import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Helper.dart';
import 'package:ecommerce/Models/ProductModel.dart';
import 'package:ecommerce/api/ProductApi.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {

  ProductApi _productApi = ProductApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Center(child: createTextThemeWise(label: 'Home', style: Theme.of(context).primaryTextTheme.caption),)),
            InkWell(
                onTap: (){
                  setTheme();
                },
                child: SvgPicture.asset('assets/svg/themeicon.svg', height: 25, color: Theme.of(context).indicatorColor,))
          ],
        ),),
      body: SafeArea(
          child: getBody()),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _productApi.dispose();
    super.dispose();
  }

  getBody() {
    return Container(
      margin: EdgeInsets.all(15),
      child: StreamBuilder<requestResponseState>(
        initialData: requestResponseState.Loading,
        stream: _productApi.productController.stream,
        builder: (context, snapshot) {
          if(snapshot.data == requestResponseState.Success){
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: productList.length,
                itemBuilder: (BuildContext context, index) {
                  ProductModel model = productList[index];

                  return _getDesign(model);
                });
          }
          else if(snapshot.data == requestResponseState.Loading){
            _productApi.getProducts();
            return Center(child:
            DefaultTextStyle(
              style: Theme.of(context).primaryTextTheme.bodyText1,
              child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('Loading..'),
                  ],
                isRepeatingAnimation: true,
              ),
            ));
          }else{
            return Center(child: createTextThemeWise(label: 'No Data Found.', style: Theme.of(context).primaryTextTheme.bodyText1, textAlign: TextAlign.center));
          }
        }
      ),
    );
  }

  _getDesign(ProductModel model) {
    String name = model.name ?? '';
    String price = model.price ?? '';
    String rating = model.rating == null ? '0.0' : model.rating.toString();

    return InkWell(
      onTap: (){
        //Navigator.pushNamed(context, MyRoutes.productDetails, arguments: model);
        Get.toNamed(MyRoutes.productDetails, arguments: model);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15)),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: model.imageLink,
              placeholder: (context, url) => CircularProgressIndicator(color: Theme.of(context).indicatorColor,),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 5, right: 5),
              child: createTextThemeWise(label: name, style: Theme.of(context).primaryTextTheme.bodyText1, textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: createTextThemeWise(label: '\$ ' + price, style: Theme.of(context).primaryTextTheme.bodyText2, textAlign: TextAlign.center),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: double.parse(rating),
                  minRating: 0,
                  maxRating: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  unratedColor: MyColors.grey ,
                  ignoreGestures: true,
                  itemSize: 15,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                createTextThemeWise(label: '($rating)', style: Theme.of(context).primaryTextTheme.subtitle1)
              ],
            )
          ],
        ),
      ),
    );
  }

}
