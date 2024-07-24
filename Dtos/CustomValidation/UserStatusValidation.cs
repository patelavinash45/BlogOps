using System.ComponentModel.DataAnnotations;
using DbContexts.Enums;

namespace Dtos.CustomValidation;

public class UserStatusValidation : ValidationAttribute
{
    public override bool IsValid(object? value)
    {
        if (value is UserStatus status)
        {
            if (status == UserStatus.All || (int)status > 2)
            {
                return false;
            }
        }
        return true;
    }
}