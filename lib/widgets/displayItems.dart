import 'package:flutter/material.dart';
import 'package:pawlinker/model/heading.dart';
import 'package:pawlinker/widgets/thumbnail.dart';

class DisplayItems extends StatefulWidget {
  DisplayItems({super.key, required this.headings, required this.CurrentIndex});
  int CurrentIndex;
  List<Heading> headings;

  @override
  State<DisplayItems> createState() => _DisplayItemsState();
}

class _DisplayItemsState extends State<DisplayItems> {
  @override
  Widget build(BuildContext context) {
    List<Details> items = widget.headings[headingIndex[widget.CurrentIndex]].lists;
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (int i = 0; i < widget.headings.length; i++)
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  onTap: () {
                    setState(() {
                      headingIndex[widget.CurrentIndex] = i;
                    });
                  },
                  child: Builder(
                    builder: (context) {
                      if (headingIndex[widget.CurrentIndex] == i) {
                        return AnimatedContainer(
                          margin: EdgeInsets.all(3),
                          padding: EdgeInsets.all(3),
                          width: 200,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary.withAlpha(20),
                                Theme.of(context).colorScheme.primary.withAlpha(40),
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(widget.headings[i].icon, color: Theme.of(context).colorScheme.primary),
                              SizedBox(width: 10),
                              Text(
                                widget.headings[i].title,
                                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        );
                      } else {
                        return AnimatedContainer(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          width: 125,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.secondary.withAlpha(10),
                                Theme.of(context).colorScheme.secondary.withAlpha(20),
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(widget.headings[i].icon, color: Theme.of(context).colorScheme.secondary),
                              SizedBox(width: 10),
                              Text(widget.headings[i].title, style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                              SizedBox(width: 10),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 65.0,
              mainAxisExtent: 190,
            ),
            itemBuilder: (context, index) {
              return ThumbNail(item: items[index]);
            },
          ),
        ),
      ],
    );
  }
}
