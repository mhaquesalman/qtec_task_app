import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qtec_task_app/model/product_details.dart';
import 'package:qtec_task_app/network/network.dart';
import 'package:qtec_task_app/ui/helper/rating_bar_widget.dart';

class ApiProductDetailsScreen extends StatefulWidget {
  const ApiProductDetailsScreen({Key key}) : super(key: key);

  @override
  _ApiProductDetailsScreenState createState() => _ApiProductDetailsScreenState();
}

class _ApiProductDetailsScreenState extends State<ApiProductDetailsScreen> {
  Future<ProductDetails> _productDetails;


  @override
  void initState() {
    super.initState();
    _productDetails = _getProductDetails();
  }

  Future<ProductDetails> _getProductDetails() => NetWork().getProductDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe1f5fe),
      appBar: AppBar(
        elevation: 5,
        title: Text(
          "Details from API",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black87
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: Colors.grey,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: FutureBuilder<ProductDetails>(
              future: _productDetails,
              builder: (BuildContext context, AsyncSnapshot<ProductDetails> snapshot) {
                final productDetailsModel = snapshot.data;
                if (snapshot.hasData && productDetailsModel != null) {
                  return Column(
                    children: [
                      buildBannerImageView(productDetailsModel),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildCustomText(label: "Category Name: ", data: productDetailsModel.categoryList[0].categoryName),
                            Divider(color: Colors.grey,),
                            buildCustomText(label: "Product Name: ", data: productDetailsModel.productName),
                            Divider(color: Colors.grey,),
                            buildCustomText(label: 'Brand: ', data: productDetailsModel.brand.name),
                            Divider(color: Colors.grey,),
                            buildCustomText(label: 'Product Price: ', data: productDetailsModel.productPrice.toString() + ' BDT'),
                            Divider(color: Colors.grey,),
                            buildCustomText(label: 'Booking Price: ', data: productDetailsModel.bookingPrice.toString()),
                            Divider(color: Colors.grey,),
                            buildCustomText(label: "Discount Charge: ",
                                data: productDetailsModel.discountCharge == null ? 'N/A' : productDetailsModel.discountCharge.toString()),
                            Divider(color: Colors.grey,),
                            buildCustomText(label: "Pre Order: ", data: productDetailsModel.preOrder ? "Available" : "N/A"),
                            Divider(color: Colors.grey,),
                            buildCustomText(label: 'Stock: ', data: productDetailsModel.stock.toString()),
                            Divider(color: Colors.grey,),
                            buildCustomText(label: 'Variation: ',
                                data: productDetailsModel.variation == null ? 'N/A' : productDetailsModel.variation.toString()),
                            Divider(color: Colors.grey,),
                            buildCustomText(label: 'Meta Description: ', data: productDetailsModel.metaDescription),
                            Divider(color: Colors.grey,),
                            buildCustomText(label: 'Message: ',
                                data: productDetailsModel.discountCharge == null ? 'N/A' : productDetailsModel.message),
                            Divider(color: Colors.grey,),
                            buildCustomText(label: 'Business Name: ', data: productDetailsModel.buisnessName),
                            Divider(color: Colors.grey,),
                            Row(
                              children: [
                                Text("Product Review: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                RatingBarWidget(rating: productDetailsModel.productReviewAvg)
                              ],
                            ),
                            Divider(color: Colors.grey,),
                            detailsImages(snapshot)
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBannerImageView(ProductDetails productDetailsModel) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Image.network(
        productDetailsModel.bannerImage,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget buildCustomText({String label, String data}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: data, style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.normal),
          ),
        ]
      ),
    );
  }

  Widget detailsImages(AsyncSnapshot<ProductDetails> snapshot) {
    List<String> detailsImages = snapshot.data.detailsImages;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Details Images: ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: detailsImages.length,
              separatorBuilder: (context, index) => SizedBox(width: 8),
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 180,
                  child: Image.network(
                    detailsImages[index],
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
