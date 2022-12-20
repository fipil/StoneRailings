$modinfo = (Get-Content "modinfo.json" -Raw) | ConvertFrom-Json
$modname = $modinfo.name -replace '\s',''
$version = $modinfo.version
$zipname = "$modname.$version.zip"
$vsBinPath = "c:\VintageStory\1.17"
$vsDataPath = "C:\VintageStory\1.17Data"

$location = Get-Location

# Preparing mod archive
Remove-Item mods\*.zip
Compress-Archive -Path assets,modinfo.json -DestinationPath mods\$zipname

# Running Vintage Story
$arguments = "--openWorld=`"test$modname`" -pcreativebuilding --addModPath=`"$location\mods`" --dataPath $vsDataPath --tracelog"
Start-Process -FilePath "$vsBinPath\Vintagestory.exe" -WorkingDirectory $vsBinPath -ArgumentList $arguments