import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/mock/mock_sample_data.dart';
import '../../../../data/models/linked_device.dart';
import '../../../../data/models/security_event.dart';
import '../../../../data/models/storage_usage.dart';
import '../../../authentication/presentation/controllers/auth_flow_controller.dart';

class SettingsState {
  const SettingsState({
    required this.devices,
    required this.events,
    required this.storage,
    required this.securityPreferences,
    this.isLoadingDevices = false,
    this.isLoadingEvents = false,
    this.isLoadingStorage = false,
    this.devicesError = false,
    this.eventsError = false,
    this.storageError = false,
    this.readReceiptsEnabled = true,
    this.typingIndicatorsEnabled = true,
    this.messageNotificationsEnabled = true,
    this.notificationPreviewsEnabled = true,
    this.vibrationEnabled = true,
    this.eventFilter = SecurityEventFilter.all,
  });

  final List<LinkedDevice> devices;
  final List<SecurityEvent> events;
  final StorageUsage storage;
  final AppSecurityPreferences securityPreferences;
  final bool isLoadingDevices;
  final bool isLoadingEvents;
  final bool isLoadingStorage;
  final bool devicesError;
  final bool eventsError;
  final bool storageError;
  final bool readReceiptsEnabled;
  final bool typingIndicatorsEnabled;
  final bool messageNotificationsEnabled;
  final bool notificationPreviewsEnabled;
  final bool vibrationEnabled;
  final SecurityEventFilter eventFilter;

  List<LinkedDevice> get otherDevices =>
      devices.where((d) => !d.isCurrentDevice).toList();

  LinkedDevice? get currentDevice {
    for (final device in devices) {
      if (device.isCurrentDevice) {
        return device;
      }
    }
    return null;
  }

  int get activeDeviceCount => devices.length;

  List<SecurityEvent> get filteredEvents {
    return events.where((event) {
      return switch (eventFilter) {
        SecurityEventFilter.all => true,
        SecurityEventFilter.devices =>
          event.type == SecurityEventType.deviceLinked ||
              event.type == SecurityEventType.deviceRemoved ||
              event.type == SecurityEventType.otherDevicesSignedOut,
        SecurityEventFilter.identity =>
          event.type == SecurityEventType.verificationCompleted ||
              event.type == SecurityEventType.emailVerified ||
              event.type == SecurityEventType.emailChangeRequested ||
              event.type == SecurityEventType.emailChanged ||
              event.type == SecurityEventType.passwordChanged ||
              event.type == SecurityEventType.passwordReset ||
              event.type == SecurityEventType.recoveryStarted ||
              event.type == SecurityEventType.recoveryCompleted ||
              event.type == SecurityEventType.reportSubmitted,
        SecurityEventFilter.signIn =>
          event.type == SecurityEventType.signIn ||
              event.type == SecurityEventType.appLockChanged ||
              event.type == SecurityEventType.screenPrivacyEnabled,
      };
    }).toList();
  }

  SecurityEvent? eventById(String id) {
    for (final event in events) {
      if (event.id == id) {
        return event;
      }
    }
    return null;
  }

  SettingsState copyWith({
    List<LinkedDevice>? devices,
    List<SecurityEvent>? events,
    StorageUsage? storage,
    AppSecurityPreferences? securityPreferences,
    bool? isLoadingDevices,
    bool? isLoadingEvents,
    bool? isLoadingStorage,
    bool? devicesError,
    bool? eventsError,
    bool? storageError,
    bool? readReceiptsEnabled,
    bool? typingIndicatorsEnabled,
    bool? messageNotificationsEnabled,
    bool? notificationPreviewsEnabled,
    bool? vibrationEnabled,
    SecurityEventFilter? eventFilter,
  }) {
    return SettingsState(
      devices: devices ?? this.devices,
      events: events ?? this.events,
      storage: storage ?? this.storage,
      securityPreferences: securityPreferences ?? this.securityPreferences,
      isLoadingDevices: isLoadingDevices ?? this.isLoadingDevices,
      isLoadingEvents: isLoadingEvents ?? this.isLoadingEvents,
      isLoadingStorage: isLoadingStorage ?? this.isLoadingStorage,
      devicesError: devicesError ?? this.devicesError,
      eventsError: eventsError ?? this.eventsError,
      storageError: storageError ?? this.storageError,
      readReceiptsEnabled: readReceiptsEnabled ?? this.readReceiptsEnabled,
      typingIndicatorsEnabled:
          typingIndicatorsEnabled ?? this.typingIndicatorsEnabled,
      messageNotificationsEnabled:
          messageNotificationsEnabled ?? this.messageNotificationsEnabled,
      notificationPreviewsEnabled:
          notificationPreviewsEnabled ?? this.notificationPreviewsEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      eventFilter: eventFilter ?? this.eventFilter,
    );
  }
}

class SettingsController extends StateNotifier<SettingsState> {
  SettingsController(this._ref)
    : super(
        SettingsState(
          devices: List.of(MockSampleData.linkedDevices),
          events: List.of(MockSampleData.securityEvents),
          storage: MockSampleData.storageUsage,
          securityPreferences: AppSecurityPreferences(
            appLockEnabled: true,
            biometricsEnabled: _ref.read(authFlowProvider).biometricsEnabled,
            lockDelay: AppLockDelay.oneMinute,
            hideContentInAppSwitcher: true,
          ),
        ),
      );

  final Ref _ref;
  int _eventCounter = 0;

  Future<void> loadDevices() async {
    state = state.copyWith(isLoadingDevices: true, devicesError: false);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    state = state.copyWith(isLoadingDevices: false);
  }

  Future<void> loadEvents() async {
    state = state.copyWith(isLoadingEvents: true, eventsError: false);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    state = state.copyWith(isLoadingEvents: false);
  }

  Future<void> loadStorage() async {
    state = state.copyWith(isLoadingStorage: true, storageError: false);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    state = state.copyWith(isLoadingStorage: false);
  }

  void setEventFilter(SecurityEventFilter filter) {
    state = state.copyWith(eventFilter: filter);
  }

  void updateSecurityPreferences(AppSecurityPreferences preferences) {
    state = state.copyWith(securityPreferences: preferences);
    _ref
        .read(authFlowProvider.notifier)
        .setBiometricsEnabled(preferences.biometricsEnabled);
  }

  void setReadReceipts(bool value) {
    state = state.copyWith(readReceiptsEnabled: value);
  }

  void setTypingIndicators(bool value) {
    state = state.copyWith(typingIndicatorsEnabled: value);
  }

  void setMessageNotifications(bool value) {
    state = state.copyWith(messageNotificationsEnabled: value);
  }

  void setNotificationPreviews(bool value) {
    state = state.copyWith(notificationPreviewsEnabled: value);
  }

  void setVibration(bool value) {
    state = state.copyWith(vibrationEnabled: value);
  }

  Future<void> removeDevice(String deviceId) async {
    LinkedDevice? removed;
    for (final device in state.devices) {
      if (device.id == deviceId) {
        removed = device;
        break;
      }
    }
    if (removed == null || removed.isCurrentDevice) {
      return;
    }

    final devices = state.devices
        .where((device) => device.id != deviceId)
        .toList();
    final event = SecurityEvent(
      id: 'sec-removed-${_eventCounter++}',
      type: SecurityEventType.deviceRemoved,
      occurredAt: DateTime.now().toUtc(),
      title: 'Device removed',
      summary: '${removed.name} was signed out from your account',
      deviceLabel: removed.name,
    );
    state = state.copyWith(devices: devices, events: [event, ...state.events]);
  }

  Future<void> clearCache() async {
    final previous = state.storage;
    final cleared = previous.copyWith(
      cacheBytes: 0,
      totalBytes: previous.totalBytes - previous.cacheBytes,
    );
    state = state.copyWith(storage: cleared);
  }

  void addSecurityEvent(SecurityEvent event) {
    state = state.copyWith(events: [event, ...state.events]);
  }

  /// Removes all non-current devices and records a privacy-safe activity event.
  void signOutOtherDevices({String summary = 'Other devices were signed out'}) {
    final remaining = state.devices
        .where((device) => device.isCurrentDevice)
        .toList();
    if (remaining.length == state.devices.length) {
      return;
    }
    final event = SecurityEvent(
      id: 'sec-devices-out-${_eventCounter++}',
      type: SecurityEventType.otherDevicesSignedOut,
      occurredAt: DateTime.now().toUtc(),
      title: 'Other devices signed out',
      summary: summary,
    );
    state = state.copyWith(
      devices: remaining,
      events: [event, ...state.events],
    );
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
      return SettingsController(ref);
    });
