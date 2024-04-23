import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/donation/data/models/donation_model.dart';
import 'package:unitysocial/features/donation/screens/widgets/donation_repository.dart';
import 'package:unitysocial/features/your_projects/screens/widgets/donut_chart_widget.dart';

class YourStats extends StatelessWidget {
  YourStats({super.key});

  final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          child: FutureBuilder(
            future: DonationRepository().fetchUserDonations(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CupertinoActivityIndicator());
              } else if (snapshot.hasError) {
                return const Text('Error fetching your donations');
              } else if (snapshot.hasData) {
                return snapshot.data!.isEmpty
                    ? const Center(
                        child: Text('You have not donated to any cause yet',
                            style: TextStyle(color: Colors.grey)),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _showTotalDonations(snapshot),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('All Donations',
                                  style: TextStyle(color: Colors.grey)),
                              DonutChart(
                                  size: size, allUserDonations: snapshot.data),
                            ],
                          )
                        ],
                      );
              }
              return const Text('Something went wrong');
            },
          ),
        ),
      ),
    );
  }

  PreferredSize _appbar() {
    return const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: UnityAppBar(
          title: 'Your Contributions',
          showBackBtn: true,
        ));
  }

  Widget _showTotalDonations(AsyncSnapshot<List<Donation>> snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total Donations',
          style: TextStyle(color: Colors.grey),
        ),
        Text(
            '₹${snapshot.data!.map((e) => e.amount).fold(0, (a, b) => a + b.toInt()).toString()}',
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
