import 'package:controller/src/data/services/client_api_service.dart';
import 'package:protocol/protocol.dart';

class KeyboardRepository {
  final ClientApiService _clientApiService;

  KeyboardRepository({
    required ClientApiService clientApiService,
  }) : _clientApiService = clientApiService;

  void type(String text) {
    _clientApiService.send(
      event: ProtocolEvent.keyPressed,
      data: text,
    );
  }

  void pressSpecialKey(SpecialKeyType type) {
    _clientApiService.send(
      event: ProtocolEvent.specialKeyPressed,
      data: KeyboardProtocolData(
        key: type,
      ),
    );
  }
  
  void releaseSpecialKey(SpecialKeyType type) {
    _clientApiService.send(
      event: ProtocolEvent.specialKeyReleased,
      data: KeyboardProtocolData(
        key: type,
      ),
    );
  }
}
