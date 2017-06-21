# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

$ErrorActionPreference = 'Stop';

$packageName= $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/sacloud/usacloud/releases/download/v0.0.12/usacloud_windows-386.zip'
$url64      = 'https://github.com/sacloud/usacloud/releases/download/v0.0.12/usacloud_windows-amd64.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = $url
  url64bit      = $url64
  softwareName  = 'usacloud*'
  checksum      = '510588EA7466C6301F6CC38B1FACE7BEF8160D28E6E589B5A066FB2EA8F95DE49BABB2C6FE485D42F0471096DFADDB25D675E93E00E8475E680FE2834CB32F6A'
  checksumType  = 'sha512' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '309A1304E5A0654190FC13C4461CEA81143C99FCBAFB1062C5F6C574F795E9AC3C24A3F66F7EC419FF59C6927BD933B6859A5D4C9EDABA897B3EC63A2667FBB5'
  checksumType64= 'sha512'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs
