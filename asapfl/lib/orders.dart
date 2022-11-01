class Order {
  String foodorder;
  String location;
  String phone;

  Order(
      this.foodorder,
      this.location,
      this.phone
      );

  Map<String, dynamic> toJson() =>{
    'foodorder': foodorder,
    'location': location,
    'phone': phone,
  };
}