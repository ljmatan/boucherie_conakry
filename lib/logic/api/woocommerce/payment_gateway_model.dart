// To parse this JSON data, do
//
//     final paymentGateway = paymentGatewayFromJson(jsonString);

import 'dart:convert';

List<PaymentGateway> paymentGatewayFromJson(String str) =>
    List<PaymentGateway>.from(
        json.decode(str).map((x) => PaymentGateway.fromJson(x)));

String paymentGatewayToJson(List<PaymentGateway> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentGateway {
  PaymentGateway({
    this.id,
    this.title,
    this.description,
    this.order,
    this.enabled,
    this.methodTitle,
    this.methodDescription,
    this.methodSupports,
    this.settings,
    this.links,
  });

  final String id;
  final String title;
  final String description;
  final int order;
  final bool enabled;
  final String methodTitle;
  final String methodDescription;
  final List<String> methodSupports;
  final Map<String, Setting> settings;
  final Links links;

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        order: json["order"] == null ? null : json["order"],
        enabled: json["enabled"] == null ? null : json["enabled"],
        methodTitle: json["method_title"] == null ? null : json["method_title"],
        methodDescription: json["method_description"] == null
            ? null
            : json["method_description"],
        methodSupports: json["method_supports"] == null
            ? null
            : List<String>.from(json["method_supports"].map((x) => x)),
        settings: json["settings"] == null
            ? null
            : Map.from(json["settings"]).map(
                (k, v) => MapEntry<String, Setting>(k, Setting.fromJson(v))),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "order": order == null ? null : order,
        "enabled": enabled == null ? null : enabled,
        "method_title": methodTitle == null ? null : methodTitle,
        "method_description":
            methodDescription == null ? null : methodDescription,
        "method_supports": methodSupports == null
            ? null
            : List<dynamic>.from(methodSupports.map((x) => x)),
        "settings": settings == null
            ? null
            : Map.from(settings)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "_links": links == null ? null : links.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  final List<Collection> self;
  final List<Collection> collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? null
            : List<Collection>.from(
                json["self"].map((x) => Collection.fromJson(x))),
        collection: json["collection"] == null
            ? null
            : List<Collection>.from(
                json["collection"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self == null
            ? null
            : List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": collection == null
            ? null
            : List<dynamic>.from(collection.map((x) => x.toJson())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  final String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href == null ? null : href,
      };
}

class Setting {
  Setting({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.settingDefault,
    this.tip,
    this.placeholder,
    this.options,
  });

  final String id;
  final String label;
  final String description;
  final String type;
  final String value;
  final String settingDefault;
  final String tip;
  final Placeholder placeholder;
  final Options options;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        id: json["id"] == null ? null : json["id"],
        label: json["label"] == null ? null : json["label"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"] == null ? null : json["type"],
        value: json["value"] == null ? null : json["value"],
        settingDefault: json["default"] == null ? null : json["default"],
        tip: json["tip"] == null ? null : json["tip"],
        placeholder: json["placeholder"] == null
            ? null
            : placeholderValues.map[json["placeholder"]],
        options:
            json["options"] == null ? null : Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "label": label == null ? null : label,
        "description": description == null ? null : description,
        "type": type == null ? null : type,
        "value": value == null ? null : value,
        "default": settingDefault == null ? null : settingDefault,
        "tip": tip == null ? null : tip,
        "placeholder":
            placeholder == null ? null : placeholderValues.reverse[placeholder],
        "options": options == null ? null : options.toJson(),
      };
}

class Options {
  Options({
    this.flatRate,
    this.freeShipping,
    this.localPickup,
    this.sale,
    this.authorization,
  });

  final String flatRate;
  final String freeShipping;
  final String localPickup;
  final String sale;
  final String authorization;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        flatRate: json["flat_rate"] == null ? null : json["flat_rate"],
        freeShipping:
            json["free_shipping"] == null ? null : json["free_shipping"],
        localPickup: json["local_pickup"] == null ? null : json["local_pickup"],
        sale: json["sale"] == null ? null : json["sale"],
        authorization:
            json["authorization"] == null ? null : json["authorization"],
      );

  Map<String, dynamic> toJson() => {
        "flat_rate": flatRate == null ? null : flatRate,
        "free_shipping": freeShipping == null ? null : freeShipping,
        "local_pickup": localPickup == null ? null : localPickup,
        "sale": sale == null ? null : sale,
        "authorization": authorization == null ? null : authorization,
      };
}

enum Placeholder { EMPTY, OPTIONAL, YOU_YOUREMAIL_COM }

final placeholderValues = EnumValues({
  "": Placeholder.EMPTY,
  "Optional": Placeholder.OPTIONAL,
  "you@youremail.com": Placeholder.YOU_YOUREMAIL_COM
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
