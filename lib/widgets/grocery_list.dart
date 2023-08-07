import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_mate/data/dummy_items.dart';
import 'package:shop_mate/models/grocery_item.dart';
import 'package:shop_mate/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItem = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItem.add(newItem);
    });
  }

  void _removeItem(int index) async {
    setState(() {
      _groceryItem.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
      ),
      body: _groceryItem.isNotEmpty
          ? ListView.builder(
              itemCount: _groceryItem.length,
              itemBuilder: (context, index) => Dismissible(
                key: ValueKey(_groceryItem[index]),
                onDismissed: (direction) => _removeItem(index),
                background: ListTile(
                  tileColor: Theme.of(context).colorScheme.errorContainer,
                ),
                child: ListTile(
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: _groceryItem[index].category.color,
                  ),
                  title: Text(_groceryItem[index].name),
                  trailing: Text(
                    _groceryItem[index].quantity.toString(),
                  ),
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "No items yet . . .",
                        textStyle: GoogleFonts.italiana(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 250),
                      ),
                    ],
                    totalRepeatCount: 5,
                    pause: const Duration(milliseconds: 200),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                ),
              ],
            ),
    );
  }
}
