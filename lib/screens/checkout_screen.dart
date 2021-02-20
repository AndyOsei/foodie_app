import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/models/cart.dart';
import 'package:foodie_app/models/dish.dart';
import 'package:foodie_app/models/order.dart';
import 'package:foodie_app/models/profile.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/info_card.dart';
import 'package:foodie_app/widgets/radio_group.dart';
import 'package:foodie_app/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    Key key,
    @required this.cartItems,
    this.stage = 'Delivery',
  }) : super(key: key);

  final String stage;
  final List<CartItem> cartItems;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Order _order;

  bool _change = false;
  List<String> _deliverymethods;
  String _selectedDeliveryMethod;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var profile = context.read<Profile>();

    _deliverymethods = ['Door Delivery', 'Pick up'];
    _selectedDeliveryMethod = _deliverymethods[0];

    _order = Order(
      name: profile.name,
      address: profile.address,
      mobile: profile.mobile,
      deliveryMethod: _selectedDeliveryMethod,
      items: widget.cartItems,
    );
  }

  String _validate(String value) {
    if (value.isEmpty) {
      return 'required';
    }
    return null;
  }

  void _toggleChange() {
    setState(() {
      _change = !_change;
      if (_change == true) {
        _nameController.text = _order.name;
        _addressController.text = _order.address;
        _mobileController.text = _order.mobile;
      }
    });
  }

  void _goBack() {
    ExtendedNavigator.root.pop();
  }

  void _onRadioListChanged(String value) {
    setState(() {
      _selectedDeliveryMethod = value;
    });
  }

  String calculateTotal() {
    double total = 0.0;
    for (CartItem item in _order.items) {
      double price = item.dish.price * item.quantity;
      total += price;
    }

    return toMoney(total);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.blue200,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.SIZE_30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.stage,
              style: textTheme.headline4.copyWith(
                fontFamily: StringConst.SF_PRO_TEXT,
                fontSize: Sizes.TEXT_SIZE_34,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringConst.ADDRESS_DETAILS,
                  style: textTheme.headline4.copyWith(
                    fontFamily: StringConst.SF_PRO_TEXT,
                    fontSize: Sizes.TEXT_SIZE_17,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: _toggleChange,
                  style: TextButton.styleFrom(primary: AppColors.orange),
                  child: Text(
                    _change == false ? StringConst.CHANGE : StringConst.CANCEL,
                    style: textTheme.bodyText2.copyWith(
                      fontFamily: StringConst.SF_PRO_TEXT,
                      fontSize: Sizes.TEXT_SIZE_15,
                      color: AppColors.orange,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: Sizes.SIZE_8),
            InfoCard(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.SIZE_30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildName(textTheme),
                      _buildDivider(),
                      _buildAddress(textTheme),
                      _buildDivider(),
                      _buildMobile(textTheme),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              StringConst.DELIVERY_METHOD,
              style: textTheme.headline4.copyWith(
                fontFamily: StringConst.SF_PRO_TEXT,
                fontSize: Sizes.TEXT_SIZE_17,
                color: Colors.black,
              ),
            ),
            SizedBox(height: Sizes.SIZE_16),
            RadioGroup(
              children: [
                for (String deliveryMethod in _deliverymethods)
                  RadioListTile<String>(
                    onChanged: _onRadioListChanged,
                    groupValue: _selectedDeliveryMethod,
                    value: deliveryMethod,
                    title: Text(
                      '${deliveryMethod}',
                      style: textTheme.bodyText2.copyWith(
                        fontFamily: StringConst.SF_PRO_TEXT,
                      ),
                    ),
                  ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(StringConst.TOTAL, style: textTheme.bodyText2),
                Text(
                  '${calculateTotal()}',
                  style: textTheme.headline4.copyWith(
                    fontFamily: StringConst.SF_PRO_TEXT,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: Sizes.SIZE_20),
                child: RoundedButton(
                  onPressed: () {},
                  label: StringConst.PROCEED_TO_PAYMENT,
                  width: MediaQuery.of(context).size.width - Sizes.SIZE_150,
                  height: Sizes.SIZE_60,
                ),
              ),
            ),
          ],
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
        StringConst.CHECKOUT,
        style: Theme.of(context).textTheme.headline4.copyWith(
              fontFamily: StringConst.SF_PRO_TEXT,
              fontSize: Sizes.TEXT_SIZE_18,
              color: Colors.black,
            ),
      ),
    );
  }

  Widget _buildDivider() {
    if (_change) {
      return Container();
    } else {
      return const Divider();
    }
  }

  Widget _buildName(TextTheme textTheme) {
    if (_change) {
      return Container(
        height: Sizes.SIZE_30,
        padding: const EdgeInsets.only(
          right: Sizes.SIZE_30,
          bottom: Sizes.SIZE_10,
        ),
        child: TextFormField(
          controller: _nameController,
          validator: _validate,
          style: textTheme.headline5.copyWith(
            fontFamily: StringConst.SF_PRO_TEXT,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            isDense: true,
          ),
        ),
      );
    } else {
      return Text(
        '${_order.name}',
        style: textTheme.headline5.copyWith(
          fontFamily: StringConst.SF_PRO_TEXT,
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }

  Widget _buildAddress(TextTheme textTheme) {
    if (_change) {
      return Container(
        padding: const EdgeInsets.only(
          right: Sizes.SIZE_30,
          bottom: Sizes.SIZE_10,
        ),
        child: TextFormField(
          controller: _addressController,
          maxLines: null,
          validator: _validate,
          style: textTheme.bodyText2.copyWith(
            fontFamily: StringConst.SF_PRO_TEXT,
            fontSize: Sizes.TEXT_SIZE_15,
          ),
          decoration: InputDecoration(
            isDense: true,
          ),
        ),
      );
    } else {
      return Text(
        '${_order.address}',
        style: textTheme.bodyText2.copyWith(
          fontFamily: StringConst.SF_PRO_TEXT,
          fontSize: Sizes.TEXT_SIZE_15,
        ),
      );
    }
  }

  Widget _buildMobile(TextTheme textTheme) {
    if (_change) {
      return Container(
        height: Sizes.SIZE_30,
        padding: const EdgeInsets.only(
          right: Sizes.SIZE_30,
          bottom: Sizes.SIZE_10,
        ),
        child: TextFormField(
          controller: _mobileController,
          validator: _validate,
          style: textTheme.bodyText2.copyWith(
            fontFamily: StringConst.SF_PRO_TEXT,
            fontSize: Sizes.TEXT_SIZE_15,
          ),
          decoration: InputDecoration(
            isDense: true,
          ),
        ),
      );
    } else {
      return Text(
        '${_order.mobile}',
        style: textTheme.bodyText2.copyWith(
          fontFamily: StringConst.SF_PRO_TEXT,
          fontSize: Sizes.TEXT_SIZE_15,
        ),
      );
    }
  }
}
