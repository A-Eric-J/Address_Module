import 'package:address_module/ui/views/address/address_screen.dart';
import 'package:flutter/material.dart';

/// We have just [AddressScreen] in [MainView]
class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: AddressScreen(),
      ),
    );
  }
}
