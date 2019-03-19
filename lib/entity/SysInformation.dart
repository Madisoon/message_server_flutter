class SysInformation {
  final String title;
  final String content;
  final String url;
  final int type;
  final int grade;
  final String source;
  final String site;
  final String author;
  final String time;

  bool selected = false;

  SysInformation(this.title, this.content, this.url, this.type, this.grade,
      this.source, this.site, this.author, this.time, this.selected);

  @override
  String toString() {
    return 'SysInformation{title: $title, content: $content, url: $url, type: $type, grade: $grade, source: $source, site: $site, author: $author, time: $time, selected: $selected}';
  }

}
