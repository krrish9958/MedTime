// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_intake_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMedicineIntakeRecordCollection on Isar {
  IsarCollection<MedicineIntakeRecord> get medicineIntakeRecords =>
      this.collection();
}

const MedicineIntakeRecordSchema = CollectionSchema(
  name: r'MedicineIntakeRecord',
  id: 24457704897677079,
  properties: {
    r'key': PropertySchema(id: 0, name: r'key', type: IsarType.string),
    r'medicineId': PropertySchema(
      id: 1,
      name: r'medicineId',
      type: IsarType.string,
    ),
    r'scheduledAt': PropertySchema(
      id: 2,
      name: r'scheduledAt',
      type: IsarType.dateTime,
    ),
    r'skipped': PropertySchema(id: 3, name: r'skipped', type: IsarType.bool),
    r'takenAt': PropertySchema(
      id: 4,
      name: r'takenAt',
      type: IsarType.dateTime,
    ),
  },
  estimateSize: _medicineIntakeRecordEstimateSize,
  serialize: _medicineIntakeRecordSerialize,
  deserialize: _medicineIntakeRecordDeserialize,
  deserializeProp: _medicineIntakeRecordDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'key': IndexSchema(
      id: -4906094122524121629,
      name: r'key',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'key',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _medicineIntakeRecordGetId,
  getLinks: _medicineIntakeRecordGetLinks,
  attach: _medicineIntakeRecordAttach,
  version: '3.1.0+1',
);

int _medicineIntakeRecordEstimateSize(
  MedicineIntakeRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.key.length * 3;
  bytesCount += 3 + object.medicineId.length * 3;
  return bytesCount;
}

void _medicineIntakeRecordSerialize(
  MedicineIntakeRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.key);
  writer.writeString(offsets[1], object.medicineId);
  writer.writeDateTime(offsets[2], object.scheduledAt);
  writer.writeBool(offsets[3], object.skipped);
  writer.writeDateTime(offsets[4], object.takenAt);
}

MedicineIntakeRecord _medicineIntakeRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicineIntakeRecord();
  object.isarId = id;
  object.key = reader.readString(offsets[0]);
  object.medicineId = reader.readString(offsets[1]);
  object.scheduledAt = reader.readDateTime(offsets[2]);
  object.skipped = reader.readBool(offsets[3]);
  object.takenAt = reader.readDateTimeOrNull(offsets[4]);
  return object;
}

P _medicineIntakeRecordDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _medicineIntakeRecordGetId(MedicineIntakeRecord object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _medicineIntakeRecordGetLinks(
  MedicineIntakeRecord object,
) {
  return [];
}

void _medicineIntakeRecordAttach(
  IsarCollection<dynamic> col,
  Id id,
  MedicineIntakeRecord object,
) {
  object.isarId = id;
}

extension MedicineIntakeRecordByIndex on IsarCollection<MedicineIntakeRecord> {
  Future<MedicineIntakeRecord?> getByKey(String key) {
    return getByIndex(r'key', [key]);
  }

  MedicineIntakeRecord? getByKeySync(String key) {
    return getByIndexSync(r'key', [key]);
  }

  Future<bool> deleteByKey(String key) {
    return deleteByIndex(r'key', [key]);
  }

  bool deleteByKeySync(String key) {
    return deleteByIndexSync(r'key', [key]);
  }

  Future<List<MedicineIntakeRecord?>> getAllByKey(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return getAllByIndex(r'key', values);
  }

  List<MedicineIntakeRecord?> getAllByKeySync(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'key', values);
  }

  Future<int> deleteAllByKey(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'key', values);
  }

  int deleteAllByKeySync(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'key', values);
  }

  Future<Id> putByKey(MedicineIntakeRecord object) {
    return putByIndex(r'key', object);
  }

  Id putByKeySync(MedicineIntakeRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'key', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByKey(List<MedicineIntakeRecord> objects) {
    return putAllByIndex(r'key', objects);
  }

  List<Id> putAllByKeySync(
    List<MedicineIntakeRecord> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'key', objects, saveLinks: saveLinks);
  }
}

extension MedicineIntakeRecordQueryWhereSort
    on QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QWhere> {
  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterWhere>
  anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MedicineIntakeRecordQueryWhere
    on QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QWhereClause> {
  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterWhereClause>
  isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterWhereClause>
  isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterWhereClause>
  isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterWhereClause>
  isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterWhereClause>
  isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterWhereClause>
  keyEqualTo(String key) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'key', value: [key]),
      );
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterWhereClause>
  keyNotEqualTo(String key) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'key',
                lower: [],
                upper: [key],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'key',
                lower: [key],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'key',
                lower: [key],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'key',
                lower: [],
                upper: [key],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension MedicineIntakeRecordQueryFilter
    on
        QueryBuilder<
          MedicineIntakeRecord,
          MedicineIntakeRecord,
          QFilterCondition
        > {
  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  keyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  keyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  keyLessThan(String value, {bool include = false, bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  keyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'key',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  keyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  keyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  keyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  keyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'key',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'key', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'key', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  medicineIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'medicineId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  medicineIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'medicineId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  medicineIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'medicineId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  medicineIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'medicineId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  medicineIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'medicineId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  medicineIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'medicineId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  medicineIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'medicineId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  medicineIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'medicineId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  medicineIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'medicineId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  medicineIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'medicineId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  scheduledAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scheduledAt', value: value),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  scheduledAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scheduledAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  scheduledAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scheduledAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  scheduledAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scheduledAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  skippedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'skipped', value: value),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  takenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'takenAt'),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  takenAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'takenAt'),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  takenAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'takenAt', value: value),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  takenAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'takenAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  takenAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'takenAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicineIntakeRecord,
    MedicineIntakeRecord,
    QAfterFilterCondition
  >
  takenAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'takenAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension MedicineIntakeRecordQueryObject
    on
        QueryBuilder<
          MedicineIntakeRecord,
          MedicineIntakeRecord,
          QFilterCondition
        > {}

extension MedicineIntakeRecordQueryLinks
    on
        QueryBuilder<
          MedicineIntakeRecord,
          MedicineIntakeRecord,
          QFilterCondition
        > {}

extension MedicineIntakeRecordQuerySortBy
    on QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QSortBy> {
  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  sortByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  sortByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  sortByMedicineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.asc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  sortByMedicineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.desc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  sortByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.asc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  sortByScheduledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.desc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  sortBySkipped() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipped', Sort.asc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  sortBySkippedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipped', Sort.desc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  sortByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.asc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  sortByTakenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.desc);
    });
  }
}

extension MedicineIntakeRecordQuerySortThenBy
    on QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QSortThenBy> {
  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenByMedicineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.asc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenByMedicineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.desc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.asc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenByScheduledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.desc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenBySkipped() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipped', Sort.asc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenBySkippedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipped', Sort.desc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.asc);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QAfterSortBy>
  thenByTakenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.desc);
    });
  }
}

extension MedicineIntakeRecordQueryWhereDistinct
    on QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QDistinct> {
  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QDistinct>
  distinctByKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'key', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QDistinct>
  distinctByMedicineId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medicineId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QDistinct>
  distinctByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledAt');
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QDistinct>
  distinctBySkipped() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'skipped');
    });
  }

  QueryBuilder<MedicineIntakeRecord, MedicineIntakeRecord, QDistinct>
  distinctByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'takenAt');
    });
  }
}

extension MedicineIntakeRecordQueryProperty
    on
        QueryBuilder<
          MedicineIntakeRecord,
          MedicineIntakeRecord,
          QQueryProperty
        > {
  QueryBuilder<MedicineIntakeRecord, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<MedicineIntakeRecord, String, QQueryOperations> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'key');
    });
  }

  QueryBuilder<MedicineIntakeRecord, String, QQueryOperations>
  medicineIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicineId');
    });
  }

  QueryBuilder<MedicineIntakeRecord, DateTime, QQueryOperations>
  scheduledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledAt');
    });
  }

  QueryBuilder<MedicineIntakeRecord, bool, QQueryOperations> skippedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'skipped');
    });
  }

  QueryBuilder<MedicineIntakeRecord, DateTime?, QQueryOperations>
  takenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'takenAt');
    });
  }
}
