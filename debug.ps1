$modinfo = (Get-Content "modinfo.json" -Raw) | ConvertFrom-Json
$modname = $modinfo.name -replace '\s',''
$version = $modinfo.version
$zipname = "$modname.$version.zip"
$vsBinPath = "c:\VintageStory\1.19"
$vsDataPath = "C:\VintageStory\1.19Data"

$location = Get-Location

# Preparing mod archive
New-Item -ItemType Directory -Force -Path mods
Remove-Item mods\*.zip
# DO NOT USE the Compress-Archive for creating the package - it produces linux incompatible zip archives!!! (unless you have powershell v6.2.1 or above, where it's fixed)
# Rather use the 7zip, which is okay.
& "C:\Program Files\7-Zip\7z.exe" a -tzip mods\$zipname "modinfo.json" "modicon.png" "assets\" -aoa

# Running Vintage Story Server
$arguments = "--openWorld=`"test$modname`" -pcreativebuilding --addModPath=`"$location\mods`" --dataPath $vsDataPath --tracelog"
Start-Process -FilePath "$vsBinPath\Vintagestory.exe" -WorkingDirectory $vsBinPath -ArgumentList $arguments

# Running Vintage Story Client
# $title    = 'Client'
# $question = 'Run Vintage Story client?'
# $choices  = '&Yes', '&No'
# $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
# if ($decision -eq 0) {
#     $arguments = "--addModPath=`"$location\mods`" --dataPath $vsDataPath"
#     Start-Process -FilePath "$vsBinPath\Vintagestory.exe" -WorkingDirectory $vsBinPath -ArgumentList $arguments
# }