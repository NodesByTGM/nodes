import 'package:data_table_2/data_table_2.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class SubscriptionTable extends StatefulWidget {
  const SubscriptionTable({super.key});

  @override
  State<SubscriptionTable> createState() => _SubscriptionTableState();
}


// SubscriptionHistoryModel
class _SubscriptionTableState extends State<SubscriptionTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context),
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border.all(width: 0.7, color: BORDER),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        // minWidth: 600,
        minWidth: screenWidth(context),
        columns: [
          DataColumn2(
            label: subtext(
              'PLAN',
              color: GRAY,
              textAlign: TextAlign.center,
            ),
            size: ColumnSize.L,
          ),
          DataColumn(
            label: subtext(
              'BILLING DATE & TIME',
              color: GRAY,
              textAlign: TextAlign.left,
            ),
          ),
          DataColumn(
            label: subtext(
              'AMOUNT',
              color: GRAY,
              textAlign: TextAlign.right,
            ),
            numeric: true,
          ),
          DataColumn(
            label: subtext(
              'STATUS',
              color: GRAY,
              textAlign: TextAlign.center,
            ),
          ),
          // DataColumn(
          //   label: Text('Column NUMBERS'),
          //   numeric: true,
          // ),
        ],
        rows: List<DataRow>.generate(
          5,
          (index) => DataRow(cells: [
            DataCell(
              subtext('Business $index'),
            ),
            DataCell(
              subtext(
                formatDateOnly(DateTime.now()),
              ),
            ),
            DataCell(
              subtext(formatCurrencyAmount(Constants.naira, 7900)),
            ),
            DataCell(
              subtext(
                'Active',
                color: PRIMARY,
              ),
            ),
            // DataCell(Text(((index + 0.1) * 25.4).toString()))
          ]),
        ),
      ),
    );
  }
}
