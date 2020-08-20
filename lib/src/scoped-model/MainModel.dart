// Packages
import 'package:scoped_model/scoped_model.dart';

// Scoped Models
import 'DetectorModel.dart';
import 'InputModel.dart';

class MainModel extends Model with InputModel, DetectorModel {
  // Kelas ini hanya buat menyatukan scoped model biar dipanggilnya hanya satu (MainModel)
}