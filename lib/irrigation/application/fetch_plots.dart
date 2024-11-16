import '../domain/entities/plot_entity.dart';
import '../infrastructure/models/plot_model.dart';
import '../infrastructure/repositories/plot_repository.dart';
import 'dart:collection';

class FetchPlots {
  final PlotRepository repository;

  FetchPlots(this.repository);

  Future<UnmodifiableListView<Plot>> call() async {
    final plotModels = await repository.getAllPlots();
    // Convertir PlotModel a Plot
    final plots = plotModels.map((model) => model.toEntity()).toList();
    return UnmodifiableListView(plots);
  }
}

// Extensión para convertir PlotModel a Plot
extension PlotModelExtension on PlotModel {
  Plot toEntity() {
    return Plot(
      id: int.parse(id), // Convertir a entero si id es un String
      name: name,
      extension: extension.toInt(), // Asegurar que extension sea un int
      imageUrl: imageUrl,
      location: location,
      status: "Unknown", // Valor predeterminado
      size: 0, // Valor predeterminado o ajustar
      installedNodes: 0, // Valor predeterminado
      lastIrrigationDate: "Unknown", // Valor predeterminado
      nodes: [], // Lista vacía como valor predeterminado
    );
  }
}
