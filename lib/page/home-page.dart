import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String operaciones = "";
  String resultadoOperaciones = "";
  String mensaje = "";
  String expresion = "";
  RegExp re = RegExp(
      r'([+-]{2,})|([x\/]{2,})|([^0-9]\%)|(^[+-]{2,})|(^[\/x]+)|([0-9]\/0)');
  List<Text> listaResultados = [];

  var aux = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
        ),
        body: _body());
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: listaResultados,
                )
              ]),
            ),
          ),
        ),
        Container(
            color: Colors.blue,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.yellow,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(operaciones,
                                style: TextStyle(
                                  fontSize: 14.0,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      mensaje,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    )
                  ])
                ],
              ),
            )),
        Container(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "7";
                    });
                  },
                  child: Text("7"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "8";
                    });
                  },
                  child: Text("8"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "9";
                    });
                  },
                  child: Text("9"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (operaciones != "") {
                        operaciones += " / ";
                        expresion += "/";
                      }
                    });
                  },
                  child: Text("/"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (operaciones != "") {
                        // operaciones += " √ ";
                      }
                    });
                  },
                  child: Text("√"),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "4";
                    });
                  },
                  child: Text("4"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "5";
                    });
                  },
                  child: Text("5"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "6";
                    });
                  },
                  child: Text("6"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (operaciones != "") {
                        operaciones += " x ";
                        expresion += "x";
                      }
                    });
                  },
                  child: Text("x"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (operaciones != "") {
                        operaciones += " % ";
                        expresion += "%";
                      }
                    });
                  },
                  child: Text("%"),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "1";
                    });
                  },
                  child: Text("1"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "2";
                    });
                  },
                  child: Text("2"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "3";
                    });
                  },
                  child: Text("3"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (operaciones != "") {
                        operaciones += " - ";
                        expresion += "-";
                      }
                    });
                  },
                  child: Text("-"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("x²"),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones = "";
                    });
                  },
                  child: Text("C"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "0";
                    });
                  },
                  child: Text("0"),
                ),
                ElevatedButton(
                  onPressed: calcularOperaciones,
                  child: Text("="),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (operaciones != "") {
                        operaciones += " + ";
                        expresion += "+";
                      }
                    });
                  },
                  child: Text("+"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(" "),
                ),
              ])
            ],
          ),
        ),
      ],
    );
  }

  validar(){
     if (re.hasMatch()){
      setState((){
        mensaje="";
      });

      return;

    }
  }

  calcularOperaciones() {
    var lista = operaciones.trim().split(" ");
    
   
    
    var r = calcular(lista);
  }

  bool esNumero(String str) {
    return (str == null) ? false : double.tryParse(str) != null;
  }

  double calcular(List<String> lista) {
    print("Inicio*******");
    print("lista $lista");

    var aux = 0.0;
    var a = "";
    var b = "";
    var operador = "";

    if (lista.length < 3) {
      return double.parse(lista.first.trim());
    }

    if (lista.first.trim() == "(" || lista.first.trim() == "") {
      lista.removeAt(0);
      return 1 * calcular(lista);
    }

    a = lista.removeAt(0).trim();

    if (a == "-") {
      a = "-" + lista.removeAt(0).trim();
    } else if (a == "+") {
      a = lista.removeAt(0).trim();
    }

    operador = lista.removeAt(0).trim();

    print("Operador...$operador");

    if (operador.isEmpty || esNumero(operador)) {
      lista.insert(0, "$a ");
      return calcular(lista);
    }

    /*if(esNumero(operador)){
    
    lista.insert(0, "$a ");
    return calcular(lista);
   }*/

    /* if (operador == "(") {
      print("$a x $lista");
      aux = double.parse(a) * calcular(lista);
      lista.insert(0, "$aux ");
      print("(->Sub total: $aux ");
    }*/

    if (operador == "%") {
      print("$a +  -> $lista");
      aux = double.parse(a) / 100;
      lista.insert(0, "$aux ");
      print("+ -> Sub total: $aux ");
    }

    if (operador == "+") {
      print("$a +  -> $lista");
      aux = double.parse(a) + calcular(lista);
      lista.insert(0, "$aux ");
      print("+ -> Sub total: $aux ");
    }

    if (operador == "-") {
      print("$a -  -> $lista");
      aux = double.parse(a) - calcular(lista);
      lista.insert(0, "$aux ");
      print("- ->Sub total: $aux ");
      return aux;
    }

    if (operador == "x") {
      b = lista.first.trim(); //Validar si no es un numero!!!
      lista.removeAt(0);
      print("$a * $b -> $lista");
      aux = double.parse(a) * double.parse(b);
      lista.insert(0, "$aux ");
      print("x -> Sub total: $aux ");
    }

    if (operador == "/") {
      //Validar division por cero
      b = lista.removeAt(0).trim(); //Validar mayor que cero!!!
      print("$a / $b -> $lista");
      aux = double.parse(a) / double.parse(b);
      lista.insert(0, "$aux");
      print("/ -> Sub total: $aux ");
    }

    /*if (operador == ")") {
      print(") Es num $a -> $lista");

      return double.parse(a);
    }*/

    return (lista.length > 2) ? calcular(lista) : aux;
  }
}
aux;
  }

  
}
