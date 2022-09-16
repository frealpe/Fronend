
import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/providers/producto_form_provider.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/cards/cards.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

import '../../models/producto.dart';

class ProductoView extends StatefulWidget {

  final String uid;
  
  const ProductoView({
    Key? key,
    required this.uid
    }) : super(key: key);

  @override
 _ProductoViewState createState() => _ProductoViewState();
}

class _ProductoViewState extends State<ProductoView> {

Producto? producto;
List <Categoria>categorias = [];  
  @override
  void initState() {
    super.initState();

     Provider.of<CategoriesProvider>(context,listen: false).getCategories();
          
     final productosProvider = Provider.of<ProductosProvider>(context,listen: false);
     final productoFormProvider = Provider.of<ProductoFormProvider>(context,listen: false);
     SideMenuProvider.isImag=true;
     productosProvider.getProductoById(widget.uid)
    .then((productoDB) {
        if(productoDB != null){
          if (!mounted) return;
          productoFormProvider.producto = productoDB;
          productoFormProvider.formKey = new GlobalKey<FormState>(); 
          setState((){ producto = productoDB; });         
      }else{
        NavigationServer.replaceTo('/dashboard/productos');
      }       
    });

  }

//////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
      
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),          
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Modificación del Articulo: ${producto!.nombre}',style: CustomLabels.h1),
          SizedBox(height: 10),
//////////////////////////////////////////////////////////////////////////////////////////
          if( producto == null ) 
            WhiteCard(
              child: Container(
                alignment: Alignment.center,
                height: 300,
                child: CircularProgressIndicator(),
              )
            ),
//////////////////////////////////////////////////////////////////////////////////////////
            if( producto != null ) 
            
            _ProductoViewBody()

        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////

class _ProductoViewBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(700)
        },

        children: [
          TableRow(
            children: [
              // AVATAR
              ImagenContainer(),

              ProductoViewForm(),

            ]
          )
        ],
      ),
    );
  }
}


