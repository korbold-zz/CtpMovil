import 'package:ctp1/Providers/datosCliente_prov.dart';
import 'package:ctp1/pages/cliente_page.dart';
import 'package:ctp1/pages/pages_tabs/drawer.dart';
import 'package:ctp1/pages/pages_tabs/pay_tab.dart';
import 'package:ctp1/pages/prueba.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClienteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datosCliente = Provider.of<DatosClienteProv>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.account_circle)),
              Tab(icon: Icon(Icons.account_balance_wallet)),
            ],
          ),
          title: Text('Cliente: ${datosCliente.codigoCliente}'),
        ),
        body: TabBarView(
          children: [
            // ClientePage(),
            ProfilePage(),
            PayTab(),
          ],
        ),
      ),
    );
  }
}
