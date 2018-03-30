<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 수불손익 > 월마감관리
 * 작 성 일 : 2011.06.07
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pstk3110.jsp
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
 var top = 110;		//해당화면의 동적그리드top위치

function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_CLOSE_S_DT     , "YYYYMM"   , PK);      //마감기간 FROM
    //콤보 초기화 
    initComboStyle(LC_STR_CD            ,DS_STR_CD            , "CODE^0^30,NAME^0^155", 1, PK);      //점(조회)
    initComboStyle(LC_AFFAIRS_FLAG      ,DS_AFFAIRS_FLAG      , "CODE^0^30,NAME^0^155", 1, PK);      //업무구분

    // 점코드 조회
    getStore("DS_STR_CD"    , "Y", "", "N");
    searchAffairs();
    insComboData( LC_AFFAIRS_FLAG, "%", "전체",1);
    //getEtcCode("DS_AFFAIRS_FLAG", "D", "P802", "Y");
    LC_AFFAIRS_FLAG.Index= 0;
    
    //LC_AFFAIRS_FLAG
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
    	LC_STR_CD.Index= 0;
    }

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod311","DS_MASTER" );
    
    EM_CLOSE_S_DT.Text = getTodayFormat("YYYYMM");
    bfStrCd   = LC_STR_CD.BindColVal;
    brCloseYm = EM_CLOSE_S_DT.Text;
    LC_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=25   align=center edit=none    name="NO"           </FC>'
                     + '<FC>id=CLOSE_YM        width=80   align=center edit=none    name="년월"        mask="XXXX/XX" </FC>'
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
    if( EM_CLOSE_S_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "마감시작년월");
        EM_CLOSE_S_DT.Focus();
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
	 
	/* 신규 없음.
	var insRow = 0;
	for(var i=1; i<=DS_MASTER.CountRow; i++){
		if(DS_MASTER.RowStatus(i)==1){
			insRow = i;
			break;
		}
	}
    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
	if( insRow != 0){
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){   
            setFocusGrid(GD_MASTER, DS_MASTER, insRow, "CLOSE_YM");
            return;
        }
        DS_MASTER.DeleteRow(insRow);
	}
    //행추가
    DS_MASTER.Addrow();
    var row = DS_MASTER.RowPosition;
    DS_MASTER.NameValue(row,"STR_CD")          = LC_STR_CD.BindColVal;
    DS_MASTER.NameValue(row,"CLOSE_TASK_FLAG") = 'PSTK';
    DS_MASTER.NameValue(row,"CLOSE_YM")        = getTodayFormat("YYYYMM");
    DS_MASTER.NameValue(row,"CLOSE_YN")        = "N";
    DS_MASTER.NameValue(row,"SAP_IF_YN")       = "N";
    */
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
/*
    // 저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if( DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }

    if( !checkMasterValidation())
        return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        GD_MASTER.Focus();
        return; 
    }
    
    TR_MAIN.Action="/dps/pstk311.pt?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    if(TR_MAIN.ErrorCode == 0){
        searchMaster();        
    }
    GD_MASTER.Focus();
*/
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

    TR_MAIN.Action="/dps/pstk311.pt?goTo=close";  
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
 * btn_sapIF()
 * 작 성 자 : 정진영
 * 작 성 일 : 2011-02-18
 * 개    요 :  SAP 전송처리를 실행한다.
 * return값 : void
 */
function btn_sapIF(){
	//
    if(GD_MASTER.ColumnProp('SAP_IF', 'edit') == '{"false"}' || !DS_MASTER.IsUpdated){
        showMessage(EXCLAMATION, OK, "USER-1000", "전송할 데이터가 존재하지 않습니다.");
        return;
    }
	var total = DS_MASTER.CountRow;
	for(var i=1; i<=total; i++){
		if( DS_MASTER.NameValue(i,'SAP_IF')=="T"){
			if(DS_MASTER.NameValue(i,'CLOSE_YN')=="N"){
				showMessage(EXCLAMATION, OK, "USER-1000", "마감되지 않은 데이터 입니다.");
				setFocusGrid(GD_MASTER, DS_MASTER, i, 'CLOSE_YN');
				return;
			}
		}
	}
    
    if( showMessage(QUESTION, YESNO, "USER-1000","선택한 업무를 SAP 전송 하시겠습니까?") != 1 ){
        GD_MASTER.Focus();
        return; 
    }
    TR_MAIN.Action="/dps/pstk311.pt?goTo=sapSend";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    

    if(TR_MAIN.ErrorCode == 0){
        searchMaster();        
        GD_MASTER.ColumnProp('CLOSE_YN', 'edit') = '';
    }
    GD_MASTER.Focus();
}
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
    var strCloseDtS    = EM_CLOSE_S_DT.Text;
    var strAffairsFlag = LC_AFFAIRS_FLAG.BindColVal;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="         +encodeURIComponent(strStrCd)
                   + "&strCloseDtS="       +encodeURIComponent(strCloseDtS)
                   + "&strAffairsFlag="   +encodeURIComponent(strAffairsFlag);
    
    TR_MAIN.Action="/dps/pstk311.pt?goTo="+goTo+parameters;      
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
        
        if( closeYn==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "마감여부");
            errYn = true;
            colid = "CLOSE_YN";
            break;
        }
        
        if(closeYn=="Y"){
            if(bfCloseYn!="Y"){
                showMessage(EXCLAMATION, OK, "USER-1000", "이전 월이 마감되지 않았습니다.");
                errYn = true;
                colid = "CLOSE_YN";
                break;
            }
        }else{
            if(afCloseYn!="N"){
                showMessage(EXCLAMATION, OK, "USER-1000", "이후 월이 마감되어 있습니다.");
                errYn = true;
                colid = "CLOSE_YN";
                break;
            }
        }

        if(!checkBizClose( row))
        	return false;
    }
    
    if(errYn){
        setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
        return false;
    }
    return true;
}

/**
 * checkBizClose()
 * 작 성 자 : 정진영
 * 작 성 일 : 2011-04-04
 * 개    요 : 업무 마감 여부체크
 * return값 : void
**/
function checkBizClose( row){
	// 업무 코드 정의
	var saleBizCd       = '41';   // 매출
	var orderBizCd      = '42';   // 매입
    //var commissionBizCd = '44';   // 임대을수수료율 산출
    //var paymentBizCd    = '46';   // 대금지불
	var recDisBizCd     = '43';   // 수불
    var proLosBizCd     = '45';   // 손익
    
    var closeYn = DS_MASTER.NameValue(row,"CLOSE_YN");
    var unitCd  = DS_MASTER.NameValue(row,"CLOSE_UNIT_FLAG");

    // 데이터 셋의 업무의 로우
    var saleBizRow       = DS_MASTER.NameValueRow("CLOSE_UNIT_FLAG",saleBizCd);
    var orderBizRow      = DS_MASTER.NameValueRow("CLOSE_UNIT_FLAG",orderBizCd);
    //var commissionBizRow = DS_MASTER.NameValueRow("CLOSE_UNIT_FLAG",commissionBizCd);
    //var paymentBizRow    = DS_MASTER.NameValueRow("CLOSE_UNIT_FLAG",paymentBizCd);
    var recDisBizRow     = DS_MASTER.NameValueRow("CLOSE_UNIT_FLAG",recDisBizCd);
    var proLosBizRow     = DS_MASTER.NameValueRow("CLOSE_UNIT_FLAG",proLosBizCd);

    var rtnRow;
    var errYn = false;
    
    switch(unitCd){
        case saleBizCd:
        	if(closeYn=="N"){ // 마감 취소시 검증
                if(proLosBizRow >0){
                    if( DS_MASTER.NameValue(proLosBizRow,"CLOSE_YN")=="Y"){
                        rtnRow = proLosBizRow;
                        errYn = true;
                        break;
                    }
                }
                if(recDisBizRow >0){
                    if( DS_MASTER.NameValue(recDisBizRow,"CLOSE_YN")=="Y"){
                        rtnRow = recDisBizRow;
                        errYn = true;
                        break;
                    }
                }/*
        		if(commissionBizRow >0){
        			if( DS_MASTER.NameValue(commissionBizRow,"CLOSE_YN")=="Y"){
                        rtnRow = commissionBizRow;
                        errYn = true;
                        break;
        			}
        		}*/
        	}
        	break;
        case orderBizCd:
            if(closeYn=="N"){ // 마감 취소시 검증
                if(proLosBizRow >0){
                    if( DS_MASTER.NameValue(proLosBizRow,"CLOSE_YN")=="Y"){
                        rtnRow = proLosBizRow;
                        errYn = true;
                        break;
                    }
                }
                if(recDisBizRow >0){
                    if( DS_MASTER.NameValue(recDisBizRow,"CLOSE_YN")=="Y"){
                        rtnRow = recDisBizRow;
                        errYn = true;
                        break;
                    }
                }/*
                if(paymentBizRow >0){
                    if( DS_MASTER.NameValue(paymentBizRow,"CLOSE_YN")=="Y"){
                        rtnRow = paymentBizRow;
                        errYn = true;
                        break;
                    }
                }*/
            }
            break;/*
        case commissionBizCd:
            if(closeYn=="N"){ // 마감 취소시 검증
                if(paymentBizRow >0){
                    if( DS_MASTER.NameValue(paymentBizRow,"CLOSE_YN")=="Y"){
                        rtnRow = paymentBizRow;
                        errYn = true;
                        break;
                    }
                }
            }else{ // 마감 시 검증
                if(saleBizRow >0){
                    if( DS_MASTER.NameValue(saleBizRow,"CLOSE_YN")=="N"){
                        rtnRow = saleBizRow;
                        errYn = true;
                        break;
                    }
                }            	
            }
            break;*//*
        case paymentBizCd:
            if(closeYn=="Y"){ // 마감 시 검증
                if(orderBizRow >0){
                    if( DS_MASTER.NameValue(orderBizRow,"CLOSE_YN")=="N"){
                        rtnRow = orderBizRow;
                        errYn = true;
                        break;
                    }
                }
                if(saleBizRow >0){
                    if( DS_MASTER.NameValue(saleBizRow,"CLOSE_YN")=="N"){
                        rtnRow = saleBizRow;
                        errYn = true;
                        break;
                    }
                }
                if(commissionBizRow >0){
                    if( DS_MASTER.NameValue(commissionBizRow,"CLOSE_YN")=="N"){
                        rtnRow = commissionBizRow;
                        errYn = true;
                        break;
                    }
                }
            }
            break;*/
        case recDisBizCd:
            if(closeYn=="N"){ // 마감 취소시 검증
                if(proLosBizRow >0){
                    if( DS_MASTER.NameValue(proLosBizRow,"CLOSE_YN")=="Y"){
                        rtnRow = proLosBizRow;
                        errYn = true;
                        break;
                    }
                }
            }else{ // 마감 시 검증
                if(orderBizRow >0){
                    if( DS_MASTER.NameValue(orderBizRow,"CLOSE_YN")=="N"){
                        rtnRow = orderBizRow;
                        errYn = true;
                        break;
                    }
                }            
                if(saleBizRow >0){
                    if( DS_MASTER.NameValue(saleBizRow,"CLOSE_YN")=="N"){
                        rtnRow = saleBizRow;
                        errYn = true;
                        break;
                    }
                }               
            }
            break;
        case proLosBizCd:
            if(closeYn=="Y"){ // 마감 시 검증
                if(orderBizRow >0){
                    if( DS_MASTER.NameValue(orderBizRow,"CLOSE_YN")=="N"){
                        rtnRow = orderBizRow;
                        errYn = true;
                        break;
                    }
                }
                if(saleBizRow >0){
                    if( DS_MASTER.NameValue(saleBizRow,"CLOSE_YN")=="N"){
                        rtnRow = saleBizRow;
                        errYn = true;
                        break;
                    }
                }
                if(recDisBizRow >0){
                    if( DS_MASTER.NameValue(recDisBizRow,"CLOSE_YN")=="N"){
                        rtnRow = recDisBizRow;
                        errYn = true;
                        break;
                    }
                }
            }
            break;
    }

    if(errYn){
    	if(closeYn=="N"){
            showMessage(EXCLAMATION, OK, "USER-1000", DS_MASTER.NameValue(rtnRow,"CLOSE_UNIT_NAME") + "이/가 마감되어 있습니다.");
    	}else{
            showMessage(EXCLAMATION, OK, "USER-1000", DS_MASTER.NameValue(rtnRow,"CLOSE_UNIT_NAME") + "이/가 마감되지 않았습니다.");
    	}
        
        setFocusGrid(GD_MASTER,DS_MASTER,rtnRow,"CLOSE_YN");
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
    var strCloseDtS    = EM_CLOSE_S_DT.Text;
    var strAffairsFlag = LC_AFFAIRS_FLAG.BindColVal;

    
    var goTo       = "searchAffairs" ;    
    var action     = "O";  
    var parameters = "";
    
    TR_MAIN.Action="/dps/pstk311.pt?goTo="+goTo+parameters;      
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
        if( colid == "CLOSE_YM"){
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
    	if(value=="Y"){
    		if(bfCloseYn!="Y"){
    			showMessage(EXCLAMATION, OK, "USER-1000", "이전 월이 마감되지 않았습니다.");
    			DS_MASTER.NameValue(row, "CLOSE_YN") = 'N';
    			return;
    		}
    	}else{
            if(afCloseYn!="N"){
                showMessage(EXCLAMATION, OK, "USER-1000", "이후 월이 마감되어 있습니다.");
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
        case 'CLOSE_YM':
            if(!checkDateTypeYM(GD_MASTER,colid,getTodayFormat("YYYYMM"))){ 
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
        case 'CLOSE_YM':
            openCal(GD_MASTER,row,colid,'M');
            break;
    }
    onPopup = false;
</script>

<!-- 기간(조회) -->
<script language=JavaScript for=EM_CLOSE_S_DT event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getCalDt('NAME',EM_CLOSE_S_DT,"S");
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

<script language='javascript'>
window.onresize = function(){
	
var obj   = document.getElementById("GD_MASTER");
    
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
            <th width="80" class="point" >마감년월</th>
            <td width="150" >
              <comment id="_NSID_">
                <object id=EM_CLOSE_S_DT classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" onclick="javascript:getCalDt('POP', EM_CLOSE_S_DT,'S')" align="absmiddle" />
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
      <tr valign="top">
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=505 classid=<%=Util.CLSID_GRID%>>
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

