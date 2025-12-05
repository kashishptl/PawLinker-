import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawlinker/model/heading.dart';
import 'package:pawlinker/provider/favoriteProvider.dart';
import 'package:pawlinker/screen/itemDetails.dart';

class ThumbNail extends ConsumerWidget {
  final Details item;
  const ThumbNail({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Details> favorites = ref.watch(favoriteProvider);
    IconData genderIcon = item.gender == Gender.Male ? Icons.male : Icons.female;
    Color genderColor = item.gender == Gender.Male ? Colors.blue : Colors.pink;
    Color heartColor = favorites.contains(item) ? Colors.pink : Colors.grey;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetails(item: item)));
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Hero(
                  tag: item.id,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(item.image[0], height: 135, width: double.maxFinite, fit: BoxFit.cover),
                  ),
                ),
              ),
              // Info card
              Positioned(
                top: 110,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 130,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title & Heart Icon
                          Text(
                            item.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 4),

                          Text(
                            item.description,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (item.isPet) Icon(genderIcon, size: 20, color: genderColor),
                              Spacer(),
                              if (item.price != null)
                                Text(
                                  '₹${item.price}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.teal[700]),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {
              ref.read(favoriteProvider.notifier).changeFav(item);
            },
            icon: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.surface.withAlpha(200)),
              padding: EdgeInsets.all(2),
              child: Icon(Icons.favorite_rounded, color: heartColor, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
