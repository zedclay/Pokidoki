import '../models/linked_device.dart';
import '../models/security_event.dart';
import '../models/storage_usage.dart';
import '../repositories/security_repository.dart';
import 'mock_sample_data.dart';

class MockSecurityRepository implements SecurityRepository {
  const MockSecurityRepository();

  @override
  Future<List<LinkedDevice>> getLinkedDevices() async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return MockSampleData.linkedDevices;
  }

  @override
  Future<List<SecurityEvent>> getSecurityEvents() async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return MockSampleData.securityEvents;
  }

  @override
  Future<StorageUsage> getStorageUsage() async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return MockSampleData.storageUsage;
  }
}
