#  Bullet Point - 1
function Get-SystemHardware {
	write-output "********** System hardware information **********"
	get-ciminstance win32_computersystem | select-object Description | fl
}
Get-SystemHardware



# Bullet Point - 2 
function Get-OperatingSystem {
	write-output "********** Operating system information **********"
	get-ciminstance win32_operatingsystem | select-object Name,Version | fl
}
Get-OperatingSystem



# Bullet Point - 3
function Get-Processor {
	write-output "********** Processor information **********"
	get-ciminstance win32_processor | where-object MaxClockSpeed -ne $null | foreach {
 											new-object -TypeName psobject -Property @{
											"Description" = $_.Description
 											"Speed" = $_.MaxClockSpeed
 											"Number of Cores" = $_.NumberOfCores
 											"L1 CacheSize(KB)" = $_.L1CacheSize/1kb
 											"L2 CacheSize(KB)" = $_.L2CacheSize/1kb
 											"L3 CacheSize(KB)" = $_.L3CacheSize/1kb
 											}
										  } | fl  "Description", "Speed", "Number of Cores", "L1 CacheSize(KB)", "L2 CacheSize(KB)", "L3 CacheSize(KB)"
}
Get-Processor



# Bullet Point - 4
function Get-RAM {
	write-output "********** RAM information **********"
	$totalRam = 0
	get-ciminstance win32_physicalmemory | foreach {
 							new-object -TypeName psobject -Property @{
 							"Vendor" = $_.manufacturer
 							"Description" = $_.Description
 							"Size(GB)" = $_.capacity/1gb
 							"Bank" = $_.banklabel
 							"Slot" = $_.devicelocator
 							}
 							$totalRam += $_.capacity/1gb
						} | ft -AutoSize "Vendor","Description", "Size(GB)", "Bank", "Slot"
						"Total RAM : ${totalRam}GB"
}
Get-RAM



# Bullet Point - 5
function Get-PhysicalDiskDrive {
	write-output "********** Physical disk drive information **********"	
   	$diskdrives = Get-CimInstance CIM_DiskDrive | Where-Object size -gt 0
   	$tempResult = foreach($disk in $diskdrives) {
      		$partitions = $disk | Get-CimAssociatedInstance -ResultClassName CIM_diskpartition
      		foreach($partition in $partitions) {
         		$logicaldisks = $partition | Get-CimAssociatedInstance -ResultClassName CIM_logicaldisk
         		foreach($logicaldisk in $logicaldisks) {
            			New-Object -TypeName psobject -Property @{"Vendor" = $disk.Manufacturer
                                                      			"Model" = $disk.Model
                                                      			"Size(GB)" = $logicaldisk.Size / 1gb -as [int]
                                                      			"Free Space(GB)" = $logicaldisk.FreeSpace / 1gb -as [int]
                                                      			"Free disk space in %" = ( $logicaldisk.FreeSpace / $logicaldisk.Size ) * 100 -as [float]
            }
         }
      }
   }
   $tempResult | ft -AutoSize "Vendor", "Model", "Size(GB)", "Free Space(GB)", "Free disk space in %"
}
Get-PhysicalDiskDrive



# Bullet Point - 6 
function Get-NetworkAdapter {
	write-output "********** Network adapter information **********"
	get-ciminstance win32_networkadapterconfiguration | where-object {$_.ipenabled -eq "true"} | select description,index,ipaddress,ipsubnet,dnsdomain,dnsserversearchorder | ft
}
Get-NetworkAdapter



# Bullet Point - 7
function Get-VideoCard {
	write-output "********** Video card information **********"
	$videoCardInfo = get-ciminstance win32_videocontroller
	$HorizontalResolution = $videoCardInfo.CurrentHorizontalResolution
   	$VerticalResolution = $videoCardInfo.CurrentVerticalResolution
	$result = "$HorizontalResolution x $VerticalResolution"
	$finalResult = New-Object -Typename psobject -Property @{Vendor=$videoCardInfo.AdapterCompatibility
                                             			Description=$videoCardInfo.Description
                                             			"Current Screen Resolution"=$result
								} 
	$finalResult | fl "Vendor","Description","Current Screen Resolution"
}
Get-VideoCard