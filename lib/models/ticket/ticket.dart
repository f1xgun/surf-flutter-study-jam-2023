import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
/// Модель билета
class Ticket {
  int imageCodePoint;
  String title;
  String url;
  bool isLoaded;
  double downloadProgress;

  Ticket(
      {required this.imageCodePoint,
      required this.title,
      required this.url,
      this.isLoaded = false, this.downloadProgress = 0});

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
