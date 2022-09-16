
import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/cards/cards.dart';
import 'package:admin_dashboard/ui/cards/imag_cardcat.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';



class NewCategory extends StatefulWidget {

  const NewCategory({
    Key? key, 
    }) : super(key: key);

  @override
  State<NewCategory> createState() => _NewCategoryState();
}


class _NewCategoryState extends State<NewCategory> {

  Categoria? categoria;
  @override
  void initState() {

    super.initState();

    final categoriaFromProvider = Provider.of<CategoriaFormProvider>(context,listen: false);

    SideMenuProvider.isImag=false;
    
    categoria = Categoria(id: '', nombre: '');

        setState((){categoria;});   
        categoriaFromProvider.categoria=categoria;
        categoriaFromProvider.formKey = new GlobalKey<FormState>(); 
  }

  @override
  Widget build(BuildContext context) {

 //final Categoria? categoria; 
return Container(
      padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),          
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Nuevo Articulo:',style: CustomLabels.h1),
          SizedBox(height: 10),
           
            _CateViewBody()

        ],
      ),
    );
  }
}
////////////////////////////////////////////////////////////

class _CateViewBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    //final categoria = Provider.of<CategoriesProvider>(context).categorias;  
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
                ImagenContainerC(),                  
              _CategoViewForm(),


            ]
          )
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////

class _CategoViewForm extends StatelessWidget {
  
        
    const _CategoViewForm ({
    Key? key,
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

      //final productoFormProvider = Provider.of<ProductoFormProvider>(context);
      final categoriabase = Provider.of<CategoriesProvider>(context);
      final categoryFromProvider = Provider.of<CategoriaFormProvider>(context);
      final categoria = categoryFromProvider.categoria!;
///////////////////////////////////////////////////////////////////////////      
    return WhiteCard(     
      title: 'Nombre de la Categoría',
      child: Form(
        key: categoryFromProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
            //TODO PENSAR EN FILAS Y COLUMNAS
          children: [
 ////////////////////////////////////////////////////////////////////////////////////////////
            ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 250 ),
              child: TextFormField(
                initialValue: '',
                decoration: CustomInputs.formInputDecoration(
                  hint: 'Referencia de la Categoria', 
                  label: 'NOMBRE', 
                  icon: Icons.store_outlined
                ),
                onChanged: ( value ) {
                  
                  categoryFromProvider.copyCategoriaWith( nombre: value);

                  },
                
                validator: ( value ) {
                  if ( value == null || value.isEmpty ) return 'Ingrese la referencia de la categoria.';
                  if ( value.length < 4 ) return 'El nombre debe de ser de dos letras como mínimo.';
                  return null;
                },
              ),
            ),
////////////////////////////////////////////////////////////////////////////////////////////
              SizedBox( height: 20 ),
////////////////////////////////////////////////////////////////////////////////////////////         
            ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 250 ),
              child: ElevatedButton(
                onPressed: () async {
                  try{
                    ///TODO TERMINAR CATEGORIAS
                    final saved = await categoryFromProvider.newCategoryp();
                    final sali = await categoriabase.getCategoriesById(saved['_id'].toString());
                    if( sali.id != null) {
                    NotificationsService.showSnackbar('Categoria Creada');
                    Provider.of<CategoriesProvider>(context, listen: false).refreshCategoria(categoria);
                    categoryFromProvider.copyCategoriaWith( id: sali.id);                    
                    SideMenuProvider.isImag=true;

                    } 
                      else {
                    NotificationsService.showSnackbarError('No se pudo guardar');
                  }                       
                  }
                  catch(e){
                    NotificationsService.showSnackbarError('La Categoria puede estar repetida');
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

