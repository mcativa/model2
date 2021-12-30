import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'talent_photos_record.g.dart';

abstract class TalentPhotosRecord
    implements Built<TalentPhotosRecord, TalentPhotosRecordBuilder> {
  static Serializer<TalentPhotosRecord> get serializer =>
      _$talentPhotosRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'talent_user')
  DocumentReference get talentUser;

  @nullable
  @BuiltValueField(wireName: 'Image')
  String get image;

  @nullable
  String get style;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TalentPhotosRecordBuilder builder) => builder
    ..image = ''
    ..style = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('talentPhotos');

  static Stream<TalentPhotosRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<TalentPhotosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  TalentPhotosRecord._();
  factory TalentPhotosRecord(
          [void Function(TalentPhotosRecordBuilder) updates]) =
      _$TalentPhotosRecord;

  static TalentPhotosRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createTalentPhotosRecordData({
  DocumentReference talentUser,
  String image,
  String style,
}) =>
    serializers.toFirestore(
        TalentPhotosRecord.serializer,
        TalentPhotosRecord((t) => t
          ..talentUser = talentUser
          ..image = image
          ..style = style));
