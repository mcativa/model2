import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'events_record.g.dart';

abstract class EventsRecord
    implements Built<EventsRecord, EventsRecordBuilder> {
  static Serializer<EventsRecord> get serializer => _$eventsRecordSerializer;

  @nullable
  String get eventName;

  @nullable
  String get eventPromo;

  @nullable
  DocumentReference get eventProducer;

  @nullable
  BuiltList<DocumentReference> get modelCandidates;

  @nullable
  BuiltList<DocumentReference> get modelSelected;

  @nullable
  DateTime get eventDate;

  @nullable
  String get eventDetails;

  @nullable
  String get eventProducerName;

  @nullable
  @BuiltValueField(wireName: 'creation_date')
  DateTime get creationDate;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(EventsRecordBuilder builder) => builder
    ..eventName = ''
    ..eventPromo = ''
    ..modelCandidates = ListBuilder()
    ..modelSelected = ListBuilder()
    ..eventDetails = ''
    ..eventProducerName = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  EventsRecord._();
  factory EventsRecord([void Function(EventsRecordBuilder) updates]) =
      _$EventsRecord;

  static EventsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createEventsRecordData({
  String eventName,
  String eventPromo,
  DocumentReference eventProducer,
  DateTime eventDate,
  String eventDetails,
  String eventProducerName,
  DateTime creationDate,
}) =>
    serializers.toFirestore(
        EventsRecord.serializer,
        EventsRecord((e) => e
          ..eventName = eventName
          ..eventPromo = eventPromo
          ..eventProducer = eventProducer
          ..modelCandidates = null
          ..modelSelected = null
          ..eventDate = eventDate
          ..eventDetails = eventDetails
          ..eventProducerName = eventProducerName
          ..creationDate = creationDate));
