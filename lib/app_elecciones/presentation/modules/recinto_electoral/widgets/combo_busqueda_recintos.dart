import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../app/core/values/app_colors.dart';
import '../../../../../app/presentation/widgets/custom_app_widgets.dart';

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
  void dispose() {
    _userEditTextController.dispose();
    super.dispose();
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
      popupProps:PopupPropsMultiSelection.dialog(
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
                Expanded(child:popupWidget),
                if(widget.showNoEncuentroRecinto)
                  Container(
                    width:double.infinity,
                    padding:const EdgeInsets.fromLTRB(12,8,12,12),
                    decoration:const BoxDecoration(
                      color:Color(0xFFF7F9FB),
                      border:Border(
                        top:BorderSide(color:Color(0xFFE1E7ED)),
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
                        padding:const EdgeInsets.symmetric(vertical:13),
                        side:const BorderSide(color:Color(0xFF195496)),
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
      items:(filter,infiniteScrollProps)=>widget.datos,
      onChanged:(value){
        print("cambiaa");
        if(widget.complete!=null){
          widget.complete!(value);
        }
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

  Widget _customDesingDataPopop(BuildContext context,T? item,bool v,bool isSelected) {
    final responsive=ResponsiveUtil();

    print("isSelected $isSelected ybb= $v");

    Widget msjSelectDato=Container(
      width:double.infinity,
      padding:const EdgeInsets.all(10),
      child:Text(
        widget.textSeleccioneUndato??"Seleccione un dato",
        style:TextStyle(
          color:const Color(0xFFB74949),
          fontSize:responsive.diagonalP(1),
          fontWeight:FontWeight.w700,
        ),
      ),
    );

    if(item==null)return msjSelectDato;
    if(widget.displayField==null||widget.displayField!(item).isEmpty)return msjSelectDato;

    return Container(
      margin:const EdgeInsets.symmetric(
        horizontal:10,
        vertical:4,
      ),
      padding:const EdgeInsets.symmetric(
        horizontal:9,
        vertical:8,
      ),
      decoration:BoxDecoration(
        color:isSelected
            ?const Color(0xFF195496)
            :Colors.white,
        borderRadius:BorderRadius.circular(13),
        border:Border.all(
          color:isSelected
              ?const Color(0xFF195496)
              :const Color(0xFFE0E7ED),
        ),
        boxShadow:isSelected
            ?[
          BoxShadow(
            color:const Color(0xFF195496).withOpacity(.16),
            blurRadius:9,
            offset:const Offset(0,3),
          ),
        ]
            :[],
      ),
      child:getDesing(
        colorTexto:isSelected?Colors.white:const Color(0xFF17365D),
        titulo:widget.displayField!(item),
        icon:widget.icon,
        iconUrl:widget.imgUrl,
        isSelect:isSelected,
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
}