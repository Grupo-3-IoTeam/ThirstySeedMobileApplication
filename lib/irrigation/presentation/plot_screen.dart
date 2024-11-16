import 'package:flutter/material.dart';
import '../domain/logic/plot_controller.dart';
import '../infrastructure/models/plot_model.dart';

class PlotScreen extends StatefulWidget {
  final PlotController controller;

  const PlotScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _PlotScreenState createState() => _PlotScreenState();
}

class _PlotScreenState extends State<PlotScreen> {
  String _searchText = '';

  Future<List<PlotModel>> _filteredPlots() async {
    final plots = await widget.controller.fetchPlots();
    return plots.where((plot) {
      return plot.name.toLowerCase().contains(_searchText) ||
          plot.location.toLowerCase().contains(_searchText);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registered Plots'),
        centerTitle: true,
        backgroundColor: Colors.green[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                setState(() {
                  _searchText = text.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<PlotModel>>(
                future: _filteredPlots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No plots found.'));
                  }

                  final plots = snapshot.data!;
                  return ListView.builder(
                    itemCount: plots.length,
                    itemBuilder: (context, index) {
                      final plot = plots[index];
                      return ListTile(
                        leading: Image.network(plot.imageUrl),
                        title: Text(plot.name),
                        subtitle: Text('Location: ${plot.location}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
