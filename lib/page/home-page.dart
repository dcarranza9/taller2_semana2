

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  _HomePageState createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage>{
  String operaciones = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title:Text("Calculator"),       
       ),
     body: _body()
   );
  }

   Widget _body(){
    return Column(
      children: [
        Expanded(
            child: Container(
            color:Colors.red,
          ),
        ),
        Container(
          color:Colors.blue,
          height: 100,
          child: Row(
            children:[
              Text(operaciones)
            ]
          )
        ),
        Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += "7";
                    });
                  },child: Text("7"),),

                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += "8";
                    });
                  },child: Text("8"),),

                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += "9";
                    });
                  },child: Text("9"),),

                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += " / ";
                    });
                  },child: Text("/"),),
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += "4";
                    });
                  },child: Text("4"),),

                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += "5";
                    });
                  },child: Text("5"),),

                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += "6";
                    });
                  },child: Text("6"),),

                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += " x ";
                    });
                  },child: Text("x"),),
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += "1";
                    });
                  },child: Text("1"),),

                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += "2";
                    });
                  },child: Text("2"),),

                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += "3";
                    });
                  },child: Text("3"),),
                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += " - ";
                    });
                  },child: Text("-"),),
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones += "0";
                    });
                  },child: Text("0"),),
                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones="";
                    });
                  },child: Text("C"),),
                  ElevatedButton(onPressed: (){
                    setState((){
                      print(operaciones);
                      int res=0;
                      
                      var pila = operaciones.split(" ");

                      if(pila[1].trim() == "+"){
                        res = int.parse(pila[0]) + int.parse(pila[2]);

                      }

                      else if(pila[1].trim() == "-"){
                        res = int.parse(pila[0]) + int.parse(pila[2]);
                      }

                      else if(pila[1].trim() == "*"){
                        res = int.parse(pila[0]) + int.parse(pila[2]);
                      }

                      else if(pila[1].trim() == "/"){
                        res = int.parse(pila[0]) + int.parse(pila[2]);
                      }
                      print(res);
                    });
                  },child: Text("="),),
                  ElevatedButton(onPressed: (){
                    setState((){
                      operaciones+=" + ";
                    });
                  },child: Text("+"),),
                ]
              )
            ],
          ),
        ),
      ],
    );
 }
}
