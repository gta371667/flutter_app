/// 新聞頻道
class FinanceChannelData {
  ///頻道id
  num id;

  ///頻道名稱
  String name;

  ///頻道code
  String code;

  ///頻道一句話簡介
  String intro;

  ///顯示1；不顯示0，預設1
  int show;

  ///在array第幾個位置
  int indexWhere;

  bool get shouldShow => show == 1 || show == null;

  FinanceChannelData({
    this.id,
    this.name,
    this.code,
    this.intro,
    this.show = 1,
    this.indexWhere = 0,
  }) : super();
}

/// 新聞資料庫搜尋用
class FinanceSearch {
  int newsId;
  int channelId;

  FinanceSearch({this.newsId, this.channelId});
}

/// 新聞資料

class FinanceData {
  ///流水號id
  int id;

  ///新聞個別id
  int newsId;

  ///所屬頻道id
  int channelId;

  ///標題
  String title;

  ///圖片網址，有可能是Empty
  String pictureUrl;

  ///原始資料網址
  String originUrl;

  ///資料來源
  String source;

  ///發表時間
  String postTime;

  ///本地DB更新時間
  int localUpdateTime;

  ///狀態,enable:開啟/disable:關閉
  String status;

  /// 新聞詳細
  FinanceFullData fullData;

  FinanceData({
    this.id,
    this.newsId,
    this.channelId,
    this.title,
    this.pictureUrl,
    this.originUrl,
    this.source,
    this.postTime,
    this.localUpdateTime,
    this.status,
    this.fullData,
  });
}

class FinanceFullData {
  String title;
  String content;
  String coverImg;
  String avatar;

  FinanceFullData({this.title, this.content, this.coverImg, this.avatar});
}
