﻿$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'terraform-provider-sakuracloud*'
  zipFileName   = 'terraform-provider-sakuracloud_windows-386.zip'
  zipFileName64 = 'terraform-provider-sakuracloud_windows-amd64.zip'
}

Uninstall-ChocolateyZipPackage -PackageName $packageArgs['packageName'] -ZipFileName $packageArgs['zipFileName']
Uninstall-ChocolateyZipPackage -PackageName $packageArgs['packageName'] -ZipFileName $packageArgs['zipFileName64']
