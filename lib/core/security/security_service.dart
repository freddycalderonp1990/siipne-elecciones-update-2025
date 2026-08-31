import 'security_channel.dart';
import 'security_result.dart';

class SecurityService {
  const SecurityService();

  Future<SecurityResult> validate() async {
    final result = await SecurityChannel.validateDevice();
    return SecurityResult.fromMap(result);
  }
}