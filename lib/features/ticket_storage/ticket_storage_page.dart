import 'dart:math';

import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/config/text_style.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/ticket_storage_page_model.dart';
import 'package:surf_flutter_study_jam_2023/features/tickets_list/tickets_list.dart';
import 'package:surf_flutter_study_jam_2023/features/url_bottom_sheet/url_bottom_sheet.dart';
import 'package:surf_flutter_study_jam_2023/models/ticket/ticket.dart';

/// Экран “Хранения билетов”.
class TicketStoragePage extends StatelessWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(
                width: 15,
              ),
              Text(
                'Билет успешно добавлен',
                style: AppTextStyle.medium14.value.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  void _showUrlBottomSheet(
      BuildContext context, TicketStoragePageModel model) async {
    String? result = await showModalBottomSheet(
      context: context,
      builder: (context) => const UrlBottomSheet(),
      isScrollControlled: true,
      useSafeArea: true,
    );
    if (result != null && result.isNotEmpty) {
      model.addTicket(
        Ticket(
            imageCodePoint: model
                .iconsForTickets[Random().nextInt(model.iconsForTickets.length)]
                .codePoint,
            title: result.split('/').last.split('.').first,
            url: result, isLoaded: false),
      );
      _showSnackBar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = TicketStoragePageProvider.watch(context)!.notifier
        as TicketStoragePageModel;
    if (!model.isDownload) model.fetchTickets();

    return Scaffold(
      appBar: AppBar(
        title: Text('Хранение билетов', style: AppTextStyle.medium24.value),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: model.isLoading || model.tickets.isEmpty
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            if (model.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              TicketsList(tickets: model.tickets),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 100,
            child: FloatingActionButton(
              onPressed: () => _showUrlBottomSheet(context, model),
              child: Text('Добавить', style: AppTextStyle.medium14.value),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 125,
            child: FloatingActionButton(
              onPressed: model.clearTickets,
              child: Text('Загрузить все', style: AppTextStyle.medium14.value),
            ),
          ),
        ],
      ),
    );
  }
}
