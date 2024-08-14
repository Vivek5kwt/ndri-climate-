import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MilkYieldTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children: [
        _buildTableRow(['Ration ingredient'.tr, 'Milk Yield'.tr, ''], isHeader: true),
        _buildTableRow(['', '10' +'Kg'.tr, '15' +'Kg'.tr], isHeader: true),
        _buildTableRow(['Green Fodder (Maize/Jowar)'.tr, '20-25' +'Kg'.tr, '25-30' +'Kg'.tr]),
        _buildTableRow(['Dry fodder (straw/Maize Stover)'.tr, '3-4' +'Kg'.tr, '3-5' +'Kg'.tr]),
        _buildTableRow(['Grain (Maize/Jowar)'.tr, '-', '1-2' +'Kg'.tr]),
        _buildTableRow(['Concentrate mixture*'.tr, '5' +'Kg'.tr, '5-7' +'Kg'.tr]),
      ],
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells.map((cell) {
        return Container(
          padding: EdgeInsets.all(8.0),
          color: isHeader ? Colors.grey[300] : Colors.white,
          child: Text(
            cell,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class FormulationTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(),
        defaultColumnWidth: FixedColumnWidth(120.0),
        children: [
          _buildTableRow(['Ingredients'.tr, 'Formulation'.tr+' I', 'Formulation'.tr +' II', 'Formulation'.tr +' III'], isHeader: true),
          _buildTableRow(['Maize/Jowar/ wheat/ rice/oats admixture'.tr, '30' +'Kg'.tr, '20', '20']),
          _buildTableRow(['Jowar'.tr, '-', '8', '5']),
          _buildTableRow(['Rice bran (deoiled)'.tr, '10' +'Kg'.tr, '18', '17']),
          _buildTableRow(['Wheat bran (deoiled)'.tr, '20' +'Kg'.tr, '19', '13']),
          _buildTableRow(['Groundnut cake'.tr, '10'.tr +'Kg'.tr, '5', '8']),
          _buildTableRow(['Soyabean cake'.tr, '-', '7', '10']),
          _buildTableRow(['Mustard cake'.tr, '10' +'Kg'.tr, '-', '-']),
          _buildTableRow(['Cotton seed cake (decorticated)'.tr, '17' +'Kg'.tr, '20', '-']),
          _buildTableRow(['Cotton seed cake (undecorticated)'.tr, '-', '-', '24']),
          _buildTableRow(['Mineral mixture'.tr, '2' +'Kg'.tr, '2', '2']),
          _buildTableRow(['Salt'.tr, '1' +'Kg'.tr, '1', '1']),
          _buildTableRow(['Total'.tr, '100' +'Kg'.tr, '100' +'Kg'.tr, '100' +'Kg'.tr], isTotal: true),
        ],
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false, bool isTotal = false}) {
    return TableRow(
      children: cells.map((cell) {
        return Container(
          padding: EdgeInsets.all(8.0),
          color: isHeader ? Colors.grey[300] : Colors.white,
          child: Text(
            cell,
            style: TextStyle(
              fontWeight: (isHeader || isTotal) ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }
}