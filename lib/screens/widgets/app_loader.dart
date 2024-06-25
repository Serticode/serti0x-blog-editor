import 'package:flutter/cupertino.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({
    super.key,
    this.height,
    this.duration,
  });
  final double? height;
  final int? duration;

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration ?? 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: RotationTransition(
            turns: _animationController,
            child: CupertinoActivityIndicator(
              color: AppColours.instance.grey700,
              radius: 15.0,
            ),
          ),
        );
      },
    );
  }
}
