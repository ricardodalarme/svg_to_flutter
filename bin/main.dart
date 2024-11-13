import 'dart:io';

import 'package:svg_to_flutter/svg_to_flutter.dart';

void main(List<String> arguments) async {
  exit(await SvgToFlutterCommandRunner().run(arguments));
}
