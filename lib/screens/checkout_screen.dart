import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/models/cart.dart';
import 'package:foodie_app/models/dish.dart';
import 'package:foodie_app/models/order.dart';
import 'package:foodie_app/models/payment_method.dart';
import 'package:foodie_app/models/profile.dart';
import 'package:foodie_app/routes/router.gr.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/custom_alert_dialog.dart';
import 'package:foodie_app/widgets/custom_icon.dart';
import 'package:foodie_app/widgets/info_card.dart';
import 'package:foodie_app/widgets/radio_group.dart';
import 'package:foodie_app/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    Key key,
    this.order,
    this.cartItems,
    this.stage = 'Delivery',
  }) : super(key: key);

  final String stage;
  final Order order;
  final List<CartItem> cartItems;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Order _order;

  bool _change = false;
  List<String> _deliverymethods;
  String _selectedDeliveryMethod;
  List<PaymentMethod> _paymentMethods;
  PaymentMethod _selectedPaymentMethod;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.order != null) {
      _order = widget.order;
    } else {
      var profile = context.read<Profile>();

      _order = Order(
        name: profile.name,
        address: profile.address,
        mobile: profile.mobile,
        deliveryMethod: _selectedDeliveryMethod,
        items: widget.cartItems,
        total: calculateTotal(),
      );
    }

    _deliverymethods = ['Door delivery', 'Pick up'];
    _selectedDeliveryMethod = _deliverymethods[0];

    _paymentMethods = defaultPaymentMethods();
    _selectedPaymentMethod = _paymentMethods[0];
  }

  double calculateTotal() {
    double total = 0.0;
    for (CartItem item in widget.cartItems) {
      double price = item.dish.price * item.quantity;
      total += price;
    }

    return total;
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

  void _onDeliveryMethodRadioChanged(String value) {
    setState(() {
      _selectedDeliveryMethod = value;
    });
  }

  void _update() {
    if (_formKey.currentState.validate()) {
      setState(() {
        if (_nameController.text != _order.name) {
          _order.name = _nameController.text;
        }

        if (_addressController.text != _order.address) {
          _order.address = _addressController.text;
        }

        if (_mobileController.text != _order.mobile) {
          _order.mobile = _mobileController.text;
        }

        if (_order.deliveryMethod != _selectedDeliveryMethod) {
          _order.deliveryMethod = _selectedDeliveryMethod;
        }

        _change = false;
      });
    }
  }

  void _proceed() {
    ExtendedNavigator.root.push(
      Routes.checkoutScreen,
      arguments: CheckoutScreenArguments(
        order: _order,
        stage: 'Payment',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.blue200,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 30,
            right: 30,
            bottom:
                Theme.of(context).platform == TargetPlatform.android ? 16 : 0,
          ),
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
              SizedBox(height: Sizes.SIZE_20),
              ..._buildStageContent(textTheme),
              Spacer(),
              Text(
                StringConst.DELIVERY_METHOD,
                style: textTheme.headline4.copyWith(
                  fontFamily: StringConst.SF_PRO_TEXT,
                  fontSize: Sizes.TEXT_SIZE_17,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: Sizes.SIZE_8),
              RadioGroup(
                children: [
                  for (String deliveryMethod in _deliverymethods)
                    RadioListTile<String>(
                      onChanged: _onDeliveryMethodRadioChanged,
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
                    '${toMoney(_order.total)}',
                    style: textTheme.headline4.copyWith(
                      fontFamily: StringConst.SF_PRO_TEXT,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Spacer(),
              _buildBottomButton(context),
            ],
          ),
        ),
      ),
    );
  }

  void _finish(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: Text(
          StringConst.PLEASE_NOTE,
          style: TextStyle(
            fontFamily: StringConst.POPPINS,
            fontSize: Sizes.TEXT_SIZE_20,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConst.DELIVERY_TO_MAINLAND,
              style: textTheme.bodyText2.copyWith(
                fontFamily: StringConst.POPPINS,
                fontSize: Sizes.TEXT_SIZE_15,
                color: AppColors.gray400,
              ),
            ),
            Text(
              '${toMoney(1000)} - ${toMoney(2000)}',
              style: textTheme.bodyText2.copyWith(
                fontFamily: StringConst.POPPINS,
                fontSize: Sizes.TEXT_SIZE_17,
                color: Colors.black,
              ),
            ),
            const Divider(height: Sizes.SIZE_40),
            Text(
              StringConst.DELIVERY_TO_ISLAND,
              style: textTheme.bodyText2.copyWith(
                fontFamily: StringConst.POPPINS,
                fontSize: Sizes.TEXT_SIZE_15,
                color: AppColors.gray400,
              ),
            ),
            Text(
              '${toMoney(2000)} - ${toMoney(3000)}',
              style: textTheme.bodyText2.copyWith(
                fontFamily: StringConst.POPPINS,
                fontSize: Sizes.TEXT_SIZE_17,
                color: Colors.black,
              ),
            ),
            SizedBox(height: Sizes.SIZE_20),
          ],
        ),
        actions: [
          TextButton(
            child: Text(StringConst.CANCEL),
            style: TextButton.styleFrom(
              primary: Colors.black,
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.SIZE_16,
                horizontal: Sizes.SIZE_20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.SIZE_30),
              ),
              textStyle: textTheme.bodyText1.copyWith(
                fontFamily: StringConst.POPPINS,
              ),
            ),
            onPressed: () {
              ExtendedNavigator.root.pop();
            },
          ),
          TextButton(
            child: Text(StringConst.PROCEED),
            style: TextButton.styleFrom(
              primary: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.SIZE_16,
                horizontal: Sizes.SIZE_20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: AppColors.red200,
              textStyle: textTheme.bodyText1.copyWith(
                fontFamily: StringConst.POPPINS,
              ),
            ),
            onPressed: () {
              var orders = context.read<Orders>();
              var cart = context.read<Cart>();
              orders.add(_order);
              cart.clear();
              ExtendedNavigator.root.push(Routes.homeScreen);
            },
          ),
        ],
      ),
    );
  }

  Align _buildBottomButton(BuildContext context) {
    void Function() onPressed;
    String label;
    if (widget.stage == 'Delivery') {
      onPressed = _change ? _update : _proceed;
      label = _change ? StringConst.UPDATE : StringConst.PROCEED_TO_PAYMENT;
    } else {
      onPressed = () {
        _finish(context);
      };
      label = StringConst.FINISH;
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: RoundedButton(
        onPressed: onPressed,
        label: label,
        width: MediaQuery.of(context).size.width - Sizes.SIZE_150,
        height: Sizes.SIZE_60,
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
      centerTitle: true,
    );
  }

  List<Widget> _buildStageContent(TextTheme textTheme) {
    if (widget.stage == 'Delivery') {
      return _buildAddressDetails(textTheme);
    } else {
      return _buildPaymentMethodsRadioGroup(textTheme);
    }
  }

  List<Widget> _buildAddressDetails(TextTheme textTheme) {
    return [
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
              _change == false
                  ? StringConst.CHANGE
                  : StringConst.CANCEL.toLowerCase(),
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
          padding: const EdgeInsets.all(Sizes.SIZE_20),
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
    ];
  }

  void _onPaymentMethodRadioChanged(PaymentMethod value) {
    setState(() {
      _selectedPaymentMethod = value;
    });
  }

  List<Widget> _buildPaymentMethodsRadioGroup(TextTheme textTheme) {
    return [
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
              onChanged: _onPaymentMethodRadioChanged,
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
