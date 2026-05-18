// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_info.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmergencyInfoCollection on Isar {
  IsarCollection<EmergencyInfo> get emergencyInfos => this.collection();
}

const EmergencyInfoSchema = CollectionSchema(
  name: r'EmergencyInfo',
  id: 3632513816957429716,
  properties: {
    r'allergies': PropertySchema(
      id: 0,
      name: r'allergies',
      type: IsarType.string,
    ),
    r'bloodGroup': PropertySchema(
      id: 1,
      name: r'bloodGroup',
      type: IsarType.string,
    ),
    r'contactName': PropertySchema(
      id: 2,
      name: r'contactName',
      type: IsarType.string,
    ),
    r'contactPhone': PropertySchema(
      id: 3,
      name: r'contactPhone',
      type: IsarType.string,
    ),
    r'currentMedicines': PropertySchema(
      id: 4,
      name: r'currentMedicines',
      type: IsarType.string,
    ),
    r'profileUuid': PropertySchema(
      id: 5,
      name: r'profileUuid',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 6,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _emergencyInfoEstimateSize,
  serialize: _emergencyInfoSerialize,
  deserialize: _emergencyInfoDeserialize,
  deserializeProp: _emergencyInfoDeserializeProp,
  idName: r'id',
  indexes: {
    r'profileUuid': IndexSchema(
      id: 1129968050600041444,
      name: r'profileUuid',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'profileUuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _emergencyInfoGetId,
  getLinks: _emergencyInfoGetLinks,
  attach: _emergencyInfoAttach,
  version: '3.1.0+1',
);

int _emergencyInfoEstimateSize(
  EmergencyInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.allergies.length * 3;
  bytesCount += 3 + object.bloodGroup.length * 3;
  bytesCount += 3 + object.contactName.length * 3;
  bytesCount += 3 + object.contactPhone.length * 3;
  bytesCount += 3 + object.currentMedicines.length * 3;
  bytesCount += 3 + object.profileUuid.length * 3;
  return bytesCount;
}

void _emergencyInfoSerialize(
  EmergencyInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.allergies);
  writer.writeString(offsets[1], object.bloodGroup);
  writer.writeString(offsets[2], object.contactName);
  writer.writeString(offsets[3], object.contactPhone);
  writer.writeString(offsets[4], object.currentMedicines);
  writer.writeString(offsets[5], object.profileUuid);
  writer.writeDateTime(offsets[6], object.updatedAt);
}

EmergencyInfo _emergencyInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EmergencyInfo();
  object.allergies = reader.readString(offsets[0]);
  object.bloodGroup = reader.readString(offsets[1]);
  object.contactName = reader.readString(offsets[2]);
  object.contactPhone = reader.readString(offsets[3]);
  object.currentMedicines = reader.readString(offsets[4]);
  object.id = id;
  object.profileUuid = reader.readString(offsets[5]);
  object.updatedAt = reader.readDateTime(offsets[6]);
  return object;
}

P _emergencyInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _emergencyInfoGetId(EmergencyInfo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _emergencyInfoGetLinks(EmergencyInfo object) {
  return [];
}

void _emergencyInfoAttach(
    IsarCollection<dynamic> col, Id id, EmergencyInfo object) {
  object.id = id;
}

extension EmergencyInfoByIndex on IsarCollection<EmergencyInfo> {
  Future<EmergencyInfo?> getByProfileUuid(String profileUuid) {
    return getByIndex(r'profileUuid', [profileUuid]);
  }

  EmergencyInfo? getByProfileUuidSync(String profileUuid) {
    return getByIndexSync(r'profileUuid', [profileUuid]);
  }

  Future<bool> deleteByProfileUuid(String profileUuid) {
    return deleteByIndex(r'profileUuid', [profileUuid]);
  }

  bool deleteByProfileUuidSync(String profileUuid) {
    return deleteByIndexSync(r'profileUuid', [profileUuid]);
  }

  Future<List<EmergencyInfo?>> getAllByProfileUuid(
      List<String> profileUuidValues) {
    final values = profileUuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'profileUuid', values);
  }

  List<EmergencyInfo?> getAllByProfileUuidSync(List<String> profileUuidValues) {
    final values = profileUuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'profileUuid', values);
  }

  Future<int> deleteAllByProfileUuid(List<String> profileUuidValues) {
    final values = profileUuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'profileUuid', values);
  }

  int deleteAllByProfileUuidSync(List<String> profileUuidValues) {
    final values = profileUuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'profileUuid', values);
  }

  Future<Id> putByProfileUuid(EmergencyInfo object) {
    return putByIndex(r'profileUuid', object);
  }

  Id putByProfileUuidSync(EmergencyInfo object, {bool saveLinks = true}) {
    return putByIndexSync(r'profileUuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByProfileUuid(List<EmergencyInfo> objects) {
    return putAllByIndex(r'profileUuid', objects);
  }

  List<Id> putAllByProfileUuidSync(List<EmergencyInfo> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'profileUuid', objects, saveLinks: saveLinks);
  }
}

extension EmergencyInfoQueryWhereSort
    on QueryBuilder<EmergencyInfo, EmergencyInfo, QWhere> {
  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmergencyInfoQueryWhere
    on QueryBuilder<EmergencyInfo, EmergencyInfo, QWhereClause> {
  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterWhereClause> idBetween(
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

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterWhereClause>
      profileUuidEqualTo(String profileUuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'profileUuid',
        value: [profileUuid],
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterWhereClause>
      profileUuidNotEqualTo(String profileUuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileUuid',
              lower: [],
              upper: [profileUuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileUuid',
              lower: [profileUuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileUuid',
              lower: [profileUuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileUuid',
              lower: [],
              upper: [profileUuid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension EmergencyInfoQueryFilter
    on QueryBuilder<EmergencyInfo, EmergencyInfo, QFilterCondition> {
  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      allergiesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      allergiesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      allergiesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      allergiesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allergies',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      allergiesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      allergiesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      allergiesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      allergiesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'allergies',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      allergiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allergies',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      allergiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'allergies',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      bloodGroupEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      bloodGroupGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      bloodGroupLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      bloodGroupBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bloodGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      bloodGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      bloodGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      bloodGroupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      bloodGroupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bloodGroup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      bloodGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bloodGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      bloodGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bloodGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contactName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contactName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contactName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactPhoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactPhoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactPhoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactPhoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contactPhone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactPhoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactPhoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactPhoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactPhoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contactPhone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactPhoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      contactPhoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contactPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      currentMedicinesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentMedicines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      currentMedicinesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentMedicines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      currentMedicinesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentMedicines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      currentMedicinesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentMedicines',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      currentMedicinesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currentMedicines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      currentMedicinesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currentMedicines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      currentMedicinesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currentMedicines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      currentMedicinesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currentMedicines',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      currentMedicinesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentMedicines',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      currentMedicinesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currentMedicines',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
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

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      profileUuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      profileUuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profileUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      profileUuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profileUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      profileUuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profileUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      profileUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profileUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      profileUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profileUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      profileUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profileUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      profileUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profileUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      profileUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      profileUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profileUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EmergencyInfoQueryObject
    on QueryBuilder<EmergencyInfo, EmergencyInfo, QFilterCondition> {}

extension EmergencyInfoQueryLinks
    on QueryBuilder<EmergencyInfo, EmergencyInfo, QFilterCondition> {}

extension EmergencyInfoQuerySortBy
    on QueryBuilder<EmergencyInfo, EmergencyInfo, QSortBy> {
  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> sortByAllergies() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergies', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      sortByAllergiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergies', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> sortByBloodGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGroup', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      sortByBloodGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGroup', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> sortByContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      sortByContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      sortByContactPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactPhone', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      sortByContactPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactPhone', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      sortByCurrentMedicines() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMedicines', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      sortByCurrentMedicinesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMedicines', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> sortByProfileUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      sortByProfileUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension EmergencyInfoQuerySortThenBy
    on QueryBuilder<EmergencyInfo, EmergencyInfo, QSortThenBy> {
  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> thenByAllergies() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergies', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      thenByAllergiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergies', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> thenByBloodGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGroup', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      thenByBloodGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGroup', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> thenByContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      thenByContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      thenByContactPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactPhone', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      thenByContactPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactPhone', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      thenByCurrentMedicines() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMedicines', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      thenByCurrentMedicinesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMedicines', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> thenByProfileUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      thenByProfileUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.desc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension EmergencyInfoQueryWhereDistinct
    on QueryBuilder<EmergencyInfo, EmergencyInfo, QDistinct> {
  QueryBuilder<EmergencyInfo, EmergencyInfo, QDistinct> distinctByAllergies(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allergies', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QDistinct> distinctByBloodGroup(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bloodGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QDistinct> distinctByContactName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contactName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QDistinct> distinctByContactPhone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contactPhone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QDistinct>
      distinctByCurrentMedicines({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentMedicines',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QDistinct> distinctByProfileUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileUuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmergencyInfo, EmergencyInfo, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension EmergencyInfoQueryProperty
    on QueryBuilder<EmergencyInfo, EmergencyInfo, QQueryProperty> {
  QueryBuilder<EmergencyInfo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EmergencyInfo, String, QQueryOperations> allergiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allergies');
    });
  }

  QueryBuilder<EmergencyInfo, String, QQueryOperations> bloodGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bloodGroup');
    });
  }

  QueryBuilder<EmergencyInfo, String, QQueryOperations> contactNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contactName');
    });
  }

  QueryBuilder<EmergencyInfo, String, QQueryOperations> contactPhoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contactPhone');
    });
  }

  QueryBuilder<EmergencyInfo, String, QQueryOperations>
      currentMedicinesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentMedicines');
    });
  }

  QueryBuilder<EmergencyInfo, String, QQueryOperations> profileUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileUuid');
    });
  }

  QueryBuilder<EmergencyInfo, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
