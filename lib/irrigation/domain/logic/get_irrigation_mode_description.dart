String getIrrigationModeDescription(String irrigationType) {
  switch (irrigationType) {
    case 'automatic':
      return 'This irrigation mode is automated and will operate based on preset conditions.';
    case 'manual':
      return 'This irrigation mode requires manual activation by the user.';
    default:
      return 'Unknown irrigation mode';
  }
}