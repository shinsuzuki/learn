# jsonオブジェクトからプロパティにアクセス
$uri = "https://httpie.io/hello"
$json = Invoke-RestMethod -Method Get -Uri $uri
Write-Host $json.links.homepage


