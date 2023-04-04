import 'package:baber/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/text_styles.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<dynamic> items;
  final Widget? icon;
  final String? pIcon;
  final Color? pIconColor;
  final double iconSize;
  final String? label;
  final String name;
  final String? value;
  final void Function(Object?)? onChange;
  final String? Function(Object?)? validation;

  const CustomDropDownButton({
    required this.items,
    this.value,
    this.pIcon,
    this.pIconColor,
    this.onChange,
    this.validation,
    this.icon,
    this.label,
    required this.name,
    this.iconSize = 25,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: FormBuilderDropdown(
        items: widget.items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style:  AppTextStyles.w500.copyWith(
                  color: ColorResources.HINT_COLOR,
                  fontSize: 11
              ),
            ),
          );
        }).toList(),
        onChanged: widget.onChange,
        initialValue: widget.value,
        isDense: true,
        validator: widget.validation,
        isExpanded: true,
        dropdownColor: ColorResources.FILL_COLOR,
        itemHeight: 50,
        icon: widget.icon ?? const Icon(Icons.arrow_drop_down,color:ColorResources.HINT_COLOR,),
        iconSize: widget.iconSize,
        hint: Row(
          children: [
            if( widget.pIcon != null )  Image.asset(
              widget.pIcon!,
              height: 20.w,
              width: 20.w,
              color: widget.pIconColor,
            ),
            SizedBox(width: 15.w,),
            Text(
              widget.name,
              style: AppTextStyles.w500.copyWith(
                  color: ColorResources.HINT_COLOR,
                  fontSize: 11
              ),
            ),
          ],
        ),
        borderRadius:   BorderRadius.all(
            Radius.circular(12.w)),
        decoration: InputDecoration(
          fillColor: ColorResources.FILL_COLOR,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.DISABLED,
                  width: 0
              )) ,
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0
              )),
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.DISABLED,
                  width: 0
              )),
          focusedErrorBorder:const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.FAILED_COLOR,
                  width: 0.5
              )),
          errorBorder:const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.FAILED_COLOR,
                  width: 0.5
              )),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0
              )),
          labelText: widget.label,
          errorStyle: AppTextStyles.w500.copyWith(
              color: ColorResources.FAILED_COLOR,
              fontSize: 11
          ),
          labelStyle: AppTextStyles.w500.copyWith(
              color: ColorResources.HINT_COLOR,
              fontSize: 11
          ),
        ),
        name: widget.name,
      ),
    );
  }
}