import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:servicios_apis/utils/url.dart';
import 'package:servicios_apis/models/company_Model.dart';

class CompanyService {

  Future<http.Response> createCompany(Company company) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token != null){
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/companies'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'company_name': company.company_name,
          'company_description': company.company_description,
          'address': company.address
        }),
      );

      return response;
    } else{
      throw Exception('Token not found');
    }
  }

  Future<void> updateCompany(Company company) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token != null){
      final response = await http.put(
        Uri.parse('${Constants.baseUrl}/companies/${company.id}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'company_name': company.company_name,
          'company_description': company.company_description,
          'address': company.address
        }),
      );

      if(response.statusCode != 200){
        print('Error al actualizar compañia: ${response.body}');
        throw Exception('Failed to update company: ');
      }
    } else{
      throw Exception('Token not found');
    }
  }
}