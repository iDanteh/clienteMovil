import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicios_apis/components/myButton.dart';
import 'package:servicios_apis/components/confirmationDialog.dart';
import 'package:servicios_apis/screens/payment_creens/success_dialog.dart';

class CardInformation extends StatefulWidget {
  const CardInformation({super.key});

  @override
  State<CardInformation> createState() => _CardInformationState();
}

class _CardInformationState extends State<CardInformation> {
  void _buyProduct(BuildContext context) {
    ConfirmationDialogPayment.showSuccessDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: Text('Agrega tu tarjeta'),
        centerTitle: true
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido verticalmente
            children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19),
                        CardNumberInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Número de tarjeta',
                        icon: Icon(Icons.credit_card),
                        border: InputBorder.none, 
                        contentPadding: EdgeInsets.all(15), // Padding interno
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Nombre del titular',
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: "CVV",
                              icon: Icon(Icons.password),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.digitsOnly,
                              CardMontInputFormatter(),
                            ],
                            decoration: InputDecoration(
                              hintText: "MM/YY",
                              icon: Icon(Icons.date_range),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30), // Espacio entre campos y botón
                    MyButton(
                      onTap: () => ConfirmationDialog.show(
                        context,
                        title: "Confirmar compra",
                        content: "¿Desea realizar el pago de su producto?",
                        onConfirm: () => _buyProduct(context),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50), // Espacio inferior adicional
            ],
          ),
        ),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, TextEditingValue newValue){
      if (newValue.selection.baseOffset == 0){
        return newValue;
      }

      String inputData = newValue.text;
      StringBuffer buffer = StringBuffer();

      for (var i = 0; i < inputData.length; i++){
        buffer.write(inputData[i]);
        int index = i + 1;

        if(index % 4 == 0 && inputData.length != index){
          buffer.write("  "); //Double space
        }
      }

      return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.toString().length)
      );
  } 
}

class CardMontInputFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, TextEditingValue newValue){
      var newText = newValue.text;

      if (newValue.selection.baseOffset == 0){
        return newValue;
      }

      var buffer = StringBuffer();

      for(int i = 0; i < newText.length; i++){
        buffer.write(newText[i]);
        var nonZeroIndex = i + 1;
        if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length){
          buffer.write('/');
        }
      }

      var string = buffer.toString();
      return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length)
      );
  } 
}