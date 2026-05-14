function GetCategoryName-FromFile {
    param(
        [string]$fileName
    )

    $category_file_name = ($fileName -split '_')[0]
    $category = $category_file_name[0].ToString().ToUpper() + $category_file_name.Substring(1)

    return $category
}
