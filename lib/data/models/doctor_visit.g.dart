// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_visit.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDoctorVisitCollection on Isar {
  IsarCollection<DoctorVisit> get doctorVisits => this.collection();
}

const DoctorVisitSchema = CollectionSchema(
  name: r'DoctorVisit',
  id: -2124032609944485078,
  properties: {
    r'clinic': PropertySchema(
      id: 0,
      name: r'clinic',
      type: IsarType.string,
    ),
    r'completed': PropertySchema(
      id: 1,
      name: r'completed',
      type: IsarType.bool,
    ),
    r'doctorName': PropertySchema(
      id: 2,
      name: r'doctorName',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 3,
      name: r'notes',
      type: IsarType.string,
    ),
    r'profileUuid': PropertySchema(
      id: 4,
      name: r'profileUuid',
      type: IsarType.string,
    ),
    r'visitAt': PropertySchema(
      id: 5,
      name: r'visitAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _doctorVisitEstimateSize,
  serialize: _doctorVisitSerialize,
  deserialize: _doctorVisitDeserialize,
  deserializeProp: _doctorVisitDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _doctorVisitGetId,
  getLinks: _doctorVisitGetLinks,
  attach: _doctorVisitAttach,
  version: '3.1.0+1',
);

int _doctorVisitEstimateSize(
  DoctorVisit object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.clinic.length * 3;
  bytesCount += 3 + object.doctorName.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.profileUuid.length * 3;
  return bytesCount;
}

void _doctorVisitSerialize(
  DoctorVisit object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.clinic);
  writer.writeBool(offsets[1], object.completed);
  writer.writeString(offsets[2], object.doctorName);
  writer.writeString(offsets[3], object.notes);
  writer.writeString(offsets[4], object.profileUuid);
  writer.writeDateTime(offsets[5], object.visitAt);
}

DoctorVisit _doctorVisitDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DoctorVisit();
  object.clinic = reader.readString(offsets[0]);
  object.completed = reader.readBool(offsets[1]);
  object.doctorName = reader.readString(offsets[2]);
  object.id = id;
  object.notes = reader.readString(offsets[3]);
  object.profileUuid = reader.readString(offsets[4]);
  object.visitAt = reader.readDateTime(offsets[5]);
  return object;
}

P _doctorVisitDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _doctorVisitGetId(DoctorVisit object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _doctorVisitGetLinks(DoctorVisit object) {
  return [];
}

void _doctorVisitAttach(
    IsarCollection<dynamic> col, Id id, DoctorVisit object) {
  object.id = id;
}

extension DoctorVisitQueryWhereSort
    on QueryBuilder<DoctorVisit, DoctorVisit, QWhere> {
  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DoctorVisitQueryWhere
    on QueryBuilder<DoctorVisit, DoctorVisit, QWhereClause> {
  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> idBetween(
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

extension DoctorVisitQueryFilter
    on QueryBuilder<DoctorVisit, DoctorVisit, QFilterCondition> {
  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> clinicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clinic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      clinicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clinic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> clinicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clinic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> clinicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clinic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      clinicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clinic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> clinicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clinic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> clinicContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clinic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> clinicMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clinic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      clinicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clinic',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      clinicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clinic',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      completedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completed',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'doctorName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'doctorName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doctorName',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'doctorName',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      profileUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profileUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      profileUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profileUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      profileUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      profileUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profileUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> visitAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'visitAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      visitAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'visitAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> visitAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'visitAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> visitAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'visitAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DoctorVisitQueryObject
    on QueryBuilder<DoctorVisit, DoctorVisit, QFilterCondition> {}

extension DoctorVisitQueryLinks
    on QueryBuilder<DoctorVisit, DoctorVisit, QFilterCondition> {}

extension DoctorVisitQuerySortBy
    on QueryBuilder<DoctorVisit, DoctorVisit, QSortBy> {
  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByClinic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinic', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByClinicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinic', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByDoctorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByDoctorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByProfileUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByProfileUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByVisitAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitAt', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByVisitAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitAt', Sort.desc);
    });
  }
}

extension DoctorVisitQuerySortThenBy
    on QueryBuilder<DoctorVisit, DoctorVisit, QSortThenBy> {
  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByClinic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinic', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByClinicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinic', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByDoctorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByDoctorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByProfileUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByProfileUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUuid', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByVisitAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitAt', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByVisitAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitAt', Sort.desc);
    });
  }
}

extension DoctorVisitQueryWhereDistinct
    on QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> {
  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByClinic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clinic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completed');
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByDoctorName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doctorName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByProfileUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileUuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByVisitAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'visitAt');
    });
  }
}

extension DoctorVisitQueryProperty
    on QueryBuilder<DoctorVisit, DoctorVisit, QQueryProperty> {
  QueryBuilder<DoctorVisit, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DoctorVisit, String, QQueryOperations> clinicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clinic');
    });
  }

  QueryBuilder<DoctorVisit, bool, QQueryOperations> completedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completed');
    });
  }

  QueryBuilder<DoctorVisit, String, QQueryOperations> doctorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doctorName');
    });
  }

  QueryBuilder<DoctorVisit, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<DoctorVisit, String, QQueryOperations> profileUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileUuid');
    });
  }

  QueryBuilder<DoctorVisit, DateTime, QQueryOperations> visitAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'visitAt');
    });
  }
}
