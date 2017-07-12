$packName = 'terraform-provider-sakuracloud';
$zipX32   = 'terraform-provider-sakuracloud_windows-386.zip';
$zipX64   = 'terraform-provider-sakuracloud_windows-amd64.zip';

$typename = "System.Management.Automation.Host.ChoiceDescription";
$yes = New-Object $typename("&Yes", "実行する");
$no = New-Object $typename("&No", "実行しない");
$assembly= $yes.getType().AssemblyQualifiedName;
$choice = new-object "System.Collections.ObjectModel.Collection``1[[$assembly]]";
$choice.add($yes);
$choice.add($no);

function FileHashCheck {
    $answer = $host.UI.PromptForChoice("<事前確認>", "このps1ファイルと同じディレクトリ内に32bitと64bitのzipファイルを置きましたか？", $choice, 0);
    if ($answer -eq 0) {
        Write-Host '-----------------------------------------------------';
        Write-Host '<32bit>';
        Get-FileHash $zipX32 -Algorithm SHA512 | Format-List;
        Write-Host '<64bit>';
        Get-FileHash $zipX64 -Algorithm SHA512 | Format-List;
        Write-Host '-----------------------------------------------------';
    }
}

function CreatePackage {
    cpack;
}

function TestInstall {
    choco install $packName -s .\ -f;
}

function TestUninstall {
    cuninst $packName;
}

$answer = $host.UI.PromptForChoice("<Check FileHash>", "zipファイルのハッシュ値の確認しますか？", $choice, 0);
if ($answer -eq 0) {
    FileHashCheck;
}
$answer = $host.UI.PromptForChoice("<Make Package>", "Packageを生成しますか？", $choice, 0);
if ($answer -eq 0) {
    CreatePackage;
}
$answer = $host.UI.PromptForChoice("<Install Test>", "インストールの確認しますか？", $choice, 0);
if ($answer -eq 0) {
    TestInstall;
}
$answer = $host.UI.PromptForChoice("<Uninstall Test>", "アンインストールの確認しますか？", $choice, 0);
if ($answer -eq 0) {
    TestUninstall;
}
