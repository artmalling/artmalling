<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽 운영 > 기준정보  > 적립율등록  
 * 작  성  일  : 2010.03.04
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo1011.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.03.04 (김영진) 신규작성
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
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
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
 * 작 성 일 : 2010-02-28
 * 개      요  : 해당 페이지 LOAD 시  
 * return값 : void
 */
var returnMap = dialogArguments[0];
var intRow = 0;
function doInit(){
	
	// Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();
    
    // EMedit에 초기화
    initEmEdit(EM_APP_S_DT,     "YYYYMM",    PK);       //적용시작월
    initEmEdit(EM_BRCH_ID,      "GEN^10",    PK);       //가맹점ID
    initEmEdit(EM_BRCH_NAME,    "GEN^40",    READ);     //가맹점명
    
    showMaster();
    EM_BRCH_ID.Focus();
}


function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"                width=30    align=center</FC>'
                     + '<FC>id=BRCH_ID          name="가맹점ID"          width=86    align=center   show=false</FC>'
                     + '<FC>id=BRCH_NAME        name="가맹점명"          width=90    align=left     show=false</FC>'
                     + '<FC>id=PAY_TYPE_CD      name="결재수단CD"        width=90    align=center   show=false</FC>'
                     + '<FC>id=PAY_TYPE_NM      name="결재수단"          width=88    align=left     edit=none</FC>'
                     + '<FC>id=PAY_TYPE_DTL     name="결재수단CD"        width=90    align=left     show=false</FC>'
                     + '<FC>id=PAY_TYPE_DTL_NM  name="결재수단상세"      width=90    align=left     edit=none</FC>'
                     + '<FC>id=ADD_RATE         name="*적립율"           width=70    align=right</FC>'
                     + '<FC>id=DCUBE_DVD_RATE   name="*포인트분담율" width=108    align=right</FC>'
                     + '<FC>id=BRCH_DVD_RATE    name="가맹점분담율"      width=92     align=right   edit=none</FC>'
                     + '<FC>id=ADD_FEE_RATE     name="*적립수수료율"     width=92     align=right</FC>'
                     + '<FC>id=USE_FEE_RATE     name="*사용수수료율"     width=92     align=right</FC>'
                     + '<FC>id=APP_S_DT         name="적용시작월"      width=84     align=right show=false</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, true);
}


/*************************************************************************
  * 2. 공통버튼
     (1) 저장       - btn_Save()
     (2) 닫기       - btn_Close()
 *************************************************************************/
/**
 * btn_Close()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-11
 * 개      요  : POPUP닫기
 * return값 : void
 */
function btn_Close()
{
    window.close();
}

/**
 * btn_Save()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-10
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

	if(trim(EM_BRCH_ID.Text).length == 0){          // 가맹점ID
        showMessage(EXCLAMATION, OK, "USER-1003","가맹점");
        EM_BRCH_ID.Focus();
        return;
    }
	if(trim(EM_BRCH_ID.Text).length != 10 || trim(EM_BRCH_NAME.Text).length  == 0){
		showMessage(EXCLAMATION, OK, "USER-1000","존재하지 않는 가맹점코드 입니다.");
        EM_BRCH_ID.Focus();
        return;
	}
    if(trim(EM_APP_S_DT.Text).length == 0){          // 적용시작월
        showMessage(EXCLAMATION, OK, "USER-1003","적용시작월");
        EM_APP_S_DT.Focus();
        return;
    }
    if(trim(EM_APP_S_DT.Text) <=  getTodayFormat('YYYYMM')){  // 적용시작월(미래일자)
        showMessage(EXCLAMATION, OK, "USER-1000","적용시작월은 미래월로 입력하세요.");
        EM_APP_S_DT.Focus();
        return;
    }

    //DS Row 상태 초기화
    DS_IO_MASTER.ResetStatus();
    
    var intBRate = 0;
    var intDRate = 0;
    var intRateSum = 0;
    var intAddRate = 0;
    var intAddFeeRate = 0;
    var intUseFeeRate = 0;
    for( row=1 ; row < DS_IO_MASTER.CountRow+1 ; row++ ){
    	DS_IO_MASTER.UserStatus(row) = 1;
    	intBRate = DS_IO_MASTER.NameValue(row,'BRCH_DVD_RATE');
    	intDRate = DS_IO_MASTER.NameValue(row,'DCUBE_DVD_RATE');
    	intAddRate = DS_IO_MASTER.NameValue(row,'ADD_RATE');
    	intAddFeeRate = DS_IO_MASTER.NameValue(row,'ADD_FEE_RATE');
    	intUseFeeRate = DS_IO_MASTER.NameValue(row,'USE_FEE_RATE');
    	intRateSum = intBRate + intDRate;
        if(intDRate > 0 && intAddRate <= 0){
            showMessage(EXCLAMATION, OK, "USER-1000", "적립율을 입력하세요.");
            DS_IO_MASTER.RowPosition = row;
            GR_MASTER.SetColumn("ADD_RATE");  
            GR_MASTER.Focus();
            return false;
        }
    	if(intAddFeeRate > 0 && intAddRate <= 0){
    		showMessage(EXCLAMATION, OK, "USER-1000", "적립율을 입력하세요.");
            DS_IO_MASTER.RowPosition = row;
            GR_MASTER.SetColumn("ADD_RATE");  
            GR_MASTER.Focus();
            return false;
    	}
        if(intUseFeeRate > 0 && intAddRate <= 0){
            showMessage(EXCLAMATION, OK, "USER-1000", "적립율을 입력하세요.");
            DS_IO_MASTER.RowPosition = row;
            GR_MASTER.SetColumn("ADD_RATE");  
            GR_MASTER.Focus();
            return false;
        }
        if (intAddRate > 2) {
            showMessage(EXCLAMATION, OK, "USER-1000", "적립율은 2%이하로 입력하세요.");
            DS_IO_MASTER.RowPosition = row;
            GR_MASTER.SetColumn("ADD_RATE");  
            GR_MASTER.Focus();
            return false;
        }
    	if( intAddRate > 0 && intRateSum != 100 ){
            showMessage(EXCLAMATION, OK, "USER-1000","비용분담율의 합이 100%가 아닙니다.");
            DS_IO_MASTER.RowPosition = row;
            GR_MASTER.SetColumn("DCUBE_DVD_RATE");  
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
 * 작 성 일     : 2010-03-10
 * 개       요     : 적립율등록 OPEN시 조회 
 * return값 : void
 */
function showMaster(){

    var goTo        = "openSearch";    
    var action      = "O";     
    TR_MAIN.Action  ="/dcs/dmbo101.do?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
}

/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-11
 * 개       요     : 적립율등록
 * return값 : void
 */
function saveData(){
    var strBrchId   = EM_BRCH_ID.Text;
	var strAppSDt   = EM_APP_S_DT.Text+"01";

    var goTo        = "save";
    var action      = "I";  //조회는 O, 저장은 I
    var parameters  = "&strBrchId="+ encodeURIComponent(strBrchId)
                    + "&strAppSDt="+ encodeURIComponent(strAppSDt)
                    + "&strPopChk=POPUP";
    TR_MAIN.Action  ="/dcs/dmbo101.do?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-10
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NAME.Text = "";//조건입력시 코드초기화
    if (EM_BRCH_ID.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_BRCH_ID.Text.length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_BRCH_ID.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_BRCH_ID,EM_BRCH_NAME);
            }
        }
    }
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
        
        returnMap.put("BRCH_ID",  EM_BRCH_ID.Text);
        returnMap.put("APP_S_DT", EM_APP_S_DT.Text+"01");
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
<script language=JavaScript for=DS_IO_MASTER
	event=onColumnChanged(row,colid)>
    var orgValue      = DS_IO_MASTER.OrgNameValue(row,colid);
    var newValue      = DS_IO_MASTER.NameValue(row,colid);
    var intAddRate    = DS_IO_MASTER.NameValue(row,'ADD_RATE');
    var intAddReeRate = DS_IO_MASTER.NameValue(row,'ADD_FEE_RATE');
    var intUseFeeRate = DS_IO_MASTER.NameValue(row,'USE_FEE_RATE');
    
    var changeFlag = intAddRate > 0 && orgValue != newValue || (DS_IO_MASTER.RowStatus(row) == 3 ? newValue != '' : false);
    var intDvdRate = 100 - newValue;
    switch(colid){
        case 'DCUBE_DVD_RATE':
            if(changeFlag && intAddRate > 0){
            	DS_IO_MASTER.NameValue(row,'BRCH_DVD_RATE') = intDvdRate;
            }
            break;  
        case 'ADD_RATE':
            if(newValue == 0){
                DS_IO_MASTER.NameValue(row,'DCUBE_DVD_RATE') = 0;
                DS_IO_MASTER.NameValue(row,'BRCH_DVD_RATE')  = 0;
                DS_IO_MASTER.NameValue(row,'ADD_FEE_RATE')   = 0;
                DS_IO_MASTER.NameValue(row,'USE_FEE_RATE')   = 0;
            }
            if( DS_IO_MASTER.NameValue(row,'DCUBE_DVD_RATE') != 0){
                DS_IO_MASTER.NameValue(row,'BRCH_DVD_RATE') = 100 - DS_IO_MASTER.NameValue(row,'DCUBE_DVD_RATE');
            }
            break; 
        case 'ADD_FEE_RATE':
            if(changeFlag && intAddRate > 0){
                DS_IO_MASTER.NameValue(row,'ADD_FEE_RATE') = intAddReeRate;
            }else{
                //DS_IO_MASTER.NameValue(row,'ADD_FEE_RATE')   = 0;
            }
            break; 
        case 'USE_FEE_RATE':
            if(changeFlag && intAddRate > 0){
                DS_IO_MASTER.NameValue(row,'USE_FEE_RATE') = intUseFeeRate;
            }else{
                //DS_IO_MASTER.NameValue(row,'USE_FEE_RATE')   = 0;
            }
            break; 
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 적립율 2% 미만 입력 가능 CanColumnPosChange(row,colid) -->
<script language="javascript" for=GR_MASTER
	event=CanColumnPosChange(row,colid)>
    var orgValue = DS_IO_MASTER.OrgNameValue(row,colid);
    var newValue = DS_IO_MASTER.NameValue(row,colid);
    var changeFlag = orgValue != newValue || (DS_IO_MASTER.RowStatus(row) == 3 ? newValue != '' : false);
    
    switch(colid){
        case 'ADD_RATE':
            if (DS_IO_MASTER.NameValue(row, 'ADD_RATE') > 2) {
                showMessage(EXCLAMATION, OK, "USER-1000", "적립율은 2%이하로 입력하세요.");
                return false;
            } else {
                return true;
            }
            break;
        case 'DCUBE_DVD_RATE':
            if (DS_IO_MASTER.NameValue(row, 'DCUBE_DVD_RATE') > 100) {
                showMessage(EXCLAMATION, OK, "USER-1000", "포인트분담율은 100%이하 입력하세요.");
                return false;
            } else {
                return true;
            }
            break;
        case 'BRCH_DVD_RATE':
            if (DS_IO_MASTER.NameValue(row, 'BRCH_DVD_RATE') > 100) {
                showMessage(EXCLAMATION, OK, "USER-1000", "가맹점분담율은 100%이하  입력하세요.");
                return false;
            } else {
                return true;
            }
            break;
    }
</script>
<script language=Javascript>
    //이전 Focus에 대한 정보를 저장한다.
    var old_Row = 0;
</script>
<!-- 적립율 2% 이상입력시 old_Row 포커스 이동용 OnColumnPosChanged(row,colid) -->
<script language="javascript" for=GR_MASTER event=OnColumnPosChanged(row,colid)>
    old_Row = row;
</script>

<!-- 가맹점명 onKillFocus() -->
<script language=JavaScript for=EM_BRCH_ID event=onKillFocus()>
    if ((EM_BRCH_ID.Modified) && (EM_BRCH_ID.Text.length != 10)) {
        EM_BRCH_NAME.Text = "";
    }
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!--  적용일자 onKillFocus() -->
<script language=JavaScript for=EM_APP_S_DT event=onKillFocus()>
    checkDateTypeYM(EM_APP_S_DT);
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
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
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
							align="absmiddle" class="popR05 PL03" /> 적립율 등록</td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
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
								<th width="80" class="point">가맹점</th>
								<td width="260"><comment id="_NSID_"> <object
									id=EM_BRCH_ID classid=<%=Util.CLSID_EMEDIT%> width=73
									tabindex=1 onKeyUp="javascript:keyPressEvent(event.keyCode);">
								</object> </comment> <script> _ws_(_NSID_);</script> <img
									src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
									onclick="getBrchPop(EM_BRCH_ID,EM_BRCH_NAME)" /> <comment
									id="_NSID_"> <object id=EM_BRCH_NAME
									classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1> </object> </comment>
								<script> _ws_(_NSID_);</script></td>
								<th width="80" class="point">적용시작월</th>
								<td><comment id="_NSID_"> <object id=EM_APP_S_DT
									classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
									align="absmiddle">
								</object> </comment> <script> _ws_(_NSID_);</script> <img
									src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
									onclick="javascript:openCal('M',EM_APP_S_DT)" /></td>
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
