import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SelectionHeader extends StatelessWidget {
  const SelectionHeader({
    super.key,
    required this.title,
    this.action="View more",
  });
  final String title;
  final String action;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
        Text(action,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color:Colors.white ),)
      ],
    );
  }
}
