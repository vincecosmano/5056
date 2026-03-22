import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/app_theme.dart';
import 'providers/note_provider.dart';
import 'providers/project_provider.dart';
import 'providers/client_provider.dart';
import 'providers/quote_provider.dart';
import 'providers/invoice_provider.dart';
import 'providers/mileage_provider.dart';
import 'providers/worker_hours_provider.dart';
import 'providers/calendar_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/notes_screen.dart';
import 'screens/mileage_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/clients_screen.dart';
import 'screens/worker_hours_screen.dart';
import 'screens/quotes_screen.dart';
import 'screens/invoices_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => QuoteProvider()),
        ChangeNotifierProvider(create: (_) => InvoiceProvider()),
        ChangeNotifierProvider(create: (_) => MileageProvider()),
        ChangeNotifierProvider(create: (_) => WorkerHoursProvider()),
        ChangeNotifierProvider(create: (_) => CalendarProvider()),
      ],
      child: MaterialApp(
        title: 'Oneapptredie',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const HomeScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/notes': (context) => const NotesScreen(),
          '/mileage': (context) => const MileageScreen(),
          '/calendar': (context) => const CalendarScreen(),
          '/projects': (context) => const ProjectsScreen(),
          '/clients': (context) => const ClientsScreen(),
          '/worker_hours': (context) => const WorkerHoursScreen(),
          '/quotes': (context) => const QuotesScreen(),
          '/invoices': (context) => const InvoicesScreen(),
        },
      ),
    );
  }
}
