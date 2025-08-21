import 'package:dwarka_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:whiteColor ,
      appBar: AppBar(
        actions: [
          Container(
            decoration: BoxDecoration(
              color: textFieldColor,
              borderRadius: BorderRadius.circular(50.0),
            ),
            padding:const EdgeInsets.only(right: 20.0),
            child: Icon(Iconsax.heart,
            ),
          )
        ],
      ),
    );
  }
}
