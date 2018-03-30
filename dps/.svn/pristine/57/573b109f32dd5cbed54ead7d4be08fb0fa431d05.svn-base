<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주결재 > 품목반품발주 재무팀협의
 * 작 성 일 : 2010.04.07
 * 작 성 자 : 신명섭
 * 수 정 자 : 
 * 파 일 명 : pord2030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 품목발주 SM확정 
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
var strSlipProcStat = "";                            // 발주상태
var strTaxFlag      = "";                            // 과세구분 (0:과세,1:면세)
var roundFlag       = "";                            // 원가단가 반올림 구분 (1:반올림 2:올림 3:내림)
var blnPummokChanged = false;

var inta            = 0;
var bfListRowPosition = 0;                             // 이전 List Row Position
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

 function doInit(){
     // Input  Data Set Header 초기화
     
     strToday = getTodayDB("DS_O_RESULT");
     // Output Data Set Header 초기화
     DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');  
     DS_EVENT_FLAG.setDataHeader('<gauce:dataset name="H_MARGIN_FLAG"/>');
     DS_SETEVNFLAG.setDataHeader('<gauce:dataset name="H_MARGIN_FLAG"/>');
     DS_EVENT_RATE.setDataHeader('<gauce:dataset name="H_MARGIN_RATE"/>'); 
     DS_SETEVNRATE.setDataHeader('<gauce:dataset name="H_MARGIN_RATE"/>'); 
     DS_PUMMOK_INFO.setDataHeader('<gauce:dataset name="H_PUMMOK_INFO"/>');     //품목코드 정보
     DS_CHK_STRPROCSTAT.setDataHeader('<gauce:dataset name="H_CHK_STRPROCSTAT"/>');     //승인처리시 전표상태
     
     DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)'); 
     
     // 그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일
          
     // EMedit에 초기화
     initEmEdit(EM_S_START_DT, "SYYYYMMDD", PK);                  //조회용 시작일
     initEmEdit(EM_S_END_DT,   "TODAY", PK);                  //조회용 종료일
     initEmEdit(EM_S_PB_CD,    "GEN^6", NORMAL);              //조회용 브랜드코드
     initEmEdit(EM_S_PB_NM,    "GEN",   READ);                //조회용 브랜드명     
     initEmEdit(EM_S_VEN_CD,   "GEN^6", NORMAL);              //조회용 협력사코드
     initEmEdit(EM_S_VEN_NM,   "GEN",   READ);                //조회용 협력사코드명
     initEmEdit(EM_S_SLIP_NO,  "0000-0-0000000"  ,NORMAL);      // 전표번호  

     initEmEdit(RD_SLIP_FLAG,  "GEN"  ,    READ);               //입력용 전표구분  
     initEmEdit(EM_I_PB_CD,    "GEN^6",    READ);               //입력용 브랜드코드
     initEmEdit(EM_I_PB_NM,    "GEN",      READ);             //입력용 브랜드명     
     initEmEdit(EM_I_BJDATE,   "YYYYMMDD", READ);            //입력용 발주일     
     initEmEdit(EM_I_BJHJDATE, "YYYYMMDD", READ);             //입력용 발주확정
     initEmEdit(EM_I_NPYJDATE, "YYYYMMDD", READ);            //입력용 납품예정일
     initEmEdit(EM_I_MAJINDATE,"YYYYMMDD", READ);            //입력용 마진적용일
     initEmEdit(EM_O_ETC,      "GEN^100",  NORMAL);           //입력용 비고

    // initEmEdit(EM_O_SLIP_NO,  "GEN",     READ);              //출력용 전표번호
     initEmEdit(EM_O_SLIP_NO     ,"0000-0-0000000"    ,READ);           // 전표번호 
     initEmEdit(EM_O_SLIP_PROC_STAT_NM, "GEN",     READ);     //출력용 전표상태
     initEmEdit(EM_O_BALJUJC,  "GEN",     READ);              //출력용 발주주체
     initEmEdit(EM_O_BUYER_CD, "GEN",     READ);              //출력용 바이어코드
     initEmEdit(EM_O_BUYER_NM, "GEN",     READ);              //출력용 바이어명
     initEmEdit(EM_O_GS_GBN,   "GEN",     READ);              //출력용 과세구분
     initEmEdit(EM_O_HRS_CD,   "GEN",     READ);              //출력용 협력사코드
     initEmEdit(EM_O_HRS_NM,   "GEN",     READ);              //출력용 협력사명
     initEmEdit(EM_O_GPWJ_DATE,"YYYYMMDD",READ);              //출력용 검품확정일
     initEmEdit(EM_O_SRG,      "NUMBER^9^0",   READ);         //출력용 수량계
     initEmEdit(EM_O_WGG,      "NUMBER^12^0",  READ);         //출력용 원가계
     initEmEdit(EM_O_MGG,      "NUMBER^12^0",  READ);         //출력용 매가계
     initEmEdit(EM_O_MG_RATE,  "NUMBER^5^2" ,  READ);         //출력용 마진율
    
     //콤보 초기화
     initComboStyle(LC_O_STR,    DS_STR,           "CODE^0^30,NAME^0^140", 1, PK);              //조회용 점코드     
     initComboStyle(LC_O_BUMUN,  DS_O_DEPT,        "CODE^0^30,NAME^0^80", 1, PK);              //조회용 팀     
     initComboStyle(LC_O_TEAM,   DS_O_TEAM,        "CODE^0^30,NAME^0^80", 1, PK);              //조회용 파트     
     initComboStyle(LC_O_PC,     DS_O_PC,          "CODE^0^30,NAME^0^80", 1, PK);              //조회용 PC     
     initComboStyle(LC_O_GJDATE, DS_O_GJDATE_TYPE, "CODE^0^30,NAME^0^80", 1, PK);              //조회용 기준일     
     initComboStyle(LC_O_JPST,   DS_O_PROC_STAT,   "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 전표상태        

     initComboStyle(LC_I_STORE,  DS_STR,           "CODE^0^30,NAME^0^140", 1, PK);              //입력용 점 
     initComboStyle(LC_I_SH_GBN, DS_AFT_ORD_FLAG,  "CODE^0^30,NAME^0^80", 1, NORMAL);          //입력용 사후구분   
     initComboStyle(LC_I_HS_GBN, DS_EVENT_FLAG,    "EVENT_FLAG^0^30,EVENT_FLAG_NM^0^0", 1, PK);              //입력용 행사구분 
     initComboStyle(LC_I_HS_RATE,DS_EVENT_RATE,    "EVENT_RATE^0^30,EVENT_RATE_NM^0^0", 1, PK);              //입력용 행사율     
    

     //공통코드에서 데이터 가지고 오기
//  getStrCode("DS_STR","N","N");                           // 점
    getEtcCode("DS_O_GJDATE_TYPE", "D", "P214", "N");       // 기준일
   // getEtcCode("DS_O_PROC_STAT",   "D", "P207", "Y");       // 전표상태
    getEtcCode("DS_O_PROC_STAT",   "D", "P300", "N");        //전표확정상태 (Y:확정, N:미확정)
    getEtcCode("DS_AFT_ORD_FLAG",  "D", "P209", "N");       // 사전사후구분
    getEtcCode("DS_ORD_OWN_FLAG",  "D", "P202", "N");       // 발주주체구분 
    getEtcCode("DS_TAX_FLAG",      "D", "P004", "N");       // 과세구분

    getEtcCode("DS_ORD_UNIT_CD",      "D", "P013", "N");       // 단위 
    getEtcCode("DS_TAG_FLAG",         "D", "P063", "N");       // 택구분 
    getEtcCode("DS_TAG_PRT_OWN_FLAG", "D", "P064", "N");       // 택발행주체
    
    getStore("DS_STR", "Y", "", "N");                                                            // 점        
//    getDept("DS_O_DEPT", "Y", LC_O_STR.BindColVal, "Y");                                         // 팀 
//    getTeam("DS_O_TEAM", "Y", LC_O_STR.BindColVal, LC_O_BUMUN.BindColVal, "Y");                  // 파트  
//    getPc("DS_O_PC", "Y", LC_O_STR.BindColVal, LC_O_BUMUN.BindColVal, LC_O_TEAM.BindColVal, "Y");// PC  
    

    EM_TAX_FLAG.style.display         = "none";

    LC_O_STR.Index      = 0; 
    LC_O_BUMUN.Index    = 0;
    LC_O_TEAM.Index     = 0;
    LC_O_PC.Index       = 0;  
    LC_O_GJDATE.Index   = 0;
    LC_O_JPST.Index     = 0; // 전표상태(미확정)  
    
    LC_O_STR.Focus();
    
    registerUsingDataset("pord203","DS_LIST");

     //입력부의 컴퍼넌트들을 디저블시킨다.
     setObject(false);   
     setTempEvnDataset();        //행사구분 행사율 데이터셋 임시지정
     setEventFlagDs();           //행사구분 행사율 데이터셋 복사        

 } 
 

 function gridCreate1(){
     var hdrProperies = '<FC>id=CHECK1             name="선택"        width=45    align=center  HeadCheckShow=true EditStyle=CheckBox</FC>'
                      + '<FC>id=SLIP_FLAG_NM       name="구분"        width=30    BgColor={decode(REJ_CAN_FLAG,1,"#C8FFFF",2,"#D2D2D2")} align=left Edit=none </FC>'
                      + '<FC>id=SLIP_NO            name="전표번호"    width=93    align=center Edit=none Mask="XXXX-X-XXXXXXX" sumtext="합계" </FC>'
                      + '<FC>id=ORD_DT             name="발주일"      width=80    align=center Edit=none Mask="XXXX/XX/XX" </FC>'
                      + '<FC>id=SLIP_PROC_STAT_NM  name="전표상태"    width=80    align=left Edit=none </FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드"        width=110     align=left Edit=none </FC>'
                      + '<FC>id=VEN_NM             name="협력사"      width=80     align=left Edit=none </FC>'
                      + '<FC>id=COST_TAMT          name="원가금액"    width=100     align=right Edit=none sumtext=@sum </FC>'
                      + '<FC>id=SALE_TAMT          name="매가금액"    width=100     align=right Edit=none sumtext=@sum </FC>'
                      + '<FC>id=STR_NM             name="점"          width=42    align=left Edit=none </FC>';

     initGridStyle(GR_MASTER, "common", hdrProperies, true);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}           name="NO"         width=30    align=center  sumtext=""         </FC>'
			          + '<FC>id=CHECK1             name="선택"       width=45    align=center  HeadCheckShow=true EditStyle=CheckBox</FC>'
			          + '<FC>id=PUMMOK_CD          name="* 품목코드" width=85    align=center  EditStyle=Popup    sumtext="합계" </FC>'
			          + '<FC>id=PUMMOK_NM          name="품목명"     width=100   align=left    Edit=none                      </FC>'
			          + '<FC>id=ORD_UNIT_CD        name="단위"       width=35    align=left    Edit=none          EditStyle=Lookup  Data="DS_ORD_UNIT_CD:CODE:NAME" </FC>'
			          + '<FC>id=ORD_QTY            name="* 수량"     width=40    align=right   Edit=Numeric       sumtext=@sum  </FC>'
			          + '<FC>id=MG_RATE            name="마진율"     width=40    align=right   Edit=none          sumtext=@avg  show=false</FC>'
			          + '<FG> name="원가 (부가세 제외)"' 
			          + '<FC>id=NEW_COST_PRC       name="단가"       width=80    align=right   Edit=none          sumtext=@sum  </FC>'
			          + '<FC>id=NEW_COST_AMT       name="금액"       width=95    align=right   Edit=none          sumtext=@sum  </FC>'
			          + '</FG> '
			          + '<FG> name="매가 (부가세 포함)"'
			          + '<FC>id=NEW_SALE_PRC       name="* 단가"      width=80    align=right  Edit=Numeric      </FC>'
			          + '<FC>id=NEW_SALE_AMT       name="금액"        width=95    align=right  Edit=none         sumtext=@sum  </FC>'
			          + '</FG> '
			          + '<FC>id=TAG_FLAG           name="TAG구분"     width=70    align=left   Edit=none          EditStyle=Lookup   Data="DS_TAG_FLAG:CODE:NAME" </FC>'
			          + '<FC>id=TAG_PRT_OWN_FLAG   name="TAG발행주체" width=80    align=left   Edit=none          EditStyle=Lookup   Data="DS_TAG_PRT_OWN_FLAG:CODE:NAME" </FC>'
			          + '<FC>id=NEW_GAP_RATE       name="신차익율"    width=60    align=left   Edit=none          show="false"</FC>'
			          + '<FC>id=NEW_GAP_AMT        name="신차익액"    width=80    align=left   Edit=none          show="false"</FC>';
      initGridStyle(GR_DETAIL, "common", hdrProperies, false);
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
     
     inta = 0;

     if(checkValidation("Search")){
         DS_IO_MASTER.ClearData();  
         DS_IO_DETAIL.ClearData();
         bfListRowPosition = 0;
         getList();
         // 조회결과 Return
         setPorcCount("SELECT", GR_MASTER);
         if(DS_LIST.CountRow <= 0)
             LC_O_STR.Focus();
     }
     //그리드 CHEKCBOX헤더 체크해제                         
     GR_MASTER.ColumnProp('CHECK1','HeadCheck')= "false"; 

     //입력부의 컴퍼넌트들을 디저블시킨다.
     setObject(false);        
 
 
}

/**
 * btn_New()
 * return값 : void
 */
function btn_New() {  

}

/**
 * btn_Delete()
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

    var strSlipProcStat = "";  //승인할 것인지 반려할 것인지(승인: 00, 반려: 01)    
    var vanMsgFlag = false;       //반려했을때의메시지
    var sendFlag = "";            //SMS전송시 보내는 플레그 
    var strOrgSlipProcStat = "";
    
    if(!DS_LIST.IsUpdated){
       showMessage(INFORMATION, OK, "USER-1002", "처리할 전표"); 
       return;
    }
    

    //승인 취소하려면
    if(DS_LIST.Namevalue(DS_LIST.RowPosition ,"SLIP_PROC_STAT") == "03"){ //재무팀합확정상태
        //승인 취소 하시겠습니까?
        if( showMessage(STOPSIGN, YESNO, "USER-1198") != 1 )
            return;
        else{        	
            if( showMessage(STOPSIGN, YESNO, "USER-1212", "취소") == 1 ){        //정말 취소 하시겠습니까.
                strSlipProcStat = "03" //승인상태의 플래그로 승인을 취소하기 위함.
                sendFlag = "2";        //승인취소
                //alert("승인취소한다");     
            }else{
                return;
            }
        }
    //승인하려면
    }else{
        //승인(반려)하시겠습니까?
        var returnv = showMessage(CONFIRM, CONFIRMREJECT, "USER-1197");
        if(returnv == 2 ){
            if( showMessage(STOPSIGN, YESNO, "USER-1212", "반려") == 1 ){        //정말 반려 하시겠습니까.                
                strSlipProcStat = "03" //승인상태의 플래그로 승인을 취소하기 위함.
                vanMsgFlag = true;
                sendFlag = "1";        //반려
                //alert("반려");           
            }else{
                return;
            }
            
        }else if(returnv == 1){
            strSlipProcStat = "00" //승인이안된상태의 플래그로 승인을하기 위함.
            //alert("승인"); 
            vanMsgFlag = false;
            sendFlag = "0";        //승인
        }else{
        	return;
        }    	
    }

    // 마감체크
    if(!closeCheck())
        return false;
        
    var k = 0;
    for (var i = 0; i < DS_LIST.CountRow; i++)
    {
       if(DS_LIST.NameValue(i + 1, "CHECK1") == "T"){     
    	   
           // 승인,반려,취소할수 있는 상태인지 체크(DB)
           if(!chkStrProStat(i + 1, sendFlag))
               return false;
           
            strOrgSlipProcStat = DS_LIST.NameValue(i + 1,"SLIP_PROC_STAT");
            strBuyerYN = getBuyerYN("DS_O_RESULT", LC_O_STR.BindColVal, EM_I_PB_CD.Text, EM_I_BJDATE.Text);
            var params = "&strSlipProcStat="+encodeURIComponent(strSlipProcStat) //DS_LIST.NameValue(i + 1,"SLIP_PROC_STAT")
                          + "&strToday="+encodeURIComponent(strToday)
                          + "&strBuyerYN="+encodeURIComponent(strBuyerYN)
                          + "&sendFlag="+encodeURIComponent(sendFlag)
                          + "&strOrgSlipProcStat="+encodeURIComponent(strOrgSlipProcStat)
                          + "&strStrCd="+encodeURIComponent(DS_LIST.NameValue(i + 1,"STR_CD"))
                          + "&strSlipNo="+encodeURIComponent(DS_LIST.NameValue(i + 1,"SLIP_NO"))
                          + "&strSlipFlag="+encodeURIComponent(DS_LIST.NameValue(i + 1,"SLIP_FLAG"));

           TR_MAIN.Action="/dps/pord203.po?goTo=conf"+params;
           TR_MAIN.Post();
           k = k+1;
       }   
    }    

    //반려된 전표일경우
    if(vanMsgFlag){
        showMessage(INFORMATION, OK, "USER-1201", k);
        
        btn_Search();      
        //그리드 CHEKCBOX헤더 체크해제                         
        GR_MASTER.ColumnProp('CHECK1','HeadCheck')= "false";    
        return;
    }
    
    if(strSlipProcStat == "03"){//확정상태였던 전표의 취소된 건수
        showMessage(INFORMATION, OK, "USER-1199", k); 
    
    }else{//미확정상태였던 전표의 확정된 건수
        showMessage(INFORMATION, OK, "USER-1200", k);     	
    }

    btn_Search();     
    //그리드 CHEKCBOX헤더 체크해제                         
    GR_MASTER.ColumnProp('CHECK1','HeadCheck')= "false";        
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
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
    var strProcStat    = LC_O_JPST.BindColVal;       //전표확정상태
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
    TR_L_MAIN.Action="/dps/pord203.po?goTo="+goTo+parameters;  
    TR_L_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_LIST)"; //조회는 O
    TR_L_MAIN.Post();    

    GR_MASTER.SetColumn("CHECK1");
    GR_MASTER.Focus();     

    EM_I_PB_CD.Enable = false;              
   // enableControl(IMG_PUMBUN_CD, false);
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
        
        TR_S_MAIN.Action="/dps/pord203.po?goTo="+goTo+parameters;  
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
    
    TR_S_MAIN.Action="/dps/pord203.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_S_MAIN.Post();
    
    // 협력사별 반올림 구분을 받는다
    roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);

//    alert("roundFlag::" + roundFlag);
    // 협력사별 반올림 구분을 받는다
//    getVenRoundFlag(strDatasetId, strToday, strStrCd, strVenCd);
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
         EM_O_ETC.Enable       = flag;             //비고
         LC_I_HS_GBN.Enable    = flag;             //행사구분
         LC_I_HS_RATE.Enable   = flag;             //행사율
         LC_I_STORE.Enable     = flag;             //점(입력용)
         
         EM_I_BJDATE.Enable    = flag;  
         EM_I_NPYJDATE.Enable  = flag;
         EM_I_MAJINDATE.Enable = flag;     
         
      //   enableControl(IMG_PUMBUN_CD, flag);
     //    enableControl(IMG_BJ_DATE, flag);
      //   enableControl(IMG_NPYJ_DATE, flag);
     //    enableControl(IMG_MJ_DATE, flag);
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
  * closeCheck()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-10
  * 개    요    : 저장시 월마감체크를 한다.
  * return값 : void
  */
  function closeCheck(){
      var strStrCd         = LC_I_STORE.BindColVal;  // 점
      var strCloseDt       = EM_I_BJDATE.Text;       // 마감체크일자
      var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
      var strCloseUnitFlag = "42";                   // 단위업무
      var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
      var strCloseFlag     = "M";                    // 마감구분(월마감:M)
     
      var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                    , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
      
      if(closeFlag == "TRUE"){
          showMessage(INFORMATION, OK, "USER-1083", "매입월","발주매입");
          return false;
      }else{
          return true;
      }
  }  

  /**
  * chkStrProStat()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-08-11
  * 개    요 :  승인,반려,취소시 현재 전표진행상태체크
  * return값 : void
  */
  function chkStrProStat(row, sendFlag){

     var strStrCd  = DS_LIST.NameValue(row,"STR_CD");
     var strSlipNo = DS_LIST.NameValue(row,"SLIP_NO");
     
     var goTo       = "chkStrProStat" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)+
                      "&strSlipNo="+encodeURIComponent(strSlipNo);
     
     TR_S_MAIN.Action="/dps/pord203.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_CHK_STRPROCSTAT=DS_CHK_STRPROCSTAT)"; //조회는 O
     TR_S_MAIN.Post();
     
     var msg = DS_CHK_STRPROCSTAT.NameValue(DS_CHK_STRPROCSTAT.RowPosition, "SLIP_PROC_STAT_NM");
     
     if(sendFlag == "0" || sendFlag == "1"){
         if(DS_CHK_STRPROCSTAT.NameValue(DS_CHK_STRPROCSTAT.RowPosition, "CONF_YN") == "N"){
             showMessage(INFORMATION, OK, "USER-1219", msg);
             return false;
         }else{
             return true;           
         }           
     }else{
         if(DS_CHK_STRPROCSTAT.NameValue(DS_CHK_STRPROCSTAT.RowPosition, "CANCEL_CONF_YN") == "N"){
             showMessage(INFORMATION, OK, "USER-1219", msg);
             return false;
         }else{
             return true;           
         }           
     }    
     return true;
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

//       if(EM_S_PB_CD.Text != ""){
//             setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PB_CD, EM_S_PB_NM, "Y", "1"
//                                   , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
//                                   , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
//                                   , strBizType,strSaleBuyFlag);           
//       }else {       
           
          var rtnMap = strPbnPop( EM_S_PB_CD, EM_S_PB_NM, 'Y'
                                 , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                 , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                 , strBizType,strSaleBuyFlag);
//       }
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
//         alert("DS_EVENT_FLAG = "+ DS_EVENT_FLAG.CountRow); 
//         alert("DS_EVENT_RATE = "+ DS_EVENT_RATE.CountRow);      
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
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--  ===================DS_IO_MASTER============================ -->
<!-- Grid DS_IO_MASTER 변경시 DS_IO_DETAIL의 마스터 내용 변경 -->

<!--  ===================DS_IO_MASTER============================ -->

<script language=JavaScript for=DS_LIST event=CanRowPosChange(row)>
</script>

<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)>

    var strSlipNo       = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_NO");          // 발주번호
    var strSlipProcStat = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_PROC_STAT");   // 전표상태

    if(clickSORT)
        return;
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        if(strSlipNo != ""){
            getMaster();
            getDetail();        
        }      
        if(strSlipNo !=""){
            if(inta == 0){  
                inta++;
            }else{
                setPorcCount("SELECT", DS_IO_DETAIL.CountRow);      
            }           
        }
    }
    
 


</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
</script>
<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
</script>
<!--  ===================DS_IO_DETAIL============================ -->
<!--  DS_IO_DETAIL 변경시 -->
<script language=JavaScript for=DS_IO_DETAIL
    event=OnColumnChanged(row,colid)>
</script>

<!-- 디테일 삭제시 컴퍼넌트 총금액-->
<script language=JavaScript for=DS_IO_DETAIL event=OnRowDeleted(row)>   
</script>


<!-- GR_DETAIL CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_DETAIL event=CanColumnPosChange(Row,Colid)>

</script>

<!-- 디테일 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_MASTER
    event="OnHeadCheckClick(Col,Colid,bCheck)">    

    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_LIST.CountRow; i++){
            DS_LIST.NameValue(i, "CHECK1") = 'T';
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_LIST.CountRow; i++){
            DS_LIST.NameValue(i, "CHECK1") = 'F';
        }
    }
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
    
    if(EM_I_PB_CD.Text != ""){   
        EM_I_PB_NM.Text      = "";
        EM_O_BUYER_CD.Text   = "";
        EM_O_BUYER_NM.Text   = "";
        EM_O_HRS_CD.Text     = "";
        EM_O_HRS_NM.Text     = "";
        EM_O_GS_GBN.Text     = "";
        LC_I_HS_GBN.Text     = "";
        LC_I_HS_RATE.Text    = "";
        LC_I_HS_GBN.Enable   = false;
        LC_I_HS_RATE.Enable  = false; 
        getPumbunInfoNonPop();
        return;
    }else{
        EM_I_PB_NM.Text      = "";
        EM_O_BUYER_CD.Text   = "";
        EM_O_BUYER_NM.Text   = "";
        EM_O_HRS_CD.Text     = "";
        EM_O_HRS_NM.Text     = "";
        EM_O_GS_GBN.Text     = "";
        LC_I_HS_GBN.Text     = "";
        LC_I_HS_RATE.Text    = "";
        LC_I_HS_GBN.Enable   = false;
        LC_I_HS_RATE.Enable  = false;
//        getPumbunInfo(); 
    }
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
<object id="DS_CHK_STRPROCSTAT" classid=<%=Util.CLSID_DATASET%>></object>
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
                        <th width="70" >팀</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_O_BUMUN classid=<%=Util.CLSID_LUXECOMBO%> width=100
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70">파트</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_O_TEAM classid=<%=Util.CLSID_LUXECOMBO%> width=100
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70">PC</th>
                        <td><comment id="_NSID_"> <object id=LC_O_PC
                            classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1>
                        </object> </comment><script>_ws_(_NSID_);</script></td>
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
                            align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:openCal('G',EM_S_END_DT)" align="absmiddle" />
                        </td>
                        <th width="70">전표상태</th>
                        <td><comment id="_NSID_"> <object id=LC_O_JPST
                            classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1>
                        </object> </comment><script>_ws_(_NSID_);</script></td>
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
                            <param name=Format value=" ^전체,A^매입,B^반품">
                            <param name=CodeValue value=" ">
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
                            width=100% height=431 classid=<%=Util.CLSID_GRID%>>
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
                                <th width="70" >점</th>
                                <td width="105"><comment id="_NSID_"> <object
                                    id=LC_I_STORE classid=<%=Util.CLSID_LUXECOMBO%> width=100
                                    align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
                                <th width="90" >전표번호</th>
                                <td width="105"><comment id="_NSID_"> <object
                                    id=EM_O_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                                <th width="70" >전표상태</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_O_SLIP_PROC_STAT_NM classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                            </tr>
                             
                            <tr>
                                <th>전표구분</th>
                                <td><comment id="_NSID_"> <object id=RD_SLIP_FLAG
                                    classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height: 20; width: 100">
                                    <param name=Cols value="2">
                                    <param name=Format value="A^매입,B^반품">
                                    <param name=CodeValue value="A">
                                </object> </comment> <script> _ws_(_NSID_);</script></td>
                                <th>사후구분</th>
                                <td colspan="3"><comment id="_NSID_"> <object id=LC_I_SH_GBN
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1>
                                </object> </comment><script>_ws_(_NSID_);</script></td>
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
                                <td><comment id="_NSID_"> <object
                                    id=EM_I_BJDATE classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
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
                                <td ><comment id="_NSID_"> <object
                                    id=EM_I_NPYJDATE classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>검품확정일</th>
                                <td colspan="3"><comment id="_NSID_"> <object
                                    id=EM_O_GPWJ_DATE classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>마진적용일</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_I_MAJINDATE classid=<%=Util.CLSID_EMEDIT%> width=100
                                    tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th>행사구분/행사율</th>
                                <td colspan="3"> <comment
                                    id="_NSID_"> <object id=LC_I_HS_GBN
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script><comment
                                    id="_NSID_"> <object id=LC_I_HS_RATE
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script>                      
                                <comment id="_NSID_"> <object id=EM_O_MG_RATE
                                classid=<%=Util.CLSID_EMEDIT%> width=94 tabindex=1
                                align="absmiddle"> </object> 
                                </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>수량계</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_O_SRG classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                                <th>원가계</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_O_WGG classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                                <th>매가계</th>
                                <td><comment id="_NSID_"> <object id=EM_O_MGG
                                    classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                                    align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
                            </tr>
                            
                            <tr>
                                <th>비고</th>
                                <td colspan="5"><comment id="_NSID_"> <object
                                    id=EM_O_ETC classid=<%=Util.CLSID_EMEDIT%> width=512 tabindex=1
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
                                            width=100% height=195 classid=<%=Util.CLSID_GRID%>>
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
    <object id=EM_TAX_FLAG classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
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
        <c>Col=ORD_CF_DT        Ctrl=EM_I_BJHJDATE  param=Text</c>
        <c>Col=MG_APP_DT        Ctrl=EM_I_MAJINDATE param=Text</c>
        <c>Col=BUYER_CD         Ctrl=EM_O_BUYER_CD  param=Text</c>
        <c>Col=BUYER_NM         Ctrl=EM_O_BUYER_NM  param=Text</c>
        <c>Col=TAX_FLAG_NM      Ctrl=EM_O_GS_GBN    param=Text</c>
        <c>Col=TAX_FLAG         Ctrl=EM_TAX_FLAG    param=Text</c>
        <c>Col=REMARK           Ctrl=EM_O_ETC       param=Text</c>
        <c>Col=ORD_TOT_QTY      Ctrl=EM_O_SRG       param=Text</c>
        <c>Col=NEW_COST_TAMT    Ctrl=EM_O_WGG       param=Text</c>
        <c>Col=NEW_SALE_TAMT    Ctrl=EM_O_MGG       param=Text</c>    
        <c>Col=MG_RATE          Ctrl=EM_O_MG_RATE   param=Text</c>  
        
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
