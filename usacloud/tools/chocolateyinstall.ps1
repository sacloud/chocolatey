$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";
$softwareName = 'usacloud*';
$url32        = 'https://github.com/sacloud/usacloud/releases/download/v0.3.1/usacloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/usacloud/releases/download/v0.3.1/usacloud_windows-amd64.zip';
$hashType     = 'sha512';
$hash32       = 'F0B330BF3BC7B98A4588ABDAA5EA6062186B397E72EBE73D730BB3AA9000304B32F83F87C35EE1AC309FA739C05B40DA1B6DAADF392F876BE32F528EDE2560B3';
$hash64       = '80C2EC19D0A808AEBE4AA1856AE4A8A0A11D4429DAC369B2C7C39B5C628A86AFAD64583596119E479CC6C086F3EDC4592AD7419C78EA2EC389EE67E6DD90CB0F';

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
