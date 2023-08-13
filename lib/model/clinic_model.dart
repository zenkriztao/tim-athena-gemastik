import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  static CollectionReference<Map<String, dynamic>> get doctorsColRef =>
      FirebaseFirestore.instance.collection('Clinic');
  final String? doctorID;
  final String name;
  final String occupation;
  final String occupationDescription;
  final String hospitalName;
  final String hospitalAddress;
  final String hospitalCity;
  final String hospitalGMapsLink;
  final String hospitalTelephoneNo;
  final String hospitalWebsite;

  Doctor({
    this.doctorID,
    required this.name,
    required this.occupation,
    required this.occupationDescription,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.hospitalCity,
    required this.hospitalGMapsLink,
    required this.hospitalTelephoneNo,
    required this.hospitalWebsite,
  });

  static Future<Doctor> fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) async {
    Hospital hospital =
        await Hospital.getDataFromFirestore(snapshot.data()!['hospitalID']);
    DoctorOccupation doctorOccupation =
        await DoctorOccupation.getDataFromFirestore(
            snapshot.data()!['occupationID']);

    return Doctor(
      doctorID: snapshot.id,
      name: snapshot.data()!['name'],
      occupation: doctorOccupation.name,
      occupationDescription: doctorOccupation.description,
      hospitalName: hospital.name,
      hospitalAddress: hospital.address,
      hospitalCity: hospital.city,
      hospitalGMapsLink: hospital.gMapsLink,
      hospitalTelephoneNo: hospital.telephoneNo,
      hospitalWebsite: hospital.website,
    );
  }

  static Future<List<Doctor>> getAllFromFirestore() async {
    List<Doctor> data = [];
    await doctorsColRef.get().then(
      (querySnapshot) async {
        print("Successfully completed checklist");
        for (var docSnapshot in querySnapshot.docs) {
          data.add(await Doctor.fromFirestore(docSnapshot));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }
}

class Hospital {
  static CollectionReference<Map<String, dynamic>> get hospitalsColRef =>
      FirebaseFirestore.instance.collection('Hospitals');
  final String? hospitalID;
  final String name;
  final String address;
  final String city;
  final String gMapsLink;
  final String telephoneNo;
  final String website;

  Hospital({
    this.hospitalID,
    required this.name,
    required this.address,
    required this.city,
    required this.gMapsLink,
    required this.telephoneNo,
    required this.website,
  });

  factory Hospital.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return Hospital(
      hospitalID: snapshot.id,
      name: snapshot.data()!['name'],
      address: snapshot.data()!['address'],
      city: snapshot.data()!['city'],
      gMapsLink: snapshot.data()!['gMapsLink'],
      telephoneNo: snapshot.data()!['telephoneNo'],
      website: snapshot.data()!['website'],
    );
  }

  static Future<List<Hospital>> getAllFromFirestore() async {
    List<Hospital> data = [];
    await hospitalsColRef.get().then(
      (querySnapshot) async {
        print("Successfully completed checklist");
        for (var docSnapshot in querySnapshot.docs) {
          data.add(Hospital.fromFirestore(docSnapshot));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }

  static Future<Hospital> getDataFromFirestore(String hospitalID) async {
    late Hospital data;
    await hospitalsColRef.doc(hospitalID).get().then(
      (querySnapshot) async {
        print("Successfully completed checklist");
        data = Hospital.fromFirestore(querySnapshot);
        print('${querySnapshot.id} => ${querySnapshot.data()}');
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }
}

class DoctorOccupation {
  static CollectionReference<Map<String, dynamic>>
      get doctorOccupationsColRef =>
          FirebaseFirestore.instance.collection('Doctor Occupations');
  final String? occupationID;
  final String name;
  final String description;

  DoctorOccupation({
    this.occupationID,
    required this.name,
    required this.description,
  });

  factory DoctorOccupation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return DoctorOccupation(
      occupationID: snapshot.id,
      name: snapshot.data()!['occupation'],
      description: snapshot.data()!['description'],
    );
  }

  static Future<List<DoctorOccupation>> getAllFromFirestore() async {
    List<DoctorOccupation> data = [];
    await doctorOccupationsColRef.get().then(
      (querySnapshot) async {
        print("Successfully completed checklist");
        for (var docSnapshot in querySnapshot.docs) {
          data.add(DoctorOccupation.fromFirestore(docSnapshot));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }

  static Future<DoctorOccupation> getDataFromFirestore(
      String occupationID) async {
    late DoctorOccupation data;
    await doctorOccupationsColRef.doc(occupationID).get().then(
      (querySnapshot) async {
        print("Successfully completed checklist");
        data = DoctorOccupation.fromFirestore(querySnapshot);
        print('${querySnapshot.id} => ${querySnapshot.data()}');
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }
}
