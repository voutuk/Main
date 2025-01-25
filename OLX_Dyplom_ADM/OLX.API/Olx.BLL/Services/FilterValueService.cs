using AutoMapper;
using Olx.BLL.DTOs.FilterDtos;
using Olx.BLL.Entities.FilterEntities;
using Olx.BLL.Interfaces;
using Olx.BLL.Specifications;



namespace Olx.BLL.Services
{
    public class FilterValueService(
        IRepository<FilterValue> valueRepository,
        IMapper mapper) : IFilterValueService
    {
        
        public async Task<IEnumerable<FilterValue>> GetByIdsAsync(IEnumerable<int> ids) => 
            await valueRepository.GetListBySpec(new FilterValueSpecs.GetByIds(ids, true));

        public async Task<IEnumerable<FilterValueDto>> GetDtoByIdsAsync(IEnumerable<int> ids) =>
              mapper.Map<IEnumerable<FilterValueDto>>(await valueRepository.GetListBySpec(new FilterValueSpecs.GetByIds(ids)));

        public async Task<IEnumerable<FilterValueDto>> GetAllAsync() =>
            mapper.Map<IEnumerable<FilterValueDto>>(await valueRepository.GetListBySpec(new FilterValueSpecs.GetAll()));
    }
}
