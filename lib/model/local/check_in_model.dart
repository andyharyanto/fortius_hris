import 'package:hive/hive.dart';

part 'check_in_model.g.dart';

@HiveType(typeId: 0)
class CheckInModel extends HiveObject {
  @HiveField(0)
  String? date;

  @HiveField(1)
  String? userName;

  @HiveField(2)
  String? companyId;

  @HiveField(3)
  String? status;

  @HiveField(4)
  String? durationInHrMin;

  @HiveField(5)
  String? checkInTime;

  @HiveField(6)
  String? checkInLocation;

  @HiveField(7)
  double? checkInLatitude = 0;

  @HiveField(8)
  double? checkInLongitude = 0;

  @HiveField(9)
  String? checkOutTime;

  @HiveField(10)
  String? checkOutLocation;

  @HiveField(11)
  double? checkOutLatitude = 0;

  @HiveField(12)
  double? checkOutLongitude = 0;

  @HiveField(13)
  List<String> documentList;

  @HiveField(14)
  String? checkInPlaceMark;

  @HiveField(15)
  String? checkOutPlaceMark;

  CheckInModel(
      {this.date,
      this.userName,
      this.companyId,
      this.status,
      this.durationInHrMin,
      this.checkInTime,
      this.checkInLatitude,
      this.checkInLongitude,
      this.checkInLocation,
      this.checkOutTime,
      this.checkOutLocation,
      this.checkOutLatitude,
      this.checkOutLongitude,
      required this.documentList,
      this.checkInPlaceMark,
      this.checkOutPlaceMark});
}
