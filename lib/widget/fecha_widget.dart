import 'package:ctp1/Providers/datosCliente_prov.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FechaWidget extends StatefulWidget {
  final TextEditingController edit;
  const FechaWidget({Key key, this.edit}) : super(key: key);

  @override
  _FechaWidgetState createState() => _FechaWidgetState();
}

class _FechaWidgetState extends State<FechaWidget> {
  String _fechaSig;

  @override
  void initState() {
    final datosCliente = Provider.of<DatosClienteProv>(context, listen: false);
    this.widget.edit.text = datosCliente.fechaSig;
    super.initState();
  }
  // @override
  // void dispose() {
    
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final datosCliente = Provider.of<DatosClienteProv>(context, listen: false);
    return TextFormField(
      // autofocus: true,
      enableInteractiveSelection: true, // selecion interactiva
      // initialValue: datosCliente.fechaSig,
      controller: this.widget.edit,

      style: TextStyle(fontSize: 19),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon:Icon(Icons.calendar_view_day),
        labelText: 'Fecha:',
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context, this.widget.edit, datosCliente);
      },
    );
  }

  _selectDate(BuildContext context, TextEditingController edit,
      DatosClienteProv datosClienteProv) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2020),
      lastDate: new DateTime(2021),
      // locale: Locale('es', 'ES'),
    );

    setState(() {
      if (picked == null) {
        edit.text = datosClienteProv.fechaSig;
      } else {
        _fechaSig = DateFormat("dd-MM-yyyy").format(picked);
        edit.text = _fechaSig;
        datosClienteProv.setFechaSig(_fechaSig);
      }
    });
  }
}
