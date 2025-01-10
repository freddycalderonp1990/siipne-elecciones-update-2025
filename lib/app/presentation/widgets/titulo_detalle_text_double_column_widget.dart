
part of 'custom_app_widgets.dart';


class TituloDetalleTextDoubleColumn extends StatelessWidget {
  final String title1;
  final String title2;
  final String detalle1;
  final String detalle2;
  final String icon1;
  final String icon2;
  final Color colorTexto;

  const TituloDetalleTextDoubleColumn(
      {Key? key,
      required this.title1,
      required this.title2,
      required this.detalle1,
      required this.detalle2,
      required this.icon1,
      required this.icon2,  this.colorTexto=Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: IconTitleDetalleWidget(
              colorTexto: colorTexto,
              todoElAncho: true,
              title: title1,
              nameStringImg: icon1,
              detalle: detalle1),
        ),
        Flexible(
          child: IconTitleDetalleWidget(
              colorTexto: colorTexto,
              todoElAncho: true,
              title: title2,
              nameStringImg: icon2,
              detalle: detalle2),
        ),
      ],
    );
  }


}
