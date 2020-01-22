import 'package:sql_build_database/sql_build_database.dart';

class UserModelFields{
  static String tableName = "UserModelFields";
  static String primaryKeyName = "USER_CODE";
  static String userName = "USER_NAME";
  static String userEmail = "USER_EMAIL";
}

class UserModel {
  int index;
  String userName = "234567890";
  String userEmail; 

  UserModel({
    this.index,
    this.userName,
    this.userEmail
  });

  UserModel.fromJson(Map<String,dynamic>json):
    this.userName = json[UserModelFields.userName],
    this.userEmail = json[UserModelFields.userEmail];
  
  Map<String,dynamic>toJson({List<dynamic> getKeys , List<dynamic>  notKeys , isNull = false , notNull = false }){

    Map<String,dynamic> map = {
      UserModelFields.userName: this.userName,
      UserModelFields.userEmail: this.userEmail    
    }; 

    if(getKeys != null )
    { 
      map.removeWhere((k,v)=> ! getKeys.contains(k)); 
    }
 
    if(notKeys  != null ) 
    { 
      map.removeWhere((k,v)=> notKeys.contains(k)); 
    } 

    if(isNull) 
    { 
      map.removeWhere((k,v)=> v != null); 
    } 

    if(notNull) 
    { 
      map.removeWhere((k,v)=> v == null); 
    } 

    return map;
  }

  List<dynamic> toList()=>[
    this.index,
    this.userName,
    this.userEmail
  ];

  setIndex(int index){
    this.index = index;
  }
  setUserName( String userName){
    this.userName = userName; 
  }

  setUserEmail( String userEmail){
    this.userEmail = userEmail; 
  }  

  SBDTable buildTable() => SBDTable(
    name:UserModelFields.tableName,
    primaryKeyName:UserModelFields.primaryKeyName,
    columns:[
      SBDColumn(
        name:UserModelFields.userName,
        type:SBDColumnDataType.TEXT,
        isUnique:true,
        isNotNull:true,
        defaultValue:234567890,
        isPrimaryKey:true,
        foreignKey:['232','343'],
    ),
     SBDColumn(
        name:UserModelFields.userEmail,
        type:SBDColumnDataType.TEXT,
        isNotNull:true,
        )          
    ]
  );
}