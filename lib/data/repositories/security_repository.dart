import '../models/linked_device.dart';
import '../models/security_event.dart';
import '../models/storage_usage.dart';

abstract interface class SecurityRepository {
  Future<List<LinkedDevice>> getLinkedDevices();
  Future<List<SecurityEvent>> getSecurityEvents();
  Future<StorageUsage> getStorageUsage();
}
