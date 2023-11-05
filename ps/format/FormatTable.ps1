# Format-Table 出力の改善(AutoSize,Wrap)
Get-Service -Name win* | Format-Table -Property Name,Status,StartType,DisplayName,DependentServices -Wrap


# Name                 Status StartType DisplayName                               DependentServices
# ----                 ------ --------- -----------                               -----------------
# WinDefend           Stopped    Manual Microsoft Defender Antivirus Service      {}
# WinHttpAutoProxySvc Running    Manual WinHTTP Web Proxy Auto-Discovery Service  {NcaSvc, jhi_service, iphlpsvc}
# Winmgmt             Running Automatic Windows Management Instrumentation        {VMUSBArbService, VMAuthdService, TPHKLOAD, Leno
#                                                                                 voVantageService}
# WinRM               Stopped    Manual Windows Remote Management (WS-Management) {}