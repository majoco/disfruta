import 'package:flutter/material.dart';
import 'product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  String cleanDescription(String description) {
    return description
        .replaceAll("<p>", "")
        .replaceAll("</p>", "")
        .replaceAll("<br>", "\n");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(product.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 🔙 vuelve a ProductPage
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),            
            const SizedBox(height: 6),
            if (product.categories.isNotEmpty)
              Text(
                  "${product.categories.join(", ")}"),
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
              cleanDescription(product.description),
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            
            Text(
              "Galeria",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            // Imagen principal
            if (product.image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.image,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
              ),
            const SizedBox(height: 16),                    

            // Descripción
            
          ],
        ),
      ),
    );
  }
}
