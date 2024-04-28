import 'package:data_table_2/data_table_2.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/subscription_upgrade_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/subscriptions/models/subscription_history_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';

class SubscriptionTable extends StatefulWidget {
  const SubscriptionTable({
    super.key,
    required this.config,
  });

  final SubscriptionUpgrade config;

  @override
  State<SubscriptionTable> createState() => _SubscriptionTableState();
}

// SubscriptionHistoryModel
class _SubscriptionTableState extends State<SubscriptionTable> {
  late AuthController authCtrl;
  late SubscriptionUpgrade config;
  @override
  void initState() {
    config = widget.config;
    authCtrl = locator.get<AuthController>();
    safeNavigate(() => authCtrl.fetchAllMyTransactions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, aCtrl, _) {
        // Loader here...

        if (aCtrl.isFetchingSubHistory) {
          return const BoxShimmerLoader();
        }

        List<SubscriptionHistoryModel> history = aCtrl.subscriptionHistoryList;
        // Filter the Transactions that matches the config at that moment
        List<SubscriptionHistoryModel> filteredHistory = history
            .where((h) =>
                (h.subscription?.plan == config.type) &&
                (h.subscription?.tenor == config.period))
            .toList();

        return Container(
          height: screenHeight(context),
          width: screenWidth(context),
          padding: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            border: Border.all(width: 0.7, color: BORDER),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            // minWidth: 600,
            minWidth: 500,
            // minWidth: screenWidth(context),
            columns: [
              DataColumn2(
                fixedWidth: 80,
                label: subtext(
                  'PLAN',
                  color: GRAY,
                  textAlign: TextAlign.center,
                ),
                size: ColumnSize.L,
              ),
              DataColumn(
                // fixedWidth: 100,
                label: subtext(
                  // 'BILLING DATE & TIME',
                  'DATE',
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
              filteredHistory.length,
              (index) {
                final SubscriptionHistoryModel item = filteredHistory[index];
                bool isActive =
                    (item.subscription?.active ?? false) ? true : false;
                return DataRow(
                  cells: [
                    DataCell(
                      subtext('${item.subscription?.plan}'),
                    ),
                    DataCell(
                      subtext(
                        formatDateOnly(
                          item.paidAt ?? DateTime.now(),
                        ),
                      ),
                    ),
                    DataCell(
                      subtext(formatCurrencyAmount(
                          Constants.naira, (item.amount ?? 0).toDouble())),
                    ),
                    DataCell(
                      subtext(
                        isActive ? 'Active' : 'Not Active',
                        color: isActive ? PRIMARY : RED,
                      ),
                    ),
                    // DataCell(Text(((index + 0.1) * 25.4).toString()))
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
