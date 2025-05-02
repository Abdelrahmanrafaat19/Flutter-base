import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/auth/presentation/widgets/countries.dart';
import 'package:flutter_base/features/reservation/data/models/reservation_data_model.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../auth/domain/providers/user_provider.dart';
import '../../../auth/presentation/widgets/labeled_text_field.dart';
import '../../../auth/presentation/widgets/phone_number_field.dart';
import '../providers/use_case_providers.dart';
import '../widgets/occasion_drop_down_field.dart';

String getCountryAlphaCode(String phoneNumber) {
  try {
    var number = PhoneNumber.getCountry(phoneNumber);
    print("This is Phone number ${number.code}");
    return number.code; // Returns 2-letter country code
  } catch (e) {
    print('Error parsing phone number: $e');
    return e.toString();
  }
}

class YourInformationDetailsScreen extends ConsumerStatefulWidget {
  final int guestCount;
  final String dateValue;
  final int restID;

  const YourInformationDetailsScreen(
      {super.key,
      required this.guestCount,
      required this.dateValue,
      required this.restID});

  @override
  ConsumerState<YourInformationDetailsScreen> createState() =>
      _YourInformationDetailsScreenState();
}

class _YourInformationDetailsScreenState
    extends ConsumerState<YourInformationDetailsScreen> {
  bool isBookingForSomeone = false;
  final _controller = ValueNotifier<bool>(true);
  late TextEditingController nameController;
  late TextEditingController emailController;
  late String codeCountry;

  late TextEditingController phoneController;
  String? selectedOccasion;

  final List<String> occasions = [
    'Birthday',
    'Anniversary',
    'Meeting',
    'Casual',
  ];

  @override
  void initState()  {
    final client = ref.read(userProvider.notifier).checkIfUserExist();
    codeCountry =  getCountryAlphaCode("+201063103655");

    nameController =
        TextEditingController(text: "${client?.firstName} ${client?.lastName}");
    emailController = TextEditingController(text: client?.email);
    phoneController = TextEditingController(
        text: formatNumberSync(client?.phoneNumber ?? "",
            removeCountryCodeFromResult: true));
    // WidgetsBinding.instance.addPostFrameCallback((callback) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var reservedRestaurantDataResult =
        ref.watch(createReservationUserRestaurantUseCaseProvider);
    print(
        "this is Date Value ${widget.dateValue}  this time value ${widget.guestCount}");
    return Scaffold(
      backgroundColor: AppTheme.mainAppBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 50.h,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
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
                codeCountry: codeCountry,
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
                onChange: (newValue) {
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
                  onPress: () {
                    print(selectedOccasion);
                    if (selectedOccasion == null) {
                      showValidationToast("please Select your Occasion");
                    } else {
                      ReversationDataModel reversationDateModel =
                          ReversationDataModel(
                        guestCount: widget.guestCount,
                        guestName: nameController.text,
                        guestPhone: phoneController.text,
                        occasion: selectedOccasion,
                        reservationDate: widget.dateValue,
                      );
                      ref
                          .read(createReservationUserRestaurantUseCaseProvider
                              .notifier)
                          .call(
                            restaurantID: widget.restID.toString(),
                            reservationData: reversationDateModel,
                          );
                      if (reservedRestaurantDataResult.state ==
                          DataState.SUCCESS) {
                        context.push(reviewSummeryScreenRoute, extra: {
                          REVERSATION_ID:
                              reservedRestaurantDataResult.data?.id ?? 0,
                          GUESTCOUNT: widget.guestCount
                        });
                      } else if (reservedRestaurantDataResult.state ==
                          DataState.ERROR) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            content: Container(
                              alignment: Alignment.center,
                              width: 100.w,
                              height: 100.h,
                              child: Text(
                                reservedRestaurantDataResult.message ?? "",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp),
                              ),
                            ),
                          ),
                        );
                      } else if (reservedRestaurantDataResult.state ==
                          DataState.LOADING) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            content: Container(
                              alignment: Alignment.center,
                              width: 100.w,
                              height: 100.h,
                              child: const CircularProgressIndicator(
                                color: AppTheme.codeColorB08A4E,
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showValidationToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
