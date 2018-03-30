<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 판매/회수> 회수등록
 * 작 성 일 : 2011.01.19
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif3070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상품권 회수 등록
 * 이    력 :
 *        2011.05.19 (김성미) 프로그램작성
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
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
 var strUserNM = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
 var strOrgCd = '<c:out value="${sessionScope.sessionInfo.ORG_CD}" />';
 var strToday   ;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 130;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_GIFTCARD"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_DRAWL_DT, "TODAY", PK);                   // 회수일자
    initEmEdit(EM_USER_NM,  "GEN", READ);                   // 등록자
    initEmEdit(EM_GIFT_NO, "GEN^18", NORMAL);           // 상품권코드
    //initEmEdit(EM_GIFT_NO, "NUMBER3^18", NORMAL);           // 상품권코드
    
  //콤보 초기화
    initComboStyle(LC_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);                  //점
    initComboStyle(LC_DRAWL_FLAG,DS_O_DRAWL_FLAG, "CODE^0^30,NAME^0^80", 1, PK);    //회수구분
    getStore("DS_O_STR", "Y", "", "N");
    DS_O_DRAWL_FLAG.Filter();     //회수구분, 1(정상회수), 5(재무회수) 만셋팅
  //시스템 코드 공통코드에서 가지고 오기
    getEtcCode("DS_O_DRAWL_FLAG",   "D", "M076", "N" ,"N");
    EM_USER_NM.Text = strUserNM;
    strToday   = getTodayDB("DS_O_RESULT");
    EM_DRAWL_DT.Text = strToday;
    LC_STR.Index = 0;
    LC_DRAWL_FLAG.Index = 0;
    LC_STR.Focus();
   
    registerUsingDataset("mgif307","DS_IO_MASTER");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
                     + '<FC>id=GIFT_TYPE_NAME    name="상품권종류" edit=none  SumText="합계"    width=80  align=left</FC>'
                     + '<FC>id=GIFT_AMT_NAME    name="금종명"   edit=none  width=90   align=left</FC>'
                     + '<FC>id=GIFTCERT_AMT    name="상품권금액" SumText=@sum   edit=none  width=90   align=right</FC>'
                     + '<FC>id=GIFTCARD_NO    name="상품권코드"  edit=none   width=140   align=center</FC>'
                     + '<FC>id=QTY    name="수량"  SumText=@sum edit=none width=70   align=right</FC>'
                     + '<FC>id=STAT_FLAG_NM    name="상품권상태"  edit=none   width=70   align=left</FC>'
                     + '<FC>id=SALE_DT    name="판매일자"   edit=none  width=80  mask="XXXX/XX/XX" align=center</FC>'
                     + '<FC>id=DRAWL_DT    name="회수일자"  edit=none   width=80 mask="XXXX/XX/XX"  align=center</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    GD_MASTER.ViewSummary = "1";
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    if((DS_IO_MASTER.CountRow > 0 ) &&  (showMessage(QUESTION , YESNO, "USER-1085") != 1)){
        return;
    }
    setNew();
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
    if (DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
     
    if(LC_DRAWL_FLAG.BindColVal == ""){  // 점코드
        showMessage(EXCLAMATION , OK, "USER-1002", "회수구분");
        LC_DRAWL_FLAG.Focus();
        return;
    }
	 
 // 마감체크 (common.js) : 일정산마감
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_STR.BindColVal
                      , EM_DRAWL_DT.Text
                      ,'MGIF','25','0','D') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "일", "");
        LC_STR.Focus();
        return;
    }
 
    // 마감체크 (common.js) : 월정산마감
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_STR.BindColVal
                      , EM_DRAWL_DT.Text
                      ,'MGIF','46','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "월", "");
        LC_STR.Focus();
        return;
    }
    
    if(!checkDSBlank(GD_MASTER, "9")) return;
    
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    
    var strParam = "&strDrawlDt="  + encodeURIComponent(EM_DRAWL_DT.Text)
                 + "&strStrCd="    + encodeURIComponent(LC_STR.BindColVal)
                 + "&strDrawlFlag="+ encodeURIComponent(LC_DRAWL_FLAG.BindColVal);
    
    TR_MAIN.Action="/mss/mgif307.mg?goTo=save"+strParam;  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MAIN.Post();
    
    if(TR_MAIN.ErrorCode == 0) {
        setNew();
    }
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
  * setNew()
  * 작 성 자 : 
  * 작 성 일 : 2011-05-09
  * 개    요 : 초기화
  * return값 : void
  */ 
 function setNew(){
     DS_IO_MASTER.ClearData();
     EM_GIFT_NO.Text = "";
     LC_STR.Index = 0;
     EM_DRAWL_DT.Text = strToday;
     LC_DRAWL_FLAG.Index = 0;
     LC_STR.Focus();
}
 /**
  * getGiftNoInfo()
  * 작 성 자 : 
  * 작 성 일 : 2011-05-09
  * 개    요 :  상품권 정보 조회
  * return값 : void
  */ 
 function getGiftNoInfo(){

     DS_O_GIFT_INFO.ClearData();
     var goTo       = "getGiftNoInfo";
     var parameters = "&strGiftNo=" + encodeURIComponent(EM_GIFT_NO.Text); 
     TR_MAIN.Action   = "/mss/mgif307.mg?goTo=" + goTo + parameters;
     TR_MAIN.KeyValue = "SERVLET(O:DS_O_GIFT_INFO=DS_O_GIFT_INFO)";
     TR_MAIN.Post();
     
     if(DS_O_GIFT_INFO.CountRow == 0){
         showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
         EM_GIFT_NO.Text = "";
         setTimeout("EM_GIFT_NO.Focus()", 50);
         return;
     }
     
     if(DS_O_GIFT_INFO.NameValue(1,"STAT_FLAG") != "05" && DS_O_GIFT_INFO.NameValue(1,"STAT_FLAG") != "06"){
    	 showMessage(EXCLAMATION, OK, "USER-1000", DS_O_GIFT_INFO.NameValue(1,"STAT_FLAG_NM")+" 상태의 상품권은 회수가 불가능합니다.");
         EM_GIFT_NO.Text = "";
         setTimeout("EM_GIFT_NO.Focus()", 50);
         return;
     }
     
     var strData = DS_O_GIFT_INFO.ExportData(1, DS_O_GIFT_INFO.CountRow, true);
     DS_IO_MASTER.ImportData(strData);
     EM_GIFT_NO.Text = "";
     setTimeout("EM_GIFT_NO.Focus()", 50);
 }

 /**
  * delRow()
  * 작 성 자 : 
  * 작 성 일 : 2011-05-19
  * 개    요 :  행삭제
  * return값 : void
  */
function delRow(){
	if(DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
	
	DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
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
<script language=JavaScript for=DS_O_DRAWL_FLAG event=OnFilter(row)>
// if (DS_O_DRAWL_FLAG.NameValue(row, "CODE") == "1" || DS_O_DRAWL_FLAG.NameValue(row, "CODE") == "5") {// 정상회수, 재무회수
//     return true;
// }
if (DS_O_DRAWL_FLAG.NameValue(row, "CODE") == "1" || DS_O_DRAWL_FLAG.NameValue(row, "CODE") == "6" || DS_O_DRAWL_FLAG.NameValue(row, "CODE") == "9") {// 정상회수, 강제회수추가
    return true;
}
return false;
</script>
<script language=JavaScript for=DS_O_STR event=OnFilter(row)>
if (DS_O_STR.NameValue(row, "GBN") != "0") {// 본사점
    return true;
}
return false;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=EM_DRAWL_DT event=OnKillFocus()>
/*if(this.Text > strToday){
    showMessage(EXCLAMATION, OK, "USER-1009", "회수일자", "오늘");
    this.Text = strToday;
    this.Focus();
    return false;
}*/
return true;
</script>
<script language=JavaScript for=EM_GIFT_NO event=OnKillFocus()>
if(this.Text == "") return;
if(this.Text.length != 12 && this.Text.length != 13 && this.Text.length != 16 && this.Text.length != 18){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout(this.id+".Focus()", 50);
    return;
}

// 기존 판매내역 확인
 for(var j=1;j<=DS_IO_MASTER.CountRow;j++){
     if(this.Text == DS_IO_MASTER.NameValue(j, "GIFTCARD_NO")){
         showMessage(EXCLAMATION, OK, "USER-1000", "중복된 상품권 정보가 있습니다.");
         this.Text = "";
         setTimeout(this.id+".Focus()", 50);
         return false;
     }
 }
 
 getGiftNoInfo();
return true;
</script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0) sortColId(eval(this.DataID), row, colid);
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
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>   
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT_INFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DRAWL_FLAG"  classid=<%= Util.CLSID_DATASET %>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>


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
            <th width="100" class="point">점</th>
            <td width="130">
                   <comment id="_NSID_">
                   <object id=LC_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=128 tabindex=1 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
              </td>
            <th width="100" class="point">일자</th>
            <td  width="150">
                <comment id="_NSID_">
                  <object id=EM_DRAWL_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);"  width=125 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_DRAWL_DT)" align="absmiddle" />
            </td>
            <th width="100">등록자</th>
            <td>
                  <comment id="_NSID_">
                  <object id=EM_USER_NM classid=<%=Util.CLSID_EMEDIT%>   width=120 tabindex=1>
                  </object></comment><script>_ws_(_NSID_);</script>
            </td>
          </tr> 
        </table></td>
      </tr>
    </table></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
        <td class="PB05">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width=540>
           <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
                <th width="100" class="point">회수구분</th>
	            <td width="130">
	                   <comment id="_NSID_">
	                   <object id=LC_DRAWL_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=128 tabindex=1 align="absmiddle">
	                   </object>
	               </comment><script>_ws_(_NSID_);</script> 
	              </td>
                <th width="100">상품권 코드</th>
                <td width="160">
                   <comment id="_NSID_"><object id=EM_GIFT_NO classid=<%=Util.CLSID_EMEDIT%>   width=158 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
            </tr>
        </table>
        </td>
        <td class="right">
         <img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onClick="javascript:delRow();"/>
        </tr>
       </table>
    </td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
    <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=760 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_IO_MASTER">
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>
</table>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>
