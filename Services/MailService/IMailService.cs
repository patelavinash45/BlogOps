using DbContexts.DataModels;

namespace Services.MailService;

public interface IMailService{
    Task NewUser(User user);
}