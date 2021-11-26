import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsquote/widgets/MySQL_DataTable_A/correos.dart';
import 'employees.dart';
import 'services.dart';
import 'correos.dart';
import 'dart:developer';

class DataTableDemoA extends StatefulWidget {
  //Si marca errores es por el idioma
  final String correo;
  DataTableDemoA({required String email, required this.correo}) : super();

  String get filtro => correo;
  final String title = "TSQuote";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemoA> {
  late Map<String, String>listarcorreosMO;
  late List <String> locations;
  late List<Employee> _employees;
  late List<Correo> _correos;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _Nombre_compController;
  late TextEditingController _Correop_Controller;
  late TextEditingController _AsuntoController;
  late TextEditingController _LugarController;
  late TextEditingController _FechaController;
  late TextEditingController _HoraController;
  late Employee _selectedEmployee;
  late bool _isUpdating;
  late String _titleProgress;
  late String _filtro;
  late TextEditingController _Letrero;
  //late String seleccionado;

  //late String _dropdownValue = '';
  //late String _mySelection;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _correos = [];
    locations=[];
    _isUpdating = false;
    _titleProgress = widget.title;
    _filtro = widget.correo;
    _scaffoldKey = GlobalKey();
    _Nombre_compController = TextEditingController();
    _Correop_Controller=TextEditingController();
    _AsuntoController = TextEditingController();
    _LugarController = TextEditingController();
    _FechaController = TextEditingController();
    _HoraController = TextEditingController();
    dropdownValue='';
    _getEmployees();
    _getCorreos();
    _Letrero = TextEditingController();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  /*_createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        showSnackBar(context, result);
        _getEmployees();
      }
    });
  }*/

  _addEmployee() {
    if (_Nombre_compController.text.trim().isEmpty ||
        //_Correop_Controller.text
        //.trim()
        //.isEmpty ||
        //dropdownValue!=''||
        _Letrero.text.trim().isEmpty ||
        _AsuntoController.text.trim().isEmpty ||
        _LugarController.text.trim().isEmpty ||
        _FechaController.text.trim().isEmpty ||
        _HoraController.text.trim().isEmpty) {
      print("Empty fields");
      return;
    }
    _showProgress('Agregando Cita...');
    Services.addEmployee(
        _Nombre_compController.text,
        _filtro,
        dropdownValue,
        _AsuntoController.text,
        _LugarController.text,
        _FechaController.text,
        _HoraController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees();
      }
      _clearValues();
    });
  }

  _getEmployees() {
    _showProgress('Cargando Cita...');
    Services.getEmployees(_filtro).then((employees) {
      setState(() {
        _employees = employees;
      });
      _showProgress('TSQuote');
      print("Length: ${employees.length}");
    });
  }

  _getCorreos() {
    _showProgress('Cargando Correos...');
    Services.getCorreos().then((correos) {
      setState(() {
        _correos = correos;
      });
      _showProgress('TSQuote');
      print("Length: ${correos.length}");
      //locations=_correos.cast<String>();
      //print(locations);
      /*Map<String, String>listarcorreosM = {for (var v in _correos) v.eMail: v.eMail};
      listarcorreosMO = listarcorreosM;
      print(listarcorreosMO.length);*/
      //locationes=_correos.cast<String>();
    });
  }



  /*void pintarClientes(){
    for(var i=0; i< _correos.length; i++){
      listarcorreosM[_correos[i].eMail];
      //listarcorreosM[_correos[i].eMail]; _correos[i].eMail;
      print(listarcorreosM[i].toString());
    }
    _dropdownValue=listarcorreosM[_correos[0].eMail].toString();
  }*/

  _setValues(Employee employee) {
    _Nombre_compController.text = employee.Nombre_comp;
    _Letrero.text = employee.Correo_prof;
    _AsuntoController.text = employee.Asunto;
    _LugarController.text = employee.Lugar;
    _FechaController.text = employee.Fecha;
    _HoraController.text = employee.Hora;
    setState(() {
      _isUpdating = true;
    });
  }

  _clearValues() {
    _Nombre_compController.text = '';
    //_Correop_Controller.text='';
    dropdownValue='';
    _Letrero.text= '';
    _AsuntoController.text = '';
    _LugarController.text = '';
    _FechaController.text = '';
    _HoraController.text = '';
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text("ID"), numeric: false, tooltip: "Numero de cita."),
            DataColumn(
                label: Text(
                  "Nombre",
                ),
                numeric: false,
                tooltip: "Nombre del Alumno."),
            DataColumn(
                label: Text(
                  "Correo del profesor",
                ),
                numeric: false,
                tooltip: "Correo del profesor."),
            DataColumn(
                label: Text("Asunto"),
                numeric: false,
                tooltip: "Asunto de la cita."),
            DataColumn(
                label: Text("Lugar"),
                numeric: false,
                tooltip: "Lugar de la cita."),
            DataColumn(
                label: Text("Fecha"),
                numeric: false,
                tooltip: "Fecha de cita."),
            DataColumn(
                label: Text("Hora"),
                numeric: false,
                tooltip: "Hora de la cita."),
          ],
          rows: _employees
              .map(
                (employee) => DataRow(
              cells: [
                DataCell(
                  Text(employee.id),
                  onTap: () {
                    print("Tapped " + employee.id);
                    _setValues(employee);
                    _selectedEmployee = employee;
                  },
                ),
                DataCell(
                  Text(
                    employee.Nombre_comp.toUpperCase(),
                  ),
                  onTap: () {
                    print("Tapped " + employee.Nombre_comp);
                    _setValues(employee);
                    _selectedEmployee = employee;
                  },
                ),
                DataCell(
                  Text(
                    employee.Correo_prof.toUpperCase(),
                  ),
                  onTap: () {
                    print("Tapped " + employee.Correo_prof);
                    _setValues(employee);
                    _selectedEmployee = employee;
                  },
                ),
                DataCell(
                  Text(
                    employee.Asunto.toUpperCase(),
                  ),
                  onTap: () {
                    print("Tapped " + employee.Asunto);
                    _setValues(employee);
                    _selectedEmployee = employee;
                  },
                ),
                DataCell(
                  Text(
                    employee.Lugar.toUpperCase(),
                  ),
                  onTap: () {
                    print("Tapped " + employee.Lugar);
                    _setValues(employee);
                    _selectedEmployee = employee;
                  },
                ),
                DataCell(
                  Text(
                    employee.Fecha.toUpperCase(),
                  ),
                  onTap: () {
                    print("Tapped " + employee.Fecha);
                    _setValues(employee);
                    _selectedEmployee = employee;
                  },
                ),
                DataCell(
                  Text(
                    employee.Hora.toUpperCase(),
                  ),
                  onTap: () {
                    print("Tapped " + employee.Hora);
                    _setValues(employee);
                    _selectedEmployee = employee;
                  },
                ),
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }

  showSnackBar(context, message) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
  String dropdownValue = "";
  String dropdownValueH = "7:00 am";
  //final dropdownValue = ["Mr.", "Mrs.", "Master", "Mistress"];
  //String defaultvalue = 'selectCategorie';
  /*List<Correo> dropdownValue = [
    Correo(id: '0', Nombre: 'Selecciona el correo del profesor', eMail: 'Selecciona el correo del profesor', contrasenia: 'Selecciona el correo del profesor', tipo: 'Selecciona el correo del profesor'),
    Correo(id: '0', Nombre: 'Selecciona el correo del profesor', eMail: 'Selecciona el correo del profesor', contrasenia: 'Selecciona el correo del profesor', tipo: 'Selecciona el correo del profesor'),
    Correo(id: '0', Nombre: 'Selecciona el correo del profesor', eMail: 'Selecciona el correo del profesor', contrasenia: 'Selecciona el correo del profesor', tipo: 'Selecciona el correo del profesor')
  ];*/
  //List<String> Subcategories = ['selectCategorie','category 1','category 2','category 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          /*IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),*/
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
              _getCorreos();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _Nombre_compController,
                decoration: InputDecoration.collapsed(
                  hintText: "Nombre Completo",
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: /*TextField(
                controller: _Correop_Controller,
                decoration: InputDecoration.collapsed(
                  hintText: "Correo del Profesor (Institucional)",
                ),
              )*/
                /*DropdownButton(
                  hint: Text("Select City"),
                  isExpanded: true,
                  items: _correos.map((cityOne){
                    return DropdownMenuItem(
                      child: Text(cityOne.eMail),
                      value: int.parse(cityOne.id),
                    );
                  }).toList(),
                  onChanged: (value){
                    print("Selected city is $value");
                  }
              )*/
                /*DropdownButton(
                isExpanded: true,
                value: countryname,
                hint: Text("Select Country"),
                items: _correos.map((countryone){
                  return DropdownMenuItem(
                    child: Text(countryone.eMail), //label of item
                    value: int.parse(countryone.id), //value of item
                  );
                }).toList(),
                onChanged: (value){
                  countryname = value.toString(); //change the country name
                  print(countryname); //get city list.
                },
              ),*/

                /*DropdownButton(
                 //value: dropdownValue,
                  hint: Text("Select City"),
                  isExpanded: true,
                  items: _correos.map((cityOne){
                    return DropdownMenuItem(
                      child: Text(cityOne.eMail),
                      value: int.parse(cityOne.id),
                    );
                  }).toList(),
                  onChanged: (value){
                    print("Selected city is $value");
                }
              )*/
                /*DropdownButton(
                value: dropdownValor,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                items: _correos.map((cityOne){
                  return DropdownMenuItem(
                    child: Text(cityOne.eMail),
                    value: int.parse(cityOne.id),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValor = newValue.toString();
                    //aqui realizas el guardado del item seleccionado en la variable estatica
                    Estatica.miValor=newValue.toString();
                  });
                },*/

                /*DropdownButton(
                items: _correos.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item.eMail),
                    value: int.parse(item.id),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    _mySelection = newVal.toString();
                  });
                },
                value: _mySelection,
              ),*/

                DropdownButton<String>(
                  //value: dropdownValue,
                  hint: Text("Selecciona el correo del profesor"),
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 8,
                  elevation: 0,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (String? newValue) {
                    dropdownValue = newValue!;
                    setState(() {
                      print("Valor seleccionado $dropdownValue");
                      _Letrero=TextEditingController(text: dropdownValue);

                    });
                  },
                  /*onChanged: (String? changedValue) {
                  dropdownValue = changedValue!;
                  setState(() {
                    dropdownValue;
                    print(dropdownValue);
                  });
                },*/
                  //value: dropdownValue,
                  items: _correos.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value.eMail,
                      child: Text(value.eMail),
                    );
                  }).toList(),
                )

            ),
            Padding(padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _Letrero,
                  readOnly: true,
                  decoration: InputDecoration.collapsed(hintText: "Correo del profesor"),
                )
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _AsuntoController,
                decoration: InputDecoration.collapsed(
                  hintText: "Asunto",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _LugarController,
                decoration: InputDecoration.collapsed(
                  hintText: "Lugar",

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _FechaController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration.collapsed(
                  hintText: "DD/MM/AAAA",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _HoraController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration.collapsed(
                  hintText: "HH:MM am/pm",
                ),
              ),
            ),
            _isUpdating
                ? Row(
              children: <Widget>[],
            )
                : Container(
              child: Text(
                'Bienvenido Alumno',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}