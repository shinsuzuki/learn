using System.ComponentModel.DataAnnotations;

namespace MinimalAPI.Models
{
    // ASP.NET CoreのMinimal API（最小限の API）では、
    // [StringLength]などのデータアノテーション（DataAnnotations）による
    // 自動検証（バリデーション）がデフォルトでは実行されません。
    // パッケージを入れて対応します。
    // > dotnet add package MiniValidation

    public class Product
    {
        [Required(ErrorMessage = "IDは必須")]
        public int Id { get; set; }

        [Required]
        [StringLength(10, MinimumLength = 2, ErrorMessage = "名前は2文字以上、10文字以下で入力してください")]
        public string? ProductName { get; set; }

        public override string ToString()
        {
            return $"Product ID: {Id}, Product Name: {ProductName}";
        }
    }
}
