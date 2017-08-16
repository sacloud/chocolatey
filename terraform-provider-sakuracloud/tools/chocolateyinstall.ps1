$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName;
$toolsDir     = Join-Path $env:APPDATA "terraform.d/plugins/"
$softwareName = 'terraform-provider-sakuracloud*';
$url          = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.11.0/terraform-provider-sakuracloud_windows-386.zip';
$url64        = 'https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v0.11.0/terraform-provider-sakuracloud_windows-amd64.zip';
$checkSum     = 'sha512';
$hash32       = '0903E3AEA47B8B276709084D989B4E39604DEB5019CDD721D39D38F05ED07DFDAE64103084EF3BFBD5502EB777FD8F6799DB3BE008D943BFF3ECF9EBF9350030';
$hash64       = 'E939CBD8D99078161F65EB02D9EAF7D6B4197A3A9BB7DC7660A68FA29A82C537B535B18386B94F7B3117BE9797D4ED036B79D872514B01D31F633F50E9B47D6D';

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = $url
  url64bit      = $url64
  softwareName  = $softwareName
  checksum      = $hash32
  checksumType  = $checkSum
  checksum64    = $hash64
  checksumType64= $checkSum
}

Install-ChocolateyZipPackage @packageArgs
