using System.ComponentModel.DataAnnotations;
using DbContexts.Enums;

namespace Dtos.CustomValidation;

public class BlogStatusValidation : ValidationAttribute
{
    public override bool IsValid(object? value)
    {
        if (value is BlogStatus status)
        {
            if (status == BlogStatus.All || (int)status > 6)
            {
                return false;
            }
        }
        return true;
    }
}