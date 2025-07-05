import 'package:flutter/material.dart';
import 'konsumsi_bijak_page.dart';
import 'detail_page.dart';
import 'daur_ulang.dart';
import 'kurangi_sampah.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String? userName;
  final String? userEmail;
  final bool showWelcomeMessage;

  const HomePage({
    super.key,
    this.userName,
    this.userEmail,
    this.showWelcomeMessage = false,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> features = [
    {
      'title': 'Konsumsi Bijak',
      'desc':
          'Belajar memilih barang yang ramah lingkungan dan tidak berlebihan.',
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/01/20/00/05/good-luck-1993688_1280.jpg',
    },
    {
      'title': 'Kurangi Sampah',
      'desc':
          'Kenali pentingnya mengurangi limbah dengan tindakan kecil sehari-hari.',
      'imageUrl':
          'https://images.unsplash.com/photo-1528323273322-d81458248d40',
    },
    {
      'title': 'Daur Ulang',
      'desc': 'Ubah barang bekas menjadi sesuatu yang bermanfaat dan menarik.',
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/04/08/19/55/bottles-3302316_1280.jpg',
    },
  ];

  String? selectedTitle;

  @override
  void initState() {
    super.initState();
    if (widget.showWelcomeMessage && widget.userName != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login berhasil. Selamat datang, ${widget.userName}!",
            ),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedFeature = features.firstWhere(
      (f) => f['title'] == selectedTitle,
      orElse: () => {},
    );

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text("Konsumsi & Produksi Berkelanjutan"),
        backgroundColor: Colors.green.shade700,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.userName ?? 'cynakatamso'),
              accountEmail: Text(widget.userEmail ?? 'cynakatamso@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.green),
              ),
              decoration: BoxDecoration(color: Colors.green.shade700),
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Login"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text("Konsumsi Bijak"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => KonsumsiBijakPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.reduce_capacity),
              title: Text("Kurangi Sampah"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => KurangiSampahPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.recycling),
              title: Text("Daur Ulang"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RecycleCheckerPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Tentang Aplikasi"),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  isScrollControlled:
                      true,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Icon(
                                Icons.eco,
                                size: 48,
                                color: Colors.green.shade700,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Tentang Aplikasi",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade800,
                              ),
                            ),
                            SizedBox(height: 10),
                            Divider(thickness: 1, color: Colors.green.shade200),
                            SizedBox(height: 10),
                            Text(
                              "Aplikasi ini bertujuan untuk mengedukasi pengguna mengenai pentingnya konsumsi dan produksi berkelanjutan demi menjaga lingkungan hidup.",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Fitur Unggulan:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                            SizedBox(height: 6),
                            ListTile(
                              leading: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              title: Text("Konsumsi Bijak"),
                              subtitle: Text(
                                "Tips memilih barang yang ramah lingkungan.",
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.recycling,
                                color: Colors.green,
                              ),
                              title: Text("Daur Ulang"),
                              subtitle: Text(
                                "Ide kreatif daur ulang barang bekas.",
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.delete_sweep,
                                color: Colors.green,
                              ),
                              title: Text("Kurangi Sampah"),
                              subtitle: Text(
                                "Langkah kecil untuk mengurangi limbah.",
                              ),
                            ),
                            Divider(height: 20, color: Colors.green.shade200),
                            Text(
                              "Hubungi Kami:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 8),
                                Text("CynaHidupSehat@Jupyter.id"),
                              ],
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.close),
                                label: Text("Tutup"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade700,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => HomePage(
                          userName: 'cynakatamso',
                          userEmail: 'cynakatamso@gmail.com',
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat datang!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Pilih topik untuk belajar lebih lanjut tentang gaya hidup ramah lingkungan.",
                style: TextStyle(fontSize: 16, color: Colors.green.shade700),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedTitle,
                    hint: Text("Pilih Topik"),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.green.shade700,
                    ),
                    isExpanded: true,
                    items: [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Text("Tutup"),
                      ),
                      ...features.map((feature) {
                        return DropdownMenuItem<String>(
                          value: feature['title'],
                          child: Text(feature['title']!),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedTitle = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child:
                    (selectedFeature.isNotEmpty)
                        ? Card(
                          key: ValueKey(selectedTitle),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: Image.network(
                                  selectedFeature['imageUrl']!,
                                  height: 180,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) => Center(
                                        child: Icon(Icons.broken_image),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  selectedFeature['desc'] ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 10,
                                ),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    final title = selectedFeature['title'];
                                    if (title == 'Konsumsi Bijak') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => KonsumsiBijakPage(),
                                        ),
                                      );
                                    } else if (title == 'Daur Ulang') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => RecycleCheckerPage(),
                                        ),
                                      );
                                    } else if (title == 'Kurangi Sampah') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => KurangiSampahPage(),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => DetailPage(
                                                title:
                                                    selectedFeature['title']!,
                                                description:
                                                    selectedFeature['desc']!,
                                                imageUrl:
                                                    selectedFeature['imageUrl']!,
                                              ),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.arrow_forward),
                                  label: Text("Pelajari Lebih Lanjut"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade700,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        : Container(
                          key: ValueKey("placeholder"),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'download.jpeg',
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                color: Colors.green.shade700,
                child: Center(
                  child: Text(
                    'CopyRight ©2025 by ${widget.userName ?? 'cynakatamso'}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
