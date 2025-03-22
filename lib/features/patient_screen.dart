import 'package:flutter/material.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final List<String> _allPatients = [
    "Costales, Enand Eunorel D.",
    "Balcita, Jhed F.",
    "Pajimola, Marie Claire E.",
    "Mina, Denver Lloyd C.",
    "Fernandez, Dhanica Pearl C.",
    "Reyes, Angelo B.",
  ];

  String _searchQuery = "";
  bool _isSortedAZ = false;

  @override
  Widget build(BuildContext context) {
    List<String> filteredPatients =
        _allPatients
            .where(
              (patient) =>
                  patient.toLowerCase().contains(_searchQuery.toLowerCase()),
            )
            .toList();

    if (_isSortedAZ) {
      filteredPatients.sort((a, b) => a.compareTo(b));
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2E4B3B),
                  Color(0xFF000000),
                  Color(0xFF2E4B3B),
                ],
              ),
            ),
          ),
          Column(
            children: [
              // Header with Wave
              Stack(
                children: [
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      height: 200,
                      color: const Color(0xFF2E4B3B),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.menu, color: Colors.white, size: 30),
                        const SizedBox(height: 10),
                        const Text(
                          "PATIENT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Search Bar
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            onChanged:
                                (value) => setState(() => _searchQuery = value),
                            decoration: const InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Sorting & Gender Buttons
                        Row(
                          children: [
                            const Text(
                              "Sort By",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Sort Button
                            GestureDetector(
                              onTap:
                                  () => setState(
                                    () => _isSortedAZ = !_isSortedAZ,
                                  ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      _isSortedAZ ? Colors.black : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "A → Z",
                                  style: TextStyle(
                                    color:
                                        _isSortedAZ
                                            ? Colors.white
                                            : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Gender Buttons (Placeholder for filtering)
                            _genderFilterButton(Icons.female, Colors.pink),
                            const SizedBox(width: 5),
                            _genderFilterButton(Icons.male, Colors.blue),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Patient List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: filteredPatients.length,
                  itemBuilder:
                      (context, index) =>
                          _buildPatientTile(filteredPatients[index]),
                ),
              ),
            ],
          ),
        ],
      ),
      // Fixed Bottom Navigation Bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomAppBar(
            color: const Color(0xFF27422E),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.home, color: Colors.white, size: 30),
                  Icon(Icons.mail_outline, color: Colors.white70, size: 30),
                  Icon(Icons.calendar_today, color: Colors.white70, size: 30),
                  Icon(Icons.person, color: Colors.white, size: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPatientTile(String name) {
    return Card(
      color: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.person, color: Colors.white, size: 60),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Info",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Gender Filter Button (Placeholder)
  Widget _genderFilterButton(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: color, size: 24),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.65,
      size.width * 0.5,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.85,
      size.width,
      size.height * 0.75,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
