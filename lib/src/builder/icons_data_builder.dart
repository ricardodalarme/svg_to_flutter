import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:svg_to_flutter/src/utils/normalize_name.dart';

String iconsDataBuilder({
  required Map<String, dynamic> icons,
  required String className,
  String? fontPackage,
}) {
  final header = _buildHeader();
  final imports = _buildImports(fontPackage);
  final iconDataClass = _buildCustomIconDataClass(
    className: className,
    fontPackage: fontPackage,
  );
  final iconsClass = _buildIconsClass(
    className: className,
    icons: icons,
  );

  final library = Library((b) => b.body.addAll([
        header,
        ...imports,
        iconDataClass,
        iconsClass,
      ]));

  final emitter = DartEmitter();
  final String generatedCode = library.accept(emitter).toString();

  final formatter = DartFormatter(
    languageVersion: DartFormatter.latestShortStyleLanguageVersion,
  );
  return formatter.format(generatedCode);
}

Code _buildHeader() {
  return Code('''
// ignore_for_file: sort_constructors_first, public_member_api_docs, constant_identifier_names, dangling_library_doc_comments
// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
/// SvgToFlutter
/// *****************************************************
''');
}

List<Directive> _buildImports(String? fontPackage) {
  return [Directive.import('package:flutter/widgets.dart')];
}

Class _buildCustomIconDataClass(
    {required String className, String? fontPackage}) {
  return Class(
    (ClassBuilder builder) {
      builder
        ..name = '_IconData'
        ..extend = refer('IconData')
        ..constructors.add(Constructor((constructorBuilder) {
          constructorBuilder
            ..constant = true
            ..requiredParameters.add(Parameter((paramBuilder) {
              paramBuilder
                ..name = 'codePoint'
                ..toSuper = true;
            }))
            ..initializers.add(Code(
              "super(fontFamily: '$className'${fontPackage != null ? ", fontPackage: '$fontPackage'" : ''})",
            ));
        }));
    },
  );
}

Class _buildIconsClass(
    {required String className, required Map<String, dynamic> icons}) {
  return Class(
    (ClassBuilder builder) {
      builder
        ..name = className
        ..abstract = true
        ..modifier = ClassModifier.final$;

      for (final String key in icons.keys) {
        final String codePoint = '0x${icons[key].toRadixString(16)}';
        builder.fields.add(_buildIconField(key, codePoint));
      }
    },
  );
}

Field _buildIconField(String key, String codePoint) {
  final String normalizedName = normalizeText(key);

  return Field(
    (FieldBuilder fieldBuilder) {
      fieldBuilder
        ..name = normalizedName
        ..type = refer('IconData')
        ..modifier = FieldModifier.final$
        ..assignment = Code('_IconData($codePoint)')
        ..static = true
        ..modifier = FieldModifier.constant;
    },
  );
}
