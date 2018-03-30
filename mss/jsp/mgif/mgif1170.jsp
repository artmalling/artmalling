<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 마스터 관리> 상품권입고내역조회
 * 작 성 일 : 2016.10.19
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif1170.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상품권 입고등록 처리
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" 		prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" 	prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" 		prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" 	prefix="button"%>

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
<script language="javascript" src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
 var btnSaveClick = false;
 var strCurRow = 0 ; 
 var g_select = false;
 var strToday = replaceStr(getTodayFormat("yyyymmdd"), "-","");
 
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 
//var strAppDt = replaceStr(addDate('D', +1, getTodayFormat("yyyymmdd")), "-","");
/**
 * doInit()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-08
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 470;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL2"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    DS_IO_DETAIL2.setDataHeader('<gauce:dataset name="H_DETAIL2"/>');
    
    // Output Data Set Header 초기화


    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_IN_DT, "SYYYYMMDD", PK);         //신청기간 : 시작
    initEmEdit(EM_E_IN_DT, "TODAY", PK);             //신청기간 : 종료

   
    //콤보 초기화
    initComboStyle(LC_S_STR, DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);          		//점구분(조회)\


    getStore("DS_O_S_STR", "N", "", "N");
    DS_O_S_STR.Filter();     //점구분 : 지점만 셋팅

    getStore("DS_O_STR", "N", "", "N");
    DS_O_STR.Filter();     //점구분 : 지점만 셋팅
    

    getGiftTypeCd();    //상품권종류
    
    LC_S_STR.Index = 0;
    //setObject();
    LC_S_STR.Focus();
    

}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"           width=25   align=center</FC>'
    	             + '<FC>id=STR_CD      name="점"           EditStyle=Lookup   Data="DS_O_STR:CODE:NAME"   width=100 align=left</FC>'
                     + '<FC>id=IN_DT       name="입고일자"     width=80 mask="XXXX/XX/XX"  align=center</FC>'
                     + '<FC>id=IN_SLIP_NO  name="입고번호"       width=70  align=center</FC>'
                     + '<FC>id=GIFT_TYPE_CD  name="상품권종류"   width=70  align=left         EditStyle=Lookup    DATA="DS_O_GIFT_TYPE_CD:CODE:NAME"</FC>'
                     ;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    var hdrProperies1 = '<FC>id={currow}    name="NO"             width=30   align=center</FC>'
        + '<FC>id=GIFT_AMT_TYPE	 name="금종"        	         edit=none width=60 align=center show=false</FC>'
        + '<FC>id=GIFT_AMT_NAME	 name="금종명"      sumtext="합계" 	   edit=none width=70 align=left</FC>'
        + '<FC>id=GIFTCERT_AMT	 name="상품권금액" 			           edit=none width=70 align=right</FC>'
        + '<FC>id=IN_QTY		 name="수량"        sumtext=@sum       edit=none EditLimit=7 edit=numeric  width=50  align=right</FC>'
        + '<FC>id=GIFT_S_NO		 name="상품권시작번호"  		  edit=none width=120 align=center</FC>'
        + '<FC>id=GIFT_E_NO		 name="상품권종료번호"		      edit=none width=120 align=center</FC>'
        + '<FC>id=TOT_AMT		 name="입고금액"	sumtext=@sum edit=none width=100 align=right</FC>';
        
        initGridStyle(GD_DETAIL, "common", hdrProperies1, true);
        GD_DETAIL.ViewSummary = "1";
        

      var hdrProperies2 = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
          + '<FC>id=GIFT_AMT_TYPE	 name="금종"                 edit=none width=60 align=center </FC>'
          + '<FC>id=GIFT_AMT_NAME	 name="금종명"   	           edit=none width=100 align=left</FC>'
          + '<FC>id=GIFTCERT_AMT	 name="상품권금액" 			   edit=none width=100 align=right</FC>'
          + '<FC>id=GIFT_NO		     name="상품권번호"          	 edit=none width=150 align=center</FC>'
          + '<FC>id=STAT_FLAG		 name="상태"                	 edit=none width=100 align=center</FC>';
          
          initGridStyle(GD_DETAIL2, "common", hdrProperies2, true);
          //GD_DETAIL2.ViewSummary = "1";
          
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
 * 작 성 일 : 2011-04-08
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 DS_IO_MASTER.ClearData();
	 DS_IO_DETAIL.ClearData();
	 DS_IO_DETAIL2.ClearData();
	 
	 if(LC_S_STR.BindColVal == ""){
		 showMessage(INFORMATION, OK, "USER-1001", "점");
		 LC_S_STR.Focus();
		 return;
	 }
	 
	 if(DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
         if (showMessage(QUESTION , YESNO, "USER-1073") != 1) return;
     }
	 
	 if(EM_S_IN_DT.Text.length == 0){   // 조회시작일
        showMessage(INFORMATION, OK, "USER-1001","조회기간");
        EM_S_IN_DT.focus();
        return;
    }else if(EM_E_IN_DT.Text.length == 0){    // 조회 종료일
        showMessage(INFORMATION, OK, "USER-1001","조회기간");
        EM_E_IN_DT.focus();
        return;
    }else if(EM_S_IN_DT.Text > EM_E_IN_DT.Text){ // 조회일 정합성
        showMessage(INFORMATION, OK, "USER-1015");
        EM_S_IN_DT.focus();
        return;
    }
	 
	var strStrCd = LC_S_STR.BindColVal;
	var strSdt = EM_S_IN_DT.Text;
	var strEdt = EM_E_IN_DT.Text;

	var strParams = "&strStrCd="   + encodeURIComponent(strStrCd)
	              + "&strSdt="     + encodeURIComponent(strSdt)
	              + "&strEdt="     + encodeURIComponent(strEdt);
	
	TR_MAIN.Action="/mss/mgif117.mg?goTo=getMaster"+strParams;  
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O

    g_select = true;
    TR_MAIN.Post();
    g_select = false;

    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);  
    if (DS_IO_MASTER.CountRow > 0) { 
	    getDetail();
	    getDetail2();
    }
}

/**
 * btn_New()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-08
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-08
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	
}

/**
 * btn_Excel()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-08
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-08
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-08
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
    TR_MAIN.Action="/mss/mgif117.mg?goTo=getGiftTypeCd";  
    TR_MAIN.KeyValue="SERVLET(O:DS_O_GIFT_TYPE_CD=DS_O_GIFT_TYPE_CD)"; //조회는 O
    TR_MAIN.Post();
 }
 
 /**
  * setObject()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-04-08
  * 개    요 : 신청 신규 여부에 따른 오브젝트 설정 
  * return값 : void
  */
 function setObject() {
	var strFlag = false;
	if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "IN_SLIP_NO") == ""){
		strFlag = true;
	}
    
 }
 
 /**
  * getDetail()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-04-08
  * 개    요 : 상세내역 조회
  * return값 : void
  */
 function getDetail() {

     var strInDt       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "IN_DT");
     var strStrCd      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
     var strInSlipNo   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "IN_SLIP_NO");
      
     var strParams = "&strInDt="    + encodeURIComponent(strInDt)
                   + "&strStrCd="    + encodeURIComponent(strStrCd)
                   + "&strInSlipNo="+ encodeURIComponent(strInSlipNo);
     
     TR_DTL.Action="/mss/mgif117.mg?goTo=getDetail"+strParams;  
     TR_DTL.KeyValue="SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
     TR_DTL.Post();
     //setObject();
 }
 
 
 /**
  * getDetail2()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-04-08
  * 개    요 : 상품권마스터 내역조회
  * return값 : void
  */
 function getDetail2() {

     var strInDt       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "IN_DT");
     var strStrCd      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
     var strInSlipNo   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "IN_SLIP_NO");
      
     var strParams = "&strInDt="    + encodeURIComponent(strInDt)
                   + "&strStrCd="    + encodeURIComponent(strStrCd)
                   + "&strInSlipNo="+ encodeURIComponent(strInSlipNo);
     
     TR_DTL.Action="/mss/mgif117.mg?goTo=getDetail2"+strParams;  
     TR_DTL.KeyValue="SERVLET(O:DS_IO_DETAIL2=DS_IO_DETAIL2)"; //조회는 O
     TR_DTL.Post();
     //setObject();
 }
 
 /**
  * getNewDetail()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-04-08
  * 개    요 : 금종 조회
  * return값 : void
  */
 function getNewDetail(){
	  
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

<script language=JavaScript for=TR_DTL event=onSuccess>
    for(i=0;i<TR_DTL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DTL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_DTL event=onFail>
    trFailed(TR_DTL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_S_STR event=OnFilter(row)>
	if (DS_O_S_STR.NameValue(row, "CODE") == "00") {// 본사점
		return false;
	}
	return true;
</script>


<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
	 if((DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) && !btnSaveClick){
	         if(showMessage(INFORMATION, YESNO, "USER-1074") != 1 ){
	             return false;
	         }
	         if(DS_IO_MASTER.SysStatus(row) == "1"){
	             DS_IO_MASTER.DeleteRow(row);
	             return true;
	         }
	         return true;
	}
	return true;
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

	if(row <= 0 || g_select==true) return;
	
	if(this.NameValue(row, "IN_SLIP_NO") == "") return;
	getDetail();
	//조회결과 Return
	setPorcCount("SELECT", DS_IO_DETAIL.CountRow);
	
	getDetail2();
	//조회결과 Return
	setPorcCount("SELECT", DS_IO_DETAIL2.CountRow);

</script>

<script language=JavaScript for=DS_IO_DETAIL     event=OnColumnChanged(row,colid)>
 
</script>


<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
	if(row == 0) sortColId( eval(this.DataID), row , colid );
</script>


<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
	if(row == 0) sortColId( eval(this.DataID), row , colid );
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
<comment id="_NSID_">
<object id="DS_O_S_STR" classid=<%=Util.CLSID_DATASET%>>
	<param name=UseFilter value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_STR" classid=<%=Util.CLSID_DATASET%>>
	<param name=UseFilter value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_GIFT_TYPE_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL2" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="TR_DTL" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL2");
    
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
<div id="testdiv" class="testdiv">
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
						<th width="80" class="point">점</th>
						<td width="110" ><comment id="_NSID_"> <object
							id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=130 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">입고기간</th>
						<td colspan=3><comment id="_NSID_"> <object
							id=EM_S_IN_DT classid=<%=Util.CLSID_EMEDIT%>
							onblur="javascript:checkDateTypeYMD(this);" width=75 tabindex=1
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_IN_DT)" align="absmiddle" />
						~ <comment id="_NSID_"> <object id=EM_E_IN_DT
							classid=<%=Util.CLSID_EMEDIT%>
							onblur="javascript:checkDateTypeYMD(this);" width=75 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_E_IN_DT)" align="absmiddle" />
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
			<tr valign="top">
				
				<td class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				    <tr>
					    <td width="390">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
								<tr>
									<td><comment id="_NSID_"><OBJECT id=GD_MASTER
										width=100% height=350 classid=<%=Util.CLSID_GRID%>>
										<param name="DataID" value="DS_IO_MASTER">
									</OBJECT></comment><script>_ws_(_NSID_);</script></td>
								</tr>
							</table>
						</td>						
     					<td width=5></td>
						<td colspan=2>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
								<tr>
									<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
										width=100% height=350 classid=<%=Util.CLSID_GRID%>>
										<param name="DataID" value="DS_IO_DETAIL">
									</OBJECT></comment><script>_ws_(_NSID_);</script></td>
								</tr>
							</table>
						</td>						
				    </tr>
				</table>
				</td>
			</tr>
		</td>
	</tr>
	
	<tr>
		<td class="dot"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
				<tr>
					<td><comment id="_NSID_"><OBJECT id=GD_DETAIL2
						width=100% height=430 classid=<%=Util.CLSID_GRID%>>
						<param name="DataID" value="DS_IO_DETAIL2">
					</OBJECT></comment><script>_ws_(_NSID_);</script></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

</body>
</html>

