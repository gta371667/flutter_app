import 'package:flutter_app/model/finance_model.dart';
import 'package:flutter_app/tool/db_util.dart';

class _ChannelDataTable extends SQLiteTable {
  @override
  Map<String, SQLiteDataType> get dataMap => {
        id: SQLiteDataType.integer,
        name: SQLiteDataType.string,
        code: SQLiteDataType.string,
        intro: SQLiteDataType.string,
        show: SQLiteDataType.integer,
        indexWhere: SQLiteDataType.integer,
      };

  @override
  String get tableName => 'favorite_channel';

  @override
  String get tablePrimary => id;

  final String id = "id";
  final String name = "name";
  final String code = "code";
  final String intro = "intro";
  final String indexWhere = "indexWhere"; //在array第幾個位置
  final String show = "show"; //顯示1；不顯示0，預設1
}

/// 範例 - 數據庫 db
class ChannelDatabase {
  static final _singleton = ChannelDatabase._internal();

  static ChannelDatabase getInstance() => _singleton;

  factory ChannelDatabase() => _singleton;

  final DBUtil _dbUtil = DBUtil();

  final _ChannelDataTable _dataTable = _ChannelDataTable();

  ChannelDatabase._internal() {
    _dbUtil.initDB(dbName: _dataTable.tableName, version: 1, onCreate: _onCreate);
  }

  /// 創建數據表
  Future<void> _onCreate(int version) async {
    await _dbUtil.createTable(_dataTable);
  }

  /// 新增一筆
  Future<int> insertItem(FinanceChannelData data) async {
    return await _dbUtil.insertItem(_dataTable, values: _getMapFrom(data));
  }

  /// 根據id刪除
  Future<int> deleteItem(String id) async {
    return await _dbUtil.deleteItem(_dataTable, where: "${_dataTable.id} = ?", whereArgs: [id]);
  }

  /// 修改
  Future<int> updateItem(FinanceChannelData data) async {
    return await _dbUtil.updateItem(_dataTable,
        values: _getMapFrom(data), where: "${_dataTable.id} = ?", whereArgs: [data.id]);
  }

  /// 顯示/隱藏
  Future<int> toggleItem(FinanceChannelData data) async {
    data.show = data.shouldShow ? 0 : 1;
    return await updateItem(data);
  }

  /// 新增或修改item，[show]以db的為主
  Future<int> saveOrUpdateItem(FinanceChannelData data) async {
    return await getItem(data.id).then((value) async {
      if (value == null) {
        return await insertItem(data);
      } else {
        return await updateItem(
          FinanceChannelData(
            id: data.id,
            name: data.name,
            code: data.code,
            intro: data.intro,
            show: value.show,
            indexWhere: value.indexWhere,
          ),
        );
      }
    });
  }

  /// 取得全部的資料
  Future<List<FinanceChannelData>> getTotalItem() async {
    var total = await _dbUtil.getTotalItem(_dataTable);

    var array = total.map((element) => _getDataFrom(element)).toList();
    array.sort((a, b) => a.indexWhere.compareTo(b.indexWhere));
    return array;
  }

  /// 查詢總筆數
  Future<int> getTotalCount() async {
    return _dbUtil.getTotalCount(_dataTable);
  }

  /// 從id查詢對應資料, 若查詢到多筆, 只取第一筆
  Future<FinanceChannelData> getItem(int id) async {
    var result = await _dbUtil.getItem(_dataTable, where: "${_dataTable.id} = ?", whereArgs: [id]);
    if (result.length == 0) return null;
    return _getDataFrom(result.first);
  }

  /// 清空數據
  Future<int> clear() async {
    return _dbUtil.clearItem(_dataTable);
  }

  /// 關閉
  Future close() async {
    _dbUtil.close();
  }

  /// 取得data對表格資料的轉換
  Map<String, dynamic> _getMapFrom(FinanceChannelData data) {
    return {
      _dataTable.id: data.id,
      _dataTable.name: data.name,
      _dataTable.code: data.code,
      _dataTable.intro: data.intro,
      _dataTable.show: data.show,
      _dataTable.indexWhere: data.indexWhere,
    };
  }

  /// 取得資料表格對data的轉換
  FinanceChannelData _getDataFrom(Map<String, dynamic> map) {
    return FinanceChannelData(
      id: map[_dataTable.id],
      name: map[_dataTable.name],
      code: map[_dataTable.code],
      intro: map[_dataTable.intro],
      show: map[_dataTable.show],
      indexWhere: map[_dataTable.indexWhere],
    );
  }
}
