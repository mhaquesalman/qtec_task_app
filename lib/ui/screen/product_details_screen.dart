import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qtec_task_app/model/product_details.dart';
import 'package:qtec_task_app/network/network.dart';
import 'package:qtec_task_app/ui/helper/image_list.dart';
import 'package:qtec_task_app/ui/screen/api_product_details_screen.dart';
import 'package:qtec_task_app/ui/screen/information_tile.dart';
import 'package:qtec_task_app/ui/helper/rating_bar_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../helper/description_list.dart';
import 'description_tile.dart';
import '../helper/information_list.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({Key key}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final controller = CarouselController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe1f5fe),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Product Details",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
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
            color: Colors.white,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                buildCarouselSlider(),
                Positioned(bottom: 10, child: buildIndicator())
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has "
                      "been the industry's standard dummy text ever since the 1500s, when an unknown printer took a "
                      "galley of type and scrambled it to make a type specimen book",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    buildPriceView(),
                    RatingBarWidget(
                      rating: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
                      child: Text("Select Color",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          )),
                    ),
                    buildColorsButtonView()
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Delivery Information",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          buildDeliveryView(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Payment Method (Supported)",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          buildPaymentView(),
          SizedBox(
            height: 15,
          ),
          Column(
            children: descriptionList
                .map((descriptionTile) => BuildDescriptionTileWidget(
                    descriptionTile: descriptionTile))
                .toList(),
          ),
          Column(
            children: informationList
                .map((informationTile) => BuildInformationTileWidget(
                    informationTile: informationTile))
                .toList(),
          ),
          SizedBox(
            height: 15,
          ),
          buildApiButton()
        ],
      ),
    );
  }

  Widget buildPriceView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "BDT 1,225,236",
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "BDT 2,000,000",
          style: TextStyle(
            decoration: TextDecoration.lineThrough,
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        RaisedButton(
          child: Text(
            "50 % off",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          color: Colors.red,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildColorsButtonView() {
    return Row(children: [
      OutlinedButton(
        onPressed: () {},
        child: Text("Black"),
        style: OutlinedButton.styleFrom(
            primary: Colors.black, side: BorderSide(color: Colors.black)),
      ),
      SizedBox(
        width: 8,
      ),
      ElevatedButton(
          onPressed: () {},
          child: Text("Yellow"),
          style: ElevatedButton.styleFrom(
            primary: Colors.yellow,
            onPrimary: Colors.white,
            elevation: 0,
            shadowColor: Colors.white,
          )),
      SizedBox(
        width: 8,
      ),
      OutlinedButton(
        onPressed: () {},
        child: Text("Red"),
        style: OutlinedButton.styleFrom(
            primary: Colors.red, side: BorderSide(color: Colors.red)),
      ),
      SizedBox(
        width: 8,
      ),
      OutlinedButton(
        onPressed: () {},
        child: Text("Blue"),
        style: OutlinedButton.styleFrom(
            primary: Colors.blue, side: BorderSide(color: Colors.blue)),
      ),
    ]);
  }

  Widget buildDeliveryView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: RichText(
        text: TextSpan(children: [
          WidgetSpan(
              child: Icon(
                Icons.delivery_dining_outlined,
              ),
              alignment: PlaceholderAlignment.middle),
          TextSpan(
            text: ' Sent From ',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          TextSpan(
            text: 'Dhaka,',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: ' will arrive in ',
              style: TextStyle(color: Colors.black, fontSize: 18)),
          TextSpan(
            text: '7/10',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextSpan(
              text: ' workdays',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              )),
        ]),
      ),
    );
  }

  Widget buildPaymentView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Row(children: [
            Material(
              color: Colors.transparent,
              shape: CircleBorder(side: BorderSide(color: Colors.green)),
              child: Icon(Icons.check, color: Colors.green, size: 20),
            ),
            SizedBox(width: 10),
            Text("Bkash"),
            SizedBox(width: 10),
            Material(
              color: Colors.transparent,
              shape: CircleBorder(side: BorderSide(color: Colors.red)),
              child: Icon(Icons.close, color: Colors.red, size: 20),
            ),
            SizedBox(width: 10),
            Text("Cash on Delivery not available")
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0, left: 12.0),
          child: Row(children: [
            Material(
              color: Colors.transparent,
              shape: CircleBorder(side: BorderSide(color: Colors.green)),
              child: Icon(Icons.check, color: Colors.green, size: 20),
            ),
            SizedBox(width: 10),
            Text("Bkash"),
            SizedBox(width: 10),
            Material(
              color: Colors.transparent,
              shape: CircleBorder(side: BorderSide(color: Colors.green)),
              child: Icon(Icons.check, color: Colors.green, size: 20),
            ),
            SizedBox(width: 10),
            Text("Bkash"),
            SizedBox(width: 10),
            Material(
              color: Colors.transparent,
              shape: CircleBorder(side: BorderSide(color: Colors.green)),
              child: Icon(Icons.check, color: Colors.green, size: 20),
            ),
            SizedBox(width: 10),
            Text("Bkash")
          ]),
        ),
      ],
    );
  }

  Widget buildCarouselSlider() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 220,
        initialPage: 0,
        viewportFraction: 1,
        onPageChanged: (index, reason) => (setState(() => activeIndex = index)),
      ),
      itemCount: images.length,
      itemBuilder: (context, index, pageIndex) {
        final url = images[index];
        return buildImage(url, index);
      },
      carouselController: controller,
    );
  }

  Widget buildImage(String urlImage, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildApiButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
      child: Container(
        height: 60.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: FlatButton(
            child: Text(
              'Click here to see data from API',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: goToApiProductDetailsScreen),
      ),
    );
  }

  void goToApiProductDetailsScreen() => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ApiProductDetailsScreen()),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images.length,
        effect: SlideEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: Colors.red,
            dotColor: Colors.grey),
        onDotClicked: animateToSlide,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}

class BuildDescriptionTileWidget extends StatelessWidget {
  final DescriptionTile descriptionTile;

  BuildDescriptionTileWidget({Key key, @required this.descriptionTile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = descriptionTile.title;
    final tiles = descriptionTile.tiles;
    if (tiles.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
          leading: Icon(FontAwesomeIcons.dotCircle),
          horizontalTitleGap: 0,
        ),
      );
    } else {
      return ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        children: tiles
            .map((tile) => BuildDescriptionTileWidget(
                  descriptionTile: tile,
                ))
            .toList(),
      );
    }
  }
}

class BuildInformationTileWidget extends StatelessWidget {
  final InformationTile informationTile;

  BuildInformationTileWidget({Key key, @required this.informationTile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = informationTile.title;
    final tiles = informationTile.tiles;
    if (tiles.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
          leading: Icon(FontAwesomeIcons.dotCircle),
          horizontalTitleGap: 0,
        ),
      );
    } else {
      return ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        children: tiles
            .map((tile) => BuildInformationTileWidget(
                  informationTile: tile,
                ))
            .toList(),
      );
    }
  }
}
