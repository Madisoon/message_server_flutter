/// 所有接口
class Api {
  static final String baseUrl = "http://118.178.237.219:8080/yuqingmanage";




  /// 获取所有需要推送的信息
  static final String allPostInformation = baseUrl + '/manage/getInforPost';

  /// 推送信息完成
  static final String postInformationFinish = baseUrl + '/manage/updateInforPost';

  /// 推送信息删除
  static final String postInformationDelete = baseUrl + '/manage/deleteInforPost';

  /// 获取所有监控的信息
  static final String allMonitorInformation =
      baseUrl + '/manage/getMonitorInformation';

  /// 监控信息确认
  static final String monitorInformationSure =
      baseUrl + '/manage/updateInfoData';

  /// 监控信息回收
  static final String monitorInformationTrash =
      baseUrl + '/manage/inforLogicOperation';
}
