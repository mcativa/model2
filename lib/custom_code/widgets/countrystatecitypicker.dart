// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
// Begin custom widget code
import 'package:country_state_city_picker/country_state_city_picker.dart';

class Countrystatecitypicker extends StatefulWidget {
  const Countrystatecitypicker({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;
  final String country = '';

  @override
  _CountrystatecitypickerState createState() => _CountrystatecitypickerState();
}

class _CountrystatecitypickerState extends State<Countrystatecitypicker> {
  String countryValue;
  String stateValue;
  String cityValue;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 600,
        child: Column(
          children: [
            SelectState(
              // style: TextStyle(color: Colors.red),
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged: (value) {
                setState(() {
                  stateValue = value;
                });
              },
              onCityChanged: (value) {
                setState(() {
                  cityValue = value;
                  //   FFLocalState ().city = value;
                });
              },
            ),
            // InkWell(
            //   onTap:(){
            //     print('country selected is $countryValue');
            //     print('country selected is $stateValue');
            //     print('country selected is $cityValue');
            //   },
            //   child: Text(' Check')
            // )
          ],
        ));
  }
}
