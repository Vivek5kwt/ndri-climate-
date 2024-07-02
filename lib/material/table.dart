import 'package:flutter/material.dart';

class PerformanceTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(color: Colors.black),
        columnWidths: {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
        },
        children: [
          _buildTableRow('Parameters', 'Quantity', isHeader: true),
          _buildTableRow('Average Birth weight', 'Male calves: 32 kg\nFemale calves: 30 kg'),
          _buildTableRow('Average Body weight of adult animal', 'Male: 567 kg\nFemale: 516 kg'),
          _buildTableRow('Average age of first service', '943.4 days'),
          _buildTableRow('Average age of first calving', '1319 days'),
          _buildTableRow('Total Lactation milk yield (average)', '1752 kg (1003 kg – 2057 kg)'),
          _buildTableRow('Lactation length (average)', '307 days'),
          _buildTableRow('Dry period (average)', '187.6 days'),
          _buildTableRow('On an average milk contains fat', '7.3%'),
          _buildTableRow('Overall Calving interval (average)', '452.9 days'),
          _buildTableRow('Number of service per conception (average)', '1.93'),
          _buildTableRow('Source:', 'National Bureau of Animal Genetics Resource,\nIndian Council of Agricultural Research, Karnal, Haryana', isItalic: true),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String parameter, String quantity, {bool isHeader = false, bool isItalic = false}) {
    return TableRow(
      children: [
        _buildTableCell(parameter, isHeader: isHeader, isItalic: isItalic),
        _buildTableCell(quantity, isHeader: isHeader, isItalic: isItalic),
      ],
    );
  }

  Widget _buildTableCell(String content, {bool isHeader = false, bool isItalic = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          fontSize: 16.0,
        ),
      ),
    );
  }
}