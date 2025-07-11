class CheckoutPriceModel {
  final int? cleaningPrice;
  final int? servicesPrice;
  final int? pricePerNight;
  final int? numNights;
  final int? priceForNights;
  final num? price;
  final num? discountValue;
  final num? finalPrice;

  CheckoutPriceModel({
    this.cleaningPrice,
    this.servicesPrice,
    this.pricePerNight,
    this.numNights,
    this.priceForNights,
    this.price,
    this.discountValue,
    this.finalPrice,
  });

  factory CheckoutPriceModel.fromJson(Map<String, dynamic> json) {
    return CheckoutPriceModel(
      cleaningPrice: json['cleaning_price'] as int?,
      servicesPrice: json['services_price'] as int?,
      pricePerNight: json['price_per_night'] as int?,
      numNights: json['num_nights'] as int?,
      priceForNights: json['price_for_nights'] as int?,
      price: json['price'] as num?,
      discountValue: json['discount_value'] as num?,
      finalPrice: json['final_price'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cleaning_price': cleaningPrice,
      'services_price': servicesPrice,
      'price_per_night': pricePerNight,
      'num_nights': numNights,
      'price_for_nights': priceForNights,
      'price': price,
      'discount_value': discountValue,
      'final_price': finalPrice,
    };
  }
}
