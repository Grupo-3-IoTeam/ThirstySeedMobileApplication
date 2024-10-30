// lib/catalog/infrastructure/repositories/plot_repository.dart
import '../../domain/entities/plot_entity.dart';
import '../data_sources/plot_data_source.dart';

class PlotRepository {
  final PlotDataSource dataSource;

  PlotRepository(this.dataSource);

  Future<List<Plot>> getPlots() async {
    return await dataSource.fetchPlots();
  }
}
