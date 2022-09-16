import 'package:admin_dashboard/router/admin_handlers.dart';
import 'package:admin_dashboard/router/dashboard_handlers.dart';
import 'package:admin_dashboard/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';


////////////////Nombre de la clase
class Flurorouter{
  
  static final FluroRouter router = new FluroRouter();
  //Se crean las rutas de acceso
  //Principla Page
  static String rootRoute = '/';  
  //Auth Router
  static String loginRoute = '/auth/login';
  //Login
  static String registerRoute = '/auth/register';
  //Dashboard
  static String dashboardRoute = '/dashboard';
  //Productos
  static String productosRoute = '/dashboard/productos';
  //Producto
  static String productoRoute = '/dashboard/productos/:uid';
  //prodCatego
  static String prodCategoRoute = '/dashboard/prodcateg/:uid';
  //newProduc
  static String newProducto = '/dashboard/newproducto';  
  //Categories
  static String categoriesRoute = '/dashboard/categorias';
 //New Categorias
  static String newcategoriesRoute = '/dashboard/newcat';
  //Usuarios
  static String usersRoute = '/dashboard/users';
  //Usarios uid
  static String userRoute = '/dashboard/users/:uid';


  //Blank
  static String blankRoute = '/dashboard/blank';

  //Configuración de las rutas y a cual view se llama
  static void configureRoutes(){
    router.define(rootRoute, handler: AdminHandlers.login,transitionType: TransitionType.none);
    router.define(loginRoute, handler: AdminHandlers.login,transitionType: TransitionType.none);
    router.define(registerRoute, handler: AdminHandlers.register,transitionType: TransitionType.none); 
  
  //Dashboard  
    router.define(dashboardRoute, handler: DashboardHandlers.dashboard);
    router.define(categoriesRoute, handler: DashboardHandlers.categories);       
    router.define(prodCategoRoute, handler: DashboardHandlers.prodCatego);           
    router.define(productosRoute, handler: DashboardHandlers.productos);  
    router.define(productoRoute, handler: DashboardHandlers.producto);  
    router.define(newProducto, handler: DashboardHandlers.newProducto);  
    router.define(newcategoriesRoute, handler: DashboardHandlers.newcategoriesRoute);  

    router.define(usersRoute, handler: DashboardHandlers.users);       
    router.define(userRoute, handler: DashboardHandlers.user);    
  //No page found 404
    router.notFoundHandler= NoPageFoundHandlers.noPageFound;
   
  }

}
