import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  String get email;

  @nullable
  String get password;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get bio;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  bool get likedPosts;

  @nullable
  String get profileType;

  @nullable
  bool get isGuest;

  @nullable
  @BuiltValueField(wireName: 'model_height_feet')
  int get modelHeightFeet;

  @nullable
  @BuiltValueField(wireName: 'model_height_in')
  int get modelHeightIn;

  @nullable
  @BuiltValueField(wireName: 'model_hair_color')
  String get modelHairColor;

  @nullable
  @BuiltValueField(wireName: 'model_eyes_color')
  String get modelEyesColor;

  @nullable
  @BuiltValueField(wireName: 'model_skin_color')
  String get modelSkinColor;

  @nullable
  @BuiltValueField(wireName: 'model_measure_bust')
  double get modelMeasureBust;

  @nullable
  @BuiltValueField(wireName: 'model_measure_waist')
  double get modelMeasureWaist;

  @nullable
  @BuiltValueField(wireName: 'model_measure_hips')
  double get modelMeasureHips;

  @nullable
  @BuiltValueField(wireName: 'model_DoB')
  DateTime get modelDoB;

  @nullable
  LatLng get location;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..displayName = ''
    ..email = ''
    ..password = ''
    ..photoUrl = ''
    ..bio = ''
    ..uid = ''
    ..phoneNumber = ''
    ..likedPosts = false
    ..profileType = ''
    ..isGuest = false
    ..modelHeightFeet = 0
    ..modelHeightIn = 0
    ..modelHairColor = ''
    ..modelEyesColor = ''
    ..modelSkinColor = ''
    ..modelMeasureBust = 0.0
    ..modelMeasureWaist = 0.0
    ..modelMeasureHips = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static UsersRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) => UsersRecord(
        (c) => c
          ..displayName = snapshot.data['display_name']
          ..email = snapshot.data['email']
          ..password = snapshot.data['password']
          ..createdTime = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['created_time']))
          ..photoUrl = snapshot.data['photo_url']
          ..bio = snapshot.data['bio']
          ..uid = snapshot.data['uid']
          ..phoneNumber = snapshot.data['phone_number']
          ..likedPosts = snapshot.data['likedPosts']
          ..profileType = snapshot.data['profileType']
          ..isGuest = snapshot.data['isGuest']
          ..modelHeightFeet = snapshot.data['model_height_feet']
          ..modelHeightIn = snapshot.data['model_height_in']
          ..modelHairColor = snapshot.data['model_hair_color']
          ..modelEyesColor = snapshot.data['model_eyes_color']
          ..modelSkinColor = snapshot.data['model_skin_color']
          ..modelMeasureBust = snapshot.data['model_measure_bust']
          ..modelMeasureWaist = snapshot.data['model_measure_waist']
          ..modelMeasureHips = snapshot.data['model_measure_hips']
          ..modelDoB = safeGet(() =>
              DateTime.fromMillisecondsSinceEpoch(snapshot.data['model_DoB']))
          ..location = safeGet(() => LatLng(
                snapshot.data['_geoloc']['lat'],
                snapshot.data['_geoloc']['lng'],
              ))
          ..reference = UsersRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<UsersRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'users',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUsersRecordData({
  String displayName,
  String email,
  String password,
  DateTime createdTime,
  String photoUrl,
  String bio,
  String uid,
  String phoneNumber,
  bool likedPosts,
  String profileType,
  bool isGuest,
  int modelHeightFeet,
  int modelHeightIn,
  String modelHairColor,
  String modelEyesColor,
  String modelSkinColor,
  double modelMeasureBust,
  double modelMeasureWaist,
  double modelMeasureHips,
  DateTime modelDoB,
  LatLng location,
}) =>
    serializers.toFirestore(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..displayName = displayName
          ..email = email
          ..password = password
          ..createdTime = createdTime
          ..photoUrl = photoUrl
          ..bio = bio
          ..uid = uid
          ..phoneNumber = phoneNumber
          ..likedPosts = likedPosts
          ..profileType = profileType
          ..isGuest = isGuest
          ..modelHeightFeet = modelHeightFeet
          ..modelHeightIn = modelHeightIn
          ..modelHairColor = modelHairColor
          ..modelEyesColor = modelEyesColor
          ..modelSkinColor = modelSkinColor
          ..modelMeasureBust = modelMeasureBust
          ..modelMeasureWaist = modelMeasureWaist
          ..modelMeasureHips = modelMeasureHips
          ..modelDoB = modelDoB
          ..location = location));
