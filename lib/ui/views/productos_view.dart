import 'package:admin_dashboard/datatables/productos_datasource.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class ProductosView extends StatefulWidget {


  final String? estado;
  final String? val;


  const ProductosView({
    Key? key,
    this.estado = 'true',     //inicializar 
    this.val
    }) : super(key: key);

  @override
  State<ProductosView> createState() => _ProductosViewState();
}

class _ProductosViewState extends State<ProductosView> {

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    //Dentro del build no se necesita volver a ejecutar
    //Si esta dentro del build no se necesita
    //Se inicializa  
    if(widget.estado == 'true') {
      Provider.of<ProductosProvider>(context,listen: false).getProductos();
      }else{
        Provider.of<ProductosProvider>(context,listen: false).getProduCate('${widget.val}');
      }

  }

  @override
  Widget build(BuildContext context) {

    final productos = Provider.of<ProductosProvider>(context).productos;

   // final productosDTS = new ProductosDTS(productos);
    
    return Container(
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          //Padding(padding: EdgeInsets.all(10)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Text('Lista Completa de Artículos Disponibles',style: CustomLabels.h1)
            ),
          
          SizedBox(height: 10),

          PaginatedDataTable(
            columns: [
              DataColumn(label: Text('Color')),
              DataColumn(label: Text('Ref')),              
              DataColumn(label: Text('Categoria')),
              DataColumn(label: Text('Genero')),              
              DataColumn(label: Text('Precio')),
              DataColumn(label: Text('# Disponibles')),
              DataColumn(label: Text('Acciones')),  
            ],

            //TODO ProductosDTS Provider
            source: ProductosDTS(productos,context),
            //source: productosDTS,             
            header: Text('Lista de Productos disponibles',maxLines: 2), 
            onRowsPerPageChanged: (value){
               setState(() {
                 _rowsPerPage=value ?? 10;
               }); 
            },
            rowsPerPage: _rowsPerPage,
            actions: [
                
                CustomIconButton(
                  onPressed: (){
                    NavigationServer.navigateTo('/dashboard/newproducto'); 
                  },
                  text: 'Nuevo Producto',
                  icon: Icons.add_outlined,
                 // color: Colors.brown,  
                  ),
                  
            ],
            
            
            )  

        ],
      ),
    );
  }
}