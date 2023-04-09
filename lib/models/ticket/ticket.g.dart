// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      imageCodePoint: json['imageCodePoint'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'imageCodePoint': instance.imageCodePoint,
      'title': instance.title,
      'url': instance.url,
    };
