class DVDPosition {
    [int]$title
    [int]$chapters

    DVDPosition([int]$title, [int]$chapters) {
        $this.title = $title
        $this.chapters = $chapters
    }

}