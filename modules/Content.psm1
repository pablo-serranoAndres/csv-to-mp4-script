class Content {
    [string]$project_name
    [string]$iso_file
    # [string]$category,
    [string]$file_name
    [string]$season_id

    Content([string]$project_name, [string]$iso_file, [string]$file_name, [string]$season_id) {
        $this.project_name = $project_name
        $this.iso_file = $iso_file
        $this.file_name = $file_name
        $this.season_id = $season_id
    }
    
}