import 'package:example/src/db/db.dart';

import '../../config/get.platform.dart';
import '../frogbase.dart';

late Frogbase fb;

String get httpProtocol => appSettings.useSecureProtocol ? 'https' : 'http';
String get baseUrl => '$httpProtocol://${appSettings.baseUrl}';
String get apiBaseUrl => '$baseUrl/api';

const globalBaseUrl = 'dev.algoramming.com/frogbase';
const devBaseUrl = '103.113.227.244:4200';
final localBaseUrl = pt.isNotMobile ? '127.0.0.1:4200' : '10.0.2.2:42000';


