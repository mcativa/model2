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
  @BuiltValueField(wireName: 'model_height_cm')
  double get modelHeightCm;

  @nullable
  String get city;

  @nullable
  String get state;

  @nullable
  String get country;

  @nullable
  @BuiltValueField(wireName: 'model_hair_color')
  String get modelHairColor;

  @nullable
  String get prodCompanyName;

  @nullable
  String get profileFacebook;

  @nullable
  String get profileInstagram;

  @nullable
  String get prodHero;

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
    ..modelEyesColor = ''
    ..modelSkinColor = ''
    ..modelMeasureBust = 0.0
    ..modelMeasureWaist = 0.0
    ..modelMeasureHips = 0.0
    ..modelHeightCm = 0.0
    ..city = ''
    ..state = ''
    ..country = ''
    ..modelHairColor = ''
    ..prodCompanyName = ''
    ..profileFacebook = ''
    ..profileInstagram = ''
    ..prodHero = '';

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
          ..modelHeightCm = snapshot.data['model_height_cm']
          ..city = snapshot.data['city']
          ..state = snapshot.data['state']
          ..country = snapshot.data['country']
          ..modelHairColor = snapshot.data['model_hair_color']
          ..prodCompanyName = snapshot.data['prodCompanyName']
          ..profileFacebook = snapshot.data['profileFacebook']
          ..profileInstagram = snapshot.data['profileInstagram']
          ..prodHero = snapshot.data['prodHero']
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
  String modelEyesColor,
  String modelSkinColor,
  double modelMeasureBust,
  double modelMeasureWaist,
  double modelMeasureHips,
  DateTime modelDoB,
  LatLng location,
  double modelHeightCm,
  String city,
  String state,
  String country,
  String modelHairColor,
  String prodCompanyName,
  String profileFacebook,
  String profileInstagram,
  String prodHero,
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
          ..modelEyesColor = modelEyesColor
          ..modelSkinColor = modelSkinColor
          ..modelMeasureBust = modelMeasureBust
          ..modelMeasureWaist = modelMeasureWaist
          ..modelMeasureHips = modelMeasureHips
          ..modelDoB = modelDoB
          ..location = location
          ..modelHeightCm = modelHeightCm
          ..city = city
          ..state = state
          ..country = country
          ..modelHairColor = modelHairColor
          ..prodCompanyName = prodCompanyName
          ..profileFacebook = profileFacebook
          ..profileInstagram = profileInstagram
          ..prodHero = prodHero));
