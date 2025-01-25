using AutoMapper;
using FluentValidation;
using Olx.BLL.DTOs.CategoryDtos;
using Olx.BLL.Entities;
using Olx.BLL.Exceptions;
using Olx.BLL.Interfaces;
using Olx.BLL.Models.Page;
using Olx.BLL.Pagination.Filters;
using Olx.BLL.Pagination.SortData;
using Olx.BLL.Pagination;
using Olx.BLL.Resources;
using Olx.BLL.Specifications;
using System.Net;
using Olx.BLL.Models.Category;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Olx.BLL.Exstensions;
using Microsoft.EntityFrameworkCore;


namespace Olx.BLL.Services
{
    public class CategoryService(
        IRepository<Category> categoryRepository,
        IMapper mapper,
        IImageService imageService,
        IValidator<CategoryCreationModel> validator,
        IFilterService filterService,
        UserManager<OlxUser> userManager,
        IHttpContextAccessor httpContext) : ICategoryService
    {

        public async Task<IEnumerable<CategoryDto>> Get() => mapper.Map<IEnumerable<CategoryDto>>(
               await categoryRepository.GetListBySpec(new CategorySpecs.GetAll(CategoryOpt.NoTracking | CategoryOpt.Filters)));
     
        public async Task<CategoryDto> CreateAsync(CategoryCreationModel creationModel)
        {
            await userManager.UpdateUserActivityAsync(httpContext);
            validator.ValidateAndThrow(creationModel);
            var category = mapper.Map<Category>(creationModel);
            if (creationModel.ImageFile is not null)
            {
                category.Image = await imageService.SaveImageAsync(creationModel.ImageFile);
            }

            if (creationModel.FilterIds?.Any() ?? false)
            {
                var filters = await filterService.GetByIds(creationModel.FilterIds);
                category.Filters = filters.ToList();
            }
            await categoryRepository.AddAsync(category);
            await categoryRepository.SaveAsync();
            return mapper.Map<CategoryDto>(category);
        }

        public async Task RemoveAsync(int id)
        {
            await userManager.UpdateUserActivityAsync(httpContext);
            var category = await categoryRepository.GetItemBySpec(new CategorySpecs.GetById(id));
            if (category is not null)
            {
                categoryRepository.Delete(category);
                await categoryRepository.SaveAsync();
                if (category.Image is not null)
                {
                    imageService.DeleteImageIfExists(category.Image);
                }
            }
            else throw new HttpException(Errors.InvalidCategoryId, HttpStatusCode.BadRequest);
        }

        public async Task RemoveTreeAsync(int id)
        {
            await userManager.UpdateUserActivityAsync(httpContext);
            var allCategories = await categoryRepository.GetListBySpec(new CategorySpecs.GetAll());
            var category = allCategories.FirstOrDefault(x => x.Id == id) ??
                throw new HttpException(Errors.InvalidCategoryId, HttpStatusCode.BadRequest);
            List<Category> categoriesToDelete = [category];
            categoriesToDelete.AddRange(GetAllChilds(category.Id,allCategories));
            if (categoriesToDelete.Count > 0)
            {
                categoryRepository.DeleteRange(categoriesToDelete);
                await categoryRepository.SaveAsync();
                var images = categoriesToDelete.Where(x => !String.IsNullOrEmpty(x.Image)).Select(z => z.Image);
                imageService.DeleteImagesIfExists(images);
            }
        }

        public async Task<CategoryDto> EditAsync(CategoryCreationModel editModel)
        {
            await userManager.UpdateUserActivityAsync(httpContext);
            validator.ValidateAndThrow(editModel);
            var category = await categoryRepository.GetItemBySpec( new CategorySpecs.GetById(editModel.Id,CategoryOpt.Filters))
                ?? throw new HttpException(Errors.InvalidCategoryId,HttpStatusCode.BadRequest);
            mapper.Map(editModel, category);
            if (editModel.ParentId.HasValue)
            {
                var parentCategory = await categoryRepository.GetItemBySpec(new CategorySpecs.GetById(editModel.ParentId.Value))
                    ?? throw new HttpException(Errors.InvalidParentCategoryId, HttpStatusCode.BadRequest);
                category.Parent = parentCategory;
            }

            if (String.IsNullOrWhiteSpace(editModel.CurrentImage) || editModel.ImageFile is not null)
            {
                if (!String.IsNullOrWhiteSpace(category.Image))
                {
                    imageService.DeleteImageIfExists(category.Image);
                }
                category.Image = null;
            }

            if (editModel.ImageFile is not null)
            {
                category.Image = await imageService.SaveImageAsync(editModel.ImageFile);
            }
            
            if (editModel.FilterIds?.Any() ?? false)
            {
                var filters = await filterService.GetByIds(editModel.FilterIds);
                category.Filters = filters.ToList();
            }
            else category.Filters.Clear();
            await categoryRepository.SaveAsync();
            return mapper.Map<CategoryDto>(category);
        }

        public async Task<IEnumerable<CategoryDto>> GetAllTreeAsync(bool filters = true)
        {
            var categories = await categoryRepository.GetListBySpec(new CategorySpecs.GetAll(filters 
                ? CategoryOpt.NoTracking | CategoryOpt.Filters | CategoryOpt.Parent
                : CategoryOpt.NoTracking | CategoryOpt.Parent));
            return mapper.Map<IEnumerable<CategoryDto>>(BuildTree(null, categories));
        } 
                   
        public async Task<CategoryDto> GetTreeAsync(int categoryId)
        {
            var categories = await categoryRepository.GetListBySpec(new CategorySpecs.GetAll(CategoryOpt.Filters | CategoryOpt.NoTracking));
            var category = categories.FirstOrDefault(x => x.Id == categoryId)
                ?? throw new HttpException(Errors.InvalidCategoryId,HttpStatusCode.BadRequest);
            category.Childs = BuildTree(categoryId, categories).ToHashSet();
            return mapper.Map<CategoryDto>(category);
        }

        
        private IEnumerable<Category> BuildTree(int? parentId, IEnumerable<Category> categories)
        {
            return categories.AsParallel()
                .Where(c => c.ParentId == parentId)
                .Select(c =>
                {
                    c.Childs = BuildTree(c.Id, categories).ToList();
                    return c;
                });
        }

        private IEnumerable<Category> GetAllChilds(int id, IEnumerable<Category> categories)
        {
            var children = categories.Where(c => c.ParentId == id);
            return children.Concat( children.SelectMany(child => GetAllChilds(child.Id, categories)) );
        }

        public async Task<PageResponse<CategoryDto>> GetPageAsync(CategoryPageRequest pageRequest)
        {
            var query = mapper.ProjectTo<CategoryDto>(categoryRepository.GetQuery().AsNoTracking());
            var paginationBuilder = new PaginationBuilder<CategoryDto>(query);
            var filter = new CategoryFilter(pageRequest.SearchName, pageRequest.ParentName);
            var sortData = new CategorySortData(pageRequest.IsDescending, pageRequest.SortKey);
            var page = await paginationBuilder.GetPageAsync(pageRequest.Page, pageRequest.Size, filter, sortData);
            return new()
            {
                Total = page.Total,
                Items = page.Items
            };
        }
    }
}
