
import 'package:admin_dashboard/providers/providers.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/shared/widges/card_swiper.dart';
import 'package:admin_dashboard/ui/shared/widges/movie_slider.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthProvider>(context).user!;

    //TODO INICIAR CATEGORIAS 

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Tienda en Articulos de Cuero',style: CustomLabels.h1),
          SizedBox(height: 10),
          PrincipalView(),
        ],
      ),
    );
  }
}

class PrincipalView extends StatelessWidget {
  const PrincipalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriaProvider = Provider.of<CategoriesProvider>(context);
    final productosProvider = Provider.of<ProductosProvider>(context);
    final value = Provider.of<CounterProvider>(context,listen: false);
    value.dataNow(productosProvider.productos.length,productosProvider.productos.length);
    return Container(

        child: Column(

          children: [         
////////////////////////////////////////////////////////              
            SizedBox( height: 10 ), 
////////////////////////////////////////////////////////
            CardSwiper(
            productos:productosProvider.productos            
            ),
////////////////////////////////////////////////////////////
            SizedBox( height: 30 ), 
////////////////////////////////////////////////////////////            
            MovieSlider(
            categoria: categoriaProvider.categorias,
            title: 'Categorías',
            onNexPage: () => categoriaProvider.getCategories(),
            ), 
          ],
        ),
      );
  }
}
