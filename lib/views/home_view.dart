// final currentUser = FirebaseAuth.instance.currentUser;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  final String cnic;
  const HomeView({super.key, required this.cnic});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    // Replace 'userCnic' with the actual CNIC of the logged-in user
    loadUserData(widget.cnic);
  }

  Future<void> loadUserData(String cnic) async {
    Map<String, dynamic> data = await Auth.getUserData(cnic);
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB28CFF),
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (_) => const DoctorSearch()));
        },
        child: const Icon(Icons.qr_code_scanner_sharp),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xffB28cff),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginView()));
                          },
                          child: const Icon(
                            Icons.logout,
                          )),
                      const SizedBox(
                        width: 42,
                      ),
                      Text('Welcome Again!',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Column(
                  children: [
                    Text('Your Details',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    const SizedBox(
                      height: 20,
                    ),
                    const Icon(
                      Icons.person,
                      size: 60,
                    ),
                    Text(
                      "${userData['userName']}",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    Text("${userData['gender']}",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w400)),
                    Text("${userData['cnic']}",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
