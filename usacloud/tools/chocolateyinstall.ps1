$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";
$softwareName = 'usacloud*';
$url32        = 'https://github.com/sacloud/usacloud/releases/download/v0.4.0/usacloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/usacloud/releases/download/v0.4.0/usacloud_windows-amd64.zip';
$hashType     = 'sha512';
$hash32       = 'A43292E7E4AD99223FC6E311F495C1D52F98BEB5319555E737A7B61AB5EB0FC23038ABAB039E8C1ACB890A0FDAC028E0ABBAE54CA2E08625D020E87BB3216453';
$hash64       = '62258B1CD69DCF21750E202FCEBB90200DD7578C967426125F6069B68B62B824CBFE0E3C8C4C838B0A80ECF3D55CC46312B4B8851AEED9243FBCE92F5E62E007';

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
