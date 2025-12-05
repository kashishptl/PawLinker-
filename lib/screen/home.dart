import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pawlinker/lists/headingsAdopt.dart';
import 'package:pawlinker/lists/headingsCare.dart';
import 'package:pawlinker/lists/headingsHome.dart';
import 'package:pawlinker/screen/cart.dart';
import 'package:pawlinker/widgets/displayItems.dart';
import 'package:pawlinker/widgets/likedItems.dart';
import 'package:pawlinker/widgets/sideDrawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int currentBottom = 0;
  Widget ActiveWidget = DisplayItems(headings: HeadingsHome, CurrentIndex: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            "lib/resources/logo.png",
            fit: BoxFit.cover,
            width: 150,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.menu_rounded),
              tooltip: 'Menu',
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            iconSize: 30,
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Cart',
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ],
      ),
      drawer: SideDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(FontAwesome.bowl_rice_solid), label: "Pet Care"),
          BottomNavigationBarItem(icon: Icon(Iconsax.pet_bold), label: "Pet Adoption"),
          BottomNavigationBarItem(icon: Icon(HeroIcons.heart), label: "Liked"),
        ],
        backgroundColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (index) {
          setState(() {
            currentBottom = index;
            if (index == 0) {
              ActiveWidget = DisplayItems(headings: HeadingsHome, CurrentIndex: 0);
            } else if (index == 1) {
              ActiveWidget = DisplayItems(headings: HeadingsCare, CurrentIndex: 1);
            } else if (index == 2) {
              ActiveWidget = DisplayItems(headings: HeadingsAdopt, CurrentIndex: 2);
            } else {
              ActiveWidget = LikedItems();
            }
          });
        },
        currentIndex: currentBottom,
      ),
      body: ActiveWidget,
    );
  }
}
