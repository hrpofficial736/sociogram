
import '../supabase_client.dart';

Map<String, String?> getUserCredentials() {
  final service = SupabaseAuth();
  String userEmail = service.client.auth.currentUser?.userMetadata?["email"];
  String? name = service.client.auth.currentUser?.userMetadata?["name"];
  print("Avatar URL is : ${service.client.auth.currentUser?.userMetadata?["avatar_url"]}");
  String? avatarUrl = service.client.auth.currentUser?.userMetadata?["avatar_url"];
  String? imageUrl = (avatarUrl != null && avatarUrl.isNotEmpty ? avatarUrl : null) ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR81iX4Mo49Z3oCPSx-GtgiMAkdDop2uVmVvw&s";
  String? username = userEmail.split('@')[0];

  return {
    "userEmail": userEmail,
    "username": username,
    "name": name,
    "image": imageUrl
  };
}
