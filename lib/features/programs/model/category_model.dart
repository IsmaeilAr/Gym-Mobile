import 'package:gym/utils/helpers/api/api_constants.dart';

import '../../../utils/helpers/api/api_helper.dart';

class TrainingCategoryModel {
  final int id;
  final String name;
  final String imageUrl;
  final String type;

  TrainingCategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
  });

  factory TrainingCategoryModel.fromJson(Map<String, dynamic> json) {
    return TrainingCategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: "${ApiConstants.imageUrl}${json['imageUrl']}" ?? '',
      type: json['type'] ?? '',
    );
  }
}
