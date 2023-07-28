import 'dart:convert';

import 'source_code_verification.dart';
import 'source_owner.dart';
import 'source_receiver.dart';
import 'source_redirect.dart';
import 'stripe_json_model.dart';
import 'stripe_json_utils.dart';
import 'stripe_payment_source.dart';
import 'stripe_source_type_model.dart';
import '../stripe_network_utils.dart';

class Source extends StripeJsonModel implements StripePaymentSource {
  static const String VALUE_SOURCE = "source";

  static const String ALIPAY = "alipay";
  static const String CARD = "card";
  static const String THREE_D_SECURE = "three_d_secure";
  static const String GIROPAY = "giropay";
  static const String SEPA_DEBIT = "sepa_debit";
  static const String IDEAL = "ideal";
  static const String SOFORT = "sofort";
  static const String BANCONTACT = "bancontact";
  static const String P24 = "p24";
  static const String EPS = "eps";
  static const String MULTIBANCO = "multibanco";
  static const String UNKNOWN = "unknown";

  static const String PENDING = "pending";
  static const String CHARGEABLE = "chargeable";
  static const String CONSUMED = "consumed";
  static const String CANCELED = "canceled";
  static const String FAILED = "failed";

  static const String REUSABLE = "reusable";
  static const String SINGLE_USE = "single_use";

  static const String REDIRECT = "redirect";
  static const String RECEIVER = "receiver";
  static const String CODE_VERIFICATION = "code_verification";
  static const String NONE = "none";

  static const String EURO = "eur";
  static const String USD = "usd";

  static const String FIELD_ID = "id";
  static const String FIELD_OBJECT = "object";
  static const String FIELD_AMOUNT = "amount";
  static const String FIELD_CLIENT_SECRET = "client_secret";
  static const String FIELD_CODE_VERIFICATION = "code_verification";
  static const String FIELD_CREATED = "created";
  static const String FIELD_CURRENCY = "currency";
  static const String FIELD_FLOW = "flow";
  static const String FIELD_LIVEMODE = "livemode";
  static const String FIELD_METADATA = "metadata";
  static const String FIELD_OWNER = "owner";
  static const String FIELD_RECEIVER = "receiver";
  static const String FIELD_REDIRECT = "redirect";
  static const String FIELD_STATUS = "status";
  static const String FIELD_TYPE = "type";
  static const String FIELD_USAGE = "usage";

  String id;
  int? amount;
  String? clientSecret;
  SourceCodeVerification? codeVerification;
  int? created;
  String? currency;
  String? typeRaw;
  String? flow;
  bool? liveMode;
  Map<String, String>? metaData;
  SourceOwner? owner;
  SourceReceiver? receiver;
  SourceRedirect? redirect;
  String? status;
  Map<String, Object>? sourceTypeData;
  StripeSourceTypeModel? sourceTypeModel;
  String? type;
  String? usage;

  Source({
    required this.id,
    this.amount,
    this.clientSecret,
    this.codeVerification,
    this.created,
    this.currency,
    this.flow,
    this.liveMode,
    this.metaData,
    this.owner,
    this.receiver,
    this.redirect,
    this.status,
    this.sourceTypeData,
    this.sourceTypeModel,
    this.type,
    this.usage,
  }) {
    type = asSourceType(typeRaw);
  }

  Source.fromJson(Map<String, dynamic> json)
      : id = optString(json, FIELD_ID) ?? '',
        amount = optInteger(json, FIELD_AMOUNT),
        clientSecret = optString(json, FIELD_CLIENT_SECRET),
        codeVerification = json[FIELD_CODE_VERIFICATION] != null
            ? SourceCodeVerification.fromJson(
            json[FIELD_CODE_VERIFICATION].cast<String, dynamic>())
            : null,
        created = optInteger(json, FIELD_CREATED),
        currency = optString(json, FIELD_CURRENCY),
        flow = asSourceFlow(optString(json, FIELD_FLOW)),
        liveMode = optBoolean(json, FIELD_LIVEMODE),
        metaData = json[FIELD_METADATA] != null
            ? json[FIELD_METADATA].cast<String, String>()
            : null,
        owner = json[FIELD_OWNER] != null
            ? SourceOwner.fromJson(json[FIELD_OWNER].cast<String, dynamic>())
            : null,
        receiver = json[FIELD_RECEIVER] != null
            ? SourceReceiver.fromJson(json[FIELD_RECEIVER].cast<String, dynamic>())
            : null,
        redirect = json[FIELD_REDIRECT] != null
            ? SourceRedirect.fromJson(json[FIELD_REDIRECT].cast<String, dynamic>())
            : null,
        status = asSourceStatus(optString(json, FIELD_STATUS)),
        typeRaw = optString(json, FIELD_TYPE),
        ///type = asSourceType(typeRaw),
        usage = asUsage(optString(json, FIELD_USAGE));

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> hashMap = {
      FIELD_ID: id,
      FIELD_AMOUNT: amount,
      FIELD_CLIENT_SECRET: clientSecret,
      FIELD_CODE_VERIFICATION: codeVerification?.toMap(),
      FIELD_CREATED: created,
      FIELD_CURRENCY: currency,
      FIELD_FLOW: flow,
      FIELD_LIVEMODE: liveMode,
      FIELD_METADATA: metaData,
      FIELD_OWNER: owner?.toMap(),
      FIELD_RECEIVER: receiver?.toMap(),
      FIELD_REDIRECT: redirect?.toMap(),
      typeRaw ?? '': sourceTypeData,
      FIELD_STATUS: status,
      FIELD_TYPE: typeRaw,
      FIELD_USAGE: usage,
    };
    ///removeNullAndEmptyParams(hashMap);
    return hashMap;
  }

  static String? asSourceStatus(String? sourceStatus) {
    switch (sourceStatus) {
      case PENDING:
        return PENDING;
      case CHARGEABLE:
        return CHARGEABLE;
      case CONSUMED:
        return CONSUMED;
      case CANCELED:
        return CANCELED;
      case FAILED:
        return FAILED;
      default:
        return null;
    }
  }

  static String? asSourceType(String? sourceType) {
    switch (sourceType) {
      case CARD:
        return CARD;
      case THREE_D_SECURE:
        return THREE_D_SECURE;
      case GIROPAY:
        return GIROPAY;
      case SEPA_DEBIT:
        return SEPA_DEBIT;
      case IDEAL:
        return IDEAL;
      case SOFORT:
        return SOFORT;
      case BANCONTACT:
        return BANCONTACT;
      case ALIPAY:
        return ALIPAY;
      case P24:
        return P24;
      case UNKNOWN:
        return UNKNOWN;
      default:
        return null;
    }
  }

  static String? asUsage(String? usage) {
    switch (usage) {
      case REUSABLE:
        return REUSABLE;
      case SINGLE_USE:
        return SINGLE_USE;
      default:
        return null;
    }
  }

  static String? asSourceFlow(String? sourceFlow) {
    switch (sourceFlow) {
      case REDIRECT:
        return REDIRECT;
      case RECEIVER:
        return RECEIVER;
      case CODE_VERIFICATION:
        return CODE_VERIFICATION;
      case NONE:
        return NONE;
      default:
        return null;
    }
  }
}