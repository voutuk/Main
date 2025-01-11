using _18_E_LEARN.DataAccess.Data.IRepository;
using _18_E_LEARN.DataAccess.Data.Models.Categories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.BusinessLogic.Services
{
    public class CategoryService
    {
        private readonly ICategoryRepository _categoryRepository;
        public CategoryService(ICategoryRepository categoryRepository)
        {
            _categoryRepository = categoryRepository;
        }

        public async Task<ServiceResponse> GetAllAsync()
        {
            List<Category> categories = await _categoryRepository.GetAllAsync();
            return new ServiceResponse
            {
                Success = true,
                Message = "All categories loaded.",
                Payload = categories
            };
        }

        public async Task<ServiceResponse> GetByIdAsync(int Id)
        {
            var result = await _categoryRepository.GetByIdAsync(Id);
            if (result == null)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "Category not found."
                };
            }

            return new ServiceResponse
            {
                Success = true,
                Message = "Category loaded.",
                Payload = result
            };
        }

        public async Task<ServiceResponse> Update(Category model)
        {
            var category = await _categoryRepository.GetByNameAsync(model.Name);
            if (category != null)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "Category exists.",
                };
            }
            _categoryRepository.Update(model);

            return new ServiceResponse
            {
                Success = true,
                Message = "Category updated.",
            };

        }
    }
}
