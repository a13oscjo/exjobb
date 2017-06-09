param(
[Parameter(Mandatory=$True)]
 [string]
 $output
 )
Import-module ActiveDirectory 
#Computers must be ON!

#Filter and get the name on the company's computers
$desktops = Get-ADComputer -Filter * | Select-Object Name
$desktops = $desktops -replace "@{name=","" 
$desktops = $desktops -replace "}",""
"" | out-file ($output)
#extract information about OS, HDD and when the latest updates was installed on the computer. Output is stored in the output variable.
foreach ($computer in $desktops)
{
        "checking computer: $computer" 
        
        $OS = Get-ADComputer -Identity $computer | Get-ADObject -Properties * | Format-Table Name,OperatingSystem,OperatingSystemVersion -Wrap –Auto
                    
        $Disks = Get-WmiObject win32_logicalDisk -ComputerName $computer | Select-Object DeviceID,Size,Freespace | Format-Table -AutoSize
        
        $LastUpdate = Get-HotFix -ComputerName $computer | sort Installedon -desc | select-object "Latest update",installedon -first 1 | Format-Table -AutoSize
        
        $Disks >> ($output)
        $OS >> ($output)
        $LastUpdate >> ($output)
        
        "Done with $computer!"
}
