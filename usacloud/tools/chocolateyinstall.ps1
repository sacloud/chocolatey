$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";
$softwareName = 'usacloud*';
$url32        = 'https://github.com/sacloud/usacloud/releases/download/v0.3.0/usacloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/usacloud/releases/download/v0.3.0/usacloud_windows-amd64.zip';
$hashType     = 'sha512';
$hash32       = '944B152B08133B66118C0BD84B15DEF52D10C80CEEE80ECC661F15CD073D5849B530CEF5EB0B08222545D33BD46AAED1F1F15D228D795E3CE6F598A624DEDFF3';
$hash64       = 'C21F3F1B039B4BA538737000E2B59B7C5DE6D5FBBD0E1B73A239E7ED7670E9B3E0A6BFFD4F14778FFFAA73B403EF93362AA3A80E8274753B0776E1CA2D0F9163';

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
