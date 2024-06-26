// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appdatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NowPlaying` (`adult` INTEGER, `backdropPath` TEXT, `id` INTEGER, `originalLanguage` TEXT, `originalTitle` TEXT, `overview` TEXT, `popularity` REAL, `posterPath` TEXT, `releaseDate` TEXT, `title` TEXT NOT NULL, `video` INTEGER, `voteAverage` REAL, `voteCount` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TopRated` (`adult` INTEGER, `backdropPath` TEXT, `id` INTEGER, `originalLanguage` TEXT, `originalTitle` TEXT, `overview` TEXT, `popularity` REAL, `posterPath` TEXT, `releaseDate` TEXT, `title` TEXT NOT NULL, `video` INTEGER, `voteAverage` REAL, `voteCount` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _nowPlayingInsertionAdapter = InsertionAdapter(
            database,
            'NowPlaying',
            (NowPlaying item) => <String, Object?>{
                  'adult': item.adult == null ? null : (item.adult! ? 1 : 0),
                  'backdropPath': item.backdropPath,
                  'id': item.id,
                  'originalLanguage': item.originalLanguage,
                  'originalTitle': item.originalTitle,
                  'overview': item.overview,
                  'popularity': item.popularity,
                  'posterPath': item.posterPath,
                  'releaseDate': item.releaseDate,
                  'title': item.title,
                  'video': item.video == null ? null : (item.video! ? 1 : 0),
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount
                }),
        _topRatedInsertionAdapter = InsertionAdapter(
            database,
            'TopRated',
            (TopRated item) => <String, Object?>{
                  'adult': item.adult == null ? null : (item.adult! ? 1 : 0),
                  'backdropPath': item.backdropPath,
                  'id': item.id,
                  'originalLanguage': item.originalLanguage,
                  'originalTitle': item.originalTitle,
                  'overview': item.overview,
                  'popularity': item.popularity,
                  'posterPath': item.posterPath,
                  'releaseDate': item.releaseDate,
                  'title': item.title,
                  'video': item.video == null ? null : (item.video! ? 1 : 0),
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NowPlaying> _nowPlayingInsertionAdapter;

  final InsertionAdapter<TopRated> _topRatedInsertionAdapter;

  @override
  Future<List<NowPlaying>> getAllNowPlayingMovies() async {
    return _queryAdapter.queryList('SELECT * FROM NowPlaying',
        mapper: (Map<String, Object?> row) => NowPlaying(
            adult: row['adult'] == null ? null : (row['adult'] as int) != 0,
            backdropPath: row['backdropPath'] as String?,
            id: row['id'] as int?,
            originalLanguage: row['originalLanguage'] as String?,
            originalTitle: row['originalTitle'] as String?,
            overview: row['overview'] as String?,
            popularity: row['popularity'] as double?,
            posterPath: row['posterPath'] as String?,
            releaseDate: row['releaseDate'] as String?,
            title: row['title'] as String,
            video: row['video'] == null ? null : (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?));
  }

  @override
  Future<List<TopRated>> getAllTopRatedMovies() async {
    return _queryAdapter.queryList('SELECT * FROM TopRated',
        mapper: (Map<String, Object?> row) => TopRated(
            adult: row['adult'] == null ? null : (row['adult'] as int) != 0,
            backdropPath: row['backdropPath'] as String?,
            id: row['id'] as int?,
            originalLanguage: row['originalLanguage'] as String?,
            originalTitle: row['originalTitle'] as String?,
            overview: row['overview'] as String?,
            popularity: row['popularity'] as double?,
            posterPath: row['posterPath'] as String?,
            releaseDate: row['releaseDate'] as String?,
            title: row['title'] as String,
            video: row['video'] == null ? null : (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?));
  }

  @override
  Future<void> deleteAllNowPlayingMovies() async {
    await _queryAdapter.queryNoReturn('DELETE FROM NowPlaying');
  }

  @override
  Future<void> deleteAllTopRatedMovies() async {
    await _queryAdapter.queryNoReturn('DELETE FROM TopRated');
  }

  @override
  Future<void> insertNowPlayingMovies(List<NowPlaying> movies) async {
    await _nowPlayingInsertionAdapter.insertList(
        movies, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertTopRatedMovies(List<TopRated> movies) async {
    await _topRatedInsertionAdapter.insertList(
        movies, OnConflictStrategy.abort);
  }
}
