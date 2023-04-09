import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/models/ticket/ticket.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.flight),
      title: Text(ticket.title),
      trailing: const Icon(Icons.cloud_download_outlined),
    );
  }
}
