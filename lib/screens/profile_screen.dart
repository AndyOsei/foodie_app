import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/models/payment_method.dart';
import 'package:foodie_app/models/profile.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/custom_icon.dart';
import 'package:foodie_app/widgets/info_card.dart';
import 'package:foodie_app/widgets/radio_group.dart';
import 'package:foodie_app/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<PaymentMethod> _paymentMethods;
  PaymentMethod _selectedPaymentMethod;
  bool _update = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _profileNameController = TextEditingController();
  TextEditingController _profileEmailController = TextEditingController();
  TextEditingController _profileAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _paymentMethods = defaultPaymentMethods();
    _selectedPaymentMethod = _paymentMethods[0];
  }

  void _goBack() {
    ExtendedNavigator.root.pop(true);
  }

  void _toggleUpdate() {
    setState(() {
      var profile = context.read<Profile>();
      _profileNameController.text = profile.name;
      _profileEmailController.text = profile.email;
      _profileAddressController.text = profile.address;
      _update = !_update;
    });
  }

  void _updateInfo(BuildContext context) {
    if (_update && _formKey.currentState.validate()) {
      var profile = context.read<Profile>();
      profile.updateWith(
        newName: _profileNameController.text != profile.name
            ? _profileNameController.text
            : null,
        newEmail: _profileEmailController.text != profile.email
            ? _profileEmailController.text
            : null,
        newAddress: _profileAddressController.text != profile.address
            ? _profileAddressController.text
            : null,
        newPaymentMethod: _selectedPaymentMethod,
      );
      setState(() {
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
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.SIZE_30,
            vertical: Sizes.SIZE_16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 1),
              Consumer<Profile>(
                builder: (_, profile, child) =>
                    _buildProfileInfo(textTheme, profile),
              ),
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.blue200,
      brightness: Brightness.light,
      leading: IconButton(
        onPressed: _goBack,
        icon: Icon(
          Icons.keyboard_arrow_left,
          color: Colors.black,
        ),
      ),
      title: Text(
        StringConst.MY_PROFILE,
        style: Theme.of(context).textTheme.headline4.copyWith(
              fontFamily: StringConst.SF_PRO_TEXT,
              fontSize: Sizes.TEXT_SIZE_18,
              color: Colors.black,
            ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildProfileName(TextTheme textTheme, Profile profile) {
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
        '${profile.name}',
        style: textTheme.subtitle1.copyWith(
          fontFamily: StringConst.SF_PRO_TEXT,
        ),
      );
    }
  }

  Widget _buildProfileEmail(TextTheme textTheme, Profile profile) {
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
        '${profile.email}',
        style: textTheme.bodyText2.copyWith(
          fontFamily: StringConst.SF_PRO_TEXT,
          fontSize: Sizes.TEXT_SIZE_14,
        ),
      );
    }
  }

  Widget _buildProfileAddress(TextTheme textTheme, Profile profile) {
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
        '${profile.address}',
        style: textTheme.bodyText2.copyWith(
          fontFamily: StringConst.SF_PRO_TEXT,
          fontSize: Sizes.TEXT_SIZE_14,
        ),
      );
    }
  }

  Widget _buildProfileInfo(TextTheme textTheme, Profile profile) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                          _buildProfileName(textTheme, profile),
                          SizedBox(height: Sizes.SIZE_8),
                          _buildProfileEmail(textTheme, profile),
                          SizedBox(height: Sizes.SIZE_8),
                          _buildProfileAddress(textTheme, profile),
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
        ],
      );

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
