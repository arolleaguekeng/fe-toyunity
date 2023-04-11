import 'package:toyunity/models/chat_model.dart';
import 'package:toyunity/models/user_model.dart';

class ConversationModel {
  final UserModel userModel;
  final List<ChatModel> chatModels;

  ConversationModel({required this.userModel, required this.chatModels});
}
