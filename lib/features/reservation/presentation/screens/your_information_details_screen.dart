import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../auth/presentation/widgets/labeled_text_field.dart';
import '../../../auth/presentation/widgets/phone_number_field.dart';
import '../widgets/occasion_drop_down_field.dart';

class YourInformationDetailsScreen extends StatefulWidget {
  const YourInformationDetailsScreen({super.key});

  @override
  State<YourInformationDetailsScreen> createState() =>
      _YourInformationDetailsScreenState();
}

class _YourInformationDetailsScreenState
    extends State<YourInformationDetailsScreen> {
  bool isBookingForSomeone = false;
  final _controller = ValueNotifier<bool>(true);
  late TextEditingController nameController;
  late TextEditingController emailController;

  late TextEditingController phoneController;
  String? selectedOccasion = 'Birthday';
  final List<String> occasions = [
    'Birthday',
    'Anniversary',
    'Meeting',
    'Casual',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: "Abdelrahman Shoaib");
    emailController = TextEditingController(text: "Shoaib@gmail.com");
    phoneController = TextEditingController(text: "0.010634103");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mainAppBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 50.h,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_sharp,
              color: AppTheme.colorCode171717,
              size: 24.sp,
            )),
        title: Text(
          'Book a Table',
          style:
              AppTheme.style20BlackBold.copyWith(fontWeight: FontWeight.w700),
        ),
        backgroundColor: AppTheme.mainAppBackgroundColor,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightBrown,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppTheme.codeColorB08A4E),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Booking for someone ?",
                      style: AppTheme.style20BlackBold,
                    ),
                    AdvancedSwitch(
                      controller: _controller,
                      activeColor: const Color(0xFFB38B59),
                      initialValue: true,
                      inactiveColor: AppTheme.colorCodeEAEAEA,
                      width: 50.w,
                      height: 28.h,
                      borderRadius: BorderRadius.circular(24.r),
                      onChanged: (value) {
                        if (value == false) {
                          nameController.clear();
                          phoneController.clear();
                        } else {
                          nameController =
                              TextEditingController(text: "Abdelrahman Shoaib");
                          phoneController =
                              TextEditingController(text: "0.010634103");
                        }
                        setState(() {});
                      },
                      thumb: ValueListenableBuilder<bool>(
                        valueListenable: _controller,
                        builder: (_, value, __) {
                          return Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: AppTheme.codeColor404040,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.1),
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                "Your Information Details",
                style: AppTheme.style20BlackBold.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              LabeledTextField(
                textFieldColor: AppTheme.appGrey2,
                controller: nameController,
                isvalidate: true,
                hint: "yourname",
                label: const Text(
                  "Name",
                  style: AppTheme.style14BoldBlack,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              LabeledTextField(
                enabled: false,
                textFieldColor: AppTheme.appGrey2,
                controller: emailController,
                isvalidate: true,
                hint: "yourname",
                label: const Text(
                  "email",
                  style: AppTheme.style14BoldBlack,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              PhoneNumberField(
                filledColor: AppTheme.appGrey2,
                isPhoneNumberIsValidate: true,
                controller: phoneController,
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  Text(
                    "Occasion",
                    style: AppTheme.style14BoldBlack,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    "(Optional)",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: AppTheme.codeColorA3A3A3),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              OccasionDropDownField(
                occasions: occasions,
                selectedOccasion: selectedOccasion,
                onChange:  ( newValue) {
                  setState(() {
                    selectedOccasion = newValue!;
                  });
                },
              ),
              SizedBox(
                height: 90.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppButton(
                  width: double.infinity,
                  height: defaultButtonHeight,
                  backColor: AppTheme.codeColorB08A4E,
                  text: "Continue",
                  onPress: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
