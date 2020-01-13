# json_serialize

A new flutter package to generate code in dart .


# Example use  

Add  depencencies
````
  dependencies:
    json_serialize:
      git:
        url: git://github.com/DaniloCarSan/json_serialize.git
    build_runner: ^1.6.6
````
## Estructure to file extension .jsonser

- **MODEL_NAME** | REQUIRED
- **MODEL_NAME_FIELDS** | REQUIRED
- **ATRIBUTES_MAP** | REQUIRED
  - **TYPE** | NO REQUIRED | DEFAULT dynamic
  - **NAME** | REQUIRED
  - **VARNAME** | REQUIRED
  - **VALUE** | NO REQUIRED

````
{
  "MODEL_NAME":"modelName",
  "MODEL_NAME_FIELDS":"modelNameFields",
  "ATRIBUTES_MAP":[
    {
      "TYPE":"int",
      "NAME":"USER_CODE",
      "VARNAME":"userCode",
      "VALUE":1
    },
  ]
}
````



## Create file extension user.jsonser
````
{
  "MODEL_NAME":"UserModel",
  "MODEL_NAME_FIELDS":"UserModelFields",
  "ATRIBUTES_MAP":[
    {
      "TYPE":"int",
      "NAME":"USER_CODE",
      "VARNAME":"userCode"
    },
    {
      "TYPE":"String",
      "NAME":"USER_NAME",
      "VARNAME":"userName"
    },
    {
      "NAME":"USER_EMAIL",
      "VARNAME":"userEmail"
    },
    {
      "NAME":"USER_STATUS",
      "VARNAME":"userStatus",
      "VALUE":1
    }
  ]
}

````

Run command
````
 flutter packages pub run build_runner build
````

# Code generate user_model.dart
````

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
````

## Getting Started

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
