﻿namespace Olx.BLL.Models.Authentication
{
    public class AuthResponse
    {
        public string AccessToken { get; init; } = string.Empty;
        public string RefreshToken { get; init; } = string.Empty;
    }
}
