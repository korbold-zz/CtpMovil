import 'package:flutter/material.dart';

IconButton logout(BuildContext context){
  return IconButton(
            icon: Icon(Icons.delete),
            onPressed: _maybeRemoveChecked( context),
          );
}

_maybeRemoveChecked(BuildContext context) {
      

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Confirmacion'),
                content: Text('¿Estás seguro Cerrar Sesión?'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No')),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Si')),
                ],
              ));
    }