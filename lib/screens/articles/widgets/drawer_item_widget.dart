// ignore_for_file: deprecated_member_use
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';

class DrawerItemWidget extends ConsumerWidget {
  const DrawerItemWidget({
    required this.iconName,
    required this.itemColour,
    required this.onTap,
    super.key,
  });

  final Color itemColour;
  final String iconName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 24.0,
          width: 3.0,
          decoration: BoxDecoration(
            color: itemColour,
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),

        //!
        10.0.sizedBoxWidth,

        //!
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: itemColour.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SvgPicture.asset(
            iconName.svg,
            color: AppColours.instance.grey900,
            width: 18.0,
            height: 18.0,
          ),
        ),
      ],
    ).onTap(
      onTap: onTap,
    );
  }
}
