<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 >  협력사EDI >  협력사EDI 커뮤니티 > 협력사EDI 게시판
 * 작 성 일 : 2011.03.25
 * 작 성 자 : 오형규
 * 수 정 자 : 
 * 파 일 명 : medi1040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 협력사에 게시글을 등록하고 댓글을 등록 한다.
 * 이    력 :
 *        
          2011.03.25 (오형규) 신규작성
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
    SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");    
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
var strBuyercd="";                  //바이어코드
var buyerNm="";                        //바이어명
var gubunFlag;
var pubumCnt = 0;
var g_currKey = "";
var nowRow=0;
var rowGb = "0";

var g_saveFlag = false;
<!--

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
   
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');//마스터
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_PUMBENNM"/>');//상세
    DS_O_BUYER.setDataHeader('<gauce:dataset name="H_BUYER"/>');//바이어코드
    DS_O_BORADAUTH.setDataHeader('<gauce:dataset name="H_BORADAUTH"/>');//
    DS_O_COMBOBUYER.setDataHeader('<gauce:dataset name="H_COMBOBUYER"/>');//
    
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DATE,  "SYYYYMMDD", PK);               // [조회용]시작 기간일
    initEmEdit(EM_E_DATE,  "TODAY", PK);               // [조회용]종료 기간일   
    initEmEdit(EM_O_READ_CNT,  "NUMBER3^3", NORMAL);         // [조회용]조회건수
    initEmEdit(EM_O_TITLE,  "GEN", NORMAL);         // [조회용]제목
    
    initEmEdit(EM_TITLE,  "GEN", NORMAL);              // 제목
    initEmEdit(EM_I0_BUYERNM,  "GEN", NORMAL);        //바이어코드    
    initTxtAreaEdit(TXT_CONTENT, NORMAL);              //내용
     
    initComboStyle(EM_O_STR_CD, DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);              //점(조회)
    initComboStyle(LC_I0_STRCD, DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);              //점
    initComboStyle(LC_I0_BUYER, DS_O_COMBOBUYER, "BUYER_CD^0^50, BUYER_NM^0^150", 1, PK); //바이어코드
    
    getStore("DS_O_STR_CD", "Y", "1", "N");            //점코드
    
    EM_O_STR_CD.Index = 0;
    EM_O_READ_CNT.Text = "100";
    LC_I0_BUYER.Index = 0;
    EM_O_STR_CD.Focus();
    
    enableCheck("doin");
    
    btn_Search();
    
    
    registerUsingDataset("medi104","DS_IO_MASTER,DS_IO_DETAIL,DS_O_BUYER,DS_O_BORADAUTH");
}

function gridCreate(){      
       
     var hdrProperies = ''
         + '<FC>ID={CURROW}        NAME="NO"       WIDTH=30    ALIGN=CENTER</FC>'
         + '<FC>ID=STR_CD          NAME="점"       WIDTH=100    ALIGN=LEFT SHOW=FALSE </FC>'
         + '<FC>ID=STRNM           NAME="점"       WIDTH=100    ALIGN=LEFT Data="DS_I_STR_CD:CODE:NAME"</FC>'
         + '<FC>ID=REG_SEQ_NO      NAME="순번"     WIDTH=50    ALIGN=center  </FC>'
         + '<FC>ID=REG_DT          NAME="일자"     WIDTH=80    ALIGN=center  MASK="XXXX/XX/XX" </FC>'
         + '<FC>ID=TIMES           NAME="시간"     WIDTH=65    ALIGN=center MASK="XX:XX" </FC>'
         + '<FC>ID=TITLE           NAME="제목"     WIDTH=270    ALIGN=LEFT  </FC>'
         + '<FC>ID=BUYER_CODE      NAME="바이어코드"    WIDTH=270    ALIGN=LEFT SHOW=FALSE  </FC>'
         + '<FC>ID=BUYER_NM        NAME="등록자"   WIDTH=100   ALIGN=left  </FC>'             
         + '<FC>ID=READ_CNT        NAME="조회수"   WIDTH=90   ALIGN=right Edit=Numeric </FC>'
         + '<FC>ID=TITLE01         NAME="제목"       WIDTH=100    ALIGN=LEFT SHOW=FALSE </FC>'
         + '<FC>ID=BUYER_NM01      NAME="등록자"       WIDTH=100    ALIGN=LEFT SHOW=FALSE </FC>'               
         + '<FC>ID=CONTNES         NAME="내용"       WIDTH=100    ALIGN=LEFT SHOW=FALSE </FC>'
         + '<FC>ID=AUTH_FLAG       NAME="구분"       WIDTH=100    ALIGN=LEFT SHOW=FALSE </FC>';               
     initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
  
}

function gridCreate1(){      
    
    var hdrProperies = ''
        + '<FC>ID=PUMBUN_YN       NAME=""  WIDTH=20 EDITSTYLE=CHECKBOX  HEADCHECKSHOW=TRUE align=center </FC>'
        + '<FC>ID=PUMBUN_NAME       NAME="브랜드명"       WIDTH=100  align=left    Edit="None"  </FC>';               
    initGridStyle(GD_DETAIL, "COMMON", hdrProperies, true);
    //GD_DETAIL.ColumnProp("PUMBUN_YN","HeadAlign") = "center";

 
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
    if( EM_O_STR_CD.Text == "" ){
        showMessage(INFORMATION, OK, "USER-1001", "점");
        EM_O_STR_CD.Focus();
        return;
    }
    if( EM_S_DATE.Text.length == 0 ){
        showMessage(INFORMATION, OK, "USER-1001", "시작기간일");
        EM_S_DATE.Focus();
        return;
    }
    if( EM_E_DATE.Text == 0 ){
        showMessage(INFORMATION, OK, "USER-1001", "종료기간일");
        EM_E_DATE.Focus();
        return;
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
     
	if( pubumCnt < 1 ){
        showMessage(QUESTION , OK, "GAUCE-1000", "바이어권한이 없습니다.");
        return;
    }
    /* 
    if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow,"STR_CD") == "" ){
        
        var ret = showMessage(STOPSIGN, YesNo, "USER-1072");
        if (ret != "1") { 
            return;
        }else {
            DS_IO_MASTER.DeleteRow(DS_IO_MASTER.CountRow);
        }
    }
    */
    
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
        GD_DETAIL.ColumnProp("PUMBUN_YN","Edit")="";
        
    }
    
   // DS_IO_MASTER.AddRow();
    
    gubunFlag = "1";     
    DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "REG_DT") = getTodayFormat("yyyymmdd");
    DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "BUYER_NM") = buyerNm;
    DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "AUTH_FLAG") = "2";
    
    LC_I0_STRCD.Focus();
    
    enableCheck("boradOk"); // 게시판 신규 생성시
    LC_I0_STRCD.Focus();
     
    
}

/**
 * btn_Delete()
 * 작 성 자 : 오형규
 * 작 성 일 : 2010-03-21
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
    
    
}
/**
 * saveBoard(row)
 * 작 성 자 : 오형규
 * 작 성 일 : 2010-03-21
 * 개    요 : 게시판 등록, 수정
 * return값 : void
 */
function saveBoard(row){
    
    var board_strcd    = DS_IO_MASTER.NameValue(row, "STR_CD");       //점
    var board_regdt    = DS_IO_MASTER.NameValue(row, "REG_DT");       //등록일자
    var board_regSeqno = DS_IO_MASTER.NameValue(row, "REG_SEQ_NO");   //순번
    var board_buyercd  = DS_IO_MASTER.NameValue(row, "BUYER_CODE");   //바이어코드
    
    var goTo = "saveVBoard";
    
    if( DS_IO_DETAIL.IsUpdated ){              //브랜드  권한
    
        var auth_strcd = DS_IO_MASTER.NameValue(row, "STR_CD");
        var auth_regdt = DS_IO_MASTER.NameValue(row, "REG_DT");
        var auth_seqno = DS_IO_MASTER.NameValue(row, "REG_SEQ_NO");
        var auth_buyercd = DS_IO_MASTER.NameValue(row, "BUYER_CODE");
        
    }
    
    TR_MAIN.Action = "/mss/medi104.md?goTo=" + goTo + "&strcd="     + encodeURIComponent(board_strcd)
                                                    + "&regdt="     + encodeURIComponent(board_regdt)
                                                    + "&regSeqno="  + encodeURIComponent(board_regSeqno)
                                                    + "&buyercd="   + encodeURIComponent(board_buyercd)
                                                    + "&auth_regdt="+ encodeURIComponent(auth_regdt)
                                                    + "&auth_seqno="+ encodeURIComponent(auth_seqno)
                                                    + "&auth_buyercd="+ encodeURIComponent(auth_buyercd)
                                                    + "&auth_strcd="+ encodeURIComponent(auth_strcd);
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_MAIN.Post();    
    
    
    
}
/**
 * saveReply(row)
 * 작 성 자 : 오형규
 * 작 성 일 : 2010-03-21
 * 개    요 : 답변글 등록, 수정
 * return값 : void
 */
function saveReply(row){
	 
    var reply_regdt = DS_IO_MASTER.NameValue(row-1, "REG_DT");             //등록일자
    var reply_seqNo = DS_IO_MASTER.NameValue(row-1, "REG_SEQ_NO");         //순번
    var reply_buyercd = DS_IO_MASTER.NameValue(row-1, "BUYER_CODE");       //바이어코드
    
    var goTo = "saveReply";
    
    TR_MAIN.Action = "/mss/medi104.md?goTo=" + goTo + "&regdt="+encodeURIComponent(reply_regdt)+"&seqNo="+encodeURIComponent(reply_seqNo)+"&buyercd="+encodeURIComponent(reply_buyercd); 
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MAIN.Post();
    
}
/**
 * btn_Save()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-21
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    g_saveFlag = true;
    
    if( !DS_IO_MASTER.IsUpdated  &&  !DS_IO_DETAIL.IsUpdated ){
        showMessage(StopSign, OK, "USER-1028");
        return;
    }else {
        var posi_strcd = "";
        var posi_seq_no = "";
        var posi_regdt = "";
        var saveGubun = "";
        var saveSeardcnt;
        
        var row = DS_IO_MASTER.RowPosition;
        
        if( !VailCheckSave() ) {
            g_saveFlag = false;
            return;
        }
          
        if (showMessage(STOPSIGN, YESNO, "USER-1010") != 1) return;
        
        
        if( DS_IO_MASTER.RowStatus(row) == 1  ){    //신규 등록시 게시판 또는 답변글 구분
            DS_IO_MASTER.NameValue(row, "GB") = gubunFlag;
            saveGubun = "1";//신규
        }else if( DS_IO_MASTER.RowStatus(row) == 3 ){
            saveGubun = "2";//수정
        }
        if( DS_IO_MASTER.NameValue(row, "GB") == "1" ){             //게시판 등록시
            
            saveBoard(row);
            
        }else {                                                     //답변글 등록시
            saveReply(row);
        }
        if(saveGubun != "1"){
            posi_strcd = DS_IO_MASTER.NameValue(row, "STR_CD");
            posi_seq_no = DS_IO_MASTER.NameValue(row, "REG_SEQ_NO");
            posi_regdt = DS_IO_MASTER.NameValue(row, "REG_DT");
            posi_reply_seqNo = DS_IO_MASTER.NameValue(row, "REPL_SEQ_NO");
            
            g_currKey = posi_strcd + "||" + posi_seq_no + "||" + posi_regdt + "||" + posi_reply_seqNo;
            saveSeardcnt = getNameValueRow(DS_IO_MASTER, "STR_CD||REG_SEQ_NO||REG_DT||REPL_SEQ_NO",g_currKey);
            
            getSaveSearch(saveSeardcnt);
       }else {
    	   if(DS_IO_MASTER.NameValue(row, "GB") == "1"){
    		   getSearch();
    	   } else {
    		   posi_strcd = DS_IO_MASTER.NameValue(row, "STR_CD");
               posi_seq_no = DS_IO_MASTER.NameValue(row, "REG_SEQ_NO");
               posi_regdt = DS_IO_MASTER.NameValue(row, "REG_DT");
               posi_reply_seqNo = DS_IO_MASTER.NameValue(row, "REPL_SEQ_NO");
               
               g_currKey = posi_strcd + "||" + posi_seq_no + "||" + posi_regdt + "||" + posi_reply_seqNo;
               saveSeardcnt = getNameValueRow(DS_IO_MASTER, "STR_CD||REG_SEQ_NO||REG_DT||REPL_SEQ_NO",g_currKey);
               
               getSaveSearch(saveSeardcnt);
    	   }
    	   
       }
       
    }
    g_saveFlag = false;
}

function getSaveSearch(row){
        
    if( !checkValidate() ) return;
    
    var strCd = EM_O_STR_CD.BindColVal;
    var sDate = EM_S_DATE.Text;
    var eDate = EM_E_DATE.Text;
    var readCnt = EM_O_READ_CNT.Text;
    var strTitle = EM_O_TITLE.Text;
    
    var goTo = "getMaster";
    
    TR_S_MAIN.Action = "/mss/medi104.md?goTo="+goTo
                                           +"&strCd="   + encodeURIComponent(strCd)
                                           +"&sDate="   + encodeURIComponent(sDate)
                                           +"&eDate="   + encodeURIComponent(eDate)
                                           +"&readCnt=" + encodeURIComponent(readCnt)
                                           +"&strTitle="+ encodeURIComponent(strTitle)
                                           +"&userid="  + encodeURIComponent(userid)
                                           +"&buyer="   + encodeURIComponent(strBuyercd);
    TR_S_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_S_MAIN.Post();
    
    setPorcCount("SELECT", GD_MASTER);
    DS_IO_MASTER.RowPosition = row;
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
  * 작 성 일 : 2011-03-28
  * 개    요 : 조회처리
  * return값 : void
  */
  
function getSearch(){
      
    if( DS_IO_MASTER.IsUpdated ){ 
        if(showMessage(INFORMATION, YESNO, "USER-1059") != 1 ){            
            return;             
        }  
        DS_IO_MASTER.ClearData();
    }
    
     if( !checkValidate() ) return;
     var strCd = EM_O_STR_CD.BindColVal;
     var sDate = EM_S_DATE.Text;
     var eDate = EM_E_DATE.Text;
     var readCnt = EM_O_READ_CNT.Text;
     var strTitle = EM_O_TITLE.Text;
     
     var goTo = "getMaster";
     TR_S_MAIN.Action = "/mss/medi104.md?goTo="+goTo
                                            +"&strCd="   +encodeURIComponent(strCd)
                                            +"&sDate="   +encodeURIComponent(sDate)
                                            +"&eDate="   +encodeURIComponent(eDate)
                                            +"&readCnt=" +encodeURIComponent(readCnt)
                                            +"&strTitle="+encodeURIComponent(strTitle)
                                            +"&userid="+  encodeURIComponent(userid)
                                            +"&buyer="+   encodeURIComponent(strBuyercd);
     TR_S_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
     TR_S_MAIN.Post();     
     
     
     
     setPorcCount("SELECT", GD_MASTER);
    
    
}
 
 /**
  * checkValidate()
  * 작 성 자 : 오형규
  * 작 성 일 : 2011.03.28
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
  * getBuyer_id()
  * 작 성 자 : 오형규
  * 작 성 일 : 2011.03.28
  * 개    요 : 바이어코드 가져 오기
  * return값 :
  */
function getBuyer_id(){
    
    if( userid != null || userid != "" ){
        
        var goTo = "getBuyerCd";
                
        TR_MAIN.Action = "/mss/medi104.md?goTo="+goTo+"&userid="+encodeURIComponent(userid);
        TR_MAIN.KeyValue="SERVLET(O:DS_O_BUYER=DS_O_BUYER)"; //조회는 O
        TR_MAIN.Post();
                
        if( DS_O_BUYER.CountRow > 0 ){
            strBuyercd = DS_O_BUYER.NameValue(1, "BUYER_CD");
            buyerNm    = DS_O_BUYER.NameValue(1, "BUYER_NM");   
        }else {
            strBuyercd = "";
            buyerNm = "";
        }
        getPumben();
        
    }
}

/**
 * getPumben()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011.03.28
 * 개    요 : 브랜드명 가져 오기
 * return값 :
 */
 
function getPumben(strcd,buyercd){
    
    var goTo = "getPumben";
    
    TR_MAIN.Action = "/mss/medi104.md?goTo="+goTo+"&Buyercd="+encodeURIComponent(buyercd)+"&strcd="+encodeURIComponent(strcd);
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_MAIN.Post();
} 

/**
 * enableCheck()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011.03.28
 * 개    요 : 활성화, 비활성화
 * return값 :
 */
 
function enableCheck(flag){
    if( flag == "doin" ){      //등록부 기본 세팅
        
        LC_I0_STRCD.Enable = "false";
        LC_I0_BUYER.Enable = "false";
        EM_TITLE.Enable = "false";
        EM_I0_BUYERNM.Enable = "false";
        TXT_CONTENT.Enable = "false";
        //RD_IO_AUTHORIZE.Enable = "false";     
        //RD_IO_AUTHORIZE.CodeValue = "2";
        LC_I0_STRCD.Index = 0;
        //RD_IO_AUTHORIZE.Enable = "false";
        //RD_IO_AUTHORIZE.Reset();
        GD_DETAIL.Enable = "false";
    } else if( flag == "enableOk" ){   //게시판 본인 글일 경우
        LC_I0_STRCD.Enable = "false";
        EM_I0_BUYERNM.Enable = "false";
        LC_I0_BUYER.Enable = "false";
        EM_TITLE.Enable = "true";
        TXT_CONTENT.Enable = "true";        
        //RD_IO_AUTHORIZE.Enable = "true";
        //RD_IO_AUTHORIZE.Reset();
        GD_DETAIL.Enable = "true";
    } else if( flag == "enableNo"){   //게시판 본인 글이 아닐 경우
        LC_I0_STRCD.Enable = "false";
        EM_I0_BUYERNM.Enable = "false";
        LC_I0_BUYER.Enable = "false";
        EM_TITLE.Enable = "false";
        TXT_CONTENT.Enable = "false";
        //RD_IO_AUTHORIZE.Enable = "false";
        //RD_IO_AUTHORIZE.Reset();
        GD_DETAIL.Enable = "false";
        
    } else if( flag == "repleNew" ){    //댓글 신규 생성 되었을 경우  
        
        LC_I0_STRCD.Enable = "false";
        EM_I0_BUYERNM.Enable = "false";
        LC_I0_BUYER.Enable = "true";
        EM_TITLE.Enable = "true";
        TXT_CONTENT.Enable = "true";
        LC_I0_STRCD.Index = 0;
        LC_I0_BUYER.Index = 0;
        //EM_I0_BUYERNM.Text = buyerNm; 등록자 정보
        //RD_IO_AUTHORIZE.CodeValue = "2";
        //RD_IO_AUTHORIZE.Enable = "false";
        //RD_IO_AUTHORIZE.Reset();
        GD_DETAIL.Enable = "false";
        
    } else if( flag == "boradOk" ){        //신규 생성시
        
        LC_I0_STRCD.Enable = "true";
        EM_TITLE.Enable = "true";
        EM_I0_BUYERNM.Enable = "false";
        TXT_CONTENT.Enable = "true";
        LC_I0_BUYER.Enable = "true";
        LC_I0_STRCD.Index = 0;        
        LC_I0_BUYER.Index = 0;
        //RD_IO_AUTHORIZE.CodeValue = "2";
        //RD_IO_AUTHORIZE.Enable = "true";
        //RD_IO_AUTHORIZE.Reset();
        GD_DETAIL.Enable = "true";
        
    } else if( flag == "replyCheckOK" ){   //댓글 본인 글 경우
        
        LC_I0_STRCD.Enable = "false";
        EM_I0_BUYERNM.Enable = "false";
        LC_I0_BUYER.Enable = "false";
        EM_TITLE.Enable = "true";
        TXT_CONTENT.Enable = "true";
        //RD_IO_AUTHORIZE.Enable = "false";
        //RD_IO_AUTHORIZE.Reset();
        GD_DETAIL.Enable = "false";
        
    } else if( flag == "replyCheckNO" ){       //댓글 본인 글이 아닐경우
                
        LC_I0_STRCD.Enable = "false";
        EM_I0_BUYERNM.Enable = "false";
        LC_I0_BUYER.Enable = "false";
        EM_TITLE.Enable = "false";
        TXT_CONTENT.Enable = "false";
        //RD_IO_AUTHORIZE.Enable = "false";
        //RD_IO_AUTHORIZE.Reset();
        GD_DETAIL.Enable = "false";
        
    } else if( flag == "authCheck" ){ //권한체크
        /*
        LC_I0_STRCD.Enable = "false";
        //EM_I0_BUYERNM.Enable = "false";
        EM_TITLE.Enable = "false";
        TXT_CONTENT.Enable = "false";
        //RD_IO_AUTHORIZE.CodeValue = "2";
        //RD_IO_AUTHORIZE.Enable = "false";
        //RD_IO_AUTHORIZE.Reset();
        GD_DETAIL.Enable = "false";
        */
    }else if( flag == "authCheckOK" ){ //권한체크
        /*
        LC_I0_STRCD.Enable = "true";
        //EM_I0_BUYERNM.Enable = "false";
        EM_TITLE.Enable = "true";
        TXT_CONTENT.Enable = "true";
        //RD_IO_AUTHORIZE.CodeValue = "2";
        //RD_IO_AUTHORIZE.Enable = "true";
        //RD_IO_AUTHORIZE.Reset();
        GD_DETAIL.Enable = "true";
        */
    }
    
    
}
 
function VailCheckSave(){
    for( i = 1; i <= DS_IO_MASTER.COuntRow; i++ ){
        if( DS_IO_MASTER.RowStatus(i) == 1 ||  DS_IO_MASTER.RowStatus(i) == 3 ){
            if( DS_IO_MASTER.NameValue(i, "STR_CD") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "점");
                LC_I0_STRCD.Focus();
                return false;   
            }
            
            if( DS_IO_MASTER.NameValue(i, "TITLE01") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "제목");
                EM_TITLE.Focus();
                return false;   
            }
            
            if( DS_IO_MASTER.NameValue(i, "CONTNES") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "내용");
                TXT_CONTENT.Focus(); 
                return false;   
            }
        }
    }
    var De_PU_ChYN = 0;
    for( i = 1; i <= DS_IO_DETAIL.CountRow; i++ ){
    	if( DS_IO_DETAIL.NameValue(i, "PUMBUN_YN") == "T" ){
    		De_PU_ChYN++;
    	}
    }
    
    if( DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "AUTH_FLAG") != "" && De_PU_ChYN < 1  ){              //브랜드  권한
        
        showMessage(QUESTION , OK, "GAUCE-1000", "선택된 브랜드가 없습니다.");
        detailChcnt = 0;
        return;
    }
    
    /*
    if( DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "AUTH_FLAG") != "" && !DS_IO_DETAIL.IsUpdated  ){              //브랜드  권한
        
        showMessage(QUESTION , OK, "GAUCE-1000", "선택된 브랜드가 없습니다.");
        detailChcnt = 0;
        return;
    }
    */
    
    
    return true;
}

 /**
  * getBoardAuth()
  * 작 성 자 : 오형규
  * 작 성 일 : 2011.04.01
  * 개    요 : 브랜드 권한  확인
  * return값 :
  */
function getBoardAuth(row){
    var regDt = DS_IO_MASTER.NameValue(row, "REG_DT");                 //등록일자   
    var regSeqno = DS_IO_MASTER.NameValue(row, "REG_SEQ_NO");          //등록순번
    var buyercd = DS_IO_MASTER.NameValue(row, "BUYER_CODE");          //등록순번
    var strcd = DS_IO_MASTER.NameValue(row, "STR_CD");
    
    var goTo = "getboardauth";
    
    TR_MAIN.Action = "/mss/medi104.md?goTo="+goTo+"&regDt="+encodeURIComponent(regDt)+"&Seqno="+encodeURIComponent(regSeqno)+"&buyercd="+encodeURIComponent(buyercd)+"&strcd="+encodeURIComponent(strcd);
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_MAIN.Post();
    
    var detailCount = DS_IO_DETAIL.CountRow;
    var count = 0;
}

/**
 * btn_repleAdd()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011.04.01
 * 개    요 : 댓글 로우 생성
 * return값 :
 */
function btn_repleAdd(){
    if( pubumCnt < 1  ){
        showMessage(INFORMATION , OK, "GAUCE-1000", "바이어권한이 없습니다.");
        return;
    }
     
    var row = DS_IO_MASTER.RowPosition;
    
    if( DS_IO_MASTER.NameValue(row, "REPL_DT") == "" && DS_IO_MASTER.NameValue(row, "REPL_SEQ_NO") == 0 
            && DS_IO_MASTER.NameValue(row, "AUTH_FLAG") != "" ){
 
        DS_IO_MASTER.InsertRow(row+1);
        gubunFlag = "2";
        enableCheck("repleNew");
        LC_I0_BUYER.Focus();
        nowRow = DS_IO_MASTER.RowPosition;
        //alert("now Row : " + nowRow);
    }else {
        return;
    }
}
/**
 * btn_repleAdd()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011.04.01
 * 개    요 : 신규 후  이동 삭제, 수정후 이동 원래 데이타로 
 * return값 :
 
function rollbackDate(row){
    if( DS_IO_MASTER.RowStatus(row) == 1 ){//신규시 로우 삭제
        
        if( DS_IO_MASTER.NameValue(row, "REPL_DT") == "" && DS_IO_MASTER.NameValue(row, "REPL_SEQ_NO") == "0"  &&
                DS_IO_MASTER.NameValue(row, "AUTH_FLAG") != "" ){
                    DS_IO_MASTER.DeleteRow(row);
        }else {
               rowGb = "1";
               nowRow = row;
        }
        
    }else if( DS_IO_MASTER.RowStatus(row) == 3 ){//수정시 데이타 이전 값으로 
        
        DS_IO_MASTER.NameValue(row, "TITLE01") = DS_IO_MASTER.OrgNameString(row, "TITLE01");
        DS_IO_MASTER.NameValue(row, "CONTNES") = DS_IO_MASTER.OrgNameString(row, "CONTNES");
        DS_IO_MASTER.NameValue(row, "AUTH_FLAG") = DS_IO_MASTER.OrgNameString(row, "AUTH_FLAG");
    }   
}
 */
 
function getComboBuber(){
    var strcd = LC_I0_STRCD.BindColVal;
    
    var goTo = "comboBuber";
    
    TR_MAIN.Action = "/mss/medi104.md?goTo="+goTo+"&userid="+encodeURIComponent(userid)+"&org_flag="+encodeURIComponent(org_flag)+"&strcd="+encodeURIComponent(strcd);
    TR_MAIN.KeyValue="SERVLET(O:DS_O_COMBOBUYER=DS_O_COMBOBUYER)"; //조회는 O
    TR_MAIN.Post();
    
    if( DS_O_COMBOBUYER.CountRow > 0 ){
        pubumCnt = DS_O_COMBOBUYER.CountRow; 
    }
}
 -->
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
    for(i=1;i<TR_S_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_S_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>


<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->


<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->

<script language=JavaScript for=EM_S_DATE event=onKillFocus()>
    //[조회용]시작일 체크
    checkDateTypeYMD( EM_S_DATE );
</script>

<script language=JavaScript for=EM_E_DATE event=onKillFocus()>
    //[조회용]종료일 체크
    checkDateTypeYMD( EM_E_DATE );
</script>

<script language=JavaScript for=LC_I0_BUYER event=OnSelChange()>
   var strcd = LC_I0_STRCD.BindColVal;
   var buyercd = LC_I0_BUYER.BindColVal;
   
   if( DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REG_SEQ_NO") != "" ){
       
       return;
   }else {
       
      getPumben(strcd,buyercd);
   }
</script>

<script language="javascript"  for=GD_MASTER event=OnClick(Row,Colid)>

   
    if( DS_IO_MASTER.CountRow > 0 ){
   
    
    if( nowRow > 0 && nowRow != Row ){
        
   
        if( nowRow < Row ){
            
            //var delRow = nowRow;
            //DS_IO_MASTER.DeleteRow(delRow);
            //alert("aa DS_IO_MASTER.RowPosition : " + row);
            nowRow = 0;
            DS_IO_MASTER.RowPosition = Row-1;
            GD_MASTER.Focus();
            //setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "STR_CD");
            //GD_MASTER.Focus();
            
        }
        return;
    }
    
}
</script>


<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(Row)>
    
//alert("CanRowPosChange===="+Row);
if( Row < 1 )  return;
    
   
// row변경 전

if( !g_saveFlag ){
    
    if (DS_IO_MASTER.CountRow > 0) {
        if( DS_IO_MASTER.RowStatus(Row) == 1 ){       //신규 일때
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
                //DS_IO_MASTER.DeleteRow(Row);
                DS_IO_MASTER.UndoAll();
                return true;    
            } else {
                return false;   
            }
        }else if( DS_IO_MASTER.RowStatus(Row) == 3 ){
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
                //rollBackRowData(DS_IO_MASTER, Row);
                DS_IO_MASTER.UndoAll();
                
                return true;    
            } else {
                return false;   
            }
        }
        return true;
    }
    return true;
}
</script>
 
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    if(clickSORT) return;
    
    if( DS_IO_MASTER.CountRow > 0 ){
    	
        if( DS_IO_MASTER.NameValue(row, "REPL_DT") == "" && DS_IO_MASTER.NameValue(row, "REPL_SEQ_NO") == "0"  &&
                DS_IO_MASTER.NameValue(row, "AUTH_FLAG") != ""){    //게시판
            
            getBoardAuth(row);//브랜드 권한 정보 가져오기
            enableControl(a_reply,true);
            GD_DETAIL.ColumnProp("PUMBUN_YN","Edit") = "";
            //게시판 권한 활성화
            if( DS_IO_MASTER.NameValue(row, "AUTH") != "T" ){
                
                enableCheck("enableNo");//본인 글일 경우
            }else {
                enableCheck("enableOk");//본인 글이 아닐 경우
            }
            
        }else { // 댓글
            //enableCheck("replyCheck");//본인 글이 아닐 경우
            
            getPumben(DS_IO_MASTER.NameValue(row, "STR_CD"), DS_IO_MASTER.NameValue(row, "BUYER_CODE"));
            	
            GD_DETAIL.ColumnProp("PUMBUN_YN","Edit")="None";
            enableControl(a_reply,false);
           
            //댓글 권한 활성화
            if( DS_IO_MASTER.NameValue(row, "AUTH") != "T" ){
                
                enableCheck("replyCheckNO");//본인 글일 경우
            }else {
                
                enableCheck("replyCheckOK");//본인 글이 아닐 경우
            }
            
        }
        
    }
</script>

<script language="javascript"  for=GD_DETAIL event=OnHeadCheckClick(Col,Colid,bCheck)>

    if( DS_IO_DETAIL.CountRow > 0 ){
        if( bCheck != 0 ){
            for( i = 1; i <= DS_IO_DETAIL.CountRow; i++ ){
                DS_IO_DETAIL.NameValue(i, Colid) = "T";
            }
        }else {
            for( i = 1; i <= DS_IO_DETAIL.CountRow; i++ ){
                DS_IO_DETAIL.NameValue(i, Colid) = "F";
            }
        }   
    }    

</script>
 
<script language=JavaScript for=LC_I0_STRCD event=OnSelChange()>
    
    if( LC_I0_STRCD.Text != "" ){
        getComboBuber();
    }

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

<comment id="_NSID_"><object id=DS_I_CONDITION  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BUYER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_COMBOBUYER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BORADAUTH"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝  
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작 
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
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
                        <th width="80" class="point">점</th>
                        <td width="150">
                            <comment id="_NSID_"> 
                                <object id=EM_O_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1  align="absmiddle"></object>
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
                        <td >
                            <comment id="_NSID_"> 
                                <object id=EM_O_READ_CNT classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1  align="absmiddle">
                                    
                                </object>
                            </comment>
                            <script>_ws_(_NSID_);</script>
                        </td>                                                
                    </tr>
                        <th width="80">제목</th>
                        <td colspan="5">
                            <comment id="_NSID_"> 
                                <object id=EM_O_TITLE classid=<%=Util.CLSID_EMEDIT%> width=687 tabindex=1  onkeyup="javascript:checkByteStr(this, 50, 'Y');" align="absmiddle"> </object>
                            </comment>
                            <script>_ws_(_NSID_);</script>
         
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
        <td >
         <table  border="0" cellspacing="0" cellpadding="0" width="100%">
                            <tr>
                                <td  valign="top" width="600"> 
                                  <table  border="0" cellpadding="0" cellspacing="0" class="s_table" width="100%">
                                         <tr>
                                            <th width="80" class="point">점</th>
                                             <td width="140">
                                                 <comment id="_NSID_">
                                                     <object id=LC_I0_STRCD  classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1  align="absmiddle"> </object>
                                                 </comment>
                                                 <script>_ws_(_NSID_);</script>
                                              </td>
                                             <th width="80" class="point">바이어코드</th>
                                             <td>
                                                 <comment id="_NSID_">
                                                     <object id=LC_I0_BUYER classid=<%=Util.CLSID_LUXECOMBO%> width=100% tabindex=1  align="absmiddle"> </object>
                                                 </comment>
                                                 <script>_ws_(_NSID_);</script>
                                              </td>                        
                                         </tr>
                                         <tr>
                                            <th>등록자</th>
                                             <td width="140">
                                                <comment id="_NSID_">
                                                     <object id=EM_I0_BUYERNM  classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1  align="absmiddle"> </object>
                                                 </comment>
                                                 <script>_ws_(_NSID_);</script>
                                             </td>
                                            <th class="point" width="80">제목</th>
                                             <td>
                                                 <comment id="_NSID_">
                                                     <object id=EM_TITLE classid=<%=Util.CLSID_EMEDIT%> width=100% tabindex=1 onkeyup="javascript:checkByteStr(this, 50, 'Y');" align="absmiddle">
                                                     </object> 
                                                 </comment>
                                                 <script>_ws_(_NSID_);</script>
                                             </td>
                                         </tr>
                                         <tr>
                                             <th class="point">내용</th>
                                             <td colspan="3">
                                                 <comment id="_NSID_">
                                                     <object id=TXT_CONTENT classid=<%=Util.CLSID_TEXTAREA%> height=200 
                                                             onkeyup="checkByteStr(this, 4000, 'Y');"
                                                             
                                                             width=100% tabindex=1 > 
                                                     </object>
                                                 </comment>
                                                 <script>_ws_(_NSID_);</script></td>
                                         </tr>                    
                                     </table>
                                </td>
                                <td valign="top"  class="PL10">
                                    <table border="0" cellpadding="0" cellspacing="0" class="s_table" width="100%">
                                                    
                                                    <tr>
                                                        <th width="40">선택</th>
                                                        <td valign="top">
                                                           <comment id="_NSID_"><OBJECT
                                                                    id=GD_DETAIL width=100% height=251 classid=<%=Util.CLSID_GRID%> tabindex=1 >
                                                                    <param name="DataID" value="DS_IO_DETAIL">
                                                                </OBJECT></comment><script>_ws_(_NSID_);</script>
                                                        </td>
                                                    </tr>
                                                </table>
                                </td>                               
                            </tr>
                            </table>
        </td>
    <tr valign="top">        
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="100%" align="right" class="PT03 PB03">
                    <img alt="댓글" src="/<%=dir%>/imgs/btn/reply_s.gif" onclick="javascript:btn_repleAdd();" id="a_reply" tabindex=1 />
                </td>
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
                    <tr>
                        <td width="100%" >
                        <comment id="_NSID_">
                            <OBJECT id=GD_MASTER width=100% height=199 classid=<%=Util.CLSID_GRID%> tabindex=1  >
                                <param name="DataID" value="DS_IO_MASTER">
                            </OBJECT>
                        </comment>
                        <script>_ws_(_NSID_);</script></td>
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
        <c>Col=STR_CD         Ctrl=LC_I0_STRCD            param=BindColVal</c>
        <c>Col=TITLE01        Ctrl=EM_TITLE               param=Text</c>
        <c>Col=BUYER_CODE     Ctrl=LC_I0_BUYER            param=BindColVal</c>
        <c>Col=BUYER_NM01     Ctrl=EM_I0_BUYERNM          param=Text</c>
        <c>Col=CONTNES        Ctrl=TXT_CONTENT            param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

