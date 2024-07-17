[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$currentRole = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentRole.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (!$isAdmin)
{
  Write-Host "Run that script as administrator!"
  exit 1
}

Get-ChildItem "D:\" -Recurse -Filter "*.inf" |
  ForEach-Object { 
    $result = & PNPUtil.exe /add-driver $_.FullName /install 2>&1
    if ($LASTEXITCODE -eq 0)
    {
      Write-Host "Succefully install driver: $($_.FullName)`n$result`n"
    } else
    {
      Write-Host "Driver not installed or was already installed: $($_.FullName)`n$result`n"
    }
  }
