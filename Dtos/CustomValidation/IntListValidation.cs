using System.ComponentModel.DataAnnotations;

namespace Dtos.CustomValidation;

public class IntListValidation : ValidationAttribute
{
    public override bool IsValid(object? value)
    {
        if (value is List<int> val)
        {
            foreach (int i in val ?? [])
            {
                if (i <= 0) return false;
            }
        }
        return true;
    }
}