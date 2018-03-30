<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 마스터 관리> 위탁협력사 마스터관리
 * 작 성 일 : 2011.04.06
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif115.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.04.06 (김성미) 프로그램 작성 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var btnSearchClick = false;
 var btnSaveClick = false;
 var strToday;
 var strCurRow = 0;
 var strAppDt = replaceStr(addDate('D', +1, getTodayFormat("yyyymmdd")), "-","");
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_O_GIFT_VEN_FLAG.setDataHeader(' CODE:STRING(1),NAME:STRING(40)');
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    
    initEmEdit(EM_S_VEN_CD, "NUMBER3^6", NORMAL);             //협력사코드
    initEmEdit(EM_S_VEN_NM, "GEN", READ);                     //협력사명
    initEmEdit(EM_STR_NM, "GEN", READ);                       //점
    initEmEdit(EM_VEN_CD, "GEN", READ);                       //협력사코드
    initEmEdit(EM_VEN_NM, "GEN", READ);                       //협력사명
    initEmEdit(EM_BIZ_TYPE_NM, "GEN", READ);                  //거래형태
    initEmEdit(EM_COMP_NO, "NUMBER3^10", READ);               //사업자 번호
    initEmEdit(EM_COMP_NAME, "GEN", READ);                    //상호명
    initEmEdit(EM_REP_NAME, "GEN", READ);                     //대표자명
    initEmEdit(EM_BIZ_STAT, "GEN", READ);                     //업태
    initEmEdit(EM_BIZ_CAT, "GEN", READ);                      //종목
    initEmEdit(EM_ADDR, "GEN", READ);                         //주소
    initEmEdit(EM_ADDR_DTL, "GEN", READ);                     //상세주소
    initEmEdit(EM_PHONE_NO, "NUMBER3^10", READ);              //전화번호
    initEmEdit(EM_PAY_DT_FLAG, "GEN", READ);                  //지불일자
    initEmEdit(EM_PAY_WAY, "GEN", READ);                      //지불방법
    initEmEdit(EM_FAX_NO, "NUMBER3^10", READ);                //FAX 번호
    initEmEdit(EM_RATE, "NUMBER^3^2", READ);                //FAX 번호
    
    
    //콤보 초기화
    initComboStyle(LC_S_STR,DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);                      //점(조회)
    //initComboStyle(LC_S_BUY_SALE_FLAG,DS_O_S_BUY_SALE_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);  //매출매출구분(조회)
    initComboStyle(LC_GIFT_VEN_FLAG,DS_O_GIFT_VEN_FLAG, "CODE^0^30,NAME^0^80", 1, READ);      //상품권협력사구분
    
    //getEtcCode("DS_O_S_BUY_SALE_FLAG",   "D", "P017", "Y", "N", LC_S_BUY_SALE_FLAG);
    setGiftVenFlag();
    getStore("DS_O_S_STR", "N", "", "N");
    strToday = getTodayDB("DS_O_RESULT");
    EM_COMP_NO.Format = "###-##-#####";
    EM_COMP_NO.Alignment = 0;
    EM_PHONE_NO.Format = "###-####-####";
    EM_FAX_NO.Format = "###-####-####";
    LC_S_STR.Index = 0;
    LC_S_STR.Focus();
    setObject();
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif115", "DS_IO_STRMST,DS_IO_VENFEEINF");  
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
                     + '<FC>id=STR_NAME      name="점"     width=70   align=left</FC>'
                     + '<FC>id=VEN_CD    name="혐력사;코드"       width=60  align=center</FC>'
                     + '<FC>id=VEN_NAME    name="협력사명"     width=100   align=left</FC>'
                     + '<FC>id=GIFT_VEN_FLAG     name="상품권;협력사구분" editstyle=Lookup Data="DS_O_GIFT_VEN_FLAG:CODE:NAME" width=70 align=left</FC>';
                      
    initGridStyle(GD_STRMST, "common", hdrProperies, false);
    GD_STRMST.TitleHeight = "40";
    
    var hdrProperies1 = '<FC>id={currow}    name="NO"     edit=none     width=50   align=center</FC>'
        + '<FC>id=APP_DT      name="적용일자"  edit={if(SysStatus = "I", "true", "false")}   width=150 mask="XXXX/XX/XX" EditLimit=8 edit=numeric EditStyle=Popup align=center</FC>'
        + '<FC>id=CNS_PAY_FEE_RATE    name="위탁판매 수수료율"  edit=RealNumeric  edit={if(APP_DT <= TODAY, "false", "true")}  width=120  align=right</FC>';
        
    initGridStyle(GD_VENFEEINFO, "common", hdrProperies1, true);
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-06
 * 개    요 : 협력사 마스터 목록 조회
 * return값 : void
 */
function btn_Search() {
    DS_IO_STRMST.ClearData();
    DS_IO_VENFEEINFO.ClearData();

    if(LC_S_STR.BindColVal == ""){
    	showMessage(EXCLAMATION, OK, "USER-1002", "점코드");
        LC_S_STR.Focus();
        return;
    }
    // 조회조건 셋팅
    var strStrCd            = LC_S_STR.BindColVal;
    var strBuySaleFlag      = "%";
    var strVenCd            = EM_S_VEN_CD.Text;
    var goTo       = "getStrMst" ;    
    var action     = "O";     
    var parameters = "&strStrCd="      + encodeURIComponent(strStrCd)
                   + "&strBuySaleFlag="+ encodeURIComponent(strBuySaleFlag)
                   + "&strVenCd="      + encodeURIComponent(strVenCd);
    
    btnSearchClick = true;
    TR_MAIN.Action="/mss/mgif115.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_STRMST=DS_IO_STRMST)"; //조회는 O
    TR_MAIN.Post();

    if(DS_IO_STRMST.CountRow > 0){
        if(strCurRow > 0) DS_IO_STRMST.RowPosition = strCurRow;
        getVenFeeMst();
    }else{
    	setObject();
    }
    
    strCurRow = 0;
    btnSearchClick = false;
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    // 저장할 데이터 없는 경우
	if (!DS_IO_STRMST.IsUpdated && !DS_IO_VENFEEINFO.IsUpdated){
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
    

    if(DS_IO_STRMST.NameValue(DS_IO_STRMST.RowPosition, "GIFT_VEN_FLAG") == "9"){
        showMessage(EXCLAMATION , OK, "USER-1000", "상품권협력사 구분을 선택해주세요.");
        return;
   }
    
    if(!checkDSBlank(GD_VENFEEINFO, "1")) return;
    
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    btnSaveClick = true;
    TR_MAIN.Action="/mss/mgif115.mg?goTo=save";
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_STRMST=DS_IO_STRMST,I:DS_IO_VENFEEINFO=DS_IO_VENFEEINFO)";  
    TR_MAIN.Post();
    btnSaveClick = false;
    strCurRow = DS_IO_STRMST.RowPosition;
    if(TR_MAIN.ErrorCode == 0) btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * setGiftVenFlag()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-31
  * 개    요 : 상품권협력사 코드 셋팅
  * return값 : void
  */

 function setGiftVenFlag() {
     DS_O_GIFT_VEN_FLAG.ClearData();
     DS_O_GIFT_VEN_FLAG.AddRow();
     DS_O_GIFT_VEN_FLAG.NameValue(DS_O_GIFT_VEN_FLAG.CountRow, "CODE") = "3";
     DS_O_GIFT_VEN_FLAG.NameValue(DS_O_GIFT_VEN_FLAG.CountRow, "NAME") = "위탁협력사";
     DS_O_GIFT_VEN_FLAG.AddRow();
     DS_O_GIFT_VEN_FLAG.NameValue(DS_O_GIFT_VEN_FLAG.CountRow, "CODE") = "9";
     DS_O_GIFT_VEN_FLAG.NameValue(DS_O_GIFT_VEN_FLAG.CountRow, "NAME") = "미정";
 }
 
 /**
  * addRow()
  * 작 성 자 : 
  * 작 성 일 : 2011-06-21
  * 개    요 : 상품권 수수료율 행추가
  * return값 : void
  */

 function addRow() {
    if(DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"APP_DT") == ""){
            if(showMessage(QUESTION , YESNO, "USER-1085") != 1){
                  return false;
            }
            DS_IO_VENFEEINFO.DeleteRow(DS_IO_VENFEEINFO.RowPosition);
    }
    
    DS_IO_VENFEEINFO.AddRow();
    DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"APP_DT") = addDate("d", "+1",strToday,"");
    DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"STR_CD") = DS_IO_STRMST.NameValue(DS_IO_STRMST.RowPosition,"STR_CD");
    DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"VEN_CD") = DS_IO_STRMST.NameValue(DS_IO_STRMST.RowPosition,"VEN_CD");
 }
 
 /**
  * delRow()
  * 작 성 자 : 
  * 작 성 일 : 2011-06-21
  * 개    요 : 상품권 수수료율 행삭제
  * return값 : void
  */

 function delRow() {
     if(DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"APP_DT") <= strToday
             && DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"APP_DT") != ""){
         showMessage(EXCLAMATION, OK, "USER-1000","적용일자가 오늘 이전인경우에는 삭제 할수 없습니다.");
         return;
     }
     
      if(DS_IO_VENFEEINFO.SysStatus(DS_IO_VENFEEINFO.RowPosition) != "1"){
            // 삭제전 이전 종료일 변경
             var strDt1 = DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition-1,"APP_DT");
             var strDt2 = DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition+1,"APP_DT"); 
             
             // 정렬 asc
             if(strDt1 < DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"APP_DT")){
                 DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition-1,"END_DT") = replaceStr(addDate("D",-1,DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"APP_DT")),"-","");
             }
             
            // 정렬 desc
             if(strDt2 < DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"APP_DT")){
                 DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition+1,"END_DT") = replaceStr(addDate("D",-1,DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"APP_DT")),"-",""); 
             }
      }
    
    DS_IO_VENFEEINFO.DeleteRow(DS_IO_VENFEEINFO.RowPosition);
 }
 
 /**
  * getVenFeeMst()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-03-31
  * 개    요 : 협력사 마스터 목록 조회
  * return값 : void
  */
 function getVenFeeMst() {
     // 조회조건 셋팅
     var strStrCd            = DS_IO_STRMST.NameValue(DS_IO_STRMST.RowPosition, "STR_CD");
     var strVenCd            = DS_IO_STRMST.NameValue(DS_IO_STRMST.RowPosition, "VEN_CD");
     var goTo       = "getVenFeeMst" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+ encodeURIComponent(strStrCd)
                    + "&strVenCd="+ encodeURIComponent(strVenCd);
     
     TR_MAIN.Action="/mss/mgif115.mg?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_VENFEEINFO=DS_IO_VENFEEINFO)"; //조회는 O
     TR_MAIN.Post();
     
     var strRate= 0 ;
     if(DS_IO_VENFEEINFO.CountRow > 0){
    	 // 마스터 수수료 정보 셋팅
	     for(var i=1; i<=DS_IO_VENFEEINFO.CountRow;i++){
	    	 if(DS_IO_VENFEEINFO.NameValue(i,"APP_DT") <= strToday){
	    		 strRate = DS_IO_VENFEEINFO.NameValue(i,"CNS_PAY_FEE_RATE");
	    	 }
	     }
     }
     EM_RATE.Text = strRate;
     setObject();
 } 
 
 /**
  * setObject()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-31
  * 개    요 : 적용일에 따른 컴포넌트 활성/비활성화
  * return값 : void
  */

 function setObject() {
	    
	 // 상품협력사 구분이 미정인경우만 콤보 활성화
        if(DS_IO_STRMST.NameValue(DS_IO_STRMST.RowPosition, "GIFT_VEN_FLAG") == '9' ){
            LC_GIFT_VEN_FLAG.Enable = true;
        }else{
            LC_GIFT_VEN_FLAG.Enable = false;
        }
	 
        if(DS_IO_STRMST.CountRow > 0){
            enableControl(IMG_ADD_ROW, true);
            enableControl(IMG_DEL_ROW, true);
        }else{
            enableControl(IMG_ADD_ROW, false);
            enableControl(IMG_DEL_ROW, false);
        }
 }
 
 /**
  * getVenCd()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-06
  * 개    요 : 가맹점 팝업 오픈시 점코드 필수
  * return값 : void
  */
 function getVenCd(){
     if(LC_S_STR.BindColVal == "%"){
            showMessage(EXCLAMATION, OK, "USER-1002", "점코드");
            LC_S_STR.Focus();
            return;
        }
     getMssEvtVenPop( EM_S_VEN_CD, EM_S_VEN_NM, 'S', '3', '', LC_S_STR.BindColVal, '')
 }
--></script>
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_S_STR event=OnFilter(row)>
if (DS_O_S_STR.NameValue(row, "CODE") == "00") {// 점
    return false;
}
return true;
</script>
<script language=JavaScript for=DS_IO_STRMST event=CanRowPosChange(row)>
if(btnSearchClick) return;
if(DS_IO_STRMST.IsUpdated && !btnSaveClick){
     if(showMessage(QUESTION , YESNO, "USER-1049") != 1 ){
         return false;
         }
     DS_IO_STRMST.NameValue(row, "GIFT_VEN_FLAG") = DS_IO_STRMST.OrgNameValue(row, "GIFT_VEN_FLAG");
     return true;
}
return true;
</script>
<script language=JavaScript for=DS_IO_STRMST event=OnRowPosChanged(row)>
if(btnSearchClick) return;
getVenFeeMst();
setObject();
</script>
<script language=JavaScript for=DS_IO_VENFEEINFO event=OnRowPosChanged(row)>
if(row == 0)return;
setObject();
</script>
<script language=JavaScript for=DS_IO_VENFEEINFO event=OnColumnChanged(row,colid)>
if(colid == "APP_DT" && DS_IO_VENFEEINFO.NameValue(row, "APP_DT") != ""){
    if(DS_IO_VENFEEINFO.NameValue(row, colid) <= strToday){
        showMessage(EXCLAMATION, OK, "USER-1011", "적용일자");
        DS_IO_VENFEEINFO.NameValue(row, colid) = "";
        return false;
    }
    
    var strValue = "";
    var strOValue = "";
    for(var i=1;i<=DS_IO_VENFEEINFO.CountRow;i++){ // 수수료 적용일자 중복체크
        if(strValue < DS_IO_VENFEEINFO.NameValue(i, colid)){
            strValue = DS_IO_VENFEEINFO.NameValue(i, colid);
        }
        if(i == row)continue;
        if((DS_IO_VENFEEINFO.NameValue(row, colid) == DS_IO_VENFEEINFO.NameValue(i, colid))){
            showMessage(EXCLAMATION, OK, "USER-1044");
            DS_IO_VENFEEINFO.NameValue(row, colid) = "";
            return false;
        }
        
        if(strOValue < DS_IO_VENFEEINFO.NameValue(i, colid)){
            strOValue = DS_IO_VENFEEINFO.NameValue(i, colid);
        }
    }
    
    
    var strRow  = DS_IO_VENFEEINFO.NameValueRow("APP_DT",strValue);
    var strORow  = DS_IO_VENFEEINFO.NameValueRow("APP_DT",strOValue);
    var strEndDt = replaceStr(addDate("D",-1,DS_IO_VENFEEINFO.NameValue(strRow,"APP_DT")),"-","");
    var strOEndDt = replaceStr(addDate("D",-1,DS_IO_VENFEEINFO.NameValue(strRow,"APP_DT")),"-","");
    DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"END_DT") = strEndDt;
    if(DS_IO_VENFEEINFO.CountRow > 1) DS_IO_VENFEEINFO.NameValue(strORow,"END_DT") = strOEndDt;
    DS_IO_VENFEEINFO.NameValue(strRow,"END_DT") = "99991231";
}

if(colid == "CNS_PAY_FEE_RATE" && DS_IO_VENFEEINFO.NameValue(row, "CNS_PAY_FEE_RATE") != ""){
    if(DS_IO_VENFEEINFO.NameValue(row, colid) < 0 || DS_IO_VENFEEINFO.NameValue(row, colid) > 100){
        showMessage(EXCLAMATION, OK, "USER-1000", "수수료율은 0 ~ 100 사이로 입력하세요.");
        DS_IO_VENFEEINFO.NameValue(row, colid) = "0";
    }
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
 <script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
 //코드가 존재 하지 않으면 명을 클리어 후 리턴
 if( this.Text ==""){
     EM_S_VEN_NM.Text = "";
        return;
    }
 if(this.Text.length > 0){
	    if(LC_S_STR.BindColVal == "%"){
	        showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
	        LC_S_STR.Focus();
	        return;
	    }
	    getMssEvtVenNonPop( "DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM, "E", "Y", "2", '', LC_S_STR.BindColVal, '');
	}
</script>
<script language=JavaScript for=LC_GIFT_VEN_FLAG event=OnSelChange()>
setObject();
</script>
<script language=JavaScript for=LC_S_STR event=OnSelChange()>
 EM_S_VEN_CD.Text = "";
 EM_S_VEN_NM.Text = "";
</script>
<script language=JavaScript for=GD_VENFEEINFO event=OnClick(row,colid)>
if(row == 0){
    sortColId( eval(this.DataID), row , colid );
    return;
}
if(DS_IO_VENFEEINFO.CountRow > 1) return;
setObject();
</script>
<script language=JavaScript for=GD_STRMST event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_VENFEEINFO    event=OnPopup(row,colid,data)>
   openCal(this,row,colid);    
</script>
<script language=JavaScript for=GD_VENFEEINFO event=CanColumnPosChange(row,colid)>
if(colid == "APP_DT" && DS_IO_VENFEEINFO.NameValue(row, "APP_DT") != ""){
    if(DS_IO_VENFEEINFO.NameValue(row, colid) <= strToday){
        showMessage(EXCLAMATION, OK, "USER-1011", "적용일자");
        DS_IO_VENFEEINFO.NameValue(row, colid) = "";
        return false;
    }
    
    var strValue = "";
    var strOValue = "";
    for(var i=1;i<=DS_IO_VENFEEINFO.CountRow;i++){ // 수수료 적용일자 중복체크
        if(strValue < DS_IO_VENFEEINFO.NameValue(i, colid)){
            strValue = DS_IO_VENFEEINFO.NameValue(i, colid);
        }
        if(i == row)continue;
        if((DS_IO_VENFEEINFO.NameValue(row, colid) == DS_IO_VENFEEINFO.NameValue(i, colid))){
            showMessage(EXCLAMATION, OK, "USER-1044");
            DS_IO_VENFEEINFO.NameValue(row, colid) = "";
            return false;
        }
        
        if(strOValue < DS_IO_VENFEEINFO.NameValue(i, colid)){
            strOValue = DS_IO_VENFEEINFO.NameValue(i, colid);
        }
    }
    
    
    var strRow  = DS_IO_VENFEEINFO.NameValueRow("APP_DT",strValue);
    var strORow  = DS_IO_VENFEEINFO.NameValueRow("APP_DT",strOValue);
    var strEndDt = replaceStr(addDate("D",-1,DS_IO_VENFEEINFO.NameValue(strRow,"APP_DT")),"-","");
    var strOEndDt = replaceStr(addDate("D",-1,DS_IO_VENFEEINFO.NameValue(strRow,"APP_DT")),"-","");
    DS_IO_VENFEEINFO.NameValue(DS_IO_VENFEEINFO.RowPosition,"END_DT") = strEndDt;
    if(DS_IO_VENFEEINFO.CountRow > 1) DS_IO_VENFEEINFO.NameValue(strORow,"END_DT") = strOEndDt;
    DS_IO_VENFEEINFO.NameValue(strRow,"END_DT") = "99991231";
}
if(colid == "CNS_PAY_FEE_RATE" && DS_IO_VENFEEINFO.NameValue(row, "CNS_PAY_FEE_RATE") != ""){
    if(DS_IO_VENFEEINFO.NameValue(row, colid) < 0 || DS_IO_VENFEEINFO.NameValue(row, colid) > 100){
        showMessage(EXCLAMATION, OK, "USER-1000", "수수료율은 0 ~ 100 사이로 입력하세요.");
        DS_IO_VENFEEINFO.NameValue(row, colid) = "0";
        return false;
    }
}
return true;
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

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_STR"  classid=<%= Util.CLSID_DATASET %>>
<param name=UseFilter value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_BUY_SALE_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT_VEN_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_STRMST"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_VENFEEINFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
            <td width="130">
                        <comment id="_NSID_">
                        <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=130 align="absmiddle" tabindex=1>
                        </object>
                    </comment><script>_ws_(_NSID_);</script></td>
            <th width="80">위탁협력사</th>
            <td >
                    <comment id="_NSID_">
                          <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%>   width=80 tabindex=1 align="absmiddle" tabindex=1>
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" onclick="javascript:getVenCd();" class="PR03"/>
                       <comment id="_NSID_">
                          <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%>   width=130 tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
              </td>
          </tr>           
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width="230">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A">
            <tr>
            <td>
            <comment id="_NSID_"><OBJECT id=GD_STRMST width=100% height=500 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_STRMST">
            </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>
            </tr>
            </table>
        </td>
        <td class="PL05">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr height=18>
            <td colspan=2>
               <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>위탁협력사 마스터 정보</td>
              </tr>
            </table>
           </td>
          </tr>
          <tr>
            <td class="PB03"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="120">점</th>
                    <td colspan=3>
                        <comment id="_NSID_">
                          <object id=EM_STR_NM classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th width="110">협력사코드</th>
                    <td width="150">
                        <comment id="_NSID_">
                          <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th width="110">협력사명</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th>거래형태</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_BIZ_TYPE_NM classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th>사업자번호</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_COMP_NO classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                    <th>상호명</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_COMP_NAME classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th>대표자명</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_REP_NAME classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th>업태</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_BIZ_STAT classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th>종목</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_BIZ_CAT classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th>주소</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                          <object id=EM_ADDR classid=<%=Util.CLSID_EMEDIT%>   width=434 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                   <tr>
                    <th>상세주소</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                          <object id=EM_ADDR_DTL classid=<%=Util.CLSID_EMEDIT%>   width=434 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                  <th>전화번호</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_PHONE_NO classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th>FAX번호</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_FAX_NO classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                   <th>지불일자</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_PAY_DT_FLAG classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th>지불방법</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_PAY_WAY classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">상품권협력사구분</th>
                    <td>
                        <comment id="_NSID_">
                        <object id=LC_GIFT_VEN_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150 align="absmiddle" tabindex=1>
                        </object>
                    </comment><script>_ws_(_NSID_);</script></td>
                    <th>수수료율</th>
                    <td>
                        <comment id="_NSID_">
                          <object id=EM_RATE classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
                          </object>
                      </comment><script>_ws_(_NSID_);</script></td>
                  </tr>                  
                </table></td>
                </tr>
                <tr>
            <td class="dot"></td>
          </tr>
          <tr valign=top>
                <td>
               <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>    
                       <td class="right PB02">
                            <img src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD_ROW" width="52" height="18" onClick="javaScript:addRow();" hspace="2"/> 
                            <img src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL_ROW" width="52" height="18" onClick="javaScript:delRow();"/>
                        </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A">
                          <tr>
                            <td> 
                            <comment id="_NSID_"><OBJECT id=GD_VENFEEINFO width=100% height=200 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_VENFEEINFO">
                                </OBJECT></comment><script>_ws_(_NSID_);</script></td>
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
    </table></td>
  </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BO_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_STRMST>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>col=STR_NAME           ctrl=EM_STR_NM            param=Text</c>
        <c>col=VEN_CD             ctrl=EM_VEN_CD            param=Text</c>
        <c>col=VEN_NAME           ctrl=EM_VEN_NM            param=Text</c>
        <c>col=BIZ_TYPE_NM        ctrl=EM_BIZ_TYPE_NM       param=Text</c>
        <c>col=COMP_NO            ctrl=EM_COMP_NO           param=Text</c>
        <c>col=COMP_NAME          ctrl=EM_COMP_NAME         param=Text</c>
        <c>col=REP_NAME           ctrl=EM_REP_NAME          param=Text</c>
        <c>col=BIZ_STAT           ctrl=EM_BIZ_STAT          param=Text</c>
        <c>col=BIZ_CAT            ctrl=EM_BIZ_CAT           param=Text</c>
        <c>col=ADDR               ctrl=EM_ADDR              param=Text</c>
        <c>col=ADDR_DTL           ctrl=EM_ADDR_DTL          param=Text</c>
        <c>col=PHONE_NO           ctrl=EM_PHONE_NO          param=Text</c>
        <c>col=FAX_NO             ctrl=EM_FAX_NO            param=Text</c>
        <c>col=PAY_DT_FLAG_NM     ctrl=EM_PAY_DT_FLAG_NM    param=Text</c>
        <c>col=PAY_WAY_NM         ctrl=EM_PAY_WAY_NM        param=Text</c>
        <c>col=GIFT_VEN_FLAG      ctrl=LC_GIFT_VEN_FLAG     param=BindColVal</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

