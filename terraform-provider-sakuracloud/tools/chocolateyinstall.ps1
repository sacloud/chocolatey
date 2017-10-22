$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = Join-Path $env:APPDATA "terraform.d/plugins/"
$softwareName = 'terraform-provider-sakuracloud*';
$url          = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.14.0/terraform-provider-sakuracloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.14.0/terraform-provider-sakuracloud_windows-amd64.zip';
$checkSum     = 'sha512';
$hash32       = '84B24A9AF574D461106F3F1F90EDE385D45D823E193014644D504679A6C76A300AA50A300DBD56FBE853A3410887359F905C10AA7F361BFCBC43730678E88C1D';
$hash64       = '49BD58DA6FD0998B08CF7C00A143EFA131DAB721D9555FA4349CECD0F45EF482AC6B681B53BFA6EB9F46A3991962A481E4F2CF87B8B1A339C0A734F30DA1B6C4';

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

