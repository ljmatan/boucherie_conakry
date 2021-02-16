// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productsFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  Product({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.priceHtml,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.inStock,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.relatedIds,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.groupedProducts,
    this.menuOrder,
    this.metaData,
    this.links,
  });

  final int id;
  final String name;
  final String slug;
  final String permalink;
  final DateTime dateCreated;
  final DateTime dateCreatedGmt;
  final DateTime dateModified;
  final DateTime dateModifiedGmt;
  final String type;
  final String status;
  final bool featured;
  final String catalogVisibility;
  final String description;
  final String shortDescription;
  final String sku;
  final String price;
  final String regularPrice;
  final String salePrice;
  final dynamic dateOnSaleFrom;
  final dynamic dateOnSaleFromGmt;
  final dynamic dateOnSaleTo;
  final dynamic dateOnSaleToGmt;
  final String priceHtml;
  final bool onSale;
  final bool purchasable;
  final int totalSales;
  final bool virtual;
  final bool downloadable;
  final List<dynamic> downloads;
  final int downloadLimit;
  final int downloadExpiry;
  final String externalUrl;
  final String buttonText;
  final String taxStatus;
  final String taxClass;
  final bool manageStock;
  final dynamic stockQuantity;
  final bool inStock;
  final String backorders;
  final bool backordersAllowed;
  final bool backordered;
  final bool soldIndividually;
  final String weight;
  final Dimensions dimensions;
  final bool shippingRequired;
  final bool shippingTaxable;
  final String shippingClass;
  final int shippingClassId;
  final bool reviewsAllowed;
  final String averageRating;
  final int ratingCount;
  final List<int> relatedIds;
  final List<dynamic> upsellIds;
  final List<dynamic> crossSellIds;
  final int parentId;
  final String purchaseNote;
  final List<Category> categories;
  final List<dynamic> tags;
  final List<ImageResult> images;
  final List<Attribute> attributes;
  final List<DefaultAttribute> defaultAttributes;
  final List<dynamic> variations;
  final List<dynamic> groupedProducts;
  final int menuOrder;
  final List<dynamic> metaData;
  final Links links;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        permalink: json["permalink"] == null ? null : json["permalink"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateCreatedGmt: json["date_created_gmt"] == null
            ? null
            : DateTime.parse(json["date_created_gmt"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        dateModifiedGmt: json["date_modified_gmt"] == null
            ? null
            : DateTime.parse(json["date_modified_gmt"]),
        type: json["type"] == null ? null : json["type"],
        status: json["status"] == null ? null : json["status"],
        featured: json["featured"] == null ? null : json["featured"],
        catalogVisibility: json["catalog_visibility"] == null
            ? null
            : json["catalog_visibility"],
        description: json["description"] == null ? null : json["description"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
        sku: json["sku"] == null ? null : json["sku"],
        price: json["price"] == null ? null : json["price"],
        regularPrice:
            json["regular_price"] == null ? null : json["regular_price"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
        dateOnSaleTo: json["date_on_sale_to"],
        dateOnSaleToGmt: json["date_on_sale_to_gmt"],
        priceHtml: json["price_html"] == null ? null : json["price_html"],
        onSale: json["on_sale"] == null ? null : json["on_sale"],
        purchasable: json["purchasable"] == null ? null : json["purchasable"],
        totalSales: json["total_sales"] == null ? null : json["total_sales"],
        virtual: json["virtual"] == null ? null : json["virtual"],
        downloadable:
            json["downloadable"] == null ? null : json["downloadable"],
        downloads: json["downloads"] == null
            ? null
            : List<dynamic>.from(json["downloads"].map((x) => x)),
        downloadLimit:
            json["download_limit"] == null ? null : json["download_limit"],
        downloadExpiry:
            json["download_expiry"] == null ? null : json["download_expiry"],
        externalUrl: json["external_url"] == null ? null : json["external_url"],
        buttonText: json["button_text"] == null ? null : json["button_text"],
        taxStatus: json["tax_status"] == null ? null : json["tax_status"],
        taxClass: json["tax_class"] == null ? null : json["tax_class"],
        manageStock: json["manage_stock"] == null ? null : json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        inStock: json["in_stock"] == null ? null : json["in_stock"],
        backorders: json["backorders"] == null ? null : json["backorders"],
        backordersAllowed: json["backorders_allowed"] == null
            ? null
            : json["backorders_allowed"],
        backordered: json["backordered"] == null ? null : json["backordered"],
        soldIndividually: json["sold_individually"] == null
            ? null
            : json["sold_individually"],
        weight: json["weight"] == null ? null : json["weight"],
        dimensions: json["dimensions"] == null
            ? null
            : Dimensions.fromJson(json["dimensions"]),
        shippingRequired: json["shipping_required"] == null
            ? null
            : json["shipping_required"],
        shippingTaxable:
            json["shipping_taxable"] == null ? null : json["shipping_taxable"],
        shippingClass:
            json["shipping_class"] == null ? null : json["shipping_class"],
        shippingClassId: json["shipping_class_id"] == null
            ? null
            : json["shipping_class_id"],
        reviewsAllowed:
            json["reviews_allowed"] == null ? null : json["reviews_allowed"],
        averageRating:
            json["average_rating"] == null ? null : json["average_rating"],
        ratingCount: json["rating_count"] == null ? null : json["rating_count"],
        relatedIds: json["related_ids"] == null
            ? null
            : List<int>.from(json["related_ids"].map((x) => x)),
        upsellIds: json["upsell_ids"] == null
            ? null
            : List<dynamic>.from(json["upsell_ids"].map((x) => x)),
        crossSellIds: json["cross_sell_ids"] == null
            ? null
            : List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        purchaseNote:
            json["purchase_note"] == null ? null : json["purchase_note"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        tags: json["tags"] == null
            ? null
            : List<dynamic>.from(json["tags"].map((x) => x)),
        images: json["images"] == null
            ? null
            : List<ImageResult>.from(
                json["images"].map((x) => ImageResult.fromJson(x))),
        attributes: json["attributes"] == null
            ? null
            : List<Attribute>.from(
                json["attributes"].map((x) => Attribute.fromJson(x))),
        defaultAttributes: json["default_attributes"] == null
            ? null
            : List<DefaultAttribute>.from(json["default_attributes"]
                .map((x) => DefaultAttribute.fromJson(x))),
        variations: json["variations"] == null
            ? null
            : List<dynamic>.from(json["variations"].map((x) => x)),
        groupedProducts: json["grouped_products"] == null
            ? null
            : List<dynamic>.from(json["grouped_products"].map((x) => x)),
        menuOrder: json["menu_order"] == null ? null : json["menu_order"],
        metaData: json["meta_data"] == null
            ? null
            : List<dynamic>.from(json["meta_data"].map((x) => x)),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
      );
}

class Attribute {
  Attribute({
    this.id,
    this.name,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });

  final int id;
  final String name;
  final int position;
  final bool visible;
  final bool variation;
  final List<String> options;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        position: json["position"] == null ? null : json["position"],
        visible: json["visible"] == null ? null : json["visible"],
        variation: json["variation"] == null ? null : json["variation"],
        options: json["options"] == null
            ? null
            : List<String>.from(json["options"].map((x) => x)),
      );
}

class Category {
  Category({this.id, this.name, this.slug});

  final int id;
  final String name;
  final String slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
      );
}

class DefaultAttribute {
  DefaultAttribute({
    this.id,
    this.name,
    this.option,
  });

  final int id;
  final String name;
  final String option;

  factory DefaultAttribute.fromJson(Map<String, dynamic> json) =>
      DefaultAttribute(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        option: json["option"] == null ? null : json["option"],
      );
}

class Dimensions {
  Dimensions({this.length, this.width, this.height});

  final String length;
  final String width;
  final String height;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json["length"] == null ? null : json["length"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
      );
}

class ImageResult {
  ImageResult({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
    this.position,
  });

  final int id;
  final DateTime dateCreated;
  final DateTime dateCreatedGmt;
  final DateTime dateModified;
  final DateTime dateModifiedGmt;
  final String src;
  final String name;
  final String alt;
  final int position;

  factory ImageResult.fromJson(Map<String, dynamic> json) => ImageResult(
        id: json["id"] == null ? null : json["id"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateCreatedGmt: json["date_created_gmt"] == null
            ? null
            : DateTime.parse(json["date_created_gmt"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        dateModifiedGmt: json["date_modified_gmt"] == null
            ? null
            : DateTime.parse(json["date_modified_gmt"]),
        src: json["src"] == null ? null : json["src"],
        name: json["name"] == null ? null : json["name"],
        alt: json["alt"] == null ? null : json["alt"],
        position: json["position"] == null ? null : json["position"],
      );
}

class Links {
  Links({this.self, this.collection});

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
}

class Collection {
  Collection({this.href});

  final String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"] == null ? null : json["href"],
      );
}
