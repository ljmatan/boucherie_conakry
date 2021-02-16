import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';

abstract class Products {
  static List<Product> _specialties;
  static List<Product> get specialties => _specialties;
  static void setSpecialties(List<Product> newList) => _specialties = newList;

  static List<Product> _wines;
  static List<Product> get wines => _wines;
  static void setWines(List<Product> newList) => _wines = newList;

  static List<Product> _seafood;
  static List<Product> get seafood => _seafood;
  static void setSeafood(List<Product> newList) => _seafood = newList;

  static List<Product> _butchers;
  static List<Product> get butchers => _butchers;
  static void setButchers(List<Product> newList) => _butchers = newList;

  static List<Product> _featured;
  static List<Product> get featured => _featured;
  static void setFeatured(List<Product> newList) => _featured = newList;
}
