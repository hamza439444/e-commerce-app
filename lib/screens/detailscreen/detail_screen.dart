import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../appColors/app_colors.dart';
import '../../data/detail-screen-data/detail-screen-data.dart';
import '../../models/single_product_models.dart';
import '../../routes/routes.dart';
import '../../styles/detail_screen_styles.dart';
import '../../svgimages/svg_images.dart';
import '../../widgets/drop_button_widget.dart';
import '../../widgets/single_product_widget.dart';
import '../payment/payment_screen.dart';
import '../sizeguide/size_guide_screen.dart';

class DetailScreen extends StatefulWidget {
  // final SingleProductModel data;
  final String categoryId;

  const DetailScreen({super.key, required this.categoryId});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DocumentSnapshot? categoryData;

  @override
  void initState() {
    super.initState();
    getCategoryData();
  }

  Future<void> getCategoryData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .get();
    setState(() {
      categoryData = snapshot;
    });
  }

  //  String _ratingController;
  //  String _sizeController;

  PreferredSize buildAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Lapify Enterprise",
          style: TextStyle(
            color: AppColors.baseDarkPinkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // IconButton(
          //   icon: SvgPicture.asset(
          //     SvgImages.heart,
          //     color: AppColors.baseBlackColor,
          //     width: 35,
          //     semanticsLabel: "Fave",
          //   ),
          //   onPressed: () {},
          // ),

          IconButton(
            icon: SvgPicture.asset(
              SvgImages.upload,
              color: AppColors.baseBlackColor,
              width: 35,
              semanticsLabel: "Fave",
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  buildListTile() {
    return ListTile(
      leading: const CircleAvatar(
        radius: 30.0,
        backgroundImage: AssetImage("images/Logo.png"),
        backgroundColor: Colors.transparent,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryData!['productName'],
            overflow: TextOverflow.ellipsis,
            style: DetailScreenStyles.companyTitleStyle,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            categoryData!['productModel'],
            style: DetailScreenStyles.productModelStyle,
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryData!['productPrice'].toString(),
            style: DetailScreenStyles.productPriceStyle,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            categoryData!['productOldPrice'].toString(),
            style: DetailScreenStyles.productOldPriceStyle,
          ),
        ],
      ),
    );
  }

  buildProductImages() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              categoryData!['productImage'],
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 15, top: 15),
                  child: Image.network(
                    categoryData!['productImage'],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 15, top: 15),
                  child: Image.network(
                    categoryData!['productImage'],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 15, top: 15),
                  child: Image.network(
                    categoryData!['productImage'],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  buildColorsAndSize() {
    return Row(
      children: [
        // Expanded(
        //   child: DropButton(
        //     hintText: "Color",
        //     item: const ["red", "blue", "white", "black", "pink"],
        //     ratingController: _ratingController,
        //   ),
        // ),
        // Expanded(
        //   child: DropButton(
        //     hintText: "Size",
        //     item: const ["25", "30", "35", "40", "45"],
        //     ratingController: _sizeController,
        //   ),
        // )
      ],
    );
  }

  buildExpensionTileRow(
      {required String firstTitle, required String secTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstTitle,
          // ".\t\tMaterial",
          style: const TextStyle(
            fontSize: 18.60,
          ),
        ),
        Text(
          secTitle,
          // "84%\nylon",
          style: const TextStyle(
            fontSize: 18.60,
          ),
        ),
      ],
    );
  }

  buildExpensionTile() {
    return ExpansionTile(
      title: const Text(
        "Description",
        style: DetailScreenStyles.descriptionTextStyle,
      ),
      children: [
        ListTile(
          title: Wrap(
            children: [
              Text(
                categoryData!['description'],
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  buildExpensionTileRow(
                    firstTitle: '.\t\tMaterial',
                    secTitle: "84%\tnylon",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "16% elastane",
                        style: TextStyle(
                          fontSize: 18.60,
                        ),
                      ),
                    ],
                  ),
                  buildExpensionTileRow(
                    firstTitle: ".\t\tSize",
                    secTitle: "2XS,\tXS, \ts,\tM, \tL",
                  ),
                  buildExpensionTileRow(
                    firstTitle: ".\t\tGender",
                    secTitle: "Woman",
                  ),
                  buildExpensionTileRow(
                    firstTitle: ".\t\tProvince",
                    secTitle: "Balochistan",
                  ),
                  buildExpensionTileRow(
                    firstTitle: ".\t\tCountry",
                    secTitle: "Pakistan",
                  ),
                  MaterialButton(
                    height: 55,
                    elevation: 0,
                    minWidth: double.infinity,
                    color: AppColors.basewhite60Color,
                    onPressed: () {
                      PageRouting.goToNextPage(
                        context: context,
                        navigateTo: const SizeGuideScreen(),
                      );
                    },
                    child: const Text(
                      "Size guide",
                      style: DetailScreenStyles.sizeGuideTextStyle,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  buildAddtoCart() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MaterialButton(
        elevation: 0,
        height: 50,
        color: AppColors.baseDarkGreenColor,
        shape: RoundedRectangleBorder(
            side: BorderSide.none, borderRadius: BorderRadius.circular(5)),
        child: const Text(
          "Add to Cart",
          style: DetailScreenStyles.buttonTextStyle,
        ),
        onPressed: () {
          PageRouting.goToNextPage(
            context: context,
            navigateTo: const PaymentScreen(),
          );
        },
      ),
    );
  }

  buildBottomGridView() {
    return SizedBox(
      height: 240,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              primary: true,
              itemCount: documents.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                var data = documents[index].data() as Map<String, dynamic>;
                return SingleProductWidget(
                  trilling: Container(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          categoryId: documents[index].id,
                        ),
                      ),
                    );
                  },
                  productImage: data['productImage'],
                  productModel: data['productModel'],
                  productName: data['productName'],
                  productOldPrice: data['productOldPrice'],
                  productPrice: data['productPrice'],
                );
              },
            ),
          );
        },
      ),
    );
  }

  buildMayLikeYou() {
    return const ListTile(
      leading: Text(
        "You may also like",
        style: DetailScreenStyles.youmayalsolikeTextStyle,
      ),
      trailing: Text(
        "Show All",
        style: DetailScreenStyles.showAllTextStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (categoryData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: buildAppbar(),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            buildListTile(),
            buildProductImages(),
            buildColorsAndSize(),
            buildAddtoCart(),
            buildExpensionTile(),
            buildMayLikeYou(),
            buildBottomGridView(),
          ],
        ),
      );
    }
  }
}
