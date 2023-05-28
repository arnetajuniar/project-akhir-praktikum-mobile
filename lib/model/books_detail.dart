class BookDetail {
  final String? status;
  final String? id;
  final String? title;
  final String? subtitle;
  final String? description;
  final String? authors;
  final String? publisher;
  final String? pages;
  final String? year;
  final String? image;
  final String? url;
  final String? download;

  BookDetail({
    this.status,
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.authors,
    this.publisher,
    this.pages,
    this.year,
    this.image,
    this.url,
    this.download,
  });

  BookDetail.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        id = json['id'] as String?,
        title = json['title'] as String?,
        subtitle = json['subtitle'] as String?,
        description = json['description'] as String?,
        authors = json['authors'] as String?,
        publisher = json['publisher'] as String?,
        pages = json['pages'] as String?,
        year = json['year'] as String?,
        image = json['image'] as String?,
        url = json['url'] as String?,
        download = json['download'] as String?;

  Map<String, dynamic> toJson() => {
        'status': status,
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'authors': authors,
        'publisher': publisher,
        'pages': pages,
        'year': year,
        'image': image,
        'url': url,
        'download': download
      };
}
