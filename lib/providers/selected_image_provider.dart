import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageProvider = StateProvider<Uint8List>((ref) => Uint8List(0));
