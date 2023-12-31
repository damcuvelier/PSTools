function Install-GitHubModule{
param($Name,$Repo)
$erroractionpreference = 'silentlycontinue'
Set-ExecutionPolicy -ExecutionPolicy bypass -force
$here = $PSScriptRoot; if(!$here){$here = (Get-Location).path}
$BranchName = $Repo.split('/')[-1]
$fldrName = "$BranchName-$Name"

if(!(test-path "$here\$Name.psm1" -ErrorAction silentlycontinue)){
Install-Module -Name InstallModuleFromGitHub -RequiredVersion 0.3
Install-ModuleFromGitHub -GitHubRepo $Repo -Branch $Name
if(test-path "$here\$Name.zip" -ErrorAction silentlycontinue){Remove-Item "$here\$Name.zip" -Force -Confirm:$false | out-null}
if(test-path "$here\$fldrName" -ErrorAction silentlycontinue){
	Copy-Item "$here\$fldrName\$Name.psm1" -Destination $here -force
	Remove-Item "$here\$fldrName" -Recurse -Force -Confirm:$false | out-null
}
}
import-module "$here\$Name.psm1" -DisableNameChecking -Force | out-null

}

