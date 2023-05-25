class AllResults {
  AllResults({required this.status, required this.copyright, required this.numresult, required this.results ,required this.media});

  String? status;
  String? copyright;
  int? numresult;
  List<Results>? results;
  List<Media>? media ;

  static AllResults fromJson(Map<String, dynamic> json) {
    return AllResults(
      status: json['status'],
      copyright: json['copyright'],
      numresult: json['numresult'],
      results: (json['results'] as List?)?.map((e) => Results.fromJson(e)).toList(),
      media: (json['media'] as List?)?.map((e) => Media.fromJson(e)).toList(),


    );
  }

  static List fromjsontomodel(List<dynamic> list) => list.isEmpty ? [] : list.map((e) => fromJson(e)).toList();
}

class Results {
  Results({
    required this.uri,
    required this.id,
    required this.assetId,
    required this.source,
    required this.puplishedDate,
    required this.abstract,
    required this.nytdsection,
    required this.section,
    required this.url,
    required this.subsection,
    required this.title,
    required this.type,
    required this.media,

  });

  String? uri;
  String? url;
  int? id;
  int? assetId;
  String? source;
  String? puplishedDate;
  String? section;
  String? subsection;
  String? nytdsection;
  String? type;
  String? title;
  String? abstract;
  List<Media> media;

  static Results fromJson(Map<String, dynamic> json) {
    return Results(
      uri: json['uri'],
      id: json['id'],
      assetId: json['assetId'],
      source: json['source'],
      puplishedDate: json['puplishedDate'],
      abstract: json['abstract'],
      nytdsection: json['nytdsection'],
      section: json['section'],
      url: json['url'],
      subsection: json['subsection'],
      title: json['title'],
      type: json['type'],
      media:  (json['media'] as List).map((e) => Media.fromJson(e)).toList(),
    );

  }

// static List fromjsontomodel(List<dynamic> list) => list.isEmpty ? [] : list.map((e) => fromJson(e)).toList();
}

class Media {
  final String type;
  final String subtype;
  final String caption;
  final String copyright;
  final int approvedForSyndication;
  final List<MediaMetadata> mediaMetadata;

  Media({
    required this.type,
    required this.subtype,
    required this.caption,
    required this.copyright,
    required this.approvedForSyndication,
    required this.mediaMetadata,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    List<dynamic> metadataList = json['media-metadata'];
    List<MediaMetadata> metadata = metadataList
        .map((element) => MediaMetadata.fromJson(element))
        .toList();

    return Media(
      type: json['type'],
      subtype: json['subtype'],
      caption: json['caption'],
      copyright: json['copyright'],
      approvedForSyndication: json['approved_for_syndication'],
      mediaMetadata: metadata,
    );
  }
}

class MediaMetadata {
  final String url;
  final String format;
  final int height;
  final int width;

  MediaMetadata({
    required this.url,
    required this.format,
    required this.height,
    required this.width,
  });

  factory MediaMetadata.fromJson(Map<String, dynamic> json) {
    return MediaMetadata(
      url: json['url'],
      format: json['format'],
      height: json['height'],
      width: json['width'],
    );
  }
}

