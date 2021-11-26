class Employee {
  String id;
  String Nombre_comp;
  String Correo;
  String Correo_prof;
  String Asunto;
  String Lugar;
  String Fecha;
  String Hora;

  Employee({
    required this.id,
    required this.Nombre_comp,
    required this.Correo,
    required this.Correo_prof,
    required this.Asunto,
    required this.Lugar,
    required this.Fecha,
    required this.Hora,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json['id'] as String,
        Nombre_comp: json['Nombre_comp'] as String,
        Correo: json['Correo'] as String,
        Correo_prof: json['Correo_prof'] as String,
        Asunto: json['Asunto'] as String,
        Lugar: json['Lugar'] as String,
        Fecha: json['Fecha'] as String,
        Hora: json['Hora'] as String);
  }
}
