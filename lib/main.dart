import 'package:flutter/material.dart';
import 'package:qxs/app.dart';
import 'package:qxs/utils/common.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) => runApp(new App()));
}
