import 'package:flutter/material.dart';

import '../../../model/clinic_model.dart';
import '../../../widgets/clinic_item.dart';
import '../../../widgets/widgets/dropdown.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  List<Doctor>? filteredDoctors;
  List<Doctor>? allDoctors;
  List<String> cities = [];
  List<String> occupations = [];
  String cityDropdownValue = '';
  String occupationDropdownValue = '';

  void fetchDoctors() async {
    allDoctors = await Doctor.getAllFromFirestore();
    loadCitiesAndOccupations();
    cityDropdownValue = cities.first;
    occupationDropdownValue = occupations.first;
    setFilteredDoctors(cityDropdownValue, occupationDropdownValue);
    setState(() {});
  }

  void loadCitiesAndOccupations() {
    cities = [
      'Everywhere',
      ...allDoctors!
          .map((Doctor doctor) => doctor.hospitalCity)
          .toSet()
          .toList()
        ..sort()
    ];
    occupations = [
      'Any',
      ...allDoctors!.map((Doctor doctor) => doctor.occupation).toSet().toList()
        ..sort()
    ];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  void setFilteredDoctors(String place, String occupation) {
    setState(() {
      filteredDoctors = allDoctors!
          .where((Doctor doctor) =>
              (place == 'Everywhere' || doctor.hospitalCity == place) &&
              (occupation == 'Any' || doctor.occupation == occupation))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            title: const Text('Doctors/Therapists'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropDown(
                              value: cityDropdownValue,
                              isExpanded: true,
                              list: cities,
                              onChanged: (String? value) {
                                setState(
                                  () {
                                    cityDropdownValue = value!;
                                    setFilteredDoctors(cityDropdownValue,
                                        occupationDropdownValue);
                                  },
                                );
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomDropDown(
                              value: occupationDropdownValue,
                              isExpanded: true,
                              list: occupations,
                              onChanged: (String? value) {
                                setState(
                                  () {
                                    occupationDropdownValue = value!;
                                    setFilteredDoctors(cityDropdownValue,
                                        occupationDropdownValue);
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: filteredDoctors == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: filteredDoctors!.length,
                itemBuilder: (context, index) {
                  return CustomDoctorItem(
                    docName: filteredDoctors![index].name,
                    docOccupation: filteredDoctors![index].occupation,
                    description: filteredDoctors![index].occupationDescription,
                    address: filteredDoctors![index].hospitalAddress,
                    trunkLine: filteredDoctors![index].hospitalTelephoneNo,
                    hospitalName: filteredDoctors![index].hospitalName,
                    website: filteredDoctors![index].hospitalWebsite,
                    gMapsLink: filteredDoctors![index].hospitalGMapsLink,
                  );
                },
                shrinkWrap: true,
              ),
      ),
    );
  }
}

// Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             'Doctors/Therapists',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: CustomDropDown(
//                     value: textValuePlaces,
//                     isExpanded: true,
//                     list: DoctorsPageData.places,
//                     onChanged: (String? value) {
//                       setState(
//                         () {
//                           textValuePlaces = value!;
//                           setFilteredDoctors(
//                               textValuePlaces, textValueOccupation);
//                         },
//                       );
//                     }),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                 child: CustomDropDown(
//                     value: textValueOccupation,
//                     isExpanded: true,
//                     list: DoctorsPageData.occupations,
//                     onChanged: (String? value) {
//                       setState(
//                         () {
//                           textValueOccupation = value!;
//                           setFilteredDoctors(
//                               textValuePlaces, textValueOccupation);
//                         },
//                       );
//                     }),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: filteredDoctors.length,
    //           itemBuilder: (context, index) {
    //             return CustomDoctorItem(
    //               pfp: filteredDoctors[index].profilePic,
    //               docName: filteredDoctors[index].name,
    //               docOccupation: filteredDoctors[index].occupation,
    //               description: filteredDoctors[index].jobDescription,
    //               address: filteredDoctors[index].address,
    //               trunkLine: filteredDoctors[index].trunkLine,
    //               hospitalName: filteredDoctors[index].hospital,
    //             );
    //           },
    //           shrinkWrap: true,
    //         ),
    //       )
    //     ],
    //   ),
    // )