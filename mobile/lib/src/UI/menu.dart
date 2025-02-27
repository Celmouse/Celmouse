import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controles'),
      ),
      body: CardList(),
    );
  }
}

class CardList extends StatelessWidget {
  CardList({super.key});

  push(context, Widget page) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  final List<CardItem> items = [
    CardItem(
      icon: Icons.mouse,
      title: 'Mouse',
      description: 'Aponte pra tela',
      color: Colors.blueAccent,
      // navigate: ()=> push(MoveMousePage(channel: channel))
    ),
    CardItem(
      icon: Icons.touch_app,
      title: 'TouchPad',
      description: 'Deslize o dedo',
      color: Colors.greenAccent[700]!,
    ),
    CardItem(
      icon: Icons.keyboard,
      title: 'Teclado',
      description: 'Escreva e use atalhos',
      color: Colors.orangeAccent,
    ),
    CardItem(
      icon: Icons.apple,
      title: 'Template MacOS',
      description: 'Navegue rapidamente no MacOS',
      color: Colors.redAccent,
    ),
    CardItem(
      icon: Icons.window_sharp,
      title: 'Template Windows',
      description: 'Navegue no Windows',
      color: Colors.purpleAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: item.color,
            child: ListTile(
              leading: Icon(item.icon, size: 40, color: Colors.white),
              title: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                item.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CardItem {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback? navigate;

  CardItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.navigate,
  });
}
