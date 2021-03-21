import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/pothole_item.dart';
import '../providers/potholes.dart';

class PotHolesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final potholesData = Provider.of<PotHoles>(context);
    final potholes = potholesData.items;
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: potholesData.items.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: potholes[i],
        child: PotHoleItem(),
      ),
    );
  }
}
