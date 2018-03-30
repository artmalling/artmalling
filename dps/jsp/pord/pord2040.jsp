<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주관리 > 품목발주검품확정
 * 작 성 일 : 2010.01.18
 * 작 성 자 : 신명섭
 * 수 정 자 : 
 * 파 일 명 : pord2040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 품목발주등록 
 * 이    력 :
 * 
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
<!--* A. 로그인 유무, 기본설정                                                *-->
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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var strCurRow       = "";                            // 저장시 선택된 Row
var strBuyerYN      = "";                            // 바이어/SM일 경우 Y
var org_flag        = "";                            // 조직구분 (매입:2/판매:1)
var strToday        = "";                            // 현재날짜
var strSlipNo       = "";                            // 발주번호
var strTaxFlag      = "";                            // 과세구분 (0:과세,1:면세)
var roundFlag       = "";                            // 원가단가 반올림 구분 (1:반올림 2:올림 3:내림)
var blnPummokChanged = false;


var inta            = 0;
var bfListRowPosition = 0;                           // 이전 List Row Position

var g_listChkCnt      = 0;                           //리스트체크카운트
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-09
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 165;		//해당화면의 동적그리드top위치
 var top2 = 405;		//해당화면의 동적그리드top위치

 function doInit(){
    // Input  Data Set Header 초기화
    
    //Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

    
    strToday = getTodayDB("DS_O_RESULT");
    // Output Data Set Header 초기화
    DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');  
    DS_EVENT_FLAG.setDataHeader('<gauce:dataset name="H_MARGIN_FLAG"/>');
    DS_SETEVNFLAG.setDataHeader('<gauce:dataset name="H_MARGIN_FLAG"/>');
    DS_EVENT_RATE.setDataHeader('<gauce:dataset name="H_MARGIN_RATE"/>'); 
    DS_SETEVNRATE.setDataHeader('<gauce:dataset name="H_MARGIN_RATE"/>'); 
    DS_PUMMOK_INFO.setDataHeader('<gauce:dataset name="H_PUMMOK_INFO"/>');         //품목코드 정보
    DS_PAY_CLOSE_CHK.setDataHeader('<gauce:dataset name="H_PAY_CLOSE_CHK"/>');     //대금지불마감체크
    
    DS_O_CHK_SLIP_FLAG.setDataHeader('<gauce:dataset name="H_CHK_SLIP_FLAG"/>');   //DB 전표진행상태
    DS_MG_RATE.setDataHeader('<gauce:dataset name="H_MG_RATE"/>');
    DS_TAX_YN.setDataHeader('<gauce:dataset name="H_TAX_YN"/>');                   //세금계산서 발행여부체크
    
    DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)'); 
    
    // 그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
         
    // EMedit에 초기화
    initEmEdit(EM_S_START_DT,           "SYYYYMMDD",     PK);                  //조회용 시작일
    initEmEdit(EM_S_END_DT,             "TODAY",         PK);                  //조회용 종료일
    initEmEdit(EM_S_PB_CD,              "GEN^6",         NORMAL);              //조회용 브랜드코드
    initEmEdit(EM_S_PB_NM,              "GEN",           READ);                //조회용 브랜드명     
    initEmEdit(EM_S_VEN_CD,             "GEN^6",         NORMAL);              //조회용 협력사코드
    initEmEdit(EM_S_VEN_NM,             "GEN",           READ);                //조회용 협력사코드명
    initEmEdit(EM_S_SLIP_NO,            "0000-0-0000000",NORMAL);              //전표번호  

    initEmEdit(RD_SLIP_FLAG,            "GEN"  ,         READ);                //입력용 전표구분  
    initEmEdit(EM_I_PB_CD,              "GEN^6",         READ);                //입력용 브랜드코드
    initEmEdit(EM_I_PB_NM,              "GEN",           READ);                //입력용 브랜드명     
    initEmEdit(EM_I_BJDATE,             "YYYYMMDD",      READ);                //입력용 발주일     
    initEmEdit(EM_I_BJHJDATE,           "YYYYMMDD",      READ);                //입력용 발주확정
    initEmEdit(EM_I_NPYJDATE,           "YYYYMMDD",      READ);                //입력용 납품예정일
    initEmEdit(EM_I_MAJINDATE,          "YYYYMMDD",      READ);                //입력용 마진적용일
    initEmEdit(EM_O_ETC,                "GEN^100",       NORMAL);              //입력용 비고
    initEmEdit(EM_TOT_TAX,              "NUMBER^13^0",   READ);                //부가세계

    //initEmEdit(EM_O_SLIP_NO,  "GEN",     READ);            //출력용 전표번호
    initEmEdit(EM_O_SLIP_NO,            "0000-0-0000000",READ);                //전표번호 
    initEmEdit(EM_O_SLIP_PROC_STAT_NM,  "GEN",           READ);                //출력용 전표상태
    initEmEdit(EM_O_BALJUJC,            "GEN",           READ);                //출력용 발주주체
    initEmEdit(EM_O_BUYER_CD,           "GEN",           READ);                //출력용 바이어코드
    initEmEdit(EM_O_BUYER_NM,           "GEN",           READ);                //출력용 바이어명
    initEmEdit(EM_O_GS_GBN,             "GEN",           READ);                //출력용 과세구분
    initEmEdit(EM_O_HRS_CD,             "GEN",           READ);                //출력용 협력사코드
    initEmEdit(EM_O_HRS_NM,             "GEN",           READ);                //출력용 협력사명
    initEmEdit(EM_O_GPWJ_DATE,          "YYYYMMDD",      PK);                  //출력용 검품확정일
    initEmEdit(EM_O_SRG,                "NUMBER^9^0",    READ);                //출력용 수량계
    initEmEdit(EM_O_WGG,                "NUMBER^12^0",   READ);                //출력용 원가계
    initEmEdit(EM_O_MGG,                "NUMBER^12^0",   READ);                //출력용 매가계
    initEmEdit(EM_O_MG_RATE,            "NUMBER^5^2" ,   READ);                //출력용 마진율
    
    //콤보 초기화
    initComboStyle(LC_O_STR,       DS_STR,            "CODE^0^30,NAME^0^80",               1, PK);       //조회용 점코드     
    initComboStyle(LC_O_BUMUN,     DS_O_DEPT,         "CODE^0^30,NAME^0^80",               1, PK);       //조회용 팀     
    initComboStyle(LC_O_TEAM,      DS_O_TEAM,         "CODE^0^30,NAME^0^80",               1, PK);       //조회용 파트     
    initComboStyle(LC_O_PC,        DS_O_PC,           "CODE^0^30,NAME^0^80",               1, PK);       //조회용 PC     
    initComboStyle(LC_O_GJDATE,    DS_O_GJDATE_TYPE,  "CODE^0^30,NAME^0^80",               1, PK);       //조회용 기준일     
    initComboStyle(LC_O_JPST,      DS_O_PROC_STAT,    "CODE^0^30,NAME^0^80",               1, NORMAL);   //조회용 전표상태        
                                                                                                         
    initComboStyle(LC_I_STORE,     DS_STR,            "CODE^0^30,NAME^0^80",               1, PK);       //입력용 점 
    initComboStyle(LC_I_SH_GBN,    DS_AFT_ORD_FLAG,   "CODE^0^30,NAME^0^80",               1, NORMAL);   //입력용 사후구분   
    initComboStyle(LC_I_HS_GBN,    DS_EVENT_FLAG,     "EVENT_FLAG^0^30,EVENT_FLAG_NM^0^0", 1, PK);       //입력용 행사구분 
    initComboStyle(LC_I_HS_RATE,   DS_EVENT_RATE,     "EVENT_RATE^0^30,EVENT_RATE_NM^0^0", 1, PK);       //입력용 행사율     
    

     //공통코드에서 데이터 가지고 오기
//  getStrCode("DS_STR","N","N");                           // 점
	getEtcCode("DS_O_GJDATE_TYPE",    "D", "P214", "N");    // 기준일
	getEtcCode("DS_O_PROC_STAT",      "D", "P235", "N");    // 전표확정상태 (Y:확정, N:미확정)
	getEtcCode("DS_AFT_ORD_FLAG",     "D", "P209", "N");    // 사전사후구분
	getEtcCode("DS_ORD_OWN_FLAG",     "D", "P202", "N");    // 발주주체구분 
	getEtcCode("DS_TAX_FLAG",         "D", "P004", "N");    // 과세구분
	
	getEtcCode("DS_ORD_UNIT_CD",      "D", "P013", "N");    // 단위 
	getEtcCode("DS_TAG_FLAG",         "D", "P063", "N");    // 택구분 
	getEtcCode("DS_TAG_PRT_OWN_FLAG", "D", "P064", "N");    // 택발행주체
	
	getStore("DS_STR", "Y", "", "N");                       // 점            
	
	EM_TAX_FLAG.style.display         = "none";
	
	LC_O_STR.Index      = 0; 
	LC_O_BUMUN.Index    = 0;
	LC_O_TEAM.Index     = 0;
	LC_O_PC.Index       = 0;  
	LC_O_GJDATE.Index   = 0;
	LC_O_JPST.Index     = 0;    // 전표상태(미확정) 
	LC_O_STR.Focus();
	
	setTempEvnDataset();        // 행사구분 행사율 데이터셋 임시지정
	setEventFlagDs();           // 행사구분 행사율 데이터셋 복사
	    
	registerUsingDataset("pord204","DS_LIST");
	
	//입력부의 컴퍼넌트들을 디저블시킨다.
	setObject(false);   
 } 
 
 
 function gridCreate1(){
     var hdrProperies = '<FC>id=CHECK1             name="선택"        width=45 align=center EditStyle=CheckBox  HeadCheckShow=true </FC>'
                      + '<FC>id=SLIP_FLAG_NM       name="구분"        width=30 Edit=none   BgColor={decode(REJ_CAN_FLAG,1,"#C8FFFF",2,"#D2D2D2")} align=center </FC>'
                      + '<FC>id=SLIP_NO            name="전표번호"    width=110 Edit=none   align=center Mask="XXXX-X-XXXXXXX" sumtext="합계" </FC>'
                      + '<FC>id=ORD_DT             name="발주일"      width=80 Edit=none   align=center Mask="XXXX/XX/XX" </FC>'
                      + '<FC>id=SLIP_PROC_STAT_NM  name="전표상태"    width=80 Edit=none   align=left </FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드"      width=130     align=left Edit=none </FC>'
                      + '<FC>id=VEN_NM             name="협력사"      width=80     align=left Edit=none </FC>'
                      + '<FC>id=COST_TAMT          name="원가금액"    width=100     align=right Edit=none sumtext=@sum </FC>'
                      + '<FC>id=SALE_TAMT          name="매가금액"    width=100     align=right Edit=none sumtext=@sum </FC>'
                      + '<FC>id=STR_NM             name="점"          width=60 Edit=none   align=left </FC>'  ;

     initGridStyle(GR_MASTER, "common", hdrProperies, true);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}           name="NO"         width=30    align=center  sumtext=""     </FC>'
                      + '<FC>id=PUMMOK_CD          name="품목코드"   width=70    align=left    Edit=none       sumtext="합계" </FC>'
                      + '<FC>id=PUMMOK_NM          name="품목명"     width=100   align=left    Edit=none                      </FC>'
                      + '<FC>id=ORD_UNIT_CD        name="단위"       width=35    align=left    Edit=none       EditStyle=Lookup  Data="DS_ORD_UNIT_CD:CODE:NAME" </FC>'
                      + '<FC>id=ORD_QTY            name="발주수량"   width=60    align=right   Edit=none       sumtext=@sum  </FC>'
                      + '<FC>id=CHK_QTY            name="*검품수량"  width=60    align=right   Edit=Numeric    sumtext=@sum  </FC>'
                      + '<FC>id=MG_RATE            name="마진율"     width=50    align=right   Edit=none       sumtext=@avg  show=false</FC>'
                      + '<FG> name="원가 (부가세 제외)"' 
                      + '<FC>id=NEW_COST_PRC       name="단가"       width=80    align=right   Edit=none       sumtext=@sum  </FC>'
                      + '<FC>id=NEW_COST_AMT       name="금액"       width=120    align=right   Edit=Numeric    sumtext=@sum  </FC>'
                      + '</FG> '
                      + '<FC>id=VAT_AMT            name="부가세"     width=60    align=right   Edit=Numeric    sumtext=@sum </FC>' 
                      + '<FG> name="매가 (부가세 포함)"'
                      + '<FC>id=NEW_SALE_PRC       name="단가"       width=80    align=right   Edit=none       </FC>'
                      + '<FC>id=NEW_SALE_AMT       name="금액"       width=120    align=right   Edit=none       sumtext=@sum  </FC>'
                      + '</FG> '
                      + '<FC>id=TAG_FLAG           name="TAG구분"     width=85   align=left    Edit=none EditStyle=Lookup   Data="DS_TAG_FLAG:CODE:NAME" </FC>'                  
                      + '<FC>id=TAG_PRT_OWN_FLAG   name="TAG발행주체" width=80   align=left    Edit=none EditStyle=Lookup   Data="DS_TAG_PRT_OWN_FLAG:CODE:NAME" </FC>'                  
                      + '<FC>id=NEW_GAP_RATE       name="신차익율"    width=60   align=left    Edit=none show=false</FC>'                  
                      + '<FC>id=NEW_GAP_AMT        name="신차익액"    width=80   align=left    Edit=none show=false</FC>';                  
      initGridStyle(GR_DETAIL, "common", hdrProperies, true);
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
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	g_listChkCnt = 0;
    GR_MASTER.ColumnProp('CHECK1','HeadCheck')= "false";  
    // 변경, 추가내역이 있을 경우
    if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
        if( showMessage(STOPSIGN, YESNO, "USER-1073") != 1 ){   
            return;       
        }else{
            DS_LIST.DeleteRow(DS_LIST.RowPosition);
            DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
//            DS_LIST.RowPosition(DS_LIST.CountRow);
//            DS_IO_DETAIL.ClearData();         
        }
    }
    
     if(checkValidation("Search")){
         DS_IO_MASTER.ClearData();  
         DS_IO_DETAIL.ClearData();
         inta = 0;
         bfListRowPosition = 0;
         
         getList();
         setPorcCount("SELECT", GR_MASTER);
         if(DS_LIST.CountRow <= 0)
             LC_O_STR.Focus();
     }

     //입력부의 컴퍼넌트들을 디저블시킨다.
     setObject(false);  
}

/**
 * btn_New()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {  
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요    : 삭제버튼 클릭 (신규등록일 경우 DS_IO_MASTER 삭제, 기존데이터일 경우 삭제 Action실행)
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
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
    
    if(!DS_LIST.Isupdated){
        showMessage(INFORMATION, OK, "USER-1002", "처리할 전표"); 
        //GR_DETAIL.Focus();
        return;
    }
	 
	if(!confRej())
        return;
        
	btn_Search();          
}

/**
 * confRej()
 * 작 성 자 : 
 * 작 성 일 : 2010-07-12
 * 개    요 : 확정 처리
 * return값 : void
 */
function confRej() {  
	var strSlipProcStat = "";     //전표산태플레그
	var vanMsgFlag = false;       //반려유무 플레그
	var confFlag = "";
	var sendFlag = "";            //SMS전송시 보내는 플레그 
	var strOrgSlipProcStat = "";  //해당전표의 현재 전표진행상태
	
	var disPlayConfFlag    = ""   //화면상의 전표진행상태(화면상의 전표진행상태와 실제 진행상태가 다를수 있기때문에 체크한다. 검품확정상태 : 09, 미검품확정상태 : 00)
	var k = 0;
	
	var returnflag         = false;
	
	//확정취소 하려면
	if(DS_LIST.Namevalue(DS_LIST.RowPosition ,"SLIP_PROC_STAT") == "09"){ //검품확정상태
		disPlayConfFlag = "09";
	
	    //승인 취소 하시겠습니까?
	    if( showMessage(STOPSIGN, YESNO, "USER-1206") != 1 ){
            returnflag = false;
            return;
	    }else{         
            if( showMessage(STOPSIGN, YESNO, "USER-1212", "취소") == 1 ){        //정말 취소 하시겠습니까.
                //alert("승인취소한다");   
                strSlipProcStat = "09"     //승인상태의 플래그로 승인을 취소하기 위함.
                sendFlag = "2";            //승인취소
                
                confFlag = "conf"; 
            }else{
                return;
            } 
	    }
	//확정하려면
	}else{
        disPlayConfFlag = "00";
        
	    //확정(반려)하시겠습니까?
	    var returnv = showMessage(DECIDE, DECIDEREJECT, "USER-1215");
	    if(returnv == 2){
            if( showMessage(STOPSIGN, YESNO, "USER-1212", "반려") == 1 ){        //정말 반려 하시겠습니까. 
                //alert("반려");    
                strSlipProcStat = "09"     //확정상태의 플래그로 승인을 취소하기 위함.
                vanMsgFlag = true;  
                
                confFlag = "reject";       //마스터디테일 로그테이블에 만 데이터 적용(프로시저 X)
                sendFlag = "1";            //반려
            }else{
                return;
            }
	        
	    }else if(returnv ==1){         //재무팀 합의 승인상태에서 검품확정
	        //alert("확정"); 
	        strSlipProcStat = "00"     //확정이안된상태의 플래그로 확정을하기 위함.
	        vanMsgFlag = false;
	        
	        confFlag = "conf";
	        sendFlag = "0";            //확정
	    }else{
            returnflag = false;
	        return;
	    }       
	}    
	
	//alert("g_listChkCnt = " + g_listChkCnt);
	
	if(g_listChkCnt == 1){             //한건이면
	
	    var listSlipNo = "";
	    for(x = 1; x<= DS_LIST.CountRow; x++){
	        if(DS_LIST.NameValue(x, "CHECK1") == "T"){
	            listSlipNo = DS_LIST.NameValue(x, "SLIP_NO");
	        }
	    }
	    var masterSlipNo = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO");
	    if(listSlipNo == masterSlipNo){
	    	//alert("같을때");

	        checkSlipFlag(DS_LIST.RowPosition); //현재 전표의 DB전표진행상태를 알기 위함
	        if(disPlayConfFlag == "00"){        //검품 확정 하려는 상태
	            if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){
	                //alert("이미 검품확정된 전표입니다.");
                    showMessage(INFORMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
	                setFocusGrid(GR_MASTER, DS_LIST, DS_LIST.RowPosition, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
	                returnflag = false;
	                return;
	            }else{
	                returnflag = true;  
	            }
	        }else{  //화면상에 검품 확정 상태이면(사용자는 확정취소를 의도)
	            if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "00"){
	                //alert("이미 검품취소된 전표입니다.");
                    showMessage(INFORMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
	                setFocusGrid(GR_MASTER, DS_LIST, DS_LIST.RowPosition, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
	                returnflag = false;
	                return;
	            }else{
	                returnflag = true;  
	            }
	        }   
	        
	        // 마스터 상태를 insert로 셋팅 
	        DS_IO_MASTER.UserStatus(1) = 1;
	        
	        // 디테일 상태를 insert로 셋팅 
	        for(var i=1;i<=DS_IO_DETAIL.CountRow;i++) {
	            DS_IO_DETAIL.UserStatus(i) = 1;
	        }
            
            // 세금계산서 발행유무
            if(!checkTaxYn(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD"), listSlipNo, DS_IO_MASTER.RowPosition)){
                returnflag = false;
                return false;         
            } 
    
//             // 일시재마감체크
//             if(!dayCloseCheck(strToday, DS_IO_MASTER.RowPosition)){
//                 returnflag = false;
//                 return false;               
//             } 

            // 대금지불마감체크
            var strCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
            var venCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
            var chkDt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CHK_DT");
            
            if(!chkPayClose(DS_IO_MASTER.RowPosition, strCd, venCd, chkDt)){
                returnflag = false;
                return false;               
            } 
	
	        // 마감체크
	        if(!closeCheck(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CHK_DT"), DS_IO_MASTER.RowPosition)){
                returnflag = false;
                return false;	        	
	        } 
	        
	        // 검품확정시에만 검품확정일자 체크한다. 20100804
	        if(sendFlag == "0"){
	        	//alert("확정일때만");
	            //검품확정일자 체크
	            if(!checkChkDt(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORD_DT"), DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CHK_DT"), DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "AFT_ORD_FLAG"))){
	                returnflag = false;
	                return false;               
	            }
	            
	            // 20161121 발주확정일이 없을경우 발주확정일에 검풀확정일을 세팅
	            if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORD_CF_DT") == "" || DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORD_CF_DT") == "        "){
	            	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORD_CF_DT") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CHK_DT");
	            }
	        }
	        
            // 하단그리드 마진율 비교하기위함
            if(!chkMgRate(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD"), listSlipNo, sendFlag, DS_IO_MASTER.RowPosition)){
                return false;               
            }
	        
	        var strStrCd       = DS_LIST.NameValue(DS_LIST.RowPosition,"STR_CD");
	        var strSlipNo      = DS_LIST.NameValue(DS_LIST.RowPosition,"SLIP_NO");
	        var strSlipFlag    = DS_LIST.NameValue(DS_LIST.RowPosition,"SLIP_FLAG");
	        strOrgSlipProcStat = DS_LIST.NameValue(DS_LIST.RowPosition,"SLIP_PROC_STAT");
	                    
	        var parameters   = "&strSlipProcStat="+encodeURIComponent(strSlipProcStat) 
	                         + "&strToday="+encodeURIComponent(strToday)
	                         + "&strStrCd="+encodeURIComponent(strStrCd)
	                         + "&strSlipNo="+encodeURIComponent(strSlipNo) 
                             + "&sendFlag="+encodeURIComponent(sendFlag)  
                             + "&strSlipFlag="+encodeURIComponent(strSlipFlag)  
	                         + "&strOrgSlipProcStat="+encodeURIComponent(strOrgSlipProcStat); 
	        TR_S_MAIN.Action="/dps/pord204.po?goTo=conf&confFlag="+confFlag+parameters;
	        TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
	        TR_S_MAIN.Post();   
	        
	        k = 1;    
	        
	        
	    }else{      //한건이지만 리스트와 마스터 정보가 다르면 다시 DB갔다온다. 검품확정일은 DB값으로 자동 셋팅된다
	        //alert("리스트 마스터 다를경우");
	    
	        for(var closeChkCnt = 1; closeChkCnt<=DS_LIST.CountRow; closeChkCnt++){
	            if(DS_LIST.NameValue(closeChkCnt,"CHECK1") == "T"){
	                // 마감체크
	                if(!closeCheck(DS_LIST.NameValue(closeChkCnt, "CHK_DT"), closeChkCnt)){
                        returnflag = false;
                        return false;      
	                }      
	            }       
	        }    
	        
	        for(var masterChkCnt = 1; masterChkCnt<=DS_LIST.CountRow; masterChkCnt++){
	            if(DS_LIST.NameValue(masterChkCnt,"CHECK1") == "T"){
	
	                confGetMaster(masterChkCnt);
	                confGetDetail(masterChkCnt);
	                
	                // 세금계산서 발행유무
	                if(!checkTaxYn(DS_LIST.NameValue(masterChkCnt,"STR_CD"), DS_LIST.NameValue(masterChkCnt, "SLIP_NO"), sendFlag, masterChkCnt)){
	                    returnflag = false;
	                    return false;         
	                } 

//                     // 일 시재마감 체크
//                     if(!dayCloseCheck(strToday, masterChkCnt)){
//                         returnflag = false;
//                         return false;         
//                     } 
                    
	                // 대금지불마감체크
	                var strCd = DS_LIST.NameValue(masterChkCnt, "STR_CD");
	                var venCd = DS_LIST.NameValue(masterChkCnt, "VEN_CD");
	                var chkDt = DS_LIST.NameValue(masterChkCnt, "CHK_DT");
	                
	                if(!chkPayClose(masterChkCnt, strCd, venCd, chkDt)){
	                    returnflag = false;
	                    return false;               
	                } 
	                
	                // 마감체크
	                if(!closeCheck(DS_LIST.NameValue(masterChkCnt, "CHK_DT"), masterChkCnt)){
	                    returnflag = false;
	                    return false;         
	                } 
	                
	                // 하단그리드 마진율 비교하기위함
	                if(!chkMgRate(DS_LIST.NameValue(masterChkCnt,"STR_CD"), DS_LIST.NameValue(masterChkCnt, "SLIP_NO"), sendFlag, masterChkCnt)){
	                    return false;               
	                }  
	                
	                if(disPlayConfFlag == "00"){        //검품 확정 하려는 상태
	                    if(DS_MASTER_TMP.NameValue(DS_MASTER_TMP.RowPosition, "SLIP_PROC_STAT") == "09"){
	                        //alert("이미 검품확정된 전표입니다.");
                            showMessage(INFORMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
	                        setFocusGrid(GR_MASTER, DS_LIST, masterChkCnt, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
	                        returnflag = false;
	                        return;
	                    }else{
	                        returnflag = true;  
	                    }
	                }else{  //화면상에 검품 확정 상태이면(사용자는 확정취소를 의도)
	                    if(DS_MASTER_TMP.NameValue(DS_MASTER_TMP.RowPosition, "SLIP_PROC_STAT") == "00"){
	                        //alert("이미 검품취소된 전표입니다.");
                            showMessage(INFORMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
	                        setFocusGrid(GR_MASTER, DS_LIST, masterChkCnt, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
	                        returnflag = false;
	                        return;
	                    }else{
	                        returnflag = true;  
	                    }
	                }     
	
	                // 디테일 상태를 insert로 셋팅 
	                for(var i=1;i<=DS_DETAIL_TMP.CountRow;i++) {
	                    DS_DETAIL_TMP.UserStatus(i) = 1;
	                }
	                
		            // 20161121 발주확정일이 없을경우 발주확정일에 검풀확정일을 세팅
		            if(DS_MASTER_TMP.NameValue(masterChkCnt, "ORD_CF_DT") == "" || DS_MASTER_TMP.NameValue(masterChkCnt, "ORD_CF_DT") == "        "){
		            	DS_MASTER_TMP.NameValue(masterChkCnt, "ORD_CF_DT") = DS_IO_MASTER.NameValue(masterChkCnt, "CHK_DT");
		            }
		            
	                // 마스터 상태를 insert로 셋팅 
	                DS_MASTER_TMP.UserStatus(1) = 1;
	                
	                var strStrCd       = DS_LIST.NameValue(masterChkCnt,"STR_CD");
	                var strSlipNo      = DS_LIST.NameValue(masterChkCnt,"SLIP_NO");
	                var strSlipFlag    = DS_LIST.NameValue(masterChkCnt,"SLIP_FLAG");
	                strOrgSlipProcStat = DS_LIST.NameValue(masterChkCnt,"SLIP_PROC_STAT");
	                            
	                var parameters   = "&strSlipProcStat="+encodeURIComponent(strSlipProcStat) 
	                                 + "&strToday="+encodeURIComponent(strToday)
	                                 + "&strStrCd="+encodeURIComponent(strStrCd)
	                                 + "&strSlipNo="+encodeURIComponent(strSlipNo) 
	                                 + "&sendFlag="+encodeURIComponent(sendFlag)  
	                                 + "&strSlipFlag="+encodeURIComponent(strSlipFlag) 
	                                 + "&strOrgSlipProcStat="+encodeURIComponent(strOrgSlipProcStat); 
	                TR_S_MAIN.Action="/dps/pord204.po?goTo=conf&confFlag="+confFlag+parameters;
	                TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_MASTER_TMP,I:DS_IO_DETAIL=DS_DETAIL_TMP)"; //조회는 O
	                TR_S_MAIN.Post(); 
	                
	                k += 1;	                
	            }       
	        }
	    }
	}else{                      //멀티체크이면 
		// 체크된 건에 대해서 마감체크 및 DB전표진행상태를 체크한다.
	    for(var closeChkCnt = 1; closeChkCnt<=DS_LIST.CountRow; closeChkCnt++){
	        if(DS_LIST.NameValue(closeChkCnt,"CHECK1") == "T"){
	        	
	        	// 현재전표상태
	            checkSlipFlag(closeChkCnt);         //현재 전표의 DB전표진행상태를 알기 위함
	            if(disPlayConfFlag == "00"){        //검품 확정 하려는 상태
	                if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "09"){
	                    //alert("이미 검품확정된 전표입니다.");
                        showMessage(INFORMATION, OK, "GAUCE-1000", "이미 확정된 전표입니다.");
	                    setFocusGrid(GR_MASTER, DS_LIST, closeChkCnt, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
	                    returnflag = false;
	                    return;
	                }else{
	                    returnflag = true;  
	                }
	            }else{  //화면상에 검품 확정 상태이면(사용자는 확정취소를 의도)
	                if(DS_O_CHK_SLIP_FLAG.NameValue(DS_O_CHK_SLIP_FLAG.RowPosition, "SLIP_PROC_STAT") == "00"){
	                    //alert("이미 검품취소된 전표입니다.");
                        showMessage(INFORMATION, OK, "GAUCE-1000", "이미 확정취소된 전표입니다.");
	                    setFocusGrid(GR_MASTER, DS_LIST, closeChkCnt, "CHECK1");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동          
	                    returnflag = false;
	                    return;
	                }else{
	                    returnflag = true;  
	                }
	            } 
                
                // 세금계산서 발행유무
                if(!checkTaxYn(DS_LIST.NameValue(closeChkCnt,"STR_CD"), DS_LIST.NameValue(closeChkCnt, "SLIP_NO"), closeChkCnt)){
                    returnflag = false;
                    return false;         
                } 
                
//                 // 일 시재 마감체크
//                 if(!dayCloseCheck(strToday, closeChkCnt)){
//                     returnflag = false;
//                     return false;         
//                 } 

	            // 대금지불마감체크
	            var strCd = DS_LIST.NameValue(closeChkCnt, "STR_CD");
	            var venCd = DS_LIST.NameValue(closeChkCnt, "VEN_CD");
	            var chkDt = DS_LIST.NameValue(closeChkCnt, "CHK_DT");
	            
	            if(!chkPayClose(closeChkCnt, strCd, venCd, chkDt)){
	                returnflag = false;
	                return false;               
	            } 
	            
                // 마감체크
                if(!closeCheck(DS_LIST.NameValue(closeChkCnt, "CHK_DT"), closeChkCnt)){
                    returnflag = false;
                    return false;         
                } 
                
                // 하단그리드 마진율 비교하기위함
                if(!chkMgRate(DS_LIST.NameValue(closeChkCnt,"STR_CD"), DS_LIST.NameValue(closeChkCnt, "SLIP_NO"), sendFlag, closeChkCnt)){
                    return false;               
                }  
	        }       
	    }    
	    
	    for(var masterChkCnt = 1; masterChkCnt<=DS_LIST.CountRow; masterChkCnt++){
	        if(DS_LIST.NameValue(masterChkCnt,"CHECK1") == "T"){
	        	
	            confGetMaster(masterChkCnt);
	            confGetDetail(masterChkCnt);
	
	            // 디테일 상태를 insert로 셋팅 
	            for(var i=1;i<=DS_DETAIL_TMP.CountRow;i++) {
	                DS_DETAIL_TMP.UserStatus(i) = 1;
	            }
                
	            // 20161121 발주확정일이 없을경우 발주확정일에 검풀확정일을 세팅
	            if(DS_MASTER_TMP.NameValue(masterChkCnt, "ORD_CF_DT") == "" || DS_MASTER_TMP.NameValue(masterChkCnt, "ORD_CF_DT") == "        "){
	            	DS_MASTER_TMP.NameValue(masterChkCnt, "ORD_CF_DT") = DS_IO_MASTER.NameValue(masterChkCnt, "CHK_DT");
	            }
	            
	            // 마스터 상태를 insert로 셋팅 
	            DS_MASTER_TMP.UserStatus(1) = 1;
	            
	            var strStrCd       = DS_LIST.NameValue(masterChkCnt,"STR_CD");
	            var strSlipNo      = DS_LIST.NameValue(masterChkCnt,"SLIP_NO");
	            var strSlipFlag    = DS_LIST.NameValue(masterChkCnt,"SLIP_FLAG");
	            strOrgSlipProcStat = DS_LIST.NameValue(masterChkCnt,"SLIP_PROC_STAT");
	                        
	            var strDetailCount = DS_IO_DETAIL.CountRow; 
	            var parameters = "&strDetailCount="+encodeURIComponent(strDetailCount)
	                             + "&strSlipProcStat="+encodeURIComponent(strSlipProcStat) 
	                             + "&strToday="+encodeURIComponent(strToday)
	                             + "&strStrCd="+encodeURIComponent(strStrCd)
	                             + "&strSlipNo="+encodeURIComponent(strSlipNo) 
	                             + "&sendFlag="+encodeURIComponent(sendFlag)  
	                             + "&strSlipFlag="+encodeURIComponent(strSlipFlag) 
	                             + "&strOrgSlipProcStat="+encodeURIComponent(strOrgSlipProcStat); 
	            TR_S_MAIN.Action="/dps/pord204.po?goTo=conf&confFlag="+confFlag+parameters;
	            TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_MASTER_TMP,I:DS_IO_DETAIL=DS_DETAIL_TMP)"; //조회는 O
	            TR_S_MAIN.Post(); 
	            
	            k += 1;	            
	        }       
	    }       
	}    
	
	//반려된 전표일경우
	if(vanMsgFlag){
	    showMessage(INFORMATION, OK, "USER-1201", k);        
	    btn_Search();         
	    return;
	}
	
	if(strSlipProcStat == "09"){//확정상태였던 전표의 취소된 건수
	    showMessage(INFORMATION, OK, "USER-1203", k); 
	    
	}else{      //미확정상태였던 전표의 확정된 건수
	    showMessage(INFORMATION, OK, "USER-1202", k); 
	}
    returnflag = true;	
    
    return returnflag;
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
 /**
  * checkSlipFlag()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-07-12
  * 개    요 :  리스트 DB전표진행상태 조회
  * return값 : void
  */
  function checkSlipFlag(row){

	  var strStrCd  = DS_LIST.NameValue(row,"STR_CD");
	  var strSlipNo = DS_LIST.NameValue(row,"SLIP_NO");
	  
	  var goTo       = "checkSlipFlag" ;    
	  var action     = "O";     
	  var parameters = "&strStrCd="+encodeURIComponent(strStrCd)+
	                   "&strSlipNo="+encodeURIComponent(strSlipNo);
	  
	  TR_S_MAIN.Action="/dps/pord204.po?goTo="+goTo+parameters;  
	  TR_S_MAIN.KeyValue="SERVLET("+action+":DS_O_CHK_SLIP_FLAG=DS_O_CHK_SLIP_FLAG)"; //조회는 O
	  TR_S_MAIN.Post();
  }
  
  
 /**
 * getList()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getList(){

//    setEventFlagDs();  //행사구분 행사율 데이터셋 복사
    // 조회조건 셋팅
    var strStrCd       = LC_O_STR.BindColVal;        //점
    var strBumun       = LC_O_BUMUN.BindColVal;      //팀
    var strTeam        = LC_O_TEAM.BindColVal;       //파트
    var strPc          = LC_O_PC.BindColVal;    
    var strOrgCd       = strStrCd + strBumun + strTeam + strPc; // 조직//PC
    var strGiJunDtType = LC_O_GJDATE.BindColVal;     //기준일
    var strStartDt     = EM_S_START_DT.Text;         //시작일
    var strEndDt       = EM_S_END_DT.Text;           //종료일
    var strProcStat    = LC_O_JPST.BindColVal;       //전표상태
    var strPumbun      = EM_S_PB_CD.Text;            //브랜드코드
    var strVen         = EM_S_VEN_CD.Text;           //협력사코드
    var strSlip_flag   = RD_S_SLIP_FLAG.CodeValue;   //전표구분
    var strSlipNo      = EM_S_SLIP_NO.Text;          // 전표번호
   
    var goTo        = "getList" ;    
    var action      = "O";     
    var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strBumun="+encodeURIComponent(strBumun)     
                    + "&strTeam="+encodeURIComponent(strTeam)      
                    + "&strPc="+encodeURIComponent(strPc)        
                    + "&strOrgCd="+encodeURIComponent(strOrgCd)        
                    + "&strGiJunDtType="+encodeURIComponent(strGiJunDtType)
                    + "&strStartDt="+encodeURIComponent(strStartDt)   
                    + "&strEndDt="+encodeURIComponent(strEndDt)     
                    + "&strProcStat="+encodeURIComponent(strProcStat)  
                    + "&strPumbun="+encodeURIComponent(strPumbun)    
                    + "&strVen="+encodeURIComponent(strVen)        
                    + "&strSlipNo="+encodeURIComponent(strSlipNo)       
                    + "&strSlip_flag="+encodeURIComponent(strSlip_flag); 
    TR_L_MAIN.Action="/dps/pord204.po?goTo="+goTo+parameters;  
    TR_L_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_LIST)"; //조회는 O
    TR_L_MAIN.Post();    

    GR_MASTER.SetColumn("CHECK1");
    GR_MASTER.Focus();     

    EM_I_PB_CD.Enable = false;              
    //enableControl(IMG_PUMBUN_CD, false);
 }
 
 /**
 * getMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getMaster(){

        var strStrCd  = DS_LIST.NameValue(DS_LIST.RowPosition,"STR_CD");
        var strSlipNo = DS_LIST.NameValue(DS_LIST.RowPosition,"SLIP_NO");
        var strDatasetId = "DS_O_RESULT";
        var strVenCd     = EM_O_HRS_CD.Text;
        
        var goTo       = "getMaster" ;    
        var action     = "O";     
        var parameters = "&strStrCd="+encodeURIComponent(strStrCd)+
                         "&strSlipNo="+encodeURIComponent(strSlipNo);
        
        TR_S_MAIN.Action="/dps/pord204.po?goTo="+goTo+parameters;  
        TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_S_MAIN.Post();
        
        // 협력사별 반올림 구분을 받는다
//      getVenRoundFlag(strDatasetId, strToday, strStrCd, strVenCd);
 }

 /**
 * getDetail()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  디테일 리스트 조회
 * return값 : void
 */
 function getDetail(){

    var strStrCd  = DS_LIST.NameValue(DS_LIST.RowPosition,"STR_CD");
    var strSlipNo = DS_LIST.NameValue(DS_LIST.RowPosition,"SLIP_NO");
    var strDatasetId = "DS_O_RESULT";
    var strVenCd     = EM_O_HRS_CD.Text;
    
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)+
                     "&strSlipNo="+encodeURIComponent(strSlipNo);
    
    TR_S_MAIN.Action="/dps/pord204.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_S_MAIN.Post();
    
    // 협력사별 반올림 구분을 받는다
    roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);

//    alert("roundFlag::" + roundFlag);
    // 협력사별 반올림 구분을 받는다
//    getVenRoundFlag(strDatasetId, strToday, strStrCd, strVenCd);
 }
 
 /**
 * confGetMaster(row)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-07-07
 * 개    요 :  검품 확정시 마스터 리스트 조회
 * return값 : void
 */
 function confGetMaster(row){

        var strStrCd  = DS_LIST.NameValue(row,"STR_CD");
        var strSlipNo = DS_LIST.NameValue(row,"SLIP_NO");
        var strDatasetId = "DS_O_RESULT";
        var strVenCd     = EM_O_HRS_CD.Text;
        
        var goTo       = "getMaster" ;    
        var action     = "O";     
        var parameters = "&strStrCd="+encodeURIComponent(strStrCd)+
                         "&strSlipNo="+encodeURIComponent(strSlipNo);
        
        TR_S_MAIN.Action="/dps/pord204.po?goTo="+goTo+parameters;  
        TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_MASTER_TMP)"; //조회는 O
        TR_S_MAIN.Post();        
 }

 /**
 * confGetDetail(row)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-07-07
 * 개    요 :  검품 확정시 디테일 리스트 조회
 * return값 : void
 */
 function confGetDetail(row){

    var strStrCd  = DS_LIST.NameValue(row,"STR_CD");
    var strSlipNo = DS_LIST.NameValue(row,"SLIP_NO");
    var strDatasetId = "DS_O_RESULT";
    var strVenCd     = EM_O_HRS_CD.Text;
    
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)+
                     "&strSlipNo="+encodeURIComponent(strSlipNo);
    
    TR_S_MAIN.Action="/dps/pord204.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_DETAIL_TMP)"; //조회는 O
    TR_S_MAIN.Post();
    
    // 협력사별 반올림 구분을 받는다
    roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);
 }

 /**
  * setObject()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-02-09
  * 개    요    : 컴퍼넌트 활성화 유무
  * return값 : void
  */
  function setObject(flag){
        
         LC_I_SH_GBN.Enable    = flag;             //사후구분
         RD_SLIP_FLAG.Enable   = flag;             //전표구분
         EM_I_PB_CD.Enable     = flag;             //브랜드
         EM_I_BJDATE.Enable    = flag;             //발주일
         EM_I_NPYJDATE.Enable  = flag;             //납품예정일
         EM_I_MAJINDATE.Enable = flag;             //마진적용일
//         EM_O_ETC.Enable       = flag;           //비고
         LC_I_HS_GBN.Enable    = flag;             //행사구분
         LC_I_HS_RATE.Enable   = flag;             //행사율
         LC_I_STORE.Enable     = flag;             //점(입력용)
         EM_O_ETC.Enable       = flag;
         EM_I_BJDATE.Enable    = flag;  
         EM_I_NPYJDATE.Enable  = flag;
         EM_I_MAJINDATE.Enable = flag;     
         //EM_O_GPWJ_DATE.Enable = flag;
         //enableControl(IMG_EM_O_GPWJ_DATE, flag);
        // enableControl(IMG_BJ_DATE, flag);
        // enableControl(IMG_NPYJ_DATE, flag);
        // enableControl(IMG_MJ_DATE, flag);
     }  



/**
 * checkValidation(Gubun)
 * 작 성 자     : 박래형
 * 작 성 일     : 2010-02-28
 * 개    요        : 조회조건 값 체크 
 * Gubun : Search, Save, Delete
 * return값 : void
 */
function checkValidation(Gubun) {
     
     var messageCode = "USER-1001";

     switch (Gubun) {
     case "Search": 
         if(LC_O_STR.Text.length == 0){                                         // 점
               showMessage(INFORMATION, OK, messageCode, "점");
               LC_O_STR.Focus();
               return false;
         }  
         /*
         if(LC_O_BUMUN.Text.length == 0){                                       // 팀
             showMessage(INFORMATION, OK, messageCode, "팀");
             LC_O_BUMUN.Focus();
             return false;
         }  
         if(LC_O_TEAM.Text.length == 0){                                        // 파트
             showMessage(INFORMATION, OK, messageCode, "파트");
             LC_O_TEAM.Focus();
             return false;
         }  
         if(LC_O_PC.Text.length == 0){                                          // PC
             showMessage(INFORMATION, OK, messageCode, "PC");
             LC_O_PC.Focus();
             return false;
         }  
         */
         if(LC_O_GJDATE.Text.length == 0){                                      // 기준일
             showMessage(INFORMATION, OK, messageCode, "기준일");
             LC_O_GJDATE.Focus();
             return false;
         }

         if(EM_S_START_DT.Text.length == 0){                              // 조회일 정합성
             showMessage(INFORMATION, OK, "USER-1002", "조회시작일");
             EM_S_START_DT.Focus();
             return false;
        }
         if(EM_S_END_DT.Text.length == 0){                              // 조회일 정합성
             showMessage(INFORMATION, OK, "USER-1002", "조회종료일");
             EM_S_END_DT.Focus();
             return false;
        }
         if(EM_S_START_DT.Text > EM_S_END_DT.Text){                             // 조회일 정합성
             showMessage(INFORMATION, OK, "USER-1015");
             EM_S_START_DT.Focus();
             return false;
         }
         return true; 

     }     
}
  
/**
 * showRegMessage(strMsg, obj)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-14
 * 개    요    : DETAIL 그리드 행추가 시 validation체크 메시지창 팝업
 * return값 : void
 */
function showRegMessage(strMsg, obj){
      showMessage(INFORMATION, OK, "USER-1000", strMsg);
      obj.Focus();
   }

/**
 * getMarjinFlag()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-21
 * 개    요 :  마진적용일에 대한 행사구분 콤보로 조회
 * return값 : void
 */
 function getMarginFlag(){
    // 조회조건 셋팅
    var strStrCd        = LC_O_STR.BindColVal;      //점
    var strPumbunCd     = EM_I_PB_CD.Text;          //브랜드
    var strMarginAppDt  = EM_I_MAJINDATE.Text;      //마진적용일
   
    var goTo       = "getMarginFlag" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strPumbunCd="+encodeURIComponent(strPumbunCd)     
                    + "&strMarginAppDt="+encodeURIComponent(strMarginAppDt);    
    TR_S_MAIN.Action="/dps/pord204.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET("+action+":DS_EVENT_FLAG=DS_EVENT_FLAG)"; //조회는 O
    TR_S_MAIN.Post();    
 }   
 
 /**
  * getMarjinRate()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-02-21
  * 개    요 :  마진적용일에 대한 행사구분의행사율을 콤보로 조회
  * return값 : void
  */
  function getMarginRate(objCd){
     // 조회조건 셋팅
     var strStrCd        = LC_O_STR.BindColVal;      //점
     var strPumbunCd     = EM_I_PB_CD.Text;          //브랜드
     var strMarginAppDt  = EM_I_MAJINDATE.Text;      //마진적용일
     var strMarginGbn    = LC_I_HS_GBN.BindColVal;   //행사구분
     
     var goTo       = "getMarginRate" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strPumbunCd="+encodeURIComponent(strPumbunCd)     
                    + "&strMarginAppDt="+encodeURIComponent(strMarginAppDt)
                    + "&strMarginGbn="+encodeURIComponent(strMarginGbn);     
     TR_MAIN.Action="/dps/pord204.po?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_EVENT_RATE=DS_EVENT_RATE)"; //조회는 O
     TR_MAIN.Post(); 
     
     LC_I_HS_RATE.BindColVal = objCd;

  }

  /**
  * getPumbunInfo(pop)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-07
  * 개    요 :  브랜드팝업 관련 데이터 조회 및 세팅
  * return값 : void
  */
  function getPumbunInfo(pop){
      var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
      var strStrCd        = LC_I_STORE.BindColVal;                                     // 점
      var strOrgCd        = "";                                                        // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "0";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "2";                                                       // 단품구분(1:단품, 2:비단품)
      var strSkuType      = "";                                                        // 단품종류(3:의류단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "2";                                                       // 거래형태(1:직매입,2:특정)
      var strSaleBuyFlag  = "";                                                       // 판매분매입구분(1:사전매입)

      if(EM_I_PB_CD.Text != ""){
          setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PB_CD, EM_I_PB_NM, "Y", pop
                                , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                , strBizType,strSaleBuyFlag);
          if(DS_O_RESULT.CountRow == 1){
              
//              alert(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "CHAR_BUYER_NAME"));
//              alert(EM_O_BUYER_NM.Text);
              
              var idx = "";
              
              // 협력사코드
              EM_O_HRS_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD");
              EM_O_HRS_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_NAME");
              
              // 과세구분
              if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "TAX_FLAG") != undefined){
                  idx = DS_TAX_FLAG.ValueRow(1,DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "TAX_FLAG"));
                  EM_TAX_FLAG.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "TAX_FLAG");
                  EM_O_GS_GBN.Text    = DS_TAX_FLAG.NameValue(idx, "NAME");
                  strTaxFlag         = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "TAX_FLAG");
              }else{
                  EM_TAX_FLAG.Text    = "";
                  EM_O_GS_GBN.Text    = "";
                  strTaxFlag         = "";
              }
              
              // 바이어
              EM_O_BUYER_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BUYER_EMP_NAME");
              EM_O_BUYER_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "CHAR_BUYER_CD");

          }
      }else{
          var rtnMap = strPbnPop(EM_I_PB_CD, EM_I_PB_NM, 'Y'
                                 ,strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                 ,strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                 ,strBizType,strSaleBuyFlag);     
          if(rtnMap != null){
              
              EM_O_HRS_CD.Text     = rtnMap.get("VEN_CD");
              EM_O_HRS_NM.Text     = rtnMap.get("VEN_NAME");
    
              var idx = "";
              
              // 과세구분
              if(rtnMap.get("TAX_FLAG") != ""){
                  idx = DS_TAX_FLAG.ValueRow(1,rtnMap.get("TAX_FLAG"));
                  strTaxFlag = DS_TAX_FLAG.ValueRow(1,rtnMap.get("TAX_FLAG"));
                  EM_TAX_FLAG.Text    = DS_TAX_FLAG.ValueRow(1,rtnMap.get("TAX_FLAG"));
                  EM_O_GS_GBN.Text = DS_TAX_FLAG.NameValue(idx, "NAME");
              }else{
                  strTaxFlag      = "";
                  EM_TAX_FLAG.Text = "";
                  EM_O_GS_GBN.Text = "";
              }
              EM_O_BUYER_CD.Text   = rtnMap.get("CHAR_BUYER_CD");
              EM_O_BUYER_NM.Text   = rtnMap.get("BUYER_EMP_NAME");
              
          }
      }
      EM_I_BJDATE.Focus();
      EM_O_BALJUJC.Text = DS_ORD_OWN_FLAG.NameValue(idx, "NAME");     // 발주주체
      LC_I_HS_GBN.Enable = true;
      getMarginFlag();  
      // 저장시 다시 한번 브랜드의 존재여부를 확인하기 위해
      if(DS_O_RESULT.CountRow > 0) return true;
      if(rtnMap != null) return true;
  }
 
  /**
   * getPummokInfo(strPbnPmk)
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-02-21
   * 개    요 :  브랜드별 품목데이터에 정합성 체크
   * return값 : void
   */
  function getPummokInfo(strPbnPmk){
       
//     alert("브랜드에 따른 품목 제대로 체크하나");
      // 조회조건 셋팅
      var strPumbunCd     = EM_I_PB_CD.Text;          //브랜드
      var strPummokCd     = strPbnPmk;          //품목
    
      var goTo       = "getPummokInfo" ;    
      var action     = "O";     
      var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd)     
                     + "&strPummokCd="+encodeURIComponent(strPummokCd);   
      TR_S_MAIN.Action="/dps/pord204.po?goTo="+goTo+parameters;  
      TR_S_MAIN.KeyValue="SERVLET("+action+":DS_PUMMOK_INFO=DS_PUMMOK_INFO)"; //조회는 O
      TR_S_MAIN.Post(); 
      
      if(DS_PUMMOK_INFO.CountRow > 0){
          if(DS_PUMMOK_INFO.NameValue(DS_PUMMOK_INFO.RowPosition, "PUMMOK_CD") == strPbnPmk){
              return true;
          }else{
              return false;
          }
          
      }else{
          return false;
      }
   } 
   
   /**
    * getPbnPmkPop(row, colid, popFlag)
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-08
    * 개    요 :  브랜드에 따른 품목
    * return값 : void
    */
    function getPbnPmkPop(row, colid, popFlag){
        
      var strMummokCd  = DS_IO_DETAIL.NameValue(row,"PUMMOK_CD"); //품목코드
//      var strMummokCNm = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"PUMMOK_NM"); //품목명
      var strPumbunCd  = EM_I_PB_CD.Text;
      
      if(strMummokCd != ""){
         var rtnMap = setPbnPmkNmWithoutToGridPop( "DS_O_RESULT", strMummokCd, "", strPumbunCd, 
                                                  popFlag, "");
          if(rtnMap != null){         
              DS_IO_DETAIL.NameValue(row, "SLIP_NO")    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO");
              DS_IO_DETAIL.NameValue(row, "STR_CD")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
              DS_IO_DETAIL.NameValue(row, "PUMBUN_CD")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");
              DS_IO_DETAIL.NameValue(row, "VEN_CD")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
              DS_IO_DETAIL.NameValue(row, "SLIP_FLAG")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG");
              
              DS_IO_DETAIL.NameValue(row, "PUMMOK_CD")        = rtnMap.get("PUMMOK_CD");
              DS_IO_DETAIL.NameValue(row, "PUMMOK_NM")        = rtnMap.get("PUMMOK_NAME");
              DS_IO_DETAIL.NameValue(row, "TAG_FLAG")         = rtnMap.get("TAG_FLAG");
              DS_IO_DETAIL.NameValue(row, "TAG_PRT_OWN_FLAG") = rtnMap.get("TAG_PRT_OWN_FLAG");
              DS_IO_DETAIL.NameValue(row, "ORD_UNIT_CD")      = rtnMap.get("UNIT_CD");
         }
      }else{
          var rtnList = pbnPmkMultiSelPop(strMummokCd,"",strPumbunCd,"", "", "N");
          
          if(rtnList != null){
              for(var i = 0; i < rtnList.length; i++){
                  if(i != 0 )
                      DS_IO_DETAIL.AddRow();          
                  
                  DS_IO_DETAIL.NameValue(row+i, "SLIP_NO")    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO");
                  DS_IO_DETAIL.NameValue(row+i, "STR_CD")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
                  DS_IO_DETAIL.NameValue(row+i, "PUMBUN_CD")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");
                  DS_IO_DETAIL.NameValue(row+i, "VEN_CD")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
                  DS_IO_DETAIL.NameValue(row+i, "SLIP_FLAG")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG");
                  
                  DS_IO_DETAIL.NameValue(row+i, "PUMMOK_CD")        = rtnList[i].PUMMOK_CD;
                  DS_IO_DETAIL.NameValue(row+i, "PUMMOK_NM")        = rtnList[i].PUMMOK_NAME;
                  DS_IO_DETAIL.NameValue(row+i, "TAG_FLAG")         = rtnList[i].TAG_FLAG;
                  DS_IO_DETAIL.NameValue(row+i, "TAG_PRT_OWN_FLAG") = rtnList[i].TAG_PRT_OWN_FLAG;
                  DS_IO_DETAIL.NameValue(row+i, "ORD_UNIT_CD")      = rtnList[i].UNIT_CD;                  

                  DS_IO_DETAIL.NameValue(row+i, "MG_RATE")          = DS_EVENT_RATE.NameValue(1, "NORM_MG_RATE");
              }
              if(rtnList.length > 1){
                  setFocusGrid(GR_DETAIL, DS_IO_DETAIL,row,"ORD_QTY");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동             
              }
          }
      }
          
      // 단품코드 존재여부 확인을 위해
      if(rtnMap != null) return true;
      else return false;
      
      if(rtnList != null) return true;
      else return false;
    }  
   
   
  /**
   * getPbnPmkPop2()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-08
   * 개    요 :  브랜드에 따른 품목
   * return값 : void
   */
   function getPbnPmkPop2(row, colid){
       
     var strMummokCd  = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"PUMMOK_CD"); //품목코드
     var strMummokCNm = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"PUMMOK_NM"); //품목명
     var strPumbunCd  = EM_I_PB_CD.Text;
     
     if(strMummokCd != ""){
         var rtnMap = setPbnPmkNmWithoutToGridPop( "DS_O_RESULT", strMummokCd, strMummokCNm, strPumbunCd, 
                                                   "0", "");
         if(rtnMap != null){         
             DS_IO_DETAIL.NameValue(row, "PUMMOK_CD")        = rtnMap.get("PUMMOK_CD");
             DS_IO_DETAIL.NameValue(row, "PUMMOK_NM")        = rtnMap.get("PUMMOK_NAME");
             DS_IO_DETAIL.NameValue(row, "TAG_FLAG")         = rtnMap.get("TAG_FLAG");
             DS_IO_DETAIL.NameValue(row, "TAG_PRT_OWN_FLAG") = rtnMap.get("TAG_PRT_OWN_FLAG");
             DS_IO_DETAIL.NameValue(row, "ORD_UNIT_CD")      = rtnMap.get("UNIT_CD");
         }
         
     // 단품코드 존재여부 확인을 위해
     if(rtnMap != null) return true;
     else return false;
     }
  }
   
   /**
    * chkPayClose()
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-08-12
    * 개    요 :  대금지불 마감 체크
    * return값 : void
    */
    function chkPayClose(row, strStrCd, strVenCd, strChkDt){
    	
    	
       var goTo       = "chkPayClose" ;    
       var action     = "O";     
       var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                      + "&strVenCd="+encodeURIComponent(strVenCd)     
                      + "&strChkDt="+encodeURIComponent(strChkDt);     
       TR_MAIN.Action="/dps/pord204.po?goTo="+goTo+parameters;  
       TR_MAIN.KeyValue="SERVLET("+action+":DS_PAY_CLOSE_CHK=DS_PAY_CLOSE_CHK)"; //조회는 O
       TR_MAIN.Post(); 
       if(DS_PAY_CLOSE_CHK.NameValue(DS_PAY_CLOSE_CHK.RowPosition, "RET_FLAG") == "TRUE"){
           showMessage(INFORMATION, OK, "USER-1220", "대금지불");
           setFocusGrid(GR_MASTER, DS_LIST ,row, "CHECK1");      // 선택으로 포커스
           return false;
       }else{
           return true;
       }
       
        return true;
    }
   
    /**
    * dayCloseCheck(strToday, masterChkCnt)
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-08-24
    * 개    요    : 확정시 일시재마감체크한다
    * return값 : void
    */
    function dayCloseCheck(strToday, row){
        //alert("row = " + row);
        var strStrCd         = LC_I_STORE.BindColVal;  // 점
        var strCloseDt       = strToday;               // 마감체크일자
        var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
        var strCloseUnitFlag = "06";                   // 단위업무
        var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
        var strCloseFlag     = "T";                    // 마감구분(시재마감)
       
        var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                      , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
        
        if(closeFlag == "TRUE"){
            showMessage(INFORMATION, OK, "USER-1150", "시재마감","검품확정");
            setFocusGrid(GR_MASTER, DS_LIST ,row, "CHECK1");      // 선택으로 포커스
            return false;
        }else{
            return true;
        }
    }  
	
	/**
	* closeCheck()
	* 작 성 자 : 박래형
	* 작 성 일 : 2010-03-10
	* 개    요    : 저장시 일마감체크를 한다.
	* return값 : void
	*/
	function closeCheck(strChkDt, row){
	 //alert("row = " + row);
	    var strStrCd         = LC_I_STORE.BindColVal;  // 점
	    var strCloseDt       = strChkDt;               // 마감체크일자
	    var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
	    var strCloseUnitFlag = "42";                   // 단위업무
	    var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
	    var strCloseFlag     = "M";                    // 마감구분(월마감:M)
	   
	    var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
	                                  , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
	    
	    if(closeFlag == "TRUE"){
	        showMessage(INFORMATION, OK, "USER-1220", "매입월");
	        setFocusGrid(GR_MASTER, DS_LIST ,row, "CHECK1");      // 선택으로 포커스
	        return false;
	    }else{
	        return true;
	    }
	}  


  /**
   * calDetail2(row)
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-18
   * 개    요    : 디테일 변경시 원가 금액 매가 금액 계산
   * return값 : void
   */ 
     
   function calDetail2(row){         
	   var strTaxFlag = EM_TAX_FLAG.Text;
	   var chk_qty    = DS_IO_DETAIL.NameValue(row, "CHK_QTY");                // 검품수량
	   var cost_prc   = 0;                                                     // 원가단가
	   var sale_prc   = DS_IO_DETAIL.NameValue(row, "NEW_SALE_PRC");           // 매가단가
	   var cost_amt   = 0;                                                     // 원가금액         
	   var sale_amt   = 0;                                                     // 매가금액
	   var strMargin  = parseInt(DS_IO_DETAIL.NameValue(row, "MG_RATE"));      // 마진율     (Grid)    
	   
       // DETAIL---------------------------------------------------------------------------
       // 매가금액
	   sale_amt  = sale_prc * chk_qty;    
	   DS_IO_DETAIL.NameValue(row, "NEW_SALE_AMT") = sale_amt;            // 매가금액

	   // 원가금액
	   cost_amt = getCalcPord("COST_PRC", "", sale_amt, strMargin, strTaxFlag, roundFlag); 
	   DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT") = cost_amt; 

	   //원가단가
	   DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC") = getRoundDec("1", cost_amt / chk_qty, 0);

	   //디테일 차익액
	   var gapAmt     = getCalcPord("GAP_AMT", cost_amt, sale_amt, "", strTaxFlag, roundFlag);       
	   DS_IO_DETAIL.NameValue(row, "NEW_GAP_AMT")  = gapAmt;      // 차익액

       //20100524 부가세 추가
       var vatAmt = getCalcPord("VAT_AMT", cost_amt, "", "", strTaxFlag, roundFlag);
       DS_IO_DETAIL.NameValue(row, "VAT_AMT") = vatAmt;      // 부가세
       // DETAIL---------------------------------------------------------------------------
       
       // MASTER---------------------------------------------------------------------------
       // 수량, 매가합
	   EM_O_SRG.Text  = DS_IO_DETAIL.NameSum("CHK_QTY",0,0);
	   EM_O_MGG.Text  = DS_IO_DETAIL.NameSum("NEW_SALE_AMT",0,0);
	   var totSaleAmt = DS_IO_DETAIL.Sum(17,0,0);

       // 원가합 재계산
       var totCostAmt = getCalcPord("COST_PRC", "", totSaleAmt, strMargin, strTaxFlag, roundFlag); 
       DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NEW_COST_TAMT") = totCostAmt;
       
       // VAT합 재계산
       DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VAT_TAMT") = getCalcPord("VAT_AMT", totCostAmt, "", "", strTaxFlag, roundFlag);

       //20100524 차익액합계
	   var totGapAmt  = getCalcPord("GAP_AMT", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
	   DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAP_TOT_AMT")  = totGapAmt;
	
	   //20100524 차익율 추가
	   var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
	   DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NEW_GAP_RATE") = totGapRate;
       // MASTER---------------------------------------------------------------------------
 } 

   /**
    * calDetail(row)
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-18
    * 개    요    : 디테일 원가금액변경시
    * return값 : void
    */ 
      
    function calDetail(row){  
        var strTaxFlag = EM_TAX_FLAG.Text;
        var chk_qty    = DS_IO_DETAIL.NameValue(row, "CHK_QTY");                // 검품수량
        var cost_amt   = DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT");           // 원가금액         
        var sale_amt   = DS_IO_DETAIL.NameValue(row, "NEW_SALE_AMT");           // 매가금액
        var strMargin  = parseInt(DS_IO_DETAIL.NameValue(row, "MG_RATE"));      // 마진율     (Grid)    
        
        //디테일 차익액
        var gapAmt = getCalcPord("GAP_AMT", cost_amt, sale_amt, "", strTaxFlag, roundFlag);       
        DS_IO_DETAIL.NameValue(row, "NEW_GAP_AMT")  = gapAmt;      // 차익액
             
        //20100524 차익액합계
        var totGapAmt  = DS_IO_DETAIL.Sum(13,0,0);
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAP_TOT_AMT")  = totGapAmt;
     
        //20100524 차익율 추가
        var totCostAmt = DS_IO_DETAIL.Sum(15,0,0);
        var totSaleAmt = DS_IO_DETAIL.Sum(17,0,0);  
                  
        var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NEW_GAP_RATE") = totGapRate;
        
        //20100523 부가세 추가
        var vatAmt     = getCalcPord("VAT_AMT",  cost_amt,   "",         "", strTaxFlag, roundFlag);
        DS_IO_DETAIL.NameValue(row, "VAT_AMT")      = vatAmt;      // 부가세
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VAT_TAMT")  = DS_IO_DETAIL.Sum(11,0,0);
        
        EM_O_SRG.Text  = DS_IO_DETAIL.NameSum("CHK_QTY",0,0);
        EM_O_WGG.Text  = DS_IO_DETAIL.NameSum("NEW_COST_AMT",0,0);
        EM_O_MGG.Text  = DS_IO_DETAIL.NameSum("NEW_SALE_AMT",0,0);
  } 
  
  /**
  * setTempEvnDataset()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-17
  * 개    요    : 행사구분, 행사율에 적용할 데이터셋을 임시로 지정
  * return값 : void
  */
  function setTempEvnDataset(){
      for(var i = 0; i < 100; i++){
          DS_SETEVNFLAG.Addrow();
          if(i < 10){
              DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG") = '0' + i;
              DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG_NM") = '0' + i;
          }else{
              DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG") = i;    
              DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG_NM") = i;       
          }
      }   
  }
 
  /**
  * setEventFlagDs()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-17
  * 개    요    : 행사구분 데이터셋 복사
  * return값 : void
  */
  
  function setEventFlagDs(){

      DS_EVENT_FLAG.ClearData();         //복사될 데이터셋 초기화  
      DS_EVENT_RATE.ClearData();         //복사될 데이터셋 초기화  
      var setEvnFlag = DS_SETEVNFLAG.ExportData(1,DS_SETEVNFLAG.CountRow, true ); 
      DS_EVENT_FLAG.ImportData(setEvnFlag);
      DS_EVENT_RATE.ImportData(setEvnFlag);      
//      alert("DS_EVENT_FLAG = "+ DS_EVENT_FLAG.CountRow); 
//      alert("DS_EVENT_RATE = "+ DS_EVENT_RATE.CountRow);      
  }
  
  /**
   * searchPumbunPop()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-18
   * 개    요 :  조회조건 브랜드팝업
   * return값 : void
   */
   function searchPumbunPop(){
       var tmpOrgCd        = LC_O_STR.BindColVal + LC_O_BUMUN.BindColVal + LC_O_TEAM.BindColVal + LC_O_PC.BindColVal;
       var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
       var strStrCd        = LC_O_STR.BindColVal;                                       // 점
       var strOrgCd        = replaceStr(tmpOrgCd,"%","00")+"00";                        // 조직코드
       var strVenCd        = "";                                                        // 협력사
       var strBuyerCd      = "";                                                        // 바이어
       var strPumbunType   = "";                                                       // 브랜드유형
       var strUseYn        = "Y";                                                       // 사용여부
       var strSkuFlag      = "2";                                                       // 단품구분(2:비단품)
       var strSkuType      = "";                                                        // 단품종류(1:규격단품)
       var strItgOrdFlag   = "";                                                        // 통합발주여부
       var strBizType      = "2";                                                       // 거래형태(1:직매입) 
       var strSaleBuyFlag  = "";                                                       // 판매분매입구분

       var rtnMap = strPbnPop( EM_S_PB_CD, EM_S_PB_NM, 'Y'
                              , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                              , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                              , strBizType,strSaleBuyFlag);

   }


   /**
   * pumbunValCheck()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-22
   * 개    요 :  브랜드  Validation Check
   * return값 : void
   */
   function pumbunValCheck(){
       var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
       var strStrCd        = LC_O_STR.BindColVal;                                         // 점
       var strOrgCd        = "";                                                        // 조직코드
       var strVenCd        = "";                                                        // 협력사
       var strBuyerCd      = "";                                                        // 바이어
       var strPumbunType   = "";                                                        // 브랜드유형
       var strUseYn        = "Y";                                                       // 사용여부
       var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
       var strSkuType      = "2";                                                       // 단품종류(1:규격단품)
       var strItgOrdFlag   = "";                                                        // 통합발주여부
       var strBizType      = "2";                                                        // 거래형태(1:직매입,2:특정)
       var strSaleBuyFlag  = "";                                                       // 판매분매입구분(1:사전매입)

       var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PB_CD, EM_I_PB_NM, "Y", "0"
             , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
             , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
             , strBizType,strSaleBuyFlag);

       if(DS_O_RESULT.CountRow == 0)
           return true;
       else
           return false;
   }
   
   /**
    * getVenInfo(code, name)
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-18
    * 개    요 :  브랜드에 따른 협력사 팝업
    * return값 : void
    */
   function getVenInfo(code, name){
       var strStrCd        = LC_O_STR.BindColVal;                                       // 점
       var strUseYn        = "Y";                                                       // 사용여부
       var strPumBunType   = "";                                                       // 브랜드유형(0:정상)
       var strBizType      = "2";                                                       // 거래형태
       var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
       var strBizFlag      = "";                                                        // 거래구분       

       var rtnMap = venPop(code, name
                            ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                            ,strBizFlag);
   }
   
   

   /**
    * searchPumbunNonPop()
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-27
    * 개    요 :  조회조건 브랜드팝업
    * return값 : void
    */
    function searchPumbunNonPop(){   
        var tmpOrgCd        = LC_O_STR.BindColVal + LC_O_BUMUN.BindColVal + LC_O_TEAM.BindColVal + LC_O_PC.BindColVal;
        var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
        var strStrCd        = LC_O_STR.BindColVal;                                       // 점
        var strOrgCd        = replaceStr(tmpOrgCd,"%","00")+"00";                        // 조직코드
        var strVenCd        = "";                                                        // 협력사
        var strBuyerCd      = "";                                                        // 바이어
        var strPumbunType   = "";                                                       // 브랜드유형
        var strUseYn        = "Y";                                                       // 사용여부
        var strSkuFlag      = "2";                                                       // 단품구분(2:비단품)
        var strSkuType      = "";                                                        // 단품종류(1:규격단품)
        var strItgOrdFlag   = "";                                                        // 통합발주여부
        var strBizType      = "2";                                                       // 거래형태(1:직매입) 
        var strSaleBuyFlag  = "";                                                       // 판매분매입구분

        var rtnMap =  setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PB_CD, EM_S_PB_NM, "Y", "1"
                                  , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                  , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                  , strBizType,strSaleBuyFlag);       
        if(rtnMap != null){
            EM_S_PB_CD.Text = rtnMap.get("PUMBUN_CD");
            EM_S_PB_NM.Text = rtnMap.get("PUMBUN_NAME");
            return true;
        }else{
            return false;
        }       
    }

    /**
     * getVenNonInfo(code, name)
     * 작 성 자 : 박래형
     * 작 성 일 : 2010-03-18
     * 개    요 :  브랜드에 따른 협력사 팝업
     * return값 : void
     */
    function getVenNonInfo(code, name){
        var strStrCd        = LC_O_STR.BindColVal;                                       // 점
        var strUseYn        = "Y";                                                       // 사용여부
        var strPumBunType   = "";                                                       // 브랜드유형(0:정상)
        var strBizType      = "2";                                                       // 거래형태
        var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
        var strBizFlag      = "";                                                        // 거래구분
        
        var rtnMap = setRepVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                                            ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                            ,strBizFlag);
        if(rtnMap != null){
            EM_S_VEN_CD.Text = rtnMap.get("VEN_CD");
            EM_S_VEN_NM.Text = rtnMap.get("VEN_NAME");
            return true;
        }else{
            return false;
        }    
    }

    /**
     * chkMgRate(strStrCd, strSlipNo, strSendFlag)
     * 작 성 자 : 박래형
     * 작 성 일 : 2010-07-24
     * 개    요    : 확정시 비단품 마진적용일 체크
     * return값 : void
     */
     function chkMgRate(strStrCd, strSlipNo, strSendFlag, rowPosition){    
       
       var strreturnValue = "";
       
       var goTo       = "chkMgRate" ;    
       var action     = "O";     
       var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                      + "&strSlipNo="+encodeURIComponent(strSlipNo) 
                      + "&strSendFlag="+encodeURIComponent(strSendFlag);  
       TR_MG_RATE.Action="/dps/pord204.po?goTo="+goTo+parameters;  
       TR_MG_RATE.KeyValue="SERVLET("+action+":DS_MG_RATE=DS_MG_RATE)"; //조회는 O
       TR_MG_RATE.Post(); 
       
       strreturnValue = parseInt(DS_MG_RATE.NameValue(1, "RETURN_INT"));             
       var ssssmmm    = DS_MG_RATE.NameValue(1, "RETURN_MESSAGE");
       if(strreturnValue != 0){  
           setFocusGrid(GR_MASTER, DS_LIST, rowPosition, "CHECK1");      // 선택으로 포커스
           showMessage(EXCLAMATION, OK, "SCRIPT-1000", ssssmmm);
           return false;
       }
       return true;
     }

/**
 * checkTaxYn(strStrCd, strSlipNo, strSendFlag)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-07-24
 * 개    요    : 확정시 비단품 마진적용일 체크
 * return값 : void
 */
 function checkTaxYn(strStrCd, strSlipNo, rowPosition){    
	 var strreturnValue = "";
	 
	 var goTo       = "checkTaxYn" ;    
	 var action     = "O";     
	 var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
	                + "&strSlipNo="+encodeURIComponent(strSlipNo);  
	 TR_MG_RATE.Action="/dps/pord204.po?goTo="+goTo+parameters;  
	 TR_MG_RATE.KeyValue="SERVLET("+action+":DS_TAX_YN=DS_TAX_YN)"; //조회는 O
	 TR_MG_RATE.Post(); 

     strreturnValue = DS_TAX_YN.NameValue(1, "TAX_YN_FLAG");     
	 var ssssmmm = "이미 매입세금계산서가 생성되었습니다. 확인바랍니다.";
	 if(strreturnValue == "Y"){  
	     setFocusGrid(GR_MASTER, DS_LIST, rowPosition, "CHECK1");      // 선택으로 포커스
	     showMessage(EXCLAMATION, OK, "SCRIPT-1000", ssssmmm);
	     return false;
	 }
	 return true;
 }

   /**
    * checkChkDt(strOrdDt, strChkDt)
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-08-03
    * 개    요    : 발주일에 따른 검품확정일 체크
    * return값 : void
    */
    function checkChkDt(strOrdDt, strChkDt, strAftOrdFlag){    

    	//var strToday = "20101231";
    	
    	//사전전표일경우
    	if(strAftOrdFlag == "0"){
            //시스템일자가 검품확정일보다 클 경우
            if(strToday > strChkDt){     
                
                //발주월이 시스템월보다 크거나 같을 경우
                if(strOrdDt.substring(0, 6) >= strToday.substring(0, 6)){                            
                      showMessage(EXCLAMATION, OK, "USER-1020", "검품확정일","시스템일자");
                      //return false;
                      
                //발주월이 시스템월보다 작을 경우      
                }else if(strOrdDt.substring(0, 6) < strToday.substring(0, 6)){   
                    
                    //검품확정일이 발주월의 마지막 날이면
                    if((strChkDt.substring(0, 6) == strOrdDt.substring(0, 6)) && (strChkDt.substring(0, 6) != setDateAdd("D", 1, strChkDt).substring(0, 6))){    
                        //alert("검품확정일이 해당달의 마지막 날임.");
                        return true;

                    //발주월과 검품확정월이 같으면        
                    }else if(strChkDt.substring(0, 6) == strOrdDt.substring(0, 6)){                                                                           
                        showMessage(EXCLAMATION, OK, "USER-1214");
                        return false;
                        
                    //검품확정일이 그달의 마지막 일자가 아니면    
                    }else{                                                                           
                          showMessage(EXCLAMATION, OK, "USER-1213");
                          return false;
                    }
                }
            }
    	}        
	    return true;
    }
  
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

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_MG_RATE event=onSuccess>
    for(i=0;i<TR_MG_RATE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MG_RATE.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_S_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_S_MAIN.ErrorMsg);
    for(i=1;i<TR_S_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_S_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<script language=JavaScript for=TR_MG_RATE event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MG_RATE.ErrorCode + "\n" + "ErrorMsg  : " + TR_MG_RATE.ErrorMsg);
    for(i=1;i<TR_MG_RATE.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MG_RATE.SrvErrMsg('GAUCE',i));
    }
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--  ===================DS_IO_MASTER============================ -->
<!-- Grid DS_IO_MASTER 변경시 DS_IO_DETAIL의 마스터 내용 변경 -->

<!--  ===================DS_IO_MASTER============================ -->

<script language=JavaScript for=DS_LIST event=CanRowPosChange(row)>

//    setEventFlagDs();  //행사구분 행사율 데이터셋 복사
    var strSlipNo       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO");          // 발주번호
    var strSlipProcStat = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_PROC_STAT");   // 전표상태
    
    if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){ // || DS_IO_MASTER.IsUpdated
        if(showMessage(INFORMATION, YESNO, "GAUCE-1000", "변경된 내역이 있습니다. <br> 이동 하시겠습니까?") != 1 )
            return false;
    }else{
        return true;
    }    
</script>

<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)>

    /*
    for(var x = 0; x<= DS_LIST.CountRow; x++){
        if(this.NameValue(x, "CHECK1") == "T"){
            g_listChkCnt = g_listChkCnt;
        }
    }
    */
    //alert("로우체인지 g_listChkCnt = " + g_listChkCnt);
    
    var strSlipNo       = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_NO");          // 발주번호
    var strSlipProcStat = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_PROC_STAT");   // 전표상태

    if(clickSORT)
        return;
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        if(strSlipNo != ""){
            setEventFlagDs();  //행사구분 행사율 데이터셋 복사
            getMaster();
            getDetail();        
        }      
        if(strSlipNo !=""){
            if(inta <= 1){  
                setPorcCount("SELECT", GR_MASTER);
                inta++;
            }else{
                setPorcCount("SELECT", DS_IO_DETAIL.CountRow);      
            }           
        }
    }  
     
    var strSlipNo       = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_NO");          // 발주번호
    var strSlipProcStat = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_PROC_STAT");   // 전표상태
   
    
    if(strSlipProcStat !="09"  ){
       //GR_DETAIL.Editable  = true;
       setObject(false);
       if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "AFT_ORD_FLAG")=='0'){
    	   EM_O_GPWJ_DATE.Enable   = true;
    	   enableControl(IMG_EM_O_GPWJ_DATE, true);
       }
    	   
    }else{
       //GR_DETAIL.Editable  = false;
       EM_O_GPWJ_DATE.Enable   = false;
       enableControl(IMG_EM_O_GPWJ_DATE, false);
       setObject(false);
    }
       
</script>

<script language=JavaScript for=DS_LIST event=OnColumnChanged(row,colid)>

	g_listChkCnt = 0;
	if(colid == "CHECK1" ){
	    for(var x = 1; x<= DS_LIST.CountRow; x++){
	        if(this.NameValue(x, "CHECK1") == "T"){
	            g_listChkCnt = g_listChkCnt + 1;
	        }
	    }	
	    //alert("선택 체크 g_listChkCnt = " + g_listChkCnt);
	}
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
</script>

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>

  if (DS_IO_MASTER.NameValue(row,"AFT_ORD_FLAG")== '0'){
	 EM_O_GPWJ_DATE.Enable   = true;
	 enableControl(IMG_EM_O_GPWJ_DATE, true); 
  }else{
	 EM_O_GPWJ_DATE.Enable   = false;  
	 enableControl(IMG_EM_O_GPWJ_DATE, false); 
  }

  if (DS_IO_MASTER.NameValue(row,"TAX_FLAG")== '1'){
      GR_DETAIL.ColumnProp("VAT_AMT", "Edit")    = "Numeric";
      
  }else{
      GR_DETAIL.ColumnProp("VAT_AMT", "Edit")    = "None";
	  
  }
</script>

<script language=JavaScript for=DS_IO_MASTER
	event=OnColumnChanged(row,colid)>
/*
    var strBjDt = DS_IO_MASTER.NameValue(row,"ORD_DT");     //발주일
    var strNpDt = DS_IO_MASTER.NameValue(row,"DELI_DT");    //납품예정일
    var strMgDt = DS_IO_MASTER.NameValue(row,"MG_APP_DT");  //마진적용일
    var strGpDt = DS_IO_MASTER.NameValue(row,"CHK_DT");  //검품확정일
        
    var strBuyerCd = EM_O_BUYER_CD.Text;
    
    var nextDay = addDate("d", 1, strToday);
    
    if(colid == "CHK_DT"){
       if(strGpDt < strToday){
          showMessage(INFORMATION, OK, "USER-1020", "검품확정일","금일");
          EM_O_GPWJ_DATE.Text = strToday; 
       }
     }
*/
</script>
<!--  ===================DS_IO_DETAIL============================ -->
<!--  DS_IO_DETAIL 변경시 -->
<script language="javascript"  for=GR_DETAIL event=CanColumnPosChange(Row,Colid)>

	var ord_qty  = DS_IO_DETAIL.NameValue(Row, "ORD_QTY");   // 발주수량
	var chk_qty  = DS_IO_DETAIL.NameValue(Row, "CHK_QTY");   // 검품수량
	
	switch (Colid) {    
	   case "CHK_QTY":  
	      if(DS_IO_DETAIL.NameValue(Row, "CHK_QTY") > DS_IO_DETAIL.NameValue(Row, "ORD_QTY")){
	         showMessage(INFORMATION, OK, "USER-1021", "검품수량","발주수량");
	         return false;
	      }
	      return true;
	      break;  
	}   
   
</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>

    var ord_qty  = this.NameValue(row, "ORD_QTY");   // 발주수량
    var chk_qty  = this.NameValue(row, "CHK_QTY");   // 검품수량
    
    switch (colid) {    
       case "CHK_QTY": 
          calDetail2(row);          
          break;  
       case "VAT_AMT":
    	   //alert("부가세 = " + DS_IO_DETAIL.Namevalue(row, colid))
           EM_TOT_TAX.Text      = DS_IO_DETAIL.Sum(11,0,0);
           break; 
       case "NEW_COST_AMT":
           calDetail(row);  
    	   break;
    }   

</script>

<!-- 마스터 그리드 헤더 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_MASTER event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHECK1") {
        if (bCheck == 1) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHECK1") = "T";
            }    
            GR_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHECK1") = "F";
            } 
            GR_MASTER.Redraw = true;
        }
    }
</script>

<!-- 디테일 삭제시 컴퍼넌트 총금액-->
<script language=JavaScript for=DS_IO_DETAIL event=OnRowDeleted(row)>   
    calDetail2(row);

</script>


<!-- 디테일 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_DETAIL
	event="OnHeadCheckClick(Col,Colid,bCheck)">       
 </script>

<!--  ===================GR_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>

sortColId( eval(this.DataID), row, colid);

</script>
<!--  ===================GR_DETAIL============================ -->
<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
    setObject(false);               //디테일 그리드 클릭시 우츨 입력부 비활성화
    
    EM_I_PB_CD.Enable = false;     //디테일 그리드 브랜드코드 팝업 비활성화
  //  enableControl(IMG_PUMBUN_CD, false);

</script>
<!-- Grid GR_DETAIL OnExit event 처리 -->
<!-- 그리드 내용 변경시 금액 및 총수량, 금액 변경  -->
<script language=JavaScript for=GR_DETAIL
	event=OnExit(row,colid,olddata)>
//var strW_Dan_AMT = parseInt(DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC"));  

</script>


<!-- DETAIL 그리드 품목코드 팜업 -->
<script language=JavaScript for=GR_DETAIL event=OnPopup(row,colid,data)>
</script>


<!--*************************************************************************-->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_O_STR event=OnSelChange()>
    if(LC_O_STR.BindColVal != "%"){
        getDept("DS_O_DEPT", "Y", LC_O_STR.BindColVal, "Y");                                              // 팀 
        LC_O_BUMUN.Index = 0;
    }
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
    EM_S_VEN_CD.Text = "";
    EM_S_VEN_NM.Text = "";
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_O_BUMUN event=OnSelChange()>
    if(LC_O_BUMUN.BindColVal != "%"){
        getTeam("DS_O_TEAM", "Y", LC_O_STR.BindColVal, LC_O_BUMUN.BindColVal, "Y");                       // 파트  
    }else{
        DS_O_TEAM.ClearData();
        insComboData( LC_O_TEAM, "%", "전체",1);
        DS_O_PC.ClearData();
        insComboData( LC_O_PC, "%", "전체",1);
    }
    LC_O_TEAM.Index = 0;
</script>

<!-- 파트(조회)  변경시  -->
<script language=JavaScript for=LC_O_TEAM event=OnSelChange()>
    if(LC_O_TEAM.BindColVal != "%"){
        getPc("DS_O_PC", "Y", LC_O_STR.BindColVal, LC_O_BUMUN.BindColVal, LC_O_TEAM.BindColVal, "Y");     // PC  
    }else{
        DS_O_PC.ClearData();
        insComboData( LC_O_PC, "%", "전체",1);
    }
    LC_O_PC.Index = 0;
</script>

<!-- 사후구분(입력)  변경시  -->
<script language=JavaScript for=LC_I_SH_GBN event=OnSelChange()>
</script>


<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PB_CD event=onKillFocus()>
    
    if(EM_S_PB_CD.Text != ""){
        if(EM_S_PB_CD.Text.length == 6){
            searchPumbunNonPop();
        }else{
            searchPumbunPop();
        }   
    }else
        EM_S_PB_NM.Text = "";  
        
</script>


<!-- 조회부 협력사 OnKeyUp 
 <script language=JavaScript for=EM_S_VEN_CD event=OnKeyUp(kcode,scode)> 
    if(EM_S_VEN_NM.Text != ""){
        EM_S_VEN_NM.Text  = "";
    }
    if(EM_S_VEN_CD.Text.length == 6){
        getVenNonInfo(EM_S_VEN_CD, EM_S_VEN_NM);
    }
</script>
-->


<!-- 조회부 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
//    if(!this.Modified)
//        return;    
    if(EM_S_VEN_CD.Text != "")
        getVenNonInfo(EM_S_VEN_CD, EM_S_VEN_NM);
    else{
        EM_S_VEN_CD.Text = "";
        EM_S_VEN_NM.Text = ""        
    }
</script>




<!-- 점(입력)  변경시  -->
<script language=JavaScript for=LC_I_STORE event=OnSelChange()>  
</script>


<!-- 브랜드코드/명 조회-->
<script language=JavaScript for=EM_I_PB_CD event=onKillFocus()>
</script>


<!-- 행사구분 변경시 행사율 변경 -->
<script language=JavaScript for=LC_I_HS_GBN event=OnSelChange()>
//        getMarginRate();
</script>



<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_START_DT event=OnKillFocus()>
	var strSyyyymmdd = strToday.substring(0,6) + "01";
	checkDateTypeYMD( EM_S_START_DT, strSyyyymmdd );;
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_END_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_END_DT );
</script>

<!-- 발주일 변경시  -->
<script lanaguage=JavaScript for=EM_I_BJDATE event=OnKillFocus()>
    checkDateTypeYMD( EM_I_BJDATE );
</script>

<!-- 납품예정일 변경시  -->
<script lanaguage=JavaScript for=EM_I_NPYJDATE event=OnKillFocus()>
    checkDateTypeYMD( EM_I_NPYJDATE );
</script>

<!-- 검품확정일 변경시  -->
<script lanaguage=JavaScript for=EM_O_GPWJ_DATE event=OnKillFocus()>

    checkDateTypeYMD( EM_O_GPWJ_DATE );
</script>

<!-- 마진적용일 변경시  -->
<script lanaguage=JavaScript for=EM_I_MAJINDATE event=OnKillFocus()>
    checkDateTypeYMD( EM_I_MAJINDATE );
</script>

<!-- 비고 KillFocus -->
<script language=JavaScript for=EM_O_ETC event=onKillFocus()>  
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "REMARK", "비고", "EM_O_ETC");
</script>

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
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DEPT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_TEAM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_PC" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_GJDATE_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PROC_STAT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_PUMMOK_INFO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CHK_SLIP_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_AFT_ORD_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_PAY_COND" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_LIST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>  

<comment id="_NSID_">
<object id="DS_MASTER_TMP" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script> 
<comment id="_NSID_">
<object id="DS_DETAIL_TMP" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>  

<comment id="_NSID_">
<object id="DS_O_STORE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_EVENT_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_EVENT_RATE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_ORD_OWN_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_TAX_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_TAG_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_TAG_PRT_OWN_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_ORD_UNIT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_SETEVNFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_SETEVNRATE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_PUMMOK_INFO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_MG_RATE"     classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_PAY_CLOSE_CHK"     classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_TAX_YN"     classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_L_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MG_RATE" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GR_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
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

<DIV id="testdiv" class="testdiv">

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
						<th class="point" width="70">점</th>
						<td width="110"><comment id="_NSID_"> <object
							id=LC_O_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="70" class="point">팀</th>
						<td width="110"><comment id="_NSID_"> <object
							id=LC_O_BUMUN classid=<%=Util.CLSID_LUXECOMBO%> width=100
							align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="70" class="point">파트</th>
						<td width="110"><comment id="_NSID_"> <object
							id=LC_O_TEAM classid=<%=Util.CLSID_LUXECOMBO%> width=100
							align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="70" class="point">PC</th>
						<td><comment id="_NSID_"> <object id=LC_O_PC
							classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"
							tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point" width="70">기준일</th>
						<td width="110"><comment id="_NSID_"> <object
							id=LC_O_GJDATE classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th class="point" width="70">조회기간</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_START_DT classid=<%=Util.CLSID_EMEDIT%> width=75
							tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_START_DT)" align="absmiddle" />
						~ <comment id="_NSID_"> <object id=EM_S_END_DT
							classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1
							align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_END_DT)" align="absmiddle" />
						</td>
						<th width="70">전표상태</th>
						<td><comment id="_NSID_"> <object id=LC_O_JPST
							classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"
							tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>브랜드</th>
                        <td colspan="3"><comment id="_NSID_"> <object id=EM_S_PB_CD
                            classid=<%=Util.CLSID_EMEDIT%> width=88 tabindex=1
                            align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                            align="absmiddle"
                            onclick="javascript:searchPumbunPop();" />
                            <comment id="_NSID_">
                            <object id=EM_S_PB_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=184 tabindex=1
                            align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                        <th>협력사</th>
                        <td colspan="3"><comment id="_NSID_"> <object id=EM_S_VEN_CD
                            classid=<%=Util.CLSID_EMEDIT%> width=88 tabindex=1
                            align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                            align="absmiddle"
                            onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM);" />
                            <comment id="_NSID_">
                            <object id=EM_S_VEN_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=184 tabindex=1
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
					</tr>
					<tr>
						<th width="70">전표구분</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=RD_S_SLIP_FLAG classid=<%=Util.CLSID_RADIO%>
							style="height: 20; width: 150" tabindex=1>
							<param name=Cols value="3">
							<param name=Format value="%^전체,A^매입,B^반품">
							<param name=CodeValue value="%">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th>전표번호</th>
                        <td colspan="3">
                          <comment id="_NSID_"> 
                              <object id=EM_S_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=113 tabindex=1 align="absmiddle"> </object> 
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="200">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"> <OBJECT id=GR_MASTER
							width=600 height=712 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_LIST">
                            <Param Name="ViewSummary" value="1">
						</OBJECT> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td class="PL10">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="PT01 PB03">
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">

							<tr>
								<th width="70">점</th>
								<td width="110"><comment id="_NSID_"> <object
									id=LC_I_STORE classid=<%=Util.CLSID_LUXECOMBO%> width=100
									align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
								<th width="90">전표번호</th>
								<td width="130"><comment id="_NSID_"> <object
									id=EM_O_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
								<th width="70">전표상태</th>
								<td><comment id="_NSID_"> <object
									id=EM_O_SLIP_PROC_STAT_NM classid=<%=Util.CLSID_EMEDIT%>
									width=100 tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th>전표구분</th>
								<td><comment id="_NSID_"> <object id=RD_SLIP_FLAG
									classid=<%=Util.CLSID_RADIO%> tabindex=1
									style="height: 20; width: 100">
									<param name=Cols value="2">
									<param name=Format value="A^매입,B^반품">
									<param name=CodeValue value="A">
								</object> </comment> <script> _ws_(_NSID_);</script></td>
								<th>사후구분</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=LC_I_SH_GBN classid=<%=Util.CLSID_LUXECOMBO%> width=100
									align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th>브랜드</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> <object
                                    id=EM_I_PB_CD classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                    <comment id="_NSID_"> <object
                                    id=EM_I_PB_NM classid=<%=Util.CLSID_EMEDIT%> width=213
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
								<th>발주주체</th>
								<td><comment id="_NSID_"> <object id=EM_O_BALJUJC
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 value="0"
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th>협력사</th>
                                <td colspan="3">
                                    <comment id="_NSID_"> <object
                                    id=EM_O_HRS_CD classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                     <comment id="_NSID_"> <object
                                    id=EM_O_HRS_NM classid=<%=Util.CLSID_EMEDIT%> width=213
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
								<th>과세구분</th>
								<td><comment id="_NSID_"> <object id=EM_O_GS_GBN
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th>발주일</th>
								<td><comment id="_NSID_"> <object id=EM_I_BJDATE
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
								<th>발주확정일</th>
								<td><comment id="_NSID_"> <object
									id=EM_I_BJHJDATE classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>바이어</th>
								<td><comment id="_NSID_"> <object
									id=EM_O_BUYER_CD classid=<%=Util.CLSID_EMEDIT%> width=50
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								<comment id="_NSID_"> <object id=EM_O_BUYER_NM
									classid=<%=Util.CLSID_EMEDIT%> width=48 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th>납품예정일</th>
								<td><comment id="_NSID_"> <object
									id=EM_I_NPYJDATE classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>검품확정일</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_O_GPWJ_DATE classid=<%=Util.CLSID_EMEDIT%> width=75
									tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_EM_O_GPWJ_DATE
									onclick="javascript:openCal('G',EM_O_GPWJ_DATE)"
									align="absmiddle" /></td>
							</tr>

							<tr>
								<th>마진적용일</th>
								<td><comment id="_NSID_"> <object
									id=EM_I_MAJINDATE classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>행사구분/행사율</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=LC_I_HS_GBN classid=<%=Util.CLSID_LUXECOMBO%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script><comment
									id="_NSID_"> <object id=LC_I_HS_RATE
									classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>                   
                                <comment id="_NSID_"> <object id=EM_O_MG_RATE
                                classid=<%=Util.CLSID_EMEDIT%> width=94 tabindex=1
                                align="absmiddle"> </object> 
                                </comment><script> _ws_(_NSID_);</script>
                                </td>
							</tr>

							<tr>
								<th>수량계</th>
								<td><comment id="_NSID_"> <object id=EM_O_SRG
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
								<th>원가계</th>
								<td><comment id="_NSID_"> <object id=EM_O_WGG
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
								<th>매가계</th>
								<td><comment id="_NSID_"> <object id=EM_O_MGG
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
							    <th>부가세계</th>
                                <td>
                                    <comment id="_NSID_"> 
                                        <object id=EM_TOT_TAX classid=<%=Util.CLSID_EMEDIT%> width=103 tabindex=1 align="absmiddle"> </object> 
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
								<th>비고</th>
								<td colspan="3" ><comment id="_NSID_"> <object
									id=EM_O_ETC classid=<%=Util.CLSID_EMEDIT%> width=295 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>
							<!---->
						</table>
						</td>
					</tr>
					<tr>
					<tr>
						<td class="PT05">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td><comment id="_NSID_"> <OBJECT id=GR_DETAIL
											width=100% height=430 classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_IO_DETAIL">
											<Param Name="ViewSummary" value="1">
										</OBJECT> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
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
<comment id="_NSID_">
<object id=EM_TAX_FLAG classid=<%=Util.CLSID_EMEDIT%> width=30
	tabindex=1 align="absmiddle"> </object>
</comment>
<script> _ws_(_NSID_);</script>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            
        <c>Col=SLIP_NO             Ctrl=EM_O_SLIP_NO               param=Text</c>
        <c>Col=SLIP_PROC_STAT_NM   Ctrl=EM_O_SLIP_PROC_STAT_NM     param=Text</c>
        
        <c>Col=PUMBUN_CD        Ctrl=EM_I_PB_CD     param=Text</c>
        <c>Col=PUMBUN_NM        Ctrl=EM_I_PB_NM     param=Text</c>        
        <c>Col=VEN_CD           Ctrl=EM_O_HRS_CD    param=Text</c>
        <c>Col=VEN_NM           Ctrl=EM_O_HRS_NM    param=Text</c>
        <c>Col=ORD_OWN_FLAG_NM  Ctrl=EM_O_BALJUJC   param=Text</c>
        <c>Col=ORD_DT           Ctrl=EM_I_BJDATE    param=Text</c>
        <c>Col=DELI_DT          Ctrl=EM_I_NPYJDATE  param=Text</c>
        <c>Col=CHK_DT           Ctrl=EM_O_GPWJ_DATE param=Text</c> 
        <c>Col=ORD_CF_DT        Ctrl=EM_I_BJHJDATE  param=Text</c>
        <c>Col=MG_APP_DT        Ctrl=EM_I_MAJINDATE param=Text</c>
        <c>Col=BUYER_CD         Ctrl=EM_O_BUYER_CD  param=Text</c>
        <c>Col=BUYER_NM         Ctrl=EM_O_BUYER_NM  param=Text</c>
        <c>Col=TAX_FLAG_NM      Ctrl=EM_O_GS_GBN    param=Text</c>
        <c>Col=TAX_FLAG         Ctrl=EM_TAX_FLAG    param=Text</c>
        <c>Col=VAT_TAMT         Ctrl=EM_TOT_TAX     param=Text</c>
        <c>Col=REMARK           Ctrl=EM_O_ETC       param=Text</c>
        <c>Col=ORD_TOT_QTY      Ctrl=EM_O_SRG       param=Text</c>
        <c>Col=NEW_COST_TAMT    Ctrl=EM_O_WGG       param=Text</c>
        <c>Col=NEW_SALE_TAMT    Ctrl=EM_O_MGG       param=Text</c>     
        <c>Col=MG_RATE          Ctrl=EM_O_MG_RATE   param=Text</c>  
        
        <c>Col=STR_CD           Ctrl=LC_I_STORE     param=BindColVal</c>   
        <c>Col=STR_CD           Ctrl=LC_I_STORE     param=BindColVal</c>
        <c>Col=AFT_ORD_FLAG     Ctrl=LC_I_SH_GBN    param=BindColVal</c>
        <c>Col=EVENT_FLAG       Ctrl=LC_I_HS_GBN    param=BindColVal</c>
        <c>Col=EVENT_RATE       Ctrl=LC_I_HS_RATE   param=BindColVal</c>
        <c>Col=SLIP_FLAG        Ctrl=RD_SLIP_FLAG   param=CodeValue</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<body>
</html>

