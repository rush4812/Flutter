// home_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Model/post_model.dart';
import '../Services/post_service.dart';
import 'login_screen.dart';

class PostScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    int i = 1;
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Posts'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  showLogoutDialog(context);  // Trigger AlertDialog on logout button press
                },
              ),
            ]
        ),
        body: FutureBuilder<List<Post>>(
            future: apiService.fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No posts available.'));
              } else {
                List<Post> posts = snapshot.data!;
                return ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    Post post = posts[index];
                    return ListTile(
                      title: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text("${post.id}) ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.blue
                              ),),
                            Text(post.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.blue
                              ),),
                          ],
                        ),
                      ),
                      subtitle: Text(post.body),
                    );
                  },
                );
              }
            },
            ),
        );
    }
}
void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen(),));
            },
          ),
        ],
      );
    },
  );
}
