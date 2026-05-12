class RegisterCompanyBody {

  final String companyName;
  final String companyType;
  final String registrationNumber;
  final String gstNumber;
  final String companyEmail;
  final String phoneNumber;
  final String streetAddress;
  final String city;
  final String state;
  final String pincode;
  final String adminName;
  final String adminEmail;
  final String password;
  final String passwordConfirmation;

  RegisterCompanyBody({
    required this.companyName,
    required this.companyType,
    required this.registrationNumber,
    required this.gstNumber,
    required this.companyEmail,
    required this.phoneNumber,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.pincode,
    required this.adminName,
    required this.adminEmail,
    required this.password,
    required this.passwordConfirmation,
  });
}