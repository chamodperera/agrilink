class Offer {
  final String uid;
  final String name;
  final String category;
  final String avatar;
  final String rating;
  final String location;
  final String title;
  final String subtitle;
  final String description;
  final int price;

  Offer(
      {required this.uid,
      required this.name,
      required this.category,
      required this.avatar,
      required this.rating,
      required this.location,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.price});

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
        uid: json['uid'],
        name: json['name'],
        category: json['category'],
        avatar: json['avatar'],
        rating: json['rating'],
        location: json['location'],
        title: json['title'],
        subtitle: json['subtitle'],
        description: json['description'],
        price: json['price']);
  }
}
