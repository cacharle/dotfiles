Import-Module 'C:\Users\charl\vcpkg\scripts\posh-vcpkg'
Import-Module posh-git
Import-Module pure-pwsh

Set-PSReadlineOption -EditMode vi
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Disable pre made aliases to add my git aliases
Remove-Alias -Force -Name gp
Remove-Alias -Force -Name gl
Remove-Alias -Force -Name gc

Set-Alias v nvim

# Alias with arguments: https://stackoverflow.com/questions/4166370
# Maybe there is a better way?
Function gst   { git status $args }
Function gp    { git push $args }
Function gl    { git pull $args }
Function gc    { git commit $args }
Function gcmsg { git commit -m $args }
Function glg   { git log $args }
Function gd    { git diff $args }
Function gds   { git diff --staged $args }
Function gb    { git branch $args }
Function gco   { git checkout $args }
Function ga    { git add $args }
Function gc!   { git commit --amend $args }
Function gc!!  { git commit --amend --no-edit $args }
