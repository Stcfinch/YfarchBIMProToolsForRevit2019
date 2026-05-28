param(
    [string]$Message = ""
)

$ErrorActionPreference = "Stop"

Set-Location -LiteralPath $PSScriptRoot

Write-Host ""
Write-Host "=== YfarchBIMProTools2019 public repo upload ==="
Write-Host ""

if (-not (Test-Path -LiteralPath ".git")) {
    Write-Host "ERROR: This folder is not a Git repository."
    Write-Host "Folder: $PSScriptRoot"
    exit 1
}

$remote = git remote get-url origin 2>$null
if (-not $remote) {
    Write-Host "ERROR: Git remote 'origin' is not set."
    exit 1
}

Write-Host "Remote:"
Write-Host "  $remote"
Write-Host ""

$changes = git status --porcelain

if ($changes) {
    Write-Host "Changes found. Adding public files..."
    git add .

    if ([string]::IsNullOrWhiteSpace($Message)) {
        $Message = "Update public documentation $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    }

    Write-Host ""
    Write-Host "Creating commit:"
    Write-Host "  $Message"
    git commit -m $Message
}
else {
    Write-Host "No local file changes found."
}

Write-Host ""
Write-Host "Pushing to GitHub public repository..."
git push

Write-Host ""
Write-Host "Done."
Write-Host ""
Write-Host "Installer packages should be uploaded from the GitHub Releases page:"
Write-Host "https://github.com/FusionDraw9257/YfarchBIMProTools2019/releases"

