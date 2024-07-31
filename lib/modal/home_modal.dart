

class ApiModal
{
  late List<Hits> hits;

  ApiModal({required this.hits});
  factory ApiModal.fromJson(Map m1)
  {
    return ApiModal(hits: (m1['hits'] as List).map((e) => Hits.fromJson(e),).toList());
  }
}
class Hits{
  late String largeImageURL,userImageURL,user;
  late int id,likes,views;

  Hits({required this.largeImageURL,required this.id,required this.likes,required this.views,required this.user,required this.userImageURL});
  factory Hits.fromJson(Map m1)
  {
    return Hits(largeImageURL: m1['largeImageURL'], id: m1['id'], likes: m1['likes'], views: m1['views'],user: m1['user'],userImageURL: m1['userImageURL']);
  }
}