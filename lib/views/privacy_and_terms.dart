// ignore: file_names
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  Map terms = {};

  final isLoading=false.obs;

  callTermsAPI() async{
    isLoading(true);
    setState(() {

    });
    http.Response response = await http.get(Uri.parse('https://ndn.manageprojects.in/api/term_condition'));

    if(response.statusCode==200){
      terms = jsonDecode(response.body);

      isLoading(false);
      setState((){

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    callTermsAPI();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
        appBar: AppBar(
          title:  Text("Terms and conditions"),
        ),
        body:

        Container(
          child: Obx(() {
            if (isLoading.value) {
              return Center(child: CupertinoActivityIndicator());
            } else {
              return
                terms.isNotEmpty?
                SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "${terms['data']['content'].toString().replaceAll('<p>', "").replaceAll('<strong>', '').replaceAll('<br />', '').replaceAll('</strong>', '').toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ').renderHtml ?? ''}",
                      ),
                    )):
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[

                    Center(
                      child:  Text(
                        "No data found",
                      ),
                    )


                  ],);

            }
          }),
        )



    );
  }
}

class PoliciesScreen extends StatefulWidget {
  const PoliciesScreen({Key? key}) : super(key: key);

  @override
  State<PoliciesScreen> createState() => _PoliciesScreenState();
}

class _PoliciesScreenState extends State<PoliciesScreen> {
  Map policies = {};

  final isLoading=false.obs;
  /*callTermsAPI() async{
    http.Response response = await http.get(Uri.parse('https://ndn.manageprojects.in/api/privacy_policy'));
    setState((){
      policies = jsonDecode(response.body);
    });

  }*/

  callTermsAPI() async{
    isLoading(true);
    setState(() {

    });
    http.Response response = await http.get(Uri.parse('https://ndn.manageprojects.in/api/privacy_policy'));

    if(response.statusCode==200){
      policies = jsonDecode(response.body);

      isLoading(false);
      setState((){

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    callTermsAPI();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text("Privacy Policy"),
        ),
        body:

        Container(
          child: Obx(() {
            if (isLoading.value) {
              return Center(child: CupertinoActivityIndicator());
            } else {
              return
                policies.isNotEmpty?
                SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "${policies['data']['content'].toString().replaceAll('<p>', "").replaceAll('<strong>', '').replaceAll('<br />', '').replaceAll('</strong>', '').toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ') ?? ''}",
                      ),
                    )):
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[

                        Center(
                          child:  Text(
                            "No data found",
                          ),
                        )


                    ],);

            }
          }),
        )
    );
  }
}
