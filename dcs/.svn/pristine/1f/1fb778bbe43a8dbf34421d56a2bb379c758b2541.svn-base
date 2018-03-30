<!-- 
 * 시스템명 : 포인트카드 > 회원관리 > 이력조회 > 데이터변경이력조회
 * 작 성 일 : 2010.03.30
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : dctm4320.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.03.30 (장형욱) 신규작성
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
<%
    request.setCharacterEncoding("utf-8");
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
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
    type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    //DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터    
  
    //화면OPEN시 조회
    //btn_Search();
}
 
function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      name="NO"                 width=30    align=center edit=none</FC>'
    	             + '<FC>id=CHECK1        name=""                   width=20    aliRgn=left  EditStyle=CheckBox  HeadCheckShow="true" edit="true"</FC>'
    	            	 + '<FC>id=SS_NO_ORG     name="생년월일"            width=100    aliRgn=left  edit=none</FC>'
                         + '<FC>id=SS_NO         name="생년월일_암호화"     width=150     align=left  edit=none</FC>'
                         + '<FC>id=CARD_NO_ORG   name="카드번호"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=CARD_NO       name="카드번호_암호화"      width=150     align=right edit=none </FC>'
                         + '<FC>id=PWD_NO_ORG    name="비밀번호"            width=55    align=center   edit=none</FC>'
                         + '<FC>id=PWD_NO        name="비밀번호_암호화"      width=150    align=left   edit=none</FC>'
    	             if(RD_TAX_FLAG.CodeValue == "B"){
    	            	 hdrProperies += 
    	            	   '<FC>id=HOME_PH1_ORG     name="전화번호1"            width=100    aliRgn=left  edit=none</FC>'
                         + '<FC>id=HOME_PH1         name="전화번호1암호화"     width=150     align=left  edit=none</FC>'
                         + '<FC>id=HOME_PH2_ORG     name="전화번호2"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=HOME_PH2         name="전화번호2암호화"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=HOME_PH3_ORG     name="전화번호3"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=HOME_PH3         name="전화번호3암호화"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=MOBILE_PH1_ORG   name="휴대전화1"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=MOBILE_PH1       name="휴대전화1암호화"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=MOBILE_PH2_ORG   name="휴대전화2"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=MOBILE_PH2       name="휴대전화2암호화"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=MOBILE_PH3_ORG   name="휴대전화3"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=MOBILE_PH3       name="휴대전화3암호화"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=EMAIL1_ORG       name="이메일1"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=EMAIL1           name="이메일1암호화"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=EMAIL2_ORG       name="이메일2"            width=130   align=center  edit=none</FC>'
                         + '<FC>id=EMAIL2           name="이메일2암호화"            width=130   align=center  edit=none</FC>'
    	             }
                     ;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
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
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	var strFlag = RD_TAX_FLAG.CodeValue;
	
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strFlag=" + encodeURIComponent(strFlag);
    
    TR_MAIN.Action  = "/dcs/dctm433.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);  
        
    GD_MASTER.ColumnProp('CHECK1','HeadCheck') = false;
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {
	//변경또는 신규 내용을 저장하시겠습니까?
	if( showMessage(QUESTION , YESNO, "USER-1010") != 1 )
	    return;   
	var strFlag = RD_TAX_FLAG.CodeValue;
	
	var parameters  = "&strFlag=" + encodeURIComponent(strFlag);    

	TR_MAIN.Action="/dcs/dctm433.dm?goTo=save"+parameters;
	TR_MAIN.KeyValue="SERVLET(I:DS_O_MASTER=DS_O_MASTER)"; //조회는 O
	TR_MAIN.Post();

	// 정상 처리일 경우 조회
	if( TR_MAIN.ErrorCode == 0){		
	    btn_Search();        
	}  
    
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-30
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
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
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_O_MASTER.CountRow; i++)         
            DS_O_MASTER.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for (var i=1; i<=DS_O_MASTER.CountRow; i++) DS_O_MASTER.NameString(i, colid) = 'F';
    }
    this.ReDraw = "true";       
</script>

<script language=JavaScript for=RD_TAX_FLAG event=OnSelChange()>
DS_O_MASTER.ClearData();
gridCreate1();

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
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
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
<body onLoad="doInit();" class="PL10 PT15 ">
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
                        <td>
                           <comment id="_NSID_">
                           <object id=RD_TAX_FLAG classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:280">
                           <param name=Cols    value="2">
                           <param name=Format  value="A^연계카드,B^패밀리카드">
                           <param name=CodeValue  value="A">
                           </object>  
                           </comment><script> _ws_(_NSID_);</script> 
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
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><object id=GD_MASTER width="100%" height=504
                    classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_MASTER">
                </object></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
