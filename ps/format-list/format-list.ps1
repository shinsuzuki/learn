
# プロパティ一覧
Get-Date | Get-Member
#    TypeName: System.DateTime
# Name                 MemberType     Definition
# ----                 ----------     ----------
# Add                  Method         datetime Add(timespan value)
# AddDays              Method         datetime AddDays(double value)
# AddHours             Method         datetime AddHours(double value)
#               :
#               :


# プロパティの値
Get-Date | Format-List -Property *
# DisplayHint : DateTime
# DateTime    : 2025年3月21日 16:41:12
# Date        : 2025/03/21 0:00:00
# Day         : 21
# DayOfWeek   : Friday
# DayOfYear   : 80
# Hour        : 16
# Kind        : Local
# Millisecond : 878
# Microsecond : 297
# Nanosecond  : 300
# Minute      : 41
# Month       : 3
# Second      : 12
# Ticks       : 638781720728782973
# TimeOfDay   : 16:41:12.8782973
# Year        : 2025


Get-Date | Select-Object -Property *
# DisplayHint : DateTime
# DateTime    : 2025年3月21日 16:42:09
# Date        : 2025/03/21 0:00:00
# Day         : 21
# DayOfWeek   : Friday
# DayOfYear   : 80
# Hour        : 16
# Kind        : Local
# Millisecond : 802
# Microsecond : 864
# Nanosecond  : 200
# Minute      : 42
# Month       : 3
# Second      : 9
# Ticks       : 638781721298028642
# TimeOfDay   : 16:42:09.8028642
# Year        : 2025