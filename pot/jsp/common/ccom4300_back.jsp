<!-- 
/*******************************************************************************
 * 시스템명 : 우편번호 조회 팝업
 * 작  성  일  : 2010.05.11
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : ccom4300.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 우편번호 팝업 관리(신주소/구주소)
 * 이         력  :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
 <%
 	request.setCharacterEncoding("utf-8");
 %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var strSrchGubun   = "N";
var returnMap      = dialogArguments[0];
var searchCode     = dialogArguments[1];
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 /**
  * doInit()
  * 작 성 자 : 김영진
  * 작 성 일 : 2010-05-11
  * 개    요 : 해당 페이지 LOAD 시  
  * return값 : void
  */
 function doInit() 
 {	
	  
	  alert("11");
 	// Input Data Set Header 초기화 
     DS_I_POPUP.setDataHeader  ('<gauce:dataset name="H_POPUP"/>');
     
     // Output Data Set Header 초기화 
     DS_O_POPUP.setDataHeader  ('<gauce:dataset name="H_SEL_POPUP"/>');
           
     //그리드 초기화
     gridCreate1();

     //EMedit에 초기화
     initEmEdit(EM_ADDR_OLD,     "GEN^100", PK);
     initEmEdit(EM_ROADNM_NEW,   "GEN^60", PK);
     initEmEdit(BLDG1,   "00000", PK);
     initEmEdit(BLDG2,   "00000", PK);
     initEmEdit(JIBUN1,   "00000", PK);
     initEmEdit(JIBUN2,   "00000", PK);
     
     initComboStyle2(LC_SIDO_NEW,    DS_O_SIDO_NEW,    "NAME^0^130", 1, PK);  
     initComboStyle2(LC_SIGUNGU_NEW, DS_O_SIGUNGU_NEW, "NAME^0^130", 1, PK);  
     initComboStyle2(LC_SIDO_OLD,    DS_O_SIDO_NEW,    "NAME^0^130", 1, PK);  
     initComboStyle2(LC_SIGUNGU_OLD, DS_O_SIGUNGU_NEW, "NAME^0^130", 1, PK);
     
     getSidoNew("DS_O_SIDO_NEW", "", "", "Y");
     GD_SEARCH.height = "292";

     EM_ADDR_OLD.Focus();
 } 
 
 function gridCreate1(){
	var hdrProperies = '<FC>id={currow}   name="NO"          	width=30   show=false align=center</FC>'
					 + '<FC>ID=FULL_ADDR2 name="지번주소"          width=305, align="left"  </C>'
		             + '<FC>ID=FULL_ADDR  name="도로명주소"        width=455, align="left"  </C>'
		             + '<FC>ID=POST_NO    name="우편번호"    width=60,  align="center" </C>'
		             + '<FC>ID=ADDR1      name="주소1"       width=0,   show=false     align="left"</C>'
		             + '<FC>ID=ADDR2      name="주소2"       width=0,   show=false     align="center"</C>'
		             + '<FC>ID=POST_NO1   name="우편번호앞"  width=0,   show=false     align="center"</C>'
		             + '<FC>ID=POST_NO2   name="우편번호뒤"  width=0,   show=false     align="center"</C>'
		             + '<FC>ID=GUBUN      name="신/구 구분"   width=0,   show=false     align="center"</C>';
                                 
    initGridStyle(GD_SEARCH, "common", hdrProperies, false);

} 

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 닫기       - btn_Close()
 *************************************************************************/
	     
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-11
 * 개    요  : 조회 처리
 * return값 : void
 */
function btn_Search() 
{	
	var strGoto = "getOldAddr"; 
    strSrchGubun = RD_NEW_YN.CodeValue;
    
    
    var len_text = EM_ADDR_OLD.text;
    
    DS_I_POPUP.ClearData();
    DS_I_POPUP.Addrow();
	
    if(strSrchGubun == "N"){
        if(trim(EM_ADDR_OLD.text) == ""){
            showMessage(EXCLAMATION, OK, "USER-1003",  "읍/면/동");
            EM_ADDR_OLD.Focus();
            return;
        }
        
        if(len_text.length <= 1){
            showMessage(EXCLAMATION, OK, "USER-1000",  "최소 2자이상 입력하세요.");
            EM_ADDR_OLD.Focus();
            return;
        }
        
        /*
        if(trim(LC_SIDO_OLD.text) == ""){
            showMessage(EXCLAMATION, OK, "USER-1002",  "시/도");
            LC_SIDO_OLD.Focus();
            return;
        }
    	if(trim(LC_SIGUNGU_OLD.text) == ""){
            showMessage(EXCLAMATION, OK, "USER-1002",  "시/군/구");
            LC_SIGUNGU_OLD.Focus();
            return;
        }
    	*/
        strGoto = "getOldAddr"; 
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "SI_DO"     ) = LC_SIDO_OLD.text;     //시도
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "SI_GUN_GU" ) = LC_SIGUNGU_OLD.text;  //시군구
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "ADDR1"     ) = EM_ADDR_OLD.text;     // 읍/면/동
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "BLDG1"     ) = trim(JIBUN1.text);   //
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "BLDG2"     ) = trim(JIBUN2.text);   //
    }
    
    /*
    
    else{
        if(trim(EM_ROADNM_NEW.text) == ""){
            showMessage(EXCLAMATION, OK, "USER-1003",  "도로명");
            EM_ROADNM_NEW.Focus();
            return;
        }
    	if(trim(LC_SIDO_NEW.text) == ""){
            showMessage(EXCLAMATION, OK, "USER-1002",  "시/도");
            LC_SIDO_NEW.Focus();
            return;
        }
    	if(trim(LC_SIGUNGU_NEW.text) == ""){
            showMessage(EXCLAMATION, OK, "USER-1002",  "시/군/구");
            LC_SIGUNGU_NEW.Focus();
            return;
        }
        strGoto = "getNewAddr"; 
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "SI_DO"     ) = LC_SIDO_NEW.text;     //시도
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "SI_GUN_GU" ) = LC_SIGUNGU_NEW.text;  //시군구
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "ROAD_NM"   ) = EM_ROADNM_NEW.text;   //도로명
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "BLDG1"     ) = trim(BLDG1.text);   //bldg1
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "BLDG2"     ) = trim(BLDG2.text);   //bldg2
   }
    */
    TR_MAIN.Action="/<%=dir%>/ccom430.cc?goTo="+strGoto;
    TR_MAIN.KeyValue="SERVLET(I:DS_I_POPUP=DS_I_POPUP,O:DS_O_POPUP=DS_O_POPUP)";
    TR_MAIN.Post();  
    
    //endTR("R", TR_MAIN, DS_O_POPUP);
}

/**
 * btn_Close()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-11
 * 개    요 : Close
 * return값 : void
 */  
function btn_Close()
{
    window.close();
}
     
/*************************************************************************
 * 3. 함수
*************************************************************************/
/**
 * doDoubleClick()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-11
 * 개    요 : 더블클릭 처리
 * return값 : void
 */  
function doDoubleClick(row)
{
	if( row == undefined ) 
		row = DS_O_POPUP.RowPosition;

	if (row > 0) 
	{
        var strColumnId = "";
        
        for(var i=1;i<=DS_O_POPUP.CountColumn;i++)
        {
            returnMap.put(DS_O_POPUP.ColumnID(i), DS_O_POPUP.NameValue(row, DS_O_POPUP.ColumnID(i)),RD_NEW_YN.CodeValue);
        }

        window.returnValue = true;
        window.close();
    }
    return false;         
}

/**
* initComboStyle2
* 작  성 자 : 김영진
* 작  성 일 : 2010-04-13
* 개        요 : LuxeCombo의 Style 및 기본적 PARAMETER SETTING
* 사 용 법  : initComboStyle(LC_DEAL_GUBN_S, ds_deal_gubn, "ETC_CODE^0^20,ETC_NAME^0^100", 1, PK/READ/NORMAL);
*          initComboStyle(LuxeCombo ID, Dataset Name, ExprForamt, SearchColumn Index, PK)
*/
function initComboStyle2(objCombo, strDataSet, strExprFormat, intSearchColumn,  strType, strDsBindFlag){
    objCombo.ComboDataID      = strDataSet.id;
    objCombo.ListExprFormat   = strExprFormat;
    objCombo.FontSize         = "9";
    objCombo.FontName         = "돋움";
    objCombo.ListCount        = 10;
    //objCombo.SearchColumn   = strExprFormat.split(",")[intSearchColumn].split("^")[0];
    objCombo.BindColumn       = strExprFormat.split(",")[0].split("^")[0];
    objCombo.InheritColor   = true;
    if (strDsBindFlag != true){
        objCombo.SyncComboData    = false;
    }
    objCombo.WantSelChgEvent  = true;
    switch(THEME){
      case SPRING :
        break;
      case SUMMER :
        break;
      case FALL   :
        break;
      case WINTER :
        setObjTypeStyle( objCombo, "COMBO", strType );
        break;
      default :
      break;
    }
}

/**
 * getSidoNew()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-12
 * 개      요  : 시도조회
 * return값 :
 */
function getSidoNew(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) { 
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1),SIDO_NEW:STRING(50)');

    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    DS_I_COMMON.NameValue(1, "SIDO_NEW")  = "ALL";
        
    TR_MAIN.Action  = "/<%=dir%>/ccom430.cc?goTo=getEtcCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
}

/**
 * getSiGunGuNew()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-12
 * 개      요  : 시군구조회
 * return값 :
 */
function getSiGunGuNew(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) { 
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1),SIDO_NEW:STRING(50)');

    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    
    
    if(RD_NEW_YN.CodeValue == "N"){
    	DS_I_COMMON.NameValue(1, "SIDO_NEW")  = LC_SIDO_OLD.Text;
    } else {
    	DS_I_COMMON.NameValue(1, "SIDO_NEW")  = LC_SIDO_NEW.Text;
    }
    
    
    
    TR_MAIN.Action  = "/<%=dir%>/ccom430.cc?goTo=getEtcCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
}
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
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

<script language=JavaScript for=GD_SEARCH event=OnDblClick(row,colid)>
    //그리드 double 클릭이벤트에서 처리 할 내역 추가 		
	doDoubleClick(row);
</script>


<!-- 조회구분 OnSelChange() -->
<script language=JavaScript for=RD_NEW_YN event=OnSelChange()>
    if(RD_NEW_YN.CodeValue == "N"){
    	document.getElementById("divOld").style.display = "";
        document.getElementById("divNew").style.display = "none";
        //DS_O_POPUP.ClearData();

        LC_SIDO_NEW.Text    = "";
        LC_SIGUNGU_NEW.Text = "";
        EM_ROADNM_NEW.Text  = "";
        BLDG1.Text 			= "";
        BLDG2.Text 			= "";
        getSidoNew("DS_O_SIDO_NEW", "", "", "Y");
        GD_SEARCH.height = "292";
    }else{
        document.getElementById("divOld").style.display = "none";
        document.getElementById("divNew").style.display = "";
        //DS_O_POPUP.ClearData();
        EM_ADDR_OLD.Text = "";
        GD_SEARCH.height = "292";
        getSidoNew("DS_O_SIDO_NEW", "", "", "Y");
        LC_SIGUNGU_NEW.Enable = false;
    }
</script>

<!-- 시도 OnSelChange() -->
<script language=JavaScript for=LC_SIDO_NEW event=OnSelChange()>
    getSiGunGuNew("DS_O_SIGUNGU_NEW", "", "", "Y");  
    LC_SIGUNGU_NEW.Enable = true;
</script>
<script language=JavaScript for=LC_SIDO_OLD event=OnSelChange()>
    getSiGunGuNew("DS_O_SIGUNGU_NEW", "", "", "Y");  
    LC_SIGUNGU_NEW.Enable = true;
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<comment id="_NSID_">
<object id=DS_I_POPUP classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id=DS_O_POPUP classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_O_SIDO_NEW classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_O_SIGUNGU_NEW classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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
<body onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="pop01"></td>
		<td class="pop02"></td>
		<td class="pop03"></td>
	</tr>
	<tr>
		<td class="pop04"></td>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="396" class="title"><img
							src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
							align="absmiddle" class="PR05 PL03" />우편번호(주소)조회</td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=dir%>/imgs/btn/search.gif" width="50"
									height="22" onClick="btn_Search();" /></td>
								<td><img src="/<%=dir%>/imgs/btn/confirm.gif" width="50"
									height="22" onClick="doDoubleClick()" /></td>
								<td><img src="/<%=dir%>/imgs/btn/close.gif" width="50"
									height="22" onClick="btn_Close();" /></td>

							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="PB03">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="o_table">
					<tr>
						<td>
							<table width="100%" border="0" cellpadding="0" cellspacing="0"
								class="s_table">
								<tr>
									<th width="90">주소타입</th>
									<td><comment id="_NSID_"> <object id=RD_NEW_YN
										classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 200"
										tabindex=1>
										<param name=Cols value="2">
										<param name=Format value="N^통합검색">
										<param name="AutoMargin" value="true">
										<param name=CodeValue value="N">
									</object> </comment> <script> _ws_(_NSID_);</script></td>
								</tr>
							</table>
						</td>
					</tr>
					</table>
					</td>
					</tr>
					<tr>
						<td class="PT01 PB03">
						<div id="divOld">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="o_table">
							<tr>
								<td>

								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<th width="90" class="point">읍/면/동/도로명</th>
										<td><comment id="_NSID_"> <object
											id=EM_ADDR_OLD classid=<%=Util.CLSID_EMEDIT%> height=20 tabindex=1
											width=127 onKeyDown="if(event.keyCode == 13) btn_Search();" onkeyup="javascript:checkByteStr(EM_ADDR_OLD, 100, '');">
										</object> </comment><script>_ws_(_NSID_);</script></td>
										<th width="90">건물번호/지번</th>
                                        <td>
                                        	<comment id="_NSID_">
                                        		<object id=JIBUN1 classid=<%=Util.CLSID_EMEDIT%> height=20 width=40 tabindex=1 
                                        		onKeyDown="if(event.keyCode == 13) btn_Search();" onkeyup="javascript:checkByteStr(JIBUN1, 5, '');">
                                        		</object> 
                                        	</comment><script>_ws_(_NSID_);</script>-
                                        	<comment id="_NSID_">
                                        		<object id=JIBUN2 classid=<%=Util.CLSID_EMEDIT%> height=20 width=40 tabindex=1 
                                        		onKeyDown="if(event.keyCode == 13) btn_Search();" onkeyup="javascript:checkByteStr(JIBUN2, 5, '');">
                                        		</object> 
                                        	</comment><script>_ws_(_NSID_);</script>
                                        </td>
									</tr>
									<tr>
										<th width="90" class="point">시/도</th>
										<td width="138"><comment id="_NSID_"><object id=LC_SIDO_OLD
									classid=<%=Util.CLSID_LUXECOMBO%> width=131 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									<th width="90" class="point">시/군/구</th>
                                        <td><comment id="_NSID_"><object id=LC_SIGUNGU_OLD
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=131 tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</div>
						<div id="divNew" style="display: none">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="o_table">
							<tr>
								<td>

								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
                                        <th width="90" class="point">도로명</th>
                                        <td width="138"><comment id="_NSID_"> <object
                                            id=EM_ROADNM_NEW classid=<%=Util.CLSID_EMEDIT%> height=20
                                            width=127 tabindex=1 onkeyup="javascript:checkByteStr(EM_ROADNM_NEW, 60, '');">
                                        </object> </comment><script>_ws_(_NSID_);</script></td>
                                        <th width="90">건물번호</th>
                                        <td>
                                        	<comment id="_NSID_">
                                        		<object id=BLDG1 classid=<%=Util.CLSID_EMEDIT%> height=20 width=40 tabindex=1 
                                        		onkeyup="javascript:checkByteStr(BLDG1, 5, '');">
                                        		</object> 
                                        	</comment><script>_ws_(_NSID_);</script>-
                                        	<comment id="_NSID_">
                                        		<object id=BLDG2 classid=<%=Util.CLSID_EMEDIT%> height=20 width=40 tabindex=1 
                                        		onkeyup="javascript:checkByteStr(BLDG2, 5, '');">
                                        		</object> 
                                        	</comment><script>_ws_(_NSID_);</script>
                                        </td>
                                    </tr>
                                    
									<tr>
										<th width="90" class="point">시/도</th>
										<td width="138"><comment id="_NSID_"><object id=LC_SIDO_NEW
									classid=<%=Util.CLSID_LUXECOMBO%> width=131 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									<th width="90" class="point">시/군/구</th>
                                        <td><comment id="_NSID_"><object id=LC_SIGUNGU_NEW
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=131 tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</div>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="g_table">
							<tr>
								<td><!-- 마스터 --> <comment id="_NSID_"><object
									id=GD_SEARCH height=318 width="100%"
									classid=<%=Util.CLSID_GRID%> tabindex=1>  
									<param name="DataID" value="DS_O_POPUP">
								</object></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
					</table>
				</td>
				<td class="pop06"></td>
			</tr>
			<tr>
				<td class="pop07"></td>
				<td class="pop08"></td>
				<td class="pop09"></td>
			</tr>
		</table>
</body>
</html>

