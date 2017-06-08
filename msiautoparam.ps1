param(
# [Parameter(Mandatory=$True)]
# [string]
# $username,

 [Parameter(Mandatory=$True)]
 [string]
 $url

# [Parameter(Mandatory=$True)]
# [string]
# $filename
)
###########################################################################################
# Downloads and installs msi packages silently.                                           #
#Parameters are used for automated installation, uncomment variables for manual usage     #
###########################################################################################

#VARIABLES FOR MANUAL EXECUTION!
#"URL to the resource"
#$url ="http://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B03FE9563-80F9-119F-DA3D-72FBBB94BC26%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable/dl/chrome/install/googlechromestandaloneenterprise64.msi?brand=GCEA"
#"The name of the resource with file extension e.g. script.ps1, program.exe"
#"Username of the account used during installation"
#$username = Read-Host

$PathtoFile = "C:\Resources"
$number = 1
if (-not (Test-Path "C:\Resources" -PathType Container))
{
    New-Item "C:\Resources" -itemType directory
}

#if (-not (Test-Path "C:\Users\$username\Resources" -PathType Container))
#{
#    New-Item "C:\Users\$username\Resources" -itemType directory
#}

$filename = "msiinstaller$number.msi"
$output = "$PathtoFile\$filename"
$test = Test-Path "$output"
while ($test -eq $true){
    $number = $number+1
    $filename = "msiinstaller$number.msi"
    $output = "$PathtoFile\$filename"
    $test = Test-Path "$output"
}
Invoke-WebRequest -Uri $url -Outfile $output

msiexec /i $output /quiet /qn /norestart
