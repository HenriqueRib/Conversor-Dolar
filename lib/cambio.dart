import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cambio extends StatefulWidget {
  @override
  _CambioState createState() => _CambioState();
}

class _CambioState extends State<Cambio> {
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _cotacaoController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();
  var _resultado = '';

  _onItemTapped(int index){
    if (index == 0){
      _quantidadeController.clear();
      _cotacaoController.clear();
      setState(() {
        _resultado = '';
      });
    } else if (_quantidadeController.text.isEmpty || _cotacaoController.text.isEmpty){
      key.currentState.showSnackBar(SnackBar(
          content: Text('Quantidade ou cotação são obrigatorios.')
      ));
    } else {
      try{
        var quantidade = double.parse(_quantidadeController.text);
        var cotacao = double.parse(_cotacaoController.text);
        var result = quantidade / cotacao;
        setState(() {
         _resultado = 'Com $quantidade reais é possivel comprar ${result.toStringAsFixed(2)} dólares a $cotacao cada';
        });
      } catch (e){
          key.currentState.showSnackBar(SnackBar(
            content: Text('Quantidade ou cotação foram informados em formato inválido.')
          ));
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(title: Text('Caucula Dolar')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _quantidadeController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: 'Quantidade em Reais',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
              )
            ),
          ),
          TextField(
            controller: _cotacaoController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: 'Cotação do Dolar',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                )
            ),
          ),
          Text('$_resultado', style: TextStyle(fontSize: 30))
        ],
      ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.indigoAccent,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.clear, color: Colors.white, size: 20,),
              title: Text('Limpar', style: TextStyle(color: Colors.white, fontSize: 20),)
            ),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.check, color: Colors.white, size: 20,),
                title: Text('Calcular', style: TextStyle(color: Colors.white, fontSize: 20),)
            )
          ],
        ),
    );
  }
}
