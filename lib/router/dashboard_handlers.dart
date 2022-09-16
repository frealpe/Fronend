
import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/views/newcategories.dart';
import 'package:admin_dashboard/ui/views/newproducto_view.dart';
import 'package:admin_dashboard/ui/views/producto_view.dart';
import 'package:admin_dashboard/ui/views/productos_view.dart';

import 'package:admin_dashboard/ui/views/categories_view.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';

import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/user_view.dart';
import 'package:admin_dashboard/ui/views/users_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class DashboardHandlers {

static Handler dashboard =  Handler(
  handlerFunc: (context,params){
  //        return DashboardView();
  
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context,listen: false)
    .setCurrentPageUrl(Flurorouter.dashboardRoute);

    if(authProvider.authStatus == AuthStatus.authenticated)
    return DashboardView();      
    else 
    return LoginView();
    
    }
  
  );
///////////////////////////////////////////////////////////////
static Handler productos =  Handler(
  handlerFunc: (context,params){
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context,listen: false)
    .setCurrentPageUrl(Flurorouter.productosRoute);    
    if(authProvider.authStatus == AuthStatus.authenticated)
    return ProductosView(estado:'true');      
    else 
    return LoginView();
    
    }
  );
///////////////////////////////////////////////////////////////
static Handler newProducto =  Handler(
  handlerFunc: (context,params){
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context,listen: false)
    .setCurrentPageUrl(Flurorouter.productosRoute);    
    if(authProvider.authStatus == AuthStatus.authenticated)
      {
        return NewProductoView(uid:params['uid']?.first);

      }
    else 
    return LoginView();   
  }
  );
///////////////////////////////////////////////////////////////
static Handler prodCatego =  Handler(
  handlerFunc: (context,params){
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context,listen: false)
    .setCurrentPageUrl(Flurorouter.productosRoute);    
    if(authProvider.authStatus == AuthStatus.authenticated){
      if(params['uid']?.first != null){
        
        return ProductosView(estado:'false',val:params['uid']?.first);      
      }else{
            return CategoriesView();
      }

    }else {return LoginView(); }
    
    }
  );
///////////////////////////////////////////////////////////////
static Handler producto =  Handler(
  handlerFunc: (context,params){
  //        return DashboardView();
  
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context,listen: false)
    .setCurrentPageUrl(Flurorouter.productoRoute);    
    if(authProvider.authStatus == AuthStatus.authenticated){
      if(params['uid']?.first != null){
        return ProductoView(uid: params['uid']!.first);
      }else{
        ProductosView(estado: 'true');
      }
      
    }else {return LoginView();  }
    
    }
  
  );
///////////////////////////////////////////////////////////////
static Handler categories =  Handler(
  handlerFunc: (context,params){
 
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context,listen: false)
    .setCurrentPageUrl(Flurorouter.categoriesRoute);    
    if(authProvider.authStatus == AuthStatus.authenticated)
    return CategoriesView();      
    else 
    return LoginView();  
    }
  
  );
///////////////////////////////////////////////////////////////
static Handler newcategoriesRoute =  Handler(
  handlerFunc: (context,params){
 
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context,listen: false)
    .setCurrentPageUrl(Flurorouter.categoriesRoute);    
    if(authProvider.authStatus == AuthStatus.authenticated)
    return NewCategory();      
    else 
    return LoginView();  
    }
  
  );
///////////////////////////////////////////////////////////////
static Handler users =  Handler(
  handlerFunc: (context,params){
 
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context,listen: false)
    .setCurrentPageUrl(Flurorouter.usersRoute);    
    if(authProvider.authStatus == AuthStatus.authenticated)
    return UsersView();      
    else 
    return LoginView();  
    }
  
  );

///////////////////////////////////////////////////////////////
static Handler user =  Handler(
  handlerFunc: (context,params){

    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context,listen: false)
    .setCurrentPageUrl(Flurorouter.userRoute);    

    if(authProvider.authStatus == AuthStatus.authenticated){
      if(params['uid']?.first != null){
        return UserView(uid: params['uid']!.first);
      }else{
        UsersView();
      }
      
    }else {return LoginView();  }
    
    }
  
  );
}