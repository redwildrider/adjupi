import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homepi_client/api/api_client.dart';
import 'package:homepi_client/api/responses.dart';
import 'package:homepi_client/common_elements/buttons.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}
class DashboardState extends State<Dashboard> {
  Future<ApiResponse> futureResponse;
  ApiClient apiClient;

  DashboardState() {
    apiClient = ApiClient();
  }

  @override
  void initState() {
    super.initState();
    futureResponse = apiClient.fetchProjectInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Homepi Client"),
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder<ApiResponse>(
            future: futureResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.serialize());
              }
              else if(snapshot.hasError){
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
          Divider(
            height: 300,
          ),
          OnOffSwitch(
            onSwitchPressed: this.apiClient.setSwitch,
          ),
        ],
      ),
    );
  }
}