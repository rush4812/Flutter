import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Model/elec_model.dart';
import '../Services/electronic_service.dart';
import 'login_screen.dart';

class ElectronicScreen extends StatefulWidget {
  const ElectronicScreen({super.key});

  @override
  State<ElectronicScreen> createState() => _ElectronicScreenState();
}

class _ElectronicScreenState extends State<ElectronicScreen> {
  late Future<ResponseModel> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts(); // Fetch products when the screen is loaded
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
        title: Text('Products'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                showLogoutDialog(context);  // Trigger AlertDialog on logout button press
              },
            ),
          ]
      ),
      body: FutureBuilder<ResponseModel>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Show a loader while fetching data
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Show error if something goes wrong
            } else if (snapshot.hasData) {
              final products = snapshot.data!.products;
              return ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0), // Adds a grey border around the item
                      borderRadius: BorderRadius.circular(8.0), // Optional: makes the border rounded
                    ),
                    margin: const EdgeInsets.all(8.0), // Adds space between items
                    child: ListTile(
                      leading: Image.network(product.image, width: 50, height: 50), // Show product image
                      title: Text(product.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        )
                        ,),
                      subtitle: Text('\$${product.price.toString()}',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          )),
                      trailing: Text('${product.discount}% off',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                          )),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No products available.'));
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
