# IP configuration report

get-ciminstance win32_networkadapterconfiguration | where-object {$_.ipenabled -eq "true"} | select description,index,ipaddress,ipsubnet,dnsdomain,dnsserversearchorder | ft