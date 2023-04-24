import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/voucher_cubit.dart';
import 'package:member_app/presentation/bottom_sheet/voucher_bottom_sheet.dart';
import 'package:member_app/presentation/pages/loading_page.dart';

import '../../business_logic/states/voucher_state.dart';
import '../../data/models/voucher_model.dart';
import '../../presentation/res/strings/values.dart';
import '../res/dimen/dimens.dart';
import '../widgets/voucher_widget.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: spaceXL,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: Text(
          txtYourVoucher,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<VoucherCubit, VoucherState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case VoucherInitial:
              return const SizedBox();
            case VoucherLoading:
              return const LoadingPage();
            case VoucherLoaded:
              state as VoucherLoaded;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getListTicket('Sắp hết hạn', state.getsAboutToExpire()),
                    _getListTicket('Sẵn sàng sử dụng', state.getsAvailable()),
                    _getListTicket('Từ đối tác', state.getsFromPartner()),
                    _getListTicket('Đã sử dụng', state.used),
                    const SizedBox(height: dimLG),
                  ],
                ),
              );
          }
          return const LoadingPage();
        },
      ),
    );
  }

  Widget _getListTicket(String title, List<VoucherModel> vouchers) {
    if (vouchers.isEmpty) {
      return const SizedBox();
    }
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          for (var voucher in vouchers)
            Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                VoucherWidget(
                  voucher: voucher,
                  onClick: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return VoucherBottomSheet(voucher: voucher);
                      },
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
