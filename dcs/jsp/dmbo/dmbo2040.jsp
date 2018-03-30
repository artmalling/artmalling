<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 제휴카드  > 기준정보  > 비용분담율관리
 * 작  성  일  : 2010.05.19
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo2040.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.19 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*********************************************************
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");

	String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
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
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
var tomorrow = replaceStr(addDate("D", "+1", "<%=toDate%>"),'-','');
var strBrchId   = "";
var strAppSDt   = "";
var strPayType  = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**`
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-19
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();
    
    // EMedit에 초기화
    initEmEdit(EM_BRCH_ID,      "GEN^10",    NORMAL);   //가맹점ID
    initEmEdit(EM_BRCH_NAME,    "GEN^40",    READ);     //가맹점명
    
    initComboStyle (LC_PAY_TYPE, DS_PAY_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL);    //제휴신용카드사
    initComboStyle2(LC_APP_S_DT, DS_APP_DT, "NAME^0^100", 1, PK);                   //기준일자    

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getDcEtcCode("DS_PAY_TYPE", "", "PAY_TYPE", "Y");
    getDcEtcCode("DS_APP_DT", "", "APP_DT", "N");  
    
    //초기값설정
    setComboData(LC_PAY_TYPE,  "%");
    EM_BRCH_ID.Focus();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dmbo204","DS_IO_MASTER");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"                width=30    align=center edit=none</FC>'
                     + '<FC>id=BRCH_ID          name="가맹점ID"          width=86    align=center   show=false </FC>'
                     + '<FC>id=BRCH_NAME        name="가맹점명"          width=120   align=left     edit=none</FC>'
                     + '<FC>id=PAY_TYPE_DTL     name="카드사코드"        width=90    align=center   show=false</FC>'
                     + '<FC>id=PAY_TYPE_DTL_NM  name="카드사명"          width=120   align=left     edit=none</FC>'
                     + '<FC>id=ADD_RATE         name="적립율"            width=100   align=right    edit=none</FC>'
                     + '<FC>id=JCOMP_RATE       name="*카드사적립율"     width=100    align=right</FC>'
                     + '<FC>id=DCUBE_RATE       name="포인트분담율"  width=110    align=right    edit=none</FC>'
                     + '<FC>id=ADD_FEE_RATE     name="적립수수료율"      width=100    align=right</FC>'
                     + '<FC>id=APP_S_DT         name="적용시작일자"      width=96     align=center  mask="XXXX/XX/XX" edit=none</FC>'
                     + '<FC>id=IN_UP_CODE       name="IN_UP_CODE"       width=0      show=false </FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, true);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-19
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
    
    if(trim(LC_APP_S_DT.Text).length == 0){          // 기준일자
        showMessage(EXCLAMATION, OK, "USER-1002","기준일자");
        LC_APP_S_DT.Focus();
        return;
    }
    showMaster();
    //조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
 }

/**
 * btn_Save()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010-05-19
 * 개           요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
     
    // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
    
     var intJcompRate = 0;
     var intDRate     = 0;
     var intRateSum   = 0;
     var intAddRate   = 0;
     var intAddFeeRate= 0;
     for( row=0 ; row < DS_IO_MASTER.CountRow ; row++ ){
         intJcompRate = DS_IO_MASTER.NameValue(row,'JCOMP_RATE');
         intDRate     = DS_IO_MASTER.NameValue(row,'DCUBE_RATE');
         intAddRate   = DS_IO_MASTER.NameValue(row,'ADD_RATE');
         intAddFeeRate= DS_IO_MASTER.NameValue(row,'ADD_FEE_RATE');
         intRateSum  = intJcompRate + intDRate;
         if( intAddRate != intRateSum ){
             showMessage(EXCLAMATION, OK, "USER-1003","카드사적립율");
             DS_IO_MASTER.RowPosition = row;
             GR_MASTER.SetColumn("JCOMP_RATE");  
             return false;
         }
     }
     if(parseInt(strAppSDt) < parseInt(tomorrow)){
         showMessage(EXCLAMATION, OK, "USER-1000",  "미래월만 수정 가능합니다.");
         LC_APP_S_DT.Focus();
         return false;
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
 * 작 성 일     : 2010-05-19
 * 개       요     : 적립율등록 조회 
 * return값 : void
 */
function showMaster(){
    
    strBrchId   = EM_BRCH_ID.Text;
    strAppSDt   = replaceStr(LC_APP_S_DT.Text,"/", "");
    strPayType  = LC_PAY_TYPE.BindColVal;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strBrchId="  + encodeURIComponent(strBrchId)
                    + "&strPayType=" + encodeURIComponent(strPayType)
                    + "&strAppSDt="  + encodeURIComponent(strAppSDt);    
    
    EXCEL_PARAMS  = "가맹점="    + strBrchId;
    EXCEL_PARAMS += "-가맹점명=" + EM_BRCH_NAME.Text;
    EXCEL_PARAMS += "-제휴신용카드사=" + strPayType;
    EXCEL_PARAMS += "-기준일자=" + strAppSDt;
    
    TR_MAIN.Action  ="/dcs/dmbo204.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_IO_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
        EM_BRCH_ID.Focus();
    }
}

/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-19
 * 개       요     : 적립율등록
 * return값 : void
 */
function saveData(){
    var goTo        = "save";
    var action      = "I";  //조회는 O, 저장은 I
    TR_MAIN.Action  ="/dcs/dmbo204.do?goTo="+goTo;   
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

/**
 * getDcEtcCode()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-19
 * 개      요  : 적립월 콤보조회
 * return값 :
 */
function getDcEtcCode(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) { 
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(10),ALL_GB:STRING(1),NUL_GB:STRING(1)');

    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
        
    TR_MAIN.Action  = "/dcs/dmbo204.do?goTo=getDcEtcCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
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
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
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
        showMaster();
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

    var intDcubeRate = intAddRate - newValue;
    switch(colid){
        case 'JCOMP_RATE':
            DS_IO_MASTER.NameValue(row,'DCUBE_RATE') = intDcubeRate;
            break; 
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 적립율 2% 미만 입력 가능 CanColumnPosChange(row,colid) -->
<script language="javascript" for=GR_MASTER
	event=CanColumnPosChange(row,colid)>
    var orgValue = DS_IO_MASTER.OrgNameValue(row,colid);
    var newValue = DS_IO_MASTER.NameValue(row,colid);
    var intAddRate   = DS_IO_MASTER.NameValue(row,'ADD_RATE');
    var intDcubeRate = intAddRate - newValue;
    
    switch(colid){
        case 'JCOMP_RATE':
            if (DS_IO_MASTER.NameValue(row, 'JCOMP_RATE') > intAddRate) {
                showMessage(EXCLAMATION, OK, "USER-1000", "카드사 적립율은 적립율 이하로 입력하세요.");
                return false;
            } else {
                return true;
            }
            break;
        case 'ADD_FEE_RATE':
            if (DS_IO_MASTER.NameValue(row, 'JCOMP_RATE') == 0 &&  newValue > 0 ) {
                showMessage(EXCLAMATION, OK, "USER-1000", "적립수수료율을 확인하세요.");
                return false;
            } else {
                return true;
            }
            break;
    }
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
<script language=JavaScript for=LC_APP_S_DT event=onKillFocus()>
    checkDateTypeYM(LC_APP_S_DT);
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
<!-- =============== 공통콤보용 -->
<comment id="_NSID_"> <object id="DS_PAY_TYPE"
	classid=<%=Util.CLSID_DATASET%>> </object> </comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"> <object id="DS_APP_DT"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"> <object id="DS_IO_MASTER"
	classid=<%=Util.CLSID_DATASET%>> </object> </comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_"> <object id="DS_I_COMMON"
	classid=<%=Util.CLSID_DATASET%>> </object> </comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"> <object id="DS_I_CONDITION"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"> <object id="DS_O_RESULT"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_"> <object id="TR_MAIN"
	classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object> </comment>
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
										<th width="80">가맹점</th>
										<td width="200"><comment id="_NSID_"> <object
												id=EM_BRCH_ID classid=<%=Util.CLSID_EMEDIT%> width=72
												tabindex=1
												onKeyUp="javascript:keyPressEvent(event.keyCode);">
											</object> </comment> <script> _ws_(_NSID_);</script> <img
											src="/<%=dir%>/imgs/btn/detail_search_s.gif"
											align="absmiddle"
											onclick="getBrchPop(EM_BRCH_ID,EM_BRCH_NAME)" /> <comment
												id="_NSID_"> <object id=EM_BRCH_NAME
												classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1>
											</object> </comment> <script> _ws_(_NSID_);</script></td>
										<th width="80">제휴신용카드사</th>
										<td width="140"><comment id="_NSID_"> <object
												id=LC_PAY_TYPE classid=<%=Util.CLSID_LUXECOMBO%> height=100
												width=120 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
										<th width="80" class="point">기준일자</th>
										<td><comment id="_NSID_"> <object
												id=LC_APP_S_DT classid=<%=Util.CLSID_LUXECOMBO%> width=100
												tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
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
							<td><comment id="_NSID_"> <object id=GR_MASTER
									width="100%" height=503 classid=<%=Util.CLSID_GRID%> tabindex=1>
									<param name="DataID" value="DS_IO_MASTER">
								</object> </comment> <script> _ws_(_NSID_);</script></td>
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
