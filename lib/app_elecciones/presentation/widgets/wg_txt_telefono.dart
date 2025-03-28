part of 'customWidgets.dart';
class WgTxtTelefono extends StatelessWidget {

  final GlobalKey<FormState>? formKey;
  final TextEditingController controllerTelefono;
  const WgTxtTelefono({super.key,  this.formKey, required this.controllerTelefono});

  @override
  Widget build(BuildContext context) {
    final responsive=ResponsiveUtil();

    Widget imput=ImputTextWidget(
      maxLength: 10,
      keyboardType: TextInputType.number,
      controller:controllerTelefono,
      icono: Icon(
        Icons.phone_android,
        color: AppColors.colorIcons,
      ),
      label: "Teléfono",
      fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
      validar: Validate.validateTelefono,
    );


    if(formKey==null){
      return imput;
    }
    return Form(
      key: formKey,
      child: imput,
    );
  }
}
