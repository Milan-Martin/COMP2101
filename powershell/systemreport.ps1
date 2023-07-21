function systemreport {
	Param(
   		[Parameter(Position=1)][switch]$System,
		[Parameter(Position=2)][switch]$Disks,
		[Parameter(Position=3)][switch]$Network

	)

	if ( !($System) -and !($Disks) -and !($Network)) {
      		Get-SystemHardware
      		Get-OperatingSystem
      		Get-Processor
      		Get-RAM
      		Get-PhysicalDiskDrive
      		Get-NetworkAdapter
      		Get-VideoCard
   	}

   	elseif ($System) {
      		Get-SystemHardware
      		Get-OperatingSystem
      		Get-Processor
      		Get-RAM
      		Get-VideoCard
  	}

   	elseif ($Disks) {
      		Get-PhysicalDiskDrive
   	}

   	elseif ($Network) {
      		Get-NetworkAdapter
   	}

}