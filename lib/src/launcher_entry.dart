import 'package:dbus/dbus.dart';

/// The service that provides access to the Launcher API.
class LauncherEntryService {
  /// Creates a service instance from a given [appUri] of the form
  /// `application://$desktop_file_id`.
  ///
  /// The [objectPath] defaults to
  /// ```dart
  /// '/com/canonical/unity/launcherentry/${_djbHash(appUri)}'
  /// ```
  /// to be in compliance with the default AppArmor profile.
  LauncherEntryService({required this.appUri, String? objectPath})
      : objectPath = objectPath ??
            '/com/canonical/unity/launcherentry/${_djbHash(appUri)}';
  // https://bazaar.launchpad.net/~unity-team/libunity/trunk/view/head:/src/unity-launcher.vala#L146
  final String appUri;
  final String objectPath;

  // https://theartincode.stanis.me/008-djb2/
  static int _djbHash(String s) {
    var hash = 5831;
    for (final r in s.runes) {
      hash = (hash << 5) + hash + r;
    }
    return hash;
  }

  Future<void> update({
    int? count,
    bool? countVisible,
    double? progress,
    bool? progressVisible,
    String? quicklist,
    bool? urgent,
  }) =>
      DBusClient.session().emitSignal(
        path: DBusObjectPath(objectPath),
        interface: 'com.canonical.Unity.LauncherEntry',
        name: 'Update',
        values: [
          DBusString(appUri),
          DBusDict(
            DBusSignature('s'),
            DBusSignature('v'),
            {
              if (count != null)
                const DBusString('count'): DBusVariant(DBusInt64(count)),
              if (countVisible != null)
                const DBusString('count-visible'):
                    DBusVariant(DBusBoolean(countVisible)),
              if (progress != null)
                const DBusString('progress'): DBusVariant(DBusDouble(progress)),
              if (progressVisible != null)
                const DBusString('progress-visible'):
                    DBusVariant(DBusBoolean(progressVisible)),
              if (quicklist != null)
                const DBusString('quicklist'):
                    DBusVariant(DBusString(quicklist)),
              if (urgent != null)
                const DBusString('urgent'): DBusVariant(DBusBoolean(urgent)),
            },
          )
        ],
      );
}
