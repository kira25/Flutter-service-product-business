import 'package:service_products_business/global/environment.dart';
import 'package:service_products_business/repository/preferences/preferences_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService {
  PreferencesRepository _preferencesRepository = PreferencesRepository();
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;

  // SocketService() {
  //   this._initConfig();
  // }

  void disconnect() {
    this._socket.disconnect();
  }

  void connect() async {
    final token = await _preferencesRepository.getData('token');
    // Dart client
    //Put 10.0.2.2 or ur IP Address
    _socket = IO.io('${Environment.socketUrl}', {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true //forzar una nueva sesion de conexion al socket
      ,
    });

    //Listen on connect
    _socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      print('Connected');
    });
    //Listen on connecting
    _socket.on('connecting', (_) {
      this._serverStatus = ServerStatus.Connecting;
    });
    //Listen on disconnect
    _socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
    });
    //Listen custom event
    // socket.on('new-message', (payload) {
    //   print('new message :');
    //   print('nombre:${payload['name']}');
    //   print('nombre:${payload['message']}');
    //   print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay');
    //   notifyListeners();
    // });

    // socket.off("new-message");
  }
}
