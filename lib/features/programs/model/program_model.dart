import 'package:gym/utils/helpers/api/api_constants.dart';

import 'category_model.dart';

class ProgramModel {
  final int id;
  final String name;
  final String file;
  final String imageUrl;
  final String type;
  final int coachId;

  ProgramModel({
    required this.id,
    required this.name,
    required this.file,
    required this.imageUrl,
    required this.type,
    required this.coachId,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      file: json['file'] ?? '',
      imageUrl: '${ApiConstants.imageUrl}${json['imageUrl']}' ?? '',
      type: json['type'] ?? '',
      coachId: json['user_id'] ?? 0,
    );
  }
}

