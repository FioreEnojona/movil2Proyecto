import 'package:flutter/material.dart';

class Notificaciones extends StatelessWidget {
  const Notificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
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
    message:
        'Pastel de zanahoria con frosting de queso crema ¡Revisa los detalles!',
  ),
  NotificationItem(
    title: 'Actualización de ingredientes',
    message: 'Ahora puedes añadir unidades personalizadas a tus ingredientes.',
  ),
  NotificationItem(
    title: '¡No olvides compartir!',
    message:
        'Publica tu receta favorita y recibe comentarios de la comunidad pastelera ',
  ),
];
