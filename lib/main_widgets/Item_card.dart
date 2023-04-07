import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/svg_images.dart';
import 'package:baber/presentation/base/custom_images.dart';
import 'package:baber/presentation/base/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../app/core/utils/text_styles.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../controller/item_provider.dart';
import '../controller/vednor_prvider.dart';
import '../data/model/item_model.dart';


class ItemCard extends StatefulWidget {
  const ItemCard({Key? key, this.itemModel,this.isVendor=true,this.fromHome=true,})
      : super(key: key);
  final ItemModel? itemModel;
  final bool isVendor;
  final bool fromHome;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(widget.isVendor) {
          Provider.of<VendorProvider>(context, listen: false).getVendorDetails(id: widget.itemModel?.id??0);
          CustomNavigator.push(Routes.VENDOR,);
        }else{
          Provider.of<ItemProvider>(context, listen: false).getItemDetails(id: widget.itemModel?.id??0);
          CustomNavigator.push(Routes.ITEM_DETAILS,);
        }
      },
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical:8.h),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, .1),
                    blurRadius: 0.5,
                    spreadRadius:0.75,
                    offset: Offset(-1, 1)
                )
              ],
              color: ColorResources.WHITE_COLOR,
             ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Card Image
              CustomNetworkImage.containerNewWorkImage(
                  image: widget.itemModel?.image??"",
                  height:widget.fromHome?90.h: 95.h,
                  width:widget.fromHome?130.w: 165.w,
                  fit: BoxFit.cover,
                  edges: true,
                  radius: 8.w,
              ),
              // Text Content
              Padding(
                padding: EdgeInsets.symmetric(horizontal:12.w ,vertical:6.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Meal name
                    Text("${widget.itemModel?.title}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.w700.copyWith(fontSize: 12,)),
                    Text("${widget.itemModel?.address}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.w500.copyWith(fontSize: 12,)),
                  if(!widget.isVendor)  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.itemModel?.price??10} ر.س",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.w500.copyWith(fontSize: 14,color: ColorResources.PRIMARY_COLOR)),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150.w),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, .1),
                                    blurRadius: 0.05,
                                    spreadRadius:0.05,
                                    offset: Offset(0, 1)
                                )
                              ],
                              color: ColorResources.WHITE_COLOR,
                            ),
                            child: customImageIconSVG(imageName: SvgImages.stackCartIcon,width: 28.w,height: 28.h))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemShimmerCard extends StatelessWidget {
  const ItemShimmerCard({Key? key, this.itemModel,this.isVendor=true,this.fromHome=true,})
      : super(key: key);
  final ItemModel? itemModel;
  final bool isVendor;
  final bool fromHome;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical:8.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: ColorResources.WHITE_COLOR,
          ),
        ),
      ),
    );
  }
}
