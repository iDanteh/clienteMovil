import 'package:flutter/material.dart';

class CardInformation extends StatefulWidget {
  const CardInformation({super.key});

  @override
  State<CardInformation> createState() => _CardInformationState();
}

class _CardInformationState extends State<CardInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(title: Text('Agrega tu tarjeta')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                    TextFormField(decoration: InputDecoration(hintText: 'Numero de tarjeta',
                    icon: Icon(Icons.credit_card)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}