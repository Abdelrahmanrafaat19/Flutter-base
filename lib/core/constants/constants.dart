
//KEYS
import 'package:flutter/cupertino.dart';

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
const defaultPaddingForInputFields = EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0);


// Arrays
final sortByItems = [
  ItemSelector(
    id: 0,
    name: "All",
  ),
  ItemSelector(
    id: 1,
    name: "Newest",
  ),
  ItemSelector(
    id: 2,
    name: "Popular",
  ),
];

final ratings = [
  ItemSelector(
    id: 0,
    name: "1",
  ),
  ItemSelector(
    id: 1,
    name: "2",
  ),
  ItemSelector(
    id: 2,
    name: "3",
  ),
  ItemSelector(
    id: 3,
    name: "4",
  ),
  ItemSelector(
    id: 4,
    name: "5",
  ),
];

