using System.Net;
using System.Net.Mail;
using DbContexts.DataModels;
using Dtos.Constants;
using Microsoft.Extensions.Configuration;

namespace Services.MailService;

public class MailService(IConfiguration configuration) : IMailService
{
    private readonly IConfiguration _configuration = configuration;

    public async Task NewUser(User user)
    {
        string templatePath = Path.Combine(Directory.GetCurrentDirectory(), "EmailTemplate/NewUser.html");
        string bodyHtml = File.ReadAllText(templatePath);
        bodyHtml = bodyHtml.Replace("UserName", $"{user.FirstName} {user.LastName}");
        bodyHtml = bodyHtml.Replace("EmailLink", user.VerificationToken);
        MailMessage mailMessage = new()
        {
            From = new MailAddress(_configuration["EmailCredentials:UserName"] ?? ""),
            Body = bodyHtml,
            IsBodyHtml = true,
            Subject = ConstantValue.NewUserEmailSubject,
        };
        mailMessage.To.Add(new MailAddress(user.Email));
        await SendMail(mailMessage);
    }

    private async Task SendMail(MailMessage mailMessage)
    {
        SmtpClient smtpClient = new(ConstantValue.EmailHost, 587)
        {
            Credentials = new NetworkCredential(
            userName: _configuration["EmailCredentials:UserName"],
            password: _configuration["EmailCredentials:Password"]),
        };
        await smtpClient.SendMailAsync(mailMessage);
    }
}