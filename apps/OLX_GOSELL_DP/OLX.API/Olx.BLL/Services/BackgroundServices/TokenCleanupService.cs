using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Olx.BLL.Entities;
using Olx.BLL.Interfaces;
using Olx.BLL.Specifications;

namespace Olx.BLL.Services.BackgroundServices
{
    public class TokenCleanupService(IConfiguration configuration, IServiceScopeFactory serviceScopeFactory) : BackgroundService
    {
        private readonly TimeSpan _interval = TimeSpan.FromHours(int.Parse(configuration["RefreshTokenCleanupIntervalHours"]!)); 
        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            Console.WriteLine("Token cleanup service started");
            while (!stoppingToken.IsCancellationRequested)
            {
                await Task.Delay(_interval, stoppingToken);
                await CleanupExpiredTokensAsync();
            }
        }

        private async Task CleanupExpiredTokensAsync()
        {
            using var scope = serviceScopeFactory.CreateScope();
            var refreshToketRepo = scope.ServiceProvider.GetRequiredService<IRepository<RefreshToken>>();
            var expiredTokens = await refreshToketRepo.GetListBySpec(new RefreshTokenSpecs.GetExpired(true));

            if (expiredTokens.Any())
            {
                refreshToketRepo.DeleteRange(expiredTokens);
                await refreshToketRepo.SaveAsync();
                Console.WriteLine($"Removed {expiredTokens.Count()} expired tokens");
            }
        }
    }
}
