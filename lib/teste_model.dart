class UserModelFields{
  static String tableName = "UserModelFields";
  static String userCode = "USER_CODE";
  static String userName = "USER_NAME";
  static String userEmail = "USER_EMAIL";
  static String userStatus = "USER_STATUS";
}

class UserModel {
  int index;
  int userCode; 
  String userName; 
  dynamic userEmail; 
  dynamic userStatus = 1;

  UserModel({
    this.index,
    this.userCode,
    this.userName,
    this.userEmail,
    this.userStatus
  });

  UserModel.fromJson(Map<String,dynamic>json):
    this.userCode = json[UserModelFields.userCode],
    this.userName = json[UserModelFields.userName],
    this.userEmail = json[UserModelFields.userEmail],
    this.userStatus = json[UserModelFields.userStatus];
  
  Map<String,dynamic>toJson({List<dynamic> getKeys , List<dynamic>  notKeys }){

    Map<String,dynamic> map = {
      UserModelFields.userCode: this.userCode,
      UserModelFields.userName: this.userName,
      UserModelFields.userEmail: this.userEmail,
      UserModelFields.userStatus: this.userStatus    
    }; 

    if(getKeys != null )
    { 
      map.removeWhere((k,v)=> ! getKeys.contains(k)); 
    }
 
    if(notKeys  != null ) 
    { 
      map.removeWhere((k,v)=> notKeys.contains(k)); 
    } 

    return map;
  }

  List<dynamic> toList()=>[
    this.index,
    this.userCode,
    this.userName,
    this.userEmail,
    this.userStatus
  ];

  setIndex(int index){
    this.index = index;
  }
  setUserCode( int userCode){
    this.userCode = userCode; 
  }

  setUserName( String userName){
    this.userName = userName; 
  }

  setUserEmail( dynamic userEmail){
    this.userEmail = userEmail; 
  }

  setUserStatus( dynamic userStatus){
    this.userStatus = userStatus; 
  }  
 }