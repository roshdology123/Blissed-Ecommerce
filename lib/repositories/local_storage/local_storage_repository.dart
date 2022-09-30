import 'package:hive/hive.dart';

import '../../models/product_model.dart';
import 'base_local_storage_repository.dart';


class LocalStorageRepository extends BaseLocalStorageRepository{

  String boxName = 'wishlist_products';

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Product>(boxName);
    return box;
  }
  @override
  List<Product> getWishlist(Box box) {
    return box.values.toList() as List<Product>;
  }


  @override
  Future<void> addProductToWishlist(Box box, Product product) async{
    await box.put(product.id,product);
  }


  @override
  Future<void> removeProductFromWishlist(Box box, Product product) async {
    await box.delete(product.id);
  }

  @override
  Future<void> clearWishlist(Box box) async {
    await box.clear();
  }




}