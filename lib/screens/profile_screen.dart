import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie_app/models/payment_method.dart';
import 'package:foodie_app/models/profile.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/custom_icon.dart';
import 'package:foodie_app/widgets/info_card.dart';
import 'package:foodie_app/widgets/rounded_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile _profile;
  List<PaymentMethod> _paymentMethods;
  PaymentMethod _selectedPaymentMethod;

  @override
  void initState() {
    _profile = Profile(
      name: 'Marvis Ighedosa',
      email: 'dosamarvis@gmail.com',
      address: 'No 15 uti street off ovie palace road effurun delta state',
    );

    _paymentMethods = defaultPaymentMethods();
    _selectedPaymentMethod = _paymentMethods[0];

    super.initState();
  }

  void _goBack() {
    ExtendedNavigator.root.pop();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.blue200,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.SIZE_30,
            vertical: Sizes.SIZE_16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(screenWidth),
              Spacer(flex: 1),
              ..._buildProfileInfo(textTheme),
              Spacer(flex: 1),
              ..._buildPaymentMethodsRadioGroup(textTheme),
              Spacer(flex: 4),
              Align(
                alignment: Alignment.bottomCenter,
                child: RoundedButton(
                  onPressed: () {},
                  width: screenWidth - Sizes.SIZE_150,
                  height: Sizes.SIZE_60,
                  label: StringConst.UPDATE,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeader(double screenWidth) {
    return Row(
      children: [
        IconButton(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(0.0),
          onPressed: _goBack,
          icon: Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        SizedBox(width: screenWidth / 5),
        Text(
          StringConst.MY_PROFILE,
        ),
      ],
    );
  }

  List<Widget> _buildProfileInfo(TextTheme textTheme) => [
        Text(
          StringConst.INFORMATION,
          style: textTheme.subtitle1.copyWith(
            fontFamily: StringConst.SF_PRO_TEXT,
          ),
        ),
        SizedBox(height: Sizes.SIZE_8),
        InfoCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.SIZE_16,
              vertical: Sizes.SIZE_20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ImagePath.PROFILE_PIC,
                ),
                SizedBox(width: Sizes.SIZE_16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_profile.name}',
                        style: textTheme.subtitle1.copyWith(
                          fontFamily: StringConst.SF_PRO_TEXT,
                        ),
                      ),
                      SizedBox(height: Sizes.SIZE_8),
                      Text(
                        '${_profile.email}',
                        style: textTheme.bodyText2.copyWith(
                          fontFamily: StringConst.SF_PRO_TEXT,
                          fontSize: Sizes.TEXT_SIZE_14,
                        ),
                      ),
                      SizedBox(height: Sizes.SIZE_8),
                      Text(
                        '${_profile.address}',
                        style: textTheme.bodyText2.copyWith(
                          fontFamily: StringConst.SF_PRO_TEXT,
                          fontSize: Sizes.TEXT_SIZE_14,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: Sizes.SIZE_8),
                CustomIcon(name: 'edit'),
              ],
            ),
          ),
        )
      ];

  List<Widget> _buildPaymentMethodsRadioGroup(TextTheme textTheme) => [
        Text(
          StringConst.PAYMENT_METHOD,
          style: textTheme.subtitle1.copyWith(
            fontFamily: StringConst.SF_PRO_TEXT,
          ),
        ),
        SizedBox(height: Sizes.SIZE_8),
        InfoCard(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.SIZE_8),
            child: Column(
              children: List.generate(_paymentMethods.length, (int i) {
                return _buildRadioListTile(i);
              }),
            ),
          ),
        )
      ];

  Column _buildRadioListTile(int i) {
    return Column(
      children: [
        RadioListTile<PaymentMethod>(
          onChanged: (value) {},
          groupValue: _selectedPaymentMethod,
          value: _paymentMethods[i],
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(Sizes.SIZE_8),
                decoration: BoxDecoration(
                  color: _paymentMethods[i].color,
                  borderRadius: BorderRadius.circular(
                    Sizes.SIZE_10,
                  ),
                ),
                child: CustomIcon(
                  name: _paymentMethods[i].icon,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: Sizes.SIZE_12),
              Text('${_paymentMethods[i].name}'),
            ],
          ),
        ),
        if (i != _paymentMethods.length - 1)
          Divider(
            color: AppColors.gray200,
            indent: 20,
          ),
      ],
    );
  }
}
