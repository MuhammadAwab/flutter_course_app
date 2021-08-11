class Articles{
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Articles({
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
  });
  factory Articles.fromJson(Map < String, dynamic > json) {
    return Articles(
        author: json['author'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        url : json['url'] as String,
        urlToImage : json['urlToImage'] as String,
        publishedAt: json['publishedAt'] as String,
        content: json['content'] as String
    );
  }
}
