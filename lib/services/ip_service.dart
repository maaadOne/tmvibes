import 'package:dart_ipify/dart_ipify.dart';
import 'package:get/get.dart';

class IpService extends GetxService {
  final _isTurkmen = false.obs;
  final ipRanges = [
    ["217.174.224.0", "255.255.240.0"],
    ["95.85.96.0", "255.255.224.0"],
    ["119.235.112.0", "255.255.240.0"],
    ["216.250.8.0", "255.255.240.0"],
    ["103.220.0.0", "255.255.252.0"],
    ["177.93.143.0", "255.255.255.0"],
    // ["10.0.0.0", "255.0.0.0"],
    ["185.69.185.0", "255.255.255.0"],
    ["93.11.220.0", "255.255.252.0"],
    ["185.69.184.0", "255.255.254.0"],
    ["185.69.186.0", "255.255.255.0"],
    ["185.69.187.0", "255.255.255.0"],
    ["95.47.57.0", "255.255.255.0"],
  ];
  Future<IpService> init() async {
    final ipv4 = await Ipify.ipv4();
    for (var rangeIp in ipRanges) {
      if (checkIpInRange(ipv4, rangeIp)) {
        _isTurkmen.value = true;
        break;
      }
    }
    return this;
  }

  bool get isTurkmen => _isTurkmen.value;

  bool checkIpInRange(String ipToCheck, List<String> networkPrefix) {
    List<String> networkIp = networkPrefix[0].split('.');
    List<String> networkMask = networkPrefix[1].split('.');
    List<String> checkIpParts = ipToCheck.split('.');

    for (int i = 0; i < 4; i++) {
      int checkIpPart = int.parse(checkIpParts[i]);
      int networkIpPart = int.parse(networkIp[i]);
      int maskPart = int.parse(networkMask[i]);

      if (networkIpPart & maskPart != checkIpPart & maskPart) {
        return false;
      }
    }

    return true;
  }
}
