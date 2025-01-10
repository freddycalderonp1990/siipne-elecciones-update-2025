part of 'custom_app_widgets.dart';

class BtnAtrasWidget extends StatelessWidget {
  final VoidCallback?  pantallaIrAtras;


  const BtnAtrasWidget({Key? key, this.pantallaIrAtras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    // TODO: implement build
    return  Positioned(
        left: responsive.isVertical()
            ? responsive.altoP(1)
            : responsive.anchoP(1),
        top: responsive.isVertical()
            ? responsive.altoP(1)
            : responsive.anchoP(2),
        child: SafeArea(
          child: CupertinoButton(
            minSize: responsive.isVertical()
                ? responsive.altoP(5)
                : responsive.anchoP(5),
            padding: EdgeInsets.all(3),
            borderRadius: BorderRadius.circular(30),
            color: Colors.black26,
            onPressed:pantallaIrAtras == null? () =>
                    Get.back()
                :
                pantallaIrAtras,
            //volver atras
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: responsive.isVertical()
                  ? responsive.altoP(3)
                  : responsive.anchoP(3),
            ),
          ),
        ));
  }
}
