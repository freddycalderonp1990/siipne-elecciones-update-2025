part of 'custom_app_widgets.dart';



class TituloDetalleTextWidget extends StatelessWidget {

  final String title;
  final String detalle;
  final  Color color ;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;


  TituloDetalleTextWidget({required this.title, required this.detalle, this.color=Colors.white, this.margin, this.padding});
  @override
  Widget build(BuildContext context) {


    final responsive = ResponsiveUtil();
    return Container(
        margin: margin==null? EdgeInsets.all(2):margin,
        padding:padding==null? EdgeInsets.all(2):padding,
        decoration: BoxDecoration(
            color:color,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: AppColors.colorBordecajas, blurRadius: 0.5)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title ,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                    responsive.diagonalP(AppConfig.tamTexto ))),
            SizedBox(
              width: responsive.altoP(1),
            ),
            Flexible(
              child: Text(detalle,
                  style: TextStyle(
                      fontSize: responsive
                          .diagonalP(AppConfig.tamTexto ))),
            ),
          ],
        ));


  }
}


