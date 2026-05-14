function GetFiles-ToMigrate {
    param(
        [string]$directory
    )

    $files_in_to_migrate = Get-ChildItem -Path $directory
    return $files_in_to_migrate
}