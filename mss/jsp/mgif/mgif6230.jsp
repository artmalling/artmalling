<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 정산관리 > 자사상품권POS회수집계조회
 * 작 성 일 : 2016.
 * 작 성 자 : KHJ
 * 수 정 자 : 
 * 파 일 명 : mgif6230.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 자사상품권 정산내역을 조회 한다.
 * 이    력 : 2011.03.14 (신익수) 신규개발
 *         
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
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var old_Row = 0;
var btnSearchClick = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 500;		//해당화면의 동적그리드top위치
 var top2 = 500;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GD_DETAIL2"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

    // Input Data Set Header 초기화
  
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    DS_O_DETAIL2.setDataHeader('<gauce:dataset name="H_DETAIL2"/>');
    
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_CAL_YMD_FROM, "SYYYYMMDD", PK);       //폐기일자 from
    initEmEdit(EM_CAL_YMD_TO, "TODAY", PK);         //폐기일자 to
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점
    //initComboStyle(LC_GIFT_TYPE_CD,DS_O_GIFT_TYPE_CD, "CODE^0^30,NAME^0^100", 1, PK);	//상품권종류
    
    getStore("DS_O_STR_CD", "Y", "", "N");
    getGiftTypeCd();
    
    LC_STR_CD.index = 0;
    LC_STR_CD.Focus();
	//LC_GIFT_TYPE_CD.Index = 0;
}

function gridCreate(){

	var hdrProperies  =  '<FC>id={currow}               name="NO"              width=25   align=center</FC>'
				        + '<FC>id=GIFT_TYPE_CD          name="상품권종류"      width=80   align=left EditStyle=Lookup    DATA="DS_O_GIFT_TYPE_CD:CODE:NAME" sumtext="합계"</FC>' 
				        + '<FC>id=GIFT_AMT_TYPE         name="금종"            width=80   align=left show=false  </FC>'
				        + '<FC>id=GIFT_AMT_NAME         name="금종명"          width=80   align=left  </FC>'
				        + '<FC>id=GIFTCERT_AMT          name="상품권금액"      width=70   align=light </FC>'
				        + '<FC>id=GIFTCERT_QTY          name="수량"            width=80   align=light sumtext=@sum </FC>'
				        + '<FC>id=GIFTCERT_AMT_SUM      name="합계금액"        width=80   align=light sumtext=@sum </FC>';

	initGridStyle(GD_MASTER, "common", hdrProperies, false);
				        
				        
	var hdrProperies1 =   '<FC>id={currow}              name="NO"              width=25   align=center</FC>'
				         + '<FC>id=GIFT_TYPE_CD         name="상품권종류"      width=80   align=left EditStyle=Lookup    DATA="DS_O_GIFT_TYPE_CD:CODE:NAME" sumtext="합계"</FC>' 
	                     + '<FC>id=GIFT_AMT_TYPE        name="금종"            width=80   align=left show=false </FC>'
				         + '<FC>id=GIFT_AMT_NAME        name="금종명"          width=80   align=left  </FC>'
				         + '<FC>id=GIFTCERT_AMT         name="상품권금액"      width=70   align=light </FC>'
				         + '<FC>id=GIFTCERT_QTY         name="수량"            width=80   align=light sumtext=@sum </FC>'
				         + '<FC>id=GIFTCERT_AMT_SUM     name="합계금액"        width=80   align=light sumtext=@sum </FC>';
				         
	initGridStyle(GD_DETAIL, "common", hdrProperies1, false);
	  
	var hdrProperies2 =  '<FC>id={currow}               name="NO"              width=25   align=center</FC>'
				        + '<FC>id=GIFT_TYPE_CD          name="상품권종류"      width=80   align=left EditStyle=Lookup    DATA="DS_O_GIFT_TYPE_CD:CODE:NAME" sumtext="합계"</FC>' 
				        + '<FC>id=GIFT_AMT_TYPE         name="금종"            width=80   align=left show=false </FC>'
				        + '<FC>id=GIFT_AMT_NAME         name="금종명"          width=80   align=left  </FC>'
				        + '<FC>id=GIFTCERT_AMT          name="상품권금액"      width=70   align=light </FC>'
				        + '<FC>id=GIFTCERT_QTY          name="수량"            width=80   align=light sumtext=@sum </FC>'
				        + '<FC>id=GIFTCERT_AMT_SUM      name="합계금액"        width=80   align=light sumtext=@sum </FC>'
						 ;

	initGridStyle(GD_DETAIL2, "common", hdrProperies2, false);
	
          
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
	if(LC_STR_CD.BindColVal.length == 0){ 
        showMessage(INFORMATION, OK, "USER-1001", "점");
        LC_STR_CD.focus();
        return;
     }
    
     // 조회조건 셋팅
     var strStrCd        = LC_STR_CD.BindColVal;           //점코드
     var strCalYmdFrom          = EM_CAL_YMD_FROM.Text;  //회수일자 FROM
     var strCalYmdTo          = EM_CAL_YMD_TO.Text;      //회수일자 TO
     
     if(strCalYmdFrom > strCalYmdTo) {
         showMessage(INFORMATION, OK, "USER-1000","시작일은 종료일보다 작아야 합니다.");
         EM_CAL_YMD_FROM.Focus();
         return;
     }
     
     //데이타 셋 클리어
     DS_O_MASTER.ClearData();
     DS_O_DETAIL.ClearData();
     DS_O_DETAIL2.ClearData();
     
     var goTo       = "getGiftPosSum" ;      
     var action     = "O";     
     var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                    + "&strCalYmdFrom="+ encodeURIComponent(strCalYmdFrom)
                    + "&strCalYmdTo="  + encodeURIComponent(strCalYmdTo)
                    ;
     
     TR_MAIN.Action="/mss/mgif623.mg?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
     TR_MAIN.Post();
     
     old_Row = 1;
     // 조회결과 Return
     setPorcCount("SELECT", GD_MASTER);
     //if (DS_O_MASTER.RowCount > 0){
     	getGiftMst();
     //}
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
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

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
  * getGiftTypeCd()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-04-08
  * 개    요 : 상품권종류 콤보 조회
  * return값 : void
  */
 function getGiftTypeCd() {
    TR_MAIN.Action="/mss/mgif116.mg?goTo=getGiftTypeCd";  
    TR_MAIN.KeyValue="SERVLET(O:DS_O_GIFT_TYPE_CD=DS_O_GIFT_TYPE_CD)"; //조회는 O
    TR_MAIN.Post();
 }
 
 function getGiftMst(){

     var strStrCd        = LC_STR_CD.BindColVal;    //점코드
     var strCalYmdFrom   = EM_CAL_YMD_FROM.Text;    //회수일자 FROM
     var strCalYmdTo     = EM_CAL_YMD_TO.Text;      //회수일자 TO
     
     var goTo       = "getGiftMst" ;    
     var action     = "O";     
     var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
			         + "&strCalYmdFrom="+ encodeURIComponent(strCalYmdFrom)
			         + "&strCalYmdTo="  + encodeURIComponent(strCalYmdTo)
	                  ;
			         
    btnSearchClick = true;
    TR_MAIN1.Action="/mss/mgif623.mg?goTo="+goTo+parameters;  
    TR_MAIN1.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_MAIN1.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_DETAIL.Countrow);
    getGiftMstNot();
    btnSearchClick = false;
}

function getGiftMstNot(){
	
    var strStrCd        = LC_STR_CD.BindColVal;   //점코드
    var strCalYmdFrom   = EM_CAL_YMD_FROM.Text;   //회수일자 FROM
    var strCalYmdTo     = EM_CAL_YMD_TO.Text;     //회수일자 TO
	
    var goTo       = "getGiftMstNot" ;    
    var action     = "O";     
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
				    + "&strCalYmdFrom="+ encodeURIComponent(strCalYmdFrom)
				    + "&strCalYmdTo="  + encodeURIComponent(strCalYmdTo)
                    ;
    
    TR_MAIN1.Action="/mss/mgif623.mg?goTo="+goTo+parameters;  
    TR_MAIN1.KeyValue="SERVLET("+action+":DS_O_DETAIL2=DS_O_DETAIL2)"; //조회는 O
    TR_MAIN1.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_DETAIL2.Countrow);
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
<script language=JavaScript for=TR_MAIN1 event=onSuccess>
    for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
   /* showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN1 event=onFail>
   /* showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN1.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN1.ErrorMsg);
    for(i=1;i<TR_MAIN1.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN1.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN1.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>
<script language=JavaScript for=GD_DETAIL2 event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_STR_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SALE_STR"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL2"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_GIFT_TYPE_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN1" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_DETAIL2");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
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
             <th class="POINT" width="80" >회수점</th>
             <td width="180">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150 align="absmiddle"></object>
               </comment>
               <script>_ws_(_NSID_);</script> 
             </td>
             <th width="80" class="POINT">회수기간</th>
             <td >
                <comment id="_NSID_">
                    <object id=EM_CAL_YMD_FROM classid=<%=Util.CLSID_EMEDIT%> width="70" align="absmiddle"
                    onblur="javascript:checkDateTypeYMD(this);" > 
                    </object>
                 </comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_CAL_YMD_FROM)" /> ~ 
                 <comment id="_NSID_">
                    <object id=EM_CAL_YMD_TO classid=<%=Util.CLSID_EMEDIT%> width="70" align="absmiddle" 
                    onblur="javascript:checkDateTypeYMD(this);" >
                    </object>
                 </comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_CAL_YMD_TO)" align="absmiddle" />
           
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
    <td class="PT01 PB03" >
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=370 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_MASTER">
               <Param Name="ViewSummary"   value="1" >
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>
<!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->

  <tr>
    <td class="PT01 PB03">
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
        <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 아트몰링상품권
        </td>
        <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 형지그룹상품권
        </td>
  	</tr>
    <tr>
    <td width="50%" class="PR05">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=380 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_DETAIL">
               <Param Name="ViewSummary"   value="1" >
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    <td width="50%"  class="PR05">
     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_DETAIL2 width=100% height=380 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_DETAIL2">
               <Param Name="ViewSummary"   value="1" >
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
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

