import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'employees.dart';
import 'services.dart';

class DataTableDemo extends StatefulWidget {
  final String correo;
  DataTableDemo({required String email, required this.correo}) : super();

  String get filtro => correo;
  final String title = "TSQuote";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  late List<Employee> _employees;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _Nombre_compController;
  late TextEditingController _CorreoController;
  late TextEditingController _AsuntoController;
  late TextEditingController _LugarController;
  late TextEditingController _FechaController;
  late TextEditingController _HoraController;
  late Employee _selectedEmployee;
  late bool _isUpdating;
  late String _titleProgress;
  late String _filtro;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _filtro = widget.correo;
    _scaffoldKey = GlobalKey();
    _Nombre_compController = TextEditingController();
    _CorreoController = TextEditingController();
    _AsuntoController = TextEditingController();
    _LugarController = TextEditingController();
    _FechaController = TextEditingController();
    _HoraController = TextEditingController();
    _getEmployees();
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
        _CorreoController.text.trim().isEmpty ||
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
        _CorreoController.text,
        _filtro,
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
    _showProgress('Cargando citas...');
    Services.getEmployees(_filtro).then((employees) {
      setState(() {
        _employees = employees;
      });
      _showProgress('TSQuote');
      print("Length: ${employees.length}");
    });
  }

  _deleteEmployee(Employee employee) {
    _showProgress('Deleting Employee...');
    Services.deleteEmployee(employee.id).then((result) {
      if ('success' == result) {
        setState(() {
          _employees.remove(employee);
        });
        _getEmployees();
      }
    });
  }

  _updateEmployee(Employee employee) {
    _showProgress('Updating Employee...');
    Services.updateEmployee(employee.id, _LugarController.text,
        _FechaController.text, _HoraController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees();
        setState(() {
          _isUpdating = false;
        });
        _Nombre_compController.text = '';
        _CorreoController.text = '';
        _AsuntoController.text = '';
        _LugarController.text = '';
        _FechaController.text = '';
        _HoraController.text = '';
      }
    });
  }

  _setValues(Employee employee) {
    _Nombre_compController.text = employee.Nombre_comp;
    _CorreoController.text = employee.Correo;
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
    _CorreoController.text = '';
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
                  "Correo del Alumno",
                ),
                numeric: false,
                tooltip: "Correo del Alumno."),
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
            DataColumn(
                label: Text("Eliminar"),
                numeric: false,
                tooltip: "Eliminar cita."),
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
                    employee.Correo.toUpperCase(),
                  ),
                  onTap: () {
                    print("Tapped " + employee.Correo);
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
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteEmployee(employee);
                    },
                  ),
                  onTap: () {
                    print("Tapped " + employee.Nombre_comp);
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
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _Nombre_compController,
                decoration: InputDecoration.collapsed(
                  hintText: "Nombre Completo",

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _CorreoController,
                decoration: InputDecoration.collapsed(
                  hintText: "Correo del Alumno (Institucional)",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _AsuntoController,
                decoration: InputDecoration.collapsed(
                  hintText: "Asunto",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _LugarController,
                decoration: InputDecoration.collapsed(
                  hintText: "Lugar",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _FechaController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration.collapsed(
                  hintText: "DD/MM/AAAA",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _HoraController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration.collapsed(
                  hintText: "HH:MM am/pm",
                ),
              ),
            ),
            _isUpdating
                ? SingleChildScrollView(
                child: Row(
                  children: <Widget>[
                    OutlineButton(
                      child: Text('Actualizar cita.'),
                      onPressed: () {
                        _updateEmployee(_selectedEmployee);
                      },
                    ),
                    OutlineButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        setState(() {
                          _isUpdating = false;
                        });
                        _clearValues();
                      },
                    ),
                  ],
                ))
                : Container(
              child: Text(
                'Bienvenido Profesor',
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
