import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  int imageCodePoint;
  String title;
  String url;

  Ticket(
      {required this.imageCodePoint, required this.title, required this.url});

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
