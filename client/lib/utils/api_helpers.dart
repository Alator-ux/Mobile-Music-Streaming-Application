import 'package:client/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

String fixUrl(String? url, String pcIp) {
  if (url == null) return "";
  return url.replaceFirst("localhost:9000", pcIp);
}

String getLocalizedError(String serverDetail, BuildContext context) {
  final l10n = context.l10n;

  switch (serverDetail) {
    case "Email already registered":
      return l10n.error_email_already_registered;
    case "Incorrect email or password":
      return l10n.error_incorrect_credentials;
    case "Could not validate credentials":
    case "In token no sub!":
      return l10n.error_invalid_token;
    case "Database connection failed":
      return l10n.error_db_connection;
    default:
      return l10n.error_unknown;
  }
}
