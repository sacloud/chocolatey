$ErrorActionPreference = 'Stop';

$packageName= $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.10.3/terraform-provider-sakuracloud_windows-386.zip'
$url64      = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.10.3/terraform-provider-sakuracloud_windows-amd64.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = $url
  url64bit      = $url64
  softwareName  = 'terraform-provider-sakuracloud*'
  checksum      = 'EC7E4E3B2FC9FEA93EA57653CAD0CBD4AC0086E067611373200EFB9C1955EF3141AE504401F18BC0399E5012D74EC9F56D98263736DE8E603B3E71EDEB3F75C2'
  checksumType  = 'sha512'
  checksum64    = '4D0F7175A268D621E5C28DA9A170161461EDD338DDA27919FAA93104565F05CF6188AD24A32FEE78CE8E048D8EA59717F5ABDB5C254386BC50FECC242AF7CB24'
  checksumType64= 'sha512'
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
