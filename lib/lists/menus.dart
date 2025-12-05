import 'package:flutter/material.dart';
import 'package:pawlinker/model/menu.dart';
import 'package:pawlinker/screen/cart.dart';
import 'package:pawlinker/screen/help.dart';
import 'package:pawlinker/screen/login.dart';
import 'package:pawlinker/screen/order.dart';
import 'package:pawlinker/screen/profile.dart';

List<Menu> Menus = [
  Menu(icon: Icons.account_circle, title: "Profile", screen: Profile()),
  Menu(icon: Icons.shopping_cart, title: "Cart", screen: CartScreen()),
  Menu(icon: Icons.shopping_bag_rounded, title: "Orders", screen: Order()),
  Menu(icon: Icons.help, title: "Help", screen: Help()),
  Menu(icon: Icons.logout, title: "Log out", screen: Login()),
];
