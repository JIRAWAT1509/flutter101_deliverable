import 'package:flutter/material.dart';
import 'package:covid_form/viewModels/home_view_model.dart';
import 'package:covid_form/views/covid_form_view.dart';
import 'package:covid_form/views/patients_list_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _viewModel.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [const SizedBox(height: 40), ..._buildNavigationCards()],
        ),
      ),
    );
  }

  Widget _getCovidFormScreen() {
    return CovidFormView();
  }

  Widget _getPatientsListScreen() {
    return const PatientsListView();
  }

  Widget _getScreenByRoute(String route) {
    switch (route) {
      case 'covid_form':
        return _getCovidFormScreen();
      case 'patients_list':
        return _getPatientsListScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  List<Widget> _buildNavigationCards() {
    return _viewModel.navigationItems.map((item) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _buildNavigationCard(
          title: item.title,
          icon: item.icon,
          onTap: () => _navigateToScreen(item.route),
        ),
      );
    }).toList();
  }

  void _navigateToScreen(String route) {
    final Widget screen = _getScreenByRoute(route);
    final String title = _viewModel.getTitleByRoute(route);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                Scaffold(appBar: AppBar(title: Text(title)), body: screen),
      ),
    );
  }

  Widget _buildNavigationCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 32),
              const SizedBox(width: 16),
              Text(title, style: const TextStyle(fontSize: 18)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
