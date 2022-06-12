import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllquAppBar extends StatelessWidget {
  const AllquAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            if(Navigator.canPop(context))  IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => {
                Navigator.pop(context)
              },
            ),
            SizedBox(width: 20.0),
            Text('Allqu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      )
    );
  }
}