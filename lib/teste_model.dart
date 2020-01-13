class UsuarioModelFields{
  static String tableName = "UsuarioModelFields";
  static String usuarioCodigo = "USUARIO_CODIGO";
  static String usuarioNome = "USUARIO_NOME";
  static String usuarioEmail = "USUARIO_EMAIL";
}

class UsuarioModel {
  int index;
  int usuarioCodigo = 13;
  String usuarioNome; 
  dynamic usuarioEmail; 

  UsuarioModel({
    this.index,
    this.usuarioCodigo,
    this.usuarioNome,
    this.usuarioEmail
  });

  UsuarioModel.fromJson(Map<String,dynamic>json):
    this.usuarioCodigo = json[UsuarioModelFields.usuarioCodigo],
    this.usuarioNome = json[UsuarioModelFields.usuarioNome],
    this.usuarioEmail = json[UsuarioModelFields.usuarioEmail];
  
  Map<String,dynamic>toJson({List<dynamic> getKeys , List<dynamic>  notKeys }){

    Map<String,dynamic> map = {
      UsuarioModelFields.usuarioCodigo: this.usuarioCodigo,
      UsuarioModelFields.usuarioNome: this.usuarioNome,
      UsuarioModelFields.usuarioEmail: this.usuarioEmail    
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
    this.usuarioCodigo,
    this.usuarioNome,
    this.usuarioEmail
  ];

  setIndex(int index){
    this.index = index;
  }
  setUsuarioCodigo( int usuarioCodigo){
    this.usuarioCodigo = usuarioCodigo; 
  }

  setUsuarioNome( String usuarioNome){
    this.usuarioNome = usuarioNome; 
  }

  setUsuarioEmail( dynamic usuarioEmail){
    this.usuarioEmail = usuarioEmail; 
  }  
 }