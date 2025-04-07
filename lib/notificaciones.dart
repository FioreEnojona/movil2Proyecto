import 'package:flutter/material.dart';
import 'package:movil2proyecto/db/database_helper.dart';
import 'package:movil2proyecto/models/noti.dart';

class Notificaciones extends StatefulWidget {
  const Notificaciones({super.key});

  @override
  State<Notificaciones> createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<Noti>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _refreshNotifications();
  }

  Future<void> _refreshNotifications() async {
    setState(() {
      _notificationsFuture = _dbHelper.getAllNotis();
    });
  }

  Future<void> _deleteNotification(int id) async {
    final result = await _dbHelper.deleteNoti(id);
    if (result > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notificación eliminada'),
          backgroundColor: Colors.orange,
        ),
      );
      _refreshNotifications();
    }
  }

  Future<void> _deleteAllNotifications() async {
    final result = await _dbHelper.deleteAllNotis();
    if (result > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$result notificaciones eliminadas'),
          backgroundColor: Colors.orange,
        ),
      );
      _refreshNotifications();
    }
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: _deleteAllNotifications,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: FutureBuilder<List<Noti>>(
          future: _notificationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final notifications = snapshot.data ?? [];

            if (notifications.isEmpty) {
              return const Center(
                child: Text(
                  'No hay notificaciones',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final noti = notifications[index];
                  return Dismissible(
                    key: Key(noti.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) => _deleteNotification(noti.id!),
                    child: Card(
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
                          noti.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE48826),
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              noti.message,
                              style: const TextStyle(color: Colors.black87),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatDate(noti.createdAt),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Notificación: ${noti.title}'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        },
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

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
