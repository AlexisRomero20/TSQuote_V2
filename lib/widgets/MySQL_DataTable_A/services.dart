import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tsquote/widgets/MySQL_DataTable_A/correos.dart';
import 'employees.dart';
import 'correos.dart';

class Services{
  static const ROOT = 'http://192.168.100.29:80/agendaCita/employee_actions.php';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _CREATE_TABLE = 'CREATE_TABLE';
  static const String _ADD_EMP_ACTION = 'ADD_EMP';
  static const String _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const String _DELETE_EMP_ACTION = 'DELETE_EMP';

  static const String _GET_ACTIONC='GET_ALLC';

  static List<Employee> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  static List<Correo> parseCorreos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Correo>((json) => Correo.fromJson(json)).toList();
  }


  static Future<List<Employee>> getEmployees(String correo) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      map["filtro"]=correo;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("getEmployees >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }
  }

  /*
  static Future<String> createTable() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _CREATE_TABLE;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("createTable >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
  */

  static Future<String> addEmployee(String Nombre_comp, String Correo, String Correo_prof,String Asunto, String Lugar, String Fecha, String Hora) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_EMP_ACTION;
      map["Nombre_comp"] = Nombre_comp;
      map["Correo"] = Correo;
      map["Correo_prof"] = Correo_prof;
      map["Asunto"] = Asunto;
      map["Lugar"] = Lugar;
      map["Fecha"] = Fecha;
      map["Hora"] = Hora;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("addEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateEmployee(
      String empId, String Lugar, String Fecha,String Hora) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _UPDATE_EMP_ACTION;
      map["id"] = empId;
      map["Lugar"] = Lugar;
      map["Fecha"] = Fecha;
      map["Hora"] = Hora;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("deleteEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<List<Correo>> getCorreos() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTIONC;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("getCorreos >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Correo> listC = parseCorreos(response.body);
        return listC;
      } else {
        throw <Correo>[];
      }
    } catch (e) {
      return <Correo>[];
    }
  }

  static Future<String> deleteEmployee(String empId) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _DELETE_EMP_ACTION;
      map["emp_id"] = empId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("deleteEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

}