class PageResponse {
  final String? id;
  final String? pageName;
  final String? pageRoute;

  PageResponse({
     this.id,
     this.pageName,
     this.pageRoute,
  });

  factory PageResponse.fromJson(Map<String, dynamic> json) {
    return PageResponse(
      id: json['id'] as String,
      pageName: json['PageName'] as String,
      pageRoute: json['PageRoute'] as String,
    );
  }
}
