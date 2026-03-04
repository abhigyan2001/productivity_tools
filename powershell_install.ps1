# powershell_install.ps1
# Run this in PowerShell (as your normal user, not Administrator unless noted)
# Usage: .\powershell_install.ps1

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Starting PowerShell Environment Setup with Starship" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# Check winget is available
# ============================================================================
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "winget is not available. Install it from the Microsoft Store (App Installer) and re-run."
}

# ============================================================================
# Install CLI tools via winget
# ============================================================================
Write-Host "Installing CLI tools via winget..." -ForegroundColor Yellow

$tools = @(
    @{ Id = "Starship.Starship";              Name = "Starship" },
    @{ Id = "junegunn.fzf";                   Name = "fzf" },
    @{ Id = "sharkdp.bat";                    Name = "bat" },
    @{ Id = "sharkdp.fd";                     Name = "fd" },
    @{ Id = "BurntSushi.ripgrep.MSVC";        Name = "ripgrep (rg)" },
    @{ Id = "eza-community.eza";              Name = "eza" },
    @{ Id = "dandavison.delta";               Name = "delta" },
    @{ Id = "jqlang.jq";                      Name = "jq" },
    @{ Id = "jesseduffield.lazygit";          Name = "lazygit" },
    @{ Id = "ajeetdsouza.zoxide";             Name = "zoxide" },
    @{ Id = "tldr-pages.tldr";               Name = "tldr" }
)

foreach ($tool in $tools) {
    Write-Host "  Installing $($tool.Name)..." -NoNewline
    winget install --id $tool.Id --source winget --silent --accept-package-agreements --accept-source-agreements
    Write-Host "  $($tool.Name) done" -ForegroundColor Green
}

# ============================================================================
# Install PSFzf module (fzf key bindings for PowerShell)
# ============================================================================
Write-Host ""
Write-Host "Installing PSFzf PowerShell module..." -ForegroundColor Yellow
if (-not (Get-Module -ListAvailable -Name PSFzf)) {
    Install-Module -Name PSFzf -Scope CurrentUser -Force
    Write-Host "  PSFzf installed" -ForegroundColor Green
} else {
    Write-Host "  PSFzf already installed" -ForegroundColor Green
}

# ============================================================================
# Copy starship.toml config
# ============================================================================
Write-Host ""
Write-Host "Setting up Starship configuration..." -ForegroundColor Yellow

$starshipConfig = "$env:USERPROFILE\.config\starship.toml"
$repoConfig = Join-Path $PSScriptRoot "starship.toml"

New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config" | Out-Null

if (Test-Path $repoConfig) {
    Copy-Item $repoConfig $starshipConfig -Force
    Write-Host "  Copied starship.toml from repo" -ForegroundColor Green
} else {
    Write-Host "  WARNING: starship.toml not found in repo - Starship will use defaults" -ForegroundColor Yellow
}

$windowsConfig = Join-Path $PSScriptRoot "starship_windows.toml"
if (Test-Path $windowsConfig) {
    Copy-Item $windowsConfig "$env:USERPROFILE\.config\starship_windows.toml" -Force
    Write-Host "  Copied starship_windows.toml from repo" -ForegroundColor Green
}

# ============================================================================
# Install PowerShell profile
# ============================================================================
Write-Host ""
Write-Host "Installing PowerShell profile..." -ForegroundColor Yellow

$profileDir = Split-Path $PROFILE -Parent
New-Item -ItemType Directory -Force -Path $profileDir | Out-Null

$repoProfile = Join-Path $PSScriptRoot "Microsoft.PowerShell_profile.ps1"

if (Test-Path $PROFILE) {
    $backup = "$PROFILE.backup"
    Copy-Item $PROFILE $backup -Force
    Write-Host "  Backed up existing profile to $backup" -ForegroundColor Green
}

Copy-Item $repoProfile $PROFILE -Force
Write-Host "  Profile installed to $PROFILE" -ForegroundColor Green

# ============================================================================
# Done
# ============================================================================
Write-Host ""
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host "Installation Complete!" -ForegroundColor Cyan
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "What was installed:"
Write-Host "   Starship (fast prompt framework)"
Write-Host "   ripgrep (rg) - fast grep alternative"
Write-Host "   fzf + PSFzf - fuzzy finder with Ctrl+T / Ctrl+R"
Write-Host "   bat - better cat with syntax highlighting"
Write-Host "   fd - fast find alternative"
Write-Host "   eza - modern ls replacement"
Write-Host "   zoxide - smarter cd with frecency"
Write-Host "   delta - beautiful git diffs"
Write-Host "   lazygit - git UI in terminal"
Write-Host "   tldr - simplified man pages"
Write-Host "   jq - JSON query tool"
Write-Host ""
Write-Host "Next steps:"
Write-Host "   1. Restart PowerShell or run: . `$PROFILE"
Write-Host "   2. Nerd Font required for icons - install from https://www.nerdfonts.com/"
Write-Host "      and set it in Windows Terminal settings"
Write-Host "   3. Try: rg --version, bat --version, eza --version"
Write-Host ""
Write-Host "Profile location: $PROFILE"
Write-Host "Starship config:  $starshipConfig"
Write-Host ""
