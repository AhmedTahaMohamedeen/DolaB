
import 'package:adminappp/constants/userInfo.dart';
import 'package:flutter/material.dart';

import 'Screens/Admin/admin_order/AdminOrders.dart';
import 'Screens/Admin/store_settings/store_settings.dart';
import 'Screens/Admin/PeopleLikes.dart';
import 'Screens/Admin/admin_store_profile/StoreProfile.dart';
import 'Screens/Admin/add_product/addProduct.dart';
import 'Screens/Admin/admin_product_view/adminProductView.dart';
import 'Screens/Admin/edit_product/editProductScreen.dart';
import 'Screens/Admin/store_settings/editStorePhoto.dart';
import 'Screens/Admin/followers.dart';
import 'Screens/Admin/store_properties/store_properties.dart';
import 'Screens/Chat_screens/Admin/Admin_Chat.dart';
import 'Screens/Chat_screens/User/User_chat.dart';
import 'Screens/Chat_screens/User/user_messages.dart';
import 'Screens/User/user_shopping_cart/ShoppingCart.dart';
import 'Screens/User/following_screen.dart';

import 'Screens/User/user_order/userOrders.dart';
import 'Screens/adminOrdersScreen.dart';
import 'Screens/beginningScreens/loadingScreen.dart';
import 'Screens/beginningScreens/phoneLogin.dart';
import 'Screens/deliveryScreen.dart';
import 'Screens/search_Screens/StoresOnMap.dart';
import 'Screens/search_Screens/peoduct_search/search_product.dart';
import 'Screens/search_Screens/store_search/search_stores_all.dart';

import 'Screens/trend/Trend_Products.dart';
import 'Screens/trend/Trend_Stores.dart';
import 'Screens/User/edit_user/editUser.dart';
import 'Screens/User/edit_user/editUserPhoto.dart';
import 'Screens/User/loveScreen.dart';
import 'Screens/User/user_product_view/user_product_view.dart';
import 'Screens/User/user_profile/userProfile.dart';
import 'Screens/home/HomeScreen.dart';
import 'Screens/beginningScreens/LoginScreen.dart';
import 'Screens/beginningScreens/SignupScreen.dart';

import 'Screens/beginningScreens/firstScreen.dart';
import 'Screens/createStore.dart';


import 'Screens/beginningScreens/loggingchoose.dart';

import 'Screens/Chat_screens/Admin/Admin_messages.dart';
import 'Screens/noStore.dart';
import 'Screens/beginningScreens/registerChoose.dart';
import 'Screens/search_Screens/store_search/search_store.dart';
import 'Screens/search_Screens/select_search.dart';
import 'Screens/strangers/stranger_store_profile/stranger_store_profile.dart';

import 'Screens/beginningScreens/verify1.dart';
import 'Screens/beginningScreens/verify2.dart';
import 'Screens/beginningScreens/verify3.dart';
import 'Screens/strangers/stranger_userProfile.dart';
import 'Screens/testingBota.dart';
import 'Screens/trend/select_trend.dart';
import 'Screens/Show_Photo.dart';
import 'constants/AdminInfo.dart';
import 'constants/productInfo.dart';


Map<String,WidgetBuilder>routes={

  Home.route:(context)=>const Home(),
  FirstScreen.route:(context)=>const  FirstScreen(),
  VerifyScreen1.route:(context)=> const VerifyScreen1(),
  VerifyScreen2.route:(context)=>  const VerifyScreen2(),
  VerifyScreen3.route:(context)=>const VerifyScreen3(),
  LoginScreen.route:(context)=>const  LoginScreen(),
  ShowPhoto.route:(context)=>const ShowPhoto(),
  UserMessages.route:(context)=>const UserMessages(),
  AdminMessages.route:(context)=>const AdminMessages(),
  StoreProfileScreen.route:(context)=>const StoreProfileScreen(),
  CreateStore.route:(context)=> const CreateStore(),
  NoStore.route:(context)=>const NoStore(),
  AddProductScreen.route:(context)=>  AddProductScreen(admin: Admin(),),
  AdminProductView.route:(context)=>  AdminProductView(product: Product(),),
  EditProductScreen.route:(context)=>  EditProductScreen(admin: Admin(),product: Product()),
  SignUpScreen.route:(context)=> const SignUpScreen(),
  LoggingChoosesScreen.route:(context)=> const LoggingChoosesScreen(),
  RegisterChoosesScreen.route:(context)=> const RegisterChoosesScreen(),
  StoreSettings.route:(context)=> const StoreSettings(),
  UserProductView.route:(context)=>  UserProductView(product: Product(),admin: Admin(),),
  FollowersScreen.route:(context)=> const FollowersScreen(),
  UserProfileScreen.route:(context)=> const UserProfileScreen(),
  EditStorePhoto.route:(context)=> const EditStorePhoto(),
  EditStoreCover.route:(context)=>  EditStoreCover(),
  EditUserPhoto.route:(context)=> const EditUserPhoto(),
  EditUserInfo.route:(context)=> const EditUserInfo(),
  StrangerStore.route:(context)=>  StrangerStore(admin: Admin(),),
  StrangerUser.route:(context)=>  StrangerUser(userInfoo: UserInfoo(),),
  LoveScreen.route:(context)=>  LoveScreen(),
  TrendProducts.route:(context)=>  TrendProducts(selectedSex: '',selectedType: '',),
  TrendStores.route:(context)=>  TrendStores(selectedSex: '',selectedType: '',),
  BotaTest.route:(context)=>  BotaTest(),
  UserChat.route:(context)=>  UserChat(adminId: '',),
  AdminChat.route:(context)=>  AdminChat(userId: '',),
  PeopleLikes.route:(context)=>  PeopleLikes(product:  Product(),),
  SelectSearch.route:(context)=>  SelectSearch(),
  SearchStore.route:(context)=>  SearchStore(selectedSex: '',selectedType: '',),
  SearchProduct.route:(context)=>  SearchProduct(selectedType: '',selectedSex: '', ),
  SelectTrend.route:(context)=>  SelectTrend(),
  FollowingScreen.route:(context)=>  FollowingScreen(),
  PhoneLogin.route:(context)=>  PhoneLogin(),
  Search_Stores_all.route:(context)=>  Search_Stores_all(),
  StoreProperties.route:(context)=>  StoreProperties(),
  UserOrders.route:(context)=>  UserOrders(),
  AdminOrders.route:(context)=>  AdminOrders(),
  UserShoppingCart.route:(context)=>  UserShoppingCart(),
  DeliveryScreen.route:(context)=>  DeliveryScreen(),
  AdminOrderScreen.route:(context)=>  AdminOrderScreen(),
  StoresOnMap.route:(context)=>  StoresOnMap(),
  LoadingScreen.route:(context)=>  LoadingScreen(),












};