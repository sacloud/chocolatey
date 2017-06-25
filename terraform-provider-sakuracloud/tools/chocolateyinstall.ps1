# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

$ErrorActionPreference = 'Stop';

$packageName= $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.10.2/terraform-provider-sakuracloud_windows-386.zip'
$url64      = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.10.2/terraform-provider-sakuracloud_windows-amd64.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = $url
  url64bit      = $url64
  softwareName  = 'terraform-provider-sakuracloud*'
  checksum      = 'BCE4F85551EFE12E5A8A6C0F381BF4A031B29A6EB80FFA9C4755A88532733C5C648020F76B9FAAFD1F60ABCA1F01BD375D4DD299E8BEB2F27AC9DEBBAC8945B1'
  checksumType  = 'sha512' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '44C78854AC41DD21D2A3C63F5CF782844577EFF4C424CCA85215FFF5E82E2E502DEFFFF1FB72D0DE1D4FB5BDD10D320372910B83EA31CE50861CBEF41B74A53A'
  checksumType64= 'sha512'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs

# Check .terraformrc file
$terraformrcPath = Join-Path $env:APPDATA 'terraform.rc';
$terraformrcBackupPath = Join-Path $env:APPDATA 'terraform.rc.backup';
Write-Host "Path: " -join $terraformrcPath;
Write-Host "Backup: " -join $terraformrcBackupPath;

if (-not (Test-Path -Path $terraformrcPath)) {
  New-Item -Path $terraformrcPath -ItemType File;
} else {
  Copy-Item $terraformrcPath $terraformrcBackupPath -Force;
}

$terraformrcTagStart = 'providers {';
$terraformrcValue = 'sakuracloud = "terraform-provider-sakuracloud"';
$terraformrcTagEnd = '}';
$terraformrcTagHit = $false;
$terraformrcValueHit = $false;
$terraformrcTagStartIndex = 0;
$lineIndex = 0;
$lines = Get-Content -Path $terraformrcPath -Encoding UTF8;
foreach ($line in $lines) {
  if (-not $terraformrcTagHit) {
    if ($line.IndexOf($terraformrcTagStart) -ne (-1)) {
      $terraformrcTagHit = $true;
      $terraformrcTagStartIndex = $lineIndex;
    }
  } else {
    if ($line.IndexOf($terraformrcValue) -ne (-1)) {
      $terraformrcValueHit = $true;
    } elseif ($line.IndexOf($terraformrcTagEnd) -ne (-1)) {
      break;
    }
  }
  $lineIndex++;
}
if (-not $terraformrcTagHit) {
  Write-Host 'Write file (tag and value)';
  $txt = New-Object System.Text.StringBuilder;
  [void]$txt.AppendLine($terraformrcTagStart);
  [void]$txt.Append('  ');
  [void]$txt.AppendLine($terraformrcValue);
  [void]$txt.AppendLine($terraformrcTagEnd);
  foreach ($line in $lines) {
    [void]$txt.AppendLine($line);
  }
  Write-Host 'Export'
  Write-Host $txt.ToString();
  $txt.ToString() `
    | % { [Text.Encoding]::UTF8.GetBytes($_) } `
    | Set-Content -Path $terraformrcPath -Encoding Byte
} elseif (-not $terraformrcValueHit) {
  Write-Host 'Write file (value)';
  $txt = New-Object System.Text.StringBuilder;
  $i = 0;
  foreach ($line in $lines) {
    [void]$txt.AppendLine($line);
    if ($i -eq $terraformrcTagStartIndex) {
      [void]$txt.Append('  ');
      [void]$txt.AppendLine($terraformrcValue);
    }
    $i = $i + 1;
  }
  Write-Host 'Export'
  Write-Host $txt.ToString();
  $txt.ToString() `
    | % { [Text.Encoding]::UTF8.GetBytes($_) } `
    | Set-Content -Path $terraformrcPath -Encoding Byte
} else {
  Write-Host 'Not Working';
}
