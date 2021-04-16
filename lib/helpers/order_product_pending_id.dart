import 'package:service_products_business/models/product_response.dart';

class OrderProductPendingId {
  static orderProductPendingStock(
      int color, int size, Product product, int amount) {
    if (color != null && size == null) {
      final stockbyColor =
          product.stock.where((element) => element.color == color).first;
      if (stockbyColor.quantity == 0) return 'Sin Stock';
      return '${stockbyColor.quantity} disponible';
    } else if (color != null && size != null) {
      final stockbyColor =
          product.stock.where((element) => element.color == color).first;
      final stockBySize = stockbyColor.sizeProduct
          .where((element) => element.size == size)
          .first;
      if (stockBySize.sizeQuantity == 0) return 'Sin Stock';

      return '${stockBySize.sizeQuantity} disponible';
    } else if (amount != null && color == null && size == null) {
      if (product.stock.first.quantity == 0) return 'Sin Stock';

      return '${product.stock.first.quantity} disponible';
    }
  }


}
