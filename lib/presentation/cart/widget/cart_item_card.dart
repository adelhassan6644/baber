import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../controller/item_details_provider.dart';
import '../../../data/model/item_model.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../base/custom_network_image.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({required this.onDelete,required this.onDecrease,required this.onIncrease,required this.item,  Key? key}) : super(key: key);
 final void Function() onDelete;
 final void Function() onIncrease;
 final void Function() onDecrease;
 final ItemModel item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT.h),
      child: GestureDetector(
        onTap: (){
          Provider.of<ItemDetailsProvider>(context, listen: false).getItemDetails(id: item.id??"");
          CustomNavigator.push(Routes.ITEM_DETAILS,arguments: item.name??"");
        },
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,vertical: 12.h),
        color: ColorResources.WHITE_COLOR,
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
               item.name ??"",
                maxLines: 2,
                style: AppTextStyles.w700.copyWith(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  children: [
                    Text(
                      "${item.price} ر.س",
                      style: AppTextStyles.w700.copyWith(
                          fontSize: 14,
                          color: ColorResources.PRIMARY_COLOR),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: onIncrease,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color:
                                ColorResources.PRIMARY_COLOR,
                                borderRadius:
                                BorderRadius.circular(10.w)),
                            alignment: Alignment.center,
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: ColorResources.WHITE_COLOR,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.0.w),
                          child: Container(
                            width: 28.w,
                            height: 28.h,
                            decoration: BoxDecoration(
                                color: ColorResources.WHITE_COLOR,
                                border: Border.all(
                                    color: ColorResources
                                        .PRIMARY_COLOR,
                                    width: 0.5.h),
                                borderRadius:
                                BorderRadius.circular(10.w)),
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                "${item.qty}",
                                textAlign: TextAlign.center,
                                style:
                                AppTextStyles.w700.copyWith(
                                  fontSize: 14,
                                  color: ColorResources
                                      .PRIMARY_COLOR,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onDecrease,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color:
                                ColorResources.PRIMARY_COLOR,
                                borderRadius:
                                BorderRadius.circular(10.w)),
                            alignment: Alignment.center,
                            child: const Center(
                              child: Icon(
                                Icons.remove,
                                color: ColorResources.WHITE_COLOR,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
                GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorResources.WHITE_COLOR,
                        borderRadius: BorderRadius.circular(50.w),
                        boxShadow: const [BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, .1),
                              blurRadius: 0.05,
                              spreadRadius: 0.05,
                              offset: Offset(0, 1))],
                        border: Border.all(color: ColorResources.LIGHT_GREY_BORDER)),
                    padding: const EdgeInsets.all(4),
                    child:const Icon(Icons.delete,color: ColorResources.IN_ACTIVE,)
                    // customImageIconSVG(
                    //   imageName: SvgImages.delete,
                    //   width: 24.w,height: 24.h
                    // ),
                  ),
                ),
            ],),
          ),
          SizedBox(width: 24.w,),
          CustomNetworkImage.containerNewWorkImage(
            image:item.image??"",
            height: 70.h,
            width: 70.w,
            fit: BoxFit.cover,
            radius: 8.w,
          ),
        ],),),
      ),
    );
  }
}
