import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/presentation/base/custom_images.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../domain/localization/language_constant.dart';

class BottomNavBarItem extends StatelessWidget {
final String? imageIcon;
final String? svgIcon;
final VoidCallback onTap;
final bool isSelected;
final String? name;
final double? width;final double? height;

const BottomNavBarItem(
    {super.key, this.imageIcon,this.svgIcon , this.name,this.isSelected = false,
      required this.onTap, this.width=20, this.height=20,});

@override
Widget build(BuildContext context) {
  return InkWell(
    focusColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashColor:Colors.transparent,
    hoverColor: Colors.transparent,
    onTap: onTap,
    child: SizedBox(
      height: 60.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          svgIcon != null?
          customImageIconSVG(
            imageName:svgIcon??"",
            color:isSelected ? ColorResources.PRIMARY_COLOR :ColorResources.DISABLED ,
            width: width,
          ):
          customImageIcon(
            imageName: imageIcon??"",
            height:height,
            color:isSelected ? ColorResources.PRIMARY_COLOR :ColorResources.DISABLED ,
            width: width,
          ),
          name != null?
          Text(name??"",style: TextStyle(
            fontWeight:FontWeight.w500,
            color: isSelected? ColorResources.PRIMARY_COLOR
                :ColorResources.DISABLED,
            fontSize: 10,
          ),):const SizedBox.shrink()
        ],
      ),
    ),
  );
}
}

// class BottomNavBar extends StatelessWidget {
//   final List<String>? listOfImageIcon;
//   final List<String>? listOfSvgIcon;
//   final List<VoidCallback> onTap;
//   final int selectedIndex;
//   final List<String>? name;
//   final double? width, height;
//
//   const BottomNavBar(
//       {super.key, this.listOfImageIcon,this.listOfSvgIcon , this.name,required this.selectedIndex,
//         required this.onTap, this.width=20, this.height=20,});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding:  EdgeInsets.only(bottom: 20.h,right: 25.w,left: 25.w),
//         child: Container(
//             height: 60.h,
//             decoration:BoxDecoration(
//               color: ColorResources.NAV_BAR_BACKGROUND_COLOR,
//               borderRadius: BorderRadius.circular(100),
//               boxShadow: const [
//                 BoxShadow(
//                     color: Color.fromRGBO(0, 0, 0, .1),
//                     blurRadius: 0.5,
//                     spreadRadius:0.75,
//                     offset: Offset(0, 2)
//                 )
//               ],
//             ),
//             child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ...List.generate(onTap.length, (index) =>   Expanded(
//                     child: BottomNavBarItem(
//                       imageIcon: listOfImageIcon != null? listOfImageIcon![index] : null,
//                        svgIcon:listOfSvgIcon != null? listOfSvgIcon![index] : null,
//                       isSelected: selectedIndex ==index ,
//                       onTap: onTap[index],
//                       name:name != null? getTranslated(name![index], context) : null,
//                     ),
//                   ),)
//
//                 ]))
//     );
//   }
// }
