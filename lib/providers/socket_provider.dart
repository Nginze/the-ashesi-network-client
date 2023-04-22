import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/services/socket_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final socketProvider = StateProvider<SocketService>((ref) {
  final socketService = SocketService(socket: IO.io('http://localhost:5000'));
  socketService.connect();
  return socketService;
});
