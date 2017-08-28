$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = Join-Path $env:APPDATA "terraform.d/plugins/"
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

