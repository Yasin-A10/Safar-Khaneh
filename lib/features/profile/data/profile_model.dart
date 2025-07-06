class ProfileModel {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final int walletBalance;

  ProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.walletBalance,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      walletBalance: json['wallet_balance'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'wallet_balance': walletBalance,
    };
  }
}
