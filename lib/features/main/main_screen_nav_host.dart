import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/Assets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../home/persentaion/home_screen.dart';
import '../reservation/presentation/screens/booking_table_screen.dart';
import '../reservation/presentation/screens/my_booking_screen.dart';

class MainScreenNavHost extends ConsumerStatefulWidget {

  const MainScreenNavHost({super.key});

  @override
  ConsumerState<MainScreenNavHost> createState() => MainScreenNavHostState();
}

class MainScreenNavHostState extends ConsumerState<MainScreenNavHost> with TickerProviderStateMixin {
  double horizontalPadding = 30.0;
  double horizontalMargin = 0.0;
  int noOfIcons = 4;

  List<Map<String, dynamic>> items = [
    {"icon": homeIconPath, "label": "Home"},
    {"icon": calendarIconPath, "label": "Booking"},
    {"icon": orderIconPath, "label": "Orders"},
    {"icon": profileIconPath, "label": "Profile"},
  ];

  List<Widget> screens = [
    HomeScreen(),
    BookTableScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  late double position;
  int selected = 0;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 375));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    animation = Tween(
        begin: getEndPosition(0),
        end: getEndPosition(0))
        .animate(controller);
    position = getEndPosition(0);
    super.didChangeDependencies();
  }

  double getEndPosition(int index) {
    double totalMargin = 2 * horizontalMargin;
    double totalPadding = 2 * horizontalPadding;
    double valueToOmit = totalMargin + totalPadding;

     var position = (((MediaQuery.of(context).size.width - valueToOmit) / noOfIcons) *
        index +
        horizontalPadding) +
         (((MediaQuery.of(context).size.width - valueToOmit) / noOfIcons) / 2) - 70;

    return position;
  }

  void animateDrop(int index) {
    animation = Tween(
        begin: position,
        end: getEndPosition(index))
        .animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    controller.forward().then((value) {
      position = getEndPosition(index);
      controller.dispose();
      controller = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 575));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 575),
              child: screens[selected],
            ),
          ),
          Positioned(
            bottom: horizontalMargin,
            left: horizontalMargin,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: AppBarPainter(animation.value,isRTL),
                  size: Size(
                      MediaQuery.of(context).size.width - (2 * horizontalMargin),
                      80.0),
                  child: SizedBox(
                    height: 120.0, // Increased height to accommodate text
                    width: MediaQuery.of(context).size.width - (2 * horizontalMargin),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: items.map<Widget>((item) {
                          int index = items.indexOf(item);
                          return Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  animateDrop(index);
                                  selected = index;
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 375),
                                    curve: Curves.easeOut,
                                    height: 60, // Reduced height for better alignment
                                    width: 50,
                                    alignment: selected == index
                                        ? Alignment.topCenter
                                        : Alignment.bottomCenter,
                                    child: SvgPicture.asset(
                                      item["icon"],
                                      key: ValueKey(item["icon"]),
                                      width: 30.0,
                                      color: selected == index
                                          ? Colors.white
                                          : AppTheme.appGrey7,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsetsDirectional.symmetric(vertical: 8.0),
                                    child: Text(
                                      item["label"],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: selected == index
                                            ? AppTheme.mainAppColor
                                            : AppTheme.appGrey7,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarPainter extends CustomPainter {
  double x;
  bool isRTL;

  AppBarPainter(this.x, this.isRTL);

  double start = 45.0;
  double end = 120;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var circlePaint = Paint()
      ..color = AppTheme.mainAppColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0.0, start);

    double xOffset = isRTL ? size.width - x - 140 : x;

    /// DROP paths, included X for animation
    path.lineTo((xOffset) < 20.0 ? 20.0 : xOffset, start);
    path.quadraticBezierTo(25.0 + xOffset, start, 42.0 + xOffset, start + 23.0);
    path.quadraticBezierTo(55.0 + xOffset, start + 35.0, 70.0 + xOffset, start + 35.0);
    path.quadraticBezierTo(90.0 + xOffset, start + 35.0, 105.0 + xOffset, start + 12.0);
    path.quadraticBezierTo(
        115.0 + xOffset,
        start,
        (140.0 + xOffset) > (size.width - 20.0) ? (size.width - 20.0) : 135 + xOffset,
        start);
    path.lineTo(size.width - 20.0, start);

    /// Box with BorderRadius
    path.quadraticBezierTo(size.width, start, size.width, start );
    path.lineTo(size.width, end - 25.0);
    path.quadraticBezierTo(size.width, end, size.width, end);
    path.lineTo(25.0, end);
    path.quadraticBezierTo(0.0, end, 0.0, end );
    path.lineTo(0.0, start );
    path.quadraticBezierTo(0.0, start, 20.0, start);
    path.close();

    canvas.drawPath(path, paint);

    /// Circle to show at the top of the drop
    canvas.drawCircle(Offset(xOffset + 70.0, 45.0), 26.0, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
// class AppBarTrailing extends StatelessWidget {
//   final int currentTab;
//   const AppBarTrailing({super.key, required this.currentTab});
//
//   @override
//   Widget build(BuildContext context) {
//     if (currentTab == 0) {
//       return Padding(
//           padding:
//               const EdgeInsets.symmetric(horizontal: defaultPaddingHorizontal),
//           child: Row(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SVGIcons.smallLocationIcon(),
//                   SizedBox(
//                     width: 4,
//                   ),
//                   Text(
//                     "Riyadh",
//                     style: AppTheme
//                         .styleWithTextAppMainAppColor15AdelleSansExtendedFonts14w400,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 width: 12,
//               ),
//               SizedBox(
//                 height: 24,
//                 child: Stack(children: [
//                   Align(
//                       alignment: AlignmentDirectional.center,
//                       child: SVGIcons.notificationSvgIcon()),
//                   Positioned(
//                     right: 4,
//                     top: 1,
//                     child: Container(
//                       height: 6,
//                       width: 6,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle, color: AppTheme.mainAppColor),
//                     ),
//                   )
//                 ]),
//               )
//             ],
//           ));
//     }
//     return const SizedBox();
//   }
// }
