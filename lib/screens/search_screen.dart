import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/models/dish.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/dish_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Dish> _dishes = [];

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
    return Scaffold(
      backgroundColor: AppColors.gray,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            _buildSearch(),
            _buildGrid(),
          ],
        ),
      ),
    );
  }

  Padding _buildSearch() {
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter a search term',
                )),
          )
        ],
      ),
    );
  }

  Expanded _buildGrid() {
    return Expanded(
      child: Builder(
        builder: (
          BuildContext context,
        ) {
          if (_dishes.length > 0) {
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
                    padding:
                        const EdgeInsets.symmetric(vertical: Sizes.SIZE_30),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Found 6 Results",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildDishesGridList(context),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  GridView _buildDishesGridList(BuildContext context) {
    return GridView.builder(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.all(Sizes.SIZE_30),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: _dishes.length,
        itemBuilder: (BuildContext context, int index) {
          final double isFirstMargin =
              index == 0 ? Sizes.SIZE_20 : Sizes.SIZE_12;
          final double isLastMargin =
              index == _dishes.length - 1 ? Sizes.SIZE_20 : Sizes.SIZE_12;

          if (index % 2 != 0) {
            return Transform(
              transform: Matrix4.identity()..translate(0.0, 60.0),
              child: Container(
                margin: EdgeInsets.only(
                  top: isFirstMargin,
                  bottom: isLastMargin,
                ),
                child: DishCard(
                  dish: _dishes[index],
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
              dish: _dishes[index],
            ),
          );
        });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
