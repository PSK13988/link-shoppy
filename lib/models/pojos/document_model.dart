class Document {
  int registrationNo;
  String barcode;
  String boxNumber;
  int projectId;
  String folder;
  String senderId;
  String client;
  int postItemTypeID;
  String section;
  int itemSTypeId;
  String subSection;
  String receivedDate;
  String itemDate;
  String description;
  String path;
  String notes;
  String stickyNotes;
  String category;
  String attach;
  String type;
  String version;
  String viewProjectMail;
  String strconf;
  String link;
  String isApproved;
  String docDirection;
  String receivedBy;
  String forwardonactionid;
  String categoryColor;
  String sectionColor;
  String comments;
  String commentBy;
  String commentDate;
  String vDesc;
  String vPath;
  int vNo;
  String guid;
  int sNo;
  String message;

  Document(
      {this.registrationNo,
      this.barcode,
      this.boxNumber,
      this.projectId,
      this.folder,
      this.senderId,
      this.client,
      this.postItemTypeID,
      this.section,
      this.itemSTypeId,
      this.subSection,
      this.receivedDate,
      this.itemDate,
      this.description,
      this.path,
      this.notes,
      this.stickyNotes,
      this.category,
      this.attach,
      this.type,
      this.version,
      this.viewProjectMail,
      this.strconf,
      this.link,
      this.isApproved,
      this.docDirection,
      this.receivedBy,
      this.forwardonactionid,
      this.categoryColor,
      this.sectionColor,
      this.comments,
      this.commentBy,
      this.commentDate,
      this.vDesc,
      this.vPath,
      this.vNo,
      this.guid,
      this.sNo,
      this.message});

  factory Document.fromJson(dynamic json) {
    return Document(
        registrationNo: (json['Registration No.'] != null
            ? json['Registration No.']
            : 0) as int,
        barcode: (json['Barcode'] != null ? json['Barcode'] : '') as String,
        boxNumber: json['BoxNumber'] as String,
        projectId: json['ProjectId'] as int,
        folder: (json['Folder'] != null
            ? json['Folder']
            : json['FolderName'] != null ? json['FolderName'] : '') as String,
        senderId: json['SenderId'] as String,
        client: (json['Client'] != null ? json['Client'] : '') as String,
        postItemTypeID: json['PostItemTypeID'] as int,
        section: json['Section'] as String,
        itemSTypeId: json['ItemSTypeId'] as int,
        subSection: json['SubSection'] as String,
        receivedDate: json['Received Date'] as String,
        itemDate: json['Item Date'] as String,
        description: json['Description'] as String,
        path: json['Path'] as String,
        notes: json['Notes'] as String,
        stickyNotes: json['StickyNotes'] as String,
        category: json['Category'] as String,
        attach: json['Attach'] as String,
        type: json['Type'] as String,
        version: json['Version'] as String,
        viewProjectMail: json['ViewProjectMail'] as String,
        strconf: json['strconf'] as String,
        link: json['Link'] as String,
        isApproved: json['IsApproved'] as String,
        docDirection: json['DocDirection'] as String,
        receivedBy: json['ReceivedBy'] as String,
        forwardonactionid: json['forwardonactionid'] as String,
        categoryColor: json['CategoryColor'] as String,
        sectionColor: json['SectionColor'] as String,
        comments: json['Comments'] as String,
        commentBy: json['CommentBy'] as String,
        commentDate: json['CommentDate'] as String,
        vDesc: json['VDesc'] as String,
        vPath: json['VPath'] as String,
        vNo: json['VNo'] as int,
        guid: (json['Guid'] != null
            ? json['Guid']
            : json['GUID'] != null ? json['GUID'] : '') as String,
        sNo: json['S.No.'] as int,
        message: json['Message'] as String);
  }
}
