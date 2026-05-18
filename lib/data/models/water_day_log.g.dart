// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_day_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWaterDayLogCollection on Isar {
  IsarCollection<WaterDayLog> get waterDayLogs => this.collection();
}

const WaterDayLogSchema = CollectionSchema(
  name: r'WaterDayLog',
  id: 6750150545036345033,
  properties: {
    r'consumedMl': PropertySchema(
      id: 0,
      name: r'consumedMl',
      type: IsarType.long,
    ),
    r'dateKey': PropertySchema(
      id: 1,
      name: r'dateKey',
      type: IsarType.string,
    ),
    r'goalMl': PropertySchema(
      id: 2,
      name: r'goalMl',
      type: IsarType.long,
    ),
    r'profileUuid': PropertySchema(
      id: 3,
      name: r'profileUuid',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 4,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _waterDayLogEstimateSize,
  serialize: _waterDayLogSerialize,
  deserialize: _waterDayLogDeserialize,
  deserializeProp: _waterDayLogDeserializeProp,
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
    ),
    r'dateKey': IndexSchema(
      id: 7975223786082927131,
      name: r'dateKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _waterDayLogGetId,
  getLinks: _waterDayLogGetLinks,
  attach: _waterDayLogAttach,
  version: '3.1.0+1',
);

int _waterDayLogEstimateSize(
  WaterDayLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dateKey.length * 3;
  bytesCount += 3 + object.profileUuid.length * 3;
  return bytesCount;
}

void _waterDayLogSerialize(
  WaterDayLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.consumedMl);
  writer.writeString(offsets[1], object.dateKey);
  writer.writeLong(offsets[2], object.goalMl);
  writer.writeString(offsets[3], object.profileUuid);
  writer.writeDateTime(offsets[4], object.updatedAt);
}

WaterDayLog _waterDayLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WaterDayLog();
  object.consumedMl = reader.readLong(offsets[0]);
  object.dateKey = reader.readString(offsets[1]);
  object.goalMl = reader.readLong(offsets[2]);
  object.id = id;
  object.profileUuid = reader.readString(offsets[3]);
  object.updatedAt = reader.readDateTime(offsets[4]);
  return object;
}

P _waterDayLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _waterDayLogGetId(WaterDayLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _waterDayLogGetLinks(WaterDayLog object) {
  return [];
}

void _waterDayLogAttach(
    IsarCollection<dynamic> col, Id id, WaterDayLog object) {
  object.id = id;
}

extension WaterDayLogQueryWhereSort
    on QueryBuilder<WaterDayLog, WaterDayLog, QWhere> {
  QueryBuilder<WaterDayLog, WaterDayLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WaterDayLogQueryWhere
    on QueryBuilder<WaterDayLog, WaterDayLog, QWhereClause> {
  QueryBuilder<WaterDayLog, WaterDayLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterWhereClause> idBetween(
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterWhereClause> profileUuidEqualTo(
      String profileUuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'profileUuid',
        value: [profileUuid],
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterWhereClause>
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterWhereClause> dateKeyEqualTo(
      String dateKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateKey',
        value: [dateKey],
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterWhereClause> dateKeyNotEqualTo(
      String dateKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateKey',
              lower: [],
              upper: [dateKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateKey',
              lower: [dateKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateKey',
              lower: [dateKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateKey',
              lower: [],
              upper: [dateKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension WaterDayLogQueryFilter
    on QueryBuilder<WaterDayLog, WaterDayLog, QFilterCondition> {
  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      consumedMlEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consumedMl',
        value: value,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      consumedMlGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'consumedMl',
        value: value,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      consumedMlLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'consumedMl',
        value: value,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      consumedMlBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'consumedMl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> dateKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      dateKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> dateKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> dateKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      dateKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> dateKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> dateKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> dateKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      dateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      dateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> goalMlEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalMl',
        value: value,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      goalMlGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalMl',
        value: value,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> goalMlLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalMl',
        value: value,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> goalMlBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalMl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      profileUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profileUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      profileUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profileUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      profileUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      profileUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profileUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
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

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterFilterCondition>
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

extension WaterDayLogQueryObject
    on QueryBuilder<WaterDayLog, WaterDayLog, QFilterCondition> {}

extension WaterDayLogQueryLinks
    on QueryBuilder<WaterDayLog, WaterDayLog, QFilterCondition> {}

extension WaterDayLogQuerySortBy
    on QueryBuilder<WaterDayLog, WaterDayLog, QSortBy> {
  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> sortByConsumedMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedMl', Sort.asc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> sortByConsumedMlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedMl', Sort.desc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> sortByDateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.asc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> sortByDateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.desc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> sortByGoalMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalMl', Sort.asc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> sortByGoalMlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalMl', Sort.desc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> sortByProfileUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.asc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> sortByProfileUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.desc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension WaterDayLogQuerySortThenBy
    on QueryBuilder<WaterDayLog, WaterDayLog, QSortThenBy> {
  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenByConsumedMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedMl', Sort.asc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenByConsumedMlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedMl', Sort.desc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenByDateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.asc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenByDateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.desc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenByGoalMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalMl', Sort.asc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenByGoalMlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalMl', Sort.desc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenByProfileUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.asc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenByProfileUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.desc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension WaterDayLogQueryWhereDistinct
    on QueryBuilder<WaterDayLog, WaterDayLog, QDistinct> {
  QueryBuilder<WaterDayLog, WaterDayLog, QDistinct> distinctByConsumedMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consumedMl');
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QDistinct> distinctByDateKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QDistinct> distinctByGoalMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalMl');
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QDistinct> distinctByProfileUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileUuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WaterDayLog, WaterDayLog, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension WaterDayLogQueryProperty
    on QueryBuilder<WaterDayLog, WaterDayLog, QQueryProperty> {
  QueryBuilder<WaterDayLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WaterDayLog, int, QQueryOperations> consumedMlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consumedMl');
    });
  }

  QueryBuilder<WaterDayLog, String, QQueryOperations> dateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateKey');
    });
  }

  QueryBuilder<WaterDayLog, int, QQueryOperations> goalMlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalMl');
    });
  }

  QueryBuilder<WaterDayLog, String, QQueryOperations> profileUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileUuid');
    });
  }

  QueryBuilder<WaterDayLog, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
