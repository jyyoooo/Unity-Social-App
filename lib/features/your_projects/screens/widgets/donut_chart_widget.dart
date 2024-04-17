import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';
import 'package:unitysocial/features/donation/data/models/donation_model.dart';

class DonutChart extends StatelessWidget {
  const DonutChart({
    super.key,
    required this.size,
    required this.allUserDonations,
  });

  final Size size;
  final List<Donation>? allUserDonations;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(30),
        height: size.height / 3,
        width: size.width,
        child: SfCircularChart(
          borderColor: Colors.white,
          // legend: const Legend(isVisible: true),
          series: <CircularSeries>[
            DoughnutSeries<Donation, String>(
              legendIconType: LegendIconType.horizontalLine,
              innerRadius: '45%',
              selectionBehavior:
                  SelectionBehavior(selectedColor: CupertinoColors.activeBlue),
              animationDuration: 550,
              dataSource: allUserDonations,
              explode: true,
              pointColorMapper: (datum, index) {
                return buttonGreen;
              },
              enableTooltip: true,
              strokeColor: CupertinoColors.white,
              xValueMapper: (Donation data, _) => data.donatedTo,
              yValueMapper: (Donation data, _) => data.amount,
              dataLabelMapper: (Donation data, _) => '${data.amount}',
              dataLabelSettings: const DataLabelSettings(
                  useSeriesColor: false, isVisible: true),
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
