function Load-Env {
    param([string]$path = ".env")

    if(Test-Path $path) {
        Get-Content $path | ForEach-Object {
            if ($_ -notmatch '^\s*#' -and $_ -match '=') {
                $name, $value = $_.Split('=', 2)
                $name = $name.Trim()
                $value = $value.Trim()

                [System.Environment]::SetEnvironmentVariable($name, $value)
            }
            Write-Host "Archivo .env cargado correctamente." -ForegroundColor Cyan
        }
    } else {
        Write-Warning "No se encontró el archivo .env en $path"
    }

} 