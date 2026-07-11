using System.ComponentModel.DataAnnotations;

namespace ModelValidationExample.CustomValidators
{
    public class MinimumYearValidatorAttribute : ValidationAttribute
    {
        private readonly int _minimumYear;

        public MinimumYearValidatorAttribute(int year)
        {
            _minimumYear = year;
        }


        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            // null は未入力として成功扱い（Required 属性で必須チェックを行う）
            if (value is null)
                return ValidationResult.Success;

            // DateTime 型以外は対象外
            if (value is not DateTime date)
                return ValidationResult.Success;

            if (date.Year < _minimumYear)
            {
                var message = ErrorMessage ?? $"年は {_minimumYear} 以上である必要があります。（現在の値: {date.Year}）";
                return new ValidationResult(message);
            }

            return ValidationResult.Success;
        }
    }
}
