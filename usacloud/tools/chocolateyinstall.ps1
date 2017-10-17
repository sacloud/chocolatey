$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";
$softwareName = 'usacloud*';
$url32        = 'https://github.com/sacloud/usacloud/releases/download/v0.2.2/usacloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/usacloud/releases/download/v0.2.2/usacloud_windows-amd64.zip';
$hashType     = 'sha512';
$hash32       = '17262EC2B129FCBCC0198054AAE130EF0A40F5348266B106053B50A354CAD50314205C8949D79274EF0194EF0535B454C40D3F1F28E6D6E6D7351528D7492DB4';
$hash64       = '59CF775AA9943A85C27DAB17A2731AE05F0B08E116079326475EF751ACC3806B95CE334EBDD24B626F33A6CEFB852E787A7E211AB1E2D7E69BB0DF7E00A30FED';

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
