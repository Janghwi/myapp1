import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Phrases01 {
  String id;
  String eng;
  String kor;
  String korprn;
  String jap;
  String japprn;
  
  Phrases01(
      this.id,
      this.eng,
      this.kor,
      this.korprn,
      this.jap,
      this.japprn
      );

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
    'id': id,
    'eng': eng,
    'kor': kor,
    'korprn': korprn,
    'jap': jap,
    'japprn': japprn,
  };

  // creating a Trip object from a firebase snapshot
  Phrases01.fromSnapshot(DocumentSnapshot snapshot) :
      id = snapshot['id'].toString(),
      eng = snapshot['eng'],
      kor = snapshot['kor'],
      korprn = snapshot['korprn'],
      jap = snapshot['jap'],
      japprn = snapshot['japprn'];


  Map<String, Icon> types() => {
    "car": Icon(Icons.directions_car, size: 50),
    "bus": Icon(Icons.directions_bus, size: 50),
    "train": Icon(Icons.train, size: 50),
    "plane": Icon(Icons.airplanemode_active, size: 50),
    "ship": Icon(Icons.directions_boat, size: 50),
    "other": Icon(Icons.directions, size: 50),
  };

}