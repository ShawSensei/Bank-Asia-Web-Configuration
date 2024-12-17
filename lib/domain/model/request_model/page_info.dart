class PageInfo {
  final String? pageName;
  final String? pageRoute;

  PageInfo({ this.pageName,  this.pageRoute});

  Map<String, dynamic> toJson() {
    return {
      'PageName': pageName,
      'PageRoute': pageRoute,
    };
  }
}
