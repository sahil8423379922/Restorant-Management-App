import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/widgets/commonshadowcontainer.dart';

class LoyaltyProgram extends StatelessWidget {
  const LoyaltyProgram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
          foregroundColor: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlack,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Loyalty Program',
            style: FontStyleUtilities.h4(
                context: context,
                fontColor: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlack,
                fontWeight: FWT.medium),
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SpaceUtils.ks20.height(),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: loyaltyModels.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomerOfferTile(
                  tittle: loyaltyModels[index].tittle,
                  sub: loyaltyModels[index].subTitle,
                  value: (bool value) {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerOfferTile extends StatefulWidget {
  const CustomerOfferTile({
    Key? key,
    required this.value,
    required this.tittle,
    required this.sub,
  }) : super(key: key);
  final ValueChanged<bool> value;
  final String tittle, sub;

  @override
  State<CustomerOfferTile> createState() => _CustomerOfferTileState();
}

class _CustomerOfferTileState extends State<CustomerOfferTile> {
  bool isActivate = false;

  @override
  Widget build(BuildContext context) {
    return CommonShadowContainer(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 18),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.tittle,
                      style: FontStyleUtilities.t1(
                          context: context, fontWeight: FWT.medium)),
                  const SizedBox(height: 4),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 30,
                child: TextButton(
                    key: const ValueKey('TextButtonKey'),
                    onPressed: () {
                      isActivate = !isActivate;
                      widget.value(isActivate);
                      setState(() {});
                    },
                    child: isActivate
                        ? Text(
                            'Deactivate',
                            key: const ValueKey('Deactivate'),
                            style: FontStyleUtilities.t2(
                                context: context,
                                fontWeight: FWT.semiBold,
                                fontColor: ColorUtils.kcPrimary),
                          )
                        : Text(
                            'Activate',
                            key: const ValueKey('Activate'),
                            style: FontStyleUtilities.t2(
                                context: context,
                                fontWeight: FWT.semiBold,
                                fontColor: ColorUtils.kcPrimary),
                          )),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 80),
            child: Text(widget.sub,
                style: FontStyleUtilities.t4(
                    context: context, fontWeight: FWT.medium)),
          ),
        ],
      ),
    );
  }
}

List<LoyaltyModel> loyaltyModels = [
  LoyaltyModel(
      subTitle: 'Flat \$50 off on your first order. Min Order \$300',
      tittle: '\$50 off on first order'),
  LoyaltyModel(
      subTitle: 'You can earn \$50 on each referral by using your code.',
      tittle: '\$50 off on each referral'),
  LoyaltyModel(
      subTitle: '10% of your bill can be used in your next order.',
      tittle: '10% of order earned'),
  LoyaltyModel(
      subTitle:
          '\$10 will be credited in your loyalty programme if user give feedbacks.',
      tittle: '\$10 discount if give feedback'),
  LoyaltyModel(
      subTitle: 'Flat \$50 off on your first order. Min Order \$300',
      tittle: '\$50 off on first order'),
  LoyaltyModel(
      subTitle: 'You can earn \$50 on each referral by using your code.',
      tittle: '\$50 off on each referral'),
  LoyaltyModel(
      subTitle: '10% of your bill can be used in your next order.',
      tittle: '10% of order earned'),
  LoyaltyModel(
      subTitle:
          '\$10 will be credited in your loyalty programme if user give feedbacks.',
      tittle: '\$10 discount if give feedback'),
  LoyaltyModel(
      subTitle: 'Flat \$50 off on your first order. Min Order \$300',
      tittle: '\$50 off on first order'),
  LoyaltyModel(
      subTitle: 'You can earn \$50 on each referral by using your code.',
      tittle: '\$50 off on each referral'),
  LoyaltyModel(
      subTitle: '10% of your bill can be used in your next order.',
      tittle: '10% of order earned'),
  LoyaltyModel(
      subTitle:
          '\$10 will be credited in your loyalty programme if user give feedbacks.',
      tittle: '\$10 discount if give feedback'),
];

class LoyaltyModel {
  LoyaltyModel({required this.subTitle, required this.tittle});
  final String tittle;
  final String subTitle;
}
