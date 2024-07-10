class Offer {
  final String name;
  final String category;
  final String avatar;
  final String rating;
  final String location;
  final String title;
  final String subTitle;
  final String description;
  final String price;

  Offer(
      {required this.name,
      required this.category,
      required this.avatar,
      required this.rating,
      required this.location,
      required this.title,
      required this.subTitle,
      required this.description,
      required this.price});

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
        name: json['name'],
        category: json['category'],
        avatar: json['avatar'],
        rating: json['rating'],
        location: json['location'],
        title: json['title'],
        subTitle: json['subTitle'],
        description: json['description'],
        price: json['price']);
  }
}
