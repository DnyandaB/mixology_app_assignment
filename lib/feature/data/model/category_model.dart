class CategoryListModel {
  List<Drinks>? drinks;

  CategoryListModel({this.drinks});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        drinks!.add(new Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.drinks != null) {
      data['drinks'] = this.drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Drinks {
  String? strCategory;

  Drinks({this.strCategory});

  Drinks.fromJson(Map<String, dynamic> json) {
    strCategory = json['strCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strCategory'] = this.strCategory;
    return data;
  }
}

