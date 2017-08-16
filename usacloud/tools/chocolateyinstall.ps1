# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";
$softwareName = 'usacloud*';
$url32        = 'https://github.com/sacloud/usacloud/releases/download/v0.1.1/usacloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/usacloud/releases/download/v0.1.1/usacloud_windows-amd64.zip';
$hashType     = 'sha512';
$hash32       = '7FFE8F94DE5BC2184C33F188BEA70B2159A6BD2A4AD4304A2044A64A47841AAD1F658E40509A49554DBFD0A13733514A2816415FD4CCE2A7DA3ACCCF793BD943';
$hash64       = 'A2036DF90A2F4136A5D81792B1AA6BBD5868F28CD13BFC5FAB0DFB74FF444625BF4B5BBA515F76C7A3575D8FD2904F9B145F05EE885BC44CDF6D9666028AA2FE';

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
