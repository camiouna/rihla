import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tp3/models/reservation.dart';
import '../config/api_config.dart';
import '../models/destination.dart';
class ApiService {
  static Uri _url(String chemin)=> Uri.parse('${ApiConfig.baseUrl}$chemin');
  static Future<List<Destination>> getDestinations() async{
    final response = await http.get(_url('/destinations')).timeout(ApiConfig.timeout);
    if(response.statusCode!=200){
      throw Exception("Erreur de la recuperation");
    }
    final List<dynamic> liste= jsonDecode(utf8.decode(response.bodyBytes));
    return liste.map((json)=>Destination.fromJson(json)).toList();
  }
  static Future<String> careerReservation(Reservation reservation) async{
    final reponse = await http.post(_url('/reservations'),headers: {'Content-Type':'application/json'},
    body: jsonEncode(reservation.toJson())
    ).timeout(ApiConfig.timeout);
    if(reponse.statusCode!=201){
      throw Exception("erreur d'envoie");
    }
    final Map<String,dynamic> cree=jsonDecode(utf8.decode(reponse.bodyBytes));
    return cree['id'].toString();
  }
}