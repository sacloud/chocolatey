$packName = 'terraform-provider-sakuracloud';
$zipX32   = 'terraform-provider-sakuracloud_windows-386.zip';
$zipX64   = 'terraform-provider-sakuracloud_windows-amd64.zip';

$typename = "System.Management.Automation.Host.ChoiceDescription";
$yes = New-Object $typename("&Yes", "���s����");
$no = New-Object $typename("&No", "���s���Ȃ�");
$assembly= $yes.getType().AssemblyQualifiedName;
$choice = new-object "System.Collections.ObjectModel.Collection``1[[$assembly]]";
$choice.add($yes);
$choice.add($no);

function FileHashCheck {
    $answer = $host.UI.PromptForChoice("<���O�m�F>", "����ps1�t�@�C���Ɠ����f�B���N�g������32bit��64bit��zip�t�@�C����u���܂������H", $choice, 0);
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

$answer = $host.UI.PromptForChoice("<Check FileHash>", "zip�t�@�C���̃n�b�V���l�̊m�F���܂����H", $choice, 0);
if ($answer -eq 0) {
    FileHashCheck;
}
$answer = $host.UI.PromptForChoice("<Make Package>", "Package�𐶐����܂����H", $choice, 0);
if ($answer -eq 0) {
    CreatePackage;
}
$answer = $host.UI.PromptForChoice("<Install Test>", "�C���X�g�[���̊m�F���܂����H", $choice, 0);
if ($answer -eq 0) {
    TestInstall;
}
$answer = $host.UI.PromptForChoice("<Uninstall Test>", "�A���C���X�g�[���̊m�F���܂����H", $choice, 0);
if ($answer -eq 0) {
    TestUninstall;
}
