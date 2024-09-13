import 'package:flutter/material.dart';
import 'package:cafe_project/models/coffee.dart';
import 'package:cafe_project/screens/constants.dart';
class SearchInput extends StatefulWidget {
  final List<Coffees> coffeesList;
  final Function(Coffees) onItemClicked;

  SearchInput({required this.coffeesList, required this.onItemClicked});

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  List<Coffees> filteredCoffees = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.only(top: 25, right: 25, left: 25, bottom: 0),
        child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child:TextField(
                      onChanged: (value) {
                        setState(() {
                          isSearching = value.isNotEmpty;
                          filteredCoffees = widget.coffeesList
                              .where((coffee) =>
                              coffee.title.toLowerCase().contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search Aesthetic Coffee',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/gifs/giphy.gif',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        suffixIcon: Container(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              if (filteredCoffees.isNotEmpty) {
                                widget.onItemClicked(filteredCoffees.first);
                              }
                            },
                            child: Image.asset('assets/icons/search.png', width: 20),
                          ),
                        ),
                      ),
                    ),



                  ),
                ],
              ),
              if (isSearching)
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: filteredCoffees
                        .map(
                          (coffee) => InkWell(
                        onTap: () {
                          widget.onItemClicked(coffee);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10, right: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ), // Use Colors.white here
                          child: Text(
                            coffee.title,
                            style: TextStyle(color: Colors.black),
                          ), // Text color
                        ),
                      ),
                    )
                        .toList(),
                  ),
                )
              else
                Container(),
            ],
            ),
        );
    }
}