# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'terraform-provider-sakuracloud*'
  zipFileName   = 'terraform-provider-sakuracloud_windows-386.zip'
  zipFileName64 = 'terraform-provider-sakuracloud_windows-amd64.zip'
}

$uninstalled = $false

# Only necessary if you did not unpack to package directory - see https://chocolatey.org/docs/helpers-uninstall-chocolatey-zip-package
Uninstall-ChocolateyZipPackage -PackageName $packageArgs['packageName'] -ZipFileName $packageArgs['zipFileName']
Uninstall-ChocolateyZipPackage -PackageName $packageArgs['packageName'] -ZipFileName $packageArgs['zipFileName64']
