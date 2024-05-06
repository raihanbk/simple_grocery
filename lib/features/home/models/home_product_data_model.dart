class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final String img;
  final num price;
  final String? oldPrice;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.img,
      required this.price,
      this.oldPrice,
      });

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      oldPrice: map['oldPrice'],
      description: map['description'],
      img: map['img'],
    );
  }
}
