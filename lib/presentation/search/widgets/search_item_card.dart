import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../controller/item_details_provider.dart';
import '../../../controller/vendor_provider.dart';
import '../../../data/model/item_model.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../base/custom_network_image.dart';

class SearchItemCard extends StatelessWidget {
  const SearchItemCard({this.isVendor = true, this.item, Key? key})
      : super(key: key);
  final ItemModel? item;
  final bool isVendor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isVendor) {
          Provider.of<VendorProvider>(context, listen: false)
              .getVendorDetails(id: item!.id ?? "");
          CustomNavigator.push(
            Routes.VENDOR,
          );
        } else {
          Provider.of<ItemDetailsProvider>(context, listen: false)
              .getItemDetails(id: item?.id ?? "");
          CustomNavigator.push(Routes.ITEM_DETAILS,
              arguments: item?.name ?? "");
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 12.h),
        decoration: const BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            border: Border(
                bottom: BorderSide(
                    color: ColorResources.LIGHT_GREY_BORDER, width: 0.5))),
        child: Row(
          children: [
            CustomNetworkImage.containerNewWorkImage(
              image: item?.image ?? "",
              height: 70.h,
              width: 70.w,
              fit: BoxFit.cover,
              radius: 8.w,
            ),
            SizedBox(
              width: 24.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.name ?? "elvnelv",
                    maxLines: 1,
                    style: AppTextStyles.w700.copyWith(
                        fontSize: 14, overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    item?.address ?? "44545",
                    maxLines: 1,
                    style: AppTextStyles.w500.copyWith(
                        color: ColorResources.SUBTITLE,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 24.w,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: ColorResources.HINT_COLOR,
            )
          ],
        ),
      ),
    );
  }
}
