import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Ukuran acuan = ukuran screenshot (310 x 714). Semua ukuran dikalikan
/// faktor skala [s] supaya proporsional di jendela Chrome berapa pun.
const double refW = 310;
const double refH = 714;

TextStyle _t(
  double s,
  double size, {
  FontWeight w = FontWeight.w400,
  Color c = Colors.white,
  double? height,
  bool shadow = false,
}) {
  return TextStyle(
    fontSize: size * s,
    fontWeight: w,
    color: c,
    height: height,
    decoration: TextDecoration.none,
    shadows: shadow ? [Shadow(color: Colors.black54, blurRadius: 3 * s)] : null,
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Titik tengah kolom & sisi atas baris ikon (satuan screenshot)
  static const List<double> colX = [43, 118, 193, 268];
  static const List<double> rowY = [333, 423, 513];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: LayoutBuilder(
          builder: (context, c) {
            final w = math.min(c.maxWidth, c.maxHeight * refW / refH);
            final s = w / refW;
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: SizedBox(
                width: w,
                height: refH * s,
                child: ClipRect(
                  child: Stack(
                    children: [
                      _wallpaper(),
                      _statusBar(s),
                      _clockWidget(s),
                      _searchBar(s),
                      ..._appGrid(s),
                      _telusuri(s),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------- Wallpaper
  /// Gradasi hijau-tosca sebagai dasar. Kalau kamu menaruh gambar wallpaper
  /// sendiri di assets/images/wallpaper.jpg, gambar itu otomatis tampil di atasnya.
  Widget _wallpaper() {
    return Positioned.fill(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1E8C85),
                  Color(0xFF2AA39F),
                  Color(0xFF1F8A86),
                  Color(0xFF1B7B78),
                ],
                stops: [0.0, 0.35, 0.7, 1.0],
              ),
            ),
          ),
          Image.asset(
            'assets/images/wallpaper.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------- Status bar
  Widget _statusBar(double s) {
    Widget bars() => Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final h in [3.0, 5.0, 7.0, 9.0])
          Container(
            margin: EdgeInsets.only(right: 1 * s),
            width: 2 * s,
            height: h * s,
            color: Colors.white,
          ),
      ],
    );

    return Stack(
      children: [
        Positioned(
          left: 46 * s,
          top: 11 * s,
          child: Text('18.55', style: _t(s, 11.5, w: FontWeight.w500)),
        ),
        Positioned(
          right: 12 * s,
          top: 10 * s,
          child: Row(
            children: [
              Icon(Icons.alarm, size: 11 * s, color: Colors.white),
              SizedBox(width: 4 * s),
              Icon(Icons.wifi, size: 12 * s, color: Colors.white),
              SizedBox(width: 4 * s),
              bars(),
              SizedBox(width: 3 * s),
              bars(),
              SizedBox(width: 5 * s),
              Container(
                width: 20 * s,
                height: 10 * s,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8C547),
                  borderRadius: BorderRadius.circular(2.5 * s),
                ),
                child: Text(
                  '17',
                  style: _t(s, 7, w: FontWeight.w700, c: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------- Jam + cuaca
  Widget _clockWidget(double s) {
    return Stack(
      children: [
        Positioned(
          left: 14 * s,
          top: 116 * s,
          child: Semantics(
            label: 'Jam 18.55',
            excludeSemantics: true,
            child: Text(
              '18.55',
              style: _t(s, 50, w: FontWeight.w300, height: 1.1),
            ),
          ),
        ),
        Positioned(
          right: 12 * s,
          top: 123 * s,
          child: Semantics(
            label: 'Sebagian berawan, 28 derajat, Minggu 11 Oktober',
            excludeSemantics: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sebagian berawan 28°',
                      style: _t(s, 11.5, w: FontWeight.w500, shadow: true),
                    ),
                    SizedBox(width: 3 * s),
                    Icon(Icons.wb_cloudy, size: 17 * s, color: Colors.white),
                  ],
                ),
                SizedBox(height: 6 * s),
                Text(
                  'Min, 11 Okt',
                  style: _t(s, 11.5, w: FontWeight.w500, shadow: true),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------- Search bar
  Widget _searchBar(double s) {
    Widget icon(double cx, IconData i) => Positioned(
      left: (cx - 9) * s,
      top: 11.5 * s,
      child: Icon(i, size: 18 * s, color: Colors.white),
    );

    return Positioned(
      left: 14 * s,
      top: 256 * s,
      width: 284 * s,
      height: 41 * s,
      child: Semantics(
        label: 'Kotak pencarian',
        button: true,
        excludeSemantics: true,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xB8303034),
            borderRadius: BorderRadius.circular(21 * s),
          ),
          child: Stack(
            children: [
              icon(22, Icons.search),
              icon(178, Icons.auto_awesome),
              icon(221, Icons.mic),
              icon(262, Icons.center_focus_strong),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------- Grid ikon
  List<Widget> _appGrid(double s) {
    final apps = <_App>[
      // Baris 1
      _App.folder(
        'Folder',
        const [Icons.chat, Icons.music_note, Icons.place, Icons.photo_camera],
        const [
          Color(0xFF25D366),
          Color(0xFFFF4D6A),
          Color(0xFFEA4335),
          Color(0xFFBDBDBD),
        ],
      ),
      _App('WhatsApp', Icons.chat, Colors.white, const Color(0xFF25D366)),
      _App('Musik', Icons.music_note, Colors.white, const Color(0xFFE8344E)),
      _App(
        'Maps',
        Icons.place,
        const Color(0xFFEA4335),
        const Color(0xFFF2F2F2),
      ),
      // Baris 2
      _App(
        'Files',
        Icons.folder,
        const Color(0xFF3D7BF0),
        const Color(0xFFE9EEF7),
      ),
      _App('Kunci Layar', Icons.lock, Colors.white, const Color(0xFF8E8E93)),
      _App.folder(
        'Folder',
        const [Icons.camera_alt, Icons.close, Icons.send, Icons.photo],
        const [
          Color(0xFFFF6FA5),
          Colors.white,
          Color(0xFF4FC3F7),
          Color(0xFFFFD54F),
        ],
        badge: 4,
      ),
      _App.folder(
        'Google',
        const [
          Icons.mail,
          Icons.place,
          Icons.photo,
          Icons.play_arrow,
          Icons.cloud,
          Icons.calendar_today,
          Icons.description,
          Icons.search,
          Icons.chat,
        ],
        const [
          Color(0xFFEA4335),
          Color(0xFF34A853),
          Color(0xFFFBBC05),
          Color(0xFFEA4335),
          Color(0xFF4285F4),
          Color(0xFF4285F4),
          Color(0xFF4285F4),
          Color(0xFFFFFFFF),
          Color(0xFF34A853),
        ],
      ),
      // Baris 3
      _App.folder(
        'Folder',
        const [
          Icons.phone,
          Icons.map,
          Icons.shopping_bag,
          Icons.photo_camera,
          Icons.music_note,
          Icons.settings,
        ],
        const [
          Color(0xFF34A853),
          Color(0xFF4285F4),
          Color(0xFFFF9800),
          Color(0xFFBDBDBD),
          Color(0xFFE8344E),
          Color(0xFFBDBDBD),
        ],
      ),
      _App(
        'Alfagift',
        Icons.card_giftcard,
        Colors.white,
        const Color(0xFFD8232A),
      ),
    ];

    return [
      for (var i = 0; i < apps.length; i++)
        Positioned(
          left: (colX[i % 4] - 30) * s,
          top: rowY[i ~/ 4] * s,
          child: AppIcon(s: s, app: apps[i]),
        ),
    ];
  }

  // ----------------------------------------------------------------- Telusuri
  Widget _telusuri(double s) {
    return Positioned(
      left: 120 * s,
      top: 597 * s,
      width: 72 * s,
      height: 21 * s,
      child: Semantics(
        label: 'Telusuri',
        button: true,
        excludeSemantics: true,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0x66000000),
            borderRadius: BorderRadius.circular(11 * s),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 11 * s, color: Colors.white),
              SizedBox(width: 3 * s),
              Text('Telusuri', style: _t(s, 9.5)),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------- Model
class _App {
  final String name;
  final IconData? icon;
  final Color iconColor;
  final Color tileColor;
  final int? badge;
  final List<IconData>? minis;
  final List<Color>? miniColors;

  _App(this.name, this.icon, this.iconColor, this.tileColor, {this.badge})
    : minis = null,
      miniColors = null;

  _App.folder(
    this.name,
    List<IconData> this.minis,
    List<Color> this.miniColors, {
    this.badge,
  }) : icon = null,
       iconColor = Colors.white,
       tileColor = const Color(0x73000000);

  bool get isFolder => minis != null;
}

// ----------------------------------------------------------------- AppIcon
/// Satu ikon aplikasi (tile + badge + label).
/// Memakai implicit animation (AnimatedScale) saat ditekan dan menghormati
/// pengaturan "reduce motion" perangkat (disableAnimations).
class AppIcon extends StatefulWidget {
  const AppIcon({super.key, required this.s, required this.app});

  final double s;
  final _App app;

  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> {
  bool _pressed = false;

  void _set(bool v) => setState(() => _pressed = v);

  Widget _content(double s) {
    final a = widget.app;
    if (a.isFolder) {
      return Padding(
        padding: EdgeInsets.all(5 * s),
        child: Wrap(
          spacing: 2 * s,
          runSpacing: 2 * s,
          children: [
            for (var i = 0; i < a.minis!.length; i++)
              Container(
                width: 10 * s,
                height: 10 * s,
                decoration: BoxDecoration(
                  color: const Color(0x66FFFFFF),
                  borderRadius: BorderRadius.circular(2.5 * s),
                ),
                child: Icon(a.minis![i], size: 7 * s, color: a.miniColors![i]),
              ),
          ],
        ),
      );
    }
    return Icon(a.icon, size: 26 * s, color: a.iconColor);
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.s;
    final a = widget.app;
    final tanpaGerak = MediaQuery.of(context).disableAnimations;

    return Semantics(
      label: a.badge == null ? a.name : '${a.name}, ${a.badge} notifikasi',
      button: true,
      excludeSemantics: true,
      child: GestureDetector(
        onTapDown: (_) => _set(true),
        onTapUp: (_) => _set(false),
        onTapCancel: () => _set(false),
        child: AnimatedScale(
          scale: _pressed ? 0.9 : 1.0,
          duration: Duration(milliseconds: tanpaGerak ? 0 : 150),
          curve: Curves.easeOut,
          child: SizedBox(
            width: 60 * s,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 44 * s,
                      height: 44 * s,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: a.tileColor,
                        borderRadius: BorderRadius.circular(12 * s),
                      ),
                      child: _content(s),
                    ),
                    if (a.badge != null)
                      Positioned(
                        top: 3 * s,
                        right: 0,
                        child: Container(
                          width: 15 * s,
                          height: 15 * s,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF3B30),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${a.badge}',
                            style: _t(s, 9.5, w: FontWeight.w700),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 3.5 * s),
                Text(
                  a.name,
                  style: _t(s, 10, shadow: true),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
