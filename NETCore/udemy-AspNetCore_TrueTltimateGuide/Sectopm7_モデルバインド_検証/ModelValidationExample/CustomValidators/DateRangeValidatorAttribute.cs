using System.ComponentModel.DataAnnotations;

namespace ModelValidationExample.CustomValidators
{
    public class DateRangeValidatorAttribute : ValidationAttribute
    {
        private readonly string _fromDatePropertyName;

        public DateRangeValidatorAttribute(string fromDatePropertyName)
        {
            _fromDatePropertyName = fromDatePropertyName;
        }

        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            // null は未入力として成功扱い（Required 属性で必須チェックを行う）
            if (value is null)
                return ValidationResult.Success;

            // DateTime 型以外は対象外
            if (value is not DateTime date)
                return ValidationResult.Success;

            // FromDate プロパティの値を取得
            var fromDateProperty = validationContext.ObjectType.GetProperty(_fromDatePropertyName);
            if (fromDateProperty is null)
                return new ValidationResult($"{_fromDatePropertyName}プロパティが見つかりません。");

            var fromDateValue = fromDateProperty.GetValue(validationContext.ObjectInstance);
            if (fromDateValue is not DateTime fromDate)
                return new ValidationResult($"{_fromDatePropertyName}プロパティの値が不正です。");

            // date が fromDate より前の場合はエラー
            if (date < fromDate)
            {
                var message = ErrorMessage ?? $"終了日は開始日以降である必要があります。（開始日: {fromDate.ToShortDateString()}, 終了日: {date.ToShortDateString()}）";
                return new ValidationResult(message);
            }

            return ValidationResult.Success;
        }
    }
}
