using ModelValidationExample.CustomValidators;
using System.ComponentModel.DataAnnotations;

namespace ModelValidationExample.Models
{
    public class Person : IValidatableObject
    {
        // モデルをバインドした後に検証される
        [Required(ErrorMessage = "名前は必須です。")]
        [StringLength(40, MinimumLength = 3, ErrorMessage = "名前は3文字以上40文字以下で入力してください。[{0}]")]
        [RegularExpression(@"^[a-zA-Z0-9]+$", ErrorMessage = "名前は半角英数字で入力してください。[{0}]")]
        [Display(Name = "名前")] // Display属性で表示名を指定
        public string? PresonName { get; set; }

        [Required(ErrorMessage = "メールアドレスは必須です。")]
        [EmailAddress(ErrorMessage = "メールアドレスの形式が正しくありません。")]
        public string? Email { get; set; }

        [Phone(ErrorMessage = "電話番号の形式が正しくありません。")]
        // [ValidateNever] // このプロパティは検証されない
        public string? Phone { get; set; }

        [Required(ErrorMessage = "パスワードは必須です。")]
        public string? Password { get; set; }

        [Required(ErrorMessage = "パスワードは必須です。")]
        [Compare("Password", ErrorMessage = "パスワードが一致しません。")]
        public string? ConfirmPassword { get; set; }

        [Range(0, 10000, ErrorMessage = "価格は0以上10000以下で入力してください。")]
        public double? Price { get; set; }

        [MinimumYearValidator(2000, ErrorMessage = "生年月日は2000年以降である必要があります。")]
        //[MinimumYearValidator(2000)]
        public DateTime? DateOfBirth { get; set; }

        public DateTime? FromDate { get; set; }

        [DateRangeValidator("FromDate", ErrorMessage = "終了日は開始日以降である必要があります。")]
        public DateTime? ToDate { get; set; }

        [Required(ErrorMessage = "タグは必須です。")]
        public List<string> Tags { get; set; } = new List<string>();

        public override string ToString()
        {
            // 全メンバー変数を文字列として返す
            return $"PresonName: {PresonName}, Email: {Email}, Phone: {Phone}, " +
                $"Password: {Password}, ConfirmPassword: {ConfirmPassword}, Price: {Price}";

        }

        // モデルの検証ロジック
        IEnumerable<ValidationResult> IValidatableObject.Validate(ValidationContext validationContext)
        {
            // IValidatableObject を “複合チェック専用の場所” として使う設計が最適。
            if (Password != ConfirmPassword)
            {
                yield return new ValidationResult("パスワードが一致しません。", new[] { nameof(ConfirmPassword) });
            }

            if (DateOfBirth.HasValue && DateOfBirth.Value.Year < 2000)
            {
                yield return new ValidationResult("生年月日は2000年以降である必要があります。", new[] { nameof(DateOfBirth) });
            }

            if (FromDate.HasValue && ToDate.HasValue && FromDate.Value > ToDate.Value)
            {
                yield return new ValidationResult("終了日は開始日以降である必要があります。", new[] { nameof(ToDate) });
            }
        }
    }
}
