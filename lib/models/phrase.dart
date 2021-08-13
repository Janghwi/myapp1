import 'package:cloud_firestore/cloud_firestore.dart';

class Phrases01 {
   int id; 
   String eng; 
   String kor; 
   String korprn; 
   String jap; 
   String japprn; 

  Phrases01({
    this.id, 
    this.eng, 
    this.kor, 
    this.korprn, 
    this.jap, 
    this.japprn });


//  Map<String, dynamic> toJson() => {
//     'id': id,
//     'eng': eng,
//     'kor': kor,
//     'korprn': korprn,
//     'jap': jap,
//     'japprn': japprn,
//   };
factory Phrases01.fromJSON(Map value)  {
  return Phrases01(
      id : value['id'],
      eng : value['eng'],
      kor : value['kor'],
      korprn : value['korprn'],
      jap : value['jap'],
      japprn : value['japprn'],
  );
  // factory Phrases01.fromJSON(Map<String, dynamic> json)  {
  // return Phrases01(
  //     id : json['id'],
  //     eng : json['eng'],
  //     kor : json['kor'],
  //     korprn : json['korprn'],
  //     jap : json['jap'],
  //     japprn : json['japprn'],
  // );
  // Phrases01.fromSnapshot(DocumentSnapshot snapshot) :
  //     id = snapshot['id'],
  //     eng = snapshot['eng'],
  //     kor = snapshot['kor'],
  //     korprn = snapshot['korprn'],
  //     jap = snapshot['jap'],
  //     japprn = snapshot['japprn'];
 }
}