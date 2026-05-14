function Test-Or-Create-Dir {
    param(
        [Parameter(Mandatory=$true)][string]$directory
    )

    if (-not (Test-Path -Path $directory)) {
        New-Item -Path $directory -ItemType Directory -Force | Out-Null
        Write-Host "Directorio creado: $directory" -ForegroundColor Green
        }
}