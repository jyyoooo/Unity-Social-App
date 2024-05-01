import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/donation/data/models/donation_model.dart';
import 'package:unitysocial/features/donation/screens/widgets/donation_repository.dart';
import 'package:unitysocial/features/your_projects/screens/widgets/donut_chart_widget.dart';

class YourStats extends StatelessWidget {
  YourStats({Key? key}) : super(key: key);

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    List<Donation> allDonations = [];
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _appbar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 75.0, left: 20, right: 20),
            sliver: SliverToBoxAdapter(
              child: FutureBuilder(
                future: DonationRepository().fetchUserDonations(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.hasError) {
                    return const Text('Error fetching your donations');
                  } else if (snapshot.hasData) {
                    allDonations = snapshot.data!;
                    return snapshot.data!.isEmpty
                        ? const Center(
                            child: Text(
                              'You have not donated to any cause yet',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              _showTotalDonations(snapshot),
                              const SizedBox(height: 15),
                              showDonationChart(size, snapshot),
                              const SizedBox(height: 15),
                              listUserDonations(allDonations),
                            ],
                          );
                  }
                  return const Text('Something went wrong');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // refactored widgets

  Column showDonationChart(Size size, AsyncSnapshot<List<Donation>> snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Contribution Chart', style: TextStyle(color: Colors.grey)),
        DonutChart(size: size, allUserDonations: snapshot.data),
      ],
    );
  }

  Widget listUserDonations(List<Donation> allDonations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('All Donations', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sent to',
                  style: TextStyle(color: CupertinoColors.activeBlue)),
              Text('Amount',
                  style: TextStyle(color: CupertinoColors.activeBlue))
            ],
          ),
        ),
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: allDonations.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: ListTile(
              tileColor: CupertinoColors.systemGrey6,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(allDonations[index].donatedTo),
              ),
              trailing: Text(
                '₹${allDonations[index].amount}',
                style: const TextStyle(
                    fontSize: 15, color: CupertinoColors.systemGreen),
              ),
            ),
          ),
        ),
      ],
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
