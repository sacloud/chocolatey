$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";
$softwareName = 'usacloud*';
$url32        = 'https://github.com/sacloud/usacloud/releases/download/v0.5.0/usacloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/usacloud/releases/download/v0.5.0/usacloud_windows-amd64.zip';
$hashType     = 'sha512';
$hash32       = 'F2D471A614AD5C04E853B3D115DFEE8ED1528BC2CA48884165B4DB8D3BEBDD023A4143B291C580E90DCFDFB202F45A3ACCFDD0F99D4ECF4F24742A9BD94FFAC3';
$hash64       = '0FEFA79808BA543E93E67DB6D3B43FB915DCAE3D02486F85693B0AE39312353760C045BF4A3B30DDA3B77B99BB97AD0CC91B84AFA2DCD83268020A07FB5252FF';

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = $url32
  url64bit      = $url64
  softwareName  = $softwareName
  checksum      = $hash32
  checksumType  = $hashType
  checksum64    = $hash64
  checksumType64= $hashType
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs
