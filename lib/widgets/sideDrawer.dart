import 'package:flutter/material.dart';
import 'package:pawlinker/lists/menus.dart';
import 'package:pawlinker/lists/users.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => SideDrawerState();
}

class SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 150,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(tempUser.image),
                    radius: 40,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,\n${tempUser.name}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 150),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              ),
              height: double.infinity,
              child: Image.asset(
                color: Theme.of(context).colorScheme.primary.withAlpha(25),
                "lib/resources/background.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 150, 10, 10),
            child: ListView.builder(
              itemCount: Menus.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Menus[index].icon, color: Theme.of(context).colorScheme.primary),
                  title: Text(
                    Menus[index].title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  onTap: () {
                    setState(() {
                      if ("Log out" == Menus[index].title) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menus[index].screen));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Menus[index].screen));
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
