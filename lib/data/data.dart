import 'package:aksonhealth/model/category_model.dart';
import 'package:aksonhealth/model/date_model.dart';
import 'package:aksonhealth/model/doctor_model.dart';
import 'package:aksonhealth/model/event_type_model.dart';
import 'package:aksonhealth/model/events_model.dart';
import 'package:line_icons/line_icons.dart';
class Data {
  static final categoriesList = [
    Category(
      title: "Tanya chatbot",
      doctorsNumber: 15,
      icon: LineIcons.spinner,
    ),
  ];

  static final doctorsList = [
    Doctor(
        name: "Tanya Autism bot",
        speciality: "Integrasi AI",
        image: "assets/images/aihelp.png",
        reviews: 80,
        reviewScore: 4),
    Doctor(
        name: "Machine Learning",
        speciality: "Tingkatkan kemampuan akses deteksi tinggi",
        image: "assets/images/machinelearning.png",
        reviews: 67,
        reviewScore: 5),
  ];

  
}

List<DateModel> getDates(){

  List<DateModel> dates = [];
  DateModel dateModel = new DateModel();

  //1
  dateModel.date = "10";
  dateModel.weekDay = "Sun";
  dates.add(dateModel);

  dateModel = new DateModel();

  //1
  dateModel.date = "11";
  dateModel.weekDay = "Mon";
  dates.add(dateModel);

  dateModel = new DateModel();


  //1
  dateModel.date = "12";
  dateModel.weekDay = "Tue";
  dates.add(dateModel);

  dateModel = new DateModel();

  //1
  dateModel.date = "13";
  dateModel.weekDay = "Wed";
  dates.add(dateModel);

  dateModel = new DateModel();


  //1
  dateModel.date = "14";
  dateModel.weekDay = "Thu";
  dates.add(dateModel);

  dateModel = new DateModel();


  //1
  dateModel.date = "15";
  dateModel.weekDay = "Fri";
  dates.add(dateModel);

  dateModel = new DateModel();


  //1
  dateModel.date = "16";
  dateModel.weekDay = "Sat";
  dates.add(dateModel);

  dateModel = new DateModel();

  return dates;

}

List<EventTypeModel> getEventTypes(){

  List<EventTypeModel> events = [];
  EventTypeModel eventModel = new EventTypeModel();

  //1
  eventModel.imgAssetPath = "assets/images/webinar.png";
  eventModel.eventType = "Webinar";
  events.add(eventModel);

  eventModel = new EventTypeModel();

  //1
  eventModel.imgAssetPath = "assets/images/podcast.png";
  eventModel.eventType = "Podcast";
  events.add(eventModel);

  eventModel = new EventTypeModel();

  //1
  eventModel.imgAssetPath = "assets/images/edukasi.png";
  eventModel.eventType = "Edukasi";
  events.add(eventModel);

  eventModel.imgAssetPath = "assets/images/icon_parenting.png";
  eventModel.eventType = "Parenting";
  events.add(eventModel);

  eventModel = new EventTypeModel();

  return events;
}

List<EventsModel> getEvents(){

  List<EventsModel> events = [];
  EventsModel eventsModel = new EventsModel();

  //1
  eventsModel.imgeAssetPath = "assets/images/event_autisme.jpeg";
  eventsModel.date = "Sep 12, 2023";
  eventsModel.desc = "Cara Mengatasi Anak Autisme Hiperaktif";
  eventsModel.address = "Zoom meeting";
  events.add(eventsModel);

  eventsModel = new EventsModel();

  //2
  eventsModel.imgeAssetPath = "assets/images/event_disleksia.jpeg";
  eventsModel.date = "Sep 14, 2023";
  eventsModel.desc = "Solusi Perkembangan Anak Disleksia";
      eventsModel.address = "Zoom Meeting";
  events.add(eventsModel);

  eventsModel = new EventsModel();

  //3
  eventsModel.imgeAssetPath = "assets/images/event_autisme_2.jpeg";
  eventsModel.date = "Sep 15, 2023";
      eventsModel.desc = "Bagaimana Mencari Lingkungan anak Autisme";
  eventsModel.address = "Zoom Meeting";

  events.add(eventsModel);

  eventsModel = new EventsModel();


  return events;


}