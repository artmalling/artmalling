<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > 청구제외 등록
 * 작 성 일 : 2010.05.26
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : psal9110.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.05.26 (장형욱) 신규작성
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var EXCEL_PARAMS = "";
var strDueDt = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
          
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();  

    //-- 입력필드
    initEmEdit(EM_CCOMP_CD_S,    "00",          NORMAL);         
    initEmEdit(EM_CCOMP_NM_S,    "GEN^20",      READ);   
    initEmEdit(EM_S_SALE_DT_S,   "today",       PK);    
    initEmEdit(EM_E_SALE_DT_S,   "today",       PK);      
    
    initEmEdit(EM_RECP_NO_S,     "0000000000000000", NORMAL);     //-- 영수증번호      
    initEmEdit(EM_CARD_NO_S,     "0000-0000-0000-0000-0000",  NORMAL);   
    initEmEdit(EM_APPR_NO_S,     "0000000000",           NORMAL);     //-- 승인번호
    
    initComboStyle(LC_BCOMP_S,   DS_O_BCOMP,  "CODE^0^30, NAME^0^80", 1, NORMAL);
    initComboStyle(LC_STR_CD_S,  DS_O_S_STR,  "CODE^0^30, NAME^0^80", 1, PK);
    
    // EMedit에 초기화
    getBcompCode("DS_O_BCOMP", "", "", "Y");    
    getStore("DS_O_S_STR", "Y", "", "N");
         
    
    initEmEdit(EM_RECP_NO,       "0000000000000000",     READ);  
    initEmEdit(EM_APPR_AMT,      "NUMBER^8^0",               READ);    //-- 총매출
    initEmEdit(EM_CARD_NO,       "0000-0000-0000-0000-0000",      READ);    //-- 카드번호
    
    initEmEdit(EM_CCOMP_CD,      "00",          READ);             
    initEmEdit(EM_CCOMP_NM,      "GEN^20",      READ);       
    initEmEdit(EM_APPR_NO,       "0000000000",  READ);  //-- 승인번호
    initEmEdit(EM_DIV_MONTH,     "GEN^12",      READ);  //-- 할부개월
    
    initComboStyle(LC_BCOMP,     DS_O_BCOMP_D, "CODE^0^30, NAME^0^80", 1, READ);
    getBcompCode("DS_O_BCOMP_D", "", "", "N");    
    LC_BCOMP.BindColVal = "%";
    
    initComboStyle(LC_CHRG_YN,   DS_O_CHRG, "CODE^0^30, NAME^0^80", 1, PK);
    getChrgCode("DS_O_CHRG", "", "", "N");    
    LC_CHRG_YN.BindColVal = "%";
    
    initEmEdit(EM_REG_DT,        "YYYY/MM/DD",       READ); //-- 청구제외일자
    initEmEdit(EM_DUE_DT,        "YYYY/MM/DD",       PK);   //-- 청구예정일자
    
    initComboStyle(LC_REASON_CD,   DS_O_REASON, "CODE^0^30, NAME^0^120", 1, PK); //-- 청구제외사유
    
    getEtcCode("DS_O_REASON", "D", "D064", "N");    
    LC_REASON_CD.BindColVal = "%";      
    
    EM_S_SALE_DT_S.text   = addDate("D", "-1", EM_E_SALE_DT_S.text);
    
    //LC_BCOMP_S.BindColVal = "%";  
    LC_BCOMP_S.index    = 0;
    LC_STR_CD_S.index   = 0;   
    LC_REASON_CD.index  = 0;
    LC_CHRG_YN.index    = 0;
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("psal911","DS_IO_DETAIL");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"           width=30     align=center</FC>'
                     + '<FC>id=RECP_NO      name="영수증번호"    width=160    align=center</FC>'
                     + '<FC>id=APPR_AMT     name="총매출"        width=100    align=right</FC>'
                     + '<FC>id=CARD_NO      name="카드번호"      width=170    align=center mask="XXXX-XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=CCOMP_NM     name="카드발급사"    width=100    align=left</FC>'
                     + '<FC>id=APPR_NO      name="승인번호"      width=100     align=left</FC>'
                     + '<FC>id=DIV_MONTH    name="할부"          width=50     align=right</FC>'
                     + '<FC>id=BCOMP_NM     name="카드매입사"    width=100    align=left</FC>'
                     + '<FC>id=REG_DT       name="청구제외일자"  width=85     align=center mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=REASON_NM    name="청구제외사유"  width=100    align=left</FC>'
                     + '<FC>id=DUE_DT       name="청구예정일자"  width=85     align=center mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CHRG_YN      name="상태"          width=60     align=center</FC>'
                     + '<FC>id=STR_CD       name="hidden"        width=60     align=center show=false</FC>'
                     + '<FC>id=SALE_DT      name="hidden"        width=60     align=center show=false</FC>'
                     + '<FC>id=POS_NO       name="hidden"        width=60     align=center show=false</FC>'
                     + '<FC>id=TRAN_NO      name="hidden"        width=60     align=center show=false</FC>'
                     + '<FC>id=SEQ_NO       name="hidden"        width=60     align=center show=false</FC>'
                     + '<FC>id=PAY_TYPE     name="hidden"        width=60     align=center show=false</FC>'
                     + '<FC>id=BCOMP_CD     name="hidden"        width=60     align=center show=false</FC>'
                     + '<FC>id=CCOMP_CD     name="hidden"        width=60     align=center show=false</FC>'
                     + '<FC>id=POS_SEQ_NO   name="hidden"        width=60     align=center show=false</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
 * 작 성 일 : 2010-05-23
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {  
    if ( DS_IO_DETAIL.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
            return false;
        }else{
          strChangFlag = true;
        }
    }
    if (trim(LC_STR_CD_S.BindColVal).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
        LC_STR_CD_S.Focus();
        return;
    }   
    
    if (trim(EM_RECP_NO_S.text).length != 0 &&  trim(EM_RECP_NO_S.text).length != 16) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "영수증번호은/는 16자리까지 입력해야 합니다.");
        EM_RECP_NO_S.Focus();
        return;
    }
    
    if (trim(EM_S_SALE_DT_S.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1001",  "매출일자");
        EM_S_SALE_DT_S.Focus();
        return;
    } else if (trim(EM_E_SALE_DT_S.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1001",  "매출일자");
        EM_E_SALE_DT_S.Focus();
        return;
    }   
    
    if( EM_S_SALE_DT_S.Text > EM_E_SALE_DT_S.Text){        //조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_S_SALE_DT_S.Focus();
        return;
    }     
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="     +  encodeURIComponent(LC_STR_CD_S.BindColVal)   
                    + "&strCcompCd="   +  encodeURIComponent(EM_CCOMP_CD_S.text)  
                    + "&strBcomp="     +  encodeURIComponent(LC_BCOMP_S.BindColVal)    
                    + "&strSSaleDt="   +  encodeURIComponent(EM_S_SALE_DT_S.text)  
                    + "&strESaleDt="   +  encodeURIComponent(EM_E_SALE_DT_S.text)  
                    + "&strRecpNo="    +  encodeURIComponent(EM_RECP_NO_S.text)
                    + "&strCardNo="    +  encodeURIComponent(EM_CARD_NO_S.text)   
                    + "&strApprNo="    +  encodeURIComponent(EM_APPR_NO_S.text)
                    + "&strBuyReqYN="  +  encodeURIComponent(RD_BUYREQ_YN.CodeValue);  
    
    
    TR_MAIN.Action  = "/dps/psal911.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GD_MASTER.Focus();        
    }

    bfListRowPosition = 0;
}

/**
 * btn_Save()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
     saveData();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * saveData()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개       요 : 카드발급사코드 관리 등록
 * return값 : void
 */
function saveData(){
     
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
    
    if (trim(LC_CHRG_YN.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "상태");
        LC_CHRG_YN.Focus();
        return;
    }     
    
    if (trim(EM_DUE_DT.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "청구예정일자");
        EM_DUE_DT.Focus();
        return;
    } 
    
    if (trim(LC_REASON_CD.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "청구제외사유");
        LC_REASON_CD.Focus();
        return;
    }
          
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
       return;
    }   
    
    var goTo        = "saveData";
    var action      = "I";  //조회는 O
    
    var parameters  = "&strStrCd="   + encodeURIComponent(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"STR_CD"))
                    + "&strPosNo="   + encodeURIComponent(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"POS_NO"))
                    + "&strTranNo="  + encodeURIComponent(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"TRAN_NO"))
                    + "&strSaleDt="  + encodeURIComponent(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"SALE_DT"))
                    + "&strSeqNo="   + encodeURIComponent(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"SEQ_NO"))
                    + "&strPosSeqNo="+ encodeURIComponent(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"POS_SEQ_NO"))
                    + "&strPayType=" + encodeURIComponent(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"PAY_TYPE")); 
    
    TR_MAIN.Action  ="/dps/psal911.ps?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MAIN.Post();

    btn_Search();
}
  
/**
 * doOnClick()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개       요 : 선택된 클럽관리 정보 상세 조회 
 * return값 : void
 */
function doClick(row){
    
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
     
    var goTo          = "searchDetail";    
    var action        = "O";     
    var parameters    = "&strStrCd="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"STR_CD"))
                      + "&strPosNo="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"POS_NO"))
                      + "&strTranNo="  + encodeURIComponent(DS_O_MASTER.NameValue(row ,"TRAN_NO"))
                      + "&strSaleDt="  + encodeURIComponent(DS_O_MASTER.NameValue(row ,"SALE_DT"))
                      + "&strSeqNo="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"SEQ_NO"))
                      + "&strPayType=" + encodeURIComponent(DS_O_MASTER.NameValue(row ,"PAY_TYPE"));
    
    TR_DETAIL.Action  = "/dps/psal911.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
   
    if (DS_IO_DETAIL.CountRow <= 0 ) {
    	DS_IO_DETAIL.addRow();
        EM_RECP_NO.text   = DS_O_MASTER.NameValue(row ,"STR_CD").substring(1,2)+DS_O_MASTER.NameValue(row ,"SALE_DT").substring(2,8)+DS_O_MASTER.NameValue(row ,"POS_NO")+DS_O_MASTER.NameValue(row ,"TRAN_NO");
       
        EM_APPR_AMT.text  = DS_O_MASTER.NameValue(row ,"APPR_AMT");
        EM_CARD_NO.text   = DS_O_MASTER.NameValue(row ,"CARD_NO");
        
        EM_APPR_NO.text   = DS_O_MASTER.NameValue(row ,"APPR_NO");
        

        EM_REG_DT.text    = DS_O_MASTER.NameValue(row ,"REG_DT");
        EM_DUE_DT.text    = DS_O_MASTER.NameValue(row ,"DUE_DT");
        
        LC_BCOMP.BindColVal     = DS_O_MASTER.NameValue(row ,"BCOMP_CD");
        LC_CHRG_YN.BindColVal   = DS_O_MASTER.NameValue(row ,"CHRG_YN");   
        LC_REASON_CD.BindColVal = DS_O_MASTER.NameValue(row ,"REASON_CD");        
    }
    
    EM_CCOMP_CD.text  = DS_O_MASTER.NameValue(row ,"CCOMP_CD");
    EM_CCOMP_NM.text  = DS_O_MASTER.NameValue(row ,"CCOMP_NM");
    EM_DIV_MONTH.text = DS_O_MASTER.NameValue(row ,"DIV_MONTH");
    
    //Dataset status 초기화.
    DS_IO_DETAIL.ResetStatus();
    
}  
 
/**
 * keyPressEvent()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-25
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode, objCd, objNm) { 
    objNm.Text = "";//조건입력시 코드초기화 
	if (objCd.Text.length > 0 ) {
	    if (kcode == 13 || kcode == 9 || objCd.Text.length == 2) { //TAB,ENTER 키 실행시에만  
	        var goTo       = "searchOnMaster" ;    
	        var action     = "O";     
	        var parameters = "&strCcompCd="+encodeURIComponent(objCd.Text);
	        
	        TR_MAIN.Action="/pot/ccom027.cc?goTo="+goTo+parameters;
	        TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_RESULT)"; //조회는 O
	        TR_MAIN.Post();
	          
	        if (DS_O_RESULT.CountRow == 1 ) {
	            objCd.Text   = DS_O_RESULT.NameValue(1, "CODE");
	            objNm.Text   = DS_O_RESULT.NameValue(1, "NAME");
	        } else {
	             //1건 이외의 내역이 조회 시 팝업 호출
	            getCcompPop(objCd, objNm)
	        }
	    }  
	}  
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
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(clickSORT)
        return;
    
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        doClick(row);   
    }else{
        DS_IO_DETAIL.ClearData();
    }
    strDueDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"DUE_DT");
</script>

<!-- onKillFocus() -->
<script language=JavaScript for=EM_CCOMP_CD_S event=onKillFocus()>
    if ((EM_CCOMP_CD_S.Modified) && (EM_CCOMP_CD_S.Text.length != 2)) {
    	EM_CCOMP_CD_S.Text = "";
    	EM_CCOMP_NM_S.Text = "";
    }
</script>

<!-- 매출일자 Start onKillFocus() -->
<script language=JavaScript for=EM_S_SALE_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_SALE_DT_S)){
        EM_S_SALE_DT_S.text   = addDate("D", "-1", EM_E_SALE_DT_S.text);
    }
</script>

<!-- 매출일자 End onKillFocus() -->
<script language=JavaScript for=EM_E_SALE_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_E_SALE_DT_S)){
        initEmEdit(EM_E_SALE_DT_S,   "today",       PK);    
    }
</script>  

<!-- 청구예정일자 End onKillFocus() -->
<script language=JavaScript for=EM_DUE_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_DUE_DT)){
    	EM_DUE_DT.Text = strDueDt;
    }
</script>  
   
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
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_BCOMP classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_BCOMP_D classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_CHRG classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_REASON classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_S_STR classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

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

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
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
						<th width="80" class="point">점포명</th>
						<td width="200"><comment id="_NSID_"> <object
							id=LC_STR_CD_S classid=<%=Util.CLSID_LUXECOMBO%> width=95
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>

						<th width="80">카드발급사</th>
						<td width="160"><comment id="_NSID_"> <object
							id=EM_CCOMP_CD_S classid=<%=Util.CLSID_EMEDIT%> width=20
							tabindex=1 onKillFocus="javascript:onKillFocus()"
							onKeyUp="javascript:keyPressEvent(event.keyCode, EM_CCOMP_CD_S, EM_CCOMP_NM_S);"></object>
						</comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getCcompPop(EM_CCOMP_CD_S, EM_CCOMP_NM_S)" /> <comment
							id="_NSID_"> <object id=EM_CCOMP_NM_S
							classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>

						<th width="60">카드매입사</th>
						<td><comment id="_NSID_"> <object id=LC_BCOMP_S
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=138
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="80" class="point">매출일자</th>
						<td><comment id="_NSID_"> <object id=EM_S_SALE_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_SALE_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_E_SALE_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_SALE_DT_S)" /></td>

						<th width="80">영수증번호</th>
						<td><comment id="_NSID_"> <object id=EM_RECP_NO_S
							classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>

						<th width="60">카드번호</th>
						<td><comment id="_NSID_"> <object id=EM_CARD_NO_S
							classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="80">승인번호</th>
						<td><comment id="_NSID_"> <object id=EM_APPR_NO_S
							classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>

						<th width="80">조회구분</th>
						<td colspan="4"><comment id="_NSID_"> <object
							id=RD_BUYREQ_YN classid=<%=Util.CLSID_RADIO%>
							style="height: 20; width: 220" tabindex=1>
							<param name=Cols value="3">
							<param name=Format value="^미청구,N^청구제외,Y^기청구">
							<param name="AutoMargin" value="true">
							<param name=CodeValue value="">
						</object> </comment><script> _ws_(_NSID_);</script></td>
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
	<tr>
		<td></td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GD_MASTER
					width="100%" height=347 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
        <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width="80">영수증번호</th>
                        <td width="180"><comment id="_NSID_"> <object
                            id=EM_RECP_NO classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1></object>
                        </comment> <script> _ws_(_NSID_);</script></td>

                        <th width="80">총매출</th>
                        <td width="180"><comment id="_NSID_"> <object
                            id=EM_APPR_AMT classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1></object>
                        </comment> <script> _ws_(_NSID_);</script></td>
                        
                        <th width="80">카드번호</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1></object>
                        </comment> <script> _ws_(_NSID_);</script></td>                        
                    </tr>
                    <tr>
						<th width="80">카드발급사</th>
						<td><comment id="_NSID_"> <object
							id=EM_CCOMP_CD classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						<comment id="_NSID_"> <object id=EM_CCOMP_NM
							classid=<%=Util.CLSID_EMEDIT%> width=101 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>

						<th width="80">승인번호</th>
                        <td><comment id="_NSID_"> <object id=EM_APPR_NO
                            classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
                        
                        <th width="80">할부개월</th>
                        <td><comment id="_NSID_"> <object id=EM_DIV_MONTH
                            classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="80">카드매입사</th>
                        <td><comment id="_NSID_"> <object id=LC_BCOMP
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=137
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        
                        <th width="80" class="point">상태</th>
                        <td><comment id="_NSID_"> <object id=LC_CHRG_YN
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=159
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td> 
                        
                        <th width="80">청구제외일자</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_REG_DT classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="80" class="point">청구예정일자</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_DUE_DT classid=<%=Util.CLSID_EMEDIT%> width=113 tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_DUE_DT)" /></td>  
                        
                        <th width="80" class="point">청구제외사유</th>
                        <td colspan="3"><comment id="_NSID_"> <object id=LC_REASON_CD
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=159
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>       
                    </tr>                    
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_DETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
               <c>col=RECP_NO     ctrl=EM_RECP_NO      Param=Text</c>
               <c>col=APPR_AMT    ctrl=EM_APPR_AMT     Param=Text</c>
               <c>col=CARD_NO     ctrl=EM_CARD_NO      Param=Text</c>
               <c>col=APPR_NO     ctrl=EM_APPR_NO      Param=Text</c>
               <c>col=BCOMP_CD    ctrl=LC_BCOMP        Param=BindColVal</c>
               <c>col=CHRG_YN     ctrl=LC_CHRG_YN      Param=BindColVal</c>
               <c>col=REG_DT      ctrl=EM_REG_DT       Param=Text</c>
               <c>col=DUE_DT      ctrl=EM_DUE_DT       Param=Text</c>
               <c>col=REASON_CD   ctrl=LC_REASON_CD    Param=BindColVal</c>
             '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
