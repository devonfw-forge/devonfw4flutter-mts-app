///Generated with https://javiercbk.github.io/json_to_dart/
class SearchResponse {
  List<Content> content;
  Pageable pageable;
  int totalElements;

  SearchResponse({this.content, this.pageable, this.totalElements});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    totalElements = json['totalElements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable.toJson();
    }
    data['totalElements'] = this.totalElements;
    return data;
  }
}

class Content {
  DishData dish;
  Image image;
  List<String> extras;
  List<Categories> categories;

  Content({this.dish, this.image, this.extras, this.categories});

  Content.fromJson(Map<String, dynamic> json) {
    dish = json['dish'] != null ? new DishData.fromJson(json['dish']) : null;
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    if (json['extras'] != null) {
      extras = new List<String>();
      json['extras'].forEach((v) {
        extras.add(v);
      });
    }
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dish != null) {
      data['dish'] = this.dish.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.extras != null) {
      data['extras'] = this.extras.map((v) => v).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DishData {
  int id;
  int modificationCounter;
  String name;
  String description;
  int price;
  int imageId;

  DishData(
      {this.id,
      this.modificationCounter,
      this.name,
      this.description,
      this.price,
      this.imageId});

  DishData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modificationCounter = json['modificationCounter'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    imageId = json['imageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['modificationCounter'] = this.modificationCounter;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['imageId'] = this.imageId;
    return data;
  }
}

class Image {
  int id;
  int modificationCounter;
  String name;
  String content;
  String contentType;
  String mimeType;

  Image(
      {this.id,
      this.modificationCounter,
      this.name,
      this.content,
      this.contentType,
      this.mimeType});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modificationCounter = json['modificationCounter'];
    name = json['name'];
    content = json['content'];
    contentType = json['contentType'];
    mimeType = json['mimeType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['modificationCounter'] = this.modificationCounter;
    data['name'] = this.name;
    data['content'] = this.content;
    data['contentType'] = this.contentType;
    data['mimeType'] = this.mimeType;
    return data;
  }
}

class Categories {
  int id;
  int modificationCounter;
  String name;
  String description;
  int showOrder;

  Categories(
      {this.id,
      this.modificationCounter,
      this.name,
      this.description,
      this.showOrder});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modificationCounter = json['modificationCounter'];
    name = json['name'];
    description = json['description'];
    showOrder = json['showOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['modificationCounter'] = this.modificationCounter;
    data['name'] = this.name;
    data['description'] = this.description;
    data['showOrder'] = this.showOrder;
    return data;
  }
}

class Pageable {
  int pageNumber;
  int pageSize;
  List<String> sort;

  Pageable({this.pageNumber, this.pageSize, this.sort});

  Pageable.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    if (json['sort'] != null) {
      sort = new List<String>();
      json['sort'].forEach((v) {
        sort.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    if (this.sort != null) {
      data['sort'] = this.sort.map((v) => v).toList();
    }
    return data;
  }
}
