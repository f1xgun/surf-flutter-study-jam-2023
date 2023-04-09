import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/config/text_style.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_card/ticket_card.dart';
import 'package:surf_flutter_study_jam_2023/models/ticket/ticket.dart';

/// Список билетов
class TicketsList extends StatelessWidget {
  const TicketsList({super.key, required this.tickets});

  final List<Ticket> tickets;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: tickets.isEmpty
          ? Center(
              child: Text('Здесь пока ничего нет',
                  style: AppTextStyle.medium24.value))
          : ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) =>
                  TicketCard(ticket: tickets[index]),
            ),
    );
  }
}
