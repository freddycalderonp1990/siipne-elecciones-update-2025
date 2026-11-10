import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../app/core/values/app_colors.dart';
import '../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../data/models/models.dart';

class ComboBusquedaRecintos<T> extends StatefulWidget {
  final VoidCallback? onNoEncuentroRecinto;
  final String title;
  final ValueChanged<T?>? complete;
  final List<T> datos;
  final String hint;
  final String searchHint;
  final T? selectValue;
  final IconData? icon;
  final String? imgUrl;
  final bool showClearButton;
  final bool showNoEncuentroRecinto;
  final GlobalKey? openDropDownProgKey;
  final String? textSeleccioneUndato;
  final String? Function(T?)? validator;
  final String Function(T)? displayField;
  final void Function(T)? onChanged;

  const ComboBusquedaRecintos({
    Key? key,
    this.complete,
    required this.datos,
    this.title='',
    this.hint='Seleccione...',
    required this.searchHint,
    this.selectValue,
    this.icon,
    this.showClearButton=true,
    this.openDropDownProgKey,
    this.textSeleccioneUndato,
    this.imgUrl,
    this.validator,
    this.displayField,
    this.onChanged,
    this.onNoEncuentroRecinto,
    this.showNoEncuentroRecinto=false,
  }):super(key:key);

  @override
  _ComboBusquedaRecintosState<T> createState()=>_ComboBusquedaRecintosState<T>();
}

class _ComboBusquedaRecintosState<T> extends State<ComboBusquedaRecintos<T>> {
  late bool showX;
  final _userEditTextController=TextEditingController(text:'');

  @override
  void initState() {
    showX=false;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Widget wgComboBusquedaRecintos=DropdownSearch<T>(
      selectedItem:widget.selectValue,
      compareFn:(item,selectedItem)=>item==selectedItem,
      validator:(v){
        print("haolala");
        return v==null?"EL ${widget.title} Es requerido":null;
      },
      key:widget.openDropDownProgKey,
      suffixProps:DropdownSuffixProps(
        clearButtonProps:ClearButtonProps(
          isVisible:showX&&widget.showClearButton,
          color:const Color(0xFFB74949),
        ),
      ),
      decoratorProps:DropDownDecoratorProps(
        decoration:InputDecoration(
          filled:true,
          fillColor:Colors.white,
          contentPadding:const EdgeInsets.symmetric(horizontal:12,vertical:12),
          enabledBorder:OutlineInputBorder(
            borderRadius:BorderRadius.circular(13),
            borderSide:const BorderSide(color:Color(0xFFDCE4EC)),
          ),
          focusedBorder:OutlineInputBorder(
            borderRadius:BorderRadius.circular(13),
            borderSide:const BorderSide(color:Color(0xFF195496),width:1.4),
          ),
          errorBorder:OutlineInputBorder(
            borderRadius:BorderRadius.circular(13),
            borderSide:const BorderSide(color:Color(0xFFB74949)),
          ),
          focusedErrorBorder:OutlineInputBorder(
            borderRadius:BorderRadius.circular(13),
            borderSide:const BorderSide(color:Color(0xFFB74949),width:1.4),
          ),
        ),
      ),
      popupProps:PopupProps.dialog(
        showSelectedItems:true,
        disableFilter:false,
        showSearchBox:true,
        searchFieldProps:getBusquedaPopup(),
        dialogProps:DialogProps(
          backgroundColor:Colors.white,
          shape:RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(20),
          ),
        ),
        itemBuilder:(context,item,isSelected,l)=>_customDesingDataPopop(context,item,isSelected,l),
        containerBuilder:(context,popupWidget){
          return SafeArea(
            child:Column(
              children:[
                _cabeceraPopup(),

                _buildPendientesValidacion(),

                Expanded(
                  child:popupWidget,
                ),
                if(
                widget.showNoEncuentroRecinto &&
                    _getCantidadPendientes() < 4
                )
                  Container(
                    width:double.infinity,
                    padding:const EdgeInsets.fromLTRB(12,8,12,12),
                    decoration:const BoxDecoration(
                      color:Color(0xFFF7F9FB),
                      border:Border(
                        top:BorderSide(
                          color:Color(0xFFE1E7ED),
                        ),
                      ),
                    ),
                    child:OutlinedButton.icon(
                      icon:const Icon(
                        Icons.add_location_alt_outlined,
                        color:Color(0xFF195496),
                        size:18,
                      ),
                      label:const Text(
                        "No encuentro mi recinto",
                        style:TextStyle(
                          color:Color(0xFF195496),
                          fontSize:10.5,
                          fontWeight:FontWeight.w800,
                        ),
                      ),
                      style:OutlinedButton.styleFrom(
                        backgroundColor:Colors.white,
                        padding:const EdgeInsets.symmetric(
                          vertical:13,
                        ),
                        side:const BorderSide(
                          color:Color(0xFF195496),
                        ),
                        shape:RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(12),
                        ),
                      ),
                      onPressed:(){
                        Navigator.pop(context);
                        widget.onNoEncuentroRecinto?.call();
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      itemAsString:(item){
        if(item!=null&&widget.displayField!=null){
          return widget.displayField!(item);
        }
        return '';
      },

      dropdownBuilder:(context,selectedItem)=>_customDropDownExample(context,selectedItem),
      items: (filter, infiniteScrollProps) {
        return widget.datos.where((item) {
          return !(item is RecintosElectoral &&
              !item.listoCrearCodigo);
        }).toList();
      },
      onSelected:(value){
        _userEditTextController.clear();

        if(value is RecintosElectoral &&
            !value.listoCrearCodigo){
          return;
        }

        final bool nuevoEstado =
        _tieneSeleccion(value);

        if(showX != nuevoEstado && mounted){
          setState((){
            showX = nuevoEstado;
          });
        }

        widget.complete?.call(value);

        if(value != null){
          widget.onChanged?.call(value);
        }
      },

      onBeforeChange: (selectedItem, newItem) async {
        if (newItem is RecintosElectoral && !newItem.listoCrearCodigo) {
          DialogosAwesome.getWarning(descripcion: "Este recinto se encuentra pendiente de validación y no puede ser seleccionado.");

          return false;
        }

        return true;
      },
    );

    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        if(widget.searchHint.trim().isNotEmpty)...[
          Row(
            children:[
              Container(
                width:28,
                height:28,
                decoration:BoxDecoration(
                  color:const Color(0xFFEAF1F8),
                  borderRadius:BorderRadius.circular(8),
                ),
                child:Icon(
                  widget.icon??Icons.home_work_outlined,
                  color:const Color(0xFF195496),
                  size:15,
                ),
              ),
              const SizedBox(width:7),
              Expanded(
                child:Text(
                  widget.searchHint,
                  style:const TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:10.5,
                    fontWeight:FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height:7),
        ],
        wgComboBusquedaRecintos,
      ],
    );
  }

  int _getCantidadPendientes() {
    return widget.datos.where((item) {
      return item is RecintosElectoral &&
          !item.listoCrearCodigo;
    }).length;
  }

  Widget _cabeceraPopup() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(14,13,14,10),
      decoration:const BoxDecoration(
        color:Color(0xFFF7F9FB),
        border:Border(
          bottom:BorderSide(color:Color(0xFFE1E7ED)),
        ),
      ),
      child:Row(
        children:[
          Container(
            width:37,
            height:37,
            decoration:BoxDecoration(
              gradient:const LinearGradient(
                begin:Alignment.topLeft,
                end:Alignment.bottomRight,
                colors:[
                  Color(0xFF123F75),
                  Color(0xFF2869AC),
                ],
              ),
              borderRadius:BorderRadius.circular(10),
            ),
            child:Icon(
              widget.icon??Icons.home_work_outlined,
              color:Colors.white,
              size:19,
            ),
          ),
          const SizedBox(width:9),
          Expanded(
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                const Text(
                  'SELECCIONAR RECINTO',
                  style:TextStyle(
                    color:Color(0xFF195496),
                    fontSize:7.5,
                    fontWeight:FontWeight.w900,
                    letterSpacing:.7,
                  ),
                ),
                const SizedBox(height:2),
                Text(
                  widget.searchHint,
                  maxLines:2,
                  overflow:TextOverflow.ellipsis,
                  style:const TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:11.5,
                    fontWeight:FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendientesValidacion() {
    final pendientes = widget.datos.where((item) =>
    item is RecintosElectoral &&
        item.estado.trim().toLowerCase() == 'pendiente').length;

    final aprobados = widget.datos.where((item) =>
    item is RecintosElectoral &&
        item.estado.trim().toLowerCase() == 'aprobado').length;

    final rechazados = widget.datos.where((item) =>
    item is RecintosElectoral &&
        item.estado.trim().toLowerCase() == 'rechazado').length;

    final duplicados = widget.datos.where((item) =>
    item is RecintosElectoral &&
        item.estado.trim().toLowerCase() == 'duplicado').length;

    final pendientesR = widget.datos.where((item) {
      return item is RecintosElectoral &&
          !item.listoCrearCodigo;

    }).toList();


    return InkWell(
      onTap: () {
        _mostrarPendientesValidacion(pendientesR);
      },
      child: Container(
        width:double.infinity,
        margin:const EdgeInsets.fromLTRB(10,8,10,4),
        padding:const EdgeInsets.symmetric(
          horizontal:12,
          vertical:10,
        ),
        decoration:BoxDecoration(
          color:const Color(0xFFFFF5F5),
          borderRadius:BorderRadius.circular(13),
          border:Border.all(
            color:const Color(0xFFF0CCCC),
          ),
        ),
        child:Row(
          children:[
            Container(
              width:36,
              height:36,
              decoration:BoxDecoration(
                color:const Color(0xFFC65353).withOpacity(.08),
                borderRadius:BorderRadius.circular(9),
              ),
              child:const Icon(
                Icons.pending_outlined,
                color:Color(0xFFC65353),
                size:20,
              ),
            ),

            const SizedBox(width:10),

            Expanded(
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pendientes == 1
                            ? '1 recinto pendiente de validación'
                            : '$pendientes recintos pendientes de validación',
                        style: const TextStyle(
                          color: Color(0xFFE39A2D),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        aprobados == 1
                            ? '1 recinto aprobado'
                            : '$aprobados recintos aprobados',
                        style: const TextStyle(
                          color: Color(0xFF218A61),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        rechazados == 1
                            ? '1 recinto rechazado'
                            : '$rechazados recintos rechazados',
                        style: const TextStyle(
                          color: Color(0xFFC65353),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        duplicados == 1
                            ? '1 recinto duplicado'
                            : '$duplicados recintos duplicados',
                        style: const TextStyle(
                          color: Color(0xFF7B61A8),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height:3),

                  const Text(
                    'Toque para ver los recintos',
                    style:TextStyle(
                      color:Color(0xFF8B99A7),
                      fontSize:9.5,
                      fontWeight:FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color:Color(0xFFC65353),
              size:14,
            ),
          ],
        ),
      ),
    );
  }

  Color _colorEstado(String estado) {
    switch (estado.trim().toLowerCase()) {
      case 'aprobado':
        return const Color(0xFF218A61);

      case 'rechazado':
        return const Color(0xFFC65353);

      case 'duplicado':
        return const Color(0xFF7B61A8);

      case 'pendiente':
      default:
        return const Color(0xFFE39A2D);
    }
  }

  IconData _iconoEstado(String estado) {
    switch (estado.trim().toLowerCase()) {
      case 'aprobado':
        return Icons.check_circle_outline;

      case 'rechazado':
        return Icons.cancel_outlined;

      case 'duplicado':
        return Icons.content_copy_outlined;

      case 'pendiente':
      default:
        return Icons.pending_outlined;
    }
  }

  void _mostrarPendientesValidacion(List<T> pendientes) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 520,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF1F8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.home_work_outlined,
                        color: Color(0xFF195496),
                        size: 21,
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Expanded(
                      child: Text(
                        'Estado de recintos',
                        style: TextStyle(
                          color: Color(0xFF17365D),
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Color(0xFF8B99A7),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    pendientes.length == 1
                        ? '1 recinto encontrado.'
                        : '${pendientes.length} recintos encontrados.',
                    style: const TextStyle(
                      color: Color(0xFF667789),
                      fontSize: 11,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: pendientes.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 7),
                    itemBuilder: (context, index) {
                      final recinto =
                      pendientes[index] as RecintosElectoral;

                      final colorEstado =
                      _colorEstado(recinto.estado);


                      final iconoEstado =
                      _iconoEstado(recinto.estado);

                      return Container(
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: colorEstado.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorEstado.withOpacity(0.20),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: colorEstado.withOpacity(0.08),
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.home_work_outlined,
                                color: colorEstado,
                                size: 18,
                              ),
                            ),

                            const SizedBox(width: 9),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recinto.nomRecintoElecOnly
                                        .isNotEmpty
                                        ? recinto.nomRecintoElecOnly
                                        : recinto.nomRecintoElec,
                                    maxLines: 2,
                                    overflow:
                                    TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFF17365D),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),

                                  if (recinto
                                      .direcRecintoElec
                                      .isNotEmpty) ...[
                                    const SizedBox(height: 4),

                                    Text(
                                      recinto.observacion,
                                      maxLines: 3,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Color(0xFF667789),
                                        fontSize: 9.5,
                                        height: 1.2,
                                      ),
                                    ),
                                  ],

                                  const SizedBox(height: 5),

                                  Row(
                                    children: [
                                      Icon(
                                        iconoEstado,
                                        size: 12,
                                        color: colorEstado,
                                      ),

                                      const SizedBox(width: 4),

                                      Text(
                                        recinto.estado,
                                        style: TextStyle(
                                          color: colorEstado,
                                          fontSize: 9,
                                          fontWeight:
                                          FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF195496),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(11),
                      ),
                    ),
                    child: const Text(
                      'Entendido',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }




  TextFieldProps getBusquedaPopup() {
    return TextFieldProps(
      controller:_userEditTextController,
      style:const TextStyle(
        color:Color(0xFF17365D),
        fontSize:11,
        fontWeight:FontWeight.w600,
      ),
      decoration:InputDecoration(
        filled:true,
        fillColor:const Color(0xFFF7F9FB),
        prefixIcon:const Icon(
          Icons.search_rounded,
          color:Color(0xFF195496),
          size:20,
        ),
        suffixIcon:IconButton(
          icon:const Icon(
            Icons.close_rounded,
            color:Color(0xFFB74949),
            size:20,
          ),
          onPressed:(){
            Navigator.of(context).pop();
          },
        ),
        hintText:"Buscar recinto...",
        hintStyle:const TextStyle(
          color:Color(0xFF8B99A7),
          fontSize:10.5,
        ),
        labelText:widget.searchHint,
        labelStyle:const TextStyle(
          color:Color(0xFF667789),
          fontSize:10,
        ),
        border:OutlineInputBorder(
          borderRadius:BorderRadius.circular(13),
        ),
        enabledBorder:OutlineInputBorder(
          borderRadius:BorderRadius.circular(13),
          borderSide:const BorderSide(
            color:Color(0xFFDCE4EC),
          ),
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius:BorderRadius.circular(13),
          borderSide:const BorderSide(
            color:Color(0xFF195496),
            width:1.4,
          ),
        ),
        contentPadding:const EdgeInsets.symmetric(
          horizontal:12,
          vertical:12,
        ),
      ),
    );
  }

  Widget _customDropDownExample(BuildContext context,T? item) {
    final responsive=ResponsiveUtil();

    Widget msjSelectDato=Container(
      width:double.infinity,
      padding:const EdgeInsets.symmetric(vertical:4),
      child:Row(
        children:[
          const Icon(
            Icons.touch_app_outlined,
            color:Color(0xFF8B99A7),
            size:16,
          ),
          const SizedBox(width:6),
          Expanded(
            child:Text(
              widget.textSeleccioneUndato??"Seleccione un dato",
              style:TextStyle(
                color:const Color(0xFF7A8998),
                fontSize:responsive.diagonalP(1),
                fontWeight:FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );

    if(item==null){
      return msjSelectDato;
    }

    if(widget.displayField==null||widget.displayField!(item).isEmpty){
      if(showX){
        Future.delayed(Duration.zero,(){
          if(mounted){
            setState(()=>showX=false);
          }
        });
      }
      return msjSelectDato;
    }

    if(!showX){
      Future.delayed(Duration.zero,(){
        if(mounted){
          setState(()=>showX=true);
        }
      });
    }

    return Container(
      width:double.infinity,
      padding:const EdgeInsets.symmetric(vertical:2),
      child:Row(
        children:[
          Container(
            width:27,
            height:27,
            decoration:BoxDecoration(
              color:const Color(0xFFEAF5EE),
              borderRadius:BorderRadius.circular(8),
            ),
            child:const Icon(
              Icons.check_rounded,
              color:Color(0xFF218A61),
              size:16,
            ),
          ),
          const SizedBox(width:7),
          Expanded(
            child:Text(
              widget.displayField!(item),
              textAlign:TextAlign.left,
              softWrap:true,
              maxLines:3,
              overflow:TextOverflow.ellipsis,
              style:TextStyle(
                color:const Color(0xFF17365D),
                fontSize:responsive.diagonalP(1.08),
                fontWeight:FontWeight.w700,
                height:1.12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customDesingDataPopop(
      BuildContext context,
      T? item,
      bool v,
      bool isSelected,
      ) {
    final responsive = ResponsiveUtil();

    if (item == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Text(
          widget.textSeleccioneUndato ?? "Seleccione un dato",
          style: TextStyle(
            color: const Color(0xFFB74949),
            fontSize: responsive.diagonalP(1),
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    if (widget.displayField == null ||
        widget.displayField!(item).isEmpty) {
      return const SizedBox.shrink();
    }

    final recinto = item as RecintosElectoral;

    final bool esValidado = recinto.validado;
    final bool pendienteValidacion = !recinto.listoCrearCodigo;

    Color colorFondo = Colors.white;
    Color colorBorde = const Color(0xFFE0E7ED);
    Color colorEstado = const Color(0xFF195496);
    IconData iconEstado = Icons.home_work_outlined;
    String? textoEstado;

    if (esValidado) {
      colorFondo = const Color(0xFFF1F7FC);
      colorBorde = const Color(0xFFC9DFF2);
      colorEstado = const Color(0xFF2878B8);
      iconEstado = Icons.verified_rounded;
      textoEstado = "Validado";
    } else if (pendienteValidacion) {
      colorFondo = const Color(0xFFFFF5F5);
      colorBorde = const Color(0xFFF0CCCC);
      colorEstado = const Color(0xFFC65353);
      iconEstado = Icons.pending_outlined;
      textoEstado = "Pendiente de validación";
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF195496)
            : colorFondo,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: isSelected
              ? const Color(0xFF195496)
              : colorBorde,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withOpacity(.12)
                  : colorEstado.withOpacity(.08),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              isSelected
                  ? Icons.check_circle_rounded
                  : iconEstado,
              color: isSelected
                  ? Colors.white
                  : colorEstado,
              size: 20,
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.displayField!(item),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF17365D),
                    fontSize: responsive.diagonalP(1.08),
                    fontWeight: FontWeight.w700,
                    height: 1.12,
                  ),
                ),

                if (!isSelected && textoEstado != null) ...[
                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Icon(
                        iconEstado,
                        size: 13,
                        color: colorEstado,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        textoEstado,
                        style: TextStyle(
                          color: colorEstado,
                          fontSize: responsive.diagonalP(.85),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getOnlyDesing({
    required Widget icon,
    String titulo='',
    Color colorTexto=Colors.black,
  }) {
    final responsive=ResponsiveUtil();

    return Row(
      crossAxisAlignment:CrossAxisAlignment.center,
      children:[
        icon,
        const SizedBox(width:5),
        Expanded(
          child:Text(
            titulo,
            softWrap:true,
            maxLines:3,
            overflow:TextOverflow.ellipsis,
            style:TextStyle(
              fontSize:responsive.diagonalP(1.05),
              color:colorTexto,
              fontWeight:FontWeight.w600,
              height:1.15,
            ),
          ),
        ),
        const SizedBox(width:4),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size:11,
          color:colorTexto.withOpacity(.55),
        ),
      ],
    );
  }

  Widget getDesing({
    bool isSelect=false,
    IconData? icon,
    String titulo='',
    bool selected=false,
    String? iconUrl,
    Color colorTexto=Colors.black,
  }) {
    Widget _icon=getIcon(
      icon:icon,
      isSelecc:isSelect,
    );

    return getOnlyDesing(
      icon:_icon,
      titulo:titulo,
      colorTexto:colorTexto,
    );
  }

  Widget getIcon({
    IconData? icon,
    bool isSelecc=false,
  }) {
    Widget wg=icon!=null
        ?Icon(
      icon,
      color:const Color(0xFF195496),
      size:20,
    )
        :const Icon(
      Icons.description_outlined,
      color:Color(0xFF195496),
      size:20,
    );

    if(isSelecc){
      wg=const Icon(
        Icons.check_circle_rounded,
        color:Colors.white,
        size:21,
      );
    }

    return Container(
      width:33,
      height:33,
      alignment:Alignment.center,
      decoration:BoxDecoration(
        color:isSelecc
            ?Colors.white.withOpacity(.12)
            :const Color(0xFFEAF1F8),
        borderRadius:BorderRadius.circular(9),
      ),
      child:wg,
    );
  }

  bool _tieneSeleccion(T? item) {
    if (item == null) {
      return false;
    }

    return _getDisplayText(item).trim().isNotEmpty;
  }

  String _getDisplayText(T item) {
    if (widget.displayField != null) {
      return widget.displayField!(item);
    }

    return item.toString();
  }

  @override
  void dispose() {
    _userEditTextController.dispose();
    super.dispose();
  }
}