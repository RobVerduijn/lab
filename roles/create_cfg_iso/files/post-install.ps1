# Create Workdir
$BasePath = "C:\Windows\Temp\Install"
New-item $BasePath -itemtype directory

# Add RedHat to Trusted Publisher
$CertName = "balloon.cer"
$ExportCert = Join-Path $BasePath -ChildPath $CertName

$Cert = (Get-AuthenticodeSignature "F:\Balloon\w10\amd64\balloon.sys").SignerCertificate
$ExportType = [System.Security.Cryptography.X509Certificates.X509ContentType]::Cert

[System.IO.File]::WriteAllBytes($ExportCert, $Cert.Export($ExportType))
Import-Certificate -FilePath $ExportCert -CertStoreLocation Cert:\LocalMachine\TrustedPublisher

# install Guest Agent
msiexec /i F:\virtio-win-gt-x64.msi /qn /passive

# Get Cloud-init
Set-ExecutionPolicy Unrestricted
# stable
# $Cloudinit = "CloudbaseInitSetup_Stable_x64.msi"
# beta
$Cloudinit = "CloudbaseInitSetup_x64.msi"
$CloudinitLocation =  Join-Path -Path "C:\windows\temp\" -ChildPath $Cloudinit
invoke-webrequest https://www.cloudbase.it/downloads/$Cloudinit -o $CloudinitLocation

cmd /C start /wait msiexec /i $CloudinitLocation /qn

Copy-Item -Path "D:\cloudbase-init-unattend.conf" -Destination "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\"
Copy-Item -Path "D:\Unattend.xml" -Destination "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\"

# Run Sysprep and Shutdown
cmd /C 'cd "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\" && C:\Windows\System32\Sysprep\sysprep.exe /generalize /oobe /shutdown /unattend:Unattend.xml'