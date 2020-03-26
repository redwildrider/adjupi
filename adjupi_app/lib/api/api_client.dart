import 'dart:convert';

import 'package:homepi_client/api/responses.dart';
import 'package:homepi_client/enums.dart';
import 'package:http/http.dart' as http;

const baseLink = 'http://192.168.178.49:5000/homepi/';

class ApiClient {
  Future<ApiResponse> fetchProjectInformation() async {
    final response = await http.get(baseLink);

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load project information. Status code: ${response.statusCode}');
    }
  }

  Future<StandardResponse> setSwitch(SwitchState newState) async {
    final response = await http.get("${baseLink}switch_${operator[newState]}");

    if (response.statusCode == 200) {
      return StandardResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load project information. Status code: ${response.statusCode}');
    }
  }

  Map<SwitchState, String> operator = <SwitchState, String>{
    SwitchState.ON: "on",
    SwitchState.OFF: "off",
  };
}