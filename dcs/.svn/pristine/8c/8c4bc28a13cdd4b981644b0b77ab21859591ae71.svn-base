<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드  > 포인트정산 > 기부관리 >기부등록 찾기 팝업
 * 작 성 일 : 2010.02.17
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : DMTC7011.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.02.17 (장형욱) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	request.setCharacterEncoding("utf-8");
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-02-17
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

var returnMap       = dialogArguments[0];

function doInit(){
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');

    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_DON_TARGET,    "GEN^40",   NORMAL);    //기부처명
    initEmEdit(EM_DON_NAME,      "GEN^40",   NORMAL);    //기부명
    
    EM_DON_NAME.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"          width=30      align=center</FC>'
    	             + '<FC>id=DON_ID           name="기부ID"       width=80      align=center  </FC>'
                     + '<FC>id=DON_NAME         name="기부명"       width=130     align=left</FC>'
                     + '<FC>id=DON_TARGET       name="기부처명"      width=130     align=left</FC>'
                     + '<FC>id=S_DT             name="시작일자"      width=78      align=center  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=E_DT             name="종료일자"      width=78      align=center  mask="XXXX/XX/XX"</FC>'
                    
                      
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-02-17
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    showMaster();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
* showMaster()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-02-17
* 개    요 : 기부등록 조회
* return값 : void
*/
function showMaster(){

    var strDonTarget = EM_DON_TARGET.text;
    var strDonNm     = EM_DON_NAME.text;

    var goTo       = "searchPopMaster" ;    
    var action     = "O";     
    var parameters = "&strDonTarget=" + encodeURIComponent(strDonTarget)
                   + "&strDonNm="     + encodeURIComponent(strDonNm);
    TR_MAIN.Action="/dcs/dmtc701.dc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 )
        GD_MASTER.Focus();
    else 
    	EM_DON_NAME.Focus();    

}

/**
* btn_Close()
* 작 성 자 : 장형욱
* 작 성 일 : 2010-02-28
* 개      요  : 닫기
* return값 : void
*/
function btn_Close()
{
    window.returnValue = false; 
    window.close();
}

/**
* doDoubleClick()
* 작 성 자 : 장형욱
* 작 성 일 : 2010-02-28
* 개      요  : 데이터 선택시 닫기
* return값 : void
*/
function doDoubleClick(row)
{
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;

    if (row > 0) 
    {
        var strColumnId = "";
        
        for(var i=1;i<=DS_O_MASTER.CountColumn;i++)
        {
            //alert(DS_O_MASTER.ColumnID(i));
            returnMap.put(DS_O_MASTER.ColumnID(i), DS_O_MASTER.NameValue(row, DS_O_MASTER.ColumnID(i)));
        }
        
        window.returnValue = true;
        window.close();
    }
    return false;         
}

-->
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
    if(DS_O_MASTER.CountRow > 0){
    	GD_MASTER.Focus();  
    }else{
    	EM_DON_TARGET.Focus();
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_MASTER event=OnDblClick(row,colid)>
    doDoubleClick(row);    
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

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
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

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
							align="absmiddle" class="popR05 PL03" /> 기부명 조회</td>
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
				<td class="popT01 PB03">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="o_table">
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="100">기부명</th>
								<td><comment id="_NSID_"> <object id=EM_DON_NAME
									classid=<%=Util.CLSID_EMEDIT%> width=400 tabindex=1
									align="absmiddle"
									onkeyup="javascript:checkByteStr(EM_DON_NAME, 40, '');"></object>
								</comment><script> _ws_(_NSID_);</script></td>
							<tr>
								<th width="100">기부처명</th>
								<td><comment id="_NSID_"> <object
									id=EM_DON_TARGET classid=<%=Util.CLSID_EMEDIT%> width=400
									tabindex=1 align="absmiddle"
									onkeyup="javascript:checkByteStr(EM_DON_TARGET, 40, '');"></object>
								</comment><script> _ws_(_NSID_);</script></td>
							</tr>
							</tr>
							
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="g_table">
					<tr>
						<td><!-- 마스터 --> <comment id="_NSID_"> <OBJECT
							id=GD_MASTER width="100%" height=283 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_O_MASTER">
						</OBJECT> </comment><script>_ws_(_NSID_);</script></td>
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

