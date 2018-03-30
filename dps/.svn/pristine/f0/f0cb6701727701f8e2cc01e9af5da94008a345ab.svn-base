<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 코드관리 > 카드수수료율 등록
 * 작  성  일  : 2010.06.03
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : psal9071.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.06.03 (김영진) 신규작성
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
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-03
 * 개      요  : 해당 페이지 LOAD 시  
 * return값 : void
 */
var returnMap = dialogArguments[0];
var intRow = 0;
function doInit(){
	
	//Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();
    
    //EMedit에 초기화
    initEmEdit(EM_START_S_DT,    "YYYYMM",    PK);       //적용시작월
    initComboStyle(LC_S_STR, DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);
    getStore("DS_O_S_STR", "Y", "", "N");

    LC_S_STR.Index = 0; 
    LC_S_STR.Focus();
}


function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      name="NO"             width=30     align=center</FC>'
                     + '<FC>id=BCOMP_CD      name="매입사코드"      width=80     align=center   edit=none</FC>'
                     + '<FC>id=BCOMP_NM      name="매입사명"        width=100    align=left     edit=none</FC>'
                     + '<FC>id=JBRCH_ID      name="가맹점번호"      width=80     align=center   edit=none</FC>'
                     + '<FC>id=JBRCH_NM      name="가맹점구분명"    width=130    align=left     edit=none</FC>'
                     + '<FC>id=JOINT_YN      name="제휴사여부"      width=80     align=center   edit=none</FC>'
                     + '<FC>id=FEE_RATE      name="*수수료율"       width=100    align=right    edit=true</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, true);
}


/*************************************************************************
  * 2. 공통버튼
     (1) 저장       - btn_Save()
     (2) 닫기       - btn_Close()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-03
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if (DS_IO_MASTER.IsUpdated){
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
            setTimeout("GR_MASTER.Focus();",50);
            return false;
        }
    }
    
    if(trim(LC_S_STR.Text).length == 0){          //점포명
        showMessage(EXCLAMATION, OK, "USER-1002","점포명");
        LC_S_STR.Focus();
        return;
    }
    showMaster();
}

/**
 * btn_Close()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-03
 * 개      요  : POPUP닫기
 * return값 : void
 */
function btn_Close(){
    window.close();
}

/**
 * btn_Save()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-03
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

	if(trim(LC_S_STR.Text).length == 0){          // 가맹점ID
        showMessage(EXCLAMATION, OK, "USER-1003","가맹점");
        LC_S_STR.Focus();
        return;
    }
    if(trim(EM_START_S_DT.Text).length == 0){          // 적용시작월
        showMessage(EXCLAMATION, OK, "USER-1003","적용시작월");
        EM_START_S_DT.Focus();
        return;
    }
    if(trim(EM_START_S_DT.Text) <=  getTodayFormat('YYYYMM')){  // 적용시작월(미래일자)
        showMessage(EXCLAMATION, OK, "USER-1000","적용시작월은 미래월로 입력하세요.");
        EM_START_S_DT.Focus();
        return;
    }

    //DS Row 상태 초기화
    DS_IO_MASTER.ResetStatus();

    var intFeeRate = 0;
    for( row=1 ; row < DS_IO_MASTER.CountRow+1 ; row++ ){
    	DS_IO_MASTER.UserStatus(row) = 1;
    	intFeeRate = DS_IO_MASTER.NameValue(row,'FEE_RATE');
        if(intFeeRate <= 0){
            showMessage(EXCLAMATION, OK, "USER-1000", "카드수수료율을 입력하세요.");
            DS_IO_MASTER.RowPosition = row;
            GR_MASTER.SetColumn("FEE_RATE");  
            GR_MASTER.Focus();
            return false;
        }
    }
    
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    saveData();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-03
 * 개       요     : 카드수수료율등록 OPEN시 조회 
 * return값 : void
 */
function showMaster(){

	var strStrCd    = LC_S_STR.BindColVal;

	var goTo        = "openSearch";    
    var action      = "O";     
    var parameters  = "&strStrCd=" + encodeURIComponent(strStrCd);
    
    TR_MAIN.Action  ="/dps/psal907.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
}

/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-03
 * 개       요     : 카드수수료율등록
 * return값 : void
 */
function saveData(){
	var strStrCd    = LC_S_STR.BindColVal;
	var strStartDt  = EM_START_S_DT.Text+"01";

    var goTo        = "save";
    var action      = "I";  //조회는 O, 저장은 I
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd)
                    + "&strStartDt=" + encodeURIComponent(strStartDt)
                    + "&strPopChk=POPUP";
    TR_MAIN.Action  ="/dps/psal907.ps?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();
}
-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
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
        
        returnMap.put("STR_CD",     LC_S_STR.BindColVal);
        returnMap.put("START_S_DT", EM_START_S_DT.Text+"01");
        window.returnValue = true;
        window.close();
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
<!-- 카드수수료율 입력 가능 CanColumnPosChange(row,colid) -->
<script language="javascript" for=GR_MASTER
	event=CanColumnPosChange(row,colid)>
    var orgValue = DS_IO_MASTER.OrgNameValue(row,colid);
    var newValue = DS_IO_MASTER.NameValue(row,colid);
    var changeFlag = orgValue != newValue || (DS_IO_MASTER.RowStatus(row) == 3 ? newValue != '' : false);
    
    switch(colid){
        case 'FEE_RATE':
            if (DS_IO_MASTER.NameValue(row, 'FEE_RATE') > 100) {
                showMessage(EXCLAMATION, OK, "USER-1000", "수수료율은 100%이하  입력하세요.");
                return false;
            } else {
                return true;
            }
            break;
    }
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!--  적용일자 onKillFocus() -->
<script language=JavaScript for=EM_START_S_DT event=onKillFocus()>
    checkDateTypeYM(EM_START_S_DT);
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
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_O_S_STR" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
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
							align="absmiddle" class="popR05 PL03" /> 카드수수료율 등록</td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
							    <td><img src="/<%=dir%>/imgs/btn/search.gif" width="50"
                                    height="22" onClick="btn_Search();" /></td>
								<td><img src="/<%=dir%>/imgs/btn/save.gif"
									id="IMG_BTN_SAVE" width="50" height="22" onClick="btn_Save()" />
								</td>
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
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="80" class="point">점포명</th>
								<td width="220"><comment id="_NSID_"> <object
									id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> width=140
									align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th width="80" class="point">적용시작월</th>
								<td><comment id="_NSID_"> <object
									id=EM_START_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
									onclick="javascript:openCal('M',EM_START_S_DT)" /></td>
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
						<td><!-- 마스터 --> <comment id="_NSID_"> <object
							id=GR_MASTER width="100%" height=405 classid=<%=Util.CLSID_GRID%>
							onclick="getBrchPop(EM_BRCH_ID,EM_BRCH_NAME)">
							<param name="DataID" value="DS_IO_MASTER">
						</object> </comment> <script>_ws_(_NSID_);</script></td>
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
