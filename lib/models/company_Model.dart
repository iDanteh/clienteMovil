class Company {
  final int? id;
  final int? user_id;
  final String company_name;
  final String company_description;
  final String address;

  Company({
    this.id,
    this.user_id,
    required this.company_name,
    required this.company_description,
    required this.address
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: int.tryParse(json['id'].toString()) ?? 0,
      user_id: int.tryParse(json['user_id'].toString()) ?? 0,
      company_name: json['company_name'],
      company_description: json['company_description'], 
      address: json['address']
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'company_name': company_name,
      'company_description': company_description,
      'address': address 
    };
  }
}