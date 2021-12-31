import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_place_picker.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/place.dart';
import '../flutter_flow/upload_media.dart';
import 'dart:io';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EditModelProfileWidget extends StatefulWidget {
  const EditModelProfileWidget({
    Key key,
    this.userProfile,
  }) : super(key: key);

  final DocumentReference userProfile;

  @override
  _EditModelProfileWidgetState createState() => _EditModelProfileWidgetState();
}

class _EditModelProfileWidgetState extends State<EditModelProfileWidget> {
  String eyeColorDropDownValue;
  String hairColorDropDownValue;
  String uploadedFileUrl = '';
  TextEditingController textController1;
  TextEditingController textController2;
  double heightCmValue;
  double measureBustValue;
  double measureWaistValue;
  double measureHipsValue;
  var placePickerValue = FFPlace();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: SpinKitThreeBounce(
                color: FlutterFlowTheme.primaryColor,
                size: 50,
              ),
            ),
          );
        }
        final editModelProfileUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.chevron_left_rounded,
                color: Colors.black,
                size: 30,
              ),
            ),
            title: Text(
              'Edit Profile',
              style: FlutterFlowTheme.subtitle1,
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 5, 10, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.background,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      allowPhoto: true,
                                    );
                                    if (selectedMedia != null &&
                                        validateFileFormat(
                                            selectedMedia.storagePath,
                                            context)) {
                                      showUploadMessage(
                                          context, 'Uploading file...',
                                          showLoading: true);
                                      final downloadUrl = await uploadData(
                                          selectedMedia.storagePath,
                                          selectedMedia.bytes);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      if (downloadUrl != null) {
                                        setState(() =>
                                            uploadedFileUrl = downloadUrl);
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        showUploadMessage(
                                            context, 'Failed to upload media');
                                        return;
                                      }
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          editModelProfileUsersRecord.photoUrl,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: textController1 ??=
                                        TextEditingController(
                                      text: editModelProfileUsersRecord
                                          .displayName,
                                    ),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Full Name',
                                      labelStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: FlutterFlowTheme.grayIcon400,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.subtitle1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1,
                          color: FlutterFlowTheme.lineColor,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: textController2 ??=
                                        TextEditingController(
                                      text: editModelProfileUsersRecord.bio,
                                    ),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Short Description',
                                      labelStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: FlutterFlowTheme.grayIcon400,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.darkText,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 4,
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1,
                          color: FlutterFlowTheme.lineColor,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.9, 0),
                              child: Text(
                                'Measures\n',
                                style: FlutterFlowTheme.bodyText2,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: Text(
                                    'Height',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.bodyText2,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      heightCmValue.toString(),
                                      style: FlutterFlowTheme.bodyText2,
                                    ),
                                    Text(
                                      functions.cm2ftStr(heightCmValue),
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.bodyText2,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Slider(
                                    activeColor:
                                        FlutterFlowTheme.secondaryColor,
                                    inactiveColor: Color(0xFF9E9E9E),
                                    min: 30,
                                    max: 220,
                                    value: heightCmValue ??=
                                        functions.validateRangeDbl(
                                            30.0,
                                            220.0,
                                            170.0,
                                            editModelProfileUsersRecord
                                                .modelHeightCm),
                                    divisions: 190,
                                    onChanged: (newValue) {
                                      setState(() => heightCmValue = newValue);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 0, 0),
                                        child: Text(
                                          'Bust ',
                                          style: FlutterFlowTheme.bodyText2,
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-0.3, 0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              measureBustValue.toString(),
                                              '32',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.bodyText2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  AuthUserStreamWidget(
                                    child: Slider(
                                      activeColor:
                                          FlutterFlowTheme.secondaryColor,
                                      inactiveColor: Color(0xFF9E9E9E),
                                      min: 15,
                                      max: 60,
                                      value: measureBustValue ??=
                                          currentUserDocument?.modelMeasureBust,
                                      label: measureBustValue.toString(),
                                      divisions: 45,
                                      onChanged: (newValue) {
                                        setState(
                                            () => measureBustValue = newValue);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 0, 0),
                                        child: Text(
                                          'Waist  ',
                                          style: FlutterFlowTheme.bodyText2,
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-0.3, 0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              measureWaistValue.toString(),
                                              '32',
                                            ),
                                            style: FlutterFlowTheme.bodyText2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  AuthUserStreamWidget(
                                    child: Container(
                                      width: double.infinity,
                                      child: Slider(
                                        activeColor:
                                            FlutterFlowTheme.secondaryColor,
                                        inactiveColor: Color(0xFF9E9E9E),
                                        min: 15,
                                        max: 60,
                                        value: measureWaistValue ??=
                                            currentUserDocument
                                                ?.modelMeasureWaist,
                                        label: measureWaistValue.toString(),
                                        divisions: 45,
                                        onChanged: (newValue) {
                                          setState(() =>
                                              measureWaistValue = newValue);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Text(
                                            'Hips   ',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-0.3, 0),
                                          child: Text(
                                            measureHipsValue.toString(),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.bodyText2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  AuthUserStreamWidget(
                                    child: Slider(
                                      activeColor:
                                          FlutterFlowTheme.secondaryColor,
                                      inactiveColor: Color(0xFF9E9E9E),
                                      min: 15,
                                      max: 60,
                                      value: measureHipsValue ??=
                                          currentUserDocument?.modelMeasureHips,
                                      label: measureHipsValue.toString(),
                                      divisions: 45,
                                      onChanged: (newValue) {
                                        setState(
                                            () => measureHipsValue = newValue);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 2,
                          thickness: 1,
                          color: FlutterFlowTheme.lineColor,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Text(
                                  'Hair Color',
                                  style: FlutterFlowTheme.bodyText2,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: FlutterFlowDropDown(
                                        initialOption:
                                            hairColorDropDownValue ??=
                                                editModelProfileUsersRecord
                                                    .modelHairColor,
                                        options: [
                                          'Brown',
                                          'Blonde',
                                          'Black',
                                          'Other'
                                        ].toList(),
                                        onChanged: (val) => setState(
                                            () => hairColorDropDownValue = val),
                                        width: 130,
                                        height: 40,
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: FlutterFlowTheme.grayIcon,
                                        ),
                                        icon: FaIcon(
                                          FontAwesomeIcons.chevronDown,
                                          color: FlutterFlowTheme.grayIcon400,
                                          size: 16,
                                        ),
                                        fillColor: Colors.white,
                                        elevation: 0,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0,
                                        borderRadius: 0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            8, 4, 8, 4),
                                        hidesUnderline: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Text(
                                  'Eyes Color',
                                  style: FlutterFlowTheme.bodyText2,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: FlutterFlowDropDown(
                                        initialOption: eyeColorDropDownValue ??=
                                            editModelProfileUsersRecord
                                                .modelEyesColor,
                                        options: [
                                          'Brown',
                                          'Hazel',
                                          'Blue',
                                          'Green',
                                          'Other'
                                        ].toList(),
                                        onChanged: (val) => setState(
                                            () => eyeColorDropDownValue = val),
                                        width: 130,
                                        height: 40,
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: FlutterFlowTheme.grayIcon,
                                        ),
                                        icon: FaIcon(
                                          FontAwesomeIcons.chevronDown,
                                          color: FlutterFlowTheme.grayIcon400,
                                          size: 16,
                                        ),
                                        fillColor: Colors.white,
                                        elevation: 0,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0,
                                        borderRadius: 0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            8, 4, 8, 4),
                                        hidesUnderline: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1,
                          color: FlutterFlowTheme.lineColor,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Text(
                                  'Date of Birdth',
                                  style: FlutterFlowTheme.bodyText2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Text(
                                  'Location',
                                  style: FlutterFlowTheme.bodyText2,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Hello World',
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                  Text(
                                    'Hello World',
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: FlutterFlowPlacePicker(
                                        iOSGoogleMapsApiKey: '',
                                        androidGoogleMapsApiKey: '',
                                        webGoogleMapsApiKey:
                                            'AIzaSyBitpGwAVFERJqqJfDB1mziAYARyq3ipW0',
                                        onSelect: (place) => setState(
                                            () => placePickerValue = place),
                                        defaultText: 'Select Location',
                                        icon: Icon(
                                          Icons.place,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        buttonOptions: FFButtonOptions(
                                          width: 200,
                                          height: 40,
                                          color: FlutterFlowTheme.primaryColor,
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 1),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.primaryColor,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 36),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final usersUpdateData = createUsersRecordData(
                              displayName: textController1?.text ?? '',
                              bio: textController2?.text ?? '',
                              photoUrl: uploadedFileUrl,
                              modelMeasureBust: measureBustValue,
                              modelMeasureWaist: measureWaistValue,
                              modelMeasureHips: measureHipsValue,
                              modelHairColor: eyeColorDropDownValue,
                              modelEyesColor: eyeColorDropDownValue,
                              modelHeightCm: heightCmValue,
                              location: placePickerValue.latLng,
                              city: placePickerValue.city,
                              state: placePickerValue.state,
                              country: placePickerValue.country,
                            );
                            await editModelProfileUsersRecord.reference
                                .update(usersUpdateData);
                            Navigator.pop(context);
                          },
                          text: 'Save Changes',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: FlutterFlowTheme.primaryColor,
                            textStyle: FlutterFlowTheme.subtitle1.override(
                              fontFamily: 'Lexend Deca',
                              color: FlutterFlowTheme.tertiaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            elevation: 0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
