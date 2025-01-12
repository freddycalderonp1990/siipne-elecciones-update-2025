
part of 'customWidgets.dart';

class BtnMenuWidget  extends StatefulWidget {

  final img;
  final String? title;
  final String? descripcion;
  final GestureTapCallback? onTap;
  final bool horizontal;
  final Color colorTexto;
  final Color colorFondo;


  const BtnMenuWidget( {this.img=null,this.title='',this.descripcion='', this.onTap, this.horizontal=true,this.colorTexto=Colors.black, this.colorFondo=Colors.white}) ;

  @override
  _BtnMenuWidgetState createState() => _BtnMenuWidgetState();
}



class _BtnMenuWidgetState extends State<BtnMenuWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final responsive = ResponsiveUtil();



    Widget horizontal= Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(
                color: AppColors.colorBordecajas,
                blurRadius: AppConfig.sobraBordecajas)
          ]),
      child: Material(
        color:widget. colorFondo!=null?widget. colorFondo: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap:widget.onTap,
          // handle your onTap here
          child: Container(


            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            margin:
            EdgeInsets.only(left: 5.0, right: 5.0),
            width: responsive.anchoP(42),



            child: Container(
              height: responsive.altoP(25),

              child: SingleChildScrollView(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: responsive.altoP(1),),
                  Container(
                    width: responsive.anchoP(15),
                    height: responsive.anchoP(15),
                    child: widget.img!=null? Image.asset(
                      widget.img,
                    ):Image.asset(
                      AppImages.iconNoImg,
                    ),
                  ),



                  Text(
                    widget.title!,
                    textAlign: TextAlign.center,

                    style:TextStyle(
                        color: widget.colorTexto!=null? widget.colorTexto:Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive
                            .diagonalP(AppConfig.tamTexto)),
                  ),

                  Text(
                    widget.descripcion!,
                    textAlign: TextAlign.justify,

                    style:TextStyle(
                        color: widget.colorTexto!=null? widget.colorTexto:Colors.black87,

                        fontSize: responsive
                            .anchoP(AppConfig.tamTexto)),
                  ),

                  SizedBox(
                    height: responsive.altoP(1),
                  ),

                ],
              ),),),
          ),
        ),
      ),
    );



    Widget vertical= Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(
                color: AppColors.colorBordecajas,
                blurRadius: AppConfig.sobraBordecajas)
          ]),
      child: Material(
        shadowColor: widget. colorFondo!=null?widget. colorFondo:Colors.white,
        color:widget. colorFondo!=null?widget. colorFondo:Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap:widget.onTap,
          // handle your onTap here
          child: Container(

            margin:
            EdgeInsets.only(left: 20.0, right: 20.0,bottom: 10.0,top: 10),
            width: responsive.anchoP(70),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(18),
                  height: responsive.anchoP(18),
                  child: widget.img!=null? Image.asset(
                    widget.img,
                  ):Image.asset(
                    AppImages.iconNoImg,
                  ),
                ),
                SizedBox(
                  width: responsive.altoP(1),
                ),
                Container(
                    child: Text(
                      widget.title!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: widget.colorTexto!=null? widget.colorTexto:Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive
                              .diagonalP(AppConfig.tamTexto)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
    return  widget.horizontal?horizontal :vertical;







  }

}