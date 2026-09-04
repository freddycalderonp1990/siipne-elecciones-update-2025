
import 'package:image/image.dart' as img;
import 'package:zxing2/qrcode.dart';

class QrScanner {
 static Future<String?> decodeQRCodeFromFile(img.Image image) async {
try{


    LuminanceSource source = RGBLuminanceSource(
        image.width,
        image.height,
        image
            .convert(numChannels: 4)
            .getBytes(order: img.ChannelOrder.rgba)
            .buffer
            .asInt32List());
    var bitmap = BinaryBitmap(HybridBinarizer(source));

    var reader = QRCodeReader();
    var result = reader.decode(bitmap);
    return result.text;
} catch (e) {
  return null;
}
  }
}
