function Convert-Movie {
    param(
        [Parameter(Mandatory=$true)][array]$contents,
        [Parameter(Mandatory=$true)][string]$category
    )


    $chapter = 1;
    $title = 1; 

    for ($j=0; $j -lt $contents.Count; $j++) {
        $iso_file_path = $ISO_DIR + $category + "\" + $contents[$j].iso_file  + ".iso"
        $DVDMap = Get-DVDMap -iso_file_path $iso_file_path




        $movie_scenes_dir = $UPLOAD_DIR + "movies\" + $contents[$j].project_name + "\scenes\" 
        
        Test-Or-Create-Dir $movie_scenes_dir
        
        $video_export = $movie_scenes_dir + $contents[$j].file_name  + ".mp4"
        
        & $HANDBRAKE -i "$iso_file_path" -o "$video_export" -t $title -c $chapter --preset="HQ 720p30 Surround" 
    }

}

function Convert-Serie {
    param(
        [Parameter(Mandatory=$true)][array]$contents,
        [Parameter(Mandatory=$true)][string]$category
    )



    for ($j=0; $j -lt $contents.Count; $j++) {
        $iso_file_path = $ISO_DIR + $category + "\" + $contents[$j].iso_file  + ".iso"
        $serie_season_dir = $UPLOAD_DIR + "series\" + $contents[$j].project_name + "\seasons\" + $contents[$j].season_id + "\" 

        Test-Or-Create-Dir $serie_season_dir

        $video_export = $serie_season_dir + $contents[$j].file_name  + ".mp4"
        
        & $HANDBRAKE -i "$iso_file_path" -o "$video_export" -c ($j + 1) --preset="HQ 720p30 Surround" --comb-detect --decomb

    }
}