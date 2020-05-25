// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "islandName" : MessageLookupByLibrary.simpleMessage("Island Name"),
    "loginPageExistingUser" : MessageLookupByLibrary.simpleMessage("Existing user?"),
    "loginPageLogin" : MessageLookupByLibrary.simpleMessage("Login"),
    "loginPageLoginErrorTitle" : MessageLookupByLibrary.simpleMessage("Login fail"),
    "loginPagePinCode" : MessageLookupByLibrary.simpleMessage("Pin code for previous account"),
    "loginPagePinCodeHelpMessage" : MessageLookupByLibrary.simpleMessage("Pin code is 6 character code to identify your account, you can find this code in profile page from logged in device"),
    "loginPageTitle" : MessageLookupByLibrary.simpleMessage("Welcome"),
    "pageFriends" : MessageLookupByLibrary.simpleMessage("Friends"),
    "pageProfile" : MessageLookupByLibrary.simpleMessage("Profile"),
    "pageTurnip" : MessageLookupByLibrary.simpleMessage("Turnip"),
    "playerName" : MessageLookupByLibrary.simpleMessage("Player Name"),
    "profileLogout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "profilePinCodeDescription" : MessageLookupByLibrary.simpleMessage("Pin code is a unique identifier associate with your account, you need to use this code if you want to login on other device / reinstall this app"),
    "textFieldValidationEmpty" : MessageLookupByLibrary.simpleMessage("Cannot be blank"),
    "turnipPurchasePrice" : MessageLookupByLibrary.simpleMessage("Purchase Price")
  };
}
