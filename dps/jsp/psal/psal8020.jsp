<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 마감 > 매출일마감관리
 * 작 성 일 : 2011.06.07
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : psal8020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 월 마감작업을 처리한다.
 * 이    력 :
 *        2011.06.07 (정진영) 신규작성
          2011.09.08 (박종은) 수정 - 조회조건 기간 from to 로 변경, 업무구분 추가
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
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
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

var bfStrCd;
var brCloseYm;
var onPopup = false;
 
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){


    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_CLOSE_YM, "YYYYMM"   , PK);      //마감기간 FROM
    //콤보 초기화 
    initComboStyle(LC_STR_CD            ,DS_STR_CD            , "CODE^0^30,NAME^0^155", 1, PK);      //점(조회)
    initComboStyle(LC_AFFAIRS_FLAG      ,DS_AFFAIRS_FLAG      , "CODE^0^30,NAME^0^155", 1, PK);      //업무구분

    // 점코드 조회
    getStore("DS_STR_CD"    , "Y", "", "N");
    
    // 업무구분 조회
    searchAffairs();
    insComboData( LC_AFFAIRS_FLAG, "%", "전체",1);
    LC_AFFAIRS_FLAG.Index= 0;

    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
    	LC_STR_CD.Index= 0;
    }

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod311","DS_MASTER" );
    
    EM_CLOSE_YM.Text = getTodayFormat("YYYYMM");
    bfStrCd   = LC_STR_CD.BindColVal;
    brCloseYm = EM_CLOSE_YM.Text;
    LC_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=25   align=center edit=none    name="NO"           </FC>'
                     + '<FC>id=CLOSE_DT        width=80   align=center edit=none    name="일자"        mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=CLOSE_UNIT_NAME width=180  align=left   edit=none    name="업무구분"     </FC>'
                     + '<FC>id=CLOSE_YN        width=100  align=left                name="*마감여부"    editStyle=combo data="Y:마감,N:미마감"</FC>'
                     //+ '<FC>id=SAP_IF          width=60   align=center              name="전송"         EditStyle=checkbox  edit={IF(SAP_IF_YN="" OR CLOSE_YN="N","false","true")}</FC>'
                     //+ '<FC>id=SAP_IF_YN       width=100  align=left   edit=none    name="SAP I/F"      editStyle=combo data="Y:전송,N:미전송"</FC>'
                     + '<FC>id=MOD_USER        width=80   align=left   edit=none    name="작업자"        </FC>'
                     + '<FC>id=MOD_DATE        width=160  align=center edit=none    name="작업일시"      mask="XXXX/XX/XX XX:XX:XX"</FC>';

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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	
    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( EM_CLOSE_YM.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "마감년월");
        EM_CLOSE_YM.Focus();
        return;
    }
    
    if( DS_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_MASTER.Focus();
            return ;
        }
    }
    searchMaster();
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
	if(GD_MASTER.ColumnProp('CLOSE_YN', 'edit') == 'NONE' || !DS_MASTER.IsUpdated){
        showMessage(EXCLAMATION, OK, "USER-1000", "마감할 데이터가 존재하지 않습니다.");
        return;
	}

    if( !checkClose())
        return;
    
    if( showMessage(QUESTION, YESNO, "USER-1000","선택한 업무를 마감(마감취소) 하시겠습니까?") != 1 ){
        GD_MASTER.Focus();
        return; 
    }

    TR_MAIN.Action="/dps/psal802.ps?goTo=close";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    

    if(TR_MAIN.ErrorCode == 0){
        searchMaster();        
        GD_MASTER.ColumnProp('SAP_IF', 'edit') = '{IF(SAP_IF_YN="" OR CLOSE_YN="N","false","true")}';
    }
    GD_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2011-02-18
 * 개    요 :  저장품 재고 리스트 조회
 * return값 : void
 */
function searchMaster(){

	DS_MASTER.ClearData();
    
    var strStrCd       = LC_STR_CD.BindColVal;
    var strCloseDtS    = EM_CLOSE_YM.Text;
    var strAffairsFlag = LC_AFFAIRS_FLAG.BindColVal;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="         +encodeURIComponent(strStrCd)
                   + "&strCloseDtS="       +encodeURIComponent(strCloseDtS)
                   + "&strAffairsFlag="   +encodeURIComponent(strAffairsFlag);
    
    TR_MAIN.Action="/dps/psal802.ps?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

}

/**
 * getCalDt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2011-04-04
 * 개    요 : 달력 팝업을 실행한다.
 * return값 : void
**/
function getCalDt(evnFlag, obj, scvFlag){
	 
    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 기간을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","기간") != 1 ){
        	obj.Text = brCloseYm;
            GD_MASTER.Focus();
            return;
        }
    }
    DS_MASTER.ClearData();
    
    
    if( evnFlag == 'POP'){
        openCal('M',obj);
    }
    
    if(!checkDateTypeYM( obj , brCloseYm))
        return;

    brCloseYm = obj.Text;
}

/**
 * checkClose()
 * 작 성 자 : 정진영
 * 작 성 일 : 2011-04-04
 * 개    요 : 마감을 체크 합니다.
 * return값 : void
**/
function checkClose(){
    var row;
    var colid;
    var errYn = false;

    for(var i=1; i<=DS_MASTER.CountRow; i++){
        var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;
        
        row = i;
        var closeYn   = DS_MASTER.NameValue(i, "CLOSE_YN");
        var bfCloseYn = DS_MASTER.NameValue(i, "BF_CLOSE_YN");
        var afCloseYn = DS_MASTER.NameValue(i, "AF_CLOSE_YN");
        var mCloseYn  = DS_MASTER.NameValue(i, "M_CLOSE_YN");
        
        if( closeYn==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "마감여부");
            errYn = true;
            colid = "CLOSE_YN";
            break;
        }
        

        if(closeYn=="Y"){
        	if (i==1) {
	            if(bfCloseYn!="Y"){
	                showMessage(EXCLAMATION, OK, "USER-1000", "이전 일이 마감되지 않았습니다.");
	                errYn = true;
	                colid = "CLOSE_YN";
	                break;
	            }
        	} else {
	            if(DS_MASTER.NameValue(i-1, "CLOSE_YN")!="Y"){
	                showMessage(EXCLAMATION, OK, "USER-1000", "이전 일이 마감되지 않았습니다.");
	                errYn = true;
	                colid = "CLOSE_YN";
	                break;
	            }	
        	}
        		
        }else{
        	if (i==DS_MASTER.CountRow) {
	            if(afCloseYn!="N"){
	                showMessage(EXCLAMATION, OK, "USER-1000", "이후 일이 마감되어 있습니다.");
	                errYn = true;
	                colid = "CLOSE_YN";
	                break;
	            }
        	} else {
	            if(DS_MASTER.NameValue(i+1, "CLOSE_YN")!="N"){
	                showMessage(EXCLAMATION, OK, "USER-1000", "이후 일이 마감되어 있습니다.");
	                errYn = true;
	                colid = "CLOSE_YN";
	                break;
	            }	
        	}
            
            
            if(mCloseYn!="N"){
                showMessage(EXCLAMATION, OK, "USER-1000", "당월 월매출이 마감되어 있습니다.");
                errYn = true;
                colid = "CLOSE_YN";
                break;
            } 
        }
        
    }
    
    if(errYn){
        setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
        return false;
    }
    return true;
}


/**
 * searchAffairs()
 * 작 성 자 : 박종은
 * 작 성 일 : 2011-09-09
 * 개    요 :  업무구분 리스트 조회
 * return값 : void
 */
function searchAffairs(){

    DS_AFFAIRS_FLAG.ClearData();
    
    var strStrCd       = LC_STR_CD.BindColVal;
    var strCloseDtS    = EM_CLOSE_YM.Text;
    var strAffairsFlag = LC_AFFAIRS_FLAG.BindColVal;

    
    var goTo       = "searchAffairs" ;    
    var action     = "O";  
    var parameters = "";
    
    TR_MAIN.Action="/dps/psal802.ps?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_AFFAIRS_FLAG=DS_AFFAIRS_FLAG)"; //조회는 O
    TR_MAIN.Post();    
    

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
</script>


<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_MASTER event=OnDataError(row,colid)>
    var errorCode = DS_MASTER.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        if( colid == "CLOSE_DT"){
            showMessage(EXCLAMATION, OK, "USER-1003", "년월");
        }else{
            showMessage(EXCLAMATION, OK, "USER-1002", "업무구분");
        }
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_MASTER.ErrorMsg);       
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnListSelect(index,row,colid)>
    if(row<1)
    	return;
    
    if(colid == "CLOSE_YN"){
    	var value     = DS_MASTER.NameValue(row, "CLOSE_YN");
        var bfCloseYn = DS_MASTER.NameValue(row, "BF_CLOSE_YN");
        var afCloseYn = DS_MASTER.NameValue(row, "AF_CLOSE_YN");
        var mCloseYn  = DS_MASTER.NameValue(row, "M_CLOSE_YN");
        
    	if(value=="Y"){
    		
    		if (row == 1) {
	    		if(bfCloseYn!="Y"){
	    			showMessage(EXCLAMATION, OK, "USER-1000", "이전 일이 마감되지 않았습니다.");
	    			DS_MASTER.NameValue(row, "CLOSE_YN") = 'N';
	    			return;
	    		}
    		} else {
	    		if(DS_MASTER.NameValue(row-1, "CLOSE_YN")!="Y"){
	    			showMessage(EXCLAMATION, OK, "USER-1000", "이전 일이 마감되지 않았습니다.");
	    			DS_MASTER.NameValue(row, "CLOSE_YN") = 'N';
	    			return;
	    		}	
    		}
    	}else{
    		
    		if (row==DS_MASTER.CountRow) {
	            if(afCloseYn!="N"){
	                showMessage(EXCLAMATION, OK, "USER-1000", "이후 일이 마감되어 있습니다.");
	                DS_MASTER.NameValue(row, "CLOSE_YN") = 'Y';
	                return;
	            }
    		} else {
	            if(DS_MASTER.NameValue(row+1, "CLOSE_YN")!="N"){
	                showMessage(EXCLAMATION, OK, "USER-1000", "이후 일이 마감되어 있습니다.");
	                DS_MASTER.NameValue(row, "CLOSE_YN") = 'Y';
	                return;
	            }	
    		} 
    			
            if(mCloseYn!="N"){
                showMessage(EXCLAMATION, OK, "USER-1000", "당월 월매출이 마감되어 있습니다.");
                DS_MASTER.NameValue(row, "CLOSE_YN") = 'Y';
                return;
            } 
    	}


    	if(DS_MASTER.IsUpdated){
    		GD_MASTER.ColumnProp('SAP_IF', 'edit') = '{"false"}';
    	}else{
            GD_MASTER.ColumnProp('SAP_IF', 'edit') = '{IF(SAP_IF_YN="" OR CLOSE_YN="N","false","true")}';    		
    	}
    }
</script>
<script language=JavaScript for=GD_MASTER event=OnCheckClick(row,colid,check)>
    if(row<1)
        return;
    
    if(colid == "SAP_IF"){
        
        if(DS_MASTER.IsUpdated){
            GD_MASTER.ColumnProp('CLOSE_YN', 'edit') = 'none';
        }else{
            GD_MASTER.ColumnProp('CLOSE_YN', 'edit') = '';           
        }
    }
</script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
    if(row < 1 || onPopup){
        return;
    }
    var value = DS_MASTER.NameValue(row,colid);
    if( value == olddata)
        return;
    alert(colid);
    switch(colid){
        case 'CLOSE_DT':
            if(!checkDateTypeYM(GD_MASTER,colid,getTodayFormat("YYYYMMDD"))){ 
                return;
            }
            break;
    
    }
</script> 
<!-- 팝업  -->
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    if(row < 1){
        return;
    }
    onPopup = true;
    switch(colid){
        case 'CLOSE_DT':
            openCal(GD_MASTER,row,colid,'D');
            break;
    }
    onPopup = false;
</script>

<!-- 기간(조회) -->
<script language=JavaScript for=EM_CLOSE_YM event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getCalDt('NAME',EM_CLOSE_YM,"S");
</script>

<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    if( bfStrCd != this.BindColVal){
        if( DS_MASTER.IsUpdated){
            // 변경된 상세내역이 존재합니다. 점을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","점") != 1 ){
                setComboData(LC_STR_CD,bfStrCd);
                GD_MASTER.Focus();
                return;
            }
        }
        DS_MASTER.ClearData();
    }
    bfStrCd = this.BindColVal;
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
<comment id="_NSID_"><object id="DS_STR_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_FLAG"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEND_FLAG"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_AFFAIRS_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width=80 class="point">점</th>
            <td width="150">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point" >년월</th>
            <td width="150" >
              <comment id="_NSID_">
                <object id=EM_CLOSE_YM classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" onclick="javascript:getCalDt('POP', EM_CLOSE_YM,'S')" align="absmiddle" />
            </td>
            <th width="80" >업무구분</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_AFFAIRS_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=120 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>  
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <!-- 
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="right PB03" height=20 ><img 
              src="/<%=dir%>/imgs/btn/send_pre.gif" id=IMG_SEND onClick="javascript:btn_sapIF();" />
            </td>
          </tr>
        </table></td>
      </tr>
       -->
      <tr class="PT10">
        <td class="FS11 red">※ 수정 POS에서 과거 일자로 매출을 발생 시키려면 해당일자의 매출 일 마감을 미마감 처리 하셔야 합니다. 수정 POS 작업 완료후 마감 처리하십시요.
        </td>
      </tr>
      <tr class="PT10">
        <td class="FS11 red">※ 매출 월 마감이 완료 된 경우 매출 일마감에 대한 미마감 처리는 불가합니다. 재고수불>>수불손익>>월마감관리 확인
        </td>
      </tr>
      <tr valign="top">
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=460 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

