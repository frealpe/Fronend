import 'dart:js';


import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

import '../models/producto.dart';


class ProductosDTS extends DataTableSource{

  //final BuildContext context;

  final List<Producto> productos;
  final BuildContext context;

  ProductosDTS(this.productos, this.context);

  //ProductosDTS(this.productos);

  @override
  DataRow? getRow(int index) {

      final productos = this.productos[index];
    
      return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Text(productos.color)),
          DataCell(Text(productos.nombre)),
          DataCell(Text(productos.categoria.nombre)),
          DataCell(Text(productos.genero)),                              
          DataCell(Text(productos.precio.toString())),
          DataCell(Text(productos.cantidad.toString())),
          DataCell(
            Row(
              children: [
                IconButton(
                  onPressed: (){
                    NavigationServer.navigateTo('/dashboard/productos/${productos.id}'); 
                  },
                  icon: Icon(Icons.edit_outlined)
                  ),

                IconButton(
                  onPressed: (){
                  final dialog= AlertDialog(
                    title: Text('¿Está seguro de borrarlo?'),
                    content: Text('Borrar definitivamente ${productos.nombre}?'),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text('No')),
                      TextButton(onPressed: () async{
                       Provider.of<ProductosProvider>(context,listen: false).deleteProducto(productos.id);
                      //(productos.id);   
                        Navigator.of(context).pop();
                      }, child: Text('Si,borrar')),
                    ],
                  );
                      showDialog(
                        //Solucion rapidabarrierColor: Colors.transparent,                       
                        context: context, builder: (_)=> dialog
                        );                    

                  },
                  icon: Icon(Icons.delete_outlined,color: Colors.red.withOpacity(0.8)),
                  ),


              ],
            )
          ), 
                                     
        ]


      );
  } 

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => productos.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
  


}