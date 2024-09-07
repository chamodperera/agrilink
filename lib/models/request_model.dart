class Request {
  final String uid;
  final String name;
  final String avatar;
  final String rating;
  final String location;
  final String offerTitle;
  final String offerCategory;
  final int amount;
  final int negotiatedPrice;

  Request(
      {required this.uid,
      required this.name,
      required this.avatar,
      required this.rating,
      required this.location,
      required this.offerTitle,
      required this.offerCategory,
      required this.amount,
      required this.negotiatedPrice});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        uid: json['uid'],
        name: json['name'],
        avatar: json['avatar'],
        rating: json['rating'],
        location: json['location'],
        offerTitle: json['title'],
        offerCategory: json['category'],
        amount: json['amount'],
        negotiatedPrice: json['negotiatedPrice']);
  }
}
