import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";

class ImageRevealGame extends StatefulWidget {
  const ImageRevealGame({Key? key}) : super(key: key);

  @override
  _ImageRevealGameState createState() => _ImageRevealGameState();
}

class _ImageRevealGameState extends State<ImageRevealGame> {
  // Grid'in boyutlarını tanımlıyoruz
  final int rows = 8;
  final int columns = 5;

  // Karelerin açık/kapalı durumunu takip eden liste
  late List<List<bool>> revealedCells;

  @override
  void initState() {
    super.initState();
    // Başlangıçta tüm kareleri kapalı olarak ayarlıyoruz
    revealedCells = List.generate(
      rows,
          (i) => List.generate(columns, (j) => false),
    );
  }

  // Kareye tıklandığında veya üzerine gelindiğinde çağrılacak fonksiyon
  void _revealCell(int row, int col) {
    setState(() {
      revealedCells[row][col] = true;
    });
  }

  // Parmağın konumuna göre hangi kareye dokunduğunu hesaplayan fonksiyon
  void _revealCellAtPosition(Offset position, double cellWidth, double cellHeight) {
    final row = (position.dy ~/ cellHeight).clamp(0, rows - 1);
    final col = (position.dx ~/ cellWidth).clamp(0, columns - 1);
    _revealCell(row, col);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fotoğrafı Keşfet',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF0CB3EB),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF0CB3EB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const Icon(
                      Icons.volume_up_rounded,
                      size: 45,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF0CB3EB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Fotoğrafı keşfetmek için \nparmağınızı kareler üzerinde \ngezdiriniz.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 10 / 16,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final cellWidth = constraints.maxWidth / columns;
                      final cellHeight = constraints.maxHeight / rows;
              
                      return GestureDetector(
                        onPanUpdate: (details) {
                          _revealCellAtPosition(
                            details.localPosition,
                            cellWidth,
                            cellHeight,
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/Games/image_reveal_game/animals.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                              ),
                              itemCount: rows * columns,
                              itemBuilder: (context, index) {
                                final row = index ~/ columns;
                                final col = index % columns;
              
                                return AnimatedOpacity(
                                  opacity: revealedCells[row][col] ? 0.0 : 1.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF66D5FD),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
