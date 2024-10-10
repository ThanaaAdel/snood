
class MediationContractModel {
  int? code;
  Data? data;
  String? msg;

  MediationContractModel({
    this.code,
    this.data,
    this.msg,
  });

  factory MediationContractModel.fromJson(Map<String, dynamic> json) => MediationContractModel(
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
    "msg": msg,
  };
}

class Data {
  List<Item>? items;
  Pagination? pagination;

  Data({
    this.items,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Item {
  String? id;
  String? clientId;
  String? clientName;
  String? clientMobile;
  String? clientIdentityNo;
  String? countryId;
  String? occId;
  Experience? experience;
  Religion? religion;
  String? visaNo;
  String? costWithoutTax;
  String? costTax;
  String? costTaxRatio;
  String? costIncludeTax;
  String? statusClient;
  DateTime? createdAt;
  Occupation? occupation;
  Country? country;
  StatusDisplay? statusDisplay;

  Item({
    this.id,
    this.clientId,
    this.clientName,
    this.clientMobile,
    this.clientIdentityNo,
    this.countryId,
    this.occId,
    this.experience,
    this.religion,
    this.visaNo,
    this.costWithoutTax,
    this.costTax,
    this.costTaxRatio,
    this.costIncludeTax,
    this.statusClient,
    this.createdAt,
    this.occupation,
    this.country,
    this.statusDisplay,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    clientId: json["client_id"],
    clientName: json["client_name"],
    clientMobile: json["client_mobile"],
    clientIdentityNo: json["client_identity_no"],
    countryId: json["country_id"],
    occId: json["occ_id"],
    experience: json["experience"] is String
        ? Experience(id: null, title: json["experience"])  // treat as string
        : json["experience"] == null
        ? null
        : Experience.fromJson(json["experience"]),
    religion: json["religion"] is String
        ? Religion(id: null, title: json["religion"])  // treat as string
        : json["religion"] == null
        ? null
        : Religion.fromJson(json["religion"]),
    visaNo: json["visa_no"],
    costWithoutTax: json["cost_without_tax"],
    costTax: json["cost_tax"],
    costTaxRatio: json["cost_tax_ratio"],
    costIncludeTax: json["cost_include_tax"],
    statusClient: json["status_client"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    occupation: json["occupation"] == null ? null : Occupation.fromJson(json["occupation"]),
    country: json["country"] is String
        ? Country(id: null, name: json["country"]) // Handle string case
        : json["country"] is Map<String, dynamic>
        ? Country.fromJson(json["country"]) // Handle map case
        : json["country"] == null || json["country"] is bool
        ? null // Handle null or bool case
        : throw Exception("Unexpected country type: ${json["country"]}"),
    //country: json["country"] == null ? null : Country.fromJson(json["country"]),
    statusDisplay: json["status_display"] == null ? null : StatusDisplay.fromJson(json["status_display"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "client_name": clientName,
    "client_mobile": clientMobile,
    "client_identity_no": clientIdentityNo,
    "country_id": countryId,
    "occ_id": occId,
    "experience": experience?.toJson(),
    "religion": religion?.toJson(),
    "visa_no": visaNo,
    "cost_without_tax": costWithoutTax,
    "cost_tax": costTax,
    "cost_tax_ratio": costTaxRatio,
    "cost_include_tax": costIncludeTax,
    "status_client": statusClient,
    "created_at": createdAt?.toIso8601String(),
    "occupation": occupation?.toJson(),
    "country": country?.toJson(),
    "status_display": statusDisplay?.toJson(),
  };
}

class Country {
  String? id;
  String? name;
  String? internationalCode;

  Country({
    this.id,
    this.name,
    this.internationalCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    internationalCode: json["international_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "international_code": internationalCode,
  };
}

class Experience {
  String? id;
  String? title;

  Experience({
    this.id,
    this.title,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
class Religion {
  String? id;
  String? title;

  Religion({
    this.id,
    this.title,
  });

  factory Religion.fromJson(Map<String, dynamic> json) => Religion(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
class Occupation {
  String? id;
  String? name;

  Occupation({
    this.id,
    this.name,
  });

  factory Occupation.fromJson(Map<String, dynamic> json) => Occupation(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Pagination {
  Pages? pages;
  int? count;
  int? current;

  Pagination({
    this.pages,
    this.count,
    this.current,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    pages: json["pages"] == null ? null : Pages.fromJson(json["pages"]),
    count: json["count"],
    current: json["current"],
  );

  Map<String, dynamic> toJson() => {
    "pages": pages?.toJson(),
    "count": count,
    "current": current,
  };
}
class StatusDisplay {
  String? id;
  String? title;

  StatusDisplay({
    this.id,
    this.title,
  });

  factory StatusDisplay.fromJson(Map<String, dynamic> json) => StatusDisplay(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
class Pages {
  int? the1;

  Pages({
    this.the1,
  });

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
    the1: json["1"],
  );

  Map<String, dynamic> toJson() => {
    "1": the1,
  };
}
