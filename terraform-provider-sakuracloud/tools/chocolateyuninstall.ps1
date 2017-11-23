$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'terraform-provider-sakuracloud*'
  zipFileName   = 'terraform-provider-sakuracloud_0.14.0_windows-386.zip'
  zipFileName64 = 'terraform-provider-sakuracloud_0.14.0_windows-amd64.zip'
}

$os = Get-WmiObject -Class Win32_OperatingSystem;
if ($os.OSarchitecture.Contains("64")) {
  Uninstall-ChocolateyZipPackage -PackageName $packageArgs['packageName'] -ZipFileName $packageArgs['zipFileName64']
} else {
  Uninstall-ChocolateyZipPackage -PackageName $packageArgs['packageName'] -ZipFileName $packageArgs['zipFileName']
}
