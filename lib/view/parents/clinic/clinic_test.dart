import 'package:aksonhealth/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class ClinicTesting extends StatefulWidget {
  @override
  State<ClinicTesting> createState() => _ClinicTestingState();
}

class _ClinicTestingState extends State<ClinicTesting> {
  List _allResult = [];
  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    getClientStream();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    print(_searchController);
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var clientSnapShot in _allResult) {
        var name = clientSnapShot['city'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientSnapShot);
        }
      }
    } else {
      showResults = List.from(_allResult);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('client')
        .orderBy('city')
        .get();

    setState(() {
      _allResult = data.docs;
    });
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  void _launchMap(String gMapAddress) async {
    String url = gMapAddress;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(
                left: 16.0), // Sesuaikan angka sesuai kebutuhan Anda
            child: CupertinoSearchTextField(
              controller: _searchController,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _resultList.length,
                itemBuilder: (context, index) {
                  return CardWithMap(
                    website: _resultList[index]['website'],
                    image: _resultList[index]['image'],
                    telephone: _resultList[index]['telephone'],
                    province: _resultList[index]['province'],
                    city: _resultList[index]['city'],
                    address: _resultList[index]['address'],
                    gMapAddress: _resultList[index]['gMapsAddress'],
                    nameClinic: _resultList[index]['nameClinic'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWithMap extends StatefulWidget {
  final String city;
  final String address;
  final String gMapAddress;
  final String nameClinic;
  final String province;
  final String telephone;
  final String image;
  final String website;

  const CardWithMap({
    required this.image,
    required this.province,
    required this.city,
    required this.address,
    required this.gMapAddress,
    required this.nameClinic,
    required this.telephone,
    required this.website,
  });

  @override
  _CardWithMapState createState() => _CardWithMapState();
}

class _CardWithMapState extends State<CardWithMap> {
  void _launchMap(String gMapAddress) async {
    String url = gMapAddress;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchURLWebsite(String website) async {
    String urls = website;
    if (await canLaunch(urls)) {
      await launch(urls);
    } else {
      throw 'Could not launch $urls';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double widthClinic = screenSize.width;
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(widget.nameClinic),
                subtitle: Text(
                  '${widget.province} (${widget.city})',
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.public,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    _launchMap(widget.gMapAddress);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: 320,
                height: 150,
                child: Image.network(
                  widget.image,
                  width: 300,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(widget.address),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:
                    ContactnWebsite(widthClinic: widthClinic, widget: widget),
              ),
              SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }
}

class ContactnWebsite extends StatelessWidget {
  const ContactnWebsite({
    super.key,
    required this.widthClinic,
    required this.widget,
  });

  final double widthClinic;
  final CardWithMap widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                color: Colors.blue, // Warna border
                width: 2.0, // Lebar border
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
          ),
          onPressed: () {},
          child: Text(
            widget.telephone,
            style: TextStyle(color: Colors.blue),
          ),
        ),
        FilledButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.blue), // Warna latar belakang
          ),
          onPressed: () {
            launchUrl(Uri.parse(widget.website));
          },
          child: const Text('Get Directions'),
        )
      ],
    );
  }
}
