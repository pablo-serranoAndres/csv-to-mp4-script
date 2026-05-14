using module "./modules/DVDPosition.psm1"

function Get-DVDMap {
    param(
        [Parameter(Mandatory=$true)][string]$iso_file_path
        [Parameter(Mandatory=$true)][string]$handbrake
    )
    
    $scan = & $HANDBRAKE -i $iso_file_path -t 0 --scan 2>&1

    $focus_info = @()
    $DVDMap = @()
    
    $current_title = 0
    $chapters = 0

    for ($i=0; $i -lt $scan.Count; $i++) {
        if ($scan[$i] -like "*libhb:*") {
            for ($j=$i; $j -lt $scan.Count; $j++) {
                $focus_info += $scan[$j]
            }
        }
    }

    for ($i=0; $i -lt $focus_info.Count; $i++) {
        if ($focus_info[$i] -like "*chapters*") {
            $current_title ++

            for ($j=$i; $j -lt $focus_info.Count; $j++) { 
                if ($focus_info[$j] -like "*audio tracks:*") {
                    $i = $j

                    $chapters--

                    $DVDMap += [DVDPosition]::new(($current_title), ($chapters))


                    $chapters = 0; 
                    break

                } else {
                    $chapters++
                }
            }
        }
    }

    return $DVDMap

}

$iso_file_path = "K:\HandBrake\iso\Celebraciones\04_Pablo_Bautizo_Comunion.iso"
foreach ($row in Get-DVDMap -iso_file_path $iso_file_path) {
    Write-Host $row.title -ForegroundColor White -BackgroundColor Red
    Write-Host $row.chapters -ForegroundColor White -BackgroundColor Red
}

