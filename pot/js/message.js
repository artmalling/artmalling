  /**
  * 시스템명 : 메세지 공통 스크립트
  * 작 성 일 : 2010-06-20
  * 작 성 자 : FKL
  * 수 정 자 :
  * 파 일 명 : message.js
  * 버    전 : 1.0
  * 인 코 딩 :
  * 개    요 : 에러메세지 정의
  */

/**
* ERRORMESSAGE 생성
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : 에러 메세지를 SERVER, CLIENT, USER로 구분하여 MAP Object에 저정한다.
* return값 :
*/

var windowsXPSP2 = null;
var strErrDialogHeight = windowsXPSP2 == true ? "150" : "150";
var _ErrorMap = new Map();
var _ErrorMessage  = [
 // 서버에서 발생하는 에러메세지 (DataSet을 사용하는 Error Message
  ["SERVER-1001", "<font color=red><b>요청하신 작업을 수행할 수 없습니다.</b></font><br>전산정보팀으로 연락바랍니다.<br><label style='cursor:hand;' onClick='viewDetail();'><font color=blue><b>[상세보기]</b></font></label>를 누르면 자세한 내용을 확인 할 수 있습니다."],
  ["SERVER-3001", "귀하는 해당화면에 대한 사용권한이 없습니다"],
  ["SERVER-3002", "로그인 후 이용하기 바랍니다."],
  ["SERVER-3003", "사용시간이 만료되었습니다. <br>좌측 메뉴를 다시 선택해야 합니다."],
  ["SERVER-3004", "로그인 후 이용하시기 바랍니다."],
  //GAUCE ERROR 메세지   ****************** Don't use (공통에서 사용)********************
  ["GAUCE-1000" , "#{1}"],
  ["GAUCE-1001" , "(#{1})건 조회되었습니다."],
  ["GAUCE-1002" , "정상적으로 처리되었습니다."],
  ["GAUCE-1003" , "조회 내용이 없습니다."],
  ["GAUCE-1004" , "저장할 내용이 없습니다."],
  ["GAUCE-1005" , "(#{1})은/는 필수 입력 항목입니다."],
  ["GAUCE-1006" , "(#{1})행의 (#{2})은/는 중복된 데이터입니다."],
  ["GAUCE-1007" , "(#{1})행의 데이터는 중복됩니다."],
  ["GAUCE-1008" , "WORK XML의 GAUCE HEADER 정보가 올바르지 않습니다."],
  ["GAUCE-1009" , "다른사용자가 동일아이디로 접속하셨거나 세션이 타임아웃 되었습니다."],
  ["GAUCE-1010" , "조회를 실패하였습니다."],
  //USER VALIDATION CHECK
  ["USER-1000", "#{1}"],  //User Defined Button (Information, Question, StopSign) - Exclamation은 사용안함
  ["USER-1001", "조회시 [#{1}]은/는 반드시 입력해야 합니다."], // Information , Ok
  ["USER-1002", "(#{1})은/는 반드시 선택해야 합니다."], // StopSign    , Ok
  ["USER-1003", "(#{1})은/는 반드시 입력해야 합니다."], // StopSign    , Ok
  ["USER-1004", "(#{1})의 입력형식이 올바르지 않습니다."], // StopSign    , Ok
  ["USER-1005", "(#{1})은/는 숫자형식으로 입력해야 합니다."], // StopSign    , Ok
  ["USER-1006", "(#{1})은/는 문자형식으로 입력해야 합니다."], // StopSign    , Ok
  ["USER-1007", "(#{1})은/는 날짜형식으로 입력해야 합니다."], // StopSign    , Ok
  ["USER-1008", "(#{1})은/는 [#{2}]보다 커야 합니다."], // StopSign    , Ok
  ["USER-1009", "(#{1})은/는 [#{2}]보다 작아야 합니다."], // StopSign    , Ok
  ["USER-1010", "등록 또는 변경한 내용을 저장하겠습니까?"], // Question    , YesNo
  ["USER-1011", "(#{1})은/는 익일 이후로 입력해야 합니다."], // StopSign    , Ok
  ["USER-1012", "결과값이 여러 개 입니다.<br>시스템 관리자에게 문의 바랍니다."],  // StopSign   , Ok
  ["USER-1013", "데이타 조회 후 신규 등록이 가능합니다."], // Information , Ok
  ["USER-1014", "(#{1}:#{2})은/는 존재하지 않습니다."], // StopSign    , Ok
  ["USER-1015", "시작일은 종료일보다 작아야 합니다."], // StopSign    , Ok
  ["USER-1016", "(#{1})은/는 소수점(#{2}) 자리를 입력해야 합니다."], // StopSign    , Ok
  ["USER-1017", "(#{1})은/는 입력할 수 없습니다."], // StopSign    , Ok
  ["USER-1018", "(#{1}:#{2})은/는 중복됩니다."], // StopSign    , Ok
  ["USER-1019", "삭제 할 데이터가 없습니다."], // StopSign    , Ok
  ["USER-1020", "[#{1}]은(는) [#{2}]보다 크거나 같아야 합니다."], // StopSign    , Ok
  ["USER-1021", "[#{1}]은(는) [#{2}]보다 작거나 같아야 합니다."], // StopSign    , Ok
  ["USER-1022", "해당 #{1}코드 유효기간 : [#{2}]~[#{3}]<br>확인 후 다시 선택하십시오."],  // StopSign    , Ok
  ["USER-1023", "선택한 항목을 삭제하겠습니까?"], // Question    , YesNo
  ["USER-1024", "확정(확정취소)하시겠습니까?"], // Question    , YesNo
  ["USER-1025", "조회 후 신규 등록이 가능합니다."], // Information , Ok
  ["USER-1026", "(#{1}:#{2})은/는 삭제할 수 없습니다."], // StopSign    , Ok
  ["USER-1027", "(#{1}:#{2}자리)의 자리수가 잘못되었습니다."], // StopSign    , Ok
  ["USER-1028", "저장할 내용이 없습니다."], // StopSign    , Ok
  ["USER-1029", "(#{1}:#{2})은/는 변경할 수 없습니다."], // StopSign    , Ok
  ["USER-1030", "(#{1})은/는 금일 이후로 입력해야 합니다."], // StopSign    , Ok
  ["USER-1031", "출력 할 데이터가 없습니다."], // StopSign    , Ok
  ["USER-1032", "(#{1})를 삭제하겠습니까?"], // Question    , YesNo
  ["USER-1033", "(#{1})을/를 저장에 실패했습니다"], // StopSign    , Ok
  ["USER-1034", "시스템오류 입니다.. 전산실로 연락 바랍니다."], // StopSign    , Ok
  ["USER-1035", "권한이 없는 #{1}입니다."], // StopSign    , Ok
  ["USER-1036", "존재하지 않는 #{1}입니다."], // StopSign    , Ok
  ["USER-1037", "(#{1}) 건 확정(확정취소) 처리되었습니다"], // Question    , YesNo
  ["USER-1038", "#{1} 결산은  #{2}월만 입력가능합니다."], // 결산구분 입력제한
  ["USER-1039", "이미 등록된 행은 삭제하실수 없습니다."], // Information , Ok
  ["USER-1040", "동일한 과세구분만 등록하실수 있습니다."], // Information , Ok
  ["USER-1041", "(#{1})을(를) 확인하시기 바랍니다."], // StopSign    , Ok
  ["USER-1042", "신규 입력(행추가)시 [#{1}]은/는 반드시 선택해야 합니다."], // Information , Ok
  ["USER-1043", "저장할 내용이 있습니다. 저장하시겠습니까?"], // StopSign    , Ok
  ["USER-1044", "중복된 데이터가 있습니다."], // StopSign    , Ok
  ["USER-1045", "#{1}을/를 먼저 선택하여 주십시오"], // StopSign    , Ok
  ["USER-1046", "하위 데이터가 있습니다. <br> 하위 데이터를  먼저 삭제하여 주십시오"], // StopSign    , Ok
  ["USER-1047", "#{1}자이상 입력하십시오"], // StopSign    , Ok
  ["USER-1048", "#{1}자이하 입력하십시오"], // StopSign    , Ok
  ["USER-1049", "변경 된 상세 내역이 존재합니다.<br> 이동  하시겠습니까?"], // StopSign    , YESNO
  ["USER-1050", "변경 된 상세 내역이 존재합니다.<br> 신규 작성  하시겠습니까?"], // StopSign    , YESNO
  ["USER-1051", "초기화 하시겠습니까?"], // StopSign    , YESNO
  ["USER-1052", "신규 입력 데이터만 삭제 가능 합니다."], // StopSign    , Ok
  ["USER-1053", "#{1}은/는 #{2}자이상으로 입력하십시오"], // StopSign    , Ok
  ["USER-1054", "#{1}은/는 #{2}자이하로 입력하십시오"], // StopSign    , Ok
  ["USER-1055", "회원을 검색후 조회 바랍니다."], // StopSign    , Ok
  ["USER-1056", "변경 된 상세 내역이 존재합니다.<br> 삭제  하시겠습니까?"], // StopSign    , YESNO
  ["USER-1057", "#{1}은/는 하나만 존재해야 합니다."], //  StopSign    , Ok
  ["USER-1058", "저장되지 않은 마스터 정보가 1건 이상 존재 합니다. <br> 저장후 등록하세요"], //  StopSign    , Ok
  ["USER-1059", "변경 된 상세 내역이 존재합니다.<br> 조회  하시겠습니까?"], //  StopSign    , Ok
  ["USER-1060", "이미 등록된 정보는 삭제되고 재생성됩니다. <br>#{1}을/를 실행하시겠습니까?"], //  StopSign    , Ok
  ["USER-1061", "(#{1})은/는 유효하지 않는 날짜입니다."], // StopSign    , Ok
  ["USER-1062", "신규 추가할 정보가 없습니다. 확인바랍니다."], // StopSign    , Ok
  ["USER-1063", "변경 된 상세 내역이 존재합니다.<br> #{1}을/를 변경  하시겠습니까?"], // StopSign    , YESNO
  ["USER-1064", "#{1}을/를 변경하면 #{2}이/가 삭제됩니다. <br> #{1}을/를 변경  하시겠습니까?"], // StopSign    , YESNO
  ["USER-1065", "#{1}을/를  입력해주시기 바랍니다."], // StopSign    , YESNO
  ["USER-1066", "중복된  데이터는 삭제됩니다."], // StopSign    , YESNO
  ["USER-1067", "#{1}을/를 입력할 수 없습니다."], // StopSign    , YESNO
  ["USER-1068", "#{1}마감되어 #{2}등록/수정이 불가능합니다."], // StopSign    , Ok
  ["USER-1069", "유효하지 않는  #{1}입니다.<br>확인바랍니다."], // StopSign    , Ok
  ["USER-1070", "신규 입력 데이터만 #{1}가 가능 합니다."], // StopSign    , Ok
  ["USER-1071", "#{1}이/가 존재하여 삭제할수 없습니다."], // StopSign    , Ok
  ["USER-1072", "저장되지 않았습니다. <br> 새로 등록하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1073", "저장되지 않았습니다. <br> 새로 조회하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1074", "변경내역이 있습니다. <br> 이동하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1075", "데이터 조회 후 #{1}이/가 가능합니다."], // Information , Ok
  ["USER-1076", "적용시작일은 #{1}일 이후로 입력해야 합니다."], // StopSign    , Ok
  ["USER-1077", "수정 중 이동 할 수 없습니다."], // StopSign    , Ok
  ["USER-1078", "신규데이터 입력은 1건만 가능합니다."], // StopSign    , Ok
  ["USER-1079", "#{1} 할 데이터가 없습니다."], // StopSign    , Ok
  ["USER-1080", "변경 된 데이터가 없습니다."], // StopSign    , Ok
  ["USER-1081", "품번 최저마진이 #{1}%입니다.<br>&nbsp;#{1}% 이상 입력하세요."], // StopSign    , Ok
  ["USER-1082", "엑셀 데이터를 업로드 하시겠습니까?"], // StopSign    , Ok
  ["USER-1083", "#{1}마감되어 #{2}확정/확정취소가  불가능합니다." ], // StopSign , YESNO
  ["USER-1084", "변경내역이 있습니다. <br> 조회  하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1085", "변경내역이 있습니다. <br> 신규작성  하시겠습니까?"], //  question    , YESNO
  ["USER-1086", "변경내역이 있습니다. <br> 업로드  하시겠습니까?"], //  question    , YESNO
  ["USER-1087", "세금계산서 발행기간정보가 없습니다. <br> 확인바랍니다."], //  question    , OK
  ["USER-1088", "세금계산서 발행기간이 아닙니다.  <br> 확인바랍니다."], //  question    , OK
  ["USER-1089", "[#{1}]은/는 [#{2}]와/과 같아야 합니다."], //  question    , OK
  ["USER-1090", "확정할 데이터를 선택하세요"], //  StopSign    , OK
  ["USER-1091", "변경 된 상세 내역이 존재합니다.<br> 저장 후 실행 하세요."], //  Information    , OK
  ["USER-1092", "[#{1}]은/는 [#{2}]와/과 같지 않아야 합니다."], //  question    , OK
  ["USER-1093", "실사재고기간에만 등록가능합니다."], //  Information    , OK
  ["USER-1094", "#{1}이/가 존재하여 저장할수 없습니다."], // StopSign    , Ok
  ["USER-1095", "변경내역이 있습니다. <br> 창을 닫으시겠습니까?"], //  StopSign    , YESNO
  ["USER-1096", "변경 된 내역이 존재합니다.<br> 저장 후 실행 하세요."], //  Information    , OK
  ["USER-1097", "전송처리 하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1098", "E-Mail 재전송 하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1099", "취소요청 하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1100", "발행요청, 미승인 상태에서만  <br>  취소요청이 가능합니다."], //  Information    , OK
  ["USER-1110", "발행요청, 미승인, 승인 상태에서만 <br>  E-Mail 재전송이 가능합니다."], //  Information    , OK
  ["USER-1120", "계산서등록 상태에서만 전송이 가능합니다."], //  Information    , OK
  ["USER-1130", "계산서등록, 취소, 발행에러 상태에서만  #{1}이/가 가능합니다."], //  Information    , OK
  ["USER-1140", "#{1}마감되어야  <br> #{2}생성이 가능합니다."], // StopSign    , Ok
  ["USER-1150", "#{1}마감되어 #{2}이/가 불가능합니다."], // StopSign    , Ok
  ["USER-1160", "확정된 발주전표는 삭제할 수 없습니다."], // StopSign    , Ok
  ["USER-1170", "당일 등록건만 삭제할 수 있습니다."], // StopSign    , Ok
  ["USER-1180", "(#{1})은/는 금일이나 금일이후로 입력해야 합니다."], // StopSign    , Ok
  ["USER-1181", "수입원가 확정되었습니다. <br> 확인바랍니다."], // StopSign    , Ok
  ["USER-1182", "수입제경비 확정되었습니다. <br> 확인바랍니다."], // StopSign    , Ok
  ["USER-1183", "OFFER 마감이 아닙니다. <br> 확인바랍니다."], // StopSign    , Ok
  ["USER-1184", "수입제경비 확정이 아닙니다. <br> 확인바랍니다."], // StopSign    , Ok
  ["USER-1185", "#{1}배부기준안을 복사하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1186", "해당 OFFER의 최종 입고월과 원가확정월이 같지 않으면 확정할수 없습니다.<br> 확인바랍니다."], // StopSign    , Ok
  ["USER-1187", "검품확정 하시겠습니까?"], // Question    , YesNo
  ["USER-1188", "신규작성을 취소하고 창을 닫겠습니까?"], //  StopSign    , YESNO
  ["USER-1189", "동일 품번에 동일 단품은 등록할 수 없습니다."], // StopSign    , Ok
  ["USER-1190", "#{1}은/는 #{2}내의 일자만 입력가능 합니다."], // StopSign    , Ok
  ["USER-1191", "#{1}을/를 복사하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1192", "등록된 내역이 있어 복사할 수 없습니다. <br> 확인바랍니다."], // StopSign    , Ok
  ["USER-1193", "전월등록된  내역이 없어 복사할 수 없습니다. <br> 확인바랍니다."], // StopSign    , Ok
  ["USER-1194", "월평가내역이 확정되어 #{1}이/가 불가능합니다. <br> 확인바랍니다."], // StopSign    , Ok
  ["USER-1195", "#{1}이 등록되지 않았습니다. <br> 등록후 #{2} 하세요."], // StopSign    , Ok
  ["USER-1196", "수정작성을 취소하고  창을 닫으시겠습니까?"], //  StopSign    , YESNO
  ["USER-1197", "승인/반려 하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1198", "승인취소 하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1199", "(#{1}) 건  승인취소 처리되었습니다"], // Question    , YesNo
  ["USER-1200", "(#{1}) 건  승인  처리되었습니다"], // Question    , YesNo
  ["USER-1201", "(#{1}) 건  반려  처리되었습니다"], // StopSign    , Ok
  ["USER-1202", "(#{1}) 건  확정  처리되었습니다"], // StopSign    , Ok
  ["USER-1203", "(#{1}) 건  확정취소  처리되었습니다"], // StopSign    , Ok
  ["USER-1204", "처리 하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1205", "확정 하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1206", "확정취소 하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1207", "이미확정된 전표 입니다."], //  StopSign    , YESNO
  ["USER-1208", "단품정보를 선택해주세요."], //  StopSign    , YESNO
  ["USER-1209", "품목정보를 선택해주세요."], //  StopSign    , YESNO
  ["USER-1210", "출력할 전표를 선택해주세요."], //  StopSign    , YESNO
  ["USER-1211", "출력할 데이터를 선택해주세요."], //  StopSign    , YESNO
  ["USER-1212", "정말 (#{1}) 하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1213", "발주일과 검품확정일의 월이 다를 경우 <br> 발주월의 마지막일로만 검품확정 가능합니다."], //  StopSign    , YESNO
  ["USER-1214", "발주월의 마지막일로만 <br> 검품확정 가능합니다."], //  StopSign    , YESNO
  ["USER-1215", "확정/반려 하시겠습니까?"], //  StopSign    , YESNO
  ["USER-1216", "발행요청, 미승인, 반송 상태에서만  <br>  취소요청이 가능합니다."], //  Information    , OK
  ["USER-1217", "발행요청, 미승인, 승인, 반송 상태에서만  <br>  취소요청이 가능합니다."], //  Information    , OK
  ["USER-1218", "이미 확정된 발주전표 입니다. <br> 확정된 발주전표는 수정 할 수 없습니다."], // StopSign    , Ok
  ["USER-1219", "(#{1})상태인 전표입니다.<br> 재 조회하시기 바랍니다."], // StopSign    , Ok
  ["USER-1220", "#{1}마감되어 검품확정 할 수 없습니다."], // StopSign    , Ok
  ["USER-1221", "품번유형이 정상, F&B일 경우만 등록 가능합니다."], // StopSign    , Ok
  ["USER-1222", "(#{1})건 복사하였습니다."], // StopSign    , Ok
  ["USER-1223", "당일의 등록건만 수정할 수 있습니다."], // StopSign    , Ok
  ["USER-1224", "오류 사항이 존재합니다.<br> 확정할 수 없습니다."], // StopSign    , Ok
  ["USER-1225", "이미 저장된 내용입니다."], // StopSign    , Ok
  ["USER-1226", "확정 처리되어 삭제할 수 없습니다."], // StopSign    , Ok
  ["USER-1227", "전산처리 되어 확정 취소 할 수 없습니다."], // StopSign    , Ok
  ["USER-1228", "해당 브랜드의 형지 아트몰링 이익율<br> 정보가 없습니다.<br> 확인바랍니다."], // StopSign    , Ok
  ["USER-1229", "해당 브랜드의 형지 아트몰링 수수료<br> 정보가 없습니다.<br> 확인바랍니다."], // StopSign    , Ok
  
  //USER VALIDATION CHECK MARIO OUTLET 추가
  ["USER-2000", "변경된 내용이 있습니다. 저장하시겠습니까?"], // Question    , YesNoCancel
  ["USER-2001", "#{1}일의 근태값을 [ #{2} ]에서 [ #{3} ]으로 수정하시겠습니까? "], // Question    , YesNoCancel
  ["USER-2002", "특정매입인 경우만 등록 가능합니다."], // StopSign    , Ok
  ["USER-2003", "직매입, 특정매입인 경우만 등록 가능합니다."], // StopSign    , Ok

  //공통 스크립트 사용시 오류 메세지 : *************** Don't use (공통에서 사용) ***************
  ["SCRIPT-1000" , "#{1}"],
  ["SCRIPT-1001" , "<font color=red><b>스크립트 오류입니다.</b></font><br>시스템 관리자에게 연락바랍니다.<br><label style='cursor:hand;' onClick='viewDetail();'><font color=blue><b>[상세보기]</b></font></label>를 누르면 자세한 내용을 확인 할 수 있습니다."],
  ["SCRIPT-1002" , "달력을 오픈하는 함수(openCal)의 인자값 : 2개 <br> 1번째 : HTML('H'), MASKEDIT('G')<br> 2번째 : 날짜를 지정할 객체"],
  ["SCRIPT-1004" , "Run() Error : <br> setAction 함수를 이용하여 <br> Request Parameter을 지정해야 합니다."],
  ["SCRIPT-1005" , "Run() Error : <br> setMode 함수를 이용하여 <br> Transaction Mode을 지정해야 합니다."],
  ["SCRIPT-1006" , "Run() Error : <br> setParam 함수를 이용하여 <br> Gauce Parameter을 지정해야 합니다."],
  ["SCRIPT-1007" , "Run() Error : <br> setInValue, SetOutValue 함수를 이용하여 <br>트랜젝션객체를 지정해야 합니다."],
  ["SCRIPT-1008" , "트랜잭션 종류를 확인 후 TRNS.setMode()의 함수의 인자값을 지정해야합니다."],
  ["SCRIPT-1009" , "점포코드[#{1}]의 조직구분을 가져올 수 없습니다."],
  ["SCRIPT-1010" , "ID=[#{1}]에 Title 속성을 지정해야 합니다."],
  ["SCRIPT-1011" , "구분을 다음과 같이 입력해야 합니다.<br>"],
  ["SCRIPT-1012" , "[#{1}] 함수의 인자값 중 기준일자를 정확히 입력해야 합니다."],
  ["SCRIPT-1013" , "ID=[#{1}]에 MaxLength 속성을 지정해야 합니다."],
  ["SCRIPT-1014" , "EXCEL로 저장할 내용이 없습니다.<br>조회 후 작업해야 합니다."],
  ['','','','','']];

//Map에 _ErrorMessage 내용 넣기
_putErrorMessage(_ErrorMessage);

/**
* putErrorMessage
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : Map Object에 ErrorMessage 적재
* return값 : Void
*/
function _putErrorMessage(msgMap) {
  for (var i=0, n=msgMap.length; i<n;i++){
    var key = msgMap[i][0]; //ERROR CODE
    var msg = msgMap[i][1]; //ERROR MESSAGE
    _ErrorMap.put(key, msg);
  }
}

/**
* parsetMessage
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : ERRORMESSAGE Map에서 에러 내용에 해당하는 String 문자열을 Replace 한다.
* return값 :
*/
function _parseMessage(argKey) {
  var msg = _ErrorMap.get(argKey[0]);
  for (var i=1, n=argKey.length; i<n; i++) {
    msg = msg.replace(eval("/#{(" + i.toString() + ")}/g"), argKey[i]);
  }
  return msg;
}

/**
* `
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : 공통 에러 POPUP OPEN
* return값 :
*/
function showMessage() {
	
	var strReturn  = "";
	var strIcon    = arguments[0];
	var strButton  = arguments[1];
	var strMsgCode = arguments[2];
	var rtn;
	
	//Server Type을 정확하게 입력하지 않았을 경우 처리
	if (strMsgCode.indexOf("-") == -1){
		strReturn = 0;
		alert("메세지 코드가 존재하지 않습니다.\n\n메세지 코드를 확인");
		if(blnFocus) {
			setTimeout("LASTFOCUSEDOBJ.Focus()");
		}
		return strReturn;
	}
	var strErrorType = strMsgCode.substring(0, strMsgCode.indexOf("-"));

	switch (strErrorType) {
		case "SERVER" :	// SERVER TYPE ERROR
			var blnFocus = false;
			var blnSessionError = false;
			var strServerErrorCode = "";

			if(hasFocusObject()) {
				blnFocus = true;
			}

			var objParseMsg = new Array();
			var poparg = new Array();
			var strServerMsg = "";
			var strMsg = "";
			var objGauce = arguments[3];
			//var strTempOne  = "";
			//var strTempTwo  = "";
			var strIndex = 0;
			objParseMsg.push(strMsgCode);

			for(var i=4,n=arguments.length;i<n;i++){
				objParseMsg.push(arguments[i]);
			}
			/*
			strTempOne = objGauce.ErrorMsg;
			strTempTwo = strTempOne.split(";");
			if(strTempTwo.length >= 1){
				if (strTempTwo[0].indexOf("ORA-") != -1){
					strTempOne = strTempTwo[0].substring(strTempTwo[0].indexOf("ORA-"), strTempTwo[0].length);
					strServerMsg = strServerMsg + '에러 메세지 : ' + strTempOne + '\n';
				} else {
					strServerMsg = strServerMsg + '에러 메세지 : ' + objGauce.ErrorMsg + '\n';
				}
			} else {
				strServerMsg = strServerMsg + '에러 메세지 : ' + objGauce.ErrorMsg + '\n';
			}

			for (var i=0, n=objGauce.SrvErrCount("SESSION");i<n; i++) {
				if (objGauce.SrvErrCode("SESSION", i) == "3001" ||
					objGauce.SrvErrCode("SESSION", i) == "3002" ||
					objGauce.SrvErrCode("SESSION", i) == "3003" ||
					objGauce.SrvErrCode("SESSION", i) == "3004" ) {
						strServerErrorCode = objGauce.SrvErrCode("SESSION", i);
						blnSessionError = true;
						continue;
				}
			}
			*/
			strServerMsg = strServerMsg + '[서버 에러]\n  메세지 : ' + objGauce + '\n';
			if (blnSessionError){
				objParseMsg = new Array();
				strMsgCode = "SERVER-" + strServerErrorCode;
				objParseMsg.push(strMsgCode);
				strMsg = _parseMessage(objParseMsg);
				strMsg = "&nbsp;" + strMsg;

				poparg.push(strIcon);
				poparg.push(strButton);
				poparg.push(strMsgCode);
				poparg.push(strMsg);
			} else {
				strMsg = _parseMessage(objParseMsg);
				strMsg = "&nbsp;" + strMsg;
				poparg.push(strIcon);
				poparg.push(strButton);
				poparg.push(strMsgCode);
				poparg.push(strMsg);
			}
			poparg.push(strServerMsg);
			poparg.push(document.URL);
			rtn = showModalDialog("/pot/jsp/error.jsp", poparg,"dialogWidth:400px;dialogHeight:" + strErrDialogHeight + "px;scroll:no;resizable:yes;help:no;unadorned:no;center:yes;status:no;dialogHide:yes");
			if (blnSessionError) {
				if (strServerErrorCode == "3002"){
					document.location.host = SSOHOST + ":" + SSOPORT;
					document.location.hostname = SSOHOST;
					document.location.port = SSOPORT;
				   //여기에 로그인 페이지로 이동하는 루틴 넣을것
				}
			} else {
				 if(blnFocus) {
					 setTimeout("LASTFOCUSEDOBJ.Focus()");
				 }
			}
			//return rtn;
			break;

		case "GAUCE" : // GAUCE TYPE ERROR
			var blnFocus = false;
			if(hasFocusObject()) {
				blnFocus = true;
			}

			var objParseMsg = new Array();
			var poparg = new Array();
			var strMsg = "";

  	        objParseMsg.push(strMsgCode);
			for(var i=3, n=arguments.length;i<n;i++){
				objParseMsg.push(arguments[i]);
			}
			strMsg = _parseMessage(objParseMsg);
			strMsg = "&nbsp;" + strMsg;

			poparg.push(strIcon);
			poparg.push(strButton);
			poparg.push(strMsgCode);
			poparg.push(strMsg);

			rtn = showModalDialog("/pot/jsp/error.jsp",poparg,"dialogWidth:400px;dialogHeight:" + strErrDialogHeight + "px;scroll:no;resizable:yes;help:no;unadorned:no;center:yes;status:no;dialogHide:yes");
			
			if(blnFocus) {
				setTimeout("LASTFOCUSEDOBJ.Focus()");
			}
			//return rtn;
			break;

		case "SCRIPT" : // SCRIPT TYPE ERROR
			if (strMsgCode == "SCRIPT-1001"){
				var blnFocus = false;
				
				if(hasFocusObject()) {
					blnFocus = true;
				}
				
				var objParseMsg = new Array();
				var strMsg = "";
				var strServerMsg = "";
				var error = arguments[3];
				var poparg = new Array();
				objParseMsg.push(strMsgCode);
				strMsg = _parseMessage(objParseMsg);
				strMsg = "&nbsp;" + strMsg;
				strServerMsg += "[스크립트 에러]\n  메세지 : " + error[0] + '\n';
				strServerMsg += "  URL    : " + error[1] + '\n';
				strServerMsg += "  라  인 : " + error[2] + '\n';
				poparg.push(strIcon);
				poparg.push(strButton);
				poparg.push(strMsgCode);
				poparg.push(strMsg);
				poparg.push(strServerMsg);
				poparg.push(document.URL);
				rtn = showModalDialog("/pot/jsp/error.jsp", poparg,"dialogWidth:400px;dialogHeight:" + strErrDialogHeight + "px;scroll:no;resizable:yes;help:no;unadorned:no;center:yes;status:no;dialogHide:yes");
				
				if(blnFocus) {
					setTimeout("LASTFOCUSEDOBJ.Focus()");
				}
				
				//return rtn;
			} else {
				var blnFocus = false;
				if(hasFocusObject()) {
					blnFocus = true;
				}
				var objParseMsg = new Array();
				var poparg = new Array();
				var strMsg = "";
				var strServerMsg = "";
				objParseMsg.push(strMsgCode);
				for(var i=3, n=arguments.length;i<n;i++){
					objParseMsg.push(arguments[i]);
				}
				strMsg = _parseMessage(objParseMsg);
				strMsg = "&nbsp;" + strMsg;
				poparg.push(strIcon);
				poparg.push(strButton);
				poparg.push(strMsgCode);
				poparg.push(strMsg);
				poparg.push("");
				poparg.push(document.URL);
				rtn = showModalDialog("/pot/jsp/error.jsp",poparg,"dialogWidth:400px;dialogHeight:" + strErrDialogHeight + "px;scroll:no;resizable:yes;help:no;unadorned:no;center:yes;status:no;dialogHide:yes");

				if(blnFocus) {
					setTimeout("LASTFOCUSEDOBJ.Focus()");
				}
				//return rtn;
			}
			break;
		case "USER" :	// USER TYPE ERROR
			var blnFocus = false;

			if(hasFocusObject()) {
				blnFocus = true;
			}

			var objParseMsg = new Array();
			var poparg = new Array();
			var strMsg = "";

			objParseMsg.push(strMsgCode);
			for(var i=3, n=arguments.length;i<n;i++){
				objParseMsg.push(arguments[i]);
			}

			strMsg = _parseMessage(objParseMsg);
			strMsg = "&nbsp;" + strMsg;

			if (strMsg.indexOf("50045")>0) {
				strMsgCode = "GAUCE-1009";
				strMsg = "다른사용자가 동일아이디로 접속하셨거나 세션이 타임아웃 되었습니다.";
			}

			poparg.push(strIcon);
			poparg.push(strButton);
			poparg.push(strMsgCode);
			poparg.push(strMsg);

			// 메세지 줄수에 따른 창크기 세팅
			// var rowCnt = strMsg.split("<br>").length;
			// strErrDialogHeight = strErrDialogHeight + (17 * rowCnt);

			//여기서 소켓 에러 발생
			rtn = showModalDialog("/pot/jsp/error.jsp",poparg,"dialogWidth:400px;dialogHeight:" + strErrDialogHeight + "px;scroll:no;resizable:yes;help:no;unadorned:no;center:yes;status:no;dialogHide:yes");

			if(blnFocus) {
				setTimeout("LASTFOCUSEDOBJ.Focus()");
			}

			//return rtn;
			break;
		default :
			break;
	}

	return rtn;
}

/**
* parseGauceHeader
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : XML로 생성 Grid의 데이터 Validation 체크를 위하여 반드시 선언해야되는 부분
*/
function makeGauceErrorMsg(objDataSet, objGrid, row, colid){
  if (objGrid == ""){
    showMessage(STOPSIGN, OK, "GAUCE-1000", objDataSet.ErrorMsg);
    return false;
  } else {
    var strErrorCode  = objDataSet.ErrorCode;
    switch(strErrorCode){
      case 50018 : // Not Null Error
        var strHeaderName = objGrid.ColumnProp(colid, 'Name').replace(/\\/gi, "");
        if (strHeaderName == undefined || strHeaderName == "Unknown"){
          showMessage(STOPSIGN, OK, "GAUCE-1005", colid);
        } else {
          showMessage(STOPSIGN, OK, "GAUCE-1005", strHeaderName);
        }

        objGrid.Focus();
        objGrid.SetColumn(colid);
        return false;
        break;
      case 50019 : // Duplication Error
        var strMsg = "(";
        var intCnt = 0;
        for (var i=1, n=objDataSet.CountColumn;i<=n;i++){
          if (objDataSet.ColumnProp(i) == 2){
            if (objGrid.ColumnProp(objDataSet.ColumnID(i),'Name') != undefined) {
              intCnt++;
              strMsg = strMsg + objGrid.ColumnProp(objDataSet.ColumnID(i),'Name') + ":" + objDataSet.NameValue(row, objDataSet.ColumnID(i)) + ", ";
            }
          }
        }

        strMsg = strMsg.substr(0, strMsg.length -2);
        strMsg = strMsg + ")은/는 중복됩니다.";
        if (intCnt > 0){
          showMessage(STOPSIGN, OK, "GAUCE-1000", strMsg);
        } else {
          showMessage(STOPSIGN, OK, "GAUCE-1007", row);
        }
        objGrid.Focus();
        return false;
        break;
      case 50025 : //Gauce Bug Error
        showMessage(STOPSIGN, OK, "GAUCE-1000", objDataSet.ErrorMsg);
        objGrid.Focus();
        if (colid != "Unknown"){
          objGrid.SetColumn(colid);
        }
        return false;
        break;
      default :
        showMessage(STOPSIGN, OK, "GAUCE-1000", objDataSet.ErrorMsg);
        return false;
        break;
    }
  }
  return true;
}
