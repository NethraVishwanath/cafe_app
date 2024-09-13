import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String uid, String username, String email, String phoneNumber) async {
    await _firestore.collection('users').doc(uid).set({
      'username': username,
      'email': email,
      'phonenumber': phoneNumber,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<bool> isPhoneNumberRegistered(String phoneNumber) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('users')
          .where('phonenumber', isEqualTo: phoneNumber)
          .get();

      // Check if the document exists
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking if phone number is registered: $e');
      return false; // Return false in case of an error
    }
  }
}
