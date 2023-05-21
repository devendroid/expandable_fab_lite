# Expandable FAB

[![pub](https://img.shields.io/pub/v/expandable_fab_lite?logo=dart)](https://pub.dev/packages/expandable_fab_lite)
![](https://badges.fyi/github/latest-tag/devendroid/expandable_fab_lite)
![](https://badges.fyi/github/stars/devendroid/expandable_fab_lite)
![](https://badges.fyi/github/license/devendroid/expandable_fab_lite)

A highly customizable Simple Expandable FAB widget for Flutter, that can show/hide multiple action buttons with animation in center arc direction.

## Preview

![ExpandableFAB](/assets/efab-preview.gif)

## Instalation

* Add the latest version of the package to your pubspec.yaml file in the dependency section.

```yaml
  dependencies:
    flutter:
      sdk: flutter

    expandable_fab_lite: ^0.0.1
```
Run this in your terminal or click on `pub get`

```sh
$ flutter pub get
```

## How to use

Simple example for the usage of the package is shown below.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(...),
    body: Center(...),
    bottomNavigationBar: BottomNavigationBar(...),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: ExpandableFab(
      fabMargin: 8,
      children: [
        ActionButton(
            icon: const Icon(Icons.message),
            onPressed: (){ }),
        ActionButton(icon: const Icon(Icons.call),
            onPressed: (){ }),
        ActionButton(icon: const Icon(Icons.email),
            onPressed: (){ })
      ],
    ),
  );
}
```
## Properties

### **```ExpandableFab```**

| Property |Description| Default |
| --- | ---- | --- |
| icon | Set icon for the FAB | Icons.add |
| color | Set color for the FAB | Colors.blue |
| fabSize | Set size for the FAB | 56 |
| fabMargin | Give margin for the FAB | 0 |
| fabElevation | Set elevation for the FAB | 4 |
| actionButtonSize | Set size for the Action Buttons | 48 |
| actionButtonElevation | Set elevation for the Action Buttons | 4 |
| controller | Set controller to controll programatically |  |

### **```ActionButton```**

| Property |Description| Default |
| --- | ---- | --- |
| icon | Set icon for the ActionButton |  |
| color | Set color for the ActionButton | Colors.black87 |
| onPressed | Listener for ActionButton click |  |