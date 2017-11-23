$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = Join-Path $env:APPDATA "terraform.d/plugins/"
$softwareName = 'terraform-provider-sakuracloud*';
$url          = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v1.0.0-rc6/terraform-provider-sakuracloud_0.14.0_windows-386.zip';
$url64        = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v1.0.0-rc6/terraform-provider-sakuracloud_0.14.0_windows-amd64.zip';
$checkSum     = 'sha512';
$hash32       = 'DF2FB5097F6C07C7259BE498136FEA0619EF636029F1C5A79588B135223ED7BF17A17C1560D1A08F190A3E19571D5F1BD32EAB8A7D05C2093EEE75A536E966A5';
$hash64       = 'EA2631AE88C4E41AE7A038F32B40635813AF5C0A734BFE0ACCE7D404962C3931E840E69C74AB809D52EE4983A3D203E25AB4D779AF260C339E5D252D814AC832';

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

# 1. Install Package
Install-ChocolateyZipPackage @packageArgs

# 2. Check terraform.rc file
$terraformrcPath = Join-Path $env:APPDATA "terraform.rc";
if (Test-Path -path $terraformrcPath) {
  $delFlag = $true;
  (Get-Content -Path $terraformrcPath).foreach{
    if (($_.Contains(" = ")) -and (-not ($_.Contains("sakuracloud =")))) {
      $delFlag = $false;
    }
  };
  if ($delFlag) {
    Remove-Item -Path $terraformrcPath;
  } else {
    Write-Warning -Message '';
    Write-Warning -Message '************ W A R N I N G ************';
    Write-Warning -Message '';
    Write-Warning -Message ' Because "terraform.rc" file exists and file is in use,'
    Write-Warning -Message ' automatic deletion could not be done.';
    Write-Warning -Message '';
    Write-Warning -Message ' It is confirmed that if you do not delete '
    Write-Warning -Message ' the "terraform.rc" file,'
    Write-Warning -Message ' the plugin will not work properly.';
    Write-Warning -Message '';
    Write-Warning -Message ' "Terraform-provider-sakuracloud" is installed in'
    Write-Warning -Message ' "%APPDATA%\terraform.d\plugins",'
    Write-Warning -Message ' so the "terraform.rc" file is unnecessary.';
    Write-Warning -Message '';
    Write-Warning -Message ' Check the contents of "%APPDATA%\terraform.rc"'
    Write-Warning -Message ' file and delete it!';
    Write-Warning -Message '';
    Write-Warning -Message ' Please Check GitHub Page!';
    Write-Warning -Message '';
    Write-Warning -Message ' https://github.com/sacloud/chocolatey/wiki/About-terraform.rc-file';
    Write-Warning -Message '';
    Write-Warning -Message '***************************************';
    Write-Warning -Message '';
  }
}

