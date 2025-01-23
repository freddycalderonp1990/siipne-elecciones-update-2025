part of '../custom_app_widgets.dart';

class ComboBusqueda<T> extends StatefulWidget {
  final String title;
  final ValueChanged<T>? complete;
  final List<T> datos;
  final String hint;
  final String searchHint;
  final T? selectValue;
  final IconData? icon;
  final String? imgUrl;
  final bool showClearButton;
  final GlobalKey? openDropDownProgKey;
  final String? textSeleccioneUndato;




  final String? Function(T?)? validator;
  final String Function(T)? displayField; // Callback para determinar qué mostrar
  final void Function(T)? onChanged;





  const ComboBusqueda({
    Key? key,
    this.complete,
    required this.datos,
    this.title = '',
    this.hint = 'Seleccione...',
    required this.searchHint,
    this.selectValue,
    this.icon ,
    this.showClearButton = true,
    this.openDropDownProgKey,
    this.textSeleccioneUndato,
    this.imgUrl, this.validator, this.displayField, this.onChanged,
  }) : super(key: key);

  @override
  _ComboBusquedaState<T> createState() => _ComboBusquedaState<T>();
}

class _ComboBusquedaState<T> extends State<ComboBusqueda<T>> {
  final _userEditTextController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget wgComboBusqueda = DropdownSearch<T>(
      selectedItem: widget.selectValue,

      compareFn: (item, selectedItem) => item == selectedItem,
      validator: (v) => v == null ? "EL ${widget.title} Es requerido" : null,
      key: widget.openDropDownProgKey,
      popupProps: PopupPropsMultiSelection.dialog(
        showSelectedItems: true,


        disableFilter: true,
        itemBuilder: (context, item, isSelected,l) => _customDropDownExample(context, item, isSelected,l),
        showSearchBox: true,
        searchFieldProps: getBusquedaPopup(),
        dialogProps: DialogProps(
          backgroundColor: Colors.white,
          barrierDismissible: true, // Permite cerrar tocando fuera
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Márgenes del diálogo
          actionsAlignment: MainAxisAlignment.end, // Alinea la acción a la derecha
          actionsPadding: EdgeInsets.only(top: 10, right: 10), // Posiciona el botón arriba a la derecha
          actions: [
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red, // Cambia el color a rojo
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        ),


      ),
      itemAsString: (item) {

        // Usa el callback displayField para obtener el texto dinámico
        if (item != null && widget. displayField != null) {

          return widget.displayField!(item);
        }
        return '';
      },

      dropdownBuilder: (context, selectedItem) => _customDropDownExample(context, selectedItem, false,false),
      items: (filter, infiniteScrollProps) =>widget.datos,

      onChanged: (value) {
        if (widget.complete != null) {
          if(value!=null){
            widget.complete!(value);
          }

        }
      },
    );

    return wgComboBusqueda;
  }


  TextFieldProps getBusquedaPopup() {

    return TextFieldProps(
      controller: _userEditTextController,
      decoration: InputDecoration(
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min, // Ajusta el tamaño para evitar expandir
          children: [
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _userEditTextController.clear(); // Limpia el campo de texto
              },
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.red), // Botón "X" para cerrar
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
        labelText: widget.searchHint,
      ),
    );
  }

  Widget _customDropDownExample(BuildContext context, T? item, bool isSelected,bool b) {
    final responsive = ResponsiveUtil();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: (item == null)
          ? ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: getIcon(isNull: true),
        title: Text(
          widget.textSeleccioneUndato ?? "Seleccione un dato",
          style: TextStyle(
              color: Colors.red, fontSize: responsive.diagonalP(1)),
        ),
      )
          : getDesing(
        titulo:widget.displayField!(item) ,
        icon: widget.icon,
        iconUrl: widget.imgUrl,
      ),
    );
  }

  Widget getDesing({
    IconData? icon,
    String titulo = '',
    bool selected = false,
    String? iconUrl,
  }) {
    final responsive = ResponsiveUtil();
    Widget _icon = getIcon(icon: icon);

    return ListTile(
      selected: selected,
      contentPadding: EdgeInsets.all(0),
      leading: _icon,
      title: Text(
        titulo,
        style: TextStyle(fontSize: responsive.diagonalP(1)),
      ),
    );
  }

  getIcon({IconData? icon, bool isNull = false}) {
    if (isNull) {
      return Icon(
        Icons.cancel,
        color: Colors.red,
      );
    }

    return CircleAvatar(
      backgroundColor: isNull ? Colors.red : Colors.transparent,
      child: icon != null
          ? Icon(
        icon,
        color: AppColors.colorBotones,
      )
          : Icon(
        Icons.article_outlined,
        color: AppColors.colorBotones,
      ),
    );
  }
}

