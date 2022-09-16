import 'package:admin_dashboard/datatables/categories_datasource.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/providers/productos_provider.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<CategoriesProvider>(context,listen: false).getCategories();
  //Cuando se ecneutra dentro de una funcion o metodo el listen debe colocarse en false

  }

  @override
  Widget build(BuildContext context) {
// Si el provider estuviera aqui no se hace necesario el listen ya que el build lo crea
    final categorias = Provider.of<CategoriesProvider>(context).categorias;
//    final conteo = 


    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Categorias',style: CustomLabels.h1),
          SizedBox(height: 10),

          PaginatedDataTable(           
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Categoria')),
              DataColumn(label: Text('# Artículos')),
              DataColumn(label: Text('Acciones')),
            ],
            source: CategoriesDTS(categorias,context),
            header: Text('Lista de todas las Categorias Disponibles',maxLines: 2),
            onRowsPerPageChanged: (value){

              setState(() {
                _rowsPerPage = value ?? 20;
              });
               
            },

            rowsPerPage: _rowsPerPage,
            actions: [

              CustomIconButton(
                onPressed: (){                  
                  NavigationServer.navigateTo('/dashboard/newcat'); 
                },
                text: 'Crear',
                icon: Icons.add_outlined
                )
            ],
            )
        ],
      ),
    );
  }
}