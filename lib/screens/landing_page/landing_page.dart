import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:serti0x_blog_editor/screens/landing_page/footer/footer.dart';
import 'package:serti0x_blog_editor/screens/landing_page/header/header.dart';
import 'package:serti0x_blog_editor/shared/app_colours.dart';
import 'package:serti0x_blog_editor/shared/app_strings.dart';
import 'package:serti0x_blog_editor/utilities/app_extensions.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  static final appStrings = AppStrings.instance;
  static const appColours = AppColours.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Header(),
      ),

      //!
      body: Stack(
        children: [
          //!
          SvgPicture.asset(
            appStrings.verticalLines.svg,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),

          //!
          SvgPicture.asset(
            appStrings.backDrop.svg,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),

          //!
          Column(
            children: [
              12.0.sizedBoxHeight,

              //!
              appStrings.theFuture
                  .txt(
                    context: context,
                    fontSize: 52,
                  )
                  .fadeInFromBottom(
                    delay: const Duration(milliseconds: 400),
                  ),

              12.0.sizedBoxHeight,

              //!
              appStrings.theFutureRider
                  .txt16(
                    context: context,
                  )
                  .fadeInFromBottom(
                    delay: const Duration(milliseconds: 500),
                  ),

              20.0.sizedBoxHeight,

              Expanded(
                child: Material(
                  elevation: 40.0,
                  shadowColor: appColours.grey200.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(
                    32,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 18,
                      left: 21,
                      right: 21,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        32,
                      ),
                    ),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        scrollbars: false,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            6.0.sizedBoxHeight,
                            Image.asset(
                              "productImage".png,
                            ),
                          ],
                        ).alignBottomCenter(),
                      ),
                    ),
                  ),
                ).generalPadding,
              ),

              const Footer()
            ],
          ).alignCenter(),
        ],
      ),
    );
  }
}
