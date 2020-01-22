class SerializeModelAtributeFields {
  static String type = "TYPE";
  static String name = "NAME";
  static String varname = "VARNAME";
  static String value = "VALUE";
  static String setter = "SETTER";
  static String getter = "GETTER";
  static String isUnique = "IS_UNIQUE";
  static String isNotNull = "IS_NOT_NULL";
  static String isPrimaryKey = "IS_PRIMARY_KEY";
  static String isAutoIncrement = "IS_AUTO_INCREMENT";
  static String foreignKey = "FOREIGN_KEY";
}

class SerializeModelAtribute {
  String type;
  String name;
  String varname;
  dynamic value;
  bool setter;
  bool getter;
  bool isUnique;
  bool isNotNull;
  bool isPrimaryKey;
  bool isAutoIncrement;
  List<dynamic> foreignKey;

  SerializeModelAtribute({
    this.type,
    this.name,
    this.varname,
    this.value,
    this.setter = false,
    this.getter = false,
    this.isUnique = false,
    this.isNotNull = false,
    this.isPrimaryKey = false,
    this.isAutoIncrement = false,
    this.foreignKey,
  });

  SerializeModelAtribute.fromJson(Map<String, dynamic> json)
      : this.type = json[SerializeModelAtributeFields.type],
        this.name = json[SerializeModelAtributeFields.name],
        this.varname = json[SerializeModelAtributeFields.varname],
        this.value = json[SerializeModelAtributeFields.value],
        this.setter = json[SerializeModelAtributeFields.setter],
        this.getter = json[SerializeModelAtributeFields.getter],
        this.isUnique = json[SerializeModelAtributeFields.isUnique],
        this.isNotNull = json[SerializeModelAtributeFields.isNotNull],
        this.isPrimaryKey = json[SerializeModelAtributeFields.isPrimaryKey],
        this.isAutoIncrement =
            json[SerializeModelAtributeFields.isAutoIncrement],
        this.foreignKey = json[SerializeModelAtributeFields.foreignKey];

  Map<String, dynamic> toJson() => {
        SerializeModelAtributeFields.type: this.type,
        SerializeModelAtributeFields.name: this.name,
        SerializeModelAtributeFields.varname: this.varname,
        SerializeModelAtributeFields.value: this.value,
        SerializeModelAtributeFields.setter: this.setter,
        SerializeModelAtributeFields.getter: this.getter,
        SerializeModelAtributeFields.isUnique: this.isUnique,
        SerializeModelAtributeFields.isNotNull: this.isNotNull,
        SerializeModelAtributeFields.isPrimaryKey: this.isPrimaryKey,
        SerializeModelAtributeFields.isAutoIncrement: this.isAutoIncrement,
        SerializeModelAtributeFields.foreignKey: this.foreignKey
      };

  String buildModelField() {
    return " static String ${this.varname} = \"${this.name}\";";
  }

  String buildModel() {
    if (this.type == 'String') {
      return " ${this.type} ${this.varname}" +
          (this.value != null ? ' = \"${this.value}\";' : '; ');
    }
    this.type = this.type == null ? 'dynamic' : this.type;
    return " ${this.type} ${this.varname}" +
        (this.value != null ? ' = ${this.value};' : '; ');
  }

  buildModelConstrutor() {
    return "this.${this.varname}";
  }

  buildModelFromJson(String modelNameFields) {
    return "this.${this.varname} = json[$modelNameFields.${this.varname}]";
  }

  buildModelToJson(String modelNameFields) {
    return "$modelNameFields.${this.varname}: this.${this.varname}";
  }

  buildModeSetters() {
    return "set${this.varname[0].toUpperCase()}${this.varname.substring(1)}( ${this.type} ${this.varname}){\n    this.${this.varname} = ${this.varname}; \n  }";
  }

  buildColumn(String modelNameFields) {
    var str = "SBDColumn(\n " +
        "       name:$modelNameFields.${this.varname},\n        " +
        "type:SBDColumnDataType.TEXT,\n        ";

    if (this.isUnique == true) {
      str += "isUnique:${this.isUnique},\n        ";
    }

    if (this.isNotNull == true) {
      str += "isNotNull:${this.isNotNull},\n        ";
    }

    if (this.value != null) {
      str += "defaultValue:${this.value},\n        ";
    }

    if (this.isPrimaryKey == true) {
      str += "isPrimaryKey:${this.isPrimaryKey},\n        ";
    }

    if (this.foreignKey != null) {
      str +=
          "foreignKey:['${this.foreignKey[0]}','${this.foreignKey[1]}'],\n    ";
    }

    return str += ")";
  }
}

class SerializeModelFields {
  static String modelName = "MODEL_NAME";
  static String modelNameFields = "MODEL_NAME_FIELDS";
  static String atributesMap = "ATRIBUTES_MAP";
  static String primaryKeyName = "PRIMARY_KEY_NAME";
}

class SerializeModel {
  String modelName;
  String modelNameFields;
  String primaryKeyName;
  List<dynamic> atributesMap;
  List<SerializeModelAtribute> atributes = [];
  String modelBuild;
  String modelFields;

  SerializeModel.fromJson(Map<String, dynamic> json)
      : this.modelName = json[SerializeModelFields.modelName],
        this.modelNameFields = json[SerializeModelFields.modelNameFields],
        this.atributesMap = json[SerializeModelFields.atributesMap],
        this.primaryKeyName = json[SerializeModelFields.primaryKeyName];

  buildModelAtributes() {
    this.atributesMap.forEach((atributesMap) {
      SerializeModelAtribute serializeModelAtribute =
          SerializeModelAtribute.fromJson(atributesMap);
      this.atributes.add(serializeModelAtribute);
    });
  }

  String buildModelFields() {
    var attrs = [];
    this.atributes.forEach((serializeModelAtribute) {
      attrs.add(serializeModelAtribute.buildModelField());
    });

    return "class ${this.modelNameFields}{\n "
        " static String tableName = \"${this.modelNameFields}\";\n "
        " static String primaryKeyName = \"${this.primaryKeyName}\";\n "
        "${attrs.join('\n ')}\n"
        "}";
  }

  buildModel() {
    var attrs = [];
    var attrs1 = [];
    var attrs2 = [];
    var attrs3 = [];
    var attrs4 = [];
    var attr5 = [];
    this.atributes.forEach((serializeModelAtribute) {
      attr5.add(serializeModelAtribute.buildColumn(this.modelNameFields));

      attrs.add(serializeModelAtribute.buildModel());
      attrs1.add(serializeModelAtribute.buildModelConstrutor());
      attrs2
          .add(serializeModelAtribute.buildModelFromJson(this.modelNameFields));
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
        " Map<String,dynamic>toJson({List<dynamic> getKeys , List<dynamic>  notKeys , isNull = false , notNull = false }){\n\n  "
        "  Map<String,dynamic> map = {\n      ${attrs3.join(',\n      ')}    \n    }; \n\n"
        "    if(getKeys != null )\n"
        "    { \n"
        "      map.removeWhere((k,v)=> ! getKeys.contains(k)); \n"
        "    }\n \n"
        "    if(notKeys  != null ) \n"
        "    { \n"
        "      map.removeWhere((k,v)=> notKeys.contains(k)); \n"
        "    } \n\n"
        "    if(isNull) \n"
        "    { \n"
        "      map.removeWhere((k,v)=> v != null); \n"
        "    } \n\n"
        "    if(notNull) \n"
        "    { \n"
        "      map.removeWhere((k,v)=> v == null); \n"
        "    } \n\n"
        "    return map;\n "
        " }\n\n "
        " List<dynamic> toList()=>[\n  "
        "  this.index,\n  "
        "  ${attrs1.join(',\n    ')}\n "
        " ];\n\n"
        "  setIndex(int index){\n    this.index = index;\n  }\n"
        "  ${attrs4.join('\n\n  ')}  \n\n"
        "  SBDTable buildTable() => SBDTable(\n"
        "    name:${this.modelNameFields}.tableName,\n"
        "    primaryKeyName:${this.modelNameFields}.primaryKeyName,\n"
        "    columns:[\n"
        "      ${attr5.join(',\n     ')}      "
        "    \n    ]\n"
        "  );\n"
        "}";
  }

  String buildTableModel() {
    return "";
  }

  String build() {
    this.buildModelAtributes();
    var n1 = this.buildModelFields();
    var n2 = this.buildModel();
    return "import 'package:sql_build_database/sql_build_database.dart';\n\n$n1\n\n$n2";
  }
}
