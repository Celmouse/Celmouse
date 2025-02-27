import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/utils/result.dart';
import 'package:flutter/material.dart';

class ConnectQrViewmodel extends ChangeNotifier {
  final ConnectionRepository _connectionRepository;

  bool _isConnected = false;
  bool _isLoading = false;
  String? _errorMessage;

  ConnectQrViewmodel({
    required ConnectionRepository connectRepository,
  }) : _connectionRepository = connectRepository;

  bool get isLoading => _isLoading;
  bool get isConnected => _isConnected;
  String? get errorMessage => _errorMessage;

  void connect(String qrCode) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    final result = await _connectionRepository.connect(qrCode);

    switch (result) {
      case Ok():
        {
          _isConnected = true;
        }
      case Error():
        {
          _isConnected = false;

          _errorMessage = 'Failed to connect';
        }
    }

    _isLoading = false;
    notifyListeners();
  }
}
