import 'package:scholar_chat/shared/components/constant.dart';

class MessagesModel
{
   final String message;
   final String id;


  factory MessagesModel.fromJson(jsonData)
  {
    return MessagesModel(jsonData[kMessage],jsonData['id']);
  }

  MessagesModel(this.message, this.id,);
}
