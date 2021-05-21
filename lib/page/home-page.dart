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
      r'/([+-]{2,})|([x\/]{2,})|([^0-9]\%)|(^[+-]{2,})|(^[\/x%]+)|([0-9]\/0)|([^0-9\%][\/x])/gm');
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: listaResultados,
                  )
                ],
              ),
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
                            child: Text(
                              operaciones,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
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
                  child: Text("7"),
                  onPressed: () => validar("7"),
                ),
                ElevatedButton(
                  child: Text("8"),
                  onPressed: () => validar("8"),
                ),
                ElevatedButton(
                  child: Text("9"),
                  onPressed: () => validar("9"),
                ),
                ElevatedButton(
                  child: Text("/"),
                  onPressed: () => validar(" / "),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      double res = 0;

                      try {
                        res = calcular(operaciones.trim().split(" "));
                        res = sqrt(res);
                      } catch (exception) {
                        res = 0;
                      }

                      addResultado(res.toString());
                    });
                  },
                  child: Text("√"),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                  child: Text("4"),
                  onPressed: () => validar("4"),
                ),
                ElevatedButton(
                  child: Text("5"),
                  onPressed: () => validar("5"),
                ),
                ElevatedButton(
                  child: Text("6"),
                  onPressed: () => validar("6"),
                ),
                ElevatedButton(
                  child: Text("x"),
                  onPressed: () => validar(" x "),
                ),
                ElevatedButton(
                  child: Text("%"),
                  onPressed: () => validar(" % "),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                  child: Text("1"),
                  onPressed: () => validar("2"),
                ),
                ElevatedButton(
                  child: Text("2"),
                  onPressed: () => validar("2"),
                ),
                ElevatedButton(
                  child: Text("3"),
                  onPressed: () => validar("3"),
                ),
                ElevatedButton(
                  child: Text("-"),
                  onPressed: () => validar(" - "),
                ),
                ElevatedButton(
                  onPressed: () {
                    double res = 0;

                    try {
                      res = calcular(operaciones.trim().split(" "));
                      res = pow(res, 2);
                    } catch (exception) {
                      res = 0;
                    }

                    addResultado(res.toString());
                  },
                  child: Text("x²"),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: Text("C"),
                    onPressed: () {
                      setState(() {
                        if (operaciones == "") {
                          listaResultados = [];
                        }
                        operaciones = "";
                        expresion = "";
                        mensaje = "";
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text("0"),
                    onPressed: () => validar("0"),
                  ),
                  ElevatedButton(
                    onPressed: calcularOperaciones,
                    child: Text("="),
                  ),
                  ElevatedButton(
                    child: Text("+"),
                    onPressed: () => validar(" + "),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(" "),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  validar([String str = ""]) {
    setState(() {
      mensaje = "";
      operaciones += str;
      expresion += str.trim();
    });

    var badExp = re.hasMatch(expresion);

    if (badExp) {
      setState(() {
        mensaje = "Expresión mal formada!";
      });
    }

    return !badExp;
  }

  calcularOperaciones() {
    var lista = operaciones.trim().split(" ");
    var r;

    if (!validar() || lista.isEmpty) {
      return;
    }

    if (lista.length < 2) {
      if (!esNumero(lista.first.trim())) {
        setState(() {
          mensaje = "Expresión mal formada!";
        });
      } else if (listaResultados.last.data != lista.first.trim()) {
        setState(() {
          listaResultados.add(Text(lista.first.trim()));
        });
      }

      return;
    }

    if (lista.length < 3) {
      if (!esNumero(lista.first.trim()) && esNumero(lista.last.trim()))
        r = double.parse(lista.first.trim() + lista.last.trim());
      else if (esNumero(lista.first.trim()) && lista.last.trim() == "%")
        r = double.parse(lista.first.trim()) / 100;
      else {
        setState(() {
          mensaje = "Expresión mal formada!";
        });

        return;
      }

      addResultado(r.toString());

      return;
    }

    r = calcular(lista);

    addResultado(r.toString());
  }

  addResultado(String res) {
    if (listaResultados.isEmpty) {
      setState(() {
        listaResultados.add(Text(
          res.toString(),
          style: TextStyle(
            fontSize: 20.0,
          ),
        ));
      });
      return;
    }
    if (listaResultados.last.data != res.trim()) {
      setState(() {
        listaResultados.add(Text(
          res.toString(),
          style: TextStyle(
            fontSize: 20.0,
          ),
        ));
      });
    }
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
      if (esNumero(lista.first) && lista.last.trim() == '%') {
        aux = double.parse(lista.first.trim()) / 100;
      } else if (["+", "-"].contains(lista.first.trim()) &&
          esNumero(lista.last.trim())) {
        aux = double.parse(lista.first.trim() + lista.last.trim());
      }
      lista.clear();
      return aux;
    }

    // if (lista.first.trim() == "(" || lista.first.trim() == "") {
    //   lista.removeAt(0);
    //   return 1 * calcular(lista);
    // }

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
    print("lista-> $lista");
    return (lista.length > 2) ? calcular(lista) : aux;
  }
}
