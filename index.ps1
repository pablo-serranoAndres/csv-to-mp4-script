
using module ".\modules\DVDPosition.psm1"
using module ".\modules\Content.psm1"

. "$PSScriptRoot\utils\Load-Env.ps1"
. "$PSScriptRoot\utils\Convert-Content.ps1"
. "$PSScriptRoot\utils\GetFiles-ToMigrate.ps1"
. "$PSScriptRoot\utils\Test-Or-Create-Dir.ps1"
. "$PSScriptRoot\utils\GetCategoryName-FromFile.ps1"


Load-Env -path "$PSScriptRoot\.env"

$files_to_migrate = GetFiles-ToMigrate -directory $env:CSV_DIR

Test-Or-Create-Dir $env:MIGRATED_DIR

for ($f=0; $f -lt $files_to_migrate.Count; $f++) {
    $file_path = Join-Path $env:CSV_DIR $files_to_migrate[$f].Name

    $category = GetCategoryName-FromFile -fileName $files_to_migrate[$f].Name
    $data = Import-Csv -Path $file_path -Delimiter ";"

    $rows = $data.Count - 1

    $contents = [System.Collections.Generic.List[Content]]::new()
    
    for ($i=0; $i -lt $data.Count; $i++) {
        $new_content = [Content]::new($data[$i].project_name, $data[$i].og_file, $data[$i].file_name, $data[$i].season_id)
        $contents.Add($new_content)

        $is_last_row = ($i -eq $data.Count -1)
        $new_iso = $false

        if(-not $is_last_row) {
            if ($data[$i].og_file -ne $data[$i+1].og_file) {
                $new_iso = $true
            }
        }

        if ($is_last_row -or $new_iso) {
            $iso_file_path = Join-Path -Path $env:ISO_DIR -ChildPath "$category\$($contents[0].iso_file).iso" 

            $DVDMap = Get-DVDMap -iso_file_path $iso_file_path
            
            Convert-Content -contents $contents -category $category -iso_file_path $iso_file_path -DVDMap $DVDMap

            $contents.Clear()
        }
    }

    
}
