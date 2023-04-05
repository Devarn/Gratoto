// ignore_for_file: deprecated_member_use_from_same_package

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$IosDeviceInfo', () {
    group('fromMap | toMap', () {
      const iosUtsnameMap = <String, dynamic>{
        'release': 'release',
        'version': 'version',
        'machine': 'machine',
        'sysname': 'sysname',
        'nodename': 'nodename',
      };
      const iosDeviceInfoMap = <String, dynamic>{
        'name': 'name',
        'model': 'model',
        'utsname': iosUtsnameMap,
        'systemName': 'systemName',
        'isPhysicalDevice': 'true',
        'systemVersion': 'systemVersion',
        'localizedModel': 'localizedModel',
        'identifierForVendor': 'identifierForVendor',
      };

      test('fromMap should return $IosDeviceInfo with correct values', () {
        final iosDeviceInfo = IosDeviceInfo.fromMap(iosDeviceInfoMap);

        expect(iosDeviceInfo.name, 'name');
        expect(iosDeviceInfo.model, 'model');
        expect(iosDeviceInfo.isPhysicalDevice, isTrue);
        expect(iosDeviceInfo.systemName, 'systemName');
        expect(iosDeviceInfo.systemVersion, 'systemVersion');
        expect(iosDeviceInfo.localizedModel, 'localizedModel');
        expect(iosDeviceInfo.utsname.release, 'release');
        expect(iosDeviceInfo.utsname.version, 'version');
        expect(iosDeviceInfo.utsname.machine, 'machine');
        expect(iosDeviceInfo.utsname.sysname, 'sysname');
        expect(iosDeviceInfo.utsname.nodename, 'nodename');
      });

      test('toMap should return map with correct key and map', () {
        final iosDeviceInfo = IosDeviceInfo.fromMap(iosDeviceInfoMap);
        expect(iosDeviceInfo.data, iosDeviceInfoMap);
      });
    });
  });
}
