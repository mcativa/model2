import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'talent_porfolio_record.g.dart';

abstract class TalentPorfolioRecord
    implements Built<TalentPorfolioRecord, TalentPorfolioRecordBuilder> {
  static Serializer<TalentPorfolioRecord> get serializer =>
      _$talentPorfolioRecordSerializer;

  @nullable
  DocumentReference get userTalent;

  @nullable
  @BuiltValueField(wireName: 'portfolio_URLs')
  BuiltList<String> get portfolioURLs;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TalentPorfolioRecordBuilder builder) =>
      builder..portfolioURLs = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('talentPorfolio');

  static Stream<TalentPorfolioRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<TalentPorfolioRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  TalentPorfolioRecord._();
  factory TalentPorfolioRecord(
          [void Function(TalentPorfolioRecordBuilder) updates]) =
      _$TalentPorfolioRecord;

  static TalentPorfolioRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createTalentPorfolioRecordData({
  DocumentReference userTalent,
}) =>
    serializers.toFirestore(
        TalentPorfolioRecord.serializer,
        TalentPorfolioRecord((t) => t
          ..userTalent = userTalent
          ..portfolioURLs = null));
