#!env powershell

Set-StrictMode -version latest
$ErrorActionPreference = "Stop"

# Clone OpenUSD repo
if (!(Test-Path -PathType Container OpenUSD)) {
    git clone https://github.com/PixarAnimationStudios/OpenUSD.git OpenUSD
}

# if there's a .vscode in there, remove it
if (Test-Path -PathType Container OpenUSD\.vscode) {
    Remove-Item -Recurse -Force OpenUSD\.vscode
}
# copy in our .vscode/settings.json (just turns on C++ Debug Logging)
New-Item -ItemType Directory OpenUSD\.vscode | Out-Null
Copy-Item $PSScriptRoot\settings.json OpenUSD\.vscode | Out-Null

# if (Test-Path -PathType Container $env:USERPROFILE/scoop/persist/vscode/data/user-data/User/workspaceStorage/ce978d2515642da29f5d1b55abe83a06) {
#     Remove-Item -Recurse -Force $env:USERPROFILE/scoop/persist/vscode/data/user-data/User/workspaceStorage/ce978d2515642da29f5d1b55abe83a06
# }

# use completely fresh vscode settings, install ms-vscode.cpptools
if (Test-Path -PathType Container vscode_userdir) {
    Remove-Item -Recurse -Force vscode_userdir
}
code OpenUSD --user-data-dir $PWD\vscode_userdir --extensions-dir $PWD\vscode_userdir\extensions --install-extension ms-vscode.cpptools
# then open it
code OpenUSD --user-data-dir $PWD\vscode_userdir --extensions-dir $PWD\vscode_userdir\extensions --new-window --goto OpenUSD\pxr\imaging\plugin\hdEmbree\renderer.cpp