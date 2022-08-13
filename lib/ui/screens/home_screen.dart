import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/ui/screens/cart_screen.dart';
import 'package:food_delivery_app/ui/screens/restaurant_screen.dart';

import '../../models/order.dart';
import '../../widgets/rating.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double w = (MediaQuery.of(context).size.width / 100).roundToDouble();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          iconSize: w * 5,
          onPressed: () {},
        ),
        title: Text(
          'Food Delivery',
          style: TextStyle(
            color: Colors.white,
            fontSize: w * 4,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Cart (${currentUser.cart.length})",
              style: TextStyle(
                color: Colors.white,
                fontSize: w * 4,
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CartScreen(),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _searchBar(w),
          _recentOrders(w),
          _nearByRestaurants(w),
        ],
      ),
    );
  }

  Widget _searchBar(double w) => Padding(
        padding: EdgeInsets.all(w * 4),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 10),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: w * 3,
              horizontal: w * 3,
            ),
            prefixIcon: Icon(Icons.search_rounded, size: w * 5),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear_rounded),
              iconSize: w * 5,
              onPressed: () {},
            ),
            hintText: "Search Food or Restaurants",
          ),
        ),
      );
  Widget _recentOrders(double w) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 4),
            child: Text(
              "Recent Orders",
              style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: w * 4,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2),
            ),
          ),
          SizedBox(
            height: w * 30, //.................120.0
            child: ListView.builder(
              padding: EdgeInsets.only(left: w * 2),
              scrollDirection: Axis.horizontal,
              itemCount: currentUser.orders.length,
              itemBuilder: (BuildContext context, int index) {
                Order order = currentUser.orders[index];
                return _orderItem(context, order, w);
              },
            ),
          ),
        ],
      );

  Widget _orderItem(BuildContext context, Order order, double w) {
    return Container(
      margin: EdgeInsets.all(w * 2),
      width: w * 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 4),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(w * 4),
            child: Image(
              height: w * 25,
              width: w * 25,
              image: AssetImage(order.food.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(w * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "${order.food.name} (₹${order.food.price})",
                    order.food.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: w * 3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: w),
                  Text(
                    order.restaurant.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: w * 2.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: w),
                  Text(
                    order.date,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: w * 2.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: w * 5),
            width: w * 12,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.add_rounded),
              color: Colors.white,
              iconSize: w * 6,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _nearByRestaurants(double w) => Padding(
        padding: EdgeInsets.all(w * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nearby Restaurants",
              style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: w * 4,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2),
            ),
            _buildRestaurants(w),
          ],
        ),
      );

  Widget _buildRestaurants(double w) {
    List<Widget> restaurantList = [];
    restaurants.forEach(
      (Restaurant restaurant) {
        restaurantList.add(
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RestaurantScreen(restaurant: restaurant),
              ),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: w * 2, vertical: w * 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(w * 4),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(w * 4),
                    child: Image(
                      height: w * 30,
                      width: w * 30,
                      image: AssetImage(restaurant.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(w * 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: w * 3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: w),
                        RatingStars(rating: restaurant.rating),
                        SizedBox(height: w),
                        Text(
                          restaurant.address,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: w * 2.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: w),
                        Text(
                          '0.2 Miles away',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: w * 2.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    return Column(
      children: restaurantList,
    );
  }
}
