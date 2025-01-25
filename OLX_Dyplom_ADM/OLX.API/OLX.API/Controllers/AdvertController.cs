
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Olx.BLL.Helpers;
using Olx.BLL.Interfaces;
using Olx.BLL.Models.Advert;


namespace OLX.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdvertController(IAdvertService advertService) : ControllerBase
    {
        [HttpGet("get")]
        public async Task<IActionResult> GetAll() => Ok(await advertService.GetAllAsync());

        [HttpGet("get/{id:int}")]
        public async Task<IActionResult> GetById([FromRoute] int id) => Ok(await advertService.GetByIdAsync(id));

        [Authorize(Roles = Roles.User)]
        [HttpGet("get/user")]
        public async Task<IActionResult> GetUserAdverts([FromRoute] int id) => Ok(await advertService.GetUserAdverts());

        [Authorize(Roles = Roles.Admin)]
        [HttpGet("get/user/{id:int}")]
        public async Task<IActionResult> GetByUserId([FromRoute] int id) => Ok(await advertService.GetByUserId(id));

        [HttpGet("get/images/{id:int}")]
        public async Task<IActionResult> GetImagesByUserId([FromRoute] int id) => Ok(await advertService.GetImagesAsync(id));

        [HttpPost("get/page")]
        public async Task<IActionResult> GetPage([FromBody] AdvertPageRequest advertPageRequest) => Ok(await advertService.GetPageAsync(advertPageRequest));

        [HttpPost("get/range")]
        public async Task<IActionResult> GetRange([FromBody] IEnumerable<int> ids) => Ok(await advertService.GetRangeAsync(ids));

        [Authorize(Roles = Roles.Admin)]
        [HttpPost("block")]
        public async Task<IActionResult> SetBlockedStatus([FromQuery] int advertId, bool status)
        {
            await advertService.SetBlockedStatusAsync(advertId, status);
            return Ok();
        }

        [Authorize(Roles = Roles.Admin)]
        [HttpPost("approve/{advertId:int}")]
        public async Task<IActionResult> Approve([FromRoute] int advertId)
        {
            await advertService.ApproveAsync(advertId);
            return Ok();
        }

        [Authorize(Roles = Roles.User)]
        [HttpPost("update")]
        public async Task<IActionResult> Update([FromForm] AdvertCreationModel creationModel) => Ok(await advertService.UpdateAsync(creationModel));
        
        [Authorize(Roles = Roles.User)]
        [HttpPut("create")]
        public async Task<IActionResult> Create([FromForm] AdvertCreationModel creationModel) => Ok(await advertService.CreateAsync(creationModel));
        
        [Authorize(Roles = Roles.Admin)]
        [HttpDelete("delete/{id:int}")]
        public async Task<IActionResult> Delete([FromRoute] int id)
        {
            await advertService.DeleteAsync(id);
            return Ok();
        }  
    }
}
