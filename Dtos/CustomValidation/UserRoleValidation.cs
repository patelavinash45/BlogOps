using System.ComponentModel.DataAnnotations;
using Dtos.Enums;

namespace Dtos.CustomValidation;

public class UserRoleValidation : ValidationAttribute
{
    public override bool IsValid(object? value)
    {
        if (value is RoleEnum role)
        {
            if (role == RoleEnum.All || (int)role > 2)
            {
                return false;
            }
        }
        return true;
    }
}