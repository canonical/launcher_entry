A wrapper around the Unity [LauncherAPI](https://wiki.ubuntu.com/Unity/LauncherAPI#Low_level_DBus_API:_com.canonical.Unity.LauncherEntry) that allows to show counter badges and progress bars on launcher icons in common linux desktop environments.

## Example application

### Test Setup

Adjust the `Exec` and `Icon` paths in the `example.desktop` file from the asset directory and copy it to an appropriate location, typically `~/.local/share/applications`.

Window:

![window](.github/assets/window.png)

Launcher icon:

![icon](.github/assets/icon.png)