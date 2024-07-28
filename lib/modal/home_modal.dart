

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
  late String largeImageURL;
  late int id,likes;

  Hits({required this.largeImageURL,required this.id,required this.likes});
  factory Hits.fromJson(Map m1)
  {
    return Hits(largeImageURL: m1['largeImageURL'], id: m1['id'], likes: m1['likes']);
  }
}