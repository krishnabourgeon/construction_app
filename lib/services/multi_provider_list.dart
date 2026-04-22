import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';
import 'package:construction_app/provider/login_provider.dart';
import 'package:construction_app/provider/company_provider.dart';

class MultiProviderList {
  static List<SingleChildWidget> providerList = [
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => CompanyProvider())
  ];
}
