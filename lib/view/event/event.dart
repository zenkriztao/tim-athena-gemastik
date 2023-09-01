import 'package:aksonhealth/data/data.dart';
import 'package:aksonhealth/model/date_model.dart';
import 'package:aksonhealth/model/event_type_model.dart';
import 'package:aksonhealth/model/events_model.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/event/event_zoom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<EventScreen> {

  List<DateModel> dates = [];
  List<EventTypeModel> eventsType = [];
  List<EventsModel> events = [];


  String todayDateIs = "12";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dates = getDates();
    eventsType = getEventTypes();
    events = getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
               color: Color.fromARGB(255, 255, 255, 255)
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 60,horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset("assets/logo.png",height: 100,),
                        SizedBox(width: 8,),
                        Spacer(),
                      ],
                    ),
                    Text("Semua Event", style: GoogleFonts.nunito(
                      color: Colors.blue,
                      fontSize: 20
                    ),),
                    SizedBox(height: 16,),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        itemCount: eventsType.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                          return EventTile(
                            imgAssetPath: eventsType[index].imgAssetPath,
                            eventType: eventsType[index].eventType,
                          );
                          }),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 60,
                      child: ListView.builder(
                          itemCount: dates.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            return DateTile(
                              weekDay: dates[index].weekDay,
                              date: dates[index].date,
                              isSelected: todayDateIs == dates[index].date,
                            );
                          }),
                    ),

                    /// Popular Events
                    SizedBox(height: 16,),
                    Text("Event Populer", style: GoogleFonts.nunito(
                        color: Colors.blue,
                        fontSize: 20
                    ),),
                    Container(
                      child: ListView.builder(
                        itemCount: events.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                          return PopularEventTile(
                            desc: events[index].desc,
                            imgeAssetPath: events[index].imgeAssetPath,
                            date: events[index].date,
                            address: events[index].address,
                          );

                          }),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DateTile extends StatelessWidget {

  String weekDay;
  String date;
  bool isSelected;
  DateTile({required this.weekDay, required this.date, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xffFCCD00) : Colors.transparent,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(date, style: GoogleFonts.nunito(
            color: isSelected ? Colors.black : Colors.blue,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 10,),
          Text(weekDay, style: GoogleFonts.nunito(
              color: isSelected ? Colors.black : Colors.blue,
              fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class EventTile extends StatelessWidget {

  String imgAssetPath;
  String eventType;
  EventTile({required this.imgAssetPath, required this.eventType});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: darkBlueColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imgAssetPath, height: 27,),
          SizedBox(height: 12,),
          Text(eventType, style: GoogleFonts.nunito(
            color: Colors.white
          ),)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class PopularEventTile extends StatelessWidget {

  String desc;
  String date;
  String address;
  String imgeAssetPath;/// later can be changed with imgUrl
  PopularEventTile({required this.address,required this.date,required this.imgeAssetPath,required this.desc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ZoomEvent()));
              },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: darkBlueColor,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(desc, style: GoogleFonts.nunito(
                        color: Colors.white,
                      fontSize: 15
                    ),),
                    SizedBox(height: 8,),
                    Row(
                      children: <Widget>[
                        Image.asset("assets/images/calender.png", height: 12,),
                        SizedBox(width: 8,),
                        Text(date, style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 13
                        ),)
                      ],
                    ),
                    SizedBox(height: 4,),
                    Row(
                      children: <Widget>[
                        Image.asset("assets/images/location.png", height: 12,),
                        SizedBox(width: 8,),
                        Text(address, style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 13
                        ),)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                child: Image.asset(imgeAssetPath, height: 100,width: 120, fit: BoxFit.cover,)),
          ],
        ),
      ),
    );
  }
}



