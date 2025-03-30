import 'package:flutter/material.dart';

class notificaciones extends StatelessWidget {
  const notificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(233, 43, 247, 230),
        title: const Text("Notificaciones UNICAH 2025"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 10, // Número de notificaciones
          itemBuilder: (context, index) {
            return NotificationCard(
              title: 'Notificacion ${index + 1}',
              message:
                  'Este es el mensaje de la notificación número ${index + 1}',
            );
          },
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;

  const NotificationCard({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        leading: Icon(Icons.notifications, color: Colors.teal),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Aquí puedes definir lo que ocurre al hacer tap en la notificación
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Notificacion tocada: $title')),
          );
        },
      ),
    );
  }
}
