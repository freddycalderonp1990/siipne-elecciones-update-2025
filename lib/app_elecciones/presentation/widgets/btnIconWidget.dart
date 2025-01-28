part of 'customWidgets.dart';

class BtnIconWidget extends StatelessWidget {
  final String titulo;

  final bool select;
  final VoidCallback? onPressed;

  final Color colorTxt;
  final Color colorLineas;
  final IconData? icon;
  final Color colorIcon;
  final Color colorBtn;

  const BtnIconWidget(
      {Key? key,
      this.titulo = '',
      this.select = false,
      required this.onPressed,
      this.colorTxt = Colors.white,
      this.colorLineas = Colors.black,
      this.icon,
      this.colorIcon = Colors.white,
       this.colorBtn=AppColors.colorBotones})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = 10.0;
    final responsive = ResponsiveUtil();
    Widget wg = Container();

    Widget iconWd = icon == null
        ? Container()
        : Icon(
            icon,
            color: colorIcon,
          );

    wg = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: TextButton.icon(
        label: Text(titulo,
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: colorTxt,
                fontSize: responsive.diagonalP(AppConfig.tamTexto))),
        icon: Container(
            height: responsive.diagonalP(AppConfig.tamIcons), child: iconWd),
        style: TextButton.styleFrom(
          backgroundColor: colorBtn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: colorLineas)),
        ),
        onPressed: onPressed,
      ),
    );
    if (select) {
      wg = Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: TextButton.icon(
          label: Text(titulo,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: colorTxt,
                  fontSize: responsive.diagonalP(AppConfig.tamTexto))),
          icon: Container(
            height: responsive.diagonalP(AppConfig.tamIcons + 1),
            child: iconWd,
          ),
          style: TextButton.styleFrom(
            backgroundColor: colorBtn,
            side: BorderSide(width: 2, color: Colors.white),

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(color: colorLineas)),
          ),
          onPressed: onPressed,
        ),
      );
    }

    return wg;

    return Expanded(
      child: wg,
    );
  }
}
