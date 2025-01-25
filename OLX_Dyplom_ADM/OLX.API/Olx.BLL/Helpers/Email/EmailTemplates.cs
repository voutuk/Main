﻿using System.Net;



namespace Olx.BLL.Helpers.Email
{
    internal static class EmailTemplates
    {
        private static string _path = Path.Combine(Directory.GetCurrentDirectory(), "Helpers/EmailTemplates");
        public static string GetEmailConfirmationTemplate(string url,string token, int id)
        {
            var html = File.ReadAllText(Path.Combine(_path,"EmailConfirmation.html"));
            html = html.Replace("[token]",WebUtility.UrlEncode(token));
            html = html.Replace("[id]", id.ToString());
            html = html.Replace("[url]", url);
            return html;
        }
        public static string GetEmailConfirmedTemplate(string url)
        {
            var html = File.ReadAllText(Path.Combine(_path, "EmailConfirmed.html"));
            html = html.Replace("[url]", url);
            return html;
        }
        public static string GetPasswordResetTemplate(string url, string token, int id)
        {
            var html = File.ReadAllText(Path.Combine(_path, "PasswordReset.html"));
            html = html.Replace("[token]", WebUtility.UrlEncode(token));
            html = html.Replace("[id]", id.ToString());
            html = html.Replace("[url]", url);
            return html;
        }

        public static string GetAccountBlockedTemplate(string reason, string lockoutEnd)
        {
            var html = File.ReadAllText(Path.Combine(_path, "AccountBlocked.html"));
            html = html.Replace("[reason]",reason);
            html = html.Replace("[LockoutEnd]", lockoutEnd);
            return html;
        }

        public static string GetAccountUnblockedTemplate() => File.ReadAllText(Path.Combine(_path, "AccountUnblocked.html"));
        
    }
}
