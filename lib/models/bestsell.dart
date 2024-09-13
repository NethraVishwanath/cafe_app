import 'package:equatable/equatable.dart';

class BestSellers extends Equatable {
  final String title;
  final String category;
  final String price;
  final String imageUrl;
  final String ingredients;
  final String description;

  BestSellers({
    required this.title,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.ingredients,
    required this.description,
  });

  static List<BestSellers> generateBestSellers() {
    return [
      BestSellers(
        title: 'Indian Coffee',
        category: 'Coffee',
        price: '\₹  129.89',
        imageUrl: 'assets/images/Filter Coffee.jpg',
        ingredients: 'Coffee beans, hot water, sugar, milk',
        description: 'Indian filter coffee is a coffee drink made by mixing hot milk and sugar with the infusion obtained by percolation brewing of finely ground coffee powder with chicory in a traditional Indian filter',
      ),
      BestSellers(
          title: 'Chai',
          category: 'Coffee Beans',
          price: '\₹ 110.00',
          imageUrl: 'assets/images/Chai.jpg',
          ingredients: 'Black coffee beans, hot water',
          description: 'Chai is a type of tea that is made from black tea, spices, and milk or cream. Chai has a strong, spicy flavor. '
      ),
      BestSellers(
          title: 'Instant Coffee',
          category: 'Instant coffee',
          price: '\₹ 120.00',
          imageUrl: 'assets/images/Instant Coffee.jpg',
          ingredients: 'milk,sugar, coffee powder',
          description: 'Instant coffee is known for being easy to make. All you have to do is scoop the coffee granules into a mug, add water, and stir. Sweeteners and creamers can be added before or after you pour the water; it doesnt make much difference either way.'),

      BestSellers(
        title: 'Black Tea',
        category: 'Instant coffee',
        price: '\₹ 109.00',
        ingredients: 'Tea Leaves, Water, Milk or Cream, Lemon, Spices',
        imageUrl: 'assets/images/Black Tea.jpg',
        description: 'Discover the timeless elegance of our Black Tea, a true classic that transcends trends. Sourced from the finest tea leaves, this brew captivates with its deep and robust flavor profile. Whether enjoyed on its own or personalized with a splash of milk, a twist of lemon, or a dash of spices, our Black Tea promises a refined and invigorating tea experience. Embrace the artistry of tea-drinking with this distinguished and versatile blend.',
      ),
      BestSellers(
        title: 'Cappuccino',
        category: 'Instant coffee',
        price: '\₹ 150.00',
        ingredients: 'Coffee Beans, Badam (Almond) Extract, Milk or Cream, Sweetener (Optional)',
        imageUrl: 'assets/images/Cappuccino.jpg',
        description: 'A cappuccino is a coffee drink made with espresso, steamed milk, and foamed milk. It is typically served in a small cup and has a slightly frothy texture. ',
      ),
      BestSellers(
        title: 'Americano',
        category: 'Instant coffee',
        price: '\₹ 210.00',
        ingredients: 'Coffee Beans, Water',
        imageUrl: 'assets/images/Americano.jpg',
        description: ' An Americano is a coffee drink made with espresso and hot water. It is similar to a black coffee, but with a stronger espresso flavor. ',
      ),
      BestSellers(
        title: 'Latte',
        category: 'Instant coffee',
        price: '\₹ 100.00',
        ingredients: 'Coffee Beans, Rose Petals, Milk or Cream, Sweetener (Optional)',
        imageUrl: 'assets/images/Latte.jpg',
        description: 'A latte is a coffee drink made with espresso and steamed milk. It is typically served in a tall glass and has a creamy, smooth texture. ',
      ),
      BestSellers(
        title: 'Herbal Tea',
        category: 'Instant coffee',
        price: '\₹ 89.00',
        ingredients: 'Tea Leaves, Water, Milk or Cream, Lemon, Spices',
        imageUrl: 'assets/images/Herbal Tea.jpg',
        description: ' Herbal tea is a type of tea that is made from dried herbs, flowers, or fruits. Herbal tea does not contain caffeine and has a variety of flavors. ',
      ),

    ];
  }
    @override
    List<Object?> get props =>
    [
      title,
      category,
      price,
      imageUrl,
      ingredients,
      description,

    ];
  }
