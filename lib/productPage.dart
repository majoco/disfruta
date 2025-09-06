import 'package:disfruta/category.dart';
import 'package:disfruta/productDetailPage.dart';
import 'package:disfruta/category.dart';
import 'package:disfruta/productDetailPage.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import 'api/woo.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final WooService wooService = WooService();
  late Future<List<Product>> futureProducts;

  late Future<List<Category>> futureCategories;

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text("Inicio")),
    const Center(child: Text("Favoritos")),
    const Center(child: Text("Mapa")),
    const Center(child: Text("Perfil")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;      
    });
  }

  @override
  void initState() {
    super.initState();
    futureProducts = wooService.getProducts();
    futureCategories = wooService.getCategories();
    
  }

  String cleanDescription(String description) {
    return description.replaceAll("<p>", "").replaceAll("</p>", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alineado a la izquierda
            children: [
              Text(
                "Hola, Juan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "¡Vamos a explorar!",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                final products = await futureProducts;
                showSearch(
                  context: context,
                  delegate: ProductSearchDelegate(products),
                );
              },
            ),
          ],
        ),
        // 👉 Drawer (menú hamburguesa)
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Menú',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Inicio'),
                onTap: () {
                  Navigator.pop(context); // Cierra el drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductPage()),
                  );
                },
              ),
              /*ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Carrito'),
              onTap: () {
                Navigator.pop(context);
                // Aquí podrías navegar a tu página de carrito
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
              },
            ),*/
            ],
          ),
        ),
        body: bodyInicio(),

        // 🔹 Menú inferior
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.orange, // el seleccionado en naranja
          unselectedItemColor: Colors.grey, // los no seleccionados en gris
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Inicio",              

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: "Favoritos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Mapa",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Perfil",
            ),
          ],
        ));
  }

  FutureBuilder<List<Product>> bodyInicio() {
    return FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay productos"));
          } else {
            final products = snapshot.data!;
            return Column(
              children: [
                Padding(
                  //padding: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.only(
                      top: 12, left: 16, right: 16, bottom: 0),
                  //height: 100, // altura del slider
                  //margin: const EdgeInsets.symmetric(vertical: 6),
                  child: SizedBox(
                    height: 80, // Altura del slider
                    child: SizedBox(
                        width: MediaQuery.of(context)
                            .size
                            .width, // opcional: ancho del PageView
                        child: /*PageView(
                      controller: PageController(viewportFraction: .5),
                      children: [
                        _buildInfoChip("24°", "Antofagasta", Colors.blue),
                        _buildInfoChip("13 UV", "Radiación", Colors.orange),
                        _buildInfoChip("16 km/h", "Viento", Colors.red),
                      ],
                    ),*/
                            ListView(
                          scrollDirection:
                              Axis.horizontal, // slider horizontal
                          children: [
                            _buildInfoChip(
                                "24°", "Antofagasta", Colors.orange),
                            _buildInfoChip("13 UV", "Radiación", Colors.red),
                            _buildInfoChip(
                                "16 km/h", "Viento", const Color(0xFF1C9FE2)),
                          ],
                        )),
                  ),
                ),

                Padding(
                  //padding: const EdgeInsets.all(16.0),
                  padding:
                      EdgeInsets.only(top: 6, left: 16, right: 16, bottom: 6),
                  child: SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis
                          .horizontal, // slider horizontal                                          ,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(12), // bordes redondeados
                          child: Image.asset(
                            'lib/assets/images/image_banner.png',
                            //height: 130,
                            //width: 200, // ancho fijo para que se vea como banner
                            fit: BoxFit.cover, // se ajusta al contenedor
                          ),
                        ),
                        SizedBox(width: 5), // espacio entre imágenes
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'lib/assets/images/image_banner.png',
                            //height: 130,
                            //width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 5),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'lib/assets/images/image_banner.png',
                            //height: 130,
                            //width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 🔹 Título Categorías
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Categorías",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Aquí acción al presionar "Ver más"
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Ver más",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF3771D),
                              ),
                            ),
                            SizedBox(
                                width: 4), // espacio entre texto e ícono
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF3771D),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                FutureBuilder<List<Category>>(
                  future: futureCategories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SizedBox(); // no muestra nada si no hay categorías
                    } else {
                      final categories = snapshot.data!;
                      return SizedBox(
                        height: 40, // más alto para ícono + texto
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    futureProducts = wooService
                                        .getProductsByCategory(category.id);
                                  });
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3.0, vertical: 0.0),
                                      decoration: const BoxDecoration(
                                          //color: Colors.blue.shade50, // color de fondo
                                          //borderRadius: BorderRadius.circular(0),
                                          ),
                                      child: category.image.isNotEmpty
                                          ? Image.network(
                                              category.image,
                                              width: 28,
                                              height: 28,
                                              fit: BoxFit.contain,
                                            )
                                          : const Icon(Icons.category,
                                              size: 22,
                                              color: Color(0xFF828582)),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      category.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF828582),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),

                // 🔹 Título Categorías
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Playas Destacadas",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Aquí acción al presionar "Ver más"
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Todos",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF3771D),
                              ),
                            ),
                            SizedBox(
                                width: 4), // espacio entre texto e ícono
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF3771D),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 🔹 Lista con scroll
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(product: product),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Imagen del producto
                                  ClipRRect(
                                    borderRadius: const BorderRadius.horizontal(
                                        left: Radius.circular(16),
                                        right: Radius.circular(16),
                                      ),
                                    child: product.image.isNotEmpty
                                        ? Image.network(
                                            product.image,
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.cover,                                              
                                          )
                                        : Container(
                                            width: 120,
                                            height: 120,
                                            color: Colors.grey[200],
                                            child: const Icon(
                                                Icons.image_not_supported,
                                                size: 40,
                                                color: Colors.grey),
                                          ),
                                  ),

                                  // Texto del producto
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          const Row(
                                            children: [
                                              Icon(Icons.location_on,
                                                  color: Color(0xFF1C9FE2)),
                                              Text(
                                                "Antofagasta",
                                                maxLines: 3,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF1C9FE2),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            cleanDescription(
                                                product.description),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          if (product.categories.isNotEmpty)
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons
                                                        .beach_access_rounded,
                                                    color: Colors.grey),
                                                Text(
                                                    "${product.categories.join(", ")}"),
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));                      
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      );
  }
}


/// 🔍 SearchDelegate personalizado
class ProductSearchDelegate extends SearchDelegate {
  final List<Product> products;

  ProductSearchDelegate(this.products);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = "",
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(child: Text("No se encontraron productos"));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          leading: product.image.isNotEmpty
              ? Image.network(product.image,
                  width: 40, height: 40, fit: BoxFit.cover)
              : const Icon(Icons.image_not_supported),
          title: Text(product.name),
          subtitle: Text(product.description),
          onTap: () {
            close(context, product);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return ListTile(
          title: Text(product.name),
          onTap: () {
            query = product.name;
            showResults(context);
          },
        );
      },
    );
  }
}

// 🔹 Widget para los chips de información (clima, radiación, viento)
/*Widget _buildInfoChip(String value, String label, Color color) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    ),
  );
}*/

Widget _buildInfoChip(String title, String subtitle, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      //color: color.withOpacity(0.2),
      color: Colors.grey.withOpacity(0.2),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const SizedBox(width: 6),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ],
    ),
    /*Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 3),
        Text(subtitle, style: const TextStyle(fontSize: 14)),
      ],
    ),*/
  );
}

Widget buildImageItem(String imageUrl) {
  return Container(
    width: 200,
    margin: const EdgeInsets.only(right: 16), // espacio entre imágenes
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12), // bordes redondeados
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    ),
  );
}
