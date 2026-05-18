. "$env:GENERAL_DIR\utils\Get-Current-TitleAndChapter.ps1"

$DVDMap = @(
    [DVDPosition]::new(1, 4), # Título 1 tiene 4 capítulos
    [DVDPosition]::new(2, 6), # Título 2 tiene 6 capítulos
    [DVDPosition]::new(3, 3)  # Título 3 tiene 3 capítulos
    )
$casos = @(1, 4, 5, 10, 11, 14)

foreach ($caso in $casos) {
    $position = Get-Current-TitleAndChapter -current_index $caso -DVDMap $DVDMap
    
    if ($null -ne $position) {
        Write-Host "Caso index [$caso] -> Titulo: $($position.title), Capitulo: $($position.chapters)" -ForegroundColor Green
    } else {
        Write-Host "Caso index [$caso] -> FUERA DE RANGO" -ForegroundColor Red
    }
}
