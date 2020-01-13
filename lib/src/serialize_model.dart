class SerializeModelAtributeFields {
  static String type = "TYPE";
  static String name = "NAME";
  static String varname = "VARNAME";
  static String value = "VALUE";
  static String setter = "SETTER";
  static String getter = "GETTER";
}

class SerializeModelAtribute{
  String type;
  String name;
  String varname;
  dynamic value;
  bool setter;
  bool getter;


  SerializeModelAtribute({this.type, this.name, this.varname, this.value, this.setter = false, this.getter = false});

  SerializeModelAtribute.fromJson(Map<String,dynamic> json):
    this.type = json[SerializeModelAtributeFields.type], 
    this.name = json[SerializeModelAtributeFields.name], 
    this.varname = json[SerializeModelAtributeFields.varname], 
    this.value = json[SerializeModelAtributeFields.value], 
    this.setter = json[SerializeModelAtributeFields.setter],
    this.getter = json[SerializeModelAtributeFields.getter];

  Map<String,dynamic> toJson()=>{
    SerializeModelAtributeFields.type:this.type,
    SerializeModelAtributeFields.name:this.name,
    SerializeModelAtributeFields.varname:this.varname,
    SerializeModelAtributeFields.value: this.value,
    SerializeModelAtributeFields.setter: this.setter,
    SerializeModelAtributeFields.getter:this.getter
  };

  String buildModelField(){
    return " static String ${this.varname} = \"${this.name}\";";
  }

  String buildModel(){

    if (this.type =='String')
    {
      return " ${this.type} ${this.varname}" + (this.value != null ?' = \"${this.value}\";':'; ');
    }
    this.type = this.type==null ? 'dynamic' : this.type;
    return " ${this.type} ${this.varname}" + (this.value != null ?' = ${this.value};':'; ');

  }
  buildModelConstrutor(){
    return "this.${this.varname}";
  }

  buildModelFromJson(String modelNameFields){
    return "this.${this.varname} = json[$modelNameFields.${this.varname}]";
  }

  buildModelToJson(String modelNameFields){
    return "$modelNameFields.${this.varname}: this.${this.varname}";
  }

  buildModeSetters(){
    return "set${this.varname[0].toUpperCase()}${this.varname.substring(1)}( ${this.type} ${this.varname}){\n    this.${this.varname} = ${this.varname}; \n  }";
  }

  

}

class SerializeModelFields{
  static String modelName = "MODEL_NAME";
  static String modelNameFields = "MODEL_NAME_FIELDS";
  static String atributesMap = "ATRIBUTES_MAP";
}

class SerializeModel{


  String modelName;
  String modelNameFields;
  List<dynamic> atributesMap;
  List<SerializeModelAtribute> atributes=[];
  String modelBuild;
  String modelFields;

  SerializeModel.fromJson(Map<String,dynamic>  json):
    this.modelName=json[SerializeModelFields.modelName],
    this.modelNameFields=json[SerializeModelFields.modelNameFields],
    this.atributesMap=json[SerializeModelFields.atributesMap];
  
  buildModelAtributes(){
    this.atributesMap.forEach((atributesMap){
      SerializeModelAtribute serializeModelAtribute =SerializeModelAtribute.fromJson(atributesMap);
      this.atributes.add(serializeModelAtribute);
    });
  }

  String buildModelFields(){
    var attrs = []; 
    this.atributes.forEach((serializeModelAtribute){
      attrs.add(serializeModelAtribute.buildModelField());
    });

    return  "class ${this.modelNameFields}{\n "
      " static String tableName = \"${this.modelNameFields}\";\n "
      "${attrs.join('\n ')}\n"
    "}" ;
  }

  buildModel(){
    var attrs = []; 
    var attrs1 = []; 
    var attrs2 = []; 
    var attrs3 = []; 
    var attrs4 = []; 
    this.atributes.forEach((serializeModelAtribute){
      attrs.add(serializeModelAtribute.buildModel());
      attrs1.add(serializeModelAtribute.buildModelConstrutor());
      attrs2.add(serializeModelAtribute.buildModelFromJson(this.modelNameFields));
      attrs3.add(serializeModelAtribute.buildModelToJson(this.modelNameFields));
      attrs4.add(serializeModelAtribute.buildModeSetters());
    });

    return "class ${this.modelName} {\n "
      " int index;\n "
      "${attrs.join('\n ')}\n\n "
      " ${this.modelName}({\n  "
        "  this.index,\n  "
        "  ${attrs1.join(',\n    ')}\n "
      " });\n\n "
      " ${this.modelName}.fromJson(Map<String,dynamic>json):\n  "
        "  ${attrs2.join(',\n    ')};\n "
      " \n "
      " Map<String,dynamic>toJson({List<dynamic> getKeys , List<dynamic>  notKeys }){\n\n  "
        "  Map<String,dynamic> map = {\n      ${attrs3.join(',\n      ')}    \n    }; \n\n"
        "    if(getKeys != null )\n"
        "    { \n"
        "      map.removeWhere((k,v)=> ! getKeys.contains(k)); \n"
        "    }\n \n"
        "    if(notKeys  != null ) \n"
        "    { \n"
        "      map.removeWhere((k,v)=> notKeys.contains(k)); \n"
        "    } \n\n"
        "    return map;\n "
      " }\n\n "
      " List<dynamic> toList()=>[\n  "
          "  this.index,\n  "
          "  ${attrs1.join(',\n    ')}\n "
      " ];\n\n"
      "  setIndex(int index){\n    this.index = index;\n  }\n"
      "  ${attrs4.join('\n\n  ')}  \n "

    "}";
  }
  
  String build(){
    this.buildModelAtributes();
    var n1 = this.buildModelFields();
    var n2 = this.buildModel();
    return "$n1\n\n$n2";
  }
}