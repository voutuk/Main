using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Olx.BLL.Helpers;
using Olx.BLL.Interfaces;


namespace OLX.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FilterValuesController(IFilterValueService filterValueService) : ControllerBase
    {
        [HttpGet("get")]
        public async Task<IActionResult> GetAll() => Ok(await filterValueService.GetAllAsync());

        [HttpPost("range")]
        public async Task<IActionResult> GetRange([FromBody] IEnumerable<int> ids) => Ok(await filterValueService.GetDtoByIdsAsync(ids));
        
    }
}
