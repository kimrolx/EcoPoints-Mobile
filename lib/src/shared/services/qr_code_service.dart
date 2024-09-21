import 'package:cloud_firestore/cloud_firestore.dart';

class QrCodeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> checkIfScanned(String uuid) async {
    var doc = await _firestore.collection('scannedQRs').doc(uuid).get();
    return doc.exists;
  }

  Future<void> flagQRCodeAsScanned(int points, int bottlesRecycled,
      String userID, String userEmail, String uuid, String timestamp) async {
    await _firestore.collection('scannedQRs').doc(uuid).set({
      'time_scanned': FieldValue.serverTimestamp(),
      'qr_uuid': uuid,
      'time_generated': timestamp,
      'scanned': true,
      'points': points,
      'bottles_recycled': bottlesRecycled,
      'user_id': userID,
      'user_email': userEmail,
    });
  }
}
