import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_flutter_study_jam_2023/models/ticket/ticket.dart';

class TicketService {
  Future<List<Ticket>> getTickets() async {
    final prefs = await SharedPreferences.getInstance();
    List<Ticket> ticketsList = [];
    if (prefs.containsKey("tickets")) {
      ticketsList = json
          .decode(prefs.getString("tickets")!)
          .map((ticket) => Ticket.fromJson(ticket))
          .toList();
    }
    return ticketsList;
  }

  Future<void> addTickets(Ticket ticket) async {
    final prefs = await SharedPreferences.getInstance();
    final tickets = await getTickets();
    tickets.add(ticket);
    await prefs.setString("tickets", json.encode(tickets));
  }
}
