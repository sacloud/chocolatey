# chocolatey

## What's
sacloudで提供されているプロジェクトについて、  
chocolateyで配信するためのパッケージを作成しています。  

## Packages
- sackerel
  - https://chocolatey.org/packages/sackerel/
  - https://github.com/sacloud/sackerel
- terraform-provider-sakuracloud
  - https://chocolatey.org/packages/terraform-provider-sakuracloud/
  - https://github.com/sacloud/terraform-provider-sakuracloud
- usacloud
  - https://chocolatey.org/packages/usacloud/
  - https://github.com/sacloud/usacloud

## Folder structure

- package name .. パッケージごとのフォルダ  

  - package.nuspec .. パッケージ情報が定義されたファイル  

  - tools  

    - LICENSE.txt .. パッケージ対象のライセンス情報  

    - chocolateyinstall.ps1 .. パッケージのインストール処理  

    - chocolateyuninstall.ps1 .. パッケージのアンインストール処理  

## License
MIT

## Author
[223n(@223n)](https://github.com/223n)
