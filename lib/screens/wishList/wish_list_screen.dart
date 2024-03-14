import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../appColors/app_colors.dart';
import '../../routes/routes.dart';
import '../../svgimages/svg_images.dart';
import '../payment/payment_screen.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late String sizeController;
  late String colorsController;
  late String quantityController;
  Widget buildSingleBag(
      String image, String name, String model, int newprice, int oldprice) {
    return Card(
      child: SizedBox(
        height: 140,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(image),
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.baseBlackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            model,
                            style: TextStyle(
                              color: AppColors.baseDarkPinkColor,
                            ),
                          ),
                          Text(
                            newprice.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.baseBlackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            oldprice.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.baseGrey50Color,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.baseGrey30Color,
                        child: Icon(
                          Icons.check,
                          color: AppColors.baseWhiteColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "WishList",
        style: TextStyle(
          color: AppColors.baseBlackColor,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(
            right: 14.0,
            top: 14.0,
          ),
          child: Text(
            "Select",
            style: TextStyle(
              fontSize: 20,
              color: AppColors.baseBlackColor,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 55,
                margin: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    primary: AppColors.baseGrey80Color,
                    onSurface: Colors.grey,
                  ),
                  icon: SvgPicture.asset(
                    SvgImages.delete,
                    color: AppColors.baseWhiteColor,
                    width: 30,
                  ),
                  label: const Text(
                    "Remove",
                    style: TextStyle(
                      fontSize: 25,
                      color: AppColors.baseWhiteColor,
                    ),
                  ),
                  onLongPress: () {},
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 55,
                margin: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    PageRouting.goToNextPage(
                      context: context,
                      navigateTo: const PaymentScreen(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    primary: AppColors.baseDarkPinkColor,
                    onSurface: Colors.grey,
                  ),
                  icon: SvgPicture.asset(
                    SvgImages.shoppingCart,
                    color: AppColors.baseWhiteColor,
                    width: 30,
                  ),
                  label: const Text(
                    "Buy now",
                    style: TextStyle(
                      fontSize: 22,
                      color: AppColors.baseWhiteColor,
                    ),
                  ),
                  onLongPress: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('categories')
              .orderBy('likes', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var data = documents[index].data() as Map<String, dynamic>;
                return ListTile(
                  leading: Image.network(data['productImage']),
                  title: Text(data['productName']),
                  subtitle: Text('Likes: ${data['likes']}'),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DetailScreen(
                    //       categoryId: documents[index].id,
                    //     ),
                    //   ),
                    // );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
