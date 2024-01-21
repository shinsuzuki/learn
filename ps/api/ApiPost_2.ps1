# jsonデータ作成
$data = @{
    name="sato"
    old="20"
    city="tokyo"
};

$jsonData = $data | ConvertTo-Json

# postデータ送信
$uri = "https://pie.dev/post"
#$headers = ""
$body = $jsonData
Invoke-RestMethod -Method Post -Uri $uri -Headers $headers -ContentType "application/json" -Body $body | ConvertTo-Json

# PS C:\...\api>.\ApiPost_2.ps1
# {
#   "args": {},
#   "data": "{\r\n    \"old\":  \"20\",\r\n    \"name\":  \"sato\",\r\n    \"city\":  \"tokyo\"\r\n}",
#   "files": {},
#   "form": {},
#   "headers": {
#     "Accept-Encoding": "gzip",
#     "Cdn-Loop": "cloudflare",
#     "Cf-Connecting-Ip": "60.126.96.149",
#     "Cf-Ipcountry": "JP",
#     "Cf-Ray": "848e0cc4ac3e7379-FRA",
#     "Cf-Visitor": "{\"scheme\":\"https\"}",
#     "Connection": "Keep-Alive",
#     "Content-Length": "67",
#     "Content-Type": "application/json",
#     "Host": "pie.dev",
#     "User-Agent": "Mozilla/5.0 (Windows NT; Windows NT 10.0; ja-JP) WindowsPowerShell/5.1.22621.2506"
#   },
#   "json": {
#     "city": "tokyo",
#     "name": "sato",
#     "old": "20"
#   },
#   "origin": "60.126.96.149",
#   "url": "https://pie.dev/post"
# }
