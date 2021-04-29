class UserFolderInfo {
  int projectId;
  String folder;
  int recordCount;

  UserFolderInfo({this.projectId, this.folder, this.recordCount});

  factory UserFolderInfo.fromJson(dynamic json) {
    return UserFolderInfo(
        projectId: (json['ProjectID'] != null
            ? json['ProjectID']
            : json['ProjectId'] != null
                ? json['ProjectId']
                : json['FolderID'] != null ? json['FolderID'] : 0) as int,
        folder: (json['Folder'] != null
            ? json['Folder']
            : json['ProjectName'] != null ? json['ProjectName'] : '') as String,
        recordCount: (json['RecordsCount'] != null
            ? json['RecordsCount']
            : json['total'] != null ? json['total'] : 0) as int);
  }
}
