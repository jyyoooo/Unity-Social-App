import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:unitysocial/core/widgets/custom_button.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';

class RecruitPage extends StatelessWidget {
  const RecruitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: UnityAppBar(
            title: 'Recruit',
          )),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height / 10),
              const Text('Start your own recruitment',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
              SizedBox(height: size.height / 30),
              const Text(
                  textAlign: TextAlign.center,
                  'Create post for your own recruitment and build a community together for a shared social cause',
                  style: TextStyle(
                    fontSize: 15,
                  )),
              Center(
                child: SizedBox(
                    height: 270,
                    width: 300,
                    child: Lottie.network(
                        'https://lottie.host/b4fe37da-eff3-4d41-97aa-643be528ef0a/jxEih32wVl.json')),
              ),
              CustomButton(
                  label: 'Create post',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/recruitForm');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
