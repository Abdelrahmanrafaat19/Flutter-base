//KEYS
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/constants/Assets.dart';
import 'package:flutter_base/core/constants/eunms.dart';


import '../../features/home/data/models/item_selector.dart';

const USER_KEY = 'user_key';
const REQUEST_PERMISSIS_KEY = 'request_permissions_key';
const USER_LOCATION_KEY = 'user_location_key';
const PHONE_KEY = 'phone';
const BOOKING_ID="bookingID";
const EMAIL_KEY = 'email';
const FIRST_NAME_KEY = 'firstName';
const LAST_NAME_KEY = 'lastName';
const PASSWORD_KEY = 'password';
const OTP_TYPE_KEY = 'otpType';
const LANG_KEY = 'lang';
const TITLE_KEY = 'title';
const CUISINE_ID_KEY = 'cuisineId';
const CATEGORY_ID_KEY = 'categoryId';
const RESTAURANT_ID_KEY = 'restaurantId';
const RESTAURANT_GALLERY_KEY = 'restaurantGallery';

const FILTER_LIST_KEY="filterList";
const SELECT_RANGE_VALUE_KEY="selectRangeValues";
const SELECTED_SORT_BY_ITEM_INDEX_KEY="selectedSortByItemIndex";
const SELECT_RATING_INDEX_KEY="selectedRatingIndex";
const SELECT_CUISINES_INDEX_KEY="selectedCuisinesIndex";
const SELECT_DISTANT_RANGE_VALUES_KEY="selectDistantRangeValues";
const SEARCH_TEXT="searchText";
const String googleApiKey = "AIzaSyAIhooYpv80pRyeAhyNzAyb4YGCmkTUlXA";


/*
* filterList: [],
            selectRangeValues: ,
            selectedSortByItemIndex: ,
            selectedRatingIndex: ,
            selectedCuisinesIndex: ,selectDistantRangeValues: ,*/
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
