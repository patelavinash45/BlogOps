using DbContexts.DataModels;

namespace Services.MailService;

public interface IMailService{
    void NewUser(User user);
}