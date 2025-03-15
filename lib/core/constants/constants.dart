//KEYS
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/constants/Assets.dart';
import 'package:flutter_base/core/constants/eunms.dart';
import 'package:flutter_base/core/constants/eunms.dart';
import 'package:flutter_base/core/constants/eunms.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_svg/svg.dart';

import '../../features/home/data/item_selector.dart';

const USER_KEY = 'user_key';
const PHONE_KEY = 'phone';
const EMAIL_KEY = 'email';
const FIRST_NAME_KEY = 'firstName';
const LAST_NAME_KEY = 'lastName';
const PASSWORD_KEY = 'password';
const OTP_TYPE_KEY = 'otpType';

// CONST
const defaultPaddingHorizontal = 16.0;
const defaultButtonRadius = 8.0;
const defaultButtonHeight = 56.0;

const filterPriceStart = 0.0;
const filterPriceEnd = 100.0;

// PADDING
const defaultPaddingForInputFields =
    EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0);

// Arrays
final sortByItems = [
  FilterItemSelector(id: 0, name: "All", type: FilterType.Sort),
  FilterItemSelector(id: 1, name: "Newest", type: FilterType.Sort),
  FilterItemSelector(id: 2, name: "Popular", type: FilterType.Sort),
];

final ratings = [
  FilterItemSelector(
      id: 0, name: "1", image: starIconPath, type: FilterType.Rating),
  FilterItemSelector(
      id: 1, name: "2", image: starIconPath, type: FilterType.Rating),
  FilterItemSelector(
      id: 2, name: "3", image: starIconPath, type: FilterType.Rating),
  FilterItemSelector(
      id: 3, name: "4", image: starIconPath, type: FilterType.Rating),
  FilterItemSelector(
      id: 4, name: "5", image: starIconPath, type: FilterType.Rating),
];
