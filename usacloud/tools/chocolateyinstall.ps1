# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

$ErrorActionPreference = 'Stop';

$packageName= $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/sacloud/usacloud/releases/download/v0.0.11/usacloud_windows-386.zip'
$url64      = 'https://github.com/sacloud/usacloud/releases/download/v0.0.11/usacloud_windows-amd64.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = $url
  url64bit      = $url64
  softwareName  = 'usacloud*'
  checksum      = '9B9D051D6AD79028E365A25546F8595A5DE7C731509498359186294ABFEF6AF4F2403403BF7C3BE784486E8DD275D5CFAB11DF3CD902F85E515495FF8504C5CD'
  checksumType  = 'sha512' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '848A27F21D95607D098407E87836F2D419ED40F2067BF59C6307482D188C4760934105DB60AD022FFA0F416AF97A10316FD455E427493DE1DE5F1694298D72AE'
  checksumType64= 'sha512'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs
