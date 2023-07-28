import 'address.dart';
import 'stripe_json_model.dart';
import 'stripe_json_utils.dart';
import '../stripe_network_utils.dart';

class ShippingInformation extends StripeJsonModel {
  static const String FIELD_ADDRESS = "address";
  static const String FIELD_NAME = "name";
  static const String FIELD_PHONE = "phone";

  Address? address;
  String name;
  String phone;

  ShippingInformation({
    required this.name,
    required this.phone,
    this.address,
  });

  ShippingInformation.fromJson(Map<String, dynamic> json)
      : name = optString(json, FIELD_NAME) ?? '',
        phone = optString(json, FIELD_PHONE) ?? '',
        address = json[FIELD_ADDRESS] != null
            ? Address.fromJson(json[FIELD_ADDRESS].cast<String, dynamic>())
            : null;

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      FIELD_NAME: name,
      FIELD_PHONE: phone,
    };
    StripeJsonModel.putStripeJsonModelMapIfNotNull(map, FIELD_ADDRESS, address!);
    ///removeNullAndEmptyParams(map);
    return map;
  }
}