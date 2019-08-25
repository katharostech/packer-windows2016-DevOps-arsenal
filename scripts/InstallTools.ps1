Write-Host "Installing Git"
C:\Users\vagrant\Downloads\bin_res\Git-2.21.0-64-bit.exe /LOADINF="C:\Users\vagrant\Downloads\bin_res\gitinstallparms.ini" /SILENT | Out-Null

If (-NOT $?) {
    Write-Host "Failed to install Git"
    exit 901
}

Write-Host "Git installed successfully"

Write-Host "Installing Chef DK"
msiexec /qn /i C:\Users\vagrant\Downloads\bin_res\chef-workstation-0.2.48-1-x64.msi | Out-Null

If (-NOT $?) {
    Write-Host "Failed to install Chef DK"
    exit 902
}

Write-Host "Chef DK installed successfully"

Write-Host "Installing Packer"
Expand-Archive -LiteralPath C:\Users\vagrant\Downloads\bin_res\packer_1.3.5_windows_amd64.zip -DestinationPath C:\Packer
# Add Packer directory to the Path environment variable.
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath = "$oldpath;C:\Packer"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath

Write-Host "Packer installed successfully"

Write-Host "Installing VMware Workstation"
C:\Users\vagrant\Downloads\bin_res\VMware-workstation-full-15.0.2-10952284.exe /s /v/qn EULAS_AGREED=1 SERIALNUMBER=$Env:VMWARE_WORKSTATION_SERIAL | Out-Null

If (-NOT $?) {
    Write-Host "Failed to install VMware Workstation"
    exit 903
}

Write-Host "VMware Workstation installed successfully"

Write-Host "Installing VSCode"
C:\Users\vagrant\Downloads\bin_res\VSCodeUserSetup-x64-1.32.1.exe /VERYSILENT /MERGETASKS=!runcode | Out-Null

If (-NOT $?) {
    Write-Host "Failed to install VSCode"
    exit 904
}

Write-Host "VSCode installed successfully"

Write-Host "Installing VirtualBox"
C:\Users\vagrant\Downloads\bin_res\VirtualBox-6.0.4-128413-Win.exe --msiparams VBOX_START=0 --silent | Out-Null

If (-NOT $?) {
    Write-Host "Failed to install VirtualBox"
    exit 905
}

Write-Host "VirtualBox installed successfully"

Write-Host "Installing VBox Extensions"
Set-Location "C:\Program Files\Oracle\VirtualBox"
Write-Output "y" | ./VBoxManage.exe extpack install --replace C:\Users\vagrant\Downloads\bin_res\Oracle_VM_VirtualBox_Extension_Pack-6.0.4.vbox-extpack | Out-Null

If (-NOT $?) {
    Write-Host "Failed to install VBox Extensions"
    exit 906
}
Set-Location "C:\Users\vagrant\Downloads\bin_res"

Write-Host "VBox Extensions installed successfully"

Write-Host "Installing Visual Studio 2017"
C:\Users\vagrant\Downloads\bin_res\vs_community.exe --wait --installPath C:\myVS --passive --norestart --nocache --config "C:\Users\vagrant\Downloads\bin_res\.vsconfig" | Out-Null

If (-NOT $?) {
    Write-Host "Failed to install Visual Studio 2017"
    exit 909
}

Write-Host "Visual Studio 2017 installed successfully"

Write-Host "Installing SQL Server Data Tools"
C:\Users\vagrant\Downloads\bin_res\SSDT-Setup-ENU.exe /install /INSTALLALL /passive /norestart | Out-Null

If (-NOT $?) {
    Write-Host "Failed to install SQL Server Data Tools"
    exit 910
}

Write-Host "SQL Server Data Tools installed successfully"

Write-Host "Installing Visual Studio 2015"
choco install -y visualstudio2015professional
$last = $LASTEXITCODE
If (-NOT $?) {
    # Ignore reboot required exit code.
    If (-NOT $last -eq 3010) {
        Write-Host "Failed to install Visual Studio 2015"
        exit 911
    }
}

Write-Host "Visual Studio 2015 installed successfully"

Write-Host "Installing SQL Server Data Tools for VS 2015"
C:\Users\vagrant\Downloads\bin_res\SSDTSetup.exe INSTALLALL=1 /passive /norestart | Out-Null

If (-NOT $?) {
    Write-Host "Failed to install SQL Server Data Tools for VS 2015"
    exit 912
}

Write-Host "SQL Server Data Tools for VS 2015 installed successfully"

Write-Host "Installing IBM MQ Explorer"
Expand-Archive -LiteralPath C:\Users\vagrant\Downloads\bin_res\ms0t_mqexplorer_9100_windows_x86_64.zip -DestinationPath C:\MQExplorer
Copy-Item -Path C:\Users\vagrant\Downloads\bin_res\silent_install.resp -Destination C:\MQExplorer\ms0t_mqexplorer_9100_windows_x86_64\silent_install.resp -Force
Set-Location C:\MQExplorer\ms0t_mqexplorer_9100_windows_x86_64
.\Setup.exe -f .\silent_install.resp | Out-Null

If (-NOT $?) {
    Write-Host "Failed to install IBM MQ Explorer"
    exit 913
}

Write-Host "IBM MQ Explorer installed successfully"

exit 0