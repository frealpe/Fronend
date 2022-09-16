import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';


class CategoriesDTS extends DataTableSource{

  final List<Categoria>categorias;
  final BuildContext context;

  CategoriesDTS(this.categorias, this.context); 

  @override
  DataRow getRow(int index) {

    final categoria = this.categorias[index];
    
   // final cantidad = Provider.of<ProductosProvider>(context,listen: false).getProduCate(categoria.id);
   // final productos = Provider.of<ProductosProvider>(context).productos;
    //print('date');
    //print(productos[index].cantidad);   

    return DataRow.byIndex(
      index: index,
      
      cells: [
////////////////////////////////////////////////////////////////////
        DataCell(Text(categoria.id)),
////////////////////////////////////////////////////////////////////
        DataCell(
              Row(
                children: [
                    CustomOutlinedButton(
                      onPressed: (){
                          NavigationServer.navigateTo('/dashboard/prodcateg/${categoria.id}'); 
                      },
                      text: categoria.nombre,
                      )
                        ],
                )
                ),
////////////////////////////////////////////////////////////////////                
        DataCell(
          Container(
                child: Text(
                  
                  categoria.nombre
                  
                  )
          )
                                  
          ), //Se debe colocar aqui la accion de oprimir el botón.  
////////////////////////////////////////////////////////////////////                
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: (){
                    showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder:( context ) => CategoryModal(categoria: categoria,)
                    );
                },
                icon: Icon(Icons.edit_outlined)),

              IconButton(
                icon: Icon(Icons.delete_outlined,color: Colors.red.withOpacity(0.8),),
                onPressed: (){
                  final dialog= AlertDialog(
                    title: Text('¿Está seguro de borrarlo?'),
                    content: Text('Borrar definitivamente ${categoria.nombre}?'),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text('No')),
                      TextButton(onPressed: () async{
                       Provider.of<CategoriesProvider>(context,listen: false)
                       .deleteCategory(categoria.id);   
                        Navigator.of(context).pop();
                      }, child: Text('Si,borrar')),
                    ],
                  );
                      showDialog(
                        //Solucion rapidabarrierColor: Colors.transparent,                       
                        context: context, builder: (_)=> dialog
                        );
                },

                
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
  int get rowCount => categorias.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}