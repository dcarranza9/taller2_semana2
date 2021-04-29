

import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  _HomePageState createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage>{
  
  String operaciones = "";
  String resultadoOperaciones="";
  String mensaje="";
  
  List<Text> listaResultados=[];
  
  var aux = 0.0;
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
                ]
              ),
            ),
          ),
        ),
        Container(
          color:Colors.blue,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              children:[
                Expanded(
                   child: Container(
                     color: Colors.yellow,
                     height:50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(operaciones, style: TextStyle(fontSize: 14.0,)),
                        ),
                          ],
                        ),
                  ),
                ),
                Column(
                  mainAxisAlignment:MainAxisAlignment.end,
                  children: [
                    Text("Mensaje de error", style:TextStyle(fontSize: 16.0,),)
                  ]
                )
              ],
            ),
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
                      if(operaciones!=""){
                        operaciones += " / ";
                      }
                      
                    });
                  },child: Text("/"),),

                  ElevatedButton(onPressed: (){
                    setState((){
                      if(operaciones!=""){
                        operaciones += " √ ";
                      }
                      
                    });
                  },child: Text("√"),),
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
                      if(operaciones!=""){
                        operaciones += " x ";
                      }
                      
                    });
                  },child: Text("x"),),
                  ElevatedButton(onPressed: (){
                    setState((){
                      if(operaciones!=""){
                        operaciones += " % ";
                      }
                      
                    });
                  },child: Text("%"),),
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
                      if(operaciones!=""){
                        operaciones += " - ";
                      }
                    });
                  },child: Text("-"),),

                  ElevatedButton(onPressed: (){},child: Text(" "),),
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
                  ElevatedButton(onPressed: CalcularOperaciones, child: Text("="),),
                  ElevatedButton(onPressed: (){
                    setState((){
                      if(operaciones!=""){
                        operaciones += " + ";
                      }
                    });
                  },child: Text("+"),),
                  ElevatedButton(onPressed: (){},child: Text(" "),),
                ]
              )
            ],
          ),
        ),
      ],
    );
 }

   void CalcularOperaciones() {
     
     var res = 0.0;
     var malformacion = false;                      
     var lista = operaciones.split(" ");

     if(operaciones.trim() == ""){
        return;
     }
     
     
     if(lista.length == 1){
       
       if(lista[0] == listaResultados.last.data){
         return;
       }

       if(operaciones.trim() == "√"){
       //Mal formada
        return;
     }

      setState((){
        resultadoOperaciones = "$operaciones";
        listaResultados.add(Text(resultadoOperaciones));
      });

      return;

    }

    else if(lista.length == 2){

      if(lista[0] != "√"){
        //Mal formada  
        return;   
      } 

      res = sqrt(double.parse(lista[1]));

      setState((){
        resultadoOperaciones = "$operaciones = $res";
        listaResultados.add(Text(resultadoOperaciones));
        operaciones="$res";
      });
      
      return;
    }    

    //Operaciones básicas
    if(lista[1].trim() == "+"){
       res = double.parse(lista[0]) + double.parse(lista[2]);
     
    }
     
    else if(lista[1].trim() == "-"){
       res = double.parse(lista[0]) - double.parse(lista[2]);
    }
     
    else if(lista[1].trim() == "x"){
       res = double.parse(lista[0]) * double.parse(lista[2]);
    }
     
    else if(lista[1].trim() == "/"){
       res = double.parse(lista[0]) / double.parse(lista[2]);
    }
     
    setState((){
      resultadoOperaciones = "$operaciones=$res";
      listaResultados.add(Text(resultadoOperaciones));
      operaciones="$res";
    });

     //operaciones ="";
     
    print("El resultado: $res");
  }
}
