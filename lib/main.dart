import 'package:flutter/material.dart';
import 'package:razor_pay/razorpay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final RazorpayIntegration _integration = RazorpayIntegration();
  String paymentStatus = "";

  @override
  void initState() {
    super.initState();
    _integration.initiateRazorPay((res) =>
        {print("Response Data : $res"), paymentStatus = res, setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Razorpay"),
      ),
      body: Center(
        child: Text(paymentStatus),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _integration.openSession(amount: 10);
        },
        tooltip: 'Razorpay',
        child: const Icon(Icons.add),
      ),
    );
  }
}
