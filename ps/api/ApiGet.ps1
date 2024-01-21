# get
$uri = "https://httpie.io/hello"
Invoke-RestMethod -Method Get -Uri $uri | ConvertTo-Json

# 実行結果
# PS C:\...\api>.\ApiGet.ps1
# {
#   "ahoy": [
#     "Hello, World! ?? Thank you for trying out HTTPie ??",
#     "We hope this will become a friendship."
#   ],
#   "links": {
#     "homepage": "https://httpie.io",
#     "twitter": "https://twitter.com/httpie",
#     "discord": "https://httpie.io/discord",
#     "github": "https://github.com/httpie"
#   }
# }