class Correo {
  String id;
  String Nombre;
  String eMail;
  String contrasenia;
  String tipo;

  Correo({
    required this.id,
    required this.Nombre,
    required this.eMail,
    required this.contrasenia,
    required this.tipo,
  });

  factory Correo.fromJson(Map<String, dynamic> json) {
    return Correo(
        id: json['id'] as String,
        Nombre: json['Nombre'] as String,
        eMail: json['eMail'] as String,
        contrasenia: json['contrasenia'] as String,
        tipo: json['tipo'] as String);
  }
}
