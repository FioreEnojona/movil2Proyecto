import 'package:flutter/material.dart';

class Notificaciones extends StatelessWidget {
  const Notificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
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
=======
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 150, 0),
        title: const Text(
          "Notificaciones",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final item = notifications[index];
            return Card(
              color: Colors.white,
              shadowColor: Colors.orange.shade200,
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                title: Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE48826),
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  item.message,
                  style: const TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Notificación: ${item.title}'),
                      backgroundColor: Colors.orange,
>>>>>>> joss
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

<<<<<<< HEAD
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
=======
// Modelo de datos
class NotificationItem {
  final String title;
  final String message;

  NotificationItem({required this.title, required this.message});
}

List<NotificationItem> notifications = [
  NotificationItem(
    title: '¡Bienvenido a Chocobites!',
    message: 'Empieza a compartir tus recetas favoritas de pasteles y postres.',
  ),
  NotificationItem(
    title: 'Nueva receta publicada',
    message: 'Mira la nueva receta: Cheesecake de frutos rojos ',
  ),
  NotificationItem(
    title: 'Tip del día ',
    message: 'Agrega una pizca de sal al chocolate para realzar su sabor.',
  ),
  NotificationItem(
    title: 'Receta destacada de la semana',
    message: 'Pastel de zanahoria con frosting de queso crema ¡Revisa los detalles!',
  ),
  NotificationItem(
    title: 'Actualización de ingredientes',
    message: 'Ahora puedes añadir unidades personalizadas a tus ingredientes.',
  ),
  NotificationItem(
    title: '¡No olvides compartir!',
    message: 'Publica tu receta favorita y recibe comentarios de la comunidad pastelera ',
  ),
];
>>>>>>> joss
