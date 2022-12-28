import 'package:flutter/material.dart';

class Biography extends StatelessWidget {

String ?biography ;
Biography(this.biography);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biography'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                child: Text('${biography}',style: Theme.of(context).textTheme.subtitle1,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
