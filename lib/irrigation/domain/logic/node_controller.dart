import '../../infrastructure/models/node_model.dart';
import '../../infrastructure/repositories/node_repository.dart';

class NodeController {
  final NodeRepository _repository = NodeRepository();

  Future<List<NodeModel>> fetchNodesByPlotId(String plotId) async {
    return await _repository.getNodesByPlotId(plotId);
  }

  Future<void> saveNode(NodeModel node) async {
    await _repository.createNode(node);
  }
}
