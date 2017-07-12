$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";
$softwareName = 'terraform-provider-sakuracloud*';
$url          = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.10.4/terraform-provider-sakuracloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.10.4/terraform-provider-sakuracloud_windows-amd64.zip';
$checkSum     = 'sha512';
$hash32       = '949F30F2204999D3F79627B51D163ED0D60663CA9ADDE6F497D761C2F06E16F2A865C7A9AA81F9932D089D9E598B20C5F44B81F0FB7BCE9F1A778ADEAAECA66C';
$hash64       = 'B158D4B5771FB84EB3346F99FDBEB53739E3A3009909C9606BD04EB5EFBAB0B1040791AD1DEA7F27913ED14BE4BC3107E9EAC9B7C2E8BD248E19EC944C227D13';

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = $url
  url64bit      = $url64
  softwareName  = $softwareName
  checksum      = $hash32
  checksumType  = $checkSum
  checksum64    = $hash64
  checksumType64= $checkSum
}

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
