import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie_app/models/payment_method.dart';
import 'package:foodie_app/models/profile.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/custom_icon.dart';
import 'package:foodie_app/widgets/info_card.dart';
import 'package:foodie_app/widgets/radio_group.dart';
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
  bool _update = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _profileNameController = TextEditingController();
  TextEditingController _profileEmailController = TextEditingController();
  TextEditingController _profileAddressController = TextEditingController();

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

  void _toggleUpdate() {
    setState(() {
      _update = !_update;
      _profileNameController.text = _profile.name;
      _profileEmailController.text = _profile.email;
      _profileAddressController.text = _profile.address;
    });
  }

  void _updateInfo(BuildContext context) {
    if (_update && _formKey.currentState.validate()) {
      setState(() {
        _profile = Profile(
          name: _profileNameController.text,
          email: _profileEmailController.text,
          address: _profileAddressController.text,
          paymentMethod: _selectedPaymentMethod,
        );
        _update = false;
      });
    }
  }

  String _validate(String value) {
    if (value.isEmpty) {
      return 'required';
    }
    return null;
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
                  onPressed: () {
                    _updateInfo(context);
                  },
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

  Widget _buildProfileName(TextTheme textTheme) {
    if (_update) {
      return Container(
        height: Sizes.SIZE_30,
        padding: const EdgeInsets.only(
          right: Sizes.SIZE_30,
          bottom: Sizes.SIZE_10,
        ),
        child: TextFormField(
          controller: _profileNameController,
          validator: _validate,
          decoration: InputDecoration(
            isDense: true,
          ),
        ),
      );
    } else {
      return Text(
        '${_profile.name}',
        style: textTheme.subtitle1.copyWith(
          fontFamily: StringConst.SF_PRO_TEXT,
        ),
      );
    }
  }

  Widget _buildProfileEmail(TextTheme textTheme) {
    if (_update) {
      return Container(
        height: Sizes.SIZE_30,
        padding: const EdgeInsets.only(
          right: Sizes.SIZE_30,
          bottom: Sizes.SIZE_10,
        ),
        child: TextFormField(
          controller: _profileEmailController,
          validator: _validate,
          decoration: InputDecoration(
            isDense: true,
          ),
        ),
      );
    } else {
      return Text(
        '${_profile.email}',
        style: textTheme.bodyText2.copyWith(
          fontFamily: StringConst.SF_PRO_TEXT,
          fontSize: Sizes.TEXT_SIZE_14,
        ),
      );
    }
  }

  Widget _buildProfileAddress(TextTheme textTheme) {
    if (_update) {
      return Container(
        padding: const EdgeInsets.only(
          right: Sizes.SIZE_30,
          bottom: Sizes.SIZE_10,
        ),
        child: TextFormField(
          controller: _profileAddressController,
          maxLines: null,
          validator: _validate,
          decoration: InputDecoration(
            isDense: true,
          ),
        ),
      );
    } else {
      return Text(
        '${_profile.address}',
        style: textTheme.bodyText2.copyWith(
          fontFamily: StringConst.SF_PRO_TEXT,
          fontSize: Sizes.TEXT_SIZE_14,
        ),
      );
    }
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileName(textTheme),
                        SizedBox(height: Sizes.SIZE_8),
                        _buildProfileEmail(textTheme),
                        SizedBox(height: Sizes.SIZE_8),
                        _buildProfileAddress(textTheme),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Sizes.SIZE_8),
                GestureDetector(
                  onTap: _toggleUpdate,
                  child: CustomIcon(name: 'edit'),
                ),
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
        RadioGroup(
          children: [
            for (PaymentMethod paymentMethod in _paymentMethods)
              RadioListTile<PaymentMethod>(
                onChanged: _onRadioListChanged,
                groupValue: _selectedPaymentMethod,
                activeColor: paymentMethod.color,
                value: paymentMethod,
                title: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Sizes.SIZE_10),
                      decoration: BoxDecoration(
                        color: paymentMethod.color,
                        borderRadius: BorderRadius.circular(
                          Sizes.SIZE_10,
                        ),
                      ),
                      child: CustomIcon(
                        name: paymentMethod.icon,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: Sizes.SIZE_12),
                    Text(
                      '${paymentMethod.name}',
                      style: textTheme.bodyText2.copyWith(
                        fontFamily: StringConst.SF_PRO_TEXT,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ];

  void _onRadioListChanged(PaymentMethod value) {
    setState(() {
      _selectedPaymentMethod = value;
    });
  }

  @override
  dispose() {
    _profileNameController.dispose();
    _profileEmailController.dispose();
    _profileAddressController.dispose();
    super.dispose();
  }
}
