
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants/api_service.dart';
import '../global_widgets/snackbar.dart';

class case_free_payment extends StatefulWidget {
  String? orderId;
  String? orderAmount;
   case_free_payment({Key? key,this.orderId,this.orderAmount}) : super(key: key);

  @override
  State<case_free_payment> createState() => _case_free_paymentState();
}

class _case_free_paymentState extends State<case_free_payment> {
  var cfPaymentGatewayService = CFPaymentGatewayService();

  final isLoading=false.obs;



  @override
  void initState() {
   // order_token_api();
    super.initState();
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(onPressed: pay, child: const Text("Pay"))
            ],
          ),
        ),
      );
  }

  void verifyPayment(String orderId) {
    print("Verify Payment");
  }

  void onError(CFErrorResponse errorResponse, String orderId) {
    print(errorResponse.getMessage());
    print("Error while making payment");
  }

  String orderId = "order_18482IzymCBP2vZynruMNTgLzV9ViPn";
  String paymentSessionId = "session_K7X87C6eg18-s-FPW7FVgALeP8DmCNysDVtMMhk7mhIndk-tLQ-aPcSLZ7acE0r_BznwDIQkEDDPmEqmjkU_Jl7AZxZa5GcnmQyi9CClQenf";
  CFEnvironment environment = CFEnvironment.PRODUCTION;

  CFSession? createSession() {
    try {
      var session = CFSessionBuilder().setEnvironment(environment).setOrderId(orderId).setPaymentSessionId(paymentSessionId).build();
      return session;
    } on CFException catch (e) {
      print(e.message);
    }
    return null;
  }

  pay() async {
    try {
      var session = createSession();
      List<CFPaymentModes> components = <CFPaymentModes>[];
      var paymentComponent = CFPaymentComponentBuilder().setComponents(components).build();

      var theme = CFThemeBuilder().setNavigationBarBackgroundColorColor("#FF0000").setPrimaryFont("Menlo").setSecondaryFont("Futura").build();

      var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder().setSession(session!).setPaymentComponent(paymentComponent).setTheme(theme).build();

      cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
    } on CFException catch (e) {
      print(e.message);
    }

  }
}
