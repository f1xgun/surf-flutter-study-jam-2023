import 'package:flutter/material.dart';
import 'package:flutter_download_manager/flutter_download_manager.dart';
import 'package:surf_flutter_study_jam_2023/models/ticket/ticket.dart';
import 'package:surf_flutter_study_jam_2023/services/ticket_service.dart';

/// Модель данных для страницы хранения билетов
class TicketStoragePageModel extends ChangeNotifier {
  final TicketService _ticketService = TicketService();
  final List<Ticket> _tickets = [];
  bool _isLoading = false;
  bool _isDownload = false;
  final List<IconData> iconsForTickets = [
    Icons.flight,
    Icons.theater_comedy,
    Icons.train
  ];
  final DownloadManager dl = DownloadManager();
  List<DownloadTask> tasks = [];

  List<Ticket> get tickets => _tickets;
  bool get isLoading => _isLoading;
  bool get isDownload => _isDownload;

  /// Начало скачивания билета
  void startNewDownload(Ticket ticket) {
    dl.addDownload(ticket.url, '/storage/emulated/0/Download');
    DownloadTask? task = dl.getDownload(ticket.url);
    task?.status.addListener(() {
      if (task.status.value == DownloadStatus.completed) {
        ticket.isLoaded = true;
        _ticketService.updateTicket(ticket);
        notifyListeners();
      }
    });

    task?.progress.addListener(() {
      _updateTicketProgress(ticket, task);
    });
  }

  /// Обновление прогресса загрузки
  void _updateTicketProgress(Ticket ticket, DownloadTask task) {
    ticket.downloadProgress = task.progress.value;
    _ticketService.updateTicket(ticket);
    notifyListeners();
  }

  /// Добавление билета
  void addTicket(Ticket ticket) {
    _ticketService.addTickets(ticket);
    _tickets.add(ticket);
    notifyListeners();
  }

  /// Загрузка билетов
  Future<void> fetchTickets() async {
    _isLoading = true;
    final tickets = await _ticketService.getTickets();
    _tickets.clear();
    _tickets.addAll(tickets);
    _isLoading = false;
    _isDownload = true;
    notifyListeners();
  }

  /// Очистка билетов
  void clearTickets() {
    _tickets.clear();
    _ticketService.clearTickets();
    for (var task in tasks) {
      task.status.removeListener(() {});
      task.progress.removeListener(() {});
    }
    for (var ticket in tickets) {
      dl.cancelDownload(ticket.url);
    }
    tasks.clear;
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
