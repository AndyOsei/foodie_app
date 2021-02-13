import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/models/dish.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/custom_icon.dart';
import 'package:foodie_app/widgets/dish_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Dish> _dishes = [];
  List<Dish> _filteredDishes = [];
  int _filteredCount = -1;
  bool _filtering = false;

  @override
  void initState() {
    loadDishes().then((data) {
      setState(() {
        _dishes = data.expand((entry) => entry.dishes).toList();
      });
    });
    super.initState();
  }

  void _navigateBack() {
    ExtendedNavigator.root.pop();
  }

  @override
  Widget build(BuildContext context) {
    final bool itemNotFound = _filteredCount == 0;

    return Scaffold(
      backgroundColor: itemNotFound ? AppColors.blue200 : AppColors.gray,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            _buildSearch(context),
            Expanded(child: _buildGrid(context)),
          ],
        ),
      ),
    );
  }

  void _onTextChanged(String search) {
    setState(() {
      if (search != '') {
        _filtering = true;
        _filteredDishes = _dishes
            .where((dish) => dish.name.toLowerCase().contains(search))
            .toList();
        _filteredCount = _filteredDishes.length;
        // print('_dishes $_dishes');
        // print('_filteredCount $_filteredCount');
      } else {
        _filteredCount = -1;
        _filtering = false;
      }
    });
  }

  Padding _buildSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.SIZE_30),
      child: Row(
        children: [
          IconButton(
            onPressed: _navigateBack,
            icon: Icon(Icons.keyboard_arrow_left),
          ),
          SizedBox(width: Sizes.SIZE_30),
          Expanded(
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: _onTextChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: StringConst.SEARCH_HINT,
              ),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }

  Center _buildItemNotFound() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIcon(
              name: 'search',
              color: AppColors.gray100,
            ),
            SizedBox(height: Sizes.SIZE_20),
            Text(
              StringConst.ITEM_NOT_FOUND,
              style: Theme.of(context).textTheme.headline3.copyWith(
                    fontFamily: StringConst.SF_PRO_TEXT,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: Sizes.SIZE_20),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2,
              ),
              child: Text(StringConst.ITEM_NOT_FOUND_HINT,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontFamily: StringConst.SF_PRO_TEXT,
                        color: AppColors.gray200,
                      )),
            )
          ],
        ),
      );

  Widget _buildGrid(BuildContext context) {
    if (_filteredCount == 0) {
      return _buildItemNotFound();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.SIZE_30),
            topRight: Radius.circular(Sizes.SIZE_30)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.SIZE_30),
            child: Align(
              alignment: Alignment.center,
              child: _buildResultText(context),
            ),
          ),
          Expanded(
            child: _buildDishesGridList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildResultText(BuildContext context) {
    if (_filteredCount == -1) {
      return Container();
    }

    return Text(
      'Found $_filteredCount Results',
      style:
          Theme.of(context).textTheme.headline3.copyWith(color: Colors.black),
    );
  }

  Widget _buildDishesGridList(BuildContext context) {
    final List<Dish> _dishList = _filtering ? _filteredDishes : _dishes;

    if (_dishList.length > 0) {
      return GridView.builder(
        padding: const EdgeInsets.all(Sizes.SIZE_30),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: _dishList.length,
        itemBuilder: (BuildContext context, int index) {
          final double isFirstMargin =
              index == 0 ? Sizes.SIZE_20 : Sizes.SIZE_12;
          final double isLastMargin =
              index == _dishList.length - 1 ? Sizes.SIZE_20 : Sizes.SIZE_12;

          if (index % 2 != 0) {
            return Transform(
              transform: Matrix4.identity()..translate(0.0, 60.0),
              child: Container(
                margin: EdgeInsets.only(
                  top: isFirstMargin,
                  bottom: isLastMargin,
                ),
                child: DishCard(
                  dish: _dishList[index],
                ),
              ),
            );
          }

          return Container(
            margin: EdgeInsets.only(
              top: isFirstMargin,
              bottom: isLastMargin,
            ),
            child: DishCard(
              dish: _dishList[index],
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
