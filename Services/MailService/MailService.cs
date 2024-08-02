using System.Net;
using System.Net.Mail;
using DbContexts.DataModels;
using Microsoft.Extensions.Configuration;

namespace Services.MailService;

public class MailService(IConfiguration configuration) : IMailService
{
    private readonly IConfiguration _configuration = configuration;
    private readonly SmtpClient smtpClient = new("smtp.gmail.com")
    {
        UseDefaultCredentials = false,
        DeliveryMethod = SmtpDeliveryMethod.Network,
        EnableSsl = true,
        Port = 587,
        Credentials = new NetworkCredential(
            userName: configuration["EmailCredentials:UserName"],
            password: configuration["EmailCredentials:Password"]),
    };

    public void NewUser(User user)
    {
        MailMessage mailMessage = new()
        {
            From = new MailAddress(_configuration["EmailCredentials:UserName"] ?? ""),
            Body = "Welcome",
        };
        mailMessage.To.Add(new MailAddress(user.Email));
        SendMail(mailMessage);
    }

    private void SendMail(MailMessage mailMessage)
    {
        smtpClient.Send(mailMessage);
    }
}