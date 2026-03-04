# Microsoft.PowerShell_profile.ps1
# Install location: run $PROFILE in PowerShell to find the path
# Typically: C:\Users\<you>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

# ============================================================================
# Starship Prompt (Windows config with Windows logo + blue background)
# ============================================================================
if (Get-Command starship -ErrorAction SilentlyContinue) {
    $env:STARSHIP_CONFIG = "$env:USERPROFILE\.config\starship_windows.toml"
    Invoke-Expression (&starship init powershell)
}

# ============================================================================
# Zoxide (smarter cd)
# ============================================================================
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
    Set-Alias -Name cd -Value z -Option AllScope -Force
}

# ============================================================================
# FZF Integration
# ============================================================================
# PSFzf module adds Ctrl+T and Ctrl+R bindings — only load if fzf is on PATH
if ((Get-Command fzf -ErrorAction SilentlyContinue) -and (Get-Module -ListAvailable -Name PSFzf)) {
    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}

# ============================================================================
# Useful Aliases & Functions
# ============================================================================

# bat (better cat)
if (Get-Command bat -ErrorAction SilentlyContinue) {
    function cat { bat --style=plain @args }
}

# eza (better ls)
if (Get-Command eza -ErrorAction SilentlyContinue) {
    function ls  { eza --group-directories-first @args }
    function ll  { eza -la --group-directories-first @args }
    function la  { eza -a --group-directories-first @args }
    function l   { eza -F --group-directories-first @args }
}

# ripgrep, fd, delta
if (Get-Command rg    -ErrorAction SilentlyContinue) { Set-Alias -Name grep  -Value rg    -Option AllScope -Force }
if (Get-Command rg    -ErrorAction SilentlyContinue) { function fgrep { rg -F @args } }
if (Get-Command rg    -ErrorAction SilentlyContinue) { function egrep { rg -e @args } }
if (Get-Command fd    -ErrorAction SilentlyContinue) { Set-Alias -Name find  -Value fd    -Option AllScope -Force }
if (Get-Command delta -ErrorAction SilentlyContinue) { Set-Alias -Name diff  -Value delta -Option AllScope -Force }

# Git aliases
Set-Alias -Name g -Value git
function ga  { git add @args }
function gaa { git add -A @args }
function gst { git status @args }
function gd  { git diff @args }
function gc  { git commit @args }
function gp  { git push @args }
function gpl { git pull @args }
if (Get-Command lazygit -ErrorAction SilentlyContinue) {
    Set-Alias -Name lg -Value lazygit
}

# Directory navigation
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }

# Utility
function tree { tree.com /F /A @args }

# ============================================================================
# cowsay + fortune (random quote on shell start)
# ============================================================================
if ((Get-Command fortune -ErrorAction SilentlyContinue) -and (Get-Command cowsay -ErrorAction SilentlyContinue)) {
    fortune | cowsay
}

# ============================================================================
# History Configuration (PSReadLine)
# ============================================================================
if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine
    Set-PSReadLineOption -HistoryNoDuplicates
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineKeyHandler -Key UpArrow   -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

# ============================================================================
# FZF Default Options
# ============================================================================
$env:FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
$env:FZF_CTRL_T_COMMAND  = $env:FZF_DEFAULT_COMMAND
