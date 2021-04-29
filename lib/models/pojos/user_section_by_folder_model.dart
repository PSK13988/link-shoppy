class UserSectionByFolder {
  int folderId;
  int projectId;
  String clientId;
  String client;
  String sectionId;
  String section;
  int recordsCount;
  String sectionColor;

  UserSectionByFolder(
      {this.folderId,
      this.projectId,
      this.clientId,
      this.client,
      this.sectionId,
      this.section,
      this.recordsCount,
      this.sectionColor});

  factory UserSectionByFolder.fromJson(dynamic json) {
    return UserSectionByFolder(
      folderId: json['FolderID'] as int,
      projectId: json['ProjectID'] as int,
      clientId: json['ClientID'] as String,
      client: json['Client'] as String,
      sectionId: json['SectionID'] as String,
      section: json['Section'] as String,
      recordsCount: json['RecordsCount'] as int,
      sectionColor: json['SectionColor'] as String,
    );
  }
}
