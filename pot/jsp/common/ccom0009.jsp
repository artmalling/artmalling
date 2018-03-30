<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 > 브랜드코드 조회 팝업
 * 작  성  일  : 2010.07.13
 * 작  성  자  : 신명섭
 * 수  정  자  : 
 * 파  일  명  : ccom0009.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

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
<script language="javascript" src="/<%=dir%>/js/popup.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var returnParam     = dialogArguments[0];
 var brandCd         = dialogArguments[1];
 var brandNm         = dialogArguments[2];
/**
 * doInit()
 * 작 성 자 : 남형석
 * 작 성 일 : 2010-01-14
 * 개       요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
var returnMap = dialogArguments[0];

function doInit(){

    // Output Data Set Header 초기화
    DS_O_RESULT.setDataHeader('<gauce:dataset name="H_MASTER"/>');

    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_BRAND_CD,   "GEN^5",       NORMAL);      //브랜드코드
    initEmEdit(EM_BRAND_NM,   "GEN^40",      NORMAL);      //브랜드명
    
    
    // Input Data Set Header 초기화 
    DS_I_COND.setDataHeader  ('BRAND_CD:STRING(5),BRAND_NM:STRING(40)');
    DS_I_COND.ClearData();
    DS_I_COND.Addrow();

    EM_BRAND_CD.text = brandCd;
    EM_BRAND_NM.text = brandNm;
    
    DS_I_COND.NameValue(DS_I_COND.RowPosition, "BRAND_CD") = EM_BRAND_CD.text; 
    DS_I_COND.NameValue(DS_I_COND.RowPosition, "BRAND_NM") = EM_BRAND_NM.text;
    
    EM_BRAND_CD.Focus();
    if(brandCd.length > 0 || brandNm.length > 0   ){
        btn_Search();
    }
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"         width=30    align=center</FC>'
                     + '<FC>id=BRAND_CD        name="브랜드코드"  width=100   align=center</FC>'
                     + '<FC>id=BRAND_NM        name="브랜드명"    width=200   align=left</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
 *************************************************************************/
/**
 * btn_Search()
* 작 성 자 : 장형욱
* 작 성 일 : 2010-05-23
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
    // Input Data Set Header 초기화 
    DS_I_COND.setDataHeader  ('BRAND_CD:STRING(5),BRAND_NM:STRING(40)');
    DS_I_COND.ClearData();
    DS_I_COND.Addrow();
    
    DS_I_COND.NameValue(DS_I_COND.RowPosition, "BRAND_CD") = EM_BRAND_CD.text; 
    DS_I_COND.NameValue(DS_I_COND.RowPosition, "BRAND_NM") = EM_BRAND_NM.text;
	    
    showMaster();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
* showMaster()
* 작 성 자 : 장형욱
* 작 성 일 : 2010-05-23
* 개       요 :  
* return값 : void
*/
function showMaster(){

	
	DS_I_COND.UserStatus(1) = "1";     
	TR_MAIN.Action="/pot/ccom000.cc?goTo=searchBrandMaster";
	TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_COND,O:DS_O_RESULT=DS_O_RESULT)";
	TR_MAIN.Post(); 

}

/**
* btn_Close()
* 작 성 자 : 장형욱
* 작 성 일 : 2010-05-23
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
* 작 성 일 : 2010-05-23
* 개      요  : 데이터 선택시 닫기
* return값 : void
*/
function doDoubleClick(row) {
    if (row == undefined) 
        row = DS_O_RESULT.RowPosition;
        
    if (row > 0) {

        for(var i=1;i<=DS_O_RESULT.CountColumn;i++) {
            returnParam.put(DS_O_RESULT.ColumnID(i), DS_O_RESULT.NameValue(row, DS_O_RESULT.ColumnID(i)));
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
<script language=JavaScript for=GD_MASTER event=OnDblClick(row,colid)>
    // 그리드 double 클릭이벤트에서 처리 할 내역 추가        
    doDoubleClick(row);    
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_">
<object id=DS_I_COND classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
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
                            align="absmiddle" class="popR05 PL03" /> 브랜드 조회</td>
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
                                <th width="100">브랜드코드</th>
                                <td><comment id="_NSID_"> <object id=EM_BRAND_CD
                                    classid=<%=Util.CLSID_EMEDIT%>
                                    onkeyup="javascript:checkByteStr(EM_BRAND_CD, 5, '', '', '');"
                                    width=250 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
                            </tr>
                            <tr>
                                <th width="100">브랜드명</th>
                                <td><comment id="_NSID_"> <object id=EM_BRAND_NM
                                    classid=<%=Util.CLSID_EMEDIT%> onkeyup="javascript:checkByteStr(EM_BRAND_NM, 40, '', '', '');"
                                    width=250 tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
                                    
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
                            id=GD_MASTER width="100%" height=330 classid=<%=Util.CLSID_GRID%>
                            tabindex=1>
                            <param name="DataID" value="DS_O_RESULT">
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

