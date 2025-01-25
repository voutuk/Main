using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Olx.BLL.Helpers;
using Olx.BLL.Interfaces;
using Olx.BLL.Models.User;

namespace OLX.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Roles = Roles.Admin)]
    public class UserController(IUserService userService) : ControllerBase
    {
        [HttpGet("get")]
        public async Task<IActionResult> Get() => Ok(await userService.Get());

        [HttpGet("get/locked")]
        public async Task<IActionResult> GetLocked() => Ok(await userService.GetLocked());

        [HttpGet("get/admin")]
        public async Task<IActionResult> GetAdmins() => Ok(await userService.Get(true));

        [HttpGet("get/{id:int}")]
        public async Task<IActionResult> Get([FromRoute] int id) => Ok(await userService.Get(id));

        [HttpGet("get/admin/{id:int}")]
        public async Task<IActionResult> GetAdmin([FromRoute] int id) => Ok(await userService.Get(id,true));

        [HttpPost("get/admin/page")]
        public async Task<IActionResult> GetAdminsPage([FromForm] UserPageRequest pageRequest) => Ok(await userService.Get(pageRequest, true));

        [HttpPost("get/page")]
        public async Task<IActionResult> GetPage([FromForm] UserPageRequest pageRequest) => Ok(await userService.Get(pageRequest));

        [HttpPost("get/locked/page")]
        public async Task<IActionResult> GetLockedPage([FromForm] UserPageRequest pageRequest) => Ok(await userService.Get(pageRequest,isLocked:true));

    }
}
