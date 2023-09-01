import 'dart:math';

import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/size_config.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/campaign/campaign_banner.dart';
import 'package:aksonhealth/view/parents/home/banner.dart';
import 'package:aksonhealth/view/parents/home/doctors_list.dart';
import 'package:aksonhealth/view/parents/home/features_appbar.dart';
import 'package:aksonhealth/view/parents/home/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String name = '', email = '', uid = '', userType = '';
  String text = '';
  int current = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      //userType = prefs.getString('userType')!;
      email = prefs.getString('userEmail')!;
      uid = prefs.getString('userId')!;
    });

    FirebaseFirestore.instance
        .collection('Parents')
        .where('uid', isEqualTo: _auth.currentUser!.uid.toString())
        .get()
        .then((value) {
      setState(() {
        name = value.docs[0]['name'];
        email = value.docs[0]['email'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            ExpandingAppBar(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Flexible(child: DoctorBanner())
              ],
            )
          ];
        },
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                // DoctorAppBar(),
                Menu(),
                SizedBox(height: 5),
                FeaturesAppBar(),
                SizedBox(height: 20),
                CampaignBanner(),
                // FeaturesAppBar(),
                // DoctorsList(),
                // SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Keluar Aplikasi'),
            content: Text('Kamu ingin keluar aplikasi?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    textStyle: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('Tidak'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    textStyle: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                child: Text('Ya'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
}

class ExpandingAppBar extends ConsumerWidget {
  const ExpandingAppBar({
    Key? key,
    this.children = const <Widget>[],
    this.mainAxisAlignment = MainAxisAlignment.start
  }) : super(key: key);

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RoundedHeaderState state = ref.watch(roundedHeaderProvider);

    return SliverAppBar(
      expandedHeight: state.highestHeight,
      pinned: true,
      backgroundColor: darkBlueColor,
      primary: true,
      forceElevated: true,
      title: Image(
        height: 100,
        image: AssetImage("assets/logo.png"),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(state.radius)),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // We update the state here.
          ref.read(roundedHeaderProvider.notifier).updateHeight(constraints.maxHeight);

          return Opacity(
            opacity: state.scrollFraction,
            child: Padding(
              padding: EdgeInsets.only(top: state.smallestHeight),
              child: Column(mainAxisAlignment: mainAxisAlignment, children: children),
            ),
          );
          
        },
      ),
    );
  }
}

@immutable
class RoundedHeaderState {
  final double highestHeight = 220;
  final double smallestHeight = kToolbarHeight + 24;
  final double currentHeight;
  final double contentOpacity = 1;

  const RoundedHeaderState({this.currentHeight = 256});

  double get scrollFraction => min(max((currentHeight - smallestHeight) / (highestHeight - smallestHeight), 0), 1);
  double get radius => 120 * scrollFraction;
}

class RoundedHeaderNotifier extends StateNotifier<RoundedHeaderState> {
  RoundedHeaderNotifier(): super(const RoundedHeaderState());

  updateHeight(double currentHeight) {
    final newState = RoundedHeaderState(currentHeight: currentHeight);

    // Check that the new state is not equal to the next (prevents rebuild loop)
    if(state.currentHeight != newState.currentHeight) {

      // Setting state triggers an rebuild, the PostFrameCallback let Flutter
      // postpone the upcoming rebuild at a later time.
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        state = newState;
      });
    }
  }
}

final roundedHeaderProvider = StateNotifierProvider<RoundedHeaderNotifier, RoundedHeaderState>((ref) {
  return RoundedHeaderNotifier();
});

// Pay attention to the ProviderScope wrapping the MaterialApp. Riverpod requires this.
