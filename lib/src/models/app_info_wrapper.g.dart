// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_wrapper.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppInfoWrapperCollection on Isar {
  IsarCollection<AppInfoWrapper> get appInfoWrappers => this.collection();
}

const AppInfoWrapperSchema = CollectionSchema(
  name: r'AppInfoWrapper',
  id: 4926694402024378538,
  properties: {
    r'builtWith': PropertySchema(
      id: 0,
      name: r'builtWith',
      type: IsarType.byte,
      enumMap: _AppInfoWrapperbuiltWithEnumValueMap,
    ),
    r'iconBase64': PropertySchema(
      id: 1,
      name: r'iconBase64',
      type: IsarType.string,
    ),
    r'installedTimestamp': PropertySchema(
      id: 2,
      name: r'installedTimestamp',
      type: IsarType.long,
    ),
    r'key': PropertySchema(
      id: 3,
      name: r'key',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'packageName': PropertySchema(
      id: 5,
      name: r'packageName',
      type: IsarType.string,
    ),
    r'versionCode': PropertySchema(
      id: 6,
      name: r'versionCode',
      type: IsarType.long,
    ),
    r'versionName': PropertySchema(
      id: 7,
      name: r'versionName',
      type: IsarType.string,
    )
  },
  estimateSize: _appInfoWrapperEstimateSize,
  serialize: _appInfoWrapperSerialize,
  deserialize: _appInfoWrapperDeserialize,
  deserializeProp: _appInfoWrapperDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appInfoWrapperGetId,
  getLinks: _appInfoWrapperGetLinks,
  attach: _appInfoWrapperAttach,
  version: '3.1.0+1',
);

int _appInfoWrapperEstimateSize(
  AppInfoWrapper object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.iconBase64;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.key.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.packageName.length * 3;
  bytesCount += 3 + object.versionName.length * 3;
  return bytesCount;
}

void _appInfoWrapperSerialize(
  AppInfoWrapper object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.builtWith.index);
  writer.writeString(offsets[1], object.iconBase64);
  writer.writeLong(offsets[2], object.installedTimestamp);
  writer.writeString(offsets[3], object.key);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.packageName);
  writer.writeLong(offsets[6], object.versionCode);
  writer.writeString(offsets[7], object.versionName);
}

AppInfoWrapper _appInfoWrapperDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppInfoWrapper();
  object.builtWith =
      _AppInfoWrapperbuiltWithValueEnumMap[reader.readByteOrNull(offsets[0])] ??
          BuiltWith.flutter;
  object.iconBase64 = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.installedTimestamp = reader.readLong(offsets[2]);
  object.key = reader.readString(offsets[3]);
  object.name = reader.readString(offsets[4]);
  object.packageName = reader.readString(offsets[5]);
  object.versionCode = reader.readLong(offsets[6]);
  object.versionName = reader.readString(offsets[7]);
  return object;
}

P _appInfoWrapperDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_AppInfoWrapperbuiltWithValueEnumMap[
              reader.readByteOrNull(offset)] ??
          BuiltWith.flutter) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AppInfoWrapperbuiltWithEnumValueMap = {
  'flutter': 0,
  'react_native': 1,
  'xamarin': 2,
  'ionic': 3,
  'native_or_others': 4,
};
const _AppInfoWrapperbuiltWithValueEnumMap = {
  0: BuiltWith.flutter,
  1: BuiltWith.react_native,
  2: BuiltWith.xamarin,
  3: BuiltWith.ionic,
  4: BuiltWith.native_or_others,
};

Id _appInfoWrapperGetId(AppInfoWrapper object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appInfoWrapperGetLinks(AppInfoWrapper object) {
  return [];
}

void _appInfoWrapperAttach(
    IsarCollection<dynamic> col, Id id, AppInfoWrapper object) {
  object.id = id;
}

extension AppInfoWrapperQueryWhereSort
    on QueryBuilder<AppInfoWrapper, AppInfoWrapper, QWhere> {
  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppInfoWrapperQueryWhere
    on QueryBuilder<AppInfoWrapper, AppInfoWrapper, QWhereClause> {
  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppInfoWrapperQueryFilter
    on QueryBuilder<AppInfoWrapper, AppInfoWrapper, QFilterCondition> {
  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      builtWithEqualTo(BuiltWith value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'builtWith',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      builtWithGreaterThan(
    BuiltWith value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'builtWith',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      builtWithLessThan(
    BuiltWith value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'builtWith',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      builtWithBetween(
    BuiltWith lower,
    BuiltWith upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'builtWith',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'iconBase64',
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'iconBase64',
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconBase64',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'iconBase64',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconBase64',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      iconBase64IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconBase64',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      installedTimestampEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'installedTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      installedTimestampGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'installedTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      installedTimestampLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'installedTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      installedTimestampBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'installedTimestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      keyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      keyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      keyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      keyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'key',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      keyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      keyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      keyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      keyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      packageNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      packageNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      packageNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      packageNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'packageName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      packageNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      packageNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      packageNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      packageNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'packageName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      packageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'packageName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      packageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'packageName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionCode',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'versionCode',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'versionCode',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'versionCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'versionName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'versionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterFilterCondition>
      versionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'versionName',
        value: '',
      ));
    });
  }
}

extension AppInfoWrapperQueryObject
    on QueryBuilder<AppInfoWrapper, AppInfoWrapper, QFilterCondition> {}

extension AppInfoWrapperQueryLinks
    on QueryBuilder<AppInfoWrapper, AppInfoWrapper, QFilterCondition> {}

extension AppInfoWrapperQuerySortBy
    on QueryBuilder<AppInfoWrapper, AppInfoWrapper, QSortBy> {
  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> sortByBuiltWith() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'builtWith', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      sortByBuiltWithDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'builtWith', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      sortByIconBase64() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      sortByIconBase64Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      sortByInstalledTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installedTimestamp', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      sortByInstalledTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installedTimestamp', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> sortByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> sortByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      sortByPackageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      sortByPackageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      sortByVersionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionCode', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      sortByVersionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionCode', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      sortByVersionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      sortByVersionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.desc);
    });
  }
}

extension AppInfoWrapperQuerySortThenBy
    on QueryBuilder<AppInfoWrapper, AppInfoWrapper, QSortThenBy> {
  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> thenByBuiltWith() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'builtWith', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      thenByBuiltWithDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'builtWith', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      thenByIconBase64() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      thenByIconBase64Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      thenByInstalledTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installedTimestamp', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      thenByInstalledTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installedTimestamp', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> thenByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> thenByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      thenByPackageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      thenByPackageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      thenByVersionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionCode', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      thenByVersionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionCode', Sort.desc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      thenByVersionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.asc);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QAfterSortBy>
      thenByVersionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.desc);
    });
  }
}

extension AppInfoWrapperQueryWhereDistinct
    on QueryBuilder<AppInfoWrapper, AppInfoWrapper, QDistinct> {
  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QDistinct>
      distinctByBuiltWith() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'builtWith');
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QDistinct> distinctByIconBase64(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconBase64', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QDistinct>
      distinctByInstalledTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'installedTimestamp');
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QDistinct> distinctByKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'key', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QDistinct> distinctByPackageName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'packageName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QDistinct>
      distinctByVersionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionCode');
    });
  }

  QueryBuilder<AppInfoWrapper, AppInfoWrapper, QDistinct> distinctByVersionName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionName', caseSensitive: caseSensitive);
    });
  }
}

extension AppInfoWrapperQueryProperty
    on QueryBuilder<AppInfoWrapper, AppInfoWrapper, QQueryProperty> {
  QueryBuilder<AppInfoWrapper, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppInfoWrapper, BuiltWith, QQueryOperations>
      builtWithProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'builtWith');
    });
  }

  QueryBuilder<AppInfoWrapper, String?, QQueryOperations> iconBase64Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconBase64');
    });
  }

  QueryBuilder<AppInfoWrapper, int, QQueryOperations>
      installedTimestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'installedTimestamp');
    });
  }

  QueryBuilder<AppInfoWrapper, String, QQueryOperations> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'key');
    });
  }

  QueryBuilder<AppInfoWrapper, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<AppInfoWrapper, String, QQueryOperations> packageNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'packageName');
    });
  }

  QueryBuilder<AppInfoWrapper, int, QQueryOperations> versionCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionCode');
    });
  }

  QueryBuilder<AppInfoWrapper, String, QQueryOperations> versionNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionName');
    });
  }
}
