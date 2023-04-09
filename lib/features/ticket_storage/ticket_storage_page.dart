import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/config/text_style.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/ticket_storage_page_model.dart';
import 'package:surf_flutter_study_jam_2023/features/tickets_list/tickets_list.dart';
import 'package:surf_flutter_study_jam_2023/features/url_bottom_sheet/url_bottom_sheet.dart';

/// Экран “Хранения билетов”.
class TicketStoragePage extends StatelessWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  void _showUrlBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
        context: context, builder: ((context) => const UrlBottomSheet()));
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
              onPressed: () => _showUrlBottomSheet(context),
              child: Text('Добавить', style: AppTextStyle.medium14.value),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 125,
            child: FloatingActionButton(
              onPressed: null,
              child: Text('Загрузить все', style: AppTextStyle.medium14.value),
            ),
          ),
        ],
      ),
    );
  }
}
