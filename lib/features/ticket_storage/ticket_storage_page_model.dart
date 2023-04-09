import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/models/ticket/ticket.dart';
import 'package:surf_flutter_study_jam_2023/services/ticket_service.dart';

/// Модель данных для страницы хранения билетов
class TicketStoragePageModel extends ChangeNotifier {
  final TicketService _ticketService = TicketService();
  final List<Ticket> _tickets = [];
  bool _isLoading = false;
  bool _isDownload = false;
  final List<IconData> iconsForTickets = [Icons.flight, Icons.theater_comedy, Icons.train];

  List<Ticket> get tickets => _tickets;
  bool get isLoading => _isLoading;
  bool get isDownload => _isDownload;

  void addTicket(Ticket ticket) {
    _ticketService.addTickets(ticket);
    _tickets.add(ticket);
    notifyListeners();
  }

  Future<void> fetchTickets() async {
    _isLoading = true;
    final tickets = await _ticketService.getTickets();
    _tickets.clear();
    _tickets.addAll(tickets);
    _isLoading = false;
    _isDownload = true;
    notifyListeners();
  }

  void clearTickets() {
    _tickets.clear();
    _ticketService.clearTickets();
    notifyListeners();
  }
}

/// Провайдер для страницы хранения билетов
class TicketStoragePageProvider extends InheritedNotifier {
  const TicketStoragePageProvider(
      {super.key,
      required super.child,
      required TicketStoragePageModel super.notifier});

  static TicketStoragePageProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TicketStoragePageProvider>();
  }

  static TicketStoragePageProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TicketStoragePageProvider>()
        ?.widget;
    return widget is TicketStoragePageProvider ? widget : null;
  }
}
