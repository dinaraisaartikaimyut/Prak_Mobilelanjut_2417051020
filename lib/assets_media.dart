import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AssetsMediaPage extends StatefulWidget {
  const AssetsMediaPage({super.key});

  @override
  State<AssetsMediaPage> createState() => _AssetsMediaPageState();
}

class _AssetsMediaPageState extends State<AssetsMediaPage> {
  final AudioPlayer player = AudioPlayer();

  bool isPlaying = false;
  int _currentIndex = 0;

  void playAudio() async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.play(
        AssetSource('audios/music.mp3'),
      );
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FC),

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        title: const Text(
          'Beranda Assets & Media',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color(0xFFF8F6FC),
      ),

      // =========================
      // DRAWER
      // =========================
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF4D63D9),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.video_library,
              ),
              title: const Text(
                'Video',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                ),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: 'Data dari halaman Beranda',
                );
              },
            ),
          ],
        ),
      ),

      // =========================
      // BODY
      // =========================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // =========================
              // PROFILE CARD
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F5FB),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/profile.jpeg',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Nama Mahasiswa',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // AUDIO CARD
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F5FB),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Audio Motivasi',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E5FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundColor:
                                const Color(0xFF4D63D9),
                            child: IconButton(
                              onPressed: playAudio,
                              icon: Icon(
                                isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Expanded(
                            child: LinearProgressIndicator(
                              minHeight: 6,
                              backgroundColor: Color(0xFFCFCDEF),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                Color(0xFF4D63D9),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          const Icon(
                            Icons.volume_up,
                            color: Color(0xFF202342),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // =========================
      // BOTTOM NAVIGATION
      // =========================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,

        selectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),

        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            Navigator.pushNamed(
              context,
              '/detail',
            );
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Video',
          ),
        ],
      ),
    );
  }
}