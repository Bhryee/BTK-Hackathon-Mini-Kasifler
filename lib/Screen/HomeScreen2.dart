import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/Ai/Screen/SmartMessageWidget.dart';
import 'package:untitled1/Ai/config/env_config.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _State();
}

class _State extends State<HomeScreen2> {
  late GenerativeModel _model;
  ChatSession? _chatSession; // Nullable
  final FocusNode _textFieldFocus = FocusNode();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool loading = false;
  bool _isModelInitialized = false; // Model durumu
  bool isLoadingResponse = false; // Yeni değişken

  @override
  void initState() {
    super.initState();
    _requestMicrophonePermission();
    _initializeModel();
  }

  Future<void> _initializeModel() async {
    setState(() {
      loading = true;
    });

    try {
      final String apiKey = await EnvConfig.getApiKey();
      const String modelName = 'tunedModels/gamegemini-nkiv2hbp9y2r';

      _model = GenerativeModel(model: modelName, apiKey: apiKey);
      _chatSession = _model.startChat();
      _speech = stt.SpeechToText();
      setState(() {
        _isModelInitialized = true; // Model yüklendi
      });
    } catch (e) {
      print("Model başlatma hatası: $e");
      _showError(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isModelInitialized) {
      // Model yüklenirken gösterilecek
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatbot"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _chatSession?.history.length ?? 0,
                itemBuilder: (context, index) {
                  final Content content = _chatSession!.history.toList()[index];
                  final text = content.parts
                      .whereType<TextPart>()
                      .map<String>((e) => e.text)
                      .join('');
                  return SmartMessageWidget(
                    text: text,
                    isFromUser: content.role == 'user',
                  );
                },
              ),
            ),
            if (isLoadingResponse) // Loading simgesi
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Center(child: CircularProgressIndicator()), // Loading simgesi
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0CB3EB),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isListening ? Icons.mic : Icons.mic_none_sharp,
                        size: 30.sp,
                      ),
                      onPressed: _listen,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      focusNode: _textFieldFocus,
                      decoration: textFieldDecoration(),
                      controller: _textController,
                      minLines: 1,
                      maxLines: 3,
                      enabled: !isLoadingResponse, // Kullanıcı girişi engelle
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0CB3EB),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.send_rounded,
                        color: Colors.black,
                        size: 30.sp,
                      ),
                      onPressed: isLoadingResponse // Mesaj gönderiminde kontrol
                          ? null // Yanıt beklerken butonu devre dışı bırak
                          : () {
                        if (_textController.text.isNotEmpty) {
                          _sendChatMessage(_textController.text);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration textFieldDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF0CB3EB),
      contentPadding: EdgeInsets.all(15.h),
      hintText: 'Bir mesaj giriniz...',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14.r)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14.r)),
        borderSide: BorderSide(color: const Color(0xFF0CB3EB)),
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    if (_chatSession == null) {
      _showError("Chat oturumu başlatılamadı.");
      return;
    }

    setState(() {
      isLoadingResponse = true; // Loading durumu
    });

    try {
      final response = await _chatSession!.sendMessage(Content.text(message));
      final text = response.text;

      if (text == null) {
        throw Exception("API'den yanıt yok.");
      } else {
        setState(() {
          // Gelen mesajı ekleme işlemi burada yapılabilir
          _scrollDown();
        });
      }
    } catch (e) {
      print("Mesaj gönderme hatası: $e");
      _showError(e.toString());
    } finally {
      _textController.clear();
      setState(() {
        isLoadingResponse = false; // Yanıt geldi, loading kaldırıldı
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeOutCirc,
      );
    });
  }

  void _showError(String message) {
    print(message);
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bir şeyler ters gitti'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            if (val.hasConfidenceRating && val.confidence > 0.5) {
              setState(() {
                _textController.text = val.recognizedWords;
              });
            } else {
              print("Ses tanıma hatası: Ses net değil.");
            }
          },
        );
      } else {
        print("Ses tanıma mevcut değil.");
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
