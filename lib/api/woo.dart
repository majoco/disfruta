import 'dart:convert';
import 'package:disfruta/product.dart';
import 'package:disfruta/category.dart';
import 'package:disfruta/category.dart';
import 'package:http/http.dart' as http;

class WooService {
  /*final String baseUrl = "https://sitio1.unbcorp.cl/wp1/wp-json/wc/v3";
  final String consumerKey = "ck_fd84bbdd259689819a74f8eaa5db4b6546036669";
  final String consumerSecret = "cs_c09c378f80b28e6d191781bc2fa0acbba1bf4fc6";*/

  ///products?consumer_key=&consumer_secret=

  final String baseUrl = "https://sitio1.unbcorp.cl/wp4/wp-json/wc/v3";
  final String consumerKey = "ck_89c087d4ad802d9ba2815f9eed9408238446bb05";
  final String consumerSecret = "cs_a95f474134f2dbf5cd96a53bf247e55666282cb3";

  Future<List<Product>> getProducts() async {
    /*final url = Uri.parse(
        "$baseUrl/products?consumer_key=$consumerKey&consumer_secret=$consumerSecret");*/
    
    //final url = Uri.parse("https://sitio1.unbcorp.cl/wp4/wp-json/wc/v3/products?consumer_key=ck_89c087d4ad802d9ba2815f9eed9408238446bb05&consumer_secret=cs_a95f474134f2dbf5cd96a53bf247e55666282cb3");
    final uri = Uri.https(
      'sitio1.unbcorp.cl',
      '/wp4/wp-json/wc/v3/products',
      {
        'consumer_key': 'ck_89c087d4ad802d9ba2815f9eed9408238446bb05',
        'consumer_secret': 'cs_a95f474134f2dbf5cd96a53bf247e55666282cb3'
      },
    );
        

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception("Error al cargar productos");
    }

    /*try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        //print('Productos: ${jsonDecode(response.body)}');
        List data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        //print('Error: ${response.statusCode}');
        throw Exception("Error al cargar productos");
      }
    } catch (e) {
      //print('Excepción: $e');
    }*/
  }

  Future<List<Category>> getCategories() async {
    final response = await http.get(
      Uri.parse("$baseUrl/products/categories?per_page=20&consumer_key=$consumerKey&consumer_secret=$consumerSecret"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar categorías");
    }
  }

  Future<List<Product>> getProductsByCategory(int categoryId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/products?category=$categoryId&per_page=20&consumer_key=$consumerKey&consumer_secret=$consumerSecret"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar productos");
    }
  }
}

/*
const dominio = "https://sitio1.unbcorp.cl/wp1/wp-json/wc/v3/";
const products = "products";
const categories = "category";
const ck = "consumer_key=ck_fd84bbdd259689819a74f8eaa5db4b6546036669";
const cs = "consumer_secret=cs_c09c378f80b28e6d191781bc2fa0acbba1bf4fc6";

const listaProductos = "$dominio$products?$ck&$cs";
const listaCategorias = "$dominio$categories?$ck&$cs";

Future<List<dynamic>> productos() async {
  const url = listaProductos;
  final response = await http.get(url as Uri, headers: {"Accept": "application/json"});
  var jsonConvert = jsonDecode(response.body);
  return jsonConvert;
}*/
