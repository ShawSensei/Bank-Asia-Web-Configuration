import 'package:flutter_web/util/utility_variables.dart';

import 'text_constants.dart';


class HeaderData {
  static final Map<String, String> headerPublic = {
    'content-type': TextConstants.json,
    'accept': TextConstants.json,
    'access-auth-request-header': TextConstants.accessAuthRequestHeader,
    'device-id': UtilityVariables.imei.value,
    'access-type': TextConstants.accessPublic,
  };

  static final Map<String, String> headerPrivate = {
    'authorization': UtilityVariables.token.value,
    'content-type': TextConstants.json,
    'accept': TextConstants.json,
    'access-auth-request-header': TextConstants.accessAuthRequestHeader,
    'device-id': UtilityVariables.imei.value,
    'access-type': TextConstants.accessPrivate,
  };
}
