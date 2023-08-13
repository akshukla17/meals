import 'package:flutter/material.dart';

class FilterTile extends StatelessWidget {
  const FilterTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.curState,
      required this.onFilterState});

  final String title;
  final String subTitle;
  final bool curState;
  final bool onFilterState;

  @override
  Widget build(BuildContext context) {
    return const Text('TODO below change in future');
    // return SwitchListTile(
    //         value: curState,
    //         onChanged: (){ todoChange()},
    //         // onChanged: (){},
    //         title: Text(
    //           "Gluten-free",
    //           style: Theme.of(context).textTheme.titleLarge!.copyWith(
    //                 color: Theme.of(context).colorScheme.onBackground,
    //               ),
    //         ),
    //         subtitle: Text(
    //           "Only include gluten free meals",
    //           style: Theme.of(context).textTheme.labelMedium!.copyWith(
    //                 color: Theme.of(context).colorScheme.onBackground,
    //               ),
    //         ),
    //         activeColor: Theme.of(context).colorScheme.tertiary,
    //         contentPadding: const EdgeInsets.only(
    //           left: 34,
    //           right: 22,
    //         ),
    //       );
  }
}
