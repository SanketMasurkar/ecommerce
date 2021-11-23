import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Helper.dart';
import 'package:ecommerce/Models/ProductModel.dart';
import 'package:ecommerce/Themes.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget{
  ProductModel model;

  @override
  State<StatefulWidget> createState() {
    return ProductDetailsState();
  }

  ProductDetails(this.model);

}


class ProductDetailsState extends State<ProductDetails> {

  ProductModel model;

  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            centerTitle: false,
            leading: InkWell(
                onTap: (){
                  //Navigator.pop(context);
                  Get.offAllNamed(MyRoutes.home);
                },
                child: Icon(Icons.arrow_back, color: Theme.of(context).indicatorColor,)),
            title: Row(
              children: [
                Expanded(child: Center(child: createTextThemeWise(label: 'Details', style: Theme.of(context).primaryTextTheme.caption))),
                InkWell(
                    onTap: (){
                      setTheme();
                    },
                    child: SvgPicture.asset('assets/svg/themeicon.svg', height: 25, color: Theme.of(context).indicatorColor,))
              ],
            ),),
          bottomNavigationBar: _bottomButton(),
          body: _getBody(),
        ),
      ),
    );
  }

  Widget _getBody() {
    String name = model.name ?? '';
    String desc = model.description ?? '';
    String rating = model.rating == null ? '0.0' : model.rating.toString();
    var colors = model.productColors ?? [];

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Center(
                child: CachedNetworkImage(
                imageUrl: model.imageLink,
                placeholder: (context, url) => CircularProgressIndicator(color: Theme.of(context).indicatorColor,),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),)),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height / 3,),
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: createTextThemeWise(label: name, style: Theme.of(context).primaryTextTheme.bodyText2)),
                      Icon(Icons.star, color: Colors.amber, size: 15,),
                      createTextThemeWise(label: '($rating)', style: Theme.of(context).primaryTextTheme.subtitle1),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: createTextThemeWise(label: desc, style: Theme.of(context).primaryTextTheme.subtitle2),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        createTextThemeWise(label: 'Give Rating: ', style: Theme.of(context).primaryTextTheme.headline3),
                        RatingBar.builder(
                          initialRating: double.parse(rating),
                          minRating: 0,
                          maxRating: 5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          unratedColor: MyColors.grey ,
                          itemSize: 20,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            productList.forEach((element) {
                              if(element.id == model.id){
                                element.rating = rating;
                              }
                            });
                            setState(() {

                            });
                          },
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton() {
    String price = model.price ?? '';

    return Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            createTextThemeWise(label: '\$ ' + price, style: Theme.of(context).primaryTextTheme.headline1, textAlign: TextAlign.center),
            InkWell(
              onTap: () {

              },
              child: Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: MyColors.primaryColorLight,
                    borderRadius: BorderRadius.circular(8)),
                child: createTextThemeWise(
                    label: 'Buy',
                    style: Theme.of(context).primaryTextTheme.headline2),
              ),
            ),
          ],
        ));
  }

}