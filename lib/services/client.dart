import 'dart:convert';
import 'package:esyryt_final_app/animated_starting/onboarding_screen.dart';
import 'package:esyryt_final_app/homePage.dart';
import 'package:esyryt_final_app/todoScreens/categoryDropDown.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthClient with ChangeNotifier {
  String selectedDate = '';
  String priority = '';
  String today = '';
  bool dropDownOpened = false;
  //  OverlayEntry floatingDropdown=false;
  // final GlobalKey<NavigatorState> navigatorKey;

  // AuthClient(this.navigatorKey);
  late BuildContext context;

  bool isReminderDropdownOpened = false;
  bool isCategoryDropdownOpened = false;

  String categoryTextSelected = 'default';
  void updateCategory(String newValue) {
    categoryTextSelected = newValue;
    print("categoryTextSelected from menu is  $categoryTextSelected");
    notifyListeners();
  }
// hererererre
  void dropDownCheck(bool newValue) {
    dropDownOpened = newValue;
    print("updated dropdown");
    print(dropDownOpened);
    notifyListeners();
  }

  
  bool dropDowncategoryOpened = false; // true or false
  void dropDownCategoryCheck(bool newValue) {
    dropDowncategoryOpened = newValue;
    print("updated category dropdown");
    print(dropDowncategoryOpened);
    notifyListeners();
  }

  var dropDateCheck = false;
  void dropcheck(bool newValue) {
    dropDateCheck = newValue;
    print("drop Date dropdown");
    print(dropDownDateOpened);
    notifyListeners();
  }

  bool dropDownDateOpened = false; // true or false
  void dropDownDateCheck(bool newValue) {
    dropDownDateOpened = newValue;
    print("updated Date dropdown");
    print(dropDownDateOpened);
    notifyListeners();
  }

  bool dropDownPriorityOpened = false;
  void dropDownPriorityCheck(bool newValue) {
    dropDownPriorityOpened = newValue;
    print("updated priority dropdown");
    print(dropDownPriorityOpened);
    notifyListeners();
  }

  bool dropDownReminderOpened = false;
  void dropDownReminderCheck(bool newValue) {
    dropDownReminderOpened = newValue;
    print("updated Reminder dropdown");
    print(dropDownReminderOpened);
    notifyListeners();
  }

  void updateDate(String newValue, String today) {
    selectedDate = newValue;
    today = today;
    // print("done");
    notifyListeners();
  }

  void updatePriority(String newValue) {
    priority = newValue;
    notifyListeners();
  }

  var client = http.Client();
  var baseUrl = 'https://notesapp-i6yf.onrender.com';

  //post for register
  Future<dynamic> postRegister(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _data = json.encode(object);

    var _header = {
      'Content-Type': 'application/json',
    };
    var response = await client.post(url, body: _data, headers: _header);
    print("Register response ${response.body}");
    // var hey = jsonDecode(response.body);
    // print("helllo hiii $hey");
    // messageEmail = hey["Message"]["email"];
    // print(messageEmail);

    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   return response;
    // } else {
    //   //throw exception
    //   // Exception('cannot connect to it ');
    // }
    return response.body;
  }

  //post for login

  Future<dynamic> postLogin(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _data = json.encode(object);
    print("checking data is present or not $_data");
    var _header = {
      'Content-Type': 'application/json',
    };
    var response = await client.post(url, body: _data, headers: _header);
    print(response.statusCode);

    notifyListeners();
    return response.body;
  }

  //post for UserTodocategory
  Future<dynamic> createTodoCategorypost(
      String api, dynamic object, String token) async {
    var url = Uri.parse(baseUrl + api);
    var _data = json.encode(object);

    var _header = {
      'x-auth-token': token,
      'Content-Type': 'application/json',
    };
    var response = await client.post(url, body: _data, headers: _header);
    print("todocategory response ${response.body}");

    return response.body;
  }

  // get method
  Future<dynamic> getProfile(String api, String token) async {
    var url = Uri.parse(baseUrl + api);

    var _header = {'x-auth-token': token};
    var response = await client.get(url, headers: _header);

    print("get profile response ${response.body}");
    // var value = jsonDecode(response.body);
    // var dataResponse = value;
    // print("picvalues");
    // print(dataResponse);
    // var status = dataResponse["message"];
    // var profilepic = dataResponse["data"]["profilePic"]["filename"];
    // var profilepicUrl = dataResponse["data"]["profilePic"]["url"];
    // // var status = dataResponse["message"];
    // print(status);
    // print(profilepic);
    // print(profilepicUrl);

    return response.body;
  }

  Future<dynamic> getAllCategory(String api, String token) async {
    var url = Uri.parse(baseUrl + api);

    var _header = {'x-auth-token': token};
    var response = await client.get(url, headers: _header);

    print("get all category response ${response.body}");
    var value = jsonDecode(response.body);
    var dataResponse = value;
    print("picvalues");
    print(dataResponse);
    var category = dataResponse["data"][0]["category"];
    // var profilepic = dataResponse["data"]["profilePic"]["filename"];
    // var profilepicUrl = dataResponse["data"]["profilePic"]["url"];
    // // var status = dataResponse["message"];
    // print(status);
    print(category);
    // print(profilepicUrl);

    return response.body;
  }

  //put for updateProfile
  // Future<dynamic> updateProfile(
  //     String api, dynamic object, String token) async {
  //   var url = Uri.parse(baseUrl + api);
  //   var _data = json.encode(object);

  //   var _header = {
  //     'x-auth-token': token,
  //     'Content-Type': 'application/json',
  //   };
  //   var response = await client.put(url, body: _data, headers: _header);
  //   print("todocategory response ${response.body}");

  //   return response.body;
  // }

//post for TodoTaskPost

  Future<dynamic> TodoTaskPost(String api, dynamic object, String token) async {
    var url = Uri.parse(baseUrl + api);
    var _data = json.encode(object);
    print("checking data is present or not $_data");
    var _header = {
      'x-auth-token': token,
      'Content-Type': 'application/json',
    };
    var response = await client.post(url, body: _data, headers: _header);
    print(response.statusCode);

    return response.body;
  }

//put for DeleteCategory
  Future<dynamic> DeletesingleCategory(String api, String token) async {
    var url = Uri.parse(baseUrl + api);

    var _header = {'x-auth-token': token};
    var response = await client.put(url, headers: _header);

    print(" DeletesingleCategory response ${response.body}");

    return response.body;
  }

  Future<dynamic> getFilteredTodo(String api, String token) async {
    var url = Uri.parse(baseUrl + api);

    var _header = {'x-auth-token': token};
    var response = await client.get(url, headers: _header);

    print("get profile response ${response.body}");
    // var value = jsonDecode(response.body);
    // var dataResponse = value;
    // print("picvalues");
    // print(dataResponse);
    // var status = dataResponse["message"];

    return response.body;
  }

  Future<dynamic> getSingleTask(String api, String token) async {
    var url = Uri.parse(baseUrl + api);

    var _header = {'x-auth-token': token};
    var response = await client.get(url, headers: _header);

    print("get profile response ${response.body}");
    // var value = jsonDecode(response.body);
    // var dataResponse = value;
    // print(dataResponse);
    // var status = dataResponse["message"];

    return response.body;
  }

  Future<dynamic> DeleteSingleTask(String api, String token) async {
    var url = Uri.parse(baseUrl + api);

    var _header = {'x-auth-token': token};
    var response = await client.put(url, headers: _header);

    print("get profile response ${response.body}");
    // var value = jsonDecode(response.body);
    // var dataResponse = value;
    // print(dataResponse);
    // var status = dataResponse["message"];

    return response.body;
  }

//verify user
  // Future<dynamic> postVerifyUser(String api, VerifyUser object) async {
  //   // print(object.userId);
  //   // print(object);

  //   var url = Uri.parse(baseUrl + api);
  //   var _data = json.encode(object);
  //   var _header = {
  //     'Content-Type': 'application/json',
  //   };
  //   var response = await client.post(url, body: _data, headers: _header);

  //   return response.body;
  // }

  // resend code

  Future<dynamic> postResendCode(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _data = json.encode(object);
    var _header = {
      'Content-Type': 'application/json',
    };
    var response = await client.post(url, body: _data, headers: _header);
    return response.body;
  }

  // update password
  Future<dynamic> postUpdatePassword(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _data = json.encode(object);
    var _header = {
      'Content-Type': 'application/json',
    };
    var response = await client.post(url, body: _data, headers: _header);
    return response.body;
  }

  //serach user
  Future<dynamic> postSearchUser(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _data = json.encode(object);
    var _header = {
      'Content-Type': 'application/json',
    };
    var response = await client.post(url, body: _data, headers: _header);
    return response.body;
  }

  // logout
  Future<dynamic> logoutUser(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _data = json.encode(object);
    var _header = {
      'Content-Type': 'application/json',
    };
    var response = await client.post(url, body: _data, headers: _header);

    notifyListeners();
    return response.body;
  }
}
