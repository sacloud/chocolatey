$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";
$softwareName = 'usacloud*';
$url32        = 'https://github.com/sacloud/usacloud/releases/download/v0.2.1/usacloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/usacloud/releases/download/v0.2.1/usacloud_windows-amd64.zip';
$hashType     = 'sha512';
$hash32       = '0AA7670884847462455570A0A4AE10FDE347588E04892723997CB099D99B107445A70DE411C6EBA2C745A8EB5DEA15526222C73A0C47E384A994C478C4481362';
$hash64       = '2B8A5E0DB0C722ADD411B0DC581AD0C7F19BDFBF2E329D8CDA69C4658CFB49FCB232C2ADFACD60420BBD5FF8E82CEFC2B98747C3BEFAE0C7B983DC2AFD9865AF';

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
