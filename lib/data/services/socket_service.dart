import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  final IO.Socket socket;

  SocketService({required this.socket});

  void connect() {
    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }

  void addListener(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void removeListener(String event, Function(dynamic) callback) {
    socket.off(event, callback);
  }

  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }
}
