
import 'package:admin_dashboard/providers/producto_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/api/BolsosApi.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';




void main() async{


  await LocalStorage.configurePrefs();
  BolsosApi.configureDio();
  Flurorouter.configureRoutes();

  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          lazy:false,
          create: (_)=> AuthProvider()
          ),

        ChangeNotifierProvider(
          lazy:false,
          create: (_)=> SideMenuProvider()
          ),

        ChangeNotifierProvider(
          //lazy:false,
          create: (_)=> UsersProvider()
          ),          
        ChangeNotifierProvider(
          //lazy:false,
          create: (_)=> UserFormProvider()
          ),

        ChangeNotifierProvider(
          //No necesita el Lazy por que se crea por demanda 
          create: (_)=> ProductosProvider()
          ),

        ChangeNotifierProvider(
          //No necesita el Lazy por que se crea por demanda 
          create: (_)=> ProductoFormProvider()
          ),

        ChangeNotifierProvider(
          //No necesita el Lazy por que se crea por demanda 
          create: (_)=> CategoriaFormProvider()
          ),

        ChangeNotifierProvider(
          //No necesita el Lazy por que se crea por demanda 
          create: (_)=> CategoriesProvider()
          ),
        
        ChangeNotifierProvider(
          //No necesita el Lazy por que se crea por demanda 
          create: (_)=> CounterProvider()
          ),


      ],
      child: MyApp(),
      );
    
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marroquineria Marr??n',
      //initialRouter: Flurorouter.rootRoute es valido
      initialRoute: '/',      //Toma el widget Colocar /
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationServer.navigatorKey,       //Me permite navegar
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_,child){ //child contiene el loginview ya que la ruta widgetLoginView '/'

      final authProvider = Provider.of<AuthProvider>(context);

      if(authProvider.authStatus == AuthStatus.checking)
      return SplashLayout();

      if(authProvider.authStatus == AuthStatus.authenticated){
      return DashboardLayout(child: child!);
        //    return DashboardLayout();
      }else{
      return AuthLayout(child:child!);}
        //return AuthLayout(child:child!);
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(
            Colors.grey.withOpacity(0.5)
          )
        )
      ),

    );
  }
}