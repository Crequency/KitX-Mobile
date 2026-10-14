/// Information about a third party dependency, shown on the about page.
class ThirdPartyData // implements Built<ThirdPartyData, ThirdPartyDataBuilder>
{
  /// Name of the third party package.
  String? thirdPartyName;

  /// Version of the third party package.
  String? thirdPartyVersion;

  /// Copyright notice of the third party package.
  String? thirdPartyCopyright;

  /// URL of the third party package.
  String? thirdPartyUrl;

  /// Repository URL of the third party package.
  String? thirdPartyRepo;

  /// Constructor
  ThirdPartyData(
    this.thirdPartyName,
    this.thirdPartyVersion,
    this.thirdPartyCopyright,
    this.thirdPartyUrl,
    this.thirdPartyRepo,
  );
}
