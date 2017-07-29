$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";
$softwareName = 'terraform-provider-sakuracloud*';
$url          = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.11.0/terraform-provider-sakuracloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.11.0/terraform-provider-sakuracloud_windows-amd64.zip';
$checkSum     = 'sha512';
$hash32       = '0903E3AEA47B8B276709084D989B4E39604DEB5019CDD721D39D38F05ED07DFDAE64103084EF3BFBD5502EB777FD8F6799DB3BE008D943BFF3ECF9EBF9350030';
$hash64       = 'E939CBD8D99078161F65EB02D9EAF7D6B4197A3A9BB7DC7660A68FA29A82C537B535B18386B94F7B3117BE9797D4ED036B79D872514B01D31F633F50E9B47D6D';

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
