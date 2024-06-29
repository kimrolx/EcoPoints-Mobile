class SettingOption {
  final String iconPath;
  final String name;
  final Function() onTap;

  SettingOption({
    required this.iconPath,
    required this.onTap,
    required this.name,
  });
}
