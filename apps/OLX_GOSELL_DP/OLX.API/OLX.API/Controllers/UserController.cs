using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Olx.BLL.Helpers;
using Olx.BLL.Interfaces;
using Olx.BLL.Models.User;

namespace OLX.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class UserController(IUserService userService) : ControllerBase
    {
        [Authorize(Roles = Roles.Admin)]
        [HttpGet("get")]
        public async Task<IActionResult> Get() => Ok(await userService.Get());

        [Authorize(Roles = Roles.Admin)]
        [HttpGet("get/locked")]
        public async Task<IActionResult> GetLocked() => Ok(await userService.GetLocked());

        [Authorize(Roles = Roles.Admin)]
        [HttpGet("get/admin")]
        public async Task<IActionResult> GetAdmins() => Ok(await userService.Get(true));

        
        [HttpGet("get/{id:int}")]
        public async Task<IActionResult> Get([FromRoute] int id) => Ok(await userService.Get(id));

        [Authorize(Roles = Roles.Admin)]
        [HttpGet("get/admin/{id:int}")]
        public async Task<IActionResult> GetAdmin([FromRoute] int id) => Ok(await userService.Get(id,true));

        [Authorize(Roles = Roles.Admin)]
        [HttpPost("get/page")]
        public async Task<IActionResult> GetPage([FromForm] UserPageRequest pageRequest) => Ok(await userService.Get(pageRequest));
    }
}
