import 'package:flutter/material.dart';
import 'package:fortius_hris/common/constant.dart';
import 'package:fortius_hris/service/navigation/navigation_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../app.dart';
import '../../helper/helper.dart';
import '../../locator.dart';
import '../../model/local/boxes.dart';
import '../../model/local/check_in_model.dart';

class CheckInConfirmationViewModel extends ChangeNotifier {
  Position? currentPosition;

  Position? get getCurrentPosition => currentPosition;

  setUserPosition(Position? position) {
    currentPosition = position;
    notifyListeners();
  }

  String currentAddressTitle = "";

  String get getCurrentAddressTitle => currentAddressTitle;

  setCurrentAddressTitle(String address) {
    currentAddressTitle = address;
    notifyListeners();
  }

  String currentFullAddress = "";

  String get getCurrentFullAddress => currentFullAddress;

  setCurrentFullAddressTitle(String address) {
    currentFullAddress = address;
    notifyListeners();
  }

  bool isLoadingGetLocation = true;

  bool get getIsLoadingGetLocation => isLoadingGetLocation;

  setIsLoadingGetLocation(bool flag) {
    isLoadingGetLocation = flag;
    notifyListeners();
  }

  getCurrentLocation() async {
    setIsLoadingGetLocation(true);
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setUserPosition(position);
    getAddressFromLatLng();
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          getCurrentPosition?.latitude ?? 0.0,
          getCurrentPosition?.longitude ?? 0.0,
          localeIdentifier: "id");

      Placemark place = placeMarks[0];
      setCurrentAddressTitle(place.subLocality ?? "");
      setCurrentFullAddressTitle(
          "${place.street}, ${place.subLocality}, ${place.locality} ${place.postalCode}, ${place.country}");
      setIsLoadingGetLocation(false);
    } catch (e) {
      setIsLoadingGetLocation(false);
      setCurrentAddressTitle("-");
      setCurrentFullAddressTitle("-");
    }
  }

  saveCheckInCheckOut(String checkInFilePath) async {
    var boxCheckIn = Boxes.getListCheckIn();
    var listCarts = boxCheckIn.values
        .toList()
        .cast<CheckInModel>()
        .where((element) =>
            element.date == DateUtils.dateOnly(DateTime.now()).toString())
        .toList();

    if (listCarts.isNotEmpty) {
      var tempList = listCarts[0];
      tempList.checkOutTime = DateTime.now().toString();
      tempList.checkOutLocation = getCurrentFullAddress;
      tempList.checkOutPlaceMark = getCurrentAddressTitle;
      tempList.checkOutLatitude = getCurrentPosition?.latitude;
      tempList.checkOutLongitude = getCurrentPosition?.longitude;
      tempList.documentList.add(checkInFilePath);

      Duration diff = DateTime.parse(tempList.checkOutTime ?? "")
          .difference(DateTime.parse(tempList.checkInTime ?? ""));

      int checkInTime = int.parse(Helper.convertDateFormatJustTime(
          tempList.checkInTime ?? "").substring(0,2));
      int checkOutTime = int.parse(Helper.convertDateFormatJustTime(
          tempList.checkOutTime ?? "").substring(0,2));

      if (diff != Duration.zero) {
        int hours = diff.inHours % 24;
        int minutes = diff.inMinutes % 60;
        tempList.durationInHrMin = "$hours hrs $minutes mins";

        if (hours >= 8 && minutes > 0 && checkInTime == 9 && checkOutTime == 6) {
          tempList.status = statusPresent;
        } else if (hours < 8 && checkOutTime < 6) {
          tempList.status = statusEarlyCheckOut;
        } else if (hours >= 8 && checkOutTime > 6) {
          tempList.status = statusOvertime;
        }
      } else {
        tempList.status = statusAbsent;
      }
      tempList.save();

      Navigator.pop(locator<NavigationService>().navigationKey.currentContext!);
    } else {
      var tempData = CheckInModel(documentList: []);
      tempData.date = DateUtils.dateOnly(DateTime.now()).toString();
      tempData.userName = App.getProfile()?.name;
      tempData.companyId = App.getProfile()?.companyId;
      tempData.checkInTime = DateTime.now().toString();
      tempData.checkInLocation = getCurrentFullAddress;
      tempData.checkInPlaceMark = getCurrentAddressTitle;
      tempData.checkInLatitude = getCurrentPosition?.latitude;
      tempData.checkInLongitude = getCurrentPosition?.longitude;
      tempData.documentList.add(checkInFilePath);

      boxCheckIn.add(tempData);
      Navigator.pop(locator<NavigationService>().navigationKey.currentContext!);
    }
  }
}
