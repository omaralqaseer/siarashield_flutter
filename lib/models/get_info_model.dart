class GetInfoModel {
  GetInfoModel({
    // required this.HttpStatusCode,
    // required this.Message,
    // required this.data,
    // this.Captcha,
    // required this.HtmlFormate,
    // this.SecurityLevel,
    required this.RequestId,
    // required this.FpStatus,
    // this.VisiterLanguage,
    required this.VisiterId,
  });
  // late final int HttpStatusCode;
  // late final String Message;
  // late final Data data;
  // late final Null Captcha;
  // late final String HtmlFormate;
  // late final Null SecurityLevel;
  late final String RequestId;
  // late final String FpStatus;
  // late final Null VisiterLanguage;
  late final String VisiterId;

  GetInfoModel.fromJson(Map<String, dynamic> json){
    // HttpStatusCode = json['HttpStatusCode'];
    // Message = json['Message'];
    // data = Data.fromJson(json['data']);
    // Captcha = null;
    // HtmlFormate = json['HtmlFormate'];
    // SecurityLevel = null;
    RequestId = json['RequestId'];
    // FpStatus = json['FpStatus'];
    // VisiterLanguage = null;
    VisiterId = json['Visiter_Id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['HttpStatusCode'] = HttpStatusCode;
    // _data['Message'] = Message;
    // _data['data'] = data.toJson();
    // _data['Captcha'] = Captcha;
    // _data['HtmlFormate'] = HtmlFormate;
    // _data['SecurityLevel'] = SecurityLevel;
    _data['RequestId'] = RequestId;
    // _data['FpStatus'] = FpStatus;
    // _data['VisiterLanguage'] = VisiterLanguage;
    _data['Visiter_Id'] = VisiterId;
    return _data;
  }
}

class Data {
  Data();

  Data.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}