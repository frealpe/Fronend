import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/cards/cards.dart';
import 'package:admin_dashboard/ui/cards/catego_card.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';

import 'package:flutter/material.dart';


///////////////////////////////////////////////////////////////////////////

class ProductoViewForm extends StatelessWidget {
  
  const ProductoViewForm ({
    Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final List<String> genderItems = [
  'DAMA',
  'CABALLERO',
]; 
  final List<String> colorItems = [
  'NEGRO',
  'BLANCO',
  'CAFE',
  'ROJO',
  'AZUL',
  'OTRO',

];   
      final productoFormProvider = Provider.of<ProductoFormProvider>(context);
      final producto = productoFormProvider.producto!;

/////////////////////////////////////////////////////////////////////////////////////////////

    return WhiteCard(     
      title: 'Información especifica',
      child: Form(
        key: productoFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
            //TODO PENSAR EN FILAS Y COLUMNAS
          children: [
////////////////////////////////////////////////////////////////////////////////////////////
            CategoCard(title: producto.categoria.nombre,),
///////////////////////////////////////////////////////////////////////////////////////////
            SizedBox( height: 20 ),   
////////////////////////////////////////////////////////////////////////////////////////////
            Genero_card(genderItems:genderItems,estado: 'genero',),
////////////////////////////////////////////////////////////////////////////////////////////
            SizedBox( height: 20 ),  
////////////////////////////////////////////////////////////////////////////////////////////            
            Genero_card(genderItems:colorItems,estado: 'color'),
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
///////////////////////////////////////////////////////////////////////////////////////////                
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
//                  if ( value.length >= 1 ) return 'La cantidad debe ser .';
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
                  final saved = await productoFormProvider.updateProducto();
                  if( saved ) {
                   NotificationsService.showSnackbar('Artículo actualizado');
                   Provider.of<ProductosProvider>(context, listen: false).refreshProducto( producto );

                  } else {
                    NotificationsService.showSnackbarError('No se pudo guardar');
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

