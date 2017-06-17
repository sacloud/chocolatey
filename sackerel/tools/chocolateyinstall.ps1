# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

$ErrorActionPreference = 'Stop';

$packageName= $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/sacloud/sackerel/releases/download/v0.0.3/sackerel_windows-386.zip'
$url64      = 'https://github.com/sacloud/sackerel/releases/download/v0.0.3/sackerel_windows-amd64.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = $url
  url64bit      = $url64
  softwareName  = 'sackerel*'
  checksum      = '0279A665D132DD1BE0BE2755FB849D94A29894C6C14C31D7CE00C28B3337BF97A0984A63CFCE612FA753DC82B162CDC7248CC3C64FE221429D6C2645A145F80C'
  checksumType  = 'sha512' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '71C75B1760127CBBB92D8C743B60D92826280FB81001F1E43B0434EDA3AD3CADE73C365743F21C51FC4A40C41A35F83389D0ED8D935DE2F8E3EF9200AB114D15'
  checksumType64= 'sha512'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs
