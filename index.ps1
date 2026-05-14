using module "./modules/DVDPosition.psm1"
using module "./modules/Content.psm1"

. "$PSScriptRoot/utils/Load-Env.ps1"
. "$PSScriptRoot/utils/Convert-Contents.ps1"
. "$PSScriptRoot/utils/GetFiles-ToMigrate.ps1"
. "$PSScriptRoot/utils/Test-Or-Create-Dir.ps1"
. "$PSScriptRoot/utils/GetCategoryName-FromFile.ps1"
. "$PSScriptRoot/utils/Get-DVDMap.ps1"
. "$PSScriptRoot/utils/Get-Current-TitleAndChapter.ps1"

Load-Env -path "$PSScriptRoot/.env"

$files_to_migrate = GetFiles-ToMigrate -directory $CSV_DIR

Test-Or-Create-Dir $MIGRATED_DIR

for ($f=0; $f -lt $files_to_migrate.Count; $f++) {
    $file_path = Join-Path $CSV_DIR $files_to_migrate[$f].Name

    $category = GetCategoryNameFromFile -fileName $files_to_migrate[$f].Name
    $data = Import-Csv -Path $file_path -Delimiter ";"
    $rows = $data.Count - 1

    $contents = @()
    
    for ($i=0; $i -lt $data.Count; $i++) {

        $content = [Content]::new($data[$i].project_name, $data[$i].og_file, $data[$i].file_name, $data[$i].season_id)
        $contents += $content

       
        if (($i -eq $rows) -or  ($og_file -ne $data[$i+1].og_file)) {

            if ($contents[0].season_id -eq "NULL") {
                Convert-Movie -contents $contents -category $category 

            } else {
                Convert-Serie -contents $contents -category $category 

            }
            $contents = @()
            
        }
        
    }
    # Move-item -Path $file_path -Destination "$MIGRATED_DIR"
}
