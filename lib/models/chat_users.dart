class ChatUsers
{
  String? email;
  String? name;
  String? phone;
  String? uId;
  ChatUsers({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
  });
  ChatUsers.fromJson(Map<String,dynamic>json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId':uId,
    };
  }
}