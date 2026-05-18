using module "..\modules\DVDPosition.psm1"

function Get-Current-TitleAndChapter {
    param(
        [Parameter(Mandatory=$true)][int]$current_index,
        [Parameter(Mandatory=$true)][array]$DVDMap
    )

    $current_title = 1
    $agregate = 0


    for ($i=0; $i -lt $DVDMap.Count; $i++) {
        $chapters = $DVDMap[$i].chapters
        
        if ($current_index -eq ($agregate + $chapters)) {
            $current_chapter = $chapters
            return [DVDPosition]::new($current_title, $current_chapter) 

        } elseif ($current_index -gt $agregate + $chapters){
            $current_title++
            $agregate += $chapters
        
        } else {
            $current_chapter = $current_index -  $agregate
 
            return [DVDPosition]::new($current_title, $current_chapter)       
        }
    }
}