import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_flutter_study_jam_2023/models/ticket/ticket.dart';

/// Сервис для работы с билетами
class TicketService {

  /// Получение списка билетов из SharedPreferences
  Future<List<Ticket>> getTickets() async {
    final prefs = await SharedPreferences.getInstance();
    List<Ticket> ticketsList = [];
    if (prefs.containsKey("tickets")) {
      final ticketsListJson = json.decode(prefs.getString("tickets")!);
      ticketsList = List<Ticket>.from(
          ticketsListJson.map((ticket) => Ticket.fromJson(ticket)));
    }
    return ticketsList;
  }

  /// Добавление билета в SharedPreferences
  Future<void> addTickets(Ticket ticket) async {
    final prefs = await SharedPreferences.getInstance();
    final tickets = await getTickets();
    tickets.add(ticket);
    await prefs.setString("tickets", json.encode(tickets));
  }

  /// Удаление билета из SharedPreferences
  Future<void> clearTickets() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("tickets")) prefs.remove("tickets");
  }

  /// Обновление билета в SharedPreferences
  Future<void> updateTicket(Ticket ticket) async {
    final prefs = await SharedPreferences.getInstance();
    final tickets = await getTickets();
    tickets.removeWhere((element) => element.url == ticket.url);
    tickets.add(ticket);
    await prefs.setString("tickets", json.encode(tickets));
  }
}
