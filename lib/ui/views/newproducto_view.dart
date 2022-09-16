
import 'package:admin_dashboard/providers/producto_form_provider.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/cards/cards.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import '../../models/producto.dart';

class NewProductoView extends StatefulWidget {

  final String? uid;
  
  const NewProductoView({
    Key? key, required this.uid,

    }) : super(key: key);

  @override
 _NewProductoViewState createState() => _NewProductoViewState();
}

class _NewProductoViewState extends State<NewProductoView> {

//bool esta=true;

Producto? producto;
List <Categoriap> categoriaprod = [];
Categoriap? categoid;
  @override
  void initState() {
    super.initState();

     //final productosProvider = Provider.of<ProductosProvider>(context,listen: false);
     final productoFormProvider = Provider.of<ProductoFormProvider>(context,listen: false);
     SideMenuProvider.isImag=false;
///////////////////////////////////////////////////////////////////////////
      final categoid = Categoriap(id: '', nombre: '');
      producto = Producto(
        id: 'id',
        nombre: 'nombre',
        color: 'color',
        genero: 'genero',
        cantidad: 'cantidad',
        usuario: 'usuario',
        precio: 'precio',
        categoria: categoid,
        descripcion: 'descripcion',
        disponible: 'disponible');

        setState((){producto;});   
        productoFormProvider.producto=producto;
        productoFormProvider.formKey = new GlobalKey<FormState>(); 
  }


  @override
  Widget build(BuildContext context) {
      
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),          
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Nuevo Articulo:',style: CustomLabels.h1),
          SizedBox(height: 10),
           
            _ProductoViewBody()

        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////

class _ProductoViewBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final producto = Provider.of<ProductoFormProvider>(context).producto;  
    return Container(
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(700)
        },

        children: [
          TableRow(
            children: [
              // AVATAR
                ///SE DEBE OCULTAR LA CAR HASTA QUE NO TENGA EL ID
                ImagenContainer(),                  

              _ProductoViewForm(),

            ]
          )
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

class _ProductoViewForm extends StatelessWidget {
  


    const _ProductoViewForm ({
    Key? key,
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  final List<String> genderItems = [
  'DAMA',
  'CABALLERO',
];

  final List<String> colorItems = [
  'NEGRO',
  'ROJO',
  'AZUL',
  'AMARILLO',
  'OTROS',

];


      final productosbase = Provider.of<ProductosProvider>(context);
      final productoFormProvider = Provider.of<ProductoFormProvider>(context);
      final producto = productoFormProvider.producto!;
///////////////////////////////////////////////////////////////////////////      
    return WhiteCard(     
      title: 'Información especifica',
      child: Form(
        key: productoFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
            //TODO PENSAR EN FILAS Y COLUMNAS
          children: [
////////////////////////////////////////////////////////////////////////////////////////////
            CategoCard(title: producto.categoria.nombre),
///////////////////////////////////////////////////////////////////////////////////////////
            SizedBox( height: 20 ),   
////////////////////////////////////////////////////////////////////////////////////////////
            Genero_card(genderItems:genderItems,estado: 'genero'),
////////////////////////////////////////////////////////////////////////////////////////////
            SizedBox( height: 20 ),   
////////////////////////////////////////////////////////////////////////////////////////////            
            Genero_card(genderItems:colorItems,estado: 'genero'),
////////////////////////////////////////////////////////////////////////////////////////////            
            SizedBox( height: 20 ),   
////////////////////////////////////////////////////////////////////////////////////////////                        
            ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 250 ),
              child: TextFormField(
                initialValue: producto.nombre,
                decoration: CustomInputs.formInputDecoration(
                  hint: 'Referencia del Producto', 
                  label: 'REF', 
                  icon: Icons.store_outlined
                ),
                onChanged: ( value )=> productoFormProvider.copyProductoWith( nombre: value ),
                validator: ( value ) {
                  if ( value == null || value.isEmpty ) return 'Ingrese la referencia del producto.';
                  if ( value.length < 2 ) return 'El nombre debe de ser de dos letras como mínimo.';
                  return null;
                },
              ),
            ),
             
//////////////////////////////////////////////////////////////////////////////////////////// 
            SizedBox( height: 20 ),
////////////////////////////////////////////////////////////////////////////////////////////
            ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 250 ),
              child: TextFormField(
                initialValue: producto.cantidad,
                decoration: CustomInputs.formInputDecoration(
                  hint: 'Cantidad', 
                  label: 'Cantidad disponible', 
                  icon: Icons.numbers_outlined
                ),
                onChanged: ( value )=> productoFormProvider.copyProductoWith( cantidad: value ),
                validator: ( value ) {
                  if ( value == null || value.isEmpty ) return 'Ingrese la cantidad de artículos.';
                  return null;
                },
              ),
            ),
////////////////////////////////////////////////////////////////////////////////////////////
            SizedBox( height: 20 ),
////////////////////////////////////////////////////////////////////////////////////////////
            ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 250 ),
              child: TextFormField(
                initialValue: producto.precio,
                decoration: CustomInputs.formInputDecoration(
                  hint: 'Precio', 
                  label: 'Precio al público', 
                  icon: Icons.attach_money_outlined
                ),
                onChanged: ( value )=> productoFormProvider.copyProductoWith( precio: value ),
                validator: ( value ) {
                  if ( value == null || value.isEmpty ) return 'Ingrese el valor del  artículo.';
                  if ( value.length <= 4 ) return 'La cantidad debe ser en pesos.';
                  return null;
                },
              ),
            ),
////////////////////////////////////////////////////////////////////////////////////////////
            SizedBox( height: 20 ),
////////////////////////////////////////////////////////////////////////////////////////////
            TextFormField(
              initialValue: producto.descripcion,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Descripción del Producto', 
                label: 'Descripción', 
                icon: Icons.supervised_user_circle_outlined
              ),
              onChanged: ( value ){
                productoFormProvider.copyProductoWith( descripcion: value );          
              },

              validator: ( value ) {
                if ( value == null || value.isEmpty ) return 'Ingrese la referencia del producto.';
                if ( value.length < 30 ) return 'La descripción debe contener al menos 20 caracteres.';
                return null;
              },
            ),

////////////////////////////////////////////////////////////////////////////////////////////
            SizedBox( height: 20 ),
////////////////////////////////////////////////////////////////////////////////////////////            
            ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 250 ),
              child: ElevatedButton(
                onPressed: () async {

                 try {
                  final saved = await productoFormProvider.newProducto();
                  final sali = await productosbase.getProductoById(saved['_id'].toString()); 
                   
                  if( sali.id != null) {
                  NotificationsService.showSnackbar('Artículo guardado');
                  Provider.of<ProductosProvider>(context, listen: false).refreshProducto(producto);
                  productoFormProvider.copyProductoWith( id: sali.id);
                  SideMenuProvider.isImag=true;
                                   
                  } else {
                    NotificationsService.showSnackbarError('No se pudo guardar');
                  }
                 } catch (e) {
                   NotificationsService.showSnackbarError('El articulo puede estar repetido');
                 }   

                 
                }, 

                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all( Colors.indigo ),
                  shadowColor: MaterialStateProperty.all( Colors.transparent ),
                ),
                child: Row(
                  children: [
                    Icon( Icons.save_outlined, size: 18 ),
                    Text('Guardar')
                  ],
                )
              ),
            )
////////////////////////////////////////////////////////////////////////////////////////////
          ],
        ),
      )
    
    );
  }
 
}

