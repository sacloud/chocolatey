$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = Join-Path $env:APPDATA "terraform.d/plugins/"
$softwareName = 'terraform-provider-sakuracloud*';
$url          = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.12.0/terraform-provider-sakuracloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.12.0/terraform-provider-sakuracloud_windows-amd64.zip';
$checkSum     = 'sha512';
$hash32       = '11180BE310D27B3075B2FE0F2AE1A655F1F68E3A2FE8CFA016B0D7F60C966FFA34AF89B42A1914F45DFEC05FA25CA91FE7FD990A3F9B04404CF30A914EF82E5E';
$hash64       = 'FED47A0212A285CBC253576E00FF2B760AB1F4D76ADE4E22EC56DD301AE76C07E2172220EA77C4AE77CEBCDC1BDD99B63330D691758F480FF9787DB4F24BAB02';

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

