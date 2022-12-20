$modinfo = (Get-Content "modinfo.json" -Raw) | ConvertFrom-Json
$modname = $modinfo.name -replace '\s',''
$version = $modinfo.version
$zipname = "$modname.$version.zip"
$vsBinPath = "c:\VintageStory\1.17"
$vsDataPath = "C:\VintageStory\1.17Data"

$location = Get-Location

# Preparing mod archive
New-Item -ItemType Directory -Force -Path mods
Remove-Item mods\*.zip
Compress-Archive -Path assets,modinfo.json,modicon.png -DestinationPath mods\$zipname

# Running Vintage Story Server
$arguments = "--openWorld=`"test$modname`" -pcreativebuilding --addModPath=`"$location\mods`" --dataPath $vsDataPath --tracelog"
Start-Process -FilePath "$vsBinPath\VintagestoryServer.exe" -WorkingDirectory $vsBinPath -ArgumentList $arguments

# Running Vintage Story Client
# $title    = 'Client'
# $question = 'Run Vintage Story client?'
# $choices  = '&Yes', '&No'
# $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
# if ($decision -eq 0) {
#     $arguments = "--addModPath=`"$location\mods`" --dataPath $vsDataPath"
#     Start-Process -FilePath "$vsBinPath\Vintagestory.exe" -WorkingDirectory $vsBinPath -ArgumentList $arguments
# }