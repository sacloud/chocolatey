# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";
$softwareName = 'usacloud*';
$url32        = 'https://github.com/sacloud/usacloud/releases/download/v0.0.13/usacloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/usacloud/releases/download/v0.0.13/usacloud_windows-amd64.zip';
$hashType     = 'sha512';
$hash32       = 'AD7EA820490951E39AB961503A0637A1D7B3745A57D1FE58916337F6E628F41C063453469157FD1D5F2F6709250091E940AAB4D044BB5E0104EB52569419E356';
$hash64       = 'AA4A7F1C9103C6025D9C5BDE57C8475E8C7A120CDE456C7872197CBF9C3756B66D910B2C5690D89DD44327E4059ACA5AB38E7B9D813E16C1815C705716DCBA84';

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
