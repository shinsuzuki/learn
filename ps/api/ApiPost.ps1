# post
$uri = "pie.dev/post"
#$headers = ""
$body = "hello=World"

Invoke-RestMethod -Method Post -Uri $uri -Headers $headers -Body $body -ContentType 'application/x-www-form-urlencoded' | ConvertTo-Json

# PS C:\...\api>.\ApiPost.ps1
# {
#     "args":  {

#              },
#     "data":  "",
#     "files":  {

#               },
#     "form":  {
#                  "hello":  "World"
#              },
#     "headers":  {
#                     "Accept-Encoding":  "gzip",
#                     "Cdn-Loop":  "cloudflare",
#                     "Cf-Connecting-Ip":  "60.126.96.149",
#                     "Cf-Ipcountry":  "JP",
#                     "Cf-Ray":  "848de87c5b71262d-FRA",
#                     "Cf-Visitor":  "{\"scheme\":\"http\"}",
#                     "Connection":  "Keep-Alive",
#                     "Content-Length":  "11",
#                     "Content-Type":  "application/x-www-form-urlencoded",
#                     "Host":  "pie.dev",
#                     "User-Agent":  "Mozilla/5.0 (Windows NT; Windows NT 10.0; ja-JP) WindowsPowerShell/5.1.22621.2506"
#                 },
#     "json":  null,
#     "origin":  "60.126.96.149",
#     "url":  "http://pie.dev/post"
# }