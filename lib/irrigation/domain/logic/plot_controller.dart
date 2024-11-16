import '../../infrastructure/models/plot_model.dart';
import '../../infrastructure/repositories/plot_repository.dart';

class PlotController {
  final PlotRepository _repository;

  PlotController(this._repository);

  Future<List<PlotModel>> fetchPlots() async {
    try {
      return await _repository.getAllPlots();
    } catch (e) {
      throw Exception('Error fetching plots: $e');
    }
  }

  Future<void> savePlot(PlotModel plot) async {
    try {
      await _repository.createPlot(plot);
    } catch (e) {
      throw Exception('Error saving plot: $e');
    }
  }
}
