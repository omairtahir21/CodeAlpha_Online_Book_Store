import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllBookStore',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Book> books = [
    Book('Flutter', 'Author 1', 20, 'assets/book1.jpg'),
    Book('Mobile app developemnt', 'Author 2', 25, 'assets/book 2.jpg'),
    Book('UI/UX', 'Author 3', 30, 'assets/book 3.jpg'),
    // Add more books...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Book Store'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Image.asset(
                books[index].image,
                width: 50,
                height: 50,
              ),
              title: Text(books[index].title),
              subtitle: Text('${books[index].author} - \$${books[index].price}'),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Cart.addToCart(books[index]);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${books[index].title} added to cart'),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class Book {
  final String title;
  final String author;
  final double price;
  final String image;

  Book(this.title, this.author, this.price, this.image);
}

class Cart {
  static List<Book> items = [];

  static void addToCart(Book book) {
    items.add(book);
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: Cart.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(Cart.items[index].title),
            subtitle: Text(Cart.items[index].author),
            trailing: Text('\$${Cart.items[index].price}'),
          );
        },
      ),
    );
  }
}
