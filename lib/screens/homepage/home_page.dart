// import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../appColors/app_colors.dart';
import '../../data/home-page-data/home_page_data.dart';
import '../../routes/routes.dart';
import '../../styles/home_screen_styles.dart';
import '../../svgimages/svg_images.dart';
import '../../widgets/show_all_widget.dart';
import '../../widgets/single_product_widget.dart';
import '../detailscreen/detail_screen.dart';
import '../filtter/filterScreen.dart';
import '../tabbar/tabbar_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _userId;
  // This method will return the current user ID
  Future<String> getCurrentUserId() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      _userId = user.uid;
    }
    return _userId!;
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      bottom: const TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: 22),
        indicator: BoxDecoration(
          color: Colors.transparent,
        ),
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelColor: AppColors.baseBlackColor,
        labelColor: AppColors.baseDarkPinkColor,
        tabs: [
          Text("All"),
          Text("Clothing"),
          Text("Shoes"),
          Text("Accessories"),
        ],
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0.0,
      centerTitle: true,
      title: Column(
        children: const [
          Text(
            "Welcome To",
            style: HomeScreenStyles.appBarUpperTitleStyles,
          ),
          Text(
            "Lapify Enterprise",
            style: HomeScreenStyles.appBarBottomTitleStyles,
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            PageRouting.goToNextPage(
              context: context,
              navigateTo: const FilterScreen(),
            );
          },
          icon: RotationTransition(
            turns: const AlwaysStoppedAnimation(90 / 360),
            child: SvgPicture.asset(
              SvgImages.filter,
              color: AppColors.baseBlackColor,
              width: 30,
            ),
          ),
        ),
        IconButton(
          icon: SvgPicture.asset(
            SvgImages.search,
            color: AppColors.baseBlackColor,
            width: 30,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  // Widget buildAdvertismentPlace() {
  Widget buildTrendingProduct({
    required String productImage,
    required String productName,
    required String productModel,
    required double productPrice,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 30, right: 20, bottom: 20),
      height: 65,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Material(
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.network(productImage),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    overflow: TextOverflow.ellipsis,
                    style: HomeScreenStyles.trendingProductNameStyle,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    productModel,
                    style: HomeScreenStyles.trendingProductModelStyle,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: MaterialButton(
              color: AppColors.baseLightPinkColor,
              elevation: 0,
              height: 45,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(0.7),
              ),
              onPressed: () {},
              child: Text(
                "\$ $productPrice",
                style: HomeScreenStyles.trendingProductPriceStyle,
              ),
            ),
          )
        ],
      ),
    );
  }

  final Reference storageRef =
      FirebaseStorage.instance.ref().child('carousel_images');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: buildAppBar(context),
          body: TabBarView(
            children: [
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  // buildAdvertismentPlace(),
                  FutureBuilder<List<String>>(
                    future: _getImageUrls(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return Center(child: Text('No images found.'));
                      } else {
                        return CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 2.5,
                            autoPlay: true,
                          ),
                          items: snapshot.data!.map((imageUrl) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                height: 400,
                                fit: BoxFit.cover,
                                imageUrl: imageUrl,
                                placeholder: (context, url) =>
                                    LinearProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),

                  ShowAllWidget(leftText: "New Arrival"),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('categories')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('categories')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              final List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('categories')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    final List<DocumentSnapshot> documents =
                                        snapshot.data!.docs;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        primary: true,
                                        itemCount: documents.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.7,
                                        ),
                                        itemBuilder: (context, index) {
                                          var data = documents[index].data()
                                              as Map<String, dynamic>;
                                          // var datalike = documents[index].data()
                                          //     as Map<bool, dynamic>;
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              bool isLiked =
                                                  data['likes'] != null &&
                                                      data['likes'].containsKey(
                                                          getCurrentUserId()) &&
                                                      data['likes']
                                                          [getCurrentUserId()];
                                              int likeCount =
                                                  data['likes']?.length ?? 0;
                                              return SingleProductWidget(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailScreen(
                                                        categoryId:
                                                            documents[index].id,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                productImage:
                                                    data['productImage'],
                                                productModel:
                                                    data['productModel'],
                                                productName:
                                                    data['productName'],
                                                productOldPrice:
                                                    data['productOldPrice'],
                                                productPrice:
                                                    data['productPrice'],
                                                trilling: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () async {
                                                        if (isLiked) {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'categories')
                                                              .doc(documents[
                                                                      index]
                                                                  .id)
                                                              .update({
                                                            'likes.${getCurrentUserId()}':
                                                                FieldValue
                                                                    .delete(),
                                                          });
                                                          setState(() {
                                                            isLiked = false;
                                                            likeCount--;
                                                          });
                                                        } else {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'categories')
                                                              .doc(documents[
                                                                      index]
                                                                  .id)
                                                              .update({
                                                            'likes.${getCurrentUserId()}':
                                                                true,
                                                          });
                                                          setState(() {
                                                            isLiked = true;
                                                            likeCount++;
                                                          });
                                                        }
                                                      },
                                                      icon: Icon(
                                                        isLiked
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: isLiked
                                                            ? Colors.red
                                                            : null,
                                                      ),
                                                    ),
                                                    Text('$likeCount'),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    indent: 16,
                    endIndent: 16,
                  ),
                  ShowAllWidget(leftText: "What\'s trending"),
                  buildTrendingProduct(
                    productImage:
                        'https://assets.reebok.com/images/w_600,f_auto,q_auto/cd34290e1b57479399b3aae00137ab00_9366/Classics_Mesh_Tank_Top_White_FJ3179_01_standard.jpg',
                    productModel: 'Tank-tops',
                    productName: 'Classics mesh tank top',
                    productPrice: 15,
                  ),
                  buildTrendingProduct(
                    productImage:
                        'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/d91819a9800047d1bb28ae920142ab44_9366/NMD_R1_Shoes_Red_GX9886_01_standard.jpg',
                    productModel: 'NMD-R1 Shoes',
                    productName: 'Classics Men Shoes',
                    productPrice: 25,
                  ),
                  buildTrendingProduct(
                    productImage:
                        'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/686b5cbb08bb4d21a2b3ad6600d47c18_9366/Ewood_Track_Pants_Blue_GT1818_23_hover_model.jpg',
                    productModel: 'Ewood Track Pants',
                    productName: 'Men Orignals',
                    productPrice: 20,
                  ),
                  ShowAllWidget(
                    leftText: "Your History",
                  ),
                  SizedBox(
                    height: 240,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('categories')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          primary: true,
                          itemCount: documents.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.5,
                          ),
                          itemBuilder: (context, index) {
                            var data =
                                documents[index].data() as Map<String, dynamic>;
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
                        );
                      },
                    ),
                  ),
                ],
              ),
              TabBars(
                productData: clothsData,
              ),
              TabBars(
                productData: shoesData,
              ),
              TabBars(
                productData: accessoriesData,
              ),
            ],
          )),
    );
  }

  Future<List<String>> _getImageUrls() async {
    ListResult result = await storageRef.listAll();
    return Future.wait(
        result.items.map((ref) => ref.getDownloadURL()).toList());
  }
}
