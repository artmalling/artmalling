<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주관리 > 규격단품 통합발주 등록
 * 작 성 일 : 2010.04.04
 * 작 성 자 : 김 경 은
 * 수 정 자 : 
 * 파 일 명 : pord1140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 규격단품으로 관리하는 상품의 통합 발주 등록한다.
 * 이    력 :
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var strBuyerYN        = "";                            // 바이어/SM일 경우 (Y)
var strToday          = "";                            // 현재날짜
var strSlipNo         = "";                            // 발주번호
var roundFlag         = "";                            // 반올림 구분 (1:원단위미만반올림, 2:원단위미만버림, 3:원단위미만올림)
var strStrCd          = "";                            // 본사점
var strFStrCd         = "";                            // 점입점
var strInOutYN        = "";                            // 통합발주 가능여부 (Y:가능)
var strSumText        = "";                            // GR_DETAIL 합계(차익율)
var blnSkuChanged     = false;                         // 단품코드 변경 여부
var intSearchCnt      = 0;                             // 조회버튼클릭 여부(0일 경우 마스터조회 건수)
var bfListRowPosition = 0;                             // 이전 List Row Position

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자    : 김경은
 * 작 성 일     : 2010-04-04
 * 개    요        : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){

    strToday = getTodayDB("DS_O_RESULT");
    // Input Data Set Header 초기화
     
    // Output Data Set Header 초기화
    DS_O_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    DS_O_SKU_INFO.setDataHeader('<gauce:dataset name="H_SKU_INFO"/>');
    DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
           
    // 그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    
         
    // EMedit에 초기화 (조회용) 
    initEmEdit(EM_S_START_DT          ,"SYYYYMMDD"        ,PK);             // 조회기간1
    initEmEdit(EM_S_END_DT            ,"TODAY"            ,PK);             // 조회기간2
    initEmEdit(EM_S_PB_CD             ,"000000"           ,NORMAL);         // 브랜드코드
    initEmEdit(EM_S_PB_NM             ,"GEN"              ,READ);           // 브랜드명     
    initEmEdit(EM_S_VEN_CD            ,"000000"           ,NORMAL);         // 협력사코드
    initEmEdit(EM_S_VEN_NM            ,"GEN"              ,READ);           // 협력사코드명
    initEmEdit(EM_S_SLIP_NO           ,"0000-0-0000000"   ,NORMAL);         // 전표번호

    // EMedit에 초기화 (입력용)
    initEmEdit(EM_SLIP_NO             ,"0000-0-0000000"   ,READ);           // 전표번호  
    initEmEdit(EM_SLIP_PROC_STAT_NM   ,"GEN^40"           ,READ);           // 전표상태  
    initEmEdit(EM_PAIR_SLIP_NO        ,"0000-0-0000000"   ,READ);           // 상대전표번호
    initEmEdit(EM_P_SLIP_PROC_STAT_NM ,"GEN^40"           ,READ);           // 상대전표상태  
    initEmEdit(EM_PUMBUN_CD           ,"000000"           ,PK);             // 브랜드코드  
    initEmEdit(EM_PUMBUN_NM           ,"GEN"              ,READ);           // 브랜드명
    initEmEdit(EM_BUYER_CD            ,"GEN"              ,READ);           // 바이어코드
    initEmEdit(EM_BUYER_NM            ,"GEN"              ,READ);           // 바이어명
    initEmEdit(EM_BIZ_TYPE_NM         ,"GEN"              ,READ);           // 거래형태
    initEmEdit(EM_TAX_FLAG_NM         ,"GEN"              ,READ);           // 과세구분
    initEmEdit(EM_ORD_FLAG            ,"GEN"              ,READ);           // 발주구분
    initEmEdit(EM_VEN_CD              ,"000000"           ,PK);             // 협력사코드
    initEmEdit(EM_VEN_NM              ,"GEN"              ,READ);           // 협력사명
    initEmEdit(EM_ORD_OWN_FLAG        ,"GEN"              ,READ);           // 발주주체
    initEmEdit(EM_ORD_DT              ,"YYYYMMDD"         ,PK);             // 발주일
    initEmEdit(EM_CONF_DT             ,"YYYYMMDD"         ,READ);           // 발주확정일
    initEmEdit(EM_DELI_DT             ,"YYYYMMDD"         ,PK);             // 납품예정일
    initEmEdit(EM_PRC_APP_DT          ,"YYYYMMDD"         ,PK);             // 가격적용일
    initEmEdit(EM_CHK_DT              ,"YYYYMMDD"         ,READ);           // 검품확정일
    initEmEdit(EM_GAP_TOT_AMT         ,"NUMBER^13^0"      ,READ);           // 차익액 
    initEmEdit(EM_GAP_RATE            ,"NUMBER^3^2"       ,READ);           // 차익율
    initEmEdit(EM_TOT_QTY             ,"NUMBER^13^0"      ,READ);           // 수량계
    initEmEdit(EM_TOT_COST_AMT        ,"NUMBER^13^0"      ,READ);           // 원가계
    initEmEdit(EM_TOT_SALE_AMT        ,"NUMBER^13^0"      ,READ);           // 매가계
    initEmEdit(EM_REMARK              ,"GEN^100"          ,NORMAL);         // 비고
                                       
    
    //콤보 초기화 (조회용)
    initComboStyle(LC_S_STR           ,DS_O_STR1          ,"CODE^0^30,NAME^0^80" ,1 ,PK);         // 점     
    initComboStyle(LC_S_BUMUN         ,DS_O_DEPT          ,"CODE^0^30,NAME^0^80" ,1 ,NORMAL);     // 팀     
    initComboStyle(LC_S_TEAM          ,DS_O_TEAM          ,"CODE^0^30,NAME^0^80" ,1 ,NORMAL);     // 파트     
    initComboStyle(LC_S_PC            ,DS_O_PC            ,"CODE^0^30,NAME^0^80" ,1 ,NORMAL);     // PC     
    initComboStyle(LC_S_GJDATE_TYPE   ,DS_O_GJDATE_TYPE   ,"CODE^0^30,NAME^0^80" ,1 ,PK);         // 기준일     
    initComboStyle(LC_S_S_PROC_STAT   ,DS_O_S_PROC_STAT   ,"CODE^0^30,NAME^0^80" ,1 ,NORMAL);     // 전표상태     
                                       
    // 콤보초기화 (입력용)                     
    initComboStyle(LC_STR             ,DS_O_STR1          ,"CODE^0^30,NAME^0^80" ,1 ,PK);        // 본사점 
    initComboStyle(LC_PAIR_STR        ,DS_O_STR2          ,"CODE^0^30,NAME^0^80" ,1 ,PK);        // 점입점 
    initComboStyle(LC_AFT_ORD_FLAG    ,DS_O_AFT_ORD_FLAG  ,"CODE^0^30,NAME^0^80" ,1 ,PK);        // 사후구분 
    initComboStyle(LC_PAY_COND        ,DS_O_PAY_COND      ,"CODE^0^30,NAME^0^80" ,1 ,PK);        // 지불구분 
    
    //공통코드에서 데이터 가지고 오기
    getEtcCode("DS_O_GJDATE_TYPE"     ,"D" ,"P214" ,"N");       // 기준일
    getEtcCode("DS_O_S_PROC_STAT"     ,"D" ,"P207" ,"Y");       // 전표상태
    getEtcCode("DS_O_AFT_ORD_FLAG"    ,"D" ,"P209" ,"N");       // 사전사후구분
    getEtcCode("DS_O_PAY_COND"        ,"D" ,"P212" ,"N");       // 지불구분 
    getEtcCode("DS_O_BIZ_TYPE"        ,"D" ,"P002" ,"N");       // 거래형태 
    getEtcCode("DS_O_TAX_FLAG"        ,"D" ,"P004" ,"N");       // 과세구분
    getEtcCode("DS_O_ORD_FLAG"        ,"D" ,"P203" ,"N");       // 발주구분 
    getEtcCode("DS_O_ORD_OWN_FLAG"    ,"D" ,"P202" ,"N");       // 발주주체구분 
    
    EM_BIZ_TYPE.style.display = "none";
    EM_TAX_FLAG.style.display = "none";
    
    getStore("DS_O_STR1", "Y", "0", "N");           // 본사점
    getStore("DS_O_STR2", "Y", "1", "N","N");       // 점입점
    //getDept("DS_O_DEPT", "Y", LC_S_STR.BindColVal, "Y");                                              // 팀 
    //getTeam("DS_O_TEAM", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, "Y");                       // 파트  
    //getPc("DS_O_PC", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, LC_S_TEAM.BindColVal, "Y");     // PC  

    // LOAD시 마스터 비활성화
    setMasterObject(false);
    setDetailObject(false);
    enableControl(LC_AFT_ORD_FLAG, false);

    LC_S_STR.Index         = 0; 
    LC_S_BUMUN.Index       = 0;
    LC_S_TEAM.Index        = 0;
    LC_S_PC.Index          = 0;  
    LC_S_GJDATE_TYPE.Index = 0;
    LC_S_S_PROC_STAT.Index = 0;
    LC_S_STR.Focus();   
    
    registerUsingDataset("pord114","DS_O_LIST,DS_IO_MASTER,DS_IO_DETAIL");
 } 


 function gridCreate1(){
     var hdrProperies = '<FC>id=STR_NM             name="점"          width=42  align=left </FC>'
                      + '<FC>id=SLIP_FLAG_NM       name="구분"        width=35  BgColor={decode(REJ_CAN_FLAG,1,"#C8FFFF",2,"#D2D2D2")}  align=center </FC>'
                      + '<FC>id=SLIP_NO            name="전표번호"    width=93  align=center Mask="XXXX-X-XXXXXXX"</FC>'
                      + '<FC>id=ORD_DT             name="발주일"      width=80  align=center Mask="XXXX/XX/XX" </FC>'
                      + '<FC>id=SLIP_PROC_STAT_NM  name="전표상태"    width=80  align=left </FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드"        width=80  align=left </FC>';

     initGridStyle(GR_LIST, "common", hdrProperies, false);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}          name="NO"           width=30   align=center sumtext=""</FC>'
                      + '<FC>id=SEL               name="선택"         width=50    align=center  HeadCheckShow=true EditStyle=CheckBox</FC>'                 
                      + '<FC>id=SKU_CD            name="*단품코드"     width=120   align=center EditStyle=Popup sumtext="합계"</FC>'                           
                      + '<FC>id=SKU_NM            name="단품명"       width=100   align=left Edit=none </FC>'                           
                      + '<FC>id=ORD_UNIT_NM       name="단위"         width=40    align=left Edit=none </FC>'                           
                      + '<FC>id=ORD_QTY           name="*수량"        width=50    align=right Edit=Numeric sumtext=@sum </FC>'                           
                      + '<FG> name="원가 (부가세 제외)"'                                       
                      + '<FC>id=NEW_COST_PRC      name="*단가"         width=80    align=right edit={IF(COST_ZERO="Y","true","false")} </FC>'                        
                      + '<FC>id=NEW_COST_AMT      name="금액"         width=110   align=right Edit=none sumtext=@sum </FC>'                        
                      + '</FG> '                                                    
                      + '<FG> name="매가 (부가세 포함)"'                                       
                      + '<FC>id=NEW_SALE_PRC      name="*단가"         width=80    align=right edit={IF(SALE_ZERO="Y","true","false")} </FC>'                        
                      + '<FC>id=NEW_SALE_AMT      name="금액"         width=110   align=right Edit=none sumtext=@sum </FC>'                        
                      + '</FG> '                                                    
                      + '<FC>id=NEW_GAP_RATE      name="차익율"       width=80    align=right Edit=none  </FC>'   
                      + '<FC>id=AVG_SALE_QTY      name="평균판매량"   width=70    align=right Edit=none sumtext=@sum </FC>'                           
                      + '<FC>id=AVG_SALE_AMT      name="평균판매액"   width=110    align=right Edit=none sumtext=@sum </FC>'                           
                      + '<FC>id=ORD_STK_QTY       name="현재고"       width=50    align=right Edit=none sumtext=@sum </FC>';                           
     initGridStyle(GR_DETAIL, "common", hdrProperies, true);
 }

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-04
 * 개    요        : 조회시 필수 조회조건을 체크한 후 조회한다.
 * return값 : void
 */
function btn_Search() {
     // 변경, 추가내역이 있을 경우
     if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
         if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
            return;
     }
    
     if(checkValidation("Search")){
         DS_IO_MASTER.ClearData();  
         DS_IO_DETAIL.ClearData();
         intSearchCnt      = 0;
         bfListRowPosition = 0;
         getList();
         // 조회결과 Return
         setPorcCount("SELECT", GR_LIST);
         if(DS_O_LIST.CountRow <= 0){
             setMasterObject(false);
             setDetailObject(false);
             LC_S_STR.Focus();
         }
     }
}

/**
 * btn_New()
 * 작 성 자    : 김경은
 * 작 성 일     : 2010-04-04
 * 개    요        : 신규버튼 클릭 (DS_IO_MASTER의 ROW 추가)
 * return값 : void
 */
function btn_New() {

    // 전표마스터 추가후 행추가, 삭제 버튼 활성화 (저장되지 않은 내용이 있을경우 추가되지 않음)
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "SLIP_NO") == ""){
          if(showMessage(QUESTION, YESNO, "USER-1072") != 1 ){
              setMasterObject(true);
              setDetailObject(true);
              return;
          }else{
              DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
          }
    }else{
        DS_O_LIST.Addrow(); 
    }
         
    DS_IO_MASTER.Addrow();    
    DS_IO_DETAIL.ClearData();

    var idx;
    if(DS_IO_MASTER.CountRow > 0){
         slip_no = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO");
         if(slip_no.length == 0){
             LC_STR.Index               = 0;
             LC_PAIR_STR.Index          = 0;
             LC_AFT_ORD_FLAG.BindColVal = 0;
             LC_PAY_COND.BindColVal     = 0;
             
             idx = DS_O_ORD_FLAG.ValueRow(1,"2");
             EM_ORD_FLAG.Text = DS_O_ORD_FLAG.NameValue(idx, "NAME");             // 발주구분
             
             idx = DS_O_ORD_OWN_FLAG.ValueRow(1,"0");
             EM_ORD_OWN_FLAG.Text = DS_O_ORD_OWN_FLAG.NameValue(idx, "NAME");     // 발주주체
             
             initEmEdit(EM_ORD_DT, "TODAY", PK);                                  // 발주일
             var date = addDate("d", 1, strToday);                                // 오늘날짜 + 1
             EM_DELI_DT.Text    = date;                                           // 납품예정일
             EM_PRC_APP_DT.Text = date;                                           // 가격적용일
         }
     }
    setMasterObject(true);
    setDetailObject(true);
    LC_STR.Focus();
}

/**
 * btn_Delete()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-04
 * 개    요        : 삭제버튼 클릭 (신규등록일 경우 DS_IO_MASTER 삭제, 기존데이터일 경우 삭제 Action실행)
 * return값 : void
 */
function btn_Delete() {
     
    // 삭제할 데이터 없는 경우
    if (DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }

    // 신규 전표인 경우 데이터셋에서만 삭제
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO").length == 0){
        DS_IO_DETAIL.ClearData();
        DS_IO_MASTER.ClearData();
        DS_O_LIST.DeleteRow(DS_O_LIST.RowPosition);
        return;
    }
    
    if(!checkValidation("Delete")) 
        return;
    
    // 삭제 메세지 
    if(showMessage(QUESTION, YESNO, "USER-1023") == 1){
        // 기존데이터일 경우 삭제 Action실행 
        var params = "&strFlag=delete"
                   + "&strStrCd="+encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD"))
                   + "&strSlipNo="+encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO"));
        
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
       
        TR_MAIN.Action="/dps/pord114.po?goTo=save"+params; 
        TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
        TR_MAIN.Post();
        
        btn_Search();
     }

}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-04
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated && !DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION, OK, "USER-1028");
       return;
    }

    if(!checkValidation("Save"))    // validation 체크
        return;
    
    sel_DeleteRow( DS_IO_DETAIL, "SEL" );
    if(DS_IO_DETAIL.CountRow <= 0){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오."); 
        GR_DETAIL.Focus();
        return;
    }
    
    if(!closeCheck())           // 마감체크
        return;
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DTL_CNT")       = DS_IO_DETAIL.CountRow;    // 명세건수
        
        TR_SAVE.Action="/dps/pord114.po?goTo=save&strFlag=save&strBuyerYN="+strBuyerYN; 
        TR_SAVE.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
        TR_SAVE.Post();

    }   
}

/**
 * btn_Excel()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-04
 * 개    요        : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-04
 * 개    요        : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자     : 
 * 작 성 일     : 2010-02-14
 * 개    요        : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
  
/**
 * setMasterObject(flag)
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-04
 * 개    요        : 마스터 Object의 활성화/비활성화를 제어한다.
 * return값 : void
 */
function setMasterObject(flag){

    enableControl(LC_STR            ,flag);
    enableControl(LC_PAIR_STR       ,flag);
    enableControl(EM_PUMBUN_CD      ,flag);
    enableControl(EM_ORD_DT         ,flag);
    enableControl(EM_DELI_DT        ,flag);
    enableControl(EM_PRC_APP_DT     ,flag);
    enableControl(EM_VEN_CD         ,flag);

    enableControl(IMG_PUMBUN        ,flag);
    enableControl(IMG_ORD_DT        ,flag);
    enableControl(IMG_DELI_DT       ,flag);
    enableControl(IMG_PRC_APP_DT    ,flag);
    enableControl(IMG_VEN           ,flag); 
}  

/**
 * setDetailObject()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-04
 * 개    요        : 디테일 Object의 활성화/비활성화를 제어한다.
 * return값 : void
 */
function setDetailObject(flag){
    var strBizType      = EM_BIZ_TYPE.Text;  
    var strSlipProcStat = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_PROC_STAT");
    if(strBizType == "1"){
        if(strSlipProcStat == "00"){
            enableControl(LC_PAY_COND ,true);
            enableControl(EM_REMARK   ,true);
        }else{
            enableControl(LC_PAY_COND ,false);
            enableControl(EM_REMARK   ,false);
        }
    }else{
        LC_PAY_COND.BindColVal = "";
        enableControl(LC_PAY_COND ,false);
        enableControl(EM_REMARK   ,false);
    }
    
    enableControl(EM_REMARK ,flag);
    enableControl(IMG_ADD   ,flag);
    enableControl(IMG_DEL   ,flag);
    GR_DETAIL.Editable = flag;
} 

/**
 * checkValidation()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-04
 * 개    요        : 조회조건 값 체크 
 * return값 : void
 */
function checkValidation(Gubun) {
     
     var messageCode = "USER-1001";
     
     //조회버튼 클릭시 Validation Check
     if(Gubun == "Search"){   
         if(LC_S_STR.Text.length == 0){                                          // 점
               showMessage(EXCLAMATION, OK, messageCode, "점");
               LC_S_STR.Focus();
               return false;
         }  
         /*
         if(LC_S_BUMUN.Text.length == 0){                                        // 팀
             showMessage(EXCLAMATION, OK, messageCode, "팀");
             LC_S_BUMUN.Focus();
             return false;
         }  
         if(LC_S_TEAM.Text.length == 0){                                         // 파트
             showMessage(EXCLAMATION, OK, messageCode, "파트");
             LC_S_TEAM.Focus();
             return false;
         }  
         if(LC_S_PC.Text.length == 0){                                           // PC
             showMessage(EXCLAMATION, OK, messageCode, "PC");
             LC_S_PC.Focus();
             return false;
         }  
         */
         if(LC_S_GJDATE_TYPE.Text.length == 0){                                  // 기준일
             showMessage(EXCLAMATION, OK, messageCode, "기준일");
             LC_S_GJDATE_TYPE.Focus();
             return false;
         }
         if(EM_S_START_DT.Text.length == 0){                              // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회시작일");
             EM_S_START_DT.Focus();
             return false;
        }
         if(EM_S_END_DT.Text.length == 0){                              // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회종료일");
             EM_S_END_DT.Focus();
             return false;
        }
         if(EM_S_START_DT.Text > EM_S_END_DT.Text){                              // 조회일 정합성
              showMessage(EXCLAMATION, OK, "USER-1015");
              EM_S_START_DT.Focus();
              return false;
         }
     }
     
     // 저장버튼 클릭시 Validation Check
     if(Gubun == "Save"){
    	 var strStrCd        = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "STR_CD");           // 점
         var strSlipNo       = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "SLIP_NO");          // 발주번호
         if(!slipProcStatCheck(strStrCd, strSlipNo))                                           // 전표상태확인
             return false;

         if(EM_PUMBUN_CD.Text.length == 0){                                 // 브랜드
             showMessage(EXCLAMATION, OK, "USER-1002", "브랜드");
             EM_PUMBUN_CD.Focus();
             return false;
         }
         
         // 존재하는 브랜드 코드인지 확인한다.
         if(!pumbunValCheck("E")){          // 본사점(점출)
             showMessage(EXCLAMATION, OK, "USER-1069", "브랜드");
             EM_PUMBUN_CD.Focus();
             return false;
         }
         
         if(!pumbunValCheck("F")){          // 점입점
             showMessage(EXCLAMATION, OK, "USER-1069", "브랜드");
             EM_PUMBUN_CD.Focus();
             return false;
         }
         
         if(EM_VEN_CD.Text.length == 0){                                    // 협력사
             showMessage(EXCLAMATION, OK, "USER-1002", "협력사");
             initEmEdit(EM_VEN_CD,       "000000"     , PK);                // 협력사코드
             EM_VEN_CD.Focus();
             return false;
         } 
         if(EM_ORD_DT.Text.length == 0){                                    // 발주일
            showMessage(EXCLAMATION, OK, "USER-1002", "발주일");
            EM_ORD_DT.Focus();
            return false;
         } 
         if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1){        // 신규입력일 경우만 체크
             var aft_ord_flag = LC_AFT_ORD_FLAG.BindColVal;
             if(aft_ord_flag == "0"){
                 if(strToday > EM_ORD_DT.Text){
                     showMessage(EXCLAMATION, OK, "USER-1180", "발주일");
                    EM_ORD_DT.Focus();
                    return false;
                 }
             }
         }
         if(EM_DELI_DT.Text.length == 0){                                   // 납품예정일
            showMessage(EXCLAMATION, OK, "USER-1002", "납품예정일");
            EM_DELI_DT.Focus();
            
            return false;
         } 
         if(EM_ORD_DT.Text > EM_DELI_DT.Text){
            showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");
            EM_DELI_DT.Focus();
            return false;
         }
         if(EM_PRC_APP_DT.Text.length == 0){                                // 가격적용일
            showMessage(EXCLAMATION, OK, "USER-1002", "가격적용일");
            EM_PRC_APP_DT.Focus();
            return false;
         } 
         if(EM_DELI_DT.Text > EM_PRC_APP_DT.Text){
            showMessage(EXCLAMATION, OK, "USER-1020", "가격적용일","납품예정일");
            EM_PRC_APP_DT.Focus();
            return false;
         }
         
         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "REMARK", "비고", "EM_REMARK") )  // 비고
             return false;
         
         var strBizType    = EM_BIZ_TYPE.Text;      // 거래형태
         var intRowCount   = DS_IO_DETAIL.CountRow;
         var strSkuCd      = "";                    // 단품코드
         var intQty        = 0;                     // 발주수량                    
         var intNewCostPrc = 0;                     // 원가단가
         var intNewSalePrc = 0;                     // 매가단가
         var fltNewGapRate = 0;                     // 차익율 
         var strBottleCd   = "";                    // 공병단품코드
         
         if(intRowCount > 0){
             for(var i=1; i <= intRowCount; i++){
                 
                 strSkuCd      = DS_IO_DETAIL.NameValue(i, "SKU_CD");
                 intQty        = DS_IO_DETAIL.NameValue(i, "ORD_QTY");
                 intNewCostPrc = DS_IO_DETAIL.NameValue(i, "NEW_COST_PRC");
                 intNewSalePrc = DS_IO_DETAIL.NameValue(i, "NEW_SALE_PRC");
                 fltNewGapRate = DS_IO_DETAIL.NameValue(i, "NEW_GAP_RATE");
                 strBottleCd     = DS_IO_DETAIL.NameValue(i, "BOTTLE_CD");
                 
                 if(strSkuCd.length <= 0){
                     DS_IO_DETAIL.NameValue(i, "SEL") = "T"; 
                     continue;
                     
                     showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
                     GR_DETAIL.SetColumn("SKU_CD");  
                     DS_IO_DETAIL.RowPosition = i;  
                     return false;
                 }
                 
                 // 존재하는 단품 코드인지 확인한다.
                 if(!skuValCheck(i, "SKU_CD","E")){
                     showMessage(EXCLAMATION, OK, "USER-1069", "단품코드(본사점)");
                     GR_DETAIL.SetColumn("SKU_CD");  
                     DS_IO_DETAIL.RowPosition = i;  
                     return false;
                 }
                 
                 // 존재하는 단품 코드인지 확인한다.
                 if(!skuValCheck(i, "SKU_CD","F")){
                     showMessage(EXCLAMATION, OK, "USER-1069", "단품코드(점입점)");
                     GR_DETAIL.SetColumn("SKU_CD");  
                     DS_IO_DETAIL.RowPosition = i;  
                     return false;
                 }
                 
                 // 중복체크
                var dupRow = checkDupKey(DS_IO_DETAIL, "SKU_CD");
                if (dupRow > 0) {
                    showMessage(EXCLAMATION, OK,  "USER-1044", dupRow);
                    //DS_IO_DETAIL.NameValue( dupRow, "SKU_CD")  = "";
                    
                    DS_IO_DETAIL.RowPosition = dupRow;
                    GR_DETAIL.SetColumn("SKU_CD");
                    GR_DETAIL.Focus(); 
                    return false;
                }
                
                 if(intQty <= 0){
                     showMessage(EXCLAMATION, OK, "USER-1008", "발주수량", "0");
                     DS_IO_DETAIL.RowPosition = i;
                     GR_DETAIL.SetColumn("ORD_QTY");
                     GR_DETAIL.Focus(); 
                     return false;
                 }
                 if(strBizType == "2"){
                    if(intNewCostPrc.length <= 0){
                        showMessage(EXCLAMATION, OK, "USER-1008", "원가단가", "0");
                        DS_IO_DETAIL.RowPosition = i;
                        GR_DETAIL.SetColumn("NEW_COST_PRC");
                        GR_DETAIL.Focus(); 
                        return false;
                    }
                    if(intNewSalePrc <= 0){
                        showMessage(EXCLAMATION, OK, "USER-1008", "매가단가", "0");
                        DS_IO_DETAIL.RowPosition = i;
                        GR_DETAIL.SetColumn("NEW_SALE_PRC");
                        GR_DETAIL.Focus();
                        return false;
                    }
                 }
                 if(fltNewGapRate.lenght <= 0){
                     showMessage(EXCLAMATION, OK, "USER-1003", "차익율");
                     DS_IO_DETAIL.RowPosition = i;
                     GR_DETAIL.SetColumn("NEW_GAP_RATE");
                     GR_DETAIL.Focus();
                     return false;
                 }
                 
                 DS_IO_DETAIL.NameValue(i, "SEL") = "F"; 
                 
                 // 공병전표여부 세팅
                 if(strBottleCd != "")
                     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BOTTLE_SLIP_YN") = "Y";
                 else
                     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BOTTLE_SLIP_YN") = "N";
             }
         }
     }
     
     if(Gubun == "Delete"){
    	 var strStrCd        = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "STR_CD");           // 점
         var strSlipNo       = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "SLIP_NO");          // 발주번호
         var strRegDate      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REG_DATE");   // 등록일자
         var strSlipProcStat = getSlipProcStat("DS_O_RESULT", strStrCd, strSlipNo);            // 전표상태 
           
         if(strSlipProcStat != "00"){
             showMessage(EXCLAMATION, OK, "USER-1160");
             return false;
         }
         
         /*
         if(strRegDate != strToday){
             showMessage(EXCLAMATION, OK, "USER-1170");
             return false;
         }
         */
     }
     return true; 
}

/**
* getList()
* 작 성 자 : 김경은
* 작 성 일 : 2010-04-04
* 개    요 :  마스터 리스트 조회
* return값 : void
*/
function getList(){
   // 조회조건 셋팅
   var strStrCd         = LC_S_STR.BindColVal;                   // 점
   var strBumun         = LC_S_BUMUN.BindColVal;                 // 팀
   var strTeam          = LC_S_TEAM.BindColVal;                  // 파트
   var strPc            = LC_S_PC.BindColVal;                    // PC
   var strOrgCd         = strStrCd + strBumun + strTeam + strPc; // 조직   
   var strGJdateType    = LC_S_GJDATE_TYPE.BindColVal;           // 기준일
   var strStartDt       = EM_S_START_DT.Text;                    // 조회기간1
   var strEndDt         = EM_S_END_DT.Text;                      // 조회기간2
   var strProcStat      = LC_S_S_PROC_STAT.BindColVal;           // 전표상태
   var strPumbun        = EM_S_PB_CD.Text;                       // 브랜드
   var strBizType       = EM_BIZ_TYPE.Text;                      // 거래형태
   var strVen           = EM_S_VEN_CD.Text;                      // 협력사
   var strSlipNo        = EM_S_SLIP_NO.Text;                     // 전표번호
  
   var goTo       = "getList" ;    
   var action     = "O";     
   var parameters =  "&strStrCd="		+encodeURIComponent(strStrCd)     
                   + "&strBumun="		+encodeURIComponent(strBumun)     
                   + "&strTeam="		+encodeURIComponent(strTeam)      
                   + "&strPc="			+encodeURIComponent(strPc)     
                   + "&strOrgCd="		+encodeURIComponent(strOrgCd)
                   + "&strGJdateType="	+encodeURIComponent(strGJdateType)
                   + "&strStartDt="		+encodeURIComponent(strStartDt)   
                   + "&strEndDt="		+encodeURIComponent(strEndDt)     
                   + "&strProcStat="	+encodeURIComponent(strProcStat)  
                   + "&strPumbun="		+encodeURIComponent(strPumbun)    
                   + "&strBizType="		+encodeURIComponent(strBizType)
                   + "&strVen="			+encodeURIComponent(strVen)
                   + "&strSlipNo="		+encodeURIComponent(strSlipNo); 
   TR_S_MAIN.Action  = "/dps/pord114.po?goTo="+goTo+parameters;  
   TR_S_MAIN.KeyValue= "SERVLET("+action+":DS_O_LIST=DS_O_LIST)"; //조회는 O
   TR_S_MAIN.Post();

}

/**
* getDetail()
* 작 성 자 : 김경은
* 작 성 일 : 2010-04-04
* 개    요 :  상세조회
* return값 : void
*/
function getDetail(){
   var strVenCd     = "";
   var strStrCd     = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_CD");
   var strSlipNo    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO");
   
   var goTo         = "getDetail" ;    
   var action       = "O";     
   var parameters   = "&strStrCd=" +encodeURIComponent(strStrCd)+
                      "&strSlipNo="+encodeURIComponent(strSlipNo);
   
   TR_MAIN.Action="/dps/pord114.po?goTo="+goTo+parameters;  
   TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER,"+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
   TR_MAIN.Post();

   strVenCd  = EM_VEN_CD.Text;
   // 협력사별 반올림 구분을 받는다
   roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);
   GR_DETAIL.ColumnProp('SEL','HeadCheck')= "FALSE";
   setMasterObject(false);
   setDetailObject(true);
}

/**
* getPumbunInfo(pop)
* 작 성 자 : 김경은
* 작 성 일 : 2010-04-04
* 개    요 :  브랜드팝업 관련 데이터 조회 및 세팅
* param : pop (팝업을 띄울지..1:팝업, 0:무시)
* return값 : void
*/
function getPumbunInfo(pop){
    
    var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
    var strStrCd        = LC_STR.BindColVal;                                         // 점
    var strOrgCd        = "";                                                        // 조직코드
    var strVenCd        = "";                                                        // 협력사
    var strBuyerCd      = "";                                                        // 바이어
    var strPumbunType   = "";                                                        // 브랜드유형
    var strUseYn        = "Y";                                                       // 사용여부
    var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
    var strSkuType      = "1";                                                       // 단품종류(1:규격단품)
    var strItgOrdFlag   = "Y";                                                       // 통합발주여부
    var strBizType      = "1";                                                       // 거래형태(1:직매입)
    var strSaleBuyFlag  = "1";                                                       // 판매분매입구분(1:사전매입)
   

    var rtnMap = strPbnPop(EM_PUMBUN_CD, EM_PUMBUN_NM, 'Y'
                            ,strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                            ,strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                            ,strBizType,strSaleBuyFlag);
    if(rtnMap != null){
    	// 브랜드유형이 정상 F&B일 경우만 등록가능하다.
        if(rtnMap.get("PUMBUN_TYPE") != '0' 
                && rtnMap.get("PUMBUN_TYPE") != '4'){
            EM_PUMBUN_CD.TEXT = "";
            EM_PUMBUN_NM.TEXT = "";
            showMessage(EXCLAMATION, OK, "USER-1221"); 
            setTimeout( "EM_PUMBUN_CD.Focus()",50);
            return;
        }
    	
        EM_VEN_CD.Text   = rtnMap.get("VEN_CD");
        EM_VEN_NM.Text   = rtnMap.get("VEN_NAME");
        
        var idx = "";
        // 거래형태
        if(rtnMap.get("BIZ_TYPE") != ""){
            idx = DS_O_BIZ_TYPE.ValueRow(1,rtnMap.get("BIZ_TYPE"));
            EM_BIZ_TYPE.Text    = rtnMap.get("BIZ_TYPE");
            EM_BIZ_TYPE_NM.Text = DS_O_BIZ_TYPE.NameValue(idx, "NAME");
        }else{
            EM_BIZ_TYPE.Text = "";
            EM_BIZ_TYPE_NM.Text = "";
        }
        
        // 과세구분
        if(rtnMap.get("TAX_FLAG") != ""){
            idx = DS_O_TAX_FLAG.ValueRow(1,rtnMap.get("TAX_FLAG"));
            EM_TAX_FLAG.Text    = rtnMap.get("TAX_FLAG");
            EM_TAX_FLAG_NM.Text = DS_O_TAX_FLAG.NameValue(idx, "NAME");
        }else{
            EM_TAX_FLAG.Text    = "";
            EM_TAX_FLAG_NM.Text = "";
        }
        // 바이어
        EM_BUYER_NM.Text = rtnMap.get("BUYER_EMP_NAME");
        EM_BUYER_CD.Text = rtnMap.get("CHAR_BUYER_CD");
        
    }
    
    // 저장시 다시 한번 브랜드의 존재여부를 확인하기 위해
    if(DS_O_RESULT.CountRow > 0) return true;
    if(rtnMap != null) return true;
}

/**
* getSkuPop(row, colid)
* 작 성 자 : 김경은
* 작 성 일 : 2010-04-04
* 개    요 :  단품 팝업  관련 데이터 조회 및 세팅
* return값 : void
*/
function getSkuPop(row, colid){
    var intRow          = 1;
    var strSkuCd        = DS_IO_DETAIL.NameValue(row, colid);
    var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
    var strStrCd        = LC_STR.BindColVal;                                         // 점
    var strPumbunCd     = EM_PUMBUN_CD.Text;                                         // 브랜드코드
    var strPumbunType   = "";                                                        // 브랜드유형
    var strBizType      = EM_BIZ_TYPE.Text;                                          // 거래형태(1:직매입)
    var strUseYn        = "Y";                                                      // 사용여부   
    var strVenCd        = EM_VEN_CD.Text;                                            // 협력사
    
    var rtnList = strSkuMultiSelPop(strSkuCd, "", "Y"
                                  , strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType
                                  , strUseYn, '', '', '', ''
                                  ,'', '', '', strVenCd);

    if(rtnList != null){
        for(var i = 0; i < rtnList.length; i++){
            if(i == 0 )
                intRow = row;
            else
                DS_IO_DETAIL.AddRow();

            DS_IO_DETAIL.NameValue(row+i, "SKU_CD")      = rtnList[i].SKU_CD;
            DS_IO_DETAIL.NameValue(row+i, "SKU_NM")      = rtnList[i].SKU_NAME;
            DS_IO_DETAIL.NameValue(row+i, "ORD_UNIT_CD") = rtnList[i].ORD_UNIT_CD;
            getSkuInfo();
        }
        if(rtnList.length > 1)
            setFocusGrid(GR_DETAIL, DS_IO_DETAIL,intRow,"ORD_QTY");
    }
}

/**
* skuValCheck(row, colid, gubun)
* 작 성 자 : 김경은
* 작 성 일 : 2010-04-04
* 개    요 :  단품  Validation Check
*          gubun(E:본사점(점출), F:점입) 
* return값 : void
*/
function skuValCheck(row, colid, gubun){
    var strStrCd        = "";
    var strAuthGb       = "";
    if(gubun == "E"){
        strStrCd        = LC_STR.BindColVal;
        strAuthGb       = "Y";
    }else{
        strStrCd        = LC_PAIR_STR.BindColVal;
        strAuthGb       = "N";
    }
    
    var intRow          = 1;
    var strSkuCd        = DS_IO_DETAIL.NameValue(row, "SKU_CD")==""?strSkuCd= "#":strSkuCd=DS_IO_DETAIL.NameValue(row, "SKU_CD");
    var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
    var strPumbunCd     = EM_PUMBUN_CD.Text;                                         // 브랜드코드
    var strPumbunType   = "";                                                        // 브랜드유형
    var strBizType      = EM_BIZ_TYPE.Text;                                          // 거래형태(1:직매입)
    var strUseYn        = "Y";                                                       // 사용여부   
    var strVenCd        = EM_VEN_CD.Text;                                            // 협력사
    
    var rtnMap = setStrSkuNmWithoutToGridPordPop( "DS_O_RESULT", strSkuCd, "", strAuthGb, "0",
                                              strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType,
                                              strUseYn, '', '', '', ''
                                              ,'', '', '', strVenCd);
    if(rtnMap != null)
        return true;
    else
        return false;
}

/**
* pumbunValCheck(gubun)
* 작 성 자 : 김경은
* 작 성 일 : 2010-04-04
* 개    요 :  브랜드  Validation Check
*          gubun (E:본사(점출), F:점입)
* return값 : void
*/
function pumbunValCheck(gubun){
    var strStrCd        = "";
    var strAuthGb       = ""; 
    
    if(gubun == "E"){
        strStrCd        = LC_STR.BindColVal; 
        strAuthGb       = "Y";
    }else{
        strStrCd        = LC_PAIR_STR.BindColVal;
        strAuthGb       = "N";
    }
    
    var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
    var strOrgCd        = "";                                                        // 조직코드
    var strVenCd        = "";                                                        // 협력사
    var strBuyerCd      = "";                                                        // 바이어
    var strPumbunType   = "";                                                        // 브랜드유형
    var strUseYn        = "Y";                                                       // 사용여부
    var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
    var strSkuType      = "1";                                                       // 단품종류(1:규격단품)
    var strItgOrdFlag   = "Y";                                                       // 통합발주여부
    var strBizType      = "1";                                                       // 거래형태(1:직매입)
    var strSaleBuyFlag  = "1";                                                       // 판매분매입구분(1:사전매입)

    var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_PUMBUN_CD, EM_PUMBUN_NM, strAuthGb, "0"
          , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
          , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
          , strBizType,strSaleBuyFlag);

    if(DS_O_RESULT.CountRow == 1)
        return true;
    else
        return false;
}

/**
* getSkuInfo()
* 작 성 자 : 김경은
* 작 성 일 : 2010-04-04
* 개    요 :  상세내역의 단품관련 데이터 조회
* return값 : void
*/
function getSkuInfo(){  
   
   // 조회조건 셋팅   
   var strStrCd     = LC_STR.BindColVal;                                            // 점 
   var strPStrCd    = LC_PAIR_STR.BindColVal;                                       // 점입점 
   var strPumbunCd  = EM_PUMBUN_CD.Text;                                            // 브랜드
   var strOrdDt     = EM_ORD_DT.Text;                                               // 발주일
   var strPrcAppDt  = EM_PRC_APP_DT.Text;                                           // 가격적용일
   var strSkuCd     = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SKU_CD");   // 단품코드
   var strBizType   = EM_BIZ_TYPE.Text;                                             // 거래형태
  
   var goTo       = "getSkuInfo" ;    
   var action     = "O";     
   var parameters =  "&strStrCd="	+encodeURIComponent(strStrCd)    
                   + "&strPStrCd="	+encodeURIComponent(strPStrCd)   
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd) 
                   + "&strOrdDt="	+encodeURIComponent(strOrdDt)
                   + "&strOrdYm="	+encodeURIComponent(strOrdDt.substring(0,6))
                   + "&strPrcAppDt="+encodeURIComponent(strPrcAppDt)     
                   + "&strSkuCd="	+encodeURIComponent(strSkuCd);
   TR_S_MAIN.Action   = "/dps/pord114.po?goTo="+goTo+parameters;  
   TR_S_MAIN.KeyValue = "SERVLET("+action+":DS_O_SKU_INFO=DS_O_SKU_INFO)"; //조회는 O
   TR_S_MAIN.Post();

   if(DS_O_SKU_INFO.CountRow > 0){
       
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SEL")           = 'F';
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SLIP_NO")       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO");
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD")        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMBUN_CD")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD")        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SLIP_FLAG")     = "A";

       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMMOK_CD")     = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "PUMMOK_CD");       // 품목
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SKU_NM")        = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SKU_NAME");        // 단품명
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORD_UNIT_CD")   = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_UNIT_CD");   // 단위
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORD_UNIT_NM")   = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_UNIT_NM");// 단위명
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORD_STK_QTY")   = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "ORD_STK_QTY");     // 재고
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "AVG_SALE_QTY")  = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "AVG_SALE_QTY");    // 평균판매량
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "AVG_SALE_AMT")  = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "AVG_SALE_PRC");    // 평균판매액
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "NEW_COST_PRC")  = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SAL_COST_PRC");    // 원가단가
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "NEW_SALE_PRC")  = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_PRC");        // 매가단가
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "MG_RATE")       = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_MG_RATE");    // 마진율
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "BOTTLE_CD")     = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "BOTTLE_CD");       // 공병단품번호
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "COST_ZERO")     = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "COST_ZERO");
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SALE_ZERO")     = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_ZERO");
       
       if(strBizType == "2")
           // 특정단품일 경우 가격정보의 마진율을 세팅한다.
           DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "NEW_GAP_RATE")   = DS_O_SKU_INFO.NameValue(DS_O_SKU_INFO.RowPosition, "SALE_MG_RATE");

       return true;
   }else
       return false;
   
}

/**
 * addDetailRow()
 * 작 성 자     :김경은
 * 작 성 일     : 2010-04-04
 * 개    요        : 발주매입 상세(단품) ROW 추가
 * return값 : void
 */
function addDetailRow(){     
    if(DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "전표 마스터 내용을 먼저 추가해 주세요.");
        return;
    }
    
    if(!checkValidation("Save"))
      return;
     
    DS_IO_DETAIL.Addrow();
    GR_DETAIL.SetColumn("SKU_CD");
    GR_DETAIL.Focus(); 
    
    setMasterObject(false);
    setDetailObject(true);
    enableControl(LC_AFT_ORD_FLAG, false);
}
 
/**
* delDetailRow()
* 작 성 자 : 김경은
* 작 성 일 : 2010-04-04
* 개    요    : 전표 상세 브랜드 삭제
* return값 : void
*/
function delDetailRow(){
    if(DS_IO_DETAIL.CountRow == 0){
      showMessage(EXCLAMATION, OK, "USER-1019");
          return;
      }

    sel_DeleteRow(DS_IO_DETAIL, "SEL");
    //그리드 CHEKCBOX헤더 체크해제
    GR_DETAIL.ColumnProp('SEL','HeadCheck')= "false";
    
    if(DS_IO_DETAIL.CountRow == 0){
	    setMasterObject(true);
	    enableControl(LC_AFT_ORD_FLAG, true);
    }
    
    // 합계, 차익액, 차익율을 구한다.
    setGapCalc(DS_IO_DETAIL.RowPosition);
}


/**
* closeCheck()
* 작 성 자 : 김경은
* 작 성 일 : 2010-04-04
* 개    요    : 저장시 일마감체크를 한다.
* return값 : void
*/
function closeCheck(){
     var strStrCd         = LC_STR.BindColVal;      // 점
     var strCloseDt       = EM_ORD_DT.Text;         // 마감체크일자
     var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
     var strCloseUnitFlag = "42";                   // 단위업무
     var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
     var strCloseFlag     = "M";                    // 마감구분(월마감:M)
    
     var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                   , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
     
     if(closeFlag == "TRUE"){
         showMessage(EXCLAMATION, OK, "USER-1068", "매입월","발주매입");
         return false;
     }else{
         return true;
     }
}
 
 /**
 * setGapCalc()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-04
 * 개    요    : 차익액, 차익율을 계산한다.
 * return값 : void
 */
 function setGapCalc(row){
     var strTaxFlag  = EM_TAX_FLAG.Text;
     var strBizType  = EM_BIZ_TYPE.Text;                               // 거래형태
     var ord_qty     = DS_IO_DETAIL.NameValue(row, "ORD_QTY");         // 발주수량
     var cost_prc    = DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC");    // 원가단가
     var sale_prc    = DS_IO_DETAIL.NameValue(row, "NEW_SALE_PRC");    // 매가단가
     var cost_amt    = ord_qty * cost_prc;                             // 원가금액
     var sale_amt    = ord_qty * sale_prc;                             // 매가금액
     
     DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT") = cost_amt;          // 원가금액
     DS_IO_DETAIL.NameValue(row, "NEW_SALE_AMT") = sale_amt;           // 매가금액

     var totCostAmt = DS_IO_DETAIL.Sum(16,0,0);
     var totSaleAmt = DS_IO_DETAIL.Sum(18,0,0);
     
     // 거래형태 (1:직매입,2:특정)
     switch (strBizType) {
     case "1":
         DS_IO_DETAIL.NameValue(row, "NEW_GAP_RATE")  = getCalcPord("GAP_RATE", cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
         break;
     case "2":
         break;
     }
        
     var gapAmt     = getCalcPord("GAP_AMT",  cost_amt,   sale_amt,   "", strTaxFlag, roundFlag);
     var vatAmt     = getCalcPord("VAT_AMT",  cost_amt,   "",         "", strTaxFlag, roundFlag);
     
     DS_IO_DETAIL.NameValue(row, "NEW_GAP_AMT")  = gapAmt;      // 차익액
     DS_IO_DETAIL.NameValue(row, "VAT_AMT")      = vatAmt;      // 부가세
     
     //var totGapAmt  = getCalcPord("GAP_AMT",  totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
     var totGapAmt  = DS_IO_DETAIL.Sum(9,0,0);;
     var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);

     EM_GAP_TOT_AMT.Text = totGapAmt;
     EM_GAP_RATE.Text    = totGapRate;
     
     EM_TOT_QTY.Text      = DS_IO_DETAIL.Sum(14,0,0);
     EM_TOT_COST_AMT.Text = DS_IO_DETAIL.Sum(16,0,0);
     EM_TOT_SALE_AMT.Text = DS_IO_DETAIL.Sum(18,0,0);
     
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VAT_TAMT")  = DS_IO_DETAIL.Sum(24,0,0);
 }
 
 /**
  * getVenInfo()
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-04-04
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfo(code, name, btnFlag){

     var strStrCd = "";
      if(code.id == "EM_S_VEN_CD")
          strStrCd        = LC_S_STR.BindColVal;  
      else
          strStrCd        = LC_STR.BindColVal;  
          
     var strUseYn        = "Y";                                                       // 사용여부
     var strPumBunType   = "0";                                                       // 브랜드유형
     var strBizType      = "1";                                                       // 거래형태
     var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
     var strBizFlag      = "";                                                        // 거래구분

     if(!btnFlag){
         var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                 ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                 ,strBizFlag);
     }else{
         var rtnMap = venPop(code, name
                            ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                            ,strBizFlag);
     }
     if(code.id == "EM_VEN_CD"){
         // 협력사별 반올림 구분을 받는다
         roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, LC_STR.BindColVal, EM_VEN_CD.Text);
     }
 }
 
 /**
  * searchPumbunPop(btnFlag)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-04-04
  * 개    요 :  조회조건 브랜드팝업
  * return값 : void
  */
  function searchPumbunPop(btnFlag){   
      var tmpOrgCd        = LC_S_STR.BindColVal + LC_S_BUMUN.BindColVal + LC_S_TEAM.BindColVal + LC_S_PC.BindColVal;
      var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
      var strStrCd        = LC_S_STR.BindColVal;                                       // 점
      var strOrgCd        = replaceStr(tmpOrgCd,"%","00")+"00";                        // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "";                                                        // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
      var strSkuType      = "1";                                                       // 단품종류(1:규격단품)
      var strItgOrdFlag   = "Y";                                                       // 통합발주여부
      var strBizType      = "1";                                                       // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "1";                                                       // 판매분매입구분

      if(!btnFlag){
            setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PB_CD, EM_S_PB_NM, "Y", "1"
                                  , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                  , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                  , strBizType,strSaleBuyFlag);           
      }else {       
          
         var rtnMap = strPbnPop( EM_S_PB_CD, EM_S_PB_NM, 'Y'
                                , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                , strBizType,strSaleBuyFlag);
      }
  }
 
 /**
  * clearDataSetRow(DataSet)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-04-04
  * 개    요 : 선택 로우의 데이터를 Clear한다.
  * 사용방법 : clearDataSetRow(DS_MASTER);
  **/
 function clearDataSetRow(DataSet){
     var intToColCnt       = DataSet.CountColumn;       // 대상 데이터셋 컬럼수
     var strColNM          = "";                        // 원본 데이터셋 컬럼명
     for(var i = 1; i <= intToColCnt; i++){
         strColNM = DataSet.ColumnID(i);
         if(strColNM != "ORD_SEQ_NO")
               DataSet.NameValue(DataSet.RowPosition, strColNM) = ""; 
     }
 }
 /**
  * setStrPbnNmWithoutPopCall()
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-04-04
  * 개    요 :  브랜드입력시 부가정보 바로세팅
  * return값 : void
  */
  function setStrPbnNmWithoutPopCall(){
    var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
    var strStrCd        = LC_STR.BindColVal;                                         // 점
    var strOrgCd        = "";                                                        // 조직코드
    var strVenCd        = "";                                                        // 협력사
    var strBuyerCd      = "";                                                        // 바이어
    var strPumbunType   = "";                                                        // 브랜드유형
    var strUseYn        = "Y";                                                       // 사용여부
    var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
    var strSkuType      = "1";                                                       // 단품종류(1:규격단품)
    var strItgOrdFlag   = "Y";                                                       // 통합발주여부
    var strBizType      = "1";                                                       // 거래형태(1:직매입)
    var strSaleBuyFlag  = "1";                                                       // 판매분매입구분(1:사전매입)

    var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_PUMBUN_CD, EM_PUMBUN_NM, "Y", "1"
                                    , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                    , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                    , strBizType,strSaleBuyFlag);

    if(DS_O_RESULT.CountRow == 1){
    	// 브랜드유형이 정상 F&B일 경우만 등록가능하다.
        if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "PUMBUN_TYPE") != '0' 
                && DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "PUMBUN_TYPE") != '4'){
            PUMBUN_CD.TEXT = "";
            PUMBUN_NM.TEXT = "";
            showMessage(EXCLAMATION, OK, "USER-1221"); 
            setTimeout( "PUMBUN_CD.Focus()",50);
            return;
        }
       // 협력사코드
        EM_VEN_CD.Text   = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD");
        EM_VEN_NM.Text   = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_NAME");

        var idx = "";
        // 거래형태
        if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BIZ_TYPE") != undefined){
            idx = DS_O_BIZ_TYPE.ValueRow(1,DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BIZ_TYPE"));
            EM_BIZ_TYPE.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BIZ_TYPE");
            EM_BIZ_TYPE_NM.Text = DS_O_BIZ_TYPE.NameValue(idx, "NAME");
        }else{
            EM_BIZ_TYPE.Text    = "";
            EM_BIZ_TYPE_NM.Text = "";
        }    
        
        // 과세구분
        if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "TAX_FLAG") != undefined){
            idx = DS_O_TAX_FLAG.ValueRow(1,DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "TAX_FLAG"));
            EM_TAX_FLAG.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "TAX_FLAG");
            EM_TAX_FLAG_NM.Text = DS_O_TAX_FLAG.NameValue(idx, "NAME");
        }else{
            EM_TAX_FLAG.Text       = "";
            EM_TAX_FLAG_NM.Text    = "";
        }
        // 바이어
        EM_BUYER_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BUYER_EMP_NAME");
        EM_BUYER_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "CHAR_BUYER_CD");
    }
    if(rtnMap != null){
    	// 브랜드유형이 정상 F&B일 경우만 등록가능하다.
        if(rtnMap.get("PUMBUN_TYPE") != '0' 
                && rtnMap.get("PUMBUN_TYPE") != '4'){
            EM_PUMBUN_CD.TEXT = "";
            EM_PUMBUN_NM.TEXT = "";
            showMessage(EXCLAMATION, OK, "USER-1221"); 
            setTimeout( "EM_PUMBUN_CD.Focus()",50);
            return;
        }
        EM_VEN_CD.Text   = rtnMap.get("VEN_CD");
        EM_VEN_NM.Text   = rtnMap.get("VEN_NAME");
        
        var idx = "";
        // 거래형태
        if(rtnMap.get("BIZ_TYPE") != ""){
            idx = DS_O_BIZ_TYPE.ValueRow(1,rtnMap.get("BIZ_TYPE"));
            EM_BIZ_TYPE.Text    = rtnMap.get("BIZ_TYPE");
            EM_BIZ_TYPE_NM.Text = DS_O_BIZ_TYPE.NameValue(idx, "NAME");
        }else{
            EM_BIZ_TYPE.Text = "";
            EM_BIZ_TYPE_NM.Text = "";
        }
        
        // 과세구분
        if(rtnMap.get("TAX_FLAG") != ""){
            idx = DS_O_TAX_FLAG.ValueRow(1,rtnMap.get("TAX_FLAG"));
            EM_TAX_FLAG.Text    = rtnMap.get("TAX_FLAG");
            EM_TAX_FLAG_NM.Text = DS_O_TAX_FLAG.NameValue(idx, "NAME");
        }else{
            EM_TAX_FLAG.Text    = "";
            EM_TAX_FLAG_NM.Text = "";
        }
        // 바이어
        EM_BUYER_NM.Text = rtnMap.get("BUYER_EMP_NAME");
        EM_BUYER_CD.Text = rtnMap.get("CHAR_BUYER_CD");
        
    }
  }
 
 /**
  * clearPumbunInfo()
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-04-04
  * 개    요 :  브랜드정보 Clear
  * return값 : void
  */
 function clearPumbunInfo(){
     EM_PUMBUN_NM.Text    = "";
     EM_BUYER_CD.Text     = "";
     EM_BUYER_NM.Text     = "";
     EM_VEN_CD.Text       = "";
     EM_VEN_NM.Text       = "";
     EM_BIZ_TYPE.Text     = "";
     EM_BIZ_TYPE_NM.Text  = "";
     EM_TAX_FLAG.Text     = "";
     EM_TAX_FLAG_NM.Text  = "";
 }
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }

    blnSkuChanged   = false;
    btn_Search();
    setMasterObject(false);
</script>
<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_L_MAIN event=onSuccess>
    for(i=0;i<TR_L_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_L_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_L_MAIN event=onFail>
    trFailed(TR_L_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--  ===================DS_O_LIST============================ -->
<script language=JavaScript for=DS_O_LIST event=CanRowPosChange(row)>
    if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            return false;
        }else {
            if(DS_O_LIST.NameValue(row, "SLIP_NO") == "")
                DS_O_LIST.DeleteRow(row);
            return true;
        }
    }else{
        return true;
    }
</script>
<script language=JavaScript for=DS_O_LIST event=onRowPosChanged(row)>
    if(clickSORT)
        return;
        
    var strSlipNo       = DS_O_LIST.NameValue(row, "SLIP_NO");          // 발주번호
    var strSlipProcStat = DS_O_LIST.NameValue(row, "SLIP_PROC_STAT");   // 전표상태
    
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        
        if(strSlipNo != ""){
            getDetail();
            
            if(intSearchCnt == 0){
                intSearchCnt++;
            }else
                setPorcCount("SELECT", DS_IO_DETAIL.CountRow);
        }
    }
    //전표상태가 발주등록(00)일 경우에만 수정가능하다.
    if(strSlipNo == ""){
        setMasterObject(true);
        setDetailObject(true);      
        enableControl(LC_AFT_ORD_FLAG, true);
    }else if( strSlipProcStat == "00"){  
        setMasterObject(false);
        setDetailObject(true);   
        enableControl(LC_AFT_ORD_FLAG, true);
    }else{
        setMasterObject(false);
        setDetailObject(false);  
        enableControl(LC_AFT_ORD_FLAG, false);
    }
</script>

<script language=JavaScript for=DS_IO_MASTER
    event=OnColumnChanged(row,colid)>
    var strBizType = EM_BIZ_TYPE.Text;      // 거래형태
    var strBuyerCd = EM_BUYER_CD.Text;
    
    switch (colid) {
    case "STR_CD":
        strStrCd  = LC_STR.BindColVal;
        strFStrCd = LC_PAIR_STR.BindColVal;
        if(strStrCd != "" && strFStrCd != "")
            // 통합발주 가능여부를 받는다.
            strInOutYN = getStrInOutYN("DS_O_RESULT", strStrCd, strFStrCd);
        
        break;
    case "PAIR_STR_CD":
        strStrCd = LC_STR.BindColVal;
        strFStrCd = LC_PAIR_STR.BindColVal;
        if(strStrCd != "" && strFStrCd != "")
            // 통합발주 가능여부를 받는다.
            strInOutYN = getStrInOutYN("DS_O_RESULT", strStrCd, strFStrCd);
        
        break;
    case "PUMBUN_CD":
        //clearPumbunInfo();
        DS_IO_DETAIL.ClearData();
        break;
    case "BUYER_CD":
        // SM, 바이어여부를 가져온다.
        strBuyerYN = getBuyerYN("DS_O_RESULT", LC_STR.BindColVal, EM_PUMBUN_CD.Text, EM_ORD_DT.Text);
        // 협력사별 반올림 구분을 받는다
        roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, LC_STR.BindColVal, EM_VEN_CD.Text);
        break;
    case "BIZ_TYPE":
        // 직매입일경우 협력사,지불구분을 입력받을 수 있다.
        if(strBizType == "1"){
            LC_PAY_COND.BindColVal = 0;
            LC_PAY_COND.Enable = true;
            initEmEdit(EM_VEN_CD, "000000", PK);           // 협력사코드
            IMG_VEN.disabled   = false;
        }else{
            LC_PAY_COND.BindColVal = "";
            LC_PAY_COND.Enable = false;
              initEmEdit(EM_VEN_CD, "000000", READ);           // 협력사코드
            IMG_VEN.disabled   = true;
        }
        break;
    case "VEN_CD":
        break;
    case "ORD_DT":

        break;
    case "DELI_DT":

        break;
    case "NEW_PRC_APP_DT":

        break;  
    }
   
</script>

<!--  ===================DS_IO_DETAIL============================ -->
<script language=JavaScript for=DS_IO_DETAIL event=onRowPosChanged(row)>
    if(clickSORT)
        return;
</script>

<script language=JavaScript for=DS_IO_DETAIL
    event=OnColumnChanged(row,colid)>
    var orgValue = "";
    var newValue = "";
    
    switch (colid) {
    case "SKU_CD":
        orgValue = this.NameValue(row,"ORG_SKU_CD");
        newValue = this.NameValue(row,"SKU_CD");
        
        //if(orgValue.length > 0)
            if(orgValue != newValue){
                //getSkuInfo();
                this.NameValue(row,"ORG_SKU_CD") = newValue;
                blnSkuChanged = true;
            }
        break;
    case "ORD_QTY":
        EM_TOT_QTY.Text = DS_IO_DETAIL.Sum(14,0,0);
        break;
    case "NEW_COST_AMT":
        EM_TOT_COST_AMT.Text = DS_IO_DETAIL.Sum(16,0,0);
        break;
    case "NEW_SALE_AMT":
        EM_TOT_SALE_AMT.Text = DS_IO_DETAIL.Sum(18,0,0);
        break;
    }
   
    // 차익액, 차익율을 계산한다.
    setGapCalc(row);
    

</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!--  ===================GR_DETAIL============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GR_LIST event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid, "DS_IO_MASTER,DS_IO_DETAIL" ); 
</script>

<!--  ===================GR_DETAIL============================ -->
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript" for=GR_DETAIL
    event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_IO_DETAIL.CountRow; i++){
            DS_IO_DETAIL.NameValue(i, "SEL") = 'T';
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_IO_DETAIL.CountRow; i++){
            DS_IO_DETAIL.NameValue(i, "SEL") = 'F';
        }
    }
</script>
<!-- GR_DETAIL OnPopup event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnPopup(row,colid,data)>
    getSkuPop(row, colid);
</script>

<!-- GR_DETAIL CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript" for=GR_DETAIL
    event=CanColumnPosChange(Row,Colid)>
    switch (Colid) {
    case "SKU_CD":
        var blnSkuChk = skuValCheck(Row,Colid,"E");
        if(blnSkuChk) return true;
        else if (!blnSkuChk && DS_IO_DETAIL.NameValue(Row,"SKU_CD") == ""){
            
            /*
            showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
            clearDataSetRow(DS_IO_DETAIL);
            DS_IO_DETAIL.NameValue(Row, "SEL") = 'T';
            GR_DETAIL.Focus();
            */
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            clearDataSetRow(DS_IO_DETAIL);
            setGapCalc(Row);
            return true;
        }else {
            //if(this.NameValue(row,"SKU_CD") != "")
            showMessage(EXCLAMATION, OK, "USER-1065", "정확한 단품코드");
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "SKU_CD") = "";
            GR_DETAIL.Focus();
            return false;
        }
        
        if (blnSkuChanged) {
            //clearDataSetRow(DS_IO_DETAIL);
            if(DS_IO_DETAIL.NameValue(row,"SKU_CD") != "")
               showMessage(EXCLAMATION, OK, "USER-1065", "정확한 단품코드");
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "SKU_CD") = "";
            GR_DETAIL.Focus();
            blnSkuChanged = false;
            return false;
        }else{
            return true;
        }
        break;
    }
</script>

<!-- GR_DETAIL OnColumnPosChanged(Row,Colid) event 처리 -->
<script language="javascript" for=GR_DETAIL
    event=OnColumnPosChanged(Row,Colid)>
    switch (Colid) {
    case "ORD_QTY":
        if(blnSkuChanged || DS_IO_DETAIL.NameValue(Row,"SKU_NM") == ""){
            getSkuInfo();
            blnSkuChanged = false;
            
        }
        break;
    }
</script>



<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR event=OnSelChange()>
    if(LC_S_STR.BindColVal != "%"){
        getDept("DS_O_DEPT", "Y", LC_S_STR.BindColVal, "Y");                                              // 팀 
        LC_S_BUMUN.Index = 0;
    }
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
    EM_S_VEN_CD.Text = "";
    EM_S_VEN_NM.Text = "";
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_S_BUMUN event=OnSelChange()>
    if(LC_S_BUMUN.BindColVal != "%"){
        getTeam("DS_O_TEAM", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, "Y");                       // 파트  
    }else{
        DS_O_TEAM.ClearData();
        insComboData( LC_S_TEAM, "%", "전체",1);
        DS_O_PC.ClearData();
        insComboData( LC_S_PC, "%", "전체",1);
    }
    LC_S_TEAM.Index = 0;
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
</script>

<!-- 파트(조회)  변경시  -->
<script language=JavaScript for=LC_S_TEAM event=OnSelChange()>
    if(LC_S_TEAM.BindColVal != "%"){
        getPc("DS_O_PC", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, LC_S_TEAM.BindColVal, "Y");     // PC  
    }else{
        DS_O_PC.ClearData();
        insComboData( LC_S_PC, "%", "전체",1);
    }
    LC_S_PC.Index = 0;
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
</script>

<!-- PC(조회)  변경시  -->
<script language=JavaScript for=LC_S_PC event=OnSelChange()>
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
</script>
<!-- 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PB_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(EM_S_PB_CD.Text != "")
         searchPumbunPop(false);
    else
        EM_S_PB_NM.Text = "";
</script>

<!-- 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(EM_S_VEN_CD.Text != "")
        getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, false);
    else
        EM_S_VEN_NM.Text = "";
</script>

<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_START_DT event=OnKillFocus()>
    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_START_DT, strSyyyymmdd );
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_END_DT event=OnKillFocus()>
checkDateTypeYMD( EM_S_END_DT );
</script>

<!-- 점(입력)  변경시  -->
<script language=JavaScript for=LC_STR event=OnSelChange()>
    EM_PUMBUN_CD.Text = "";
    clearPumbunInfo();
</script>

<!-- 사후구분(입력)  포커스변경시  -->
<script language=JavaScript for=LC_AFT_ORD_FLAG event=OnSelChange()>
	var strSlipProcStat = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "SLIP_PROC_STAT");   // 전표상태
	if(strSlipProcStat == "00")
	    return;
	    
    var aft_ord_flag = LC_AFT_ORD_FLAG.BindColVal;
    var nextDay = addDate("d", 1, strToday);
    if(aft_ord_flag == "0"){                   // 사전전표
        EM_ORD_DT.Text     = strToday;
        EM_DELI_DT.Text    = nextDay;
        EM_PRC_APP_DT.Text = nextDay;
    }else{                                     // 사후전표, 재고조정전표   
        EM_ORD_DT.Text     = strToday;
        EM_DELI_DT.Text    = strToday;
        EM_PRC_APP_DT.Text = strToday;
    }

</script>

<!-- 브랜드코드 KillFocus -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    clearPumbunInfo();
    if(EM_PUMBUN_CD.Text != "")
        setStrPbnNmWithoutPopCall();    
    
</script>

<!-- 협력사 KillFocus -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(EM_VEN_CD.Text != "")
        getVenInfo(EM_VEN_CD, EM_VEN_NM, false);
    else
        EM_VEN_NM.Text = "";
</script>

<!-- 발주일 변경시  -->
<script lanaguage=JavaScript for=EM_ORD_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    var aft_ord_flag = LC_AFT_ORD_FLAG.BindColVal;
    var nextDay = addDate("d", 1, EM_ORD_DT.Text);

    if(checkDateTypeYMD(EM_ORD_DT)){
        if(aft_ord_flag == "0"){
            EM_DELI_DT.Text    = nextDay;
            EM_PRC_APP_DT.Text = nextDay;
            if(strToday > EM_ORD_DT.Text){
                nextDay = addDate("d", 1, strToday);
                showMessage(EXCLAMATION, OK, "USER-1180", "발주일");
                EM_ORD_DT.Text = strToday;
                nextDay = addDate("d", 1, EM_ORD_DT.Text);
                EM_DELI_DT.Text = nextDay;
                EM_PRC_APP_DT.Text = nextDay;
                setTimeout( "EM_ORD_DT.Focus()",50);
            }else{
                nextDay = addDate("d", 1, EM_ORD_DT.Text);
                EM_DELI_DT.Text    = nextDay;
                EM_PRC_APP_DT.Text = nextDay;
            }
        }else{
            EM_DELI_DT.Text    = EM_ORD_DT.Text;
            EM_PRC_APP_DT.Text = EM_ORD_DT.Text;
        }
    }

</script>
<!-- 납품예정일 변경시  -->
<script lanaguage=JavaScript for=EM_DELI_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    var nextDay = "";
    if(LC_AFT_ORD_FLAG.BindColVal == "0")
        nextDay = addDate("d", 1, EM_ORD_DT.Text);
    else
        nextDay = EM_ORD_DT.Text;
    
    if(checkDateTypeYMD(EM_DELI_DT,nextDay)){
        if(EM_ORD_DT.Text > EM_DELI_DT.Text){
            showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");
            EM_DELI_DT.Text = nextDay;
            setTimeout( "EM_DELI_DT.Focus()",50);
        }
        EM_PRC_APP_DT.Text = EM_DELI_DT.Text;
    }
</script>
<!-- 가격적용일 변경시  -->
<script lanaguage=JavaScript for=EM_PRC_APP_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    var nextDay = addDate("d", 1, EM_DELI_DT.Text);
    if(checkDateTypeYMD(EM_PRC_APP_DT,EM_DELI_DT.Text)){
        if(EM_DELI_DT.Text > EM_PRC_APP_DT.Text){
            showMessage(EXCLAMATION, OK, "USER-1020", "가격적용일","납품예정일");
            EM_PRC_APP_DT.Text = EM_DELI_DT.Text;
            setTimeout( "EM_PRC_APP_DT.Focus()",50);
        }
    }
</script>
<!-- 비고 KillFocus -->
<script language=JavaScript for=EM_REMARK event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "REMARK", "비고", "EM_REMARK");
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->

<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DEPT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_TEAM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PC" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_GJDATE_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_S_PROC_STAT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_STR1" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_STR2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_AFT_ORD_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PAY_COND" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_LIST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SKU_INFO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_STORE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_BIZ_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_TAX_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ORD_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ORD_OWN_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_L_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="o_table">
            <tr>
                <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th class="point" width="70">점</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="70">팀</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_S_BUMUN classid=<%=Util.CLSID_LUXECOMBO%> width=100
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="70">파트</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_S_TEAM classid=<%=Util.CLSID_LUXECOMBO%> width=100
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="70">PC</th>
                        <td><comment id="_NSID_"> <object id=LC_S_PC
                            classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"
                            tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th class="point">기준일</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_S_GJDATE_TYPE classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th class="point">조회기간</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_S_START_DT classid=<%=Util.CLSID_EMEDIT%> width=70
                            tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_START_DT
                            onclick="javascript:openCal('G',EM_S_START_DT)" align="absmiddle" />
                        ~ <comment id="_NSID_"> <object id=EM_S_END_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_END_DT
                            onclick="javascript:openCal('G',EM_S_END_DT)" align="absmiddle" />
                        </td>
                        <th>전표상태</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_S_S_PROC_STAT classid=<%=Util.CLSID_LUXECOMBO%> width=100
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th>브랜드</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_S_PB_CD classid=<%=Util.CLSID_EMEDIT%> width=88 tabindex=1
                            align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_PUMBUN"
                            class="PR03" align="absmiddle"
                            onclick="javascript:searchPumbunPop(true);" /> <comment
                            id="_NSID_"> <object id=EM_S_PB_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=184 tabindex=1
                            align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                        <th>협력사</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=88 tabindex=1
                            align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_VEN"
                            class="PR03" align="absmiddle"
                            onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, true);" />

                        <comment id="_NSID_"> <object id=EM_S_VEN_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=184 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>

                    <tr>
                        <th>전표번호</th>
                        <td colspan="8"><comment id="_NSID_"> <object
                            id=EM_S_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=108
                            tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td class="dot"></td>
    </tr>
    <tr valign="top">
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td width="200">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_LIST
                            width=100% height=432 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_O_LIST">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
                <td class="PL10">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="PT01 PB03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
                            class="s_table">

                            <tr>
                                <th width="65" class="point">점</th>
                                <td width="105"><comment id="_NSID_"> <object
                                    id=LC_STR classid=<%=Util.CLSID_LUXECOMBO%> width=100
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                                <th width="75">전표번호</th>
                                <td width="105"><comment id="_NSID_"> <object
                                    id=EM_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th width="75">전표상태</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_SLIP_PROC_STAT_NM classid=<%=Util.CLSID_EMEDIT%>
                                    width=115 tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>

                            <tr>
                                <th class="point">점입점</th>
                                <td><comment id="_NSID_"> <object id=LC_PAIR_STR
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script></td>
                                <th>점입전표</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_PAIR_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>점입전표상태</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_P_SLIP_PROC_STAT_NM classid=<%=Util.CLSID_EMEDIT%>
                                    width=115 tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>

                            <tr>
                                <th class="point">사후구분</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_AFT_ORD_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=100
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                                <th>발주구분</th>
                                <td colspan="3"><comment id="_NSID_"> <object
                                    id=EM_ORD_FLAG classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>

                            <tr>
                                <th class="point">브랜드</th>
                                <td colspan="3"><comment id="_NSID_"> <object
                                    id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=80
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
                                    id="IMG_PUMBUN" class="PR03" align="absmiddle"
                                    onclick="javascript:getPumbunInfo('1');" /> <comment
                                    id="_NSID_"> <object id=EM_PUMBUN_NM
                                    classid=<%=Util.CLSID_EMEDIT%> width=196 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                                <th>바이어</th>
                                <td><comment id="_NSID_"> <object id=EM_BUYER_CD
                                    classid=<%=Util.CLSID_EMEDIT%> width=52 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script> <comment
                                    id="_NSID_"> <object id=EM_BUYER_NM
                                    classid=<%=Util.CLSID_EMEDIT%> width=62 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                            </tr>

                            <tr>
                                <th>거래형태</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_BIZ_TYPE_NM classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>과세구분</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_TAX_FLAG_NM classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>발주주체</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_ORD_OWN_FLAG classid=<%=Util.CLSID_EMEDIT%> width=115
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>

                            <tr>
                                <th class="point">협력사</th>
                                <td colspan="3"><comment id="_NSID_"> <object
                                    id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script> <img
                                    src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN"
                                    class="PR03" align="absmiddle"
                                    onclick="javascript:getVenInfo(EM_VEN_CD, EM_VEN_NM, true);" />
                                <comment id="_NSID_"> <object id=EM_VEN_NM
                                    classid=<%=Util.CLSID_EMEDIT%> width=196 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                                <th class="point">지불구분</th>
                                <td><comment id="_NSID_"> <object id=LC_PAY_COND
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=115 align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script></td>
                            </tr>

                            <tr>
                                <th class="point">발주일</th>
                                <td><comment id="_NSID_"> <object id=EM_ORD_DT
                                    classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script> <img
                                    src="/<%=dir%>/imgs/btn/date.gif" id="IMG_ORD_DT"
                                    onclick="javascript:openCal('G',EM_ORD_DT)" align="absmiddle" />
                                </td>
                                <th>발주확정일</th>
                                <td><comment id="_NSID_"> <object id=EM_CONF_DT
                                    classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                                <th class="point">납품예정일</th>
                                <td><comment id="_NSID_"> <object id=EM_DELI_DT
                                    classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script> <img
                                    src="/<%=dir%>/imgs/btn/date.gif" id="IMG_DELI_DT"
                                    onclick="javascript:openCal('G',EM_DELI_DT)" align="absmiddle" />
                                </td>
                            </tr>

                            <tr>
                                <th class="point">가격적용일</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_PRC_APP_DT classid=<%=Util.CLSID_EMEDIT%> width=80
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_PRC_APP_DT"
                                    onclick="javascript:openCal('G',EM_PRC_APP_DT)"
                                    align="absmiddle" /></td>
                                <th>검품확정일</th>
                                <td><comment id="_NSID_"> <object id=EM_CHK_DT
                                    classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                                <th>차익액/율</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_GAP_TOT_AMT classid=<%=Util.CLSID_EMEDIT%> width=65
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                <comment id="_NSID_"> <object id=EM_GAP_RATE
                                    classid=<%=Util.CLSID_EMEDIT%> width=47 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                            </tr>

                            <tr>
                                <th>수량계</th>
                                <td><comment id="_NSID_"> <object id=EM_TOT_QTY
                                    classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                                <th>원가계</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_TOT_COST_AMT classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>매가계</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_TOT_SALE_AMT classid=<%=Util.CLSID_EMEDIT%> width=115
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>

                            <tr>
                                <th>비고</th>
                                <td colspan="5"><comment id="_NSID_"> <object
                                    id=EM_REMARK classid=<%=Util.CLSID_EMEDIT%> width=517
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <!---->
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="right"><img src="/<%=dir%>/imgs/btn/add_row.gif"
                                    id="IMG_ADD" width="52" height="18" hspace="2"
                                    onclick="javascript:addDetailRow();" /><img
                                    src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL" width="52"
                                    height="18" onclick="javascript:delDetailRow();" /></td>
                            </tr>
                            <tr valign="top">
                                <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                                    class="BD4A">
                                    <tr>
                                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL
                                            width=100% height=156 classid=<%=Util.CLSID_GRID%>>
                                            <param name="DataID" value="DS_IO_DETAIL">
                                            <Param Name="ViewSummary" value="1">
                                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                                    </tr>
                                </table>
                                </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</div>
<comment id="_NSID_">
<object id=EM_BIZ_TYPE classid=<%=Util.CLSID_EMEDIT%> width=30
    tabindex=1 align="absmiddle"> </object>
</comment>
<script> _ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=EM_TAX_FLAG classid=<%=Util.CLSID_EMEDIT%> width=30
    tabindex=1 align="absmiddle"> </object>
</comment>
<script> _ws_(_NSID_);</script>

<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>Col=SLIP_NO              Ctrl=EM_SLIP_NO              param=Text</c>
            <c>Col=SLIP_PROC_STAT_NM    Ctrl=EM_SLIP_PROC_STAT_NM    param=Text</c>
            <c>Col=PUMBUN_CD            Ctrl=EM_PUMBUN_CD            param=Text</c>
            <c>Col=PUMBUN_NM            Ctrl=EM_PUMBUN_NM            param=Text</c>         
            <c>Col=BUYER_CD             Ctrl=EM_BUYER_CD             param=Text</c>
            <c>Col=BUYER_NM             Ctrl=EM_BUYER_NM             param=Text</c>
            <c>Col=BIZ_TYPE_NM          Ctrl=EM_BIZ_TYPE_NM          param=Text</c>
            <c>Col=TAX_FLAG_NM          Ctrl=EM_TAX_FLAG_NM          param=Text</c>
            <c>Col=ORD_FLAG_NM          Ctrl=EM_ORD_FLAG             param=Text</c>
            <c>Col=VEN_CD               Ctrl=EM_VEN_CD               param=Text</c>
            <c>Col=VEN_NM               Ctrl=EM_VEN_NM               param=Text</c>
            <c>Col=ORD_OWN_FLAG_NM      Ctrl=EM_ORD_OWN_FLAG         param=Text</c>
            <c>Col=ORD_DT               Ctrl=EM_ORD_DT               param=Text</c>
            <c>Col=ORD_CONF_DT          Ctrl=EM_CONF_DT              param=Text</c>
            <c>Col=DELI_DT              Ctrl=EM_DELI_DT              param=Text</c>
            <c>Col=NEW_PRC_APP_DT       Ctrl=EM_PRC_APP_DT           param=Text</c>
            <c>Col=CHK_DT               Ctrl=EM_CHK_DT               param=Text</c>
            <c>Col=GAP_TOT_AMT          Ctrl=EM_GAP_TOT_AMT          param=Text</c>
            <c>Col=NEW_GAP_RATE         Ctrl=EM_GAP_RATE             param=Text</c>
            <c>Col=ORD_TOT_QTY          Ctrl=EM_TOT_QTY              param=Text</c>
            <c>Col=NEW_COST_TAMT        Ctrl=EM_TOT_COST_AMT         param=Text</c>
            <c>Col=NEW_SALE_TAMT        Ctrl=EM_TOT_SALE_AMT         param=Text</c>
            <c>Col=REMARK               Ctrl=EM_REMARK               param=Text</c>
            <c>Col=PAIR_SLIP_NO         Ctrl=EM_PAIR_SLIP_NO         param=Text</c>
            <c>Col=P_SLIP_PROC_STAT_NM  Ctrl=EM_P_SLIP_PROC_STAT_NM  param=Text</c>
                                                                  
            <c>Col=STR_CD               Ctrl=LC_STR                  param=BindColVal</c>
            <c>Col=PAIR_STR_CD          Ctrl=LC_PAIR_STR             param=BindColVal</c>
            <c>Col=AFT_ORD_FLAG         Ctrl=LC_AFT_ORD_FLAG         param=BindColVal</c>
            <c>Col=PAY_COND             Ctrl=LC_PAY_COND             param=BindColVal</c>
            <c>Col=BIZ_TYPE             Ctrl=EM_BIZ_TYPE             param=Text</c>
            <c>Col=TAX_FLAG             Ctrl=EM_TAX_FLAG             param=Text</c>
            
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<body>
</html>
