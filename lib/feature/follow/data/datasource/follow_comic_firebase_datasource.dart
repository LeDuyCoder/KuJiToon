import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FollowComicFirebaseDatasource {

  /// Lấy danh sách **slug truyện mà user hiện tại đang theo dõi**.
  ///
  /// Firestore structure được sử dụng:
  /// ```
  /// users/{userId}/follows/data/{comicSlug}
  /// ```
  ///
  /// - Mỗi document trong collection `data` đại diện cho **1 truyện được follow**
  /// - `documentId` chính là `comicSlug`
  /// - Hàm **chỉ lấy documentId**, không đọc field bên trong document
  ///
  /// ### Returns
  /// - `Future<List<String>>`
  ///   - Danh sách `slug` truyện mà user đang theo dõi
  ///   - Trả về list rỗng nếu user chưa follow truyện nào
  ///
  /// ### Throws
  /// - Có thể throw exception nếu:
  ///   - User chưa đăng nhập (`currentUser == null`)
  ///   - Lỗi mạng hoặc quyền Firestore (permission denied)
  ///
  /// ### Example
  /// ```dart
  /// final slugs = await getAllFollowComic();
  /// // ["tien-vo-de-ton", "tu-tien-than-toc"]
  /// ```
  Future<List<String>> getAllFollowComic() async {
    List<String> slugs = [];
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await firestore.collection("data")
        .doc("users")
        .collection("follows")
        .doc(userId)
        .collection("data")
        .get();
    
    slugs.addAll(snapshot.docs.map((e) => e.id));
    
    return slugs;
  }

}