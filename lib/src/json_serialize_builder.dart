import 'dart:async';
import 'dart:convert' as convert;
import 'package:build/build.dart';
import 'package:json_serialize/src/serialize_model.dart';

class JsonSerializeBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {

    var inputId = buildStep.inputId;
    var copyAssetId = inputId.changeExtension('_model.dart');
    var contents = await buildStep.readAsBytes(inputId);

    Map<String,dynamic> json = convert.jsonDecode(convert.utf8.decode(contents));

    SerializeModel serializeModel = SerializeModel.fromJson(json);


    await buildStep.writeAsBytes(copyAssetId, convert.utf8.encode(serializeModel.build()));
  
  }

  @override
  Map<String, List<String>> get buildExtensions => {
    '.jsonser':['_model.dart'],
  };

}