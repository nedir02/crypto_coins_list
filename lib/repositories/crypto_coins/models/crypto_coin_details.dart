import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_details.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail({
    required this.priceInUSD,
    required this.imageUrl,
    required this.hight24Hour,
    required this.low24Hours,
  });

  @HiveField(0)
  @JsonKey(name: "PRICE")
  final double priceInUSD;

  @HiveField(1)
  @JsonKey(name: "IMAGEURL")
  final String imageUrl;

  String get fullImageUrl => 'https://www.cryptocompare.com/$imageUrl';

  @HiveField(2)
  @JsonKey(name: "HIGH24HOUR")
  final double hight24Hour;

  @HiveField(3)
  @JsonKey(name: "LOW24HOUR")
  final double low24Hours;

  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  @override
  List<Object?> get props => [priceInUSD, imageUrl, hight24Hour, low24Hours];
}
