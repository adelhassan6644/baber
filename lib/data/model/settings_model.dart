class SettingsModel {
  int? id;
  String? iosUrl;
  String? androidUrl;
  String? version;
  String? versionIos;
  String? facebook;
  String? instagram;
  String? twitter;
  String? whats;
  String? snapchat;
  String? privacy;
  String? terms;
  String? about;
  String? contact;

  SettingsModel(
      {this.id,
        this.iosUrl,
        this.androidUrl,
        this.version,
        this.versionIos,
        this.facebook,
        this.instagram,
        this.twitter,
        this.whats,
        this.snapchat,
        this.privacy,
        this.terms,
        this.about,
        this.contact});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iosUrl = json['ios_url'];
    androidUrl = json['android_url'];
    version = json['version'];
    versionIos = json['version_ios'];
    facebook = json['fb'];
    instagram = json['ig'];
    twitter = json['tw'];
    whats = json['whts'];
    snapchat = json['sn'];
    privacy = json['privacy'];
    terms = json['terms'];
    about = json['about'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['ios_url'] = iosUrl;
    data['android_url'] = androidUrl;
    data['version'] = version;
    data['version_ios'] = versionIos;
    data['fb'] = facebook;
    data['ig'] = instagram;
    data['tw'] = twitter;
    data['whts'] = whats;
    data['sn'] = snapchat;
    data['privacy'] = privacy;
    data['terms'] = terms;
    data['about'] = about;
    data['contact'] = contact;
    return data;
  }
}
