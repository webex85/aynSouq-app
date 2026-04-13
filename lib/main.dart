import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lottie/lottie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

const primaryColor = Color(0xFF16B1B0);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

//
// SPLASH SCREEN
//
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WebViewScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage("assets/splash_screen.png"),
          width: 150,
        ),
      ),
    );
  }
}

//
// WEBVIEW SCREEN
//
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;

  bool isOffline = false;
  bool isLoading = true;
  StreamSubscription? sub;

  @override
  void initState() {
    super.initState();
    _initWebView();
    _listenInternet();
  }

  //
  // INIT WEBVIEW
  //
  void _initWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() => isLoading = true);
          },
          onPageFinished: (_) {
            setState(() {
              isLoading = false;
              isOffline = false;
            });
          },
          onWebResourceError: (_) {
            setState(() => isOffline = true);
          },
        ),
      )
      ..loadRequest(Uri.parse("https://aynsouq.com"));
  }

  //
  // INTERNET CHECK
  //
  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  //
  // INTERNET LISTENER
  //
  void _listenInternet() {
    sub = Connectivity().onConnectivityChanged.listen((event) async {
      bool online = await _hasInternet();

      if (!online) {
        setState(() => isOffline = true);
      } else {
        setState(() => isOffline = false);
        controller.reload();
      }
    });
  }

  //
  // BACK BUTTON
  //
  Future<bool> _onBack() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        body: SafeArea(
          child: isOffline
              ? const NoInternetScreen()
              : Stack(
                  children: [
                    WebViewWidget(controller: controller),

                    // 🔝 TOP PROGRESS BAR
                    if (isLoading)
                      const LinearProgressIndicator(
                        minHeight: 3,
                        color: primaryColor,
                        backgroundColor: Colors.transparent,
                      ),

                    // 🔄 RELOAD BUTTON
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: FloatingActionButton(
                        backgroundColor: primaryColor,
                        onPressed: () => controller.reload(),
                        child: const Icon(Icons.refresh, color: Colors.white),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

//
// NO INTERNET SCREEN
//
class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/no-internet.json", height: 200),
            const SizedBox(height: 20),
            const Text(
              "No Internet Connection",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please check your connection.\nRetrying automatically...",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}