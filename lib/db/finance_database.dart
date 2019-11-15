import 'package:flutter_app/model/finance_model.dart';
import 'package:flutter_app/tool/db_util.dart';

class _FinanceDataColumn extends SQLiteTable {
  @override
  Map<String, SQLiteDataType> get dataMap => {
        id: SQLiteDataType.integer,
        newsId: SQLiteDataType.integer,
        channelId: SQLiteDataType.integer,
        title: SQLiteDataType.string,
        pictureUrl: SQLiteDataType.string,
        originUrl: SQLiteDataType.string,
        source: SQLiteDataType.string,
        postTime: SQLiteDataType.string,
        localUpdateTime: SQLiteDataType.integer,
        status: SQLiteDataType.string,
        fullTitle: SQLiteDataType.string,
        fullContent: SQLiteDataType.string,
        fullCoverImg: SQLiteDataType.string,
        fullAvatar: SQLiteDataType.string,
      };

  @override
  String get tableName => 'finance_data';

  @override
  String get tablePrimary => id;

  final String id = "id";
  final String newsId = "newsId";
  final String channelId = "channelId";
  final String title = "title";
  final String pictureUrl = "pictureUrl";
  final String originUrl = "originUrl";
  final String source = "source";
  final String postTime = "postTime";
  final String localUpdateTime = "localUpdateTime";
  final String status = "status";

  final String fullTitle = "fullTitle";
  final String fullContent = "fullContent";
  final String fullCoverImg = "fullCoverImg";
  final String fullAvatar = "fullAvatar";
}

class _FinanceSearchHistoryColumn extends SQLiteTable {
  @override
  Map<String, SQLiteDataType> get dataMap => {
        channelId: SQLiteDataType.integer,
        newsId: SQLiteDataType.integer,
      };

  @override
  String get tableName => 'finance_history';

  @override
  String get tablePrimary => null;

  final String channelId = "channelId";
  final String newsId = "newsId";
}

class _FinanceSearchFavoriteColumn extends SQLiteTable {
  @override
  Map<String, SQLiteDataType> get dataMap => {
        channelId: SQLiteDataType.integer,
        newsId: SQLiteDataType.integer,
      };

  @override
  String get tableName => 'finance_favorite';

  @override
  String get tablePrimary => null;

  final String channelId = "channelId";
  final String newsId = "newsId";
}

/// 範例 - 數據庫 db
class FinanceDatabase {
  static final _singleton = FinanceDatabase._internal();

  static FinanceDatabase getInstance() => _singleton;

  factory FinanceDatabase() => _singleton;

  final DBUtil _dbUtil = DBUtil();

  final String dbName = "FinanceDatabase";

  final _FinanceDataColumn _dataTable = _FinanceDataColumn();
  final _FinanceSearchHistoryColumn _historyTable = _FinanceSearchHistoryColumn();
  final _FinanceSearchFavoriteColumn _favoriteTable = _FinanceSearchFavoriteColumn();

  FinanceDatabase._internal() {
    _dbUtil.initDB(dbName: dbName, version: 1, onCreate: _onCreate);
  }

  /// 創建數據表
  Future<void> _onCreate(int version) async {
    await _dbUtil.createTable(_dataTable);
    await _dbUtil.createTable(_historyTable);
    await _dbUtil.createTable(_favoriteTable);
  }

  //########################## 新聞Data #########################################

  /// 從id查詢對應資料, 若查詢到多筆, 只取第一筆
  Future<FinanceData> getItem(int id) async {
    var result = await _dbUtil.getItem(_dataTable, where: "${_dataTable.id} = ?", whereArgs: [id]);
    if (result.length == 0) return null;
    return _getDataFrom(result.first);
  }

  /// 查詢總筆數
  Future<int> getTotalCount() async {
    return _dbUtil.getTotalCount(_dataTable);
  }

  /// 取得全部的資料
  Future<List<FinanceData>> getTotalItem() async {
    var total = await _dbUtil.getTotalItem(_dataTable);
    var array = total.map((element) => _getDataFrom(element)).toList();
    return array;
  }

  /// 新增一筆
  Future<int> insertItem(FinanceData data) async {
    return await _dbUtil.insertItem(_dataTable, values: _getMapFrom(data));
  }

  /// 修改
  Future<int> updateItem(FinanceData data) async {
    return await _dbUtil.updateItem(_dataTable,
        values: _getMapFrom(data),
        where: "${_dataTable.newsId} = ? AND ${_dataTable.channelId} = ?",
        whereArgs: [data.newsId, data.channelId]);
  }

  /// 根據id刪除
  Future<int> deleteItem(int id) async {
    print("finance刪除：$id");
    return await _dbUtil.deleteItem(_dataTable, where: "${_dataTable.id} = ?", whereArgs: [id]);
  }

  //########################## 新聞Data #########################################

  //########################## 收藏紀錄 #########################################

  /// 收藏 - 查詢所有
  Future<List<FinanceSearch>> getAllFavorite() async {
    var total = await _dbUtil.getTotalItem(_favoriteTable);
    return total.map((element) => _getFavoriteDataFrom(element)).toList();
  }

  /// 收藏 - 新增一筆
  Future<int> saveFavorite(FinanceSearch data) async {
    return await _dbUtil.insertItem(_favoriteTable, values: _getFavoriteMapFrom(data));
  }

  /// 收藏 - 根據id刪除
  Future<int> deleteFavorite(FinanceSearch data) async {
    print("deleteFavorite刪除：${data.channelId} ${data.newsId} ");

    return await _dbUtil.deleteItem(_favoriteTable,
        where: "${_favoriteTable.channelId} = ? AND ${_favoriteTable.newsId} = ?",
        whereArgs: [data.channelId, data.newsId]);
  }

  //########################## 收藏紀錄 #########################################

  //########################## 歷史紀錄 #########################################

  /// 歷史 - 查詢所有
  Future<List<FinanceSearch>> getAllHistory() async {
    var total = await _dbUtil.getTotalItem(_historyTable);
    return total.map((element) => _getHistoryDataFrom(element)).toList();
  }

  /// 歷史 - 新增或修改所有列表
  Future<void> insertHistoryItem(FinanceSearch data) async {
    return await _dbUtil.insertItem(_historyTable, values: _getHistoryMapFrom(data));
//    String values = "(${data.channelId}, ${data.newsId})";
//    return await dbClient.execute("REPLACE INTO $tableNameHistory(channelId, newsId) VALUES $values ;");
  }

  //########################## 歷史紀錄 #########################################

  /// 清空數據
  Future<void> clear() async {
    await _dbUtil.clearItem(_dataTable);
    await _dbUtil.clearItem(_historyTable);
    await _dbUtil.clearItem(_favoriteTable);
  }

  /// 關閉
  Future close() async {
    _dbUtil.close();
  }

  /// 取得data對表格資料的轉換
  Map<String, dynamic> _getMapFrom(FinanceData data) {
    return {
      _dataTable.newsId: data.newsId,
      _dataTable.channelId: data.channelId,
      _dataTable.title: data.title,
      _dataTable.pictureUrl: data.pictureUrl,
      _dataTable.originUrl: data.originUrl,
      _dataTable.source: data.source,
      _dataTable.postTime: data.postTime,
      _dataTable.localUpdateTime: data.localUpdateTime,
      _dataTable.status: data.status,
      _dataTable.fullTitle: data?.fullData?.title ?? "",
      _dataTable.fullContent: data?.fullData?.content ?? "",
      _dataTable.fullCoverImg: data?.fullData?.coverImg ?? "",
      _dataTable.fullAvatar: data?.fullData?.avatar ?? "",
    };
  }

  /// 取得資料表格對data的轉換
  FinanceData _getDataFrom(Map<String, dynamic> map) {
    return FinanceData(
      id: map[_dataTable.id],
      newsId: map[_dataTable.newsId],
      channelId: map[_dataTable.channelId],
      title: map[_dataTable.title],
      pictureUrl: map[_dataTable.pictureUrl],
      originUrl: map[_dataTable.originUrl],
      source: map[_dataTable.source],
      postTime: map[_dataTable.postTime],
      localUpdateTime: map[_dataTable.localUpdateTime],
      status: map[_dataTable.status],
      fullData: FinanceFullData(
        title: map[_dataTable.fullTitle],
        content: map[_dataTable.fullContent],
        coverImg: map[_dataTable.fullCoverImg],
        avatar: map[_dataTable.fullAvatar],
      ),
    );
  }

  Map<String, dynamic> _getFavoriteMapFrom(FinanceSearch data) {
    return {
      _favoriteTable.channelId: data.channelId,
      _favoriteTable.newsId: data.newsId,
    };
  }

  FinanceSearch _getFavoriteDataFrom(Map<String, dynamic> map) {
    return FinanceSearch(
      channelId: map[_favoriteTable.channelId],
      newsId: map[_favoriteTable.newsId],
    );
  }

  Map<String, dynamic> _getHistoryMapFrom(FinanceSearch data) {
    return {
      _historyTable.channelId: data.channelId,
      _historyTable.newsId: data.newsId,
    };
  }

  FinanceSearch _getHistoryDataFrom(Map<String, dynamic> map) {
    return FinanceSearch(
      channelId: map[_historyTable.channelId],
      newsId: map[_historyTable.newsId],
    );
  }
}
