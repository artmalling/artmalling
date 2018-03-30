<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 >  협력사EDI >  협력사EDI 커뮤니티 > 협력사공지사항등록 
 * 작 성 일 : 2011.03.18
 * 작 성 자 : 오형규
 * 수 정 자 : 
 * 파 일 명 : medi1020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 협력사의 공지사항 내역을 등록
 * 이    력 :
 *        
          2011.03.18 (오형규) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
	//session 정보
	SessionInfo sessionInfo = (SessionInfo) session
			.getAttribute("sessionInfo");
	String userid = sessionInfo.getUSER_ID();
	String org_falg = sessionInfo.getORG_FLAG();

	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var userid = '<%=userid%>';         //사용자아이디
var org_flag = '<%=org_falg%>';     //매장정보
var g_saveFlag = false;
var type = "N";


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
   
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_BYBER.setDataHeader('<gauce:dataset name="H_BUYERCD"/>');
    DS_O_COMBOBUYER.setDataHeader('<gauce:dataset name="H_COMBOBUYER"/>');//
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DATE,  "SYYYYMMDD", PK);               // [조회용]시작 기간일
    initEmEdit(EM_E_DATE,  "TODAY", PK);               // [조회용]종료 기간일
    initEmEdit(EM_O_TITLE,  "GEN", NORMAL);      // [조회용]제목/내용
    initEmEdit(EM_O_READ_CNT,  "NUMBER3^3", NORMAL);         // [조회용]조회건수
    
    initEmEdit(EM_TITLE,  "GEN", NORMAL);              // 제목    
    initEmEdit(RD_IO_AUTHORIZE, "GEN", NORMAL);        //권한
    initTxtAreaEdit(TEXT_CALL_DESC_I, NORMAL);              //내용
    initEmEdit(EM_FILE_NAME, "GEN", READ);        //첨부파일
    
    
    initComboStyle(LC_O_STRCD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점(조회)
    initComboStyle(LC_IO_STRCD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점(입력)
    initComboStyle(LC_I0_REGISTER , DS_O_COMBOBUYER, "BUYER_CD^0^50, BUYER_NM^0^150", 1, PK); ////등록자
    
    getStore("DS_O_STR_CD", "Y", "1", "N");             //점코드
    getStore("DS_I_STR_CD", "Y", "1", "N"); 
    
   
    
    LC_O_STRCD.Index = 0;
    EM_O_READ_CNT.Text = "100";
    LC_O_STRCD.Focus();
    
    EnableCheck("false");
    
    getSearch(); 
    LC_IO_STRCD.Index = 0;
    
    registerUsingDataset("medi102","DS_IO_MASTER,DS_O_BYBER");
   // getComboBuyer();
}

function gridCreate(){      
       
           var hdrProperies = ''
               + '<FC>ID={CURROW}        NAME="NO"'
               + '                                         WIDTH=30    ALIGN=CENTER</FC>'
               + '<FC>ID=STR_CD         NAME="점"           WIDTH=80    ALIGN=LEFT SHOW=FALSE </FC>'
               + '<FC>ID=STRNM         NAME="점"           WIDTH=80    ALIGN=LEFT EditStyle=Lookup </FC>'
               + '<FC>ID=SEQ_NO          NAME="순번"'
               + '                                         WIDTH=80    ALIGN=CENTER  </FC>'
               + '<FC>ID=REG_DT          NAME="일자"'
               + '                                         WIDTH=140    ALIGN=center  MASK="XXXX/XX/XX" </FC>'
               + '<FC>ID=TIMES           NAME="시간"'
               + '                                         WIDTH=100    ALIGN=center MASK="XX:XX" </FC>'
               + '<FC>ID=TITLE01         NAME="제목"'
               + '                                         WIDTH=270    ALIGN=LEFT   </FC>'
               + '<FC>ID=BUYER_NAME01    NAME="등록자"'
               + '                                         WIDTH=100   ALIGN=LEFT  </FC>'
               + '<FC>ID=READ_CNT        NAME="조회수"'
               + '                                         WIDTH=100  Edit=Numeric  ALIGN=center  </FC>'
               + '<FC>ID=TITLE02         NAME="제목"       WIDTH=100    ALIGN=LEFT SHOW=FALSE </FC>'
               + '<FC>ID=BUYER_NAME02    NAME="등록자"       WIDTH=100    ALIGN=LEFT SHOW=FALSE </FC>'
               + '<FC>ID=AUTH_FLAG       NAME="권한"       WIDTH=100    ALIGN=LEFT SHOW=FALSE </FC>'
               + '<FC>ID=CONTEN          NAME="내용"       WIDTH=100    ALIGN=LEFT SHOW=FALSE </FC>'
               + '<FC>ID=BUYER_CD        NAME="바이어코드"       WIDTH=100    ALIGN=LEFT SHOW=TRUE </FC>';
           initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
        
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
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-21
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    
    if( LC_O_STRCD.Text.length == 0 ){
        showMessage(INFORMATION, OK, "USER-1001", "점");
        LC_O_STRCD.Focus();
        return;
    }
    if( EM_S_DATE.Text.length == 0 ){
        showMessage(INFORMATION, OK, "USER-1001", "시작기간일");
        EM_S_DATE.Focus();
        return;
    }
    
    if( EM_E_DATE.Text.length == 0 ){
        showMessage(INFORMATION, OK, "USER-1001", "종료기간일");
        EM_E_DATE.Focus();
        return;
    }
    
    if( type == "Y" && DS_IO_MASTER.IsUpdated){ 
        if(showMessage(INFORMATION, YESNO, "USER-1059") != 1 ){            
            return;             
        }  
        DS_IO_MASTER.ClearData();
    }
    
    getSearch();
    
}

/**
 * btn_New()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-21
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
     
     /*if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow,"SEQ_NO") == ""){
         if(showMessage(INFORMATION, YESNO, "GAUCE-1000", "공지사항이 등록 되지 않았습니다. <br> 새로 등록하시겠습니까?") != 1 ){
             return;
         }else{
             DS_IO_MASTER.DeleteRow(DS_IO_MASTER.CountRow);
             }
    }
     */
    // LC_IO_STRCD.Index = 0;
    // LC_I0_REGISTER.Index = 0;
     
	//if( LC_I0_REGISTER.BindColVal == "" ){
	
		
	//삭제 - 현업요청으로 	
	//if(DS_O_COMBOBUYER.CountRow == 0) {
    //    showMessage(STOPSIGN, OK, "USER-1000", "바이어 사번만 등록이 가능합니다.");
    //    LC_I0_REGISTER.Focus();
    //    return false;
    //}
     type = "Y";
     
     if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1) {//변경데이터 있을 시 확인
         var ret = showMessage(Question, YesNo, "USER-1049");
         if (ret == "1") {
             DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
             DS_IO_MASTER.AddRow();
         } else {
             return;
         }
     } else if  (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 3) {
         var ret = showMessage(Question, YesNo, "USER-1050");
         if (ret == "1") {
             rollBackRowData(DS_IO_MASTER, DS_IO_MASTER.RowPosition);
             DS_IO_MASTER.AddRow();
         } else {
             return;
         }
     } else {
         DS_IO_MASTER.AddRow();
     }
      
    DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "REG_DT") = getTodayFormat("yyyymmdd");
    EnableCheck("true");    
    LC_IO_STRCD.Index = 0;
    getComboBuyer();  //등록자 
    
    LC_I0_REGISTER.Index = 0;        
    RD_IO_AUTHORIZE.CodeValue = "1";
    LC_IO_STRCD.Focus();
    
    if(LC_I0_REGISTER.text == "마리오"){
    	LC_I0_REGISTER.Enable = "false";
    	RD_IO_AUTHORIZE.Enable = "false";
    }else{
    	LC_I0_REGISTER.Enable = "true";
    	RD_IO_AUTHORIZE.Enable = "true";
    }
}

/**
 * btn_Delete()
 * 작 성 자 : 오형규
 * 작 성 일 : 2010-03-21
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
    
    if( DS_IO_MASTER.CountRow == 0 ){
        showMessage(STOPSIGN, OK, "USER-1019");
        return;
    }
    
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition ,"AUTH") != "T" ){
    	 showMessage(INFORMATION, OK, "GAUCE-1000", "삭제 권한이 없습니다.");     
         return;
    }
    // 삭제 메세지 
    if(showMessage(Question, YESNO, "USER-1023") != 1)  return;
    
    if( DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition ,"SEQ_NO") == "" ){
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);        
        return;
    }
        
      var strCd     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition ,"STR_CD");
      var strSeq_no = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition ,"SEQ_NO");
      var strReg_dt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition ,"REG_DT");
          
      var goTo = "save";
      var paraments = "&seq_no="+ encodeURIComponent(strSeq_no)
                    + "&reg_dt="+ encodeURIComponent(strReg_dt) 
                    + "&strCd=" + encodeURIComponent(strCd) 
                    ;
      
      DS_IO_MASTER.UserStatus(DS_IO_MASTER.RowPosition)= 2;

      TR_MAIN.Action = "/mss/medi102.md?goTo=" + goTo + paraments + "&strFlg=delete"; 
      TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
      TR_MAIN.Post();
      
      getSearch();
}

/**
 * btn_Save()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-21
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    //저장 시  CanRowPosChange 이벤트 우회 flag
    g_saveFlag = true;
    var statusGubun = "";
    var saveSeardcnt = "";
    
    if( !DS_IO_MASTER.IsUpdated  ){
        showMessage(StopSign, OK, "USER-1028");
        return;
    }else {
        
        if( !VailCheckSave() ){ 
            g_saveFlag = false;
            return;
        }
        
        if (showMessage(STOPSIGN, YESNO, "USER-1010") != 1) return;
        var row = DS_IO_MASTER.RowPosition;
        if( DS_IO_MASTER.RowStatus(row) == 3 ){       //수정시 
            statusGubun = "2";
        }else if( DS_IO_MASTER.RowStatus(row) == 1 ) {    //신규시
            statusGubun = "1";
        }
        
        var em_date = getTodayFormat("yyyymmdd");
        
        var goTo = "save";
        var paraments = "&em_date="+ encodeURIComponent(em_date);
        TR_MAIN.Action = "/mss/medi102.md?strFlg=save&goTo=" + goTo + paraments; 
        TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
        
        if( statusGubun != "1" ){       //저장후 조회 수정 행으로 이동
            var posi_strcd = DS_IO_MASTER.NameValue(row, "STR_CD");
            var posi_seq_no = DS_IO_MASTER.NameValue(row, "SEQ_NO");
            var posi_regdt = DS_IO_MASTER.NameValue(row, "REG_DT");
            
            var g_currKey = posi_strcd + "||" + posi_seq_no + "||" + posi_regdt;
            saveSeardcnt = getNameValueRow(DS_IO_MASTER, "STR_CD||SEQ_NO||REG_DT",g_currKey);
            
            saveSearch(saveSeardcnt);
           
        }else {                         //신규 저장후 조회
            getSearch();
        }
        g_saveFlag = false;
    }
    g_saveFlag = false;
}
function saveSearch(row){
    
    
    if( !checkValidate() ) return;
    
    return;
    
    var strcd = LC_O_STRCD.BindColVal;
    var sDate = EM_S_DATE.Text;
    var eDate = EM_E_DATE.Text;
    var strTitle = EM_O_TITLE.Text;
    var strReadCnt = EM_O_READ_CNT.Text;
    var goTo = "getMaster";    
    var parameters = "&sDate="     + encodeURIComponent(sDate)
                   + "&eDate="     + encodeURIComponent(eDate)
                   + "&strTitle="  + encodeURIComponent(strTitle)
                   + "&strReadCnt="+ encodeURIComponent(strReadCnt)
                   + "&strcd="     + encodeURIComponent(strcd)
                   + "&userid="    + encodeURIComponent(userid);
            
    TR_MAIN.Action = "/mss/medi102.md?goTo="+goTo+parameters;
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", GD_MASTER);    
    DS_IO_MASTER.RowPosition = row;
    
    type = "N";
    
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
     
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * getSearch()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-21
  * 개    요 : 조회처리
  * return값 : void
  */
  
function getSearch(){
    
    if( !checkValidate() ) return;
    
    var strcd = LC_O_STRCD.BindColVal;
    var sDate = EM_S_DATE.Text;
    var eDate = EM_E_DATE.Text;
    var strTitle = EM_O_TITLE.Text;
    var strReadCnt = EM_O_READ_CNT.Text;
    
    var goTo = "getMaster";    
    var parameters = "&sDate="+ encodeURIComponent(sDate)
                   + "&eDate="+ encodeURIComponent(eDate) 
                   + "&strTitle="+ encodeURIComponent(strTitle)
                   + "&strReadCnt="+ encodeURIComponent(strReadCnt)
                   + "&strcd="+ encodeURIComponent(strcd)
                   + "&userid="+ encodeURIComponent(userid);
            
    TR_MAIN.Action = "/mss/medi102.md?goTo="+goTo+parameters;
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", GD_MASTER);
}
 
 /**
  * checkValidate()
  * 작 성 자 : 오형규
  * 작 성 일 : 2011.03.21
  * 개    요 : 값체크
  * return값 : ture / false
  */
 function checkValidate() {
     
     //시작, 종료일 일자체크
     var em_sdate = (trim(EM_S_DATE.Text)).replace(' ','');
     var em_edate = (trim(EM_E_DATE.Text)).replace(' ','');
     if (em_sdate.length < 8) {
         showMessage(STOPSIGN, OK, "USER-1003", "시작일");
         EM_S_DATE.Focus();
         return false;
     } else if (em_edate.length < 8) {
         showMessage(STOPSIGN, OK, "USER-1003", "종료일");
         EM_E_DATE.Focus();
         return false;
     }

     if (em_sdate > em_edate) { //시작일은 종료일보다 커야 합니다.
         showMessage(STOPSIGN, OK, "USER-1015");
         EM_S_DATE.Focus();
         return false;
     }

     return true;
 } 
 
/**
 * getComboBuyer()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011.03.21
 * 개    요 : 콤보 바이어코드 가져 오기
 * return값 :
 */
function getComboBuyer(value){
    var goTo = "getComboBuyer";
    var strcd = LC_IO_STRCD.BindColVal;

    if(value != "undefined" && value != null && value != ""){
		//noteid = value;
    	TR_S_MAIN.Action = "/mss/medi102.md?goTo="+goTo+"&userid="+encodeURIComponent(userid)+"&org_flag="+encodeURIComponent(org_flag)+"&strcd="+encodeURIComponent(strcd)+"&noteid="+encodeURIComponent(value);
	}else{
	    TR_S_MAIN.Action = "/mss/medi102.md?goTo="+goTo+"&userid="+encodeURIComponent(userid)+"&org_flag="+encodeURIComponent(org_flag)+"&strcd="+encodeURIComponent(strcd);
	}
    
    TR_S_MAIN.KeyValue="SERVLET(O:DS_O_COMBOBUYER=DS_O_COMBOBUYER)"; //조회는 O
    TR_S_MAIN.Post();
    
    LC_I0_REGISTER.Index = 0;
}
/**
 * EnableCheck()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011.03.21
 * 개    요 : Enable(활성화/비활성화)
 * return값 :
 */
function EnableCheck(Flag){
	 //alert(Flag);
    if( Flag == "true" ){
        LC_IO_STRCD.Enable = "true";
        LC_I0_REGISTER.Enable = "true";    
        EM_TITLE.Enable = "true";
        RD_IO_AUTHORIZE.Enable = "true";
        RD_IO_AUTHORIZE.Reset();
        TEXT_CALL_DESC_I.ReadOnly = false;
        enableControl(IMG_FILE_SELECT,true);
        enableControl(IMG_FILE_DEL,true);
    } else if( Flag == "false" ){
        LC_IO_STRCD.Enable = "false";
        EM_TITLE.Enable = "false";
        LC_I0_REGISTER.Enable = "false";
        RD_IO_AUTHORIZE.Enable = "false";
        RD_IO_AUTHORIZE.Reset();
        TEXT_CALL_DESC_I.ReadOnly = true;
        enableControl(IMG_FILE_SELECT,false);
        enableControl(IMG_FILE_DEL,false);
        
    } else if( Flag == "authcheckOk" ) {       //권한 체크 (T 일 경우 본인  권한)
        LC_IO_STRCD.Enable = "false";
        LC_I0_REGISTER.Enable = "false";
        EM_TITLE.Enable = "true";
        RD_IO_AUTHORIZE.Enable = "true";
        RD_IO_AUTHORIZE.Reset();
        TEXT_CALL_DESC_I.ReadOnly = false;
        enableControl(IMG_FILE_SELECT,true);
        enableControl(IMG_FILE_DEL,true);
        
    } else if( Flag == "authcheckNo" ){    //권한 체크 (F 일 경우 권한이 아닐 경우)
        LC_IO_STRCD.Enable = "false";
        LC_I0_REGISTER.Enable = "false";
        RD_IO_AUTHORIZE.Enable = "false";
        RD_IO_AUTHORIZE.Reset();
        EM_TITLE.Enable = "false";
        TEXT_CALL_DESC_I.ReadOnly = true;
        enableControl(IMG_FILE_SELECT,false);
        enableControl(IMG_FILE_DEL,false);
    }
	    
    if(LC_I0_REGISTER.text == "마리오"){
    	LC_I0_REGISTER.Enable = "false";
    	RD_IO_AUTHORIZE.Enable = "false";
    }else{
    	LC_I0_REGISTER.Enable = "true";
    	RD_IO_AUTHORIZE.Enable = "true";
    }
}

 /**
  * VailCheckSave()
  * 작 성 자 : 오형규
  * 작 성 일 : 2011.03.21
  * 개    요 : Enable(활성화/비활성화)
  * return값 : true / false
  */
  
function VailCheckSave(){
    
    for( i = 1; i <= DS_IO_MASTER.CountRow; i ++){
        if( DS_IO_MASTER.RowStatus(i) == 1 || DS_IO_MASTER.RowStatus(i) == 3 ){
            
            if( DS_IO_MASTER.NameValue(i, "STR_CD") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "점");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("STR_CD");
                GD_MASTER.Focus();
                return false;
            }
            
            if( DS_IO_MASTER.NameValue(i, "TITLE02") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "제목");
                DS_IO_MASTER.RowPosition = i;
                EM_TITLE.Focus();
                return false;
            }
            if( RD_IO_AUTHORIZE.CodeValue == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "권한");
                DS_IO_MASTER.RowPosition = i;
                RD_IO_AUTHORIZE.Focus();
                return false;
            }
            if( DS_IO_MASTER.NameValue(i, "CONTEN") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "내용");
                DS_IO_MASTER.RowPosition = i;
                TEXT_CALL_DESC_I.Focus();
                return false;
            }
            
            if( DS_IO_MASTER.NameValue(i, "BUYER_CD") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "등록자");
                DS_IO_MASTER.RowPosition = i;
                LC_I0_REGISTER.Focus();
                return false;
            }
            
        }
    }
    return true;
}
  /**
   * btn_repleAdd()
   * 작 성 자 : 오형규
   * 작 성 일 : 2011.04.01
   * 개    요 : 신규 후  이동 삭제, 수정후 이동 원래 데이타로 
   * return값 :
   */
function rollbackDate(row){
    
    if( DS_IO_MASTER.RowStatus(row) == 1 ){//신규시 로우 삭제
        DS_IO_MASTER.DeleteRow(row);
    }else if( DS_IO_MASTER.RowStatus(row) == 3 ){//수정시 데이타 이전 값으로 
        DS_IO_MASTER.NameValue(row, "TITLE02") = DS_IO_MASTER.OrgNameString(row, "TITLE02");
        DS_IO_MASTER.NameValue(row, "CONTEN") = DS_IO_MASTER.OrgNameString(row, "CONTEN");
        DS_IO_MASTER.NameValue(row, "AUTH_FLAG") = DS_IO_MASTER.OrgNameString(row, "AUTH_FLAG");
    }   
    
}

   
   
/**
 * openFile()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.07.20
 * 개    요 : 파일열기
 * return값 :
 */
function openFile() {
 	
   INF_FILEUPLOAD.Open();
   if (INF_FILEUPLOAD.SelectState) {
       var strFileInfo = INF_FILEUPLOAD.Value; //파일이름
       var tmpFileName = strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1);
       var strFileName = tmpFileName.substring(0, tmpFileName.lastIndexOf("."));
       var chrByre = checkLenByteStr(strFileName);
       var chrLen  = strFileName.length;
       
       if (chrByre != chrLen) {    // 파일명 한글
           showMessage(STOPSIGN, OK, "USER-1000", "파일명은 영문,숫자만으로 작성해주세요");
           return;
       } else if (chrByre > 100) {  // 파일명 100Byte이내작성
           showMessage(STOPSIGN, OK, "USER-1000", "파일명은 100Byte(영문,숫자100자)이내로 작성해주세요");
           return;
       } else { 
    	    
           if((1024 * 1024 * 5) < INF_FILEUPLOAD.FileInfo("size")){
               showMessage(STOPSIGN, OK, "USER-1000", "업로드파일의 사이즈는 5M 를 넘을 수 없습니다.");
               var strFlag = "";
               if (DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"FILE_PATH") != "") {
                   strFlag = "D";
               } else {
                   strFlag = "N";
               }
               DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = strFlag;    // 파일Flag
               DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = ""; // 경로명 표기
               DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_NAME") = "";
           } else {
               DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = "Y";   // 파일Flag
               DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = strFileInfo;
               DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_NAME") = tmpFileName;
               
           }
       }
   } 
} 

/**
 * saveAsFiles()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.07.20
 * 개    요 : 값체크(저장)
 * return값 :
 */
function saveAsFiles() {
     
   var strPath   = "upload/";    
   var strFileNm = DS_IO_MASTER.NameValue(DS_IO_MASTER.Rowposition, "OLD_FILE_NAME");       
   if( strFileNm != null  ) {                          
       iFrame.location.href="/mss/jsp/fileDownload.jsp?strPath="+strPath+"&strFileNm="+encodeURIComponent(strFileNm);
   }  
}

/**
 * deleteFile()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.03.05
 * 개    요 : 파일열기
 * return값 :
 */
function deleteFile() {
     var strFlag = "";
     if (DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"FILE_NAME") != "") {
         strFlag = "D";
     } else {
         strFlag = "N";
     }
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = strFlag;    // 파일Flag
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = "";   // 경로명 표기
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_NAME") = ""; // 경로명 표기
}

/**
 * checkLenByteStr()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.04.01
 * 개    요 : 문자열 Byte체크
 * return값 :
 */
function checkLenByteStr(str) {
    //byte체크
    var intByte = 0;
    for (k = 0; k < str.length; k++) {
        var onechar = str.charAt(k);
        if (escape(onechar).length > 4) {
            intByte += 2;
        } else {
            intByte++;
        }
    }
    return intByte;
}

</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_S_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_S_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_S_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_S_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>   

if(clickSORT) return;

if (row > 0) {
	
	
    if( DS_IO_MASTER.NameValue(row, "AUTH") == "T" ){
        EnableCheck("authcheckOk");
        EnableCheck("authcheckNo");
        
    }else {     
        EnableCheck("authcheckNo");
    }
	LC_I0_REGISTER.Enable = "false";
	RD_IO_AUTHORIZE.Enable = "false";
    //첨부파일 체크
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "OLD_FILE_NAME").length > 0) {
        enableControl(IMG_FILE_LINK,true);
    } else {
        enableControl(IMG_FILE_LINK,false);
    }
} else {
	enableControl(IMG_FILE_LINK,false);
}
	//alert(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUYER_CD"));
	//getComboBuyer(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUYER_CD"));
	getComboBuyer(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUYER_CD"));

</script>

<script language=JavaScript for=LC_IO_STRCD event=OnSelChange()>
    
    if( LC_IO_STRCD.Text != "" ){
    	getComboBuyer();
    }

</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(Row)>
// row변경 전
if (g_saveFlag) return;
if (DS_IO_MASTER.CountRow > 0) {
    // 선택 시 상세조회(선택 Row) 미사용
    
    if (type == "Y" && DS_IO_MASTER.IsUpdated) {// 컬럼변경전 변경데이터 있을 시 이동할것인지 확인
         var ret = showMessage(Question, YESNO, "USER-1049");
         if (ret == "1") {
            type = "N";
            rollbackDate(Row);     
            return true;
         }else {
            return false;
         }
   }
    return true;
}
return true;
</script>


<!--  GD_MASTER 소팅 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    
    if( row < 1 ){      
        sortColId( eval(this.DataID), row, colid);   
    }
    
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->

<script language=JavaScript for=EM_S_DATE event=onKillFocus()>
    //[조회용]시작일 체크
    checkDateTypeYMD( EM_S_DATE );
</script>

<script language=JavaScript for=EM_E_DATE event=onKillFocus()>
    //[조회용]종료일 체크
    checkDateTypeYMD( EM_E_DATE );
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_I_CONDITION  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_I_STR_CD  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BYBER"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_COMBOBUYER"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== ONLOAD용 -->


<!-- =============== 공통함수용 -->

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--------------------- 3. Fileupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_FILEUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
    <param name="FileFilterString"  value=1>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝  
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작 
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<iframe id=iFrame name=iFrame src="about:blank" width=0 height=0>
</iframe>
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
                <td><!-- search start -->
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width="80" class="POINT">점</th>
                        <td width="140">
                            <comment id="_NSID_"> 
                                <object id=LC_O_STRCD classid=<%=Util.CLSID_LUXECOMBO%> width=140  tabindex=1 align="absmiddle"> </object> 
                            </comment>
                            <script>_ws_(_NSID_);</script>                            
                        </td>
                        <th width="80" class="POINT">기간</th>
                        <td width="200">
                            <comment id="_NSID_"> 
                                <object id=EM_S_DATE classid=<%=Util.CLSID_EMEDIT%> width=70  tabindex=1 align="absmiddle"> </object> 
                            </comment>
                            <script>_ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DATE)" /> ~ 
                            <comment id="_NSID_">
                                <object id=EM_E_DATE  classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object> 
                            </comment><script>_ws_(_NSID_);</script> 
                            <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_E_DATE)" />
                        </td>
                        <th width="80">조회건수</th>
                         <td>
                         <comment id="_NSID_"> 
                             <object id=EM_O_READ_CNT classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1  align="absmiddle">
                                 
                             </object>
                         </comment>
                         <script>_ws_(_NSID_);</script>
                         </td> 
                    </tr>
                     <tr>
                         <th width="80">제목</th>
                         <td colspan="5">
                             <comment id="_NSID_"> 
                                 <object id=EM_O_TITLE classid=<%=Util.CLSID_EMEDIT%> width=683 tabindex=1 onkeyup="javascript:checkByteStr(this, 50, 'Y');"  align="absmiddle"> </object>
                             </comment>
                             <script>_ws_(_NSID_);</script>
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
    <tr>
        <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td><!-- search start -->
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  class="s_table">
                    <tr>
                        <th class="POINT" width="80">점</th>
                        <td width="140">
                            <comment id="_NSID_"> 
                                <object id=LC_IO_STRCD classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 align="absmiddle"> </object> 
                            </comment>
                            <script>_ws_(_NSID_);</script>                            
                        </td>
                        <th width="80" class="point">등록자</th>
                        <td width="200">
                            <comment id="_NSID_">
                                <object id=LC_I0_REGISTER classid=<%=Util.CLSID_LUXECOMBO%> width=200 tabindex=1  align="absmiddle"> </object>
                            </comment>
                            <script>_ws_(_NSID_);</script>
                         </td>
                        <th width="80" class="point">권한</th>
                        <td>
                            <comment id="_NSID_"> 
                                <object id=RD_IO_AUTHORIZE  classid=<%=Util.CLSID_RADIO%> width=141 tabindex=1 align="absmiddle">
                                    <param name=Cols    value="2">
                                    <param name=Format  value="1^전체,2^바이어">
                                    <param name=CodeColumn value="AUTH_FLAG">
                                    <param name=CodeValue  value="1">
                                </object> 
                            </comment>
                            <script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th class="point" width="80">제목</th>
                        <td colspan="5">
                            <comment id="_NSID_">
                                <object id=EM_TITLE classid=<%=Util.CLSID_EMEDIT%> width=685 tabindex=1 onkeyup="javascript:checkByteStr(this, 50, 'Y');" align="absmiddle">
                                </object> 
                            </comment>
                            <script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th class="point" width="80">내용</th>
                        <td colspan="5">
                            <comment id="_NSID_">
                                <object id=TEXT_CALL_DESC_I classid=<%=Util.CLSID_TEXTAREA%> onkeyup="checkByteStr(this, 4000, 'Y');" height=185   width=685 tabindex=1 > 
                                </object>
                            </comment>
                            <script>_ws_(_NSID_);</script>
                        </td>
                    </tr>  
                    <tr>
                        <th class="point" width="80">첨부파일</th>
						<td colspan="5"><comment id="_NSID_"> <object
							id=EM_FILE_NAME classid=<%=Util.CLSID_EMEDIT%> width=495
							tabindex=1 onkeyup="javascript:checkByteStr(this, 50, 'Y');"
							align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script> <img
							id="IMG_FILE_SELECT" src="/<%=dir%>/imgs/btn/file_search.gif"
							class="PR03" onclick="javascript:openFile();" align="absmiddle" />
						<img id="IMG_FILE_LINK" style="vertical-align: middle;"
							onclick="javascript:saveAsFiles();"
							src="/<%=dir%>/imgs/btn/file_down.gif" /> <img id="IMG_FILE_DEL"
							style="vertical-align: middle;"
							onclick="javascript:deleteFile();"
							src="/<%=dir%>/imgs/btn/file_del.gif" /></td>
					</tr>               
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td ></td>
    </tr>
    <tr valign="top">
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td width="100%"><comment id="_NSID_"><OBJECT
                            id=GD_MASTER width=100% height=215 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_MASTER">
                        </OBJECT></comment><script>_ws_(_NSID_);</script></td>
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
<object id=BD_IO_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>Col=STR_CD           Ctrl=LC_IO_STRCD           param=BindColVal</c>
        <c>Col=TITLE02          Ctrl=EM_TITLE              param=Text</c>
        <c>Col=BUYER_CD         Ctrl=LC_I0_REGISTER        param=BindColVal</c>
        <c>Col=CONTEN           Ctrl=TEXT_CALL_DESC_I      param=Text</c>        
        <c>Col=AUTH_FLAG        Ctrl=RD_IO_AUTHORIZE       param=CodeValue</c>
        <c>Col=FILE_NAME        Ctrl=EM_FILE_NAME          param=Text</c>        
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

