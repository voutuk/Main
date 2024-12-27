using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Configuration;
using MimeKit;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.BusinessLogic.Services
{
    public class EmailService
    {
        private readonly IConfiguration _configuration;
        public EmailService(IConfiguration configuration)
        {
            _configuration = configuration; 
        }

        public async Task SendEmailAsync(string toEmail, string subject, string body)
        {
            string fromEmail = _configuration["EmailSettings:User"];
            string smtp = _configuration["EmailSettings:SMTP"];
            int port = Int32.Parse(_configuration["EmailSettings:PORT"]);
            string password = _configuration["EmailSettings:Password"];

            var email = new MimeMessage();
            email.From.Add(MailboxAddress.Parse(fromEmail));
            email.To.Add(MailboxAddress.Parse(toEmail));
            email.Subject = subject;

            var bodyBuilder = new BodyBuilder();
            bodyBuilder.HtmlBody= body;
            email.Body = bodyBuilder.ToMessageBody();

            // Send email
            using (var smtpClient = new SmtpClient())
            {
                smtpClient.Connect(smtp, port, SecureSocketOptions.SslOnConnect);
                smtpClient.Authenticate(fromEmail, password);
                await smtpClient.SendAsync(email);
                smtpClient.Disconnect(true);
            }
        }
    }
}
