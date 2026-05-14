using module "./modules/DVDPosition.psm1"

function Get-Current-TitleAndChapter {
    param(
        [Parameter(Mandatory=$true)][int]$current_index,
        [Parameter(Mandatory=$true)][array]$DVDMap
    )

    $current_title = 1
    $current_chapter = 1
    $agregate = 0
    $found = $false

    foreach ($title in $DVDMap) {
        if (($current_index -gt ($agregate + $title.chapters))) {
            $agregate += $title.chapters
            $current_title++
        }
        
        if (($current_index -eq ($agregate + $title.chapters))) {
            $current_chapter = $title.chapters 
            break
        }
        
        if ($current_index -lt ($agregate + $title.chapters)) {
            for ($c=1; $c -le $title.chapters; $c++) {
                if ($current_index -eq $agregate + $c) {
                    $current_chapter = $c
                }
            }
        }
    }

    if  ($found) {
        Write-Host "title actual: $current_title" -ForegroundColor Green
        Write-Host "chapter actual: $current_chapter" -ForegroundColor Green
    
    } else {
        Write-Host "FUERA DE RANGO!" -ForegroundColor Red
    }

    return $found
}

$DVDMap = @(
    [DVDPosition]::new(1, 4),
    [DVDPosition]::new(2, 3),
    [DVDPosition]::new(3, 3)
)

Get-Current-TitleAndChapter -current_index 20 -DVDMap $DVDMap


