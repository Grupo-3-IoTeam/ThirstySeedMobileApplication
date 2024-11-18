import '../../domain/entities/node_entity.dart';
import '../data_sources/node_data_source.dart';

class PlotRepository {
  final PlotDataSource dataSource;

  PlotRepository(this.dataSource);

  Future<List<Node>> getNodes() async {
    return await dataSource.fetchNodes();

  }

  Future<Node> addNode(Node node) async {
    return await dataSource.createNode(node);
  }


}
