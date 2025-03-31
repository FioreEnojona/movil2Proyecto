import 'package:flutter/material.dart';

class Notificaciones extends StatelessWidget {
  const Notificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notificaciones")),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 2,
              child: ListTile(
                title: Text(
                  notifications[index].title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(notifications[index].message),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Notificación: ${notifications[index].title}',
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// Modelo de datos simplificado
class Notification {
  final String title;
  final String message;

  Notification({required this.title, required this.message});
}

List<Notification> notifications = [
  Notification(
    title: 'Bienvenido a UNICAH',
    message: '¡Gracias por unirte a nuestra comunidad!',
  ),
  Notification(
    title: 'Error al cargar datos',
    message:
        'Hubo un problema al intentar obtener los datos, por favor intente más tarde.',
  ),
  Notification(
    title: 'Nuevo mensaje de tu profesor',
    message: 'Tienes un nuevo mensaje en tu cuenta de la UNICAH.',
  ),
  Notification(
    title: 'Aviso importante',
    message: 'El servidor estará en mantenimiento de 10:00 PM a 12:00 AM.',
  ),
  Notification(
    title: 'Reintentar operación',
    message: 'Por favor, vuelve a intentar la acción más tarde.',
  ),
];
