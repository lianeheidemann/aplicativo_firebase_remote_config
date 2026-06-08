import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _defaultBackgroundColor = '#FFFFFF';
  static const _defaultPropaganda = 'default';

  final _remoteConfig = FirebaseRemoteConfig.instance;

  bool _loading = true;
  String? _error;
  Color _backgroundColor = Colors.white;
  String _propaganda = _defaultPropaganda;

  @override
  void initState() {
    super.initState();
    _loadRemoteConfig();
  }

  Future<void> _loadRemoteConfig() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: Duration.zero,
        ),
      );

      await _remoteConfig.setDefaults({
        'cor_fundo': _defaultBackgroundColor,
        'propaganda': _defaultPropaganda,
      });

      await _remoteConfig.fetchAndActivate();

      setState(() {
        _backgroundColor = _parseColor(_remoteConfig.getString('cor_fundo'));
        _propaganda = _remoteConfig.getString('propaganda');
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Color _parseColor(String hex) {
    final value = hex.replaceAll('#', '').trim();
    if (value.length == 6) {
      return Color(int.parse('FF$value', radix: 16));
    }
    return Colors.white;
  }

  String _propagandaAsset() {
    return switch (_propaganda) {
      'alternativa' => 'assets/images/propaganda_alt.png',
      _ => 'assets/images/propaganda.png',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Remote Config'),
        actions: [
          IconButton(
            onPressed: _loading ? null : _loadRemoteConfig,
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar configurações',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          'Erro ao carregar Remote Config',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _error!,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadRemoteConfig,
                          child: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            _propagandaAsset(),
                            width: 320,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text('Hello World Liane!'),
                        const SizedBox(height: 8),
                
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            final uri = Uri.parse('https://www.google.com');
                            if (!await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            )) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Não foi possível abrir o site.'),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Ir Para o Site!'),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
