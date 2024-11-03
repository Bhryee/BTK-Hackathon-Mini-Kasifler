import 'package:flutter/material.dart';

class SequenceGame extends StatefulWidget {
  const SequenceGame({Key? key}) : super(key: key);

  @override
  State<SequenceGame> createState() => _SequenceGameState();
}

class _SequenceGameState extends State<SequenceGame> {
  final List<String> images = [
    'assets/Games/sequence_game/brush_teeth_1.png',
    'assets/Games/sequence_game/brush_teeth_2.png',
    'assets/Games/sequence_game/brush_teeth_3.png',
    'assets/Games/sequence_game/brush_teeth_4.png',
  ];

  late List<String> shuffledImages;
  List<String?> placedImages = List.filled(4, null);
  List<bool> visibilityList = List.filled(4, true);
  bool isCorrectOrder = true;

  @override
  void initState() {
    super.initState();
    shuffledImages = List.from(images)..shuffle();
  }

  bool checkSequence() {
    for (int i = 0; i < images.length; i++) {
      if (placedImages[i] != images[i]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Sıralama Oyunu',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF6860F4),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const InstructionSection(),
            DraggableImageList(
              images: shuffledImages,
              visibilityList: visibilityList,
            ),
            TargetImageSlots(
              shuffledImages: shuffledImages,
              placedImages: placedImages,
              onImagePlaced: (index, image, originalIndex) {
                setState(() {
                  placedImages[index] = image;
                  visibilityList[originalIndex] = false;

                  if (checkSequence()) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Center(
                          child: const Text(
                            'AFERİN!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/Games/sequence_game/cat_happy.png',
                              height: 200,
                              width: 200,
                            ),
                          ],
                        ),
                        backgroundColor: Color(0xFF9294FB),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                shuffledImages.shuffle();
                                placedImages = List.filled(4, null);
                                visibilityList = List.filled(4, true);
                              });
                            },
                            child: const Icon(
                              Icons.check_circle_outline_rounded,
                              size: 50,
                              color: Color(0xFF5843E8),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (!checkSequence() && !placedImages.contains(null)) {
                    isCorrectOrder = false;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Center(
                          child: const Text(
                            'ÜZGÜNÜM!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/Games/sequence_game/cat_sad.png',
                              height: 200,
                              width: 200,
                            ),
                          ],
                        ),
                        backgroundColor: Color(0xFF9294FB),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                placedImages = List.filled(4, null);
                                visibilityList = List.filled(4, true);
                              });
                            },
                            child: const Icon(
                              Icons.refresh_rounded,
                              size: 50,
                              color: Color(0xFF5843E8),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                });
              },
            ),
            // Image added at the bottom
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset(
                'assets/Games/sequence_game/child.png', // Replace with your image path
                height: 350, // Adjust the height as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InstructionSection extends StatelessWidget {
  const InstructionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  color: const Color(0xFF6860F4),
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
              color: const Color(0xFF6860F4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Resimleri doğru sırada \noluşturmak için sürükleyip \nbırakınız.',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

class DraggableImageList extends StatelessWidget {
  final List<String> images;
  final List<bool> visibilityList;

  const DraggableImageList({
    Key? key,
    required this.images,
    required this.visibilityList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(images.length, (index) {
          return visibilityList[index]
              ? Draggable<String>(
            data: images[index],
            feedback: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            childWhenDragging: Container(
              width: 90,
              height: 90,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Container(
              width: 90,
              height: 90,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
              : Container(
            width: 90,
            height: 90,
            margin: const EdgeInsets.all(4.0),
          );
        }),
      ),
    );
  }
}

class TargetImageSlots extends StatelessWidget {
  final List<String?> placedImages;
  final List<String> shuffledImages;
  final Function(int, String, int) onImagePlaced;

  const TargetImageSlots({
    Key? key,
    required this.placedImages,
    required this.shuffledImages,
    required this.onImagePlaced,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(placedImages.length, (index) {
          return DragTarget<String>(
            builder: (context, candidates, rejects) {
              return Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: candidates.isNotEmpty ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: placedImages[index] != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    placedImages[index]!,
                    fit: BoxFit.cover,
                  ),
                )
                    : null,
              );
            },
            onWillAccept: (data) => true,
            onAccept: (image) {
              final originalIndex = shuffledImages.indexOf(image);
              onImagePlaced(index, image, originalIndex);
            },
          );
        }),
      ),
    );
  }
}
