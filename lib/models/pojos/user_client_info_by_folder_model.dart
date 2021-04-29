class UserClientInfoByFolder {
  int folderId;
  String clientId;
  String client;
  int recordCount;

  UserClientInfoByFolder(
      {this.folderId, this.clientId, this.client, this.recordCount});

  factory UserClientInfoByFolder.fromJson(dynamic json) {
    return UserClientInfoByFolder(
        folderId: json['FolderID'] as int,
        clientId: json['ClientID'] as String,
        client: json['Client'] as String,
        recordCount: json['RecordsCount'] as int);
  }
}
