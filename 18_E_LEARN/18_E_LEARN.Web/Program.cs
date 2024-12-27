using _18_E_LEARN.DataAccess.Data.Context;
using _18_E_LEARN.DataAccess.Data.Models.User;
using _18_E_LEARN.DataAccess.Initializer;
using _18_E_LEARN.Web.Infrastructure.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using _18_E_LEARN.Web.Infrastructure.AutoMapper;
using _18_E_LEARN.Web.Infrastructure.Repositoryes;

var builder = WebApplication.CreateBuilder(args);

// Include services
ServicesConfiguration.Config(builder.Services);

// Include Mapping
AutoMapperConfiguration.Config(builder.Services);

// Include repositories
RepositoryConfiguration.Config(builder.Services);


var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapRazorPages();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

await AppDbInitializer.Seed(app);
app.Run();
