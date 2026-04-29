# Update-Version.ps1
# Updates the Lightspeed Filter Agent target version and pushes to GitHub
# Usage: .\Update-Version.ps1 -Version "3.2.5"

param (
    [Parameter(Mandatory)]
    [string]$Version
)

git -C $PSScriptRoot pull

$ConfigPath = Join-Path $PSScriptRoot "config.json"

if (-not (Test-Path $ConfigPath)) {
    Write-Error "config.json not found at $ConfigPath"
    exit 1
}

@{ version = $Version } | ConvertTo-Json | Set-Content -Path $ConfigPath -Encoding UTF8

git -C $PSScriptRoot add $ConfigPath
git -C $PSScriptRoot commit -m "Bump Lightspeed agent to $Version"
git -C $PSScriptRoot push

Write-Output "Done. Lightspeed Filter Agent target version is now $Version."
