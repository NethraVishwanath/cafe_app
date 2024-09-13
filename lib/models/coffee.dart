
import 'package:equatable/equatable.dart';

class Coffees extends Equatable {
  final String title;
  final String subtitle;
  final String ingredients;
  final String price;
  final String imageUrl;
  final String description;
  List<String> detailUrl;

  Coffees({required this.title,required this.subtitle,required this.price,required this.imageUrl,required this.detailUrl,required this.ingredients,required this.description});

  static List<Coffees> generateCoffees(){
    return [
      Coffees(
        title: 'Espresso',
        subtitle: 'coffee',
        price: '\₹ 207.50',
        ingredients: 'Tea Leaves, Water, Milk (Optional), Sweetener (Optional)',
        imageUrl: 'assets/images/Cappuccino.jpg',
        detailUrl: ['assets/images/arrival1.png', 'assets/images/detail2.png'],
        description: 'Espresso is a coffee brewing method that forces hot water through finely-ground coffee beans at high pressure. This results in a concentrated, flavorful shot of coffee with a thick crema. ',
      ),

      Coffees(
        title: 'Americano',
        subtitle: 'coffee',
        price: '\₹  210.00',
        ingredients: 'Coffee Beans, Water',
        imageUrl: 'assets/images/Americano.jpg',
        detailUrl: ['assets/images/arrival2.png', 'assets/images/best1.png'],
        description: ' An Americano is a coffee drink made with espresso and hot water. It is similar to a black coffee, but with a stronger espresso flavor. ',
      ),


      Coffees(
        title: 'Latte',
        subtitle: 'coffee',
        price: '\₹  160.00',
        ingredients: 'Coffee Beans, Rose Petals, Milk or Cream, Sweetener (Optional)',
        imageUrl: 'assets/images/Latte.jpg',
        detailUrl: ['assets/images/best1.png', 'assets/images/detail2.png'],
        description: 'A latte is a coffee drink made with espresso and steamed milk. It is typically served in a tall glass and has a creamy, smooth texture. ',
      ),


      Coffees(
          title: 'Cappuccino',
        subtitle: 'coffee',
          price: '\₹ 190.00',
          ingredients: 'Coffee Beans, Badam (Almond) Extract, Milk or Cream, Sweetener (Optional)',
          imageUrl: 'assets/images/Cappuccino.jpg',
          detailUrl: ['assets/images/detail2.png', 'assets/images/detail3.png'],
          description: 'A cappuccino is a coffee drink made with espresso, steamed milk, and foamed milk. It is typically served in a small cup and has a slightly frothy texture. ',
      ),

      Coffees(
        title: 'Mocha',
        subtitle: 'coffee',
        price: '\₹ 199.00',
        ingredients: 'Tea Leaves, Water, Milk or Cream, Lemon, Spices',
        imageUrl: 'assets/images/Mocha.jpg',
        detailUrl: ['assets/images/detail3.png', 'assets/images/arrival1.png'],
        description: 'A mocha is a coffee drink made with espresso, chocolate, and steamed milk. It is typically served in a small cup and has a rich, chocolatey flavor.',
      ),
      Coffees(
        title: 'Black Tea',
        subtitle: 'tea',
        price: '\₹  89.00',
        ingredients: 'Tea Leaves, Water, Milk or Cream, Lemon, Spices',
        imageUrl: 'assets/images/Black Tea.jpg',
        detailUrl: ['assets/images/detail3.png', 'assets/images/arrival1.png'],
        description: 'Discover the timeless elegance of our Black Tea, a true classic that transcends trends. Sourced from the finest tea leaves, this brew captivates with its deep and robust flavor profile. Whether enjoyed on its own or personalized with a splash of milk, a twist of lemon, or a dash of spices, our Black Tea promises a refined and invigorating tea experience. Embrace the artistry of tea-drinking with this distinguished and versatile blend.',
      ),

      Coffees(
        title: 'Green Tea',
        subtitle: 'tea',
        price: '\₹ 109.00',
        ingredients: 'Tea Leaves, Water, Milk or Cream, Lemon, Spices',
        imageUrl: 'assets/images/Green Tea.jpg',
        detailUrl: ['assets/images/detail3.png', 'assets/images/arrival1.png'],
        description: 'Green tea is a type of tea that is not fully oxidized, meaning that the leaves have been steamed or pan-fired to stop the oxidation process. Green tea has a light, delicate flavor. ',
    ),
      Coffees(
        title: 'Herbal Tea',
        subtitle: 'tea',
        price: '\₹ 209.00',
        ingredients: 'Tea Leaves, Water, Milk or Cream, Lemon, Spices',
        imageUrl: 'assets/images/Herbal Tea.jpg',
        detailUrl: ['assets/images/detail3.png', 'assets/images/arrival1.png'],
        description: ' Herbal tea is a type of tea that is made from dried herbs, flowers, or fruits. Herbal tea does not contain caffeine and has a variety of flavors. ',
      ),

      Coffees(
        title: 'Chai',
        subtitle: 'tea',
        price: '\₹  110.00',
        ingredients: 'Tea Leaves, Water, Milk or Cream, Lemon, Spices',
        imageUrl: 'assets/images/Chai.jpg',
        detailUrl: ['assets/images/detail3.png', 'assets/images/arrival1.png'],
          description: 'Chai is a type of tea that is made from black tea, spices, and milk or cream. Chai has a strong, spicy flavor. ',
      ),
          Coffees(
        title: 'Iced Tea', subtitle: 'tea',
        price: '\₹ 209.00',
        ingredients: 'Tea Leaves, Water, Milk or Cream, Lemon, Spices',
        imageUrl: 'assets/images/Iced tea.jpg',
        detailUrl: ['assets/images/detail3.png', 'assets/images/arrival1.png'],
        description: 'Iced tea is a type of tea that is brewed hot and then chilled. Iced tea can be made with black tea, green tea, or herbal tea. ',
          ),


    ];
  }
  @override
  List<Object?> get props =>
      [
  title,
  subtitle,
  price,
  imageUrl,
  ingredients,
  description,
  detailUrl,
  ];
}

