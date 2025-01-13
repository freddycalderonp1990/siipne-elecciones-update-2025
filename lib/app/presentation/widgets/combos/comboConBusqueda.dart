part of '../custom_app_widgets.dart';

class ComboConBusqueda extends StatefulWidget {
  final String title;
  final ValueChanged<String>? complete;
  final List<String> datos;
  final String hint;
  final String searchHint;
  final String? selectValue;
  final String imgString;
  final String? imgUrl;
  final bool showClearButton;
  final openDropDownProgKey;
  final String? textSeleccioneUndato;

  const ComboConBusqueda(
      {Key? key,
      this.complete,
      required this.datos,
      this.title = '',
      this.hint = 'Seleccione...',
      required this.searchHint,
      this.selectValue,
      this.imgString = '',
      this.showClearButton = true,
      this.openDropDownProgKey,
      this.textSeleccioneUndato,
      this.imgUrl})
      : super(key: key);

  @override
  _ComboConBusquedaState createState() => _ComboConBusquedaState();
}

class _ComboConBusquedaState extends State<ComboConBusqueda> {
  final _userEditTextController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget wgComboBusqueda = DropdownSearch<String>(
      selectedItem: widget.selectValue,
      compareFn: (item, selectedItem) => item == selectedItem,
      validator: (v) => v == null ? "EL ${widget.title} Es requerido" : null,
      key: widget.openDropDownProgKey,

      popupProps: PopupPropsMultiSelection.modalBottomSheet(
        showSelectedItems: true,
        disableFilter: true,
        itemBuilder: _customDropDownExample,
        showSearchBox: true,
        searchFieldProps: getBusquedaPopup(),
      ),

      dropdownBuilder:(context, selectedItem) => _customDropDownExample(context,selectedItem,false,false),
      //popupItemBuilder: _customPopupItem,
      // mode: Mode.DIALOG,
      items: (filter, infiniteScrollProps) => widget.datos,

      onChanged: (value) {
        if (widget.complete != null) {
          widget.complete!(value != null ? value : '');
        }
      },
    );

    return wgComboBusqueda;
  }

  getBusquedaPopup() {
    return TextFieldProps(
      controller: _userEditTextController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            _userEditTextController.clear();
          },
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
        labelText: widget.searchHint,
      ),
    );
  }

  getDesingPopup() {
    final responsive = ResponsiveUtil();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorBotones,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConfig.radioBordecajas),
          topRight: Radius.circular(AppConfig.radioBordecajas),
        ),
      ),
      child: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: responsive.diagonalP(3),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  getIcon({String iconString = '', bool isNull = false}) {
    if (isNull) {
      return Icon(
        Icons.cancel,
        color: Colors.red,
      );
    }

    return CircleAvatar(
      backgroundColor: isNull ? Colors.red : Colors.transparent,
      child: iconString != ''
          ? Image.asset(iconString)
          : Icon(
              Icons.article_outlined,
              color: AppColors.colorBotones,
            ),
      // this does not work - throws 404 error
      // backgroundImage: NetworkImage(item.avatar ?? ''),
    );
  }

  Widget getDesing(
      {String iconString = '',
      String titulo = '',
      bool selected = false,
      String? iconUrl}) {
    final responsive = ResponsiveUtil();

    Widget icon = getIcon(iconString: iconString);
    if (iconUrl != null) {
      icon = Container(
        height: 32,
        width: 32,
        child: Container(color: Colors.red,),
      );
    }

    return ListTile(
      selected: selected,
      contentPadding: EdgeInsets.all(0),
      leading: icon,
      title: Text(
        titulo,
        style: TextStyle(fontSize: responsive.diagonalP(1.5)),
      ),
    );
  }

  //Diseño cuando el combo se muestra
  Widget _customDropDownExample(
      BuildContext context, String? item,bool isSelected,bool b) {



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
                widget.textSeleccioneUndato == null
                    ? "Seleccione un dato"
                    : widget.textSeleccioneUndato!,
                style: TextStyle(
                    color: Colors.red, fontSize: responsive.diagonalP(1.5)),
              ),
            )
          : getDesing(
              titulo: item,
              iconString: widget.imgString,
              iconUrl: widget.imgUrl),
    );
  }

  Widget _customPopupItem(BuildContext context, String? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: getDesing(
          titulo: item!,
          selected: isSelected,
          iconString: widget.imgString,
          iconUrl: widget.imgUrl),
    );
  }

  List<DropdownMenuItem> setDatos(
      List<String> datos, ResponsiveUtil responsive) {
    List<DropdownMenuItem> items = [];

    for (int i = 0; i < datos.length; i++) {
      String valor = datos[i];
      if (valor != null) {
        items.add(DropdownMenuItem(
          child: DesingDatos(
            valor: valor,
          ),
          value: valor,
        ));
      }
    }

    return items;
  }
}

class DesingDatos extends StatelessWidget {
  final String valor;

  const DesingDatos({Key? key, required this.valor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: AppColors.colorBordecajas, blurRadius: 1)
            ]),
        child: Text(
          valor,
          style: TextStyle(
            fontSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            color: Colors.black,
          ),
        ));
  }
}

class SearchHintDesing extends StatelessWidget {
  final String valor;

  const SearchHintDesing({Key? key, required this.valor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    return Expanded(
      child: Text(valor,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            color: Colors.black,
          )),
    );
  }
}
