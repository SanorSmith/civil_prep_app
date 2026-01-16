import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/household_profile_model.dart';

class OnboardingState {
  final String? postalCode;
  final HousingType? housingType;
  final HeatingType? heatingType;
  final int adultCount;
  final int childCount;
  final int infantCount;
  final bool allowAggregation;

  OnboardingState({
    this.postalCode,
    this.housingType,
    this.heatingType,
    this.adultCount = 1,
    this.childCount = 0,
    this.infantCount = 0,
    this.allowAggregation = false,
  });

  OnboardingState copyWith({
    String? postalCode,
    HousingType? housingType,
    HeatingType? heatingType,
    int? adultCount,
    int? childCount,
    int? infantCount,
    bool? allowAggregation,
  }) {
    return OnboardingState(
      postalCode: postalCode ?? this.postalCode,
      housingType: housingType ?? this.housingType,
      heatingType: heatingType ?? this.heatingType,
      adultCount: adultCount ?? this.adultCount,
      childCount: childCount ?? this.childCount,
      infantCount: infantCount ?? this.infantCount,
      allowAggregation: allowAggregation ?? this.allowAggregation,
    );
  }
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(OnboardingState());

  void setPostalCode(String postalCode) {
    state = state.copyWith(postalCode: postalCode);
  }

  void setHousingType(HousingType housingType) {
    state = state.copyWith(housingType: housingType);
  }

  void setHeatingType(HeatingType heatingType) {
    state = state.copyWith(heatingType: heatingType);
  }

  void setHouseholdSize({
    required int adults,
    required int children,
    required int infants,
  }) {
    state = state.copyWith(
      adultCount: adults,
      childCount: children,
      infantCount: infants,
    );
  }

  void setAllowAggregation(bool allow) {
    state = state.copyWith(allowAggregation: allow);
  }

  void reset() {
    state = OnboardingState();
  }
}

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier();
});
