import 'package:dbus/dbus.dart';

class LauncherEntryService {
  LauncherEntryService(this._appUri, this._objectPath);
  final String _appUri;
  final String _objectPath;

  Future<void> update({
    int? count,
    bool? countVisible,
    double? progress,
    bool? progressVisible,
    String? quicklist,
    bool? urgent,
  }) =>
      DBusClient.session().emitSignal(
        path: DBusObjectPath(_objectPath),
        interface: 'com.canonical.Unity.LauncherEntry',
        name: 'Update',
        values: [
          DBusString(_appUri),
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
