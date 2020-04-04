import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctp1/Providers/datos_prov.dart';
import 'package:ctp1/Providers/login_prov.dart';

import 'package:ctp1/Providers/lugares_prov.dart';
import 'package:ctp1/Providers/usuarios_prov.dart';

import 'package:ctp1/core/Models/lugares_model.dart';
import 'package:ctp1/core/Models/usuarios_model.dart';
import 'package:ctp1/pages/pages_tabs/page_1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LugaresTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LugaresList(),
    );
  }
}

class LugaresList extends StatelessWidget {
  const LugaresList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserRepository>(context, listen: false);

    List<LugaresModel> lugares;

    print('USUARIO: ' + userProvider.user.email);

    final lugaresProvider = Provider.of<LugaresProv>(context, listen: false);
    final clientesProvider = Provider.of<ClientesProv>(context, listen: false);

    return StreamBuilder(
        stream: lugaresProvider.getRuta(userProvider.user.email.toString()),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            lugares = snapshot.data.documents
                .map((doc) => LugaresModel.fromMap(doc.data))
                .toList();
            return ListView.builder(
              itemCount: lugares.length,
              itemBuilder: (buildContext, index) => _listTipo1(
                  lugaresDetalle: lugares[index],
                  index: index,
                  lugarProvider: clientesProvider,
                  context: context),
            );
          } else {
            return _crearLoading();
          }
        });
  }

  Widget _crearLoading() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          )
        ],
      ),
    );
  }

  _listTipo1(
      {LugaresModel lugaresDetalle,
      int index,
      ClientesProv lugarProvider,
      BuildContext context}) {
    index++;
    return Column(
      children: <Widget>[
        ListTile(
          leading: Text(
            index.toString(),
            style: TextStyle(fontSize: 30),
          ),
          title: Text(
            lugaresDetalle.nombreRuta,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          subtitle: Text(lugaresDetalle.codRuta),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 40,
            color: Colors.blue,
          ),
          onTap: () {
            lugarProvider.setLugar(lugaresDetalle.codRuta);
            lugarProvider.setNombreLugar(lugaresDetalle.nombreRuta);
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new Page1Tab(),
              ),
            );
          },
        ),
        Divider(
          color: Colors.blue[600],
        )
      ],
    );
  }
}
