import 'dart:async';
import 'dart:io';
import 'package:injectable/injectable.dart';

@injectable
class ConnectivityService {
  StreamController<bool>? _connectivityController;
  Timer? _connectivityTimer;
  bool _isConnected = true;

  Stream<bool> get connectivityStream {
    _connectivityController ??= StreamController<bool>.broadcast();
    _startConnectivityCheck();
    return _connectivityController!.stream;
  }

  bool get isConnected => _isConnected;

  void _startConnectivityCheck() {
    _connectivityTimer?.cancel();
    _connectivityTimer = Timer.periodic(
      const Duration(seconds: 5),
          (_) => _checkConnectivity(),
    );
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final wasConnected = _isConnected;

    try {
      final result = await InternetAddress.lookup('google.com');
      _isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      _isConnected = false;
    }

    if (wasConnected != _isConnected) {
      _connectivityController?.add(_isConnected);
    }
  }

  Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  void dispose() {
    _connectivityTimer?.cancel();
    _connectivityController?.close();
  }
}