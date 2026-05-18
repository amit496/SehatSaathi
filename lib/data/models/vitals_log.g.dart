// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vitals_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVitalsLogCollection on Isar {
  IsarCollection<VitalsLog> get vitalsLogs => this.collection();
}

const VitalsLogSchema = CollectionSchema(
  name: r'VitalsLog',
  id: -8308872872682141205,
  properties: {
    r'diastolic': PropertySchema(
      id: 0,
      name: r'diastolic',
      type: IsarType.long,
    ),
    r'note': PropertySchema(
      id: 1,
      name: r'note',
      type: IsarType.string,
    ),
    r'profileUuid': PropertySchema(
      id: 2,
      name: r'profileUuid',
      type: IsarType.string,
    ),
    r'recordedAt': PropertySchema(
      id: 3,
      name: r'recordedAt',
      type: IsarType.dateTime,
    ),
    r'sugarMgDl': PropertySchema(
      id: 4,
      name: r'sugarMgDl',
      type: IsarType.double,
    ),
    r'systolic': PropertySchema(
      id: 5,
      name: r'systolic',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 6,
      name: r'type',
      type: IsarType.string,
      enumMap: _VitalsLogtypeEnumValueMap,
    )
  },
  estimateSize: _vitalsLogEstimateSize,
  serialize: _vitalsLogSerialize,
  deserialize: _vitalsLogDeserialize,
  deserializeProp: _vitalsLogDeserializeProp,
  idName: r'id',
  indexes: {
    r'profileUuid': IndexSchema(
      id: 1129968050600041444,
      name: r'profileUuid',
      unique: false,
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
  getId: _vitalsLogGetId,
  getLinks: _vitalsLogGetLinks,
  attach: _vitalsLogAttach,
  version: '3.1.0+1',
);

int _vitalsLogEstimateSize(
  VitalsLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.note.length * 3;
  bytesCount += 3 + object.profileUuid.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _vitalsLogSerialize(
  VitalsLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.diastolic);
  writer.writeString(offsets[1], object.note);
  writer.writeString(offsets[2], object.profileUuid);
  writer.writeDateTime(offsets[3], object.recordedAt);
  writer.writeDouble(offsets[4], object.sugarMgDl);
  writer.writeLong(offsets[5], object.systolic);
  writer.writeString(offsets[6], object.type.name);
}

VitalsLog _vitalsLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VitalsLog();
  object.diastolic = reader.readLongOrNull(offsets[0]);
  object.id = id;
  object.note = reader.readString(offsets[1]);
  object.profileUuid = reader.readString(offsets[2]);
  object.recordedAt = reader.readDateTime(offsets[3]);
  object.sugarMgDl = reader.readDoubleOrNull(offsets[4]);
  object.systolic = reader.readLongOrNull(offsets[5]);
  object.type =
      _VitalsLogtypeValueEnumMap[reader.readStringOrNull(offsets[6])] ??
          VitalsType.bloodPressure;
  return object;
}

P _vitalsLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (_VitalsLogtypeValueEnumMap[reader.readStringOrNull(offset)] ??
          VitalsType.bloodPressure) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _VitalsLogtypeEnumValueMap = {
  r'bloodPressure': r'bloodPressure',
  r'bloodSugar': r'bloodSugar',
};
const _VitalsLogtypeValueEnumMap = {
  r'bloodPressure': VitalsType.bloodPressure,
  r'bloodSugar': VitalsType.bloodSugar,
};

Id _vitalsLogGetId(VitalsLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vitalsLogGetLinks(VitalsLog object) {
  return [];
}

void _vitalsLogAttach(IsarCollection<dynamic> col, Id id, VitalsLog object) {
  object.id = id;
}

extension VitalsLogQueryWhereSort
    on QueryBuilder<VitalsLog, VitalsLog, QWhere> {
  QueryBuilder<VitalsLog, VitalsLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VitalsLogQueryWhere
    on QueryBuilder<VitalsLog, VitalsLog, QWhereClause> {
  QueryBuilder<VitalsLog, VitalsLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<VitalsLog, VitalsLog, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterWhereClause> idBetween(
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

  QueryBuilder<VitalsLog, VitalsLog, QAfterWhereClause> profileUuidEqualTo(
      String profileUuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'profileUuid',
        value: [profileUuid],
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterWhereClause> profileUuidNotEqualTo(
      String profileUuid) {
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

extension VitalsLogQueryFilter
    on QueryBuilder<VitalsLog, VitalsLog, QFilterCondition> {
  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> diastolicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'diastolic',
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition>
      diastolicIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'diastolic',
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> diastolicEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diastolic',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition>
      diastolicGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diastolic',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> diastolicLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diastolic',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> diastolicBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diastolic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> noteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> noteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> noteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> noteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> noteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> noteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> profileUuidEqualTo(
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

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition>
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

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> profileUuidLessThan(
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

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> profileUuidBetween(
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

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition>
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

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> profileUuidEndsWith(
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

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> profileUuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profileUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> profileUuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profileUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition>
      profileUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition>
      profileUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profileUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> recordedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recordedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition>
      recordedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recordedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> recordedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recordedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> recordedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recordedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> sugarMgDlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sugarMgDl',
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition>
      sugarMgDlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sugarMgDl',
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> sugarMgDlEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sugarMgDl',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition>
      sugarMgDlGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sugarMgDl',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> sugarMgDlLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sugarMgDl',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> sugarMgDlBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sugarMgDl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> systolicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'systolic',
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition>
      systolicIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'systolic',
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> systolicEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'systolic',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> systolicGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'systolic',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> systolicLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'systolic',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> systolicBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'systolic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> typeEqualTo(
    VitalsType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> typeGreaterThan(
    VitalsType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> typeLessThan(
    VitalsType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> typeBetween(
    VitalsType lower,
    VitalsType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension VitalsLogQueryObject
    on QueryBuilder<VitalsLog, VitalsLog, QFilterCondition> {}

extension VitalsLogQueryLinks
    on QueryBuilder<VitalsLog, VitalsLog, QFilterCondition> {}

extension VitalsLogQuerySortBy on QueryBuilder<VitalsLog, VitalsLog, QSortBy> {
  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortByDiastolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolic', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortByDiastolicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolic', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortByProfileUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortByProfileUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortBySugarMgDl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarMgDl', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortBySugarMgDlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarMgDl', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortBySystolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolic', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortBySystolicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolic', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension VitalsLogQuerySortThenBy
    on QueryBuilder<VitalsLog, VitalsLog, QSortThenBy> {
  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenByDiastolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolic', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenByDiastolicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolic', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenByProfileUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenByProfileUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenBySugarMgDl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarMgDl', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenBySugarMgDlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarMgDl', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenBySystolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolic', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenBySystolicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolic', Sort.desc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension VitalsLogQueryWhereDistinct
    on QueryBuilder<VitalsLog, VitalsLog, QDistinct> {
  QueryBuilder<VitalsLog, VitalsLog, QDistinct> distinctByDiastolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diastolic');
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QDistinct> distinctByProfileUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileUuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QDistinct> distinctByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordedAt');
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QDistinct> distinctBySugarMgDl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sugarMgDl');
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QDistinct> distinctBySystolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'systolic');
    });
  }

  QueryBuilder<VitalsLog, VitalsLog, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension VitalsLogQueryProperty
    on QueryBuilder<VitalsLog, VitalsLog, QQueryProperty> {
  QueryBuilder<VitalsLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VitalsLog, int?, QQueryOperations> diastolicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diastolic');
    });
  }

  QueryBuilder<VitalsLog, String, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<VitalsLog, String, QQueryOperations> profileUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileUuid');
    });
  }

  QueryBuilder<VitalsLog, DateTime, QQueryOperations> recordedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordedAt');
    });
  }

  QueryBuilder<VitalsLog, double?, QQueryOperations> sugarMgDlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sugarMgDl');
    });
  }

  QueryBuilder<VitalsLog, int?, QQueryOperations> systolicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'systolic');
    });
  }

  QueryBuilder<VitalsLog, VitalsType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
