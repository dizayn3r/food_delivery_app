import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/counter_widget.dart';

import '../../data/data.dart';
import '../../models/order.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  _buildCartItem(Order order, double w) {
    return Container(
      padding: EdgeInsets.all(w * 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Image and Quantity
          Column(
            children: [
              Image(
                image: AssetImage(order.food.imageUrl),
                fit: BoxFit.cover,
                width: w * 35,
                height: w * 35,
              ),
              SizedBox(height: w * 2),
              Container(
                width: w * 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w * 2),
                  border: Border.all(
                    width: 0.8,
                    color: Colors.black54,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        '-',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: w * 5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: w * 5),
                    Text(
                      order.quantity.toString(),
                      style: TextStyle(
                        fontSize: w * 5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: w * 5),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        '+',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: w * 5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: w * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order.food.name,
                  style: TextStyle(
                    fontSize: w * 4,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: w * 2),
                Text(
                  order.restaurant.name,
                  style: TextStyle(
                    fontSize: w * 4,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: w * 2),
                Text(
                  '\$${order.quantity * order.food.price}',
                  style: TextStyle(
                    fontSize: w * 4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = (MediaQuery.of(context).size.width / 100).roundToDouble();
    double totalPrice = 0;
    currentUser.cart.forEach(
      (Order order) => totalPrice += order.quantity * order.food.price,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${currentUser.cart.length})'),
      ),
      body: ListView.separated(
        itemCount: currentUser.cart.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cart.length) {
            Order order = currentUser.cart[index];
            return _buildCartItem(order, w);
          }
          return Padding(
            padding: EdgeInsets.all(w * 5),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Estimated Delivery Time:',
                      style: TextStyle(
                        fontSize: w * 4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '25 min',
                      style: TextStyle(
                        fontSize: w * 4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: w * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total Cost:',
                      style: TextStyle(
                        fontSize: w * 4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: w * 4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: w * 20),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1.0,
            color: Colors.grey,
          );
        },
      ),
      bottomSheet: Container(
        height: w * 20,
        alignment: Alignment.center,
        width: w * 100,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Text(
          'CHECKOUT',
          style: TextStyle(
            color: Colors.white,
            fontSize: w * 5,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}
