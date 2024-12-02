import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitungayabiso/widget/app_text.dart';
import 'package:kitungayabiso/widget/app_text_large.dart';
import 'package:kitungayabiso/widget/constantes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey pour contrôler le Drawer

  final List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'assets/Intro_3.jpg',
      'title': 'Four encastrable fonction vapeur LIVERPOOL',
      'originalPrice': '500.00',
      'discountedPrice': '499.00',
      'discount': 0.25,
    },
    // Ajoutez ici d'autres produits...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _scaffoldKey, // Ajout de la clé au Scaffold
      appBar: AppBar(
        centerTitle: false,
        title: const Image(
          height: 100,
          width: 90,
          image: AssetImage(
            'assets/logo_kitunga.png',
          ),
        ),
        actions: [
          Row(
            children: [
              Column(
                children: [
                  const Icon(
                    CupertinoIcons.person,
                  ),
                  AppText(
                    text: 'Se connecter',
                    size: 12,
                  ),
                ],
              ),
              sizedbox2,
              Column(
                children: [
                  const Icon(
                    CupertinoIcons.cart,
                  ),
                  AppText(
                    text: 'Panier',
                    size: 12,
                  ),
                ],
              ),
              sizedbox2,
            ],
          )
        ],
        leading: Container(),
          leadingWidth: 0,
      ),
      drawer: Drawer( // Menu latéral Drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).highlightColor,
                  ),
                  SizedBox(height: 10),
                  const Text('Futela App', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Recherche'),
              onTap: () {
                // Logique de navigation ici
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Catégories'),
              onTap: () {
                // Logique de navigation ici
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Déconnexion'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: _HeaderDelegate(openDrawer: _openDrawer), // Passer la méthode pour ouvrir le Drawer
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                children: [
                  sizedbox,
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                  sizedbox,
                  Align(
                    alignment: Alignment.topLeft,
                    child: AppTextLarge(
                      text: 'Nos Meilleures Offres',
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final product = products[index];
                  return ProductCard(
                    imageUrl: product['imageUrl'],
                    title: product['title'],
                    originalPrice: product['originalPrice'],
                    discountedPrice: product['discountedPrice'],
                    discount: product['discount'],
                  );
                },
                childCount: products.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour ouvrir le Drawer
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Function openDrawer;

  _HeaderDelegate({required this.openDrawer});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              openDrawer(); // Ouvrir le Drawer au clic
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(CupertinoIcons.list_bullet_below_rectangle),
                AppText(
                  text: 'Produits',
                  size: 10,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 45,
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).highlightColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: 'Recherche'),
                const Icon(CupertinoIcons.search),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 70.0;

  @override
  double get minExtent => 70.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String originalPrice;
  final String discountedPrice;
  final double discount;

  const ProductCard({
    required this.imageUrl,
    required this.title,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 10),
          AppText(
            text: title,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '$originalPrice\$',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).highlightColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '-${(discount * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$discountedPrice\$',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: const CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  radius: 20,
                  child: Icon(
                    CupertinoIcons.cart_fill,
                    color: Colors.white
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
