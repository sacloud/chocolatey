# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

$ErrorActionPreference = 'Stop';

# select packer command directory
$msg_en = "Please enter the folder containing the Packer command.";
$msg_jp = "Packerコマンドが含まれているフォルダを入力してください。";
$msg_split = "*************************************************************"
Write-Output $msg_split;
Write-Output $msg_en;
Write-Output "--------------";
Write-Output $msg_jp;
Write-Output $msg_split;
$readPath = Read-Host "Path: ";

if (Test-Path $readPath -PathType Container) {
  $packageName= $env:ChocolateyPackageName
  $toolsDir   = $readPath;
# $toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  $url        = 'https://github.com/sacloud/packer-builder-sakuracloud/releases/download/v0.1.1/packer-builder-sakuracloud_windows-386.zip'
  $url64      = 'https://github.com/sacloud/packer-builder-sakuracloud/releases/download/v0.1.1/packer-builder-sakuracloud_windows-amd64.zip'

  $packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url
    url64bit      = $url64
    softwareName  = 'packer-builder-sakuracloud*'
    checksum      = 'D2E6C00428918BBD4080642CCE6EAF387F9024154DCD07CEA478C8B0722F0941C9E63FEE2F1E171A04512A2487C95B9BE781561D6D425F642AA76F9F0DEC3FE1'
    checksumType  = 'sha512' #default is md5, can also be sha1, sha256 or sha512
    checksum64    = '8086C75AACD920FAE52E861CCE228B66E808DDD4BEFAFCECD48B6DE3A5BAA71647AECF791086F98918E3F45A5BD73D9A7B18F32C9EF3464DE6528CE9BA5B0AB8'
    checksumType64= 'sha512'
  }

  # https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
  Install-ChocolateyZipPackage @packageArgs

} else {
  throw "The path is incorrect or a space was entered.";
}
