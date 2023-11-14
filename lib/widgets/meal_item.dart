import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:meals/widgets/meal_item_trail.dart';

import 'package:meals/models/meal.dart';

class MealItem extends StatelessWidget {
  MealItem({super.key, required this.meal, required this.onMealTap});

  final Meal meal;
  final void Function() onMealTap;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onMealTap,
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: InkWell(
          onTap: onMealTap,
          child: Stack(
            children: [
              Hero(
                tag: meal.id,
                child: FadeInImage(
                  placeholder: MemoryImage(
                      kTransparentImage), //place holder untill real image is not downloaded from internet
                  image: NetworkImage(
                      meal.imageUrl), //downloading IMG from internet
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom:
                    0, //means positioned widget start from bottom of above widget and start from left to all the way to right
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 44,
                  ),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2, //only display title in 2 lines
                        softWrap: true,
                        overflow: TextOverflow
                            .ellipsis, // extra word will be replace with ...
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrail(
                              icon: Icons.schedule,
                              label: '${meal.duration} min'),
                          const SizedBox(
                            width: 12,
                          ),
                          MealItemTrail(
                            icon: Icons.work,
                            label: complexityText,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          MealItemTrail(
                            icon: Icons.work,
                            label: affordabilityText,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
