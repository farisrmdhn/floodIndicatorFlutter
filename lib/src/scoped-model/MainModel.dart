// Packages

import 'package:scoped_model/scoped_model.dart';

// Scoped Models
import 'DetectorModel.dart';
import 'InputModel.dart';
import 'UserModel.dart';

class MainModel extends Model with InputModel, DetectorModel, UserModel {
  // Kelas ini hanya buat menyatukan scoped model biar dipanggilnya hanya satu (MainModel)
}