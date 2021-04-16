
import 'package:get/get.dart';
import 'package:service_products_business/global/environment.dart';
import 'package:service_products_business/repository/preferences/preferences_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService  {

  SocketService._privateConstructor();


  static final SocketService _instance = SocketService._privateConstructor();

  factory SocketService() {
    return _instance;
  }

  PreferencesRepository _preferencesRepository = PreferencesRepository();
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;

  var listProducts = [].obs;

  int get listCount => listProducts.length;



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
      'forceNew': true, //forzar una nueva sesion de conexion al socket
      'extraHeaders': {'x-token': token},
    });

    //Listen on connect
    _socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      print('Connected');
    });
    //Listen on connecting
    _socket.on('connecting', (_) {
      this._serverStatus = ServerStatus.Connecting;
      print('connecting');
    });
    //Listen on disconnect
    _socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      print('disconnect');
    });
/*
    _socket.on('order-product', _addOrderProducts);
*/

    socket.off("new-message");
  }

 /* addOrderProducts(dynamic data) async {
    print(data);
    final orderproduct = OrderProductResponse.fromJson(data);
    print(orderproduct);
    _updateListProduct(orderproduct);

    print(orderproduct.product[0].productId);
    final getproductbyid =
    await _productService.getProductById(orderproduct.product[0].productId);
    print(listProducts);

  }

  _updateListProduct(dynamic orderproduct){
    List<OrderProductResponse> temp = [...listProducts];
    temp.add(orderproduct);
    listProducts.assignAll(temp);
  }*/
}
