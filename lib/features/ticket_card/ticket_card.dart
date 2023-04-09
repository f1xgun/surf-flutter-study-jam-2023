import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/config/text_style.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/ticket_storage_page_model.dart';
import 'package:surf_flutter_study_jam_2023/models/ticket/ticket.dart';

/// Карточка билета
class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.ticket});

  final Ticket ticket;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading:
          Icon(IconData(ticket.imageCodePoint, fontFamily: 'MaterialIcons')),
      title: Text(
        ticket.title,
        style: AppTextStyle.regular16.value.copyWith(color: Colors.purple[900]),
      ),
      subtitle: TicketCardSubtitle(ticket: ticket),
      trailing: TicketCardTrailing(ticket: ticket),
    );
  }
}

/// Подзаголовок карточки билета
class TicketCardSubtitle extends StatelessWidget {
  const TicketCardSubtitle({super.key, required this.ticket});
  final Ticket ticket;
  @override
  Widget build(BuildContext context) {
    final model = TicketStoragePageProvider.watch(context)!.notifier
        as TicketStoragePageModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: ticket.isLoaded ? 1 : ticket.downloadProgress,
        ),
        Text(
          ticket.isLoaded
              ? 'Файл загружен'
              : model.dl.getDownload(ticket.url) != null
                  ? 'Загрузка ${ticket.downloadProgress * 100}%'
                  : 'Ожидает начала загрузки',
        ),
      ],
    );
  }
}

/// Кнопка загрузки/паузы скачивания билета
class TicketCardTrailing extends StatelessWidget {
  const TicketCardTrailing({super.key, required this.ticket});
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final model = TicketStoragePageProvider.watch(context)!.notifier
        as TicketStoragePageModel;
    return GestureDetector(
      onTap: model.dl.getDownload(ticket.url) == null
          ? () => model.startNewDownload(ticket)
          : () => model.dl.pauseDownload(ticket.url),
      child: (ticket.isLoaded)
          ? Icon(Icons.cloud_done_rounded, color: Colors.purple[900])
          : (model.dl.getDownload(ticket.url) != null)
              ? Icon(Icons.pause_circle_outline, color: Colors.purple[900])
              : Icon(Icons.cloud_download_outlined, color: Colors.purple[900]),
    );
  }
}
