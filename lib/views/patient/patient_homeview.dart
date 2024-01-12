import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/auth.dart';
import '../../services/user.dart';
import '../chat/chat_view.dart';
import '../login_view.dart';

class PatientHomeView extends StatefulWidget {
  final String cnic;
  const PatientHomeView({super.key, required this.cnic});

  @override
  State<PatientHomeView> createState() => _PatientHomeViewState();
}

class _PatientHomeViewState extends State<PatientHomeView> {
  late Future<List<Map<String, dynamic>>> data;
  User? admin;

  @override
  void initState() {
    super.initState();
    loadUserData(widget.cnic);
    data = fetchData('Doctor');
  }

  Future<void> loadUserData(String cnic) async {
    admin = await Auth.getUserData(cnic, "Patient");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB28cff),
        title: Text(
          "Welcome ${admin?.userName ?? ''}",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 202, 177, 253),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text("Gender: ${admin?.gender ?? ''}",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 5,
              ),
              Text("National Id: ${admin?.cnic ?? ''}",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Date of birth: ${admin?.dob.toString() ?? ""}", // user?.dob.toString() ?? 'DOB',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 630,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginView()));
                  },
                  child: Text(
                    "Logout",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 24),
                  )),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data?[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ChatView(
                                              user: User.fromDocument(
                                                  item as Map<String, dynamic>),
                                              admin: admin ?? User(),
                                            )));
                              },
                              child: ListTile(
                                title: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 218, 211, 233)),
                                    child:
                                        Text('Doctor: ${item?['userName']}')),
                              ),
                            );
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
