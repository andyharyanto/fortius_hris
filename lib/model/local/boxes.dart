import 'package:fortius_hris/model/local/check_in_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<CheckInModel> getListCheckIn() =>
      Hive.box<CheckInModel>('Check_In');
}
