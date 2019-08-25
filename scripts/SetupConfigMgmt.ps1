Write-Host "Installing Chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

If (-NOT $?) {
    Write-Host "Failed to install Chocolatey"
    exit 801
}

Write-Host "Chocolatey installed successfully"

Write-Host "Installing VMware Tools"
choco install -y vmware-tools
$last = $LASTEXITCODE
If (-NOT $?) {
    # Ignore reboot required exit code.
    If (-NOT $last -eq 3010) {
        Write-Host "Failed to install VMware Tools"
        exit 802
    }
}

Write-Host "VMware Tools installed successfully"

exit 0