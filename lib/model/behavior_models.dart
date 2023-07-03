import 'package:cloud_firestore/cloud_firestore.dart';

class BehaviorOverview {
  static CollectionReference<Map<String, dynamic>>
      get behaviorOverviewsColRef =>
          FirebaseFirestore.instance.collection('BehaviorOverviews');
  final String? id;
  final String title;
  final String imageURL;
  final String description;

  BehaviorOverview({
    this.id,
    required this.title,
    required this.imageURL,
    required this.description,
  });

  factory BehaviorOverview.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return BehaviorOverview(
      id: snapshot.id,
      title: snapshot.data()!['title'],
      imageURL: snapshot.data()!['imageURL'],
      description: snapshot.data()!['description'],
    );
  }

  static Future<List<BehaviorOverview>> getAllFromFirestore() async {
    List<BehaviorOverview> data = [];
    await behaviorOverviewsColRef.get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          data.add(BehaviorOverview.fromFirestore(docSnapshot));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }
}

class BehaviorContent {
  static CollectionReference<Map<String, dynamic>> get behaviorContentsColRef =>
      FirebaseFirestore.instance.collection('BehaviorContents');
  final String behaviorID;
  final String overview;
  final String howToAddress;

  BehaviorContent({
    required this.behaviorID,
    required this.overview,
    required this.howToAddress,
  });

  factory BehaviorContent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return BehaviorContent(
      behaviorID: snapshot.data()!['behaviorID'],
      overview: snapshot.data()!['overview'],
      howToAddress: snapshot.data()!['howToAddress'],
    );
  }

  static Future<BehaviorContent> getDataFromFirestore(String behaviorID) async {
    late BehaviorContent data;
    await behaviorContentsColRef
        .where('behaviorID', isEqualTo: behaviorID)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot =
            querySnapshot.docs.first;
        data = BehaviorContent.fromFirestore(docSnapshot);
        print('${docSnapshot.id} => ${docSnapshot.data()}');
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }
}
