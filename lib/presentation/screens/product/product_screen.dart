// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_assignment/app/config/app_space.dart';
import 'package:task_assignment/app/config/app_text_styles.dart';
import 'package:task_assignment/app/config/asset_strings.dart';
import 'package:task_assignment/data/models/product_response.dart';
import 'package:task_assignment/presentation/controllers/product_controller.dart';
import 'package:task_assignment/presentation/widgets/base_action_button.dart';
import 'package:task_assignment/presentation/widgets/loader_widget.dart';

import '../../../app/config/app_colors.dart';
import '../../widgets/apply_and_cancle_button.dart';
import 'product_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<String> filterText = ['Newest', 'Oldest', 'Price low > High', 'Price high > Low', 'Best selling'];
  String? selectedRadio;
  List<String> selectString = [];
  late ScrollController _scrollController;
final _productController = Get.put(ProductController());
  @override
  void initState() {
    _scrollController = ScrollController();
    animationController =
        AnimationController(vsync: this, duration: Durations.long3, animationBehavior: AnimationBehavior.normal, reverseDuration: Durations.long3);

WidgetsBinding.instance.addPostFrameCallback((_){
  _productController.getResponse();
});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.scaffoldColor,
        title: Text(
          'ProductScreen',
          style: AppTextStyles.appBarTitle(color: AppColors.appbarTitleColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 25,
            onPressed: () {},
            icon: Center(
              child: SvgPicture.asset(
                'assets/icon/ic_search.svg',
                colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: buildFilterAndSortWidget(context),
        ),
      ),
      body: Obx(
    () {
          return (_productController.productList !=null && _productController.productList.isNotEmpty)? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 290,
              ),
              itemCount: _productController.productList.length,
              itemBuilder: (context, index) {
                final Product product = _productController.productList[index];
                return ProductWidget(product:product);
              },
            ),
          ) : loaderWidget();
        }
      ),
    );
  }

  buildFilterAndSortWidget(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: const Color(0xff395AB8).withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                width: 70,
                child: IconButton(
                    splashRadius: 40.0,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      log('Filter pressed');
                      _bottomFilterSheet(context);
                    },
                    icon: Row(
                      children: [
                        SvgPicture.asset(
                          AssetStrings.icfilter,
                          fit: BoxFit.cover,
                          height: 16,
                          width: 15,
                        ),
                        SpaceHepler.horizontalSmall,
                        Text(
                          'Filter',
                          style: AppTextStyles.disableText(color: null),
                        )
                      ],
                    )),
              ),
              Spacer(),
              SizedBox(
                width: 75,
                child: IconButton(
                    splashRadius: 40.0,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      log('Filter pressed');
                    },
                    icon: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sort by',
                          style: AppTextStyles.disableText(color: null),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.disableTextColor,
                          size: 25,
                        )
                      ],
                    )),
              ),
              SpaceHepler.horizontalSmall,
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AssetStrings.icDrawer),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _bottomFilterSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        transitionAnimationController: animationController,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 450),
              child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      SpaceHepler.verticalMedium,
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(color: const Color(0xFFFFD3DD), borderRadius: BorderRadius.circular(50)),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SpaceHepler.verticalMedium,
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: filterText.length,
                                itemBuilder: (context, index) {
                                  return Theme(
                                    data: ThemeData(checkboxTheme: const CheckboxThemeData(side: BorderSide(color: Colors.red, width: 2))),
                                    child: CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      activeColor: AppColors.checkBoxActive,
                                      checkboxShape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          side: BorderSide(color: AppColors.checkBoxActive, width: 1.5)),
                                      contentPadding: EdgeInsets.zero,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      title: Text(
                                        filterText[index],
                                        style: AppTextStyles.disableText(color: Colors.black),
                                      ),
                                      value: selectString.contains(filterText[index]),
                                      onChanged: (value) {
                                        if (selectString.contains(filterText[index])) {
                                          selectString.remove(filterText[index]); // unselect
                                        } else {
                                          selectString.add(filterText[index]); // select
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SpaceHepler.verticalSpace(2);
                                },
                              ),
                              SpaceHepler.verticalMedium,
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ApplyAndCancleButton(
                                  onCancle: () {
                                    Get.back();
                                  },
                                  onApply: () {
                                    _productController.sortProductList('price low to heigh');
                                       Get.back();
                                  },
                                ),
                              ),
                              SpaceHepler.verticalMedium,
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          });
        }).then(
      (value) {
        // selectString.clear();
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.index});
  final int index;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


@override
  void initState() {
 
    
    
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Image.network('https://mobileapp.getdokan.com/wp-content/uploads/2021/09/wecare.png')
        ],),
      ),
    );
  }
}
