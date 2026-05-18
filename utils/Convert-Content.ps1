. "$PSScriptRoot\Get-DVDMap.ps1"
. "$PSScriptRoot\Get-Current-TitleAndChapter.ps1"

function Convert-Content {
    param(
        [Parameter(Mandatory=$true)][System.Collections.Generic.List[Content]]$contents,
        [Parameter(Mandatory=$true)][string]$category,
        [Parameter(Mandatory=$true)][string]$iso_file_path,
        [Parameter(Mandatory=$true)][array]$DVDMap
    )

    
    for ($s=0; $s-lt $contents.Count; $s++) {

        $content_dir = ""
        $content = $contents[$s]
                
        if ($contents[$s].season_id -eq "NULL") {
            $content_dir = Join-Path -Path $env:UPLOAD_DIR -ChildPath "movies\$category\$($content.project_name)\scenes\"

        } else {
            $content_dir = Join-Path -Path $env:UPLOAD_DIR -ChildPath "series\$category\$($content.project_name)\seasons\$($content.season_id)\"
        }

        
        Test-Or-Create-Dir $content_dir
        
        $video_export = Join-Path -Path $content_dir -ChildPath "$($content.file_name).mp4"

        $current_index = $s+1
        $current_position = Get-Current-TitleAndChapter -current_index $current_index -DVDMap $DVDMap

        if ($null -ne $current_position) {
            & $env:HANDBRAKE -i "$iso_file_path" -o "$video_export" -t $current_position.title -c $current_position.chapters --preset="Fast 720p30" --comb-detect --decomb
        } else {
            Write-Host "Caso index [$caso] -> FUERA DE RANGO" -ForegroundColor Red
        }

    }
}