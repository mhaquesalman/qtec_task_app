import 'package:http/http.dart';
import 'package:qtec_task_app/model/product_details.dart';

class NetWork {
  static const String url = "http://3.1.180.10/api/product-core/suzuki-gsx-r150-fi-dual-channel-abs-yvj2/0/";

  Future<ProductDetails> getProductDetails() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("Loading success");
      return productDetailsFromJson(response.body);
    } else {
      print("Loading failed");
      throw Exception("Error getting data from the internet!");
    }
  }

}