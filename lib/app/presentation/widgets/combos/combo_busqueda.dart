part of '../custom_app_widgets.dart';

class ComboBusqueda<T> extends StatefulWidget {
  final String title;
  final ValueChanged<T>? complete;
  final List<T> datos;
  final String hint;
  final String searchHint;
  final T? selectValue;
  final String imgString;
  final String? imgUrl;
  final bool showClearButton;
  final openDropDownProgKey;
  final String? textSeleccioneUndato;

  const ComboBusqueda({
    Key? key,
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
    this.imgUrl,
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

      popupProps: PopupPropsMultiSelection.modalBottomSheet(
        showSelectedItems: true,
        disableFilter: true,
        itemBuilder: (context, item, isSelected,l) => _customDropDownExample(context, item, isSelected,l),
        showSearchBox: true,
        searchFieldProps: getBusquedaPopup(),
      ),

      dropdownBuilder: (context, selectedItem) => _customDropDownExample(context, selectedItem, false,false),
      items: (filter, infiniteScrollProps) => widget.datos,

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
              color: Colors.red, fontSize: responsive.diagonalP(1.5)),
        ),
      )
          : getDesing(
        titulo: item.toString(),
        iconString: widget.imgString,
        iconUrl: widget.imgUrl,
      ),
    );
  }

  Widget getDesing({
    String iconString = '',
    String titulo = '',
    bool selected = false,
    String? iconUrl,
  }) {
    final responsive = ResponsiveUtil();
    Widget icon = getIcon(iconString: iconString);

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
    );
  }
}

