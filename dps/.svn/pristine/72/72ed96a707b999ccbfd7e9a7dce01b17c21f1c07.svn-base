<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주관리 > 품목매입발주등록
 * 작 성 일 : 2010.01.18
 * 작 성 자 : 박래형
 * 수 정 자 :  
 * 파 일 명 : pord1010.jsp
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

var inta              = 0;
var bfListRowPosition = 0;                           // 이전 List Row Position
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
 var top2 = 420;		//해당화면의 동적그리드top위치
 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

     
     strToday        = getTodayDB("DS_O_RESULT");
     
     // Output Data Set Header 초기화
     DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');  
     DS_EVENT_FLAG.setDataHeader('<gauce:dataset name="H_MARGIN_FLAG"/>');
     DS_SETEVNFLAG.setDataHeader('<gauce:dataset name="H_MARGIN_FLAG"/>');
     DS_EVENT_RATE.setDataHeader('<gauce:dataset name="H_MARGIN_RATE"/>'); 
     DS_SETEVNRATE.setDataHeader('<gauce:dataset name="H_MARGIN_RATE"/>'); 
     DS_PUMMOK_INFO.setDataHeader('<gauce:dataset name="H_PUMMOK_INFO"/>');     //품목코드 정보
     DS_PUMMOK_SRT_INFO.setDataHeader('<gauce:dataset name="H_PUMMOK_SRT_INFO"/>');     //단축코드 정보
     
     DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)'); 
     
     // 그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일
          
     // EMedit에 초기화
     initEmEdit(EM_S_START_DT           ,"SYYYYMMDD"     ,PK);      // 조회용 시작일
     initEmEdit(EM_S_END_DT             ,"TODAY"         ,PK);      // 조회용 종료일
     initEmEdit(EM_S_PB_CD              ,"000000"        ,NORMAL);  // 조회용 브랜드코드
     initEmEdit(EM_S_PB_NM              ,"GEN"           ,READ);    // 조회용 브랜드명     
     initEmEdit(EM_S_VEN_CD             ,"000000"        ,NORMAL);  // 조회용 협력사코드
     initEmEdit(EM_S_VEN_NM             ,"GEN"           ,READ);    // 조회용 협력사코드명         
     initEmEdit(EM_S_SLIP_NO            ,"0000-0000000"  ,NORMAL);  // 전표번호  
     
     initEmEdit(RD_SLIP_FLAG            ,"GEN"           ,PK);      // 입력용 전표구분  
     initEmEdit(EM_I_PB_CD              ,"000000"        ,PK);      // 입력용 브랜드코드
     initEmEdit(EM_I_PB_NM              ,"GEN"           ,READ);    // 입력용 브랜드명     
     initEmEdit(EM_I_BJDATE             ,"YYYYMMDD"      ,PK);      // 입력용 발주일     
     initEmEdit(EM_I_BJHJDATE           ,"YYYYMMDD"      ,READ);    // 입력용 발주확정
     initEmEdit(EM_I_NPYJDATE           ,"YYYYMMDD"      ,PK);      // 입력용 납품예정일
     initEmEdit(EM_I_MAJINDATE          ,"YYYYMMDD"      ,PK);      // 입력용 마진적용일
     initEmEdit(EM_I_VAT_TAMT           ,"NUMBER^13^0"   ,READ);  	// 입력용 부가세
     initEmEdit(EM_O_ETC                ,"GEN^100"       ,NORMAL);  // 입력용 비고
     initEmEdit(EM_O_SLIP_NO            ,"0000-0000000"  ,READ);    // 출력용 전표번호
     initEmEdit(EM_O_SLIP_PROC_STAT_NM  ,"GEN"           ,READ);    // 출력용 전표상태
     initEmEdit(EM_O_BALJUJC            ,"GEN"           ,READ);    // 출력용 발주주체
     initEmEdit(EM_O_BUYER_CD           ,"GEN"           ,READ);    // 출력용 바이어코드
     initEmEdit(EM_O_BUYER_NM           ,"GEN"           ,READ);    // 출력용 바이어명
     initEmEdit(EM_O_GS_GBN             ,"GEN"           ,READ);    // 출력용 과세구분
     initEmEdit(EM_O_HRS_CD             ,"GEN"           ,READ);    // 출력용 협력사코드
     initEmEdit(EM_O_HRS_NM             ,"GEN"           ,READ);    // 출력용 협력사명
     initEmEdit(EM_O_GPWJ_DATE          ,"YYYYMMDD"      ,READ);    // 출력용 검품확정일
     initEmEdit(EM_O_SRG                ,"NUMBER^7^0"    ,READ);    // 출력용 수량계
     initEmEdit(EM_O_WGG                ,"NUMBER^13^0"   ,READ);    // 출력용 원가계
     initEmEdit(EM_O_MGG                ,"NUMBER^13^0"   ,READ);    // 출력용 매가계
     initEmEdit(EM_O_MG_RATE            ,"NUMBER^5^2"    ,READ);    // 출력용 마진율
     initEmEdit(EM_O_SUP            	,"NUMBER^13^0"    ,READ);   // 출력용 공급가
     
     //콤보 초기화
     initComboStyle(LC_O_STR      ,DS_STR            ,"CODE^0^30,NAME^0^140", 1, PK);                // 조회용 점코드     
     initComboStyle(LC_O_BUMUN    ,DS_O_DEPT         ,"CODE^0^30,NAME^0^80", 1, NORMAL);            // 조회용 팀     
     initComboStyle(LC_O_TEAM     ,DS_O_TEAM         ,"CODE^0^30,NAME^0^80", 1, NORMAL);            // 조회용 파트     
     initComboStyle(LC_O_PC       ,DS_O_PC           ,"CODE^0^30,NAME^0^80", 1, NORMAL);            // 조회용 PC     
     initComboStyle(LC_O_GJDATE   ,DS_O_GJDATE_TYPE  ,"CODE^0^30,NAME^0^80", 1, PK);                // 조회용 기준일     
     initComboStyle(LC_O_JPST     ,DS_O_PROC_STAT    ,"CODE^0^30,NAME^0^120", 1, NORMAL);            // 조회용 전표상태        
     initComboStyle(LC_I_STORE    ,DS_STR            ,"CODE^0^30,NAME^0^140", 1, PK);                // 입력용 점 
     initComboStyle(LC_I_SH_GBN   ,DS_AFT_ORD_FLAG   ,"CODE^0^30,NAME^0^100", 1, PK);                // 입력용 사후구분   
     initComboStyle(LC_I_HS_GBN   ,DS_EVENT_FLAG     ,"EVENT_FLAG^0^30,EVENT_FLAG_NM^0^0", 1, PK);  // 입력용 행사구분 
     initComboStyle(LC_I_HS_RATE  ,DS_EVENT_RATE     ,"EVENT_RATE^0^30,EVENT_RATE_NM^0^0", 1, PK);  // 입력용 행사율         

     //공통코드에서 데이터 가지고 오기
//   getStrCode("DS_STR","N","N");                              // 점
     getEtcCode("DS_O_GJDATE_TYPE",    "D", "P214", "N");       // 기준일
     getEtcCode("DS_O_PROC_STAT",      "D", "P207", "Y");       // 전표상태
     getEtcCode("DS_AFT_ORD_FLAG",     "D", "P209", "N");       // 사전사후구분
     getEtcCode("DS_ORD_OWN_FLAG",     "D", "P202", "N");       // 발주주체구분 
     getEtcCode("DS_TAX_FLAG",         "D", "P004", "N");       // 과세구분
     getEtcCode("DS_ORD_UNIT_CD",      "D", "P013", "N");       // 단위 
     getEtcCode("DS_TAG_FLAG",         "D", "P063", "N");       // 택구분 
     getEtcCode("DS_TAG_PRT_OWN_FLAG", "D", "P064", "N");       // 택발행주체    
     getStore("DS_STR", "Y", "", "N");                          // 점            

     EM_TAX_FLAG.style.display         = "none";
//     EM_O_MG_RATE.style.display         = "none";
/*
     //기준정보에서 데이터 가져오기    
     getEtcCode("DS_EVENT_FLAG", "점코드", "브랜드코드", "마진적용일", "N");                   // 행사구분     
     getEtcCode("DS_EVENT_RATE", "점코드", "브랜드코드", "마진적용일", "행사구분", "N");        // 행사율     
     getMarginFlag(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text);            //행사구분
     getMarginRate();     //행사율
*/
     LC_O_STR.Index      = 0; 
     LC_O_BUMUN.Index    = 0;
     LC_O_TEAM.Index     = 0;
     LC_O_PC.Index       = 0;  
     LC_O_GJDATE.Index   = 0;
     LC_O_JPST.Index     = 0;
     LC_O_STR.Focus();
     
/*    
     LC_I_STORE.Index    = 0;
     LC_I_SH_GBN.Index   = 0;    
     setTempEvnDataset();        //행사구분 행사율 데이터셋 임시지정
     setEventFlagDs();           //행사구분 행사율 데이터셋 복사        
*/   

     // 입력부의 컴퍼넌트들을 디저블시킨다.
     setObject(false);      
     RD_SLIP_FLAG.Enable   = false;             //전표구분
     // 사후구분이 재고조정일때 발주일, 납품예정일, 마진적용일 달력컨트롤 사용막는다
     setCalImgDis(false);    
     LC_I_SH_GBN.Enable    = false;      
     registerUsingDataset("pord101","DS_LIST,DS_IO_MASTER,DS_IO_DETAIL,DS_PUMMOK_INFO,DS_PUMMOK_SRT_INFO");     
     
     
//      alert("원가계, 부가세계 자동계산되도록 수정하였습니다. 강제조정분을 입력하지마시고 \n 총원가계 총부가세계가 이상있을시 전산팀에 연락바랍니다.");
 } 
 
 
 function gridCreate1(){
     var hdrProperies = '<FC>id=STR_NM             name="점"          width=42  BgColor={decode(REJ_CAN_FLAG,1,"",2,"")}  align=left SHOW=FALSE</FC>' //EditStyle=Lookup Data="DS_O_STORE:CODE:NAME" 
				      + '<FC>id=STR_CD             name="점코드"      width=35  BgColor={decode(REJ_CAN_FLAG,1,"",2,"")}    align=center SHOW=FALSE</FC>' 
				      + '<FC>id=SLIP_FLAG_NM       name="구분"        width=35  BgColor={decode(REJ_CAN_FLAG,1,"#C8FFFF",2,"#D2D2D2")}    align=center </FC>'
                      + '<FC>id=SLIP_NO            name="전표번호"    width=130 BgColor={decode(REJ_CAN_FLAG,1,"",2,"")}    align=left Mask="XXXX-X-XXXXXXX"</FC>'
                      + '<FC>id=ORD_DT             name="발주일"      width=80  BgColor={decode(REJ_CAN_FLAG,1,"",2,"")}    align=center Mask="XXXX/XX/XX" </FC>'
                      + '<FC>id=SLIP_PROC_STAT_NM  name="전표상태"    width=80  BgColor={decode(REJ_CAN_FLAG,1,"",2,"")}    align=left </FC>'
                      + '<FC>id=PUMBUN_CD          name="브랜드코드"    width=80  BgColor={decode(REJ_CAN_FLAG,1,"",2,"")}    align=left show=false</FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드"        width=120  BgColor={decode(REJ_CAN_FLAG,1,"",2,"")}    align=left </FC>'
                      + '<FC>id=MG_APP_DT          name="마진적용일"   width=80 BgColor={decode(REJ_CAN_FLAG,1,"#C8FFFF",2,"#D2D2D2")}     align=left show=false</FC>';

     initGridStyle(GR_MASTER, "common", hdrProperies, false);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}           name="NO"         width=30    align=center  sumtext=""         </FC>'
                      + '<FC>id=CHECK1             name="선택"       width=45    align=center  HeadCheckShow=true EditStyle=CheckBox</FC>'
                      + '<FC>id=PUMMOK_SRT_CD      name="* 단축코드" width=65    align=center  EditStyle=Popup    </FC>'
                      + '<FC>id=PUMMOK_CD          name="품목코드"   width=85    align=center  Edit=none          sumtext="합계" </FC>'
                      + '<FC>id=PUMMOK_NM          name="품목명"     width=100   align=left    Edit=none          </FC>'
                      + '<FC>id=ORD_UNIT_CD        name="단위"       width=35    align=left    Edit=none          EditStyle=Lookup  Data="DS_ORD_UNIT_CD:CODE:NAME" </FC>'
                      + '<FC>id=ORD_QTY            name="* 수량"     width=40    align=right   Edit=Numeric       sumtext=@sum  </FC>'
                      + '<FC>id=MG_RATE            name="마진율"     width=50    align=right   Edit=none          </FC>'
                      + '<FG> name="원가 (부가세 제외)"' 
                      + '<FC>id=OLD_COST_PRC       name="전단가"     width=80    align=right   Edit=none          show="false"</FC>'
                      + '<FC>id=NEW_COST_PRC       name="단가"       width=80    align=right   Edit=Numeric       </FC>'
                      + '<FC>id=NEW_COST_AMT       name="금액"       width=120    align=right   Edit=none          sumtext=@sum  </FC>'
                      + '<FC>id=VAT_AMT       	   name="VAT"       width=95    align=right   Edit=Numeric       sumtext=@sum  </FC>'
                      + '</FG> '
                      + '<FG> name="매가 (부가세 포함)"'
                      + '<FC>id=NEW_SALE_PRC       name="* 단가"      width=80    align=right  Edit=Numeric      </FC>'
                      + '<FC>id=NEW_SALE_AMT       name="금액"        width=120    align=right  Edit=none         sumtext=@sum  </FC>'
                      + '</FG> '
                      + '<FC>id=TAG_FLAG           name="TAG구분"     width=100    align=left   Edit=none          EditStyle=Lookup   Data="DS_TAG_FLAG:CODE:NAME" </FC>'
                      + '<FC>id=TAG_PRT_OWN_FLAG   name="TAG;발행주체" width=60    align=left   Edit=none          EditStyle=Lookup   Data="DS_TAG_PRT_OWN_FLAG:CODE:NAME" </FC>'
                      + '<FC>id=NEW_GAP_RATE       name="신차익율"    width=60    align=left   Edit=none          show="false"</FC>'
                      + '<FC>id=NEW_GAP_AMT        name="신차익액"    width=80    align=left   Edit=none          show="false"</FC>';
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

    // 변경, 추가내역이 있을 경우
    if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1073") != 1 ){   
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

     // 입력부의 컴퍼넌트들을 디저블시킨다.
     setObject(false);        
     // 사후구분이 재고조정일때 발주일, 납품예정일, 마진적용일 달력컨트롤 사용막는다
     setCalImgDis(false);   
}

/**
 * btn_New()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {  
    
    var slip_no = "";    
     
    // 전표마스터 추가후 행추가, 삭제 버튼 활성화 (저장되지 않은 내용이 있을경우 추가되지 않음)
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "SLIP_NO") == ""){
        if(showMessage(QUESTION, YESNO, "USER-1072") != 1 ){
            EM_I_PB_CD.Enable = true;              //신규버튼시 브랜드코드 활성화
            enableControl(IMG_PUMBUN_CD, true);
            
            setObject(true)
            LC_I_STORE.Focus();
            LC_I_HS_RATE.Enable = false;
            return;
        }else{
            DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
        }
    }else{
        DS_LIST.Addrow(); 
    }

    setObject(true);
    DS_IO_MASTER.Addrow();    
    DS_IO_DETAIL.ClearData();
        
    if(DS_IO_MASTER.CountRow > 0){
        
        slip_no = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO");
        
        if(slip_no.length == 0){
            LC_I_STORE.Index          = 0;        
            RD_SLIP_FLAG.CodeValue    = "A";
            LC_I_SH_GBN.BindColVal    = "0";    // default 사전전표 로 세팅 
            enableControl(LC_I_SH_GBN, true);
            
            idx = DS_ORD_OWN_FLAG.ValueRow(1,"0");
            EM_O_BALJUJC.Text = DS_ORD_OWN_FLAG.NameValue(idx, "NAME");   // 발주주체

            // MARIO OUTLET
            // 일 발주 타임아웃 이면. 
            if (!orderCloseCheck()) {
            	var tomorrow = addDate("d", 1, strToday);
	            EM_I_BJDATE.Text = tomorrow;
	            var date = addDate("d", 2, strToday);                         // 오늘날짜 + 1
	            EM_I_NPYJDATE.Text  = date;                                   // 납품예정일
	            EM_I_MAJINDATE.Text = date;                                   // 마진적용일
            } else {
	            initEmEdit(EM_I_BJDATE, "TODAY", NORMAL);                     // 발주일
	            var date = addDate("d", 1, strToday);                         // 오늘날짜 + 1
	            EM_I_NPYJDATE.Text  = date;                                   // 납품예정일
	            EM_I_MAJINDATE.Text = date;                                   // 마진적용일
        	}
        }
    }
    
    EM_I_PB_CD.Enable = true;              //신규버튼시 브랜드코드 활성화
    enableControl(IMG_PUMBUN_CD, true);
    
    setObject(true)
    LC_I_STORE.Focus();
    LC_I_HS_GBN.Enable = false;
    LC_I_HS_RATE.Enable = false;
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요    : 삭제버튼 클릭 (신규등록일 경우 DS_IO_MASTER 삭제, 기존데이터일 경우 삭제 Action실행)
 * return값 : void
 */
function btn_Delete() {
    
    // 삭제할 데이터 없는 경우
    if (DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
    
    
    // 신규 전표인 경우 데이터셋에서만 삭제
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO").length == 0){
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
        DS_LIST.DeleteRow(DS_LIST.RowPosition);
        return;
    }    
    
    if(!checkValidation("Delete"))
        return;
    
    if(showMessage(Question, YESNO, "USER-1023") == 1){      
        // 기존데이터일 경우 삭제 Action실행 
        var params = "&strFlag=delete"
                   + "&strStrCd="+encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD"))
                   + "&strSlipNo="+encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO")) ;

        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
        
        TR_MAIN.Action="/dps/pord101.po?goTo=save"+params; 
        TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
        //트랜젝션이 다름
        TR_MAIN.Post();
    }
        btn_Search();
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {    

    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated && !DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
/*         
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(STOPSIGN, YESNO, "USER-1010") != 1 )
        return;
*/
    
    if(DS_IO_DETAIL.CountRow <= 0){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오."); 
        GR_DETAIL.Focus();
        return;
    }
    
    if(!checkValidation("Save"))
        return;

    // 마감체크
    if(!closeCheck())
    	return false;
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){   
    		fn_strcd_reset();			// 간혹 strcd가 누락되어 저장이안됨 여기서 다시 세팅해줌
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DTL_CNT")     = DS_IO_DETAIL.CountRow;    // 명세건수
//            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NEW_GAP_RATE")= DS_EVENT_RATE.NameValue(DS_EVENT_RATE.RowPosition, "NORM_MG_RATE");
            var strDetailCount = DS_IO_DETAIL.CountRow; 
            var parameters = "&strDetailCount="+encodeURIComponent(strDetailCount); 
            TR_S_MAIN.Action="/dps/pord101.po?goTo=save&strFlag=save&strBuyerYN="+strBuyerYN+parameters;
            TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
            TR_S_MAIN.Post();     
            btn_Search();  
    }
    
    bfListRowPosition = 0;
//  setEventFlagDs();    //저장후 행사율 못가져와서 다시 복사
}

/**
 * btn_Excel()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : 박래형
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

function fn_strcd_reset()  {
	 
	var j = DS_IO_DETAIL.CountRow;
	 for(var i=1; i <= j; i++){
		 
		 DS_IO_DETAIL.NameValue(i, "STR_CD")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
		 
	 }
	 
 }
 
function btn_Conf() {
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
    var strProcStat    = LC_O_JPST.BindColVal;       //전표상태
    var strPumbun      = EM_S_PB_CD.Text;            //브랜드코드
    var strVen         = EM_S_VEN_CD.Text;           //협력사코드
    var strSlip_flag   = RD_S_SLIP_FLAG.CodeValue;   //전표구분
    var strSlipNo      = EM_S_SLIP_NO.Text;          // 전표번호
   
    var goTo        = "getList" ;    
    var action      = "O";     
    var parameters  = "&strStrCd="		+encodeURIComponent(strStrCd)     
                    + "&strBumun="		+encodeURIComponent(strBumun)     
                    + "&strTeam="		+encodeURIComponent(strTeam)      
                    + "&strPc="	 		+encodeURIComponent(strPc)        
                    + "&strOrgCd="		+encodeURIComponent(strOrgCd)        
                    + "&strGiJunDtType="+encodeURIComponent(strGiJunDtType)
                    + "&strStartDt="	+encodeURIComponent(strStartDt)   
                    + "&strEndDt="		+encodeURIComponent(strEndDt)     
                    + "&strProcStat="	+encodeURIComponent(strProcStat)  
                    + "&strPumbun="		+encodeURIComponent(strPumbun)    
                    + "&strVen="		+encodeURIComponent(strVen)       
                    + "&strSlip_flag="	+encodeURIComponent(strSlip_flag)
                    + "&strSlipNo="		+encodeURIComponent(strSlipNo); 
    TR_L_MAIN.Action="/dps/pord101.po?goTo="+goTo+parameters;  
    TR_L_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_LIST)"; //조회는 O
    TR_L_MAIN.Post();    

    GR_MASTER.SetColumn("STR_NM");
    GR_MASTER.Focus();     

    EM_I_PB_CD.Enable = false;              
    enableControl(IMG_PUMBUN_CD, false);
 }
 
 /**
 * getMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getMaster(){

        var strStrCd     = DS_LIST.NameValue(DS_LIST.RowPosition,"STR_CD");
        var strSlipNo    = DS_LIST.NameValue(DS_LIST.RowPosition,"SLIP_NO");
        var strPumbunCd  = DS_LIST.NameValue(DS_LIST.RowPosition,"PUMBUN_CD");
        var strMgAppDt   = DS_LIST.NameValue(DS_LIST.RowPosition,"MG_APP_DT");
        var strEvtFlag   = DS_LIST.NameValue(DS_LIST.RowPosition,"EVENT_FLAG");
        var strDatasetId = "DS_O_RESULT";
        var strVenCd     = EM_O_HRS_CD.Text;
        
        getMarginFlag(strStrCd, strPumbunCd, strMgAppDt);
//        getMarginRate(strStrCd, strPumbunCd, strMgAppDt, strEvtFlag);
        
        //foguddk
        
        var goTo       = "getMaster" ;    
        var action     = "O";     
        var parameters = "&strStrCd=" +encodeURIComponent(strStrCd)+
                         "&strSlipNo="+encodeURIComponent(strSlipNo);
        
        TR_S_MAIN.Action="/dps/pord101.po?goTo="+goTo+parameters;  
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
    var parameters = "&strStrCd=" +encodeURIComponent(strStrCd)+
                     "&strSlipNo="+encodeURIComponent(strSlipNo);
    
    TR_S_MAIN.Action="/dps/pord101.po?goTo="+goTo+parameters;  
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
        
//         LC_I_SH_GBN.Enable    = flag;             //사후구분
         EM_I_PB_CD.Enable     = flag;             //브랜드
         EM_I_BJDATE.Enable    = flag;             //발주일
         EM_I_NPYJDATE.Enable  = flag;             //납품예정일
         EM_I_MAJINDATE.Enable = flag;             //마진적용일
         //EM_O_ETC.Enable       = flag;             //비고
         LC_I_HS_GBN.Enable    = flag;             //행사구분
         LC_I_HS_RATE.Enable   = flag;             //행사율
         LC_I_STORE.Enable     = flag;             //점(입력용)         
         EM_I_BJDATE.Enable    = flag;  
         EM_I_NPYJDATE.Enable  = flag;
         EM_I_MAJINDATE.Enable = flag;
         
         enableControl(IMG_PUMBUN_CD, flag);
         enableControl(IMG_BJ_DATE, flag);
         enableControl(IMG_NPYJ_DATE, flag);
         enableControl(IMG_MJ_DATE, flag);
  }  

 /**
  * addDetailRow()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-02-10
  * 개    요 : DETAIL 그리드 행추가
  * return값 : void
  */
 function addDetailRow(){
       
//getMarginRate(LC_I_HS_RATE.BindColVal);        // 바인드시킨 값을 잃어버렸기 때문에 다시 셋팅
    if(DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "전표 마스터 내용을 먼저 추가해 주세요.");
        return;
    }
   
    //마스터 필수 입력 내용 체크
    if(checkValidation("Add")){
        DS_IO_DETAIL.Addrow();
//        GR_DETAIL.SetColumn("PUMMOK_CD");
//        GR_DETAIL.Focus();     
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SLIP_NO")    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMBUN_CD")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SLIP_FLAG")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG"); 
//      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "MG_RATE")    = DS_EVENT_RATE.NameValue(DS_EVENT_RATE.RowPosition, "NORM_MG_RATE");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "MG_RATE")    = EM_O_MG_RATE.Text;


//        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "NEW_GAP_RATE")    = DS_EVENT_RATE.NameValue(DS_EVENT_RATE.RowPosition, "NORM_MG_RATE");        
        
        setObject(false); 
        RD_SLIP_FLAG.Enable   = true;             //전표구분
        LC_I_SH_GBN.Enable    = false;
        //GR_DETAIL.SetColumn("PUMMOK_CD");
        GR_DETAIL.SetColumn("PUMMOK_SRT_CD");
        GR_DETAIL.Focus();
    }    
 }  

 /**
 * delDetailRow()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : DETAIL 그리드 행삭제
 * return값 : void
 */+
 function delDetailRow(){

    if(DS_IO_DETAIL.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
    sel_DeleteRow( DS_IO_DETAIL, "CHECK1" );

    //그리드 CHEKCBOX헤더 체크해제
    GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "false";
    
    if(DS_IO_DETAIL.CountRow == 0){
        //입력부의 컴퍼넌트들을 디저블시킨다.
        setObject(true);   
        RD_SLIP_FLAG.Enable = true;
        LC_I_SH_GBN.Enable  = true;      
        
        //사후구분이 재고조정일때 발주일, 납품예정일, 마진적용일 달력컨트롤 사용막는다
//        setCalImgDis(false);           
    }else{
        setObject(false);   
        RD_SLIP_FLAG.Enable = false;
    }    
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
               showMessage(EXCLAMATION, OK, messageCode, "점");
               LC_O_STR.Focus();
               return false;
         }  
         /*
         if(LC_O_BUMUN.Text.length == 0){                                       // 팀
             showMessage(EXCLAMATION, OK, messageCode, "팀");
             LC_O_BUMUN.Focus();
             return false;
         }  
         if(LC_O_TEAM.Text.length == 0){                                        // 파트
             showMessage(EXCLAMATION, OK, messageCode, "파트");
             LC_O_TEAM.Focus();
             return false;
         }  
         if(LC_O_PC.Text.length == 0){                                          // PC
             showMessage(EXCLAMATION, OK, messageCode, "PC");
             LC_O_PC.Focus();
             return false;
         }  
         */
         if(LC_O_GJDATE.Text.length == 0){                                      // 기준일
             showMessage(EXCLAMATION, OK, messageCode, "기준일");
             LC_O_GJDATE.Focus();
             return false;
         }

         if(EM_S_START_DT.Text.length == 0){                                    // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회시작일");
             EM_S_START_DT.Focus();
             return false;
        }
         if(EM_S_END_DT.Text.length == 0){                                      // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회종료일");
             EM_S_END_DT.Focus();
             return false;
        }
         if(EM_S_START_DT.Text > EM_S_END_DT.Text){                             // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1015");
             EM_S_START_DT.Focus();
             return false;
         }
         return true; 

     case "Add":        

         if(LC_I_STORE.Text.length == 0){                                       // 점
             showMessage(EXCLAMATION, OK, "USER-1003", "점");                 
             LC_I_STORE.Focus();                                              
             return false;                                                      
         }
         
         if(LC_I_SH_GBN.Text.length == 0){                                      // 사후구분
             showMessage(EXCLAMATION, OK, "USER-1003", "사후구분");                 
             LC_I_SH_GBN.Focus();                                              
             return false;                                                      
         }

         if(EM_I_PB_CD.Text.length == 0){                                 // 브랜드
             showMessage(EXCLAMATION, OK, "USER-1002", "브랜드");
             EM_I_PB_CD.Focus();
             return false;
         }

        // 존재하는 브랜드 코드인지 확인한다.
         if(!pumbunValCheck()){
             showMessage(EXCLAMATION, OK, "USER-1069", "브랜드");
             EM_I_PB_CD.Focus();
             return false;
         }
                                                                                
         if(EM_I_MAJINDATE.Text.length == 0){                                   // 마진적용일
             showMessage(EXCLAMATION, OK, "USER-1003", "마진적용일");
             EM_I_MAJINDATE.Focus();
             return false;
          } 
                                                                                
         if(LC_I_HS_GBN.Text.length == 0){                                      // 행사구분
             showMessage(EXCLAMATION, OK, "USER-1003", "행사구분");
             LC_I_HS_GBN.Focus();
             return false;
          } 
                                                                                
         if(LC_I_HS_RATE.Text.length == 0){                                     // 행사율
             showMessage(EXCLAMATION, OK, "USER-1003", "행사율");
             LC_I_HS_RATE.Focus();
             return false;
         } 
        
         if(EM_I_BJDATE.Text > EM_I_NPYJDATE.Text){                              // 납품예정일
             showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");
             EM_I_NPYJDATE.Focus();
             return false;
         }     
         
         if(EM_I_NPYJDATE.Text > EM_I_MAJINDATE.Text){                           // 마진적용일
             showMessage(EXCLAMATION, OK, "USER-1020", "마진적용일","납품예정일");
             EM_I_MAJINDATE.Focus();
             return false;
         } 
         
         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "REMARK", "비고", "EM_O_ETC") )  // 비고
             return false;

         var strPmkSrtCd   = "";                    // 단축코드
         var strPumMokCd   = "";                    // 품목코드
         var intQty        = 0;                     // 수량             
         var intNewSalePrc = 0;                     // 매가단가

         var intRowCount   = DS_IO_DETAIL.CountRow;
         if(intRowCount > 0){
             for(var i=1; i <= intRowCount; i++){
                 
            	strPmkSrtCd   = DS_IO_DETAIL.NameValue(i, "PUMMOK_SRT_CD");
                strPumMokCd   = DS_IO_DETAIL.NameValue(i, "PUMMOK_CD");
                intQty        = DS_IO_DETAIL.NameValue(i, "ORD_QTY");
                intNewSalePrc = DS_IO_DETAIL.NameValue(i, "NEW_SALE_PRC");                
                
                //단축코드 없을시 체크한다.
                if(strPmkSrtCd.length <= 0){
                    return true;
                }
                
                /*
                //품목코드 없을시 체크한다.
                if(strPumMokCd.length <= 0){
                    return true;
                }                
                */
                
                /*
                getPbnPmkPop2() 이함수 써보기                 
                
                // 존재하는 품목 코드인지 확인한다.
                if(!getPbnPmkPop(i, "PUMMOK_CD","0")){
                    showMessage(EXCLAMATION, OK, "USER-1069", "품목코드");
                    GR_DETAIL.SetColumn("PUMMOK_CD");  
                    DS_IO_DETAIL.RowPosition = i;  
                    return false;
                }               
                */            
                 
                /*
                if(!getPbnPmkPop2(i)){
                    showMessage(EXCLAMATION, OK, "USER-1069", "품목코드");
                    GR_DETAIL.SetColumn("PUMMOK_CD");  
                    DS_IO_DETAIL.RowPosition = i;  
                    return false;
                }   
                */
                /*
                                            품목등록시 중복을 허용한다. 20100704 박래형(현업 요청사항)
                // 중복체크
                var dupRow = checkDupKey(DS_IO_DETAIL, "PUMMOK_CD");
                if (dupRow > 0) {
                    showMessage(StopSign, Ok,  "USER-1044", dupRow);
                    //DS_IO_DETAIL.NameValue( dupRow, "PUMMOK_CD")  = "";
                    
                    DS_IO_DETAIL.RowPosition = dupRow;
                    GR_DETAIL.SetColumn("PUMMOK_CD");
                    GR_DETAIL.Focus(); 

                    return false;
                }
                */
                
                if(intQty <= 0){
                    showMessage(EXCLAMATION, OK, "USER-1008", "발주수량",  "0");
                    DS_IO_DETAIL.RowPosition = i;
                    GR_DETAIL.SetColumn("ORD_QTY");
                    GR_DETAIL.Focus(); 
 
                    return false;
                }
                
                if(intNewSalePrc <= 0){
                    showMessage(EXCLAMATION, OK, "USER-1008", "매가단가",  "0");
                    DS_IO_DETAIL.RowPosition = i;
                    GR_DETAIL.SetColumn("NEW_SALE_PRC");
                    GR_DETAIL.Focus();
     
                    return false;
                }
             }
         }
         return true; 

     case "Save":        
    	 var strStrCd        = DS_LIST.NameValue(DS_LIST.RowPosition, "STR_CD");           // 점
         var strSlipNo       = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_NO");          // 발주번호
         if(!slipProcStatCheck(strStrCd, strSlipNo))                                        // 전표상태확인
             return false;
         
         if(LC_I_STORE.Text.length == 0){                                       // 점
             showMessage(EXCLAMATION, OK, "USER-1003", "점");                 
             LC_I_STORE.Focus();                                              
             return false;                                                      
         }
         
         if(LC_I_SH_GBN.Text.length == 0){                                      // 사후구분
             showMessage(EXCLAMATION, OK, "USER-1003", "사후구분");                 
             LC_I_SH_GBN.Focus();                                              
             return false;                                                      
         }

         if(EM_I_PB_CD.Text.length == 0){                                 // 브랜드
             showMessage(EXCLAMATION, OK, "USER-1002", "브랜드");
             EM_I_PB_CD.Focus();
             return false;
         }

        // 존재하는 브랜드 코드인지 확인한다.
         if(!pumbunValCheck()){
             showMessage(EXCLAMATION, OK, "USER-1069", "브랜드");
             EM_I_PB_CD.Focus();
             return false;
         }
                                                                                
         if(EM_I_MAJINDATE.Text.length == 0){                                   // 마진적용일
             showMessage(EXCLAMATION, OK, "USER-1003", "마진적용일");
             EM_I_MAJINDATE.Focus();
             return false;
          } 
                                                                                
         if(LC_I_HS_GBN.Text.length == 0){                                      // 행사구분
             showMessage(EXCLAMATION, OK, "USER-1003", "행사구분");
             LC_I_HS_GBN.Focus();
             return false;
          } 
                                                                                
         if(LC_I_HS_RATE.Text.length == 0){                                     // 행사율
             showMessage(EXCLAMATION, OK, "USER-1003", "행사율");
             LC_I_HS_RATE.Focus();
             return false;
         } 
        
         // MARIO OUTLET (당일발주마감 시간 이후인 경우)
         if (!orderCloseCheck()) {
        	 // 신규 등록 && 매입 전표 && 사전전표 && 발주일 <= 현재일자
        	 if (strSlipNo == '' && RD_SLIP_FLAG.CodeValue == 'A' && LC_I_SH_GBN.BindColVal == '0' && EM_I_BJDATE.Text <= strToday) {
        		 showMessage(EXCLAMATION, OK, "GAUCE-1000", "발주 등록 마감 시간 이후에는 당일 발주 불가 합니다."); 
                 EM_I_BJDATE.Focus();
                 return false; 
        	 }
         }
     	 // MARIO OUTLET

         if(EM_I_BJDATE.Text > EM_I_NPYJDATE.Text){                              // 납품예정일
             showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");
             EM_I_NPYJDATE.Focus();
             return false;
         }     
         
         if(EM_I_NPYJDATE.Text > EM_I_MAJINDATE.Text){                           // 마진적용일
             showMessage(EXCLAMATION, OK, "USER-1020", "마진적용일","납품예정일");
             EM_I_MAJINDATE.Focus();
             return false;
         } 
         
         if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "REMARK", "비고", "EM_O_ETC") )  // 비고
             return false;

         var strPmkSrtCd   = "";                    // 단축코드
         var strPumMokCd   = "";                    // 품목코드
         var intQty        = 0;                     // 수량             
         var intNewSalePrc = 0;                     // 매가단가

         var intRowCount   = DS_IO_DETAIL.CountRow;
         if(intRowCount > 0){
             for(var i=1; i <= intRowCount; i++){
                 
            	strPmkSrtCd   = DS_IO_DETAIL.NameValue(i, "PUMMOK_SRT_CD");
            	strPumMokCd   = DS_IO_DETAIL.NameValue(i, "PUMMOK_CD");
                intQty        = DS_IO_DETAIL.NameValue(i, "ORD_QTY");
                intNewSalePrc = DS_IO_DETAIL.NameValue(i, "NEW_SALE_PRC");
                
                //alert(i + "번째 품목코드 = " + strPumMokCd);
                
                //저장시 단축코드가 없으면 그 행은 지우고 저장한다.
                if(strPmkSrtCd == ""){
                    DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                    
                } else {
                    DS_IO_DETAIL.NameValue(i, "CHECK1") = "F";
                    
                    if(!getPbnPmkSrtPop2(i)){
                        showMessage(EXCLAMATION, OK, "USER-1069", "단축코드");
                        GR_DETAIL.SetColumn("PUMMOK_SRT_CD");  
                        DS_IO_DETAIL.RowPosition = i;  
                        return false;
                    }
                    
                    /*
                    if(!getPbnPmkPop2(i)){
                        showMessage(EXCLAMATION, OK, "USER-1069", "품콕코드");
                        GR_DETAIL.SetColumn("PUMMOK_CD");  
                        DS_IO_DETAIL.RowPosition = i;  
                        return false;
                    }
                    */

                    if(intQty <= 0){
                        showMessage(EXCLAMATION, OK, "USER-1008", "발주수량",  "0");
                        DS_IO_DETAIL.RowPosition = i;
                        GR_DETAIL.SetColumn("ORD_QTY");
                        GR_DETAIL.Focus(); 
     
                        return false;
                    }
                    
                    if(intNewSalePrc <= 0){
                        showMessage(EXCLAMATION, OK, "USER-1008", "매가단가",  "0");
                        DS_IO_DETAIL.RowPosition = i;
                        GR_DETAIL.SetColumn("NEW_SALE_PRC");
                        GR_DETAIL.Focus();
         
                        return false;
                    }        
                } 
                
                /*
                //저장시 품목코드가 없으면 그 행은 지우고 저장한다.
                if(strPumMokCd == ""){
                    //showMessage(EXCLAMATION, OK, "USER-1003", "품목코드");
                    //GR_DETAIL.SetColumn("PUMMOK_CD");  
                    //DS_IO_DETAIL.RowPosition = i;  
                    DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                    
                }else{  //품목코드가 있으면 정합성 체크를 한다.

                    DS_IO_DETAIL.NameValue(i, "CHECK1") = "F";
                
                    if(!getPbnPmkSrtPop2(i)){
                        showMessage(EXCLAMATION, OK, "USER-1069", "단축코드");
                        GR_DETAIL.SetColumn("PUMMOK_SRT_CD");  
                        DS_IO_DETAIL.RowPosition = i;  
                        return false;
                    }

                    if(!getPbnPmkPop2(i)){
                        showMessage(EXCLAMATION, OK, "USER-1069", "품목코드");
                        GR_DETAIL.SetColumn("PUMMOK_CD");  
                        DS_IO_DETAIL.RowPosition = i;  
                        return false;
                    }   
                    */
                    /*
                                                     품목등록시 중복을 허용한다. 20100704 박래형(현업 요청사항)
                    // 중복체크
                    var dupRow = checkDupKey(DS_IO_DETAIL, "PUMMOK_CD");
                    if (dupRow > 0) {
                        showMessage(StopSign, Ok,  "USER-1044", dupRow);
                        //DS_IO_DETAIL.NameValue( dupRow, "PUMMOK_CD")  = "";
                        
                        DS_IO_DETAIL.RowPosition = dupRow;
                        GR_DETAIL.SetColumn("PUMMOK_CD");
                        GR_DETAIL.Focus(); 

                        return false;
                    }
                    */
                    
                    if(intQty <= 0){
                        showMessage(EXCLAMATION, OK, "USER-1008", "발주수량",  "0");
                        DS_IO_DETAIL.RowPosition = i;
                        GR_DETAIL.SetColumn("ORD_QTY");
                        GR_DETAIL.Focus(); 
     
                        return false;
                    }
                    
                    if(intNewSalePrc <= 0){
                        showMessage(EXCLAMATION, OK, "USER-1008", "매가단가",  "0");
                        DS_IO_DETAIL.RowPosition = i;
                        GR_DETAIL.SetColumn("NEW_SALE_PRC");
                        GR_DETAIL.Focus();
         
                        return false;
                    }                	
                //}
             }
             sel_DeleteRow( DS_IO_DETAIL, "CHECK1" );
             if(DS_IO_DETAIL.CountRow <= 0){
                 showMessage(EXCLAMATION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오."); 
                 GR_DETAIL.Focus();
                 return;
             }
         }
         return true; 
     
     case "Delete":
    	 var strStrCd        = DS_LIST.NameValue(DS_LIST.RowPosition, "STR_CD");           // 점
         var strSlipNo       = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_NO");          // 발주번호
         var strRegDate      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REG_DATE");   // 등록일자
         var strSlipProcStat = getSlipProcStat("DS_O_RESULT", strStrCd, strSlipNo);            // 전표상태  
       
        if(strSlipProcStat != "00"){
            showMessage(EXCLAMATION, OK, "USER-1160"); 
            return false;
        }

        // MARIO OUTLET COMMENT 
        /*
        if(strRegDate != strToday){
            showMessage(EXCLAMATION, OK, "USER-1170");
            return false;
        }
        */
        // MARIO OUTLET COMMENT 
        return true; 
     }     
}
  
/**
 * setCalImgDis(flag)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-11
 * 개    요    : 사후구분에 따른 입력부 일자(이미지) 컨트롤 유무
 * return값 : void
 */
function setCalImgDis(flag){
   enableControl(IMG_BJ_DATE, flag);    //발주일
   enableControl(IMG_NPYJ_DATE, flag);  //납품예정일
   enableControl(IMG_MJ_DATE, flag);    //마진적용일
}

/**
 * showRegMessage(strMsg, obj)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-14
 * 개    요    : DETAIL 그리드 행추가 시 validation체크 메시지창 팝업
 * return값 : void
 */
function showRegMessage(strMsg, obj){
      showMessage(EXCLAMATION, OK, "USER-1000", strMsg);
      obj.Focus();
   }

/**
 * getMarjinFlag()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-21
 * 개    요 :  마진적용일에 대한 행사구분 콤보로 조회
 * return값 : void
 */
 function getMarginFlag( strCd, pumbunCd, mgappDt){
    // 조회조건 셋팅
    var strStrCd        = strCd;        //점
    var strPumbunCd     = pumbunCd;     //브랜드
    var strMarginAppDt  = mgappDt;      //마진적용일
   
    var goTo       = "getMarginFlag" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="		+encodeURIComponent(strStrCd)     
                   + "&strPumbunCd="	+encodeURIComponent(strPumbunCd)    
                   + "&strMarginAppDt="	+encodeURIComponent(strMarginAppDt);    
    TR_S_MAIN.Action="/dps/pord101.po?goTo="+goTo+parameters;  
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
  function getMarginRate(strCd, pumbunCd, mgappDt, evtFlag){
     // 조회조건 셋팅
     var strStrCd        = strCd;      //점
     var strPumbunCd     = pumbunCd;   //브랜드
     var strMarginAppDt  = mgappDt;    //마진적용일
     var strMarginGbn    = evtFlag;    //행사구분
     
     var goTo       = "getMarginRate" ;    
     var action     = "O";     
     var parameters = "&strStrCd="		+encodeURIComponent(strStrCd)     
                    + "&strPumbunCd="	+encodeURIComponent(strPumbunCd)     
                    + "&strMarginAppDt="+encodeURIComponent(strMarginAppDt)
                    + "&strMarginGbn="	+encodeURIComponent(strMarginGbn);     
     TR_MAIN.Action="/dps/pord101.po?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_EVENT_RATE=DS_EVENT_RATE)"; //조회는 O
     TR_MAIN.Post();      
//     LC_I_HS_RATE.Enable = true;
  }

  /**
  * getPumbunInfo(pop)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-07
  * 개    요 :  브랜드팝업 관련 데이터 조회 및 세팅
  * return값 : void
  */
  function getPumbunInfo(){
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
      var strSaleBuyFlag  = "";                                                        // 판매분매입구분(1:사전매입) -- MARIO OUTLET
      
      
      var rtnMap = strPbnPop(EM_I_PB_CD, EM_I_PB_NM, 'Y'
                             ,strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                             ,strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                             ,strBizType,strSaleBuyFlag);     
      if(rtnMap != null){

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

          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_TYPE")  = rtnMap.get("BIZ_TYPE");
          EM_O_BUYER_CD.Text   = rtnMap.get("CHAR_BUYER_CD");
          EM_O_BUYER_NM.Text   = rtnMap.get("BUYER_EMP_NAME");

          
          EM_O_HRS_CD.Text     = rtnMap.get("VEN_CD");
          EM_O_HRS_NM.Text     = rtnMap.get("VEN_NAME");

          EM_I_BJDATE.Focus();
//          EM_O_BALJUJC.Text = DS_ORD_OWN_FLAG.NameValue(idx, "NAME");     // 발주주체
          
          LC_I_HS_RATE.Text = "";
          LC_I_HS_RATE.Enable = false;
          LC_I_HS_GBN.Enable = true;
          getMarginFlag(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text);  
          // 저장시 다시 한번 브랜드의 존재여부를 확인하기 위해          
      }
      
      if(rtnMap != null) return true;
  }
  

  /**
  * getPumbunInfoNonPop()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-07
  * 개    요 :  브랜드팝업 관련 데이터 조회 및 세팅
  * return값 : void
  */
  function getPumbunInfoNonPop(){
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
      var strSaleBuyFlag  = "";                                                        // 판매분매입구분(1:사전매입) --MARIO OUTLET
      
      var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PB_CD, EM_I_PB_NM, "Y", "1"
                            , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                            , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                            , strBizType,strSaleBuyFlag);
      
      if(DS_O_RESULT.CountRow == 1){
                        
          var idx = "";
          
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

          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_TYPE")  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BIZ_TYPE");
          // 협력사코드
          EM_O_HRS_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_NAME");
          EM_O_HRS_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD");
          
          // 바이어
          EM_O_BUYER_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "BUYER_EMP_NAME");
          EM_O_BUYER_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "CHAR_BUYER_CD");


          EM_I_BJDATE.Focus();
//          EM_O_BALJUJC.Text = DS_ORD_OWN_FLAG.NameValue(idx, "NAME");     // 발주주체
          LC_I_HS_GBN.Enable = true;
          getMarginFlag(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text);  
          // 저장시 다시 한번 브랜드의 존재여부를 확인하기 위해
      }   

      if(rtnMap != null){
    	    
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
          
          EM_O_HRS_CD.Text     = rtnMap.get("VEN_CD");
          EM_O_HRS_NM.Text     = rtnMap.get("VEN_NAME");

          EM_I_BJDATE.Focus();
//          EM_O_BALJUJC.Text = DS_ORD_OWN_FLAG.NameValue(idx, "NAME");     // 발주주체
          LC_I_HS_GBN.Enable = true;
          getMarginFlag(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text);  
          // 저장시 다시 한번 브랜드의 존재여부를 확인하기 위해
          
      }
      if(DS_O_RESULT.CountRow > 0) return true;
  }
  
 
  /**
   * getPummokInfo(strPbnPmk)
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-02-21
   * 개    요 :  브랜드별 품목데이터에 정합성 체크
   * return값 : void
   */
   
  function getPummokInfo(){
       
//     alert("브랜드에 따른 품목 제대로 체크하나");
      // 조회조건 셋팅
      var strPumbunCd     = EM_I_PB_CD.Text;          //브랜드
      var strPummokCd     = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMMOK_CD");                //품목
    
      var goTo       = "getPummokInfo" ;    
      var action     = "O";     
      var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd)     
                     + "&strPummokCd="+encodeURIComponent(strPummokCd);   
      TR_S_MAIN.Action="/dps/pord101.po?goTo="+goTo+parameters;  
      TR_S_MAIN.KeyValue="SERVLET("+action+":DS_PUMMOK_INFO=DS_PUMMOK_INFO)"; //조회는 O
      TR_S_MAIN.Post(); 
      
      if(DS_PUMMOK_INFO.CountRow <= 0){
//    	  alert("뭐가이상한거지");
          return false;        
      }else{
          return true;
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
       
     var strMummokCd  = DS_IO_DETAIL.NameValue(row,"PUMMOK_CD");    //품목코드
//     var strMummokCNm = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"PUMMOK_NM"); //품목명
     var strPumbunCd  = EM_I_PB_CD.Text;
         
/*      
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
*/        
         
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

//                 DS_IO_DETAIL.NameValue(row+i, "MG_RATE")          = DS_EVENT_RATE.NameValue(1, "NORM_MG_RATE");
                 DS_IO_DETAIL.NameValue(row+i, "MG_RATE")          = EM_O_MG_RATE.Text;
                 
             }
             if(rtnList.length > 1){
            	 //alert('3');
                 setFocusGrid(GR_DETAIL, DS_IO_DETAIL,row,"ORD_QTY");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동             
             }
         }         
//     }
         
     // 단품코드 존재여부 확인을 위해
//     if(rtnMap != null) return true;
//     else return false;
     
     if(rtnList != null) return true;
     else return false;
   }
  
   /**
    * getPbnPmkPop2(Row)
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-08
    * 개    요 :  브랜드에 따른 품목
    * return값 : void
    */
    function getPbnPmkPop2(Row){
        
 	 //alert( "여기를 왜 들어오나 Row  =  " + Row);
      var strMummokCd  = DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD"); //품목코드
      var strMummokCNm = DS_IO_DETAIL.NameValue(Row, "PUMMOK_NM"); //품목명
      var strPumbunCd  = EM_I_PB_CD.Text;     

      var rtnMap = setPbnPmkNmWithoutToGridPop( "DS_O_RESULT", strMummokCd, strMummokCNm, strPumbunCd, 
                                                "1", "");
      if(rtnMap != null){         
          DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD")        = rtnMap.get("PUMMOK_CD");
          DS_IO_DETAIL.NameValue(Row, "PUMMOK_NM")        = rtnMap.get("PUMMOK_NAME");
          DS_IO_DETAIL.NameValue(Row, "TAG_FLAG")         = rtnMap.get("TAG_FLAG");
          DS_IO_DETAIL.NameValue(Row, "TAG_PRT_OWN_FLAG") = rtnMap.get("TAG_PRT_OWN_FLAG");
          DS_IO_DETAIL.NameValue(Row, "ORD_UNIT_CD")      = rtnMap.get("UNIT_CD");
      }else{
          GR_MASTER.SetColumn("PUMMOK_CD"); 
          GR_DETAIL.Focus();
      }

      if(rtnMap != null) return true;
      else return false;
   }

    
    /**
     * getPmkSrtInfo()
     * 작 성 자 : DHL
     * 작 성 일 : 2012-05-11
     * 개    요 :  브랜드별 품목 단축코드  정합성 체크
     * return값 : void
     */
    function getPmkSrtInfo(){
         
//       alert("브랜드에 따른 품목 제대로 체크하나");
        // 조회조건 셋팅
        var strPumbunCd     = EM_I_PB_CD.Text;          //브랜드
        var strPmkSrtCd     = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMMOK_SRT_CD");    //단축코드
      
        var goTo       = "getPmkSrtInfo" ;    
        var action     = "O";     
        var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd)     
                       + "&strPmkSrtCd="+encodeURIComponent(strPmkSrtCd);   
        TR_S_MAIN.Action="/dps/pord101.po?goTo="+goTo+parameters;  
        TR_S_MAIN.KeyValue="SERVLET("+action+":DS_PUMMOK_SRT_INFO=DS_PUMMOK_SRT_INFO)"; //조회는 O
        TR_S_MAIN.Post(); 
        
        if(DS_PUMMOK_SRT_INFO.CountRow <= 0){
//      	  alert("뭐가이상한거지");
            return false;        
        }else{
            return true;
        }
     } 

  /**
    * getPbnPmkSrtPop(row, colid, popFlag)
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-08
    * 개    요 :  브랜드에 따른  단축코드
    * return값 : void
    */
    function getPbnPmkSrtPop(row, colid, popFlag){
        
      var strPmkSrtCd  = DS_IO_DETAIL.NameValue(row,"PUMMOK_SRT_CD"); //단축코드
      var strPumbunCd  = EM_I_PB_CD.Text;
      
/*      
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
*/                  
          // 20120509 * DHL * 수정 -->
          // var rtnList = pbnPmkMultiSelPop(strPmkSrtCd,"",strPumbunCd,"", "", "N");
          var rtnList = pbnPmkMultiSelLevelPop(strPmkSrtCd,"",strPumbunCd,"", "", "N");
          // 20120509 * DHL * 수정 <--
          
          if(rtnList != null){
              for(var i = 0; i < rtnList.length; i++){
                  if(i != 0 )
                      DS_IO_DETAIL.AddRow();          
                  
                  DS_IO_DETAIL.NameValue(row+i, "SLIP_NO")    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_NO");
                  DS_IO_DETAIL.NameValue(row+i, "STR_CD")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
                  DS_IO_DETAIL.NameValue(row+i, "PUMBUN_CD")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");
                  DS_IO_DETAIL.NameValue(row+i, "VEN_CD")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
                  DS_IO_DETAIL.NameValue(row+i, "SLIP_FLAG")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG");
                  
                  DS_IO_DETAIL.NameValue(row+i, "PUMMOK_SRT_CD")    = rtnList[i].PUMMOK_SRT_CD;
                  DS_IO_DETAIL.NameValue(row+i, "PUMMOK_CD")        = rtnList[i].PUMMOK_CD;
                  DS_IO_DETAIL.NameValue(row+i, "PUMMOK_NM")        = rtnList[i].PUMMOK_NAME;
                  DS_IO_DETAIL.NameValue(row+i, "TAG_FLAG")         = rtnList[i].TAG_FLAG;
                  DS_IO_DETAIL.NameValue(row+i, "TAG_PRT_OWN_FLAG") = rtnList[i].TAG_PRT_OWN_FLAG;
                  DS_IO_DETAIL.NameValue(row+i, "ORD_UNIT_CD")      = rtnList[i].UNIT_CD;                  

//                  DS_IO_DETAIL.NameValue(row+i, "MG_RATE")          = DS_EVENT_RATE.NameValue(1, "NORM_MG_RATE");
                  DS_IO_DETAIL.NameValue(row+i, "MG_RATE")          = EM_O_MG_RATE.Text;
                  
                  
              }
              if(rtnList.length > 1){
            	  // alert('2');
                  setFocusGrid(GR_DETAIL, DS_IO_DETAIL,row,"ORD_QTY");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동             
              }
          }                  
//      }          
      // 단품코드 존재여부 확인을 위해
//      if(rtnMap != null) return true;
//      else return false;
      
      if(rtnList != null) return true;
      else return false;
    }  
   
  /**
   * getPbnPmkSrtPop2(Row)
   * 작 성 자 : DHL
   * 작 성 일 : 2012-05-11
   * 개    요 :  브랜드에 따른 단축코드
   * return값 : void
   */
   function getPbnPmkSrtPop2(Row){
       
	 //alert( "여기를 왜 들어오나 Row  =  " + Row);
     var strPmkSrtCd  = DS_IO_DETAIL.NameValue(Row, "PUMMOK_SRT_CD"); //단축코드
     var strPummokCNm = DS_IO_DETAIL.NameValue(Row, "PUMMOK_NM"); //품목명
     var strPumbunCd  = EM_I_PB_CD.Text;     

     var rtnMap = setPbnPmkSrtNmWithoutToGridPop( "DS_O_RESULT", strPmkSrtCd, strPummokCNm, strPumbunCd, 
                                               "1", "");
     if(rtnMap != null){         
         DS_IO_DETAIL.NameValue(Row, "PUMMOK_SRT_CD")    = rtnMap.get("PUMMOK_SRT_CD");
         DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD")        = rtnMap.get("PUMMOK_CD");
         DS_IO_DETAIL.NameValue(Row, "PUMMOK_NM")        = rtnMap.get("PUMMOK_NAME");
         DS_IO_DETAIL.NameValue(Row, "TAG_FLAG")         = rtnMap.get("TAG_FLAG");
         DS_IO_DETAIL.NameValue(Row, "TAG_PRT_OWN_FLAG") = rtnMap.get("TAG_PRT_OWN_FLAG");
         DS_IO_DETAIL.NameValue(Row, "ORD_UNIT_CD")      = rtnMap.get("UNIT_CD");
     }else{
         GR_MASTER.SetColumn("PUMMOK_SRT_CD"); 
         GR_DETAIL.Focus();
     }

     if(rtnMap != null) return true;
     else return false;
  }
  
  /**
  * closeCheck()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-10
  * 개    요    : 저장시 일마감체크를 한다.
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
          showMessage(EXCLAMATION, OK, "USER-1068", "매입일","발주매입");
          return false;
      }else{
          return true;
      }
  }   
  
  
  /**
   * closeCheck()
   * 작 성 자 : MARIO OUTLET
   * 작 성 일 : 2010-03-10
   * 개    요    : 저장시 일마감체크를 한다.
   * return값 : void
   */
   function orderCloseCheck(){
       var strStrCd         = LC_I_STORE.BindColVal;  // 점
       var strCloseDt       = strToday;               // 마감체크일자
       var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
       var strCloseUnitFlag = "10";                   // 단위업무
       var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
       var strCloseFlag     = "T";                    // 마감구분(월마감:M)
      
       var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                     , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
       
       if(closeFlag == "TRUE"){
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
       var strTaxFlag  = EM_TAX_FLAG.Text;
       var ord_qty     = DS_IO_DETAIL.NameValue(row, "ORD_QTY");         // 발주수량
       var cost_prc    = 0;                                              // 원가단가
       var sale_prc    = DS_IO_DETAIL.NameValue(row, "NEW_SALE_PRC");    // 매가단가
       var cost_amt    = 0;                                              // 원가금액         
       var sale_amt    = 0;                                              // 매가금액
       var strMargin   = DS_IO_DETAIL.NameValue(row, "MG_RATE");         // 마진율     (Grid)    
       var sale_tot_prc = sale_prc * ord_qty;
       
       //함수로 구현
       /*
       if(strTaxFlag == "1"){         //과세
           cost_prc  = (((sale_prc*10) / 11) * ((100 - strMargin)) / 100);
       }else{                          //비과세, 영세
           cost_prc  = ((sale_prc * (100 - strMargin)) / 100);     
       }  
       */
       
/*
       // DETAIL---------------------------------------------------------------------------
       // 매가금액
       sale_amt  = sale_prc * ord_qty;    
       DS_IO_DETAIL.NameValue(row, "NEW_SALE_AMT") = sale_amt;            
  
       // 원가금액
       cost_amt = getCalcPord("COST_PRC", "", sale_amt, strMargin, strTaxFlag, roundFlag); 
       DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT") = cost_amt;            
       
       //원가단가
       DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC") = getRoundDec("1", cost_amt / ord_qty, 0);

       
       //디테일 차익액
       var gapAmt = getCalcPord("GAP_AMT", cost_amt, sale_amt, "", strTaxFlag, roundFlag);       
       DS_IO_DETAIL.NameValue(row, "NEW_GAP_AMT")  = gapAmt;      // 차익액
       
       //20100524 부가세 추가
       var vatAmt = getCalcPord("VAT_AMT", cost_amt, "", "", strTaxFlag, roundFlag);
       DS_IO_DETAIL.NameValue(row, "VAT_AMT") = vatAmt;      // 부가세
       // DETAIL---------------------------------------------------------------------------
 */       
       // DETAIL---------------------------------------------------------------------------
       // 매가금액
       
       
 	   
       sale_amt  = sale_prc * ord_qty;    
       DS_IO_DETAIL.NameValue(row, "NEW_SALE_AMT") = sale_amt;            

       //원가단가
       cost_prc = getCalcPord("COST_PRC", "", sale_prc, strMargin, strTaxFlag, roundFlag);
       DS_IO_DETAIL.NameValue(row, "OLD_COST_PRC") = cost_prc;
       DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC") = cost_prc;
       //alert("cost_amt : " + cost_amt);
 
       // 원가금액
//       alert("getRoundDec(roundFlag, cost_amt * ord_qty, 0)="+getRoundDec(roundFlag, cost_prc * ord_qty, 0));
       //DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT") = getRoundDec(roundFlag, cost_prc * ord_qty, 0);
       
       
       
//        DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT") = Math.round(( sale_tot_prc -( sale_tot_prc *strMargin/100))/1.1);		//AAAAAAAA - 마리오에서 수정부분
       DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT") = getRoundDec(roundFlag, cost_prc * ord_qty, 0);
       
 
       //디테일 차익액
       var gapAmt = getCalcPord("GAP_AMT", cost_prc * ord_qty, sale_amt, "", strTaxFlag, roundFlag);       
       DS_IO_DETAIL.NameValue(row, "NEW_GAP_AMT")  = gapAmt;      // 차익액
 
       
       
       //20100524 부가세 추가
       var vatAmt = getCalcPord("VAT_AMT", cost_prc * ord_qty, "", "", strTaxFlag, roundFlag);
       DS_IO_DETAIL.NameValue(row, "VAT_AMT") = vatAmt;      // 부가세
//        DS_IO_DETAIL.NameValue(row, "VAT_AMT") = sale_tot_prc-(sale_tot_prc*strMargin/100) - DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT");		//AAAAAAAA- 마리오에서 수정부분



       // DETAIL---------------------------------------------------------------------------

       // MASTER---------------------------------------------------------------------------
       //매가합
       var totSaleAmt = DS_IO_DETAIL.Sum(18,0,0);
//       alert("totSaleAmt=["+totSaleAmt+"]");
       DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NEW_SALE_TAMT") = totSaleAmt;
       
       // 원가합 재계산
       //var totCostAmt = getCalcPord("COST_PRC", "", totSaleAmt, strMargin, strTaxFlag, roundFlag); 
       var totCostAmt = DS_IO_DETAIL.Sum(16,0,0);
//       alert("totCostAmt=["+totCostAmt+"]");
       DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NEW_COST_TAMT") = totCostAmt;
       
       // VAT 재계산
//       var totVatTamt = getCalcPord("VAT_AMT", totCostAmt, "", "", strTaxFlag, roundFlag);
       var totVatTamt = DS_IO_DETAIL.Sum(25,0,0);
       DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VAT_TAMT") = totVatTamt;
       
       // VAT+공급가  재계산
       DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SUP_AMT") = totCostAmt + totVatTamt;
       
       //20100524 차익액합계
       var totGapAmt = getCalcPord("GAP_AMT", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
       DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAP_TOT_AMT")  = totGapAmt;
       
       //20100524 차익율 추가                  
       var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
       DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NEW_GAP_RATE") = totGapRate;

       EM_O_SRG.Text   = DS_IO_DETAIL.NameSum("ORD_QTY",0,0);
       //EM_O_WGG.Text   = DS_IO_DETAIL.NameSum("NEW_COST_AMT",0,0);
       EM_O_MGG.Text   = DS_IO_DETAIL.NameSum("NEW_SALE_AMT",0,0);
       
       
       	
       
       
       
       
    }  

   /**
    * calDetail2(row)
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-18
    * 개    요    : 수량변경시 원가 , 매가금액 합계금액 재 계산 
    * return값 : void
    */ 
      
    function calDetail3(row){  
        var strTaxFlag  = EM_TAX_FLAG.Text;
        var ord_qty     = DS_IO_DETAIL.NameValue(row, "ORD_QTY");         // 발주수량
        var cost_prc    = DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC");    // 원가단가
        var sale_prc    = DS_IO_DETAIL.NameValue(row, "NEW_SALE_PRC");    // 매가단가
        var cost_amt    = 0;                                              // 원가금액         
        var sale_amt    = 0;                                              // 매가금액
        var strMargin   = DS_IO_DETAIL.NameValue(row, "MG_RATE");         // 마진율     (Grid)    
        
        //함수로 구현
        /*
        if(strTaxFlag == "1"){         //과세
            cost_prc  = (((sale_prc*10) / 11) * ((100 - strMargin)) / 100);
        }else{                          //비과세, 영세
            cost_prc  = ((sale_prc * (100 - strMargin)) / 100);     
        }  
        */
        
 /*
        // DETAIL---------------------------------------------------------------------------
        // 매가금액
        sale_amt  = sale_prc * ord_qty;    
        DS_IO_DETAIL.NameValue(row, "NEW_SALE_AMT") = sale_amt;            
   
        // 원가금액
        cost_amt = getCalcPord("COST_PRC", "", sale_amt, strMargin, strTaxFlag, roundFlag); 
        DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT") = cost_amt;            
        
        //원가단가
        DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC") = getRoundDec("1", cost_amt / ord_qty, 0);

        
        //디테일 차익액
        var gapAmt = getCalcPord("GAP_AMT", cost_amt, sale_amt, "", strTaxFlag, roundFlag);       
        DS_IO_DETAIL.NameValue(row, "NEW_GAP_AMT")  = gapAmt;      // 차익액
        
        //20100524 부가세 추가
        var vatAmt = getCalcPord("VAT_AMT", cost_amt, "", "", strTaxFlag, roundFlag);
        DS_IO_DETAIL.NameValue(row, "VAT_AMT") = vatAmt;      // 부가세
        // DETAIL---------------------------------------------------------------------------
  */       
        // DETAIL---------------------------------------------------------------------------
        // 매가금액
        sale_amt  = sale_prc * ord_qty;    
        DS_IO_DETAIL.NameValue(row, "NEW_SALE_AMT") = sale_amt;            

        // 원가금액
//        alert("getRoundDec(roundFlag, cost_amt * ord_qty, 0)="+getRoundDec(roundFlag, cost_prc * ord_qty, 0));
        
        DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT") = getRoundDec(roundFlag, cost_prc * ord_qty, 0);
  
        //디테일 차익액
        var gapAmt = getCalcPord("GAP_AMT", cost_prc * ord_qty, sale_amt, "", strTaxFlag, roundFlag);       
        DS_IO_DETAIL.NameValue(row, "NEW_GAP_AMT")  = gapAmt;      // 차익액
  
        //20100524 부가세 추가
        var vatAmt = getCalcPord("VAT_AMT", cost_prc * ord_qty, "", "", strTaxFlag, roundFlag);
        DS_IO_DETAIL.NameValue(row, "VAT_AMT") = vatAmt;      // 부가세
        // DETAIL---------------------------------------------------------------------------

        // MASTER---------------------------------------------------------------------------
        //매가합
        var totSaleAmt = DS_IO_DETAIL.Sum(18,0,0);
//        alert("totSaleAmt=["+totSaleAmt+"]");
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NEW_SALE_TAMT") = totSaleAmt;
        
        // 원가합 재계산
        //var totCostAmt = getCalcPord("COST_PRC", "", totSaleAmt, strMargin, strTaxFlag, roundFlag); 
        var totCostAmt = DS_IO_DETAIL.Sum(16,0,0);
//        alert("totCostAmt=["+totCostAmt+"]");
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NEW_COST_TAMT") = totCostAmt;
        
        // VAT 재계산
//        var totVatTamt = getCalcPord("VAT_AMT", totCostAmt, "", "", strTaxFlag, roundFlag);
        var totVatTamt = DS_IO_DETAIL.Sum(25,0,0);
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VAT_TAMT") = totVatTamt;
        
        // VAT+공급가  재계산
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SUP_AMT") = totCostAmt + totVatTamt;
        
        //20100524 차익액합계
        var totGapAmt = getCalcPord("GAP_AMT", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GAP_TOT_AMT")  = totGapAmt;
        
        //20100524 차익율 추가                  
        var totGapRate = getCalcPord("GAP_RATE", totCostAmt, totSaleAmt, "", strTaxFlag, roundFlag);
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NEW_GAP_RATE") = totGapRate;

        EM_O_SRG.Text   = DS_IO_DETAIL.NameSum("ORD_QTY",0,0);
        //EM_O_WGG.Text   = DS_IO_DETAIL.NameSum("NEW_COST_AMT",0,0);
        EM_O_MGG.Text   = DS_IO_DETAIL.NameSum("NEW_SALE_AMT",0,0);
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
       var strPumbunType   = "0";                                                       // 브랜드유형
       var strUseYn        = "Y";                                                       // 사용여부
       var strSkuFlag      = "2";                                                       // 단품구분(2:비단품)
       var strSkuType      = "";                                                        // 단품종류(1:규격단품)
       var strItgOrdFlag   = "";                                                        // 통합발주여부
       var strBizType      = "2";                                                       // 거래형태(1:직매입) 
       var strSaleBuyFlag  = "";                                                        // 판매분매입구분 -- MARIO OUTLET

//       alert("왜타냐");
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
   * pumbunValCheck()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-22
   * 개    요 :  브랜드  Validation Check
   * return값 : void
   */
   function pumbunValCheck(){

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
       var strSaleBuyFlag  = "";                                                        // 판매분매입구분(1:사전매입) -- MARIO OUTLET


       var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PB_CD, EM_I_PB_NM, "Y", "0"
    	          , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
    	          , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
    	          , strBizType,strSaleBuyFlag);

	    if(DS_O_RESULT.CountRow == 1)
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
       var strPumBunType   = "0";                                                       // 브랜드유형(0:정상)
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
        var strPumbunType   = "0";                                                       // 브랜드유형
        var strUseYn        = "Y";                                                       // 사용여부
        var strSkuFlag      = "2";                                                       // 단품구분(2:비단품)
        var strSkuType      = "";                                                        // 단품종류(1:규격단품)
        var strItgOrdFlag   = "";                                                        // 통합발주여부
        var strBizType      = "2";                                                       // 거래형태(1:직매입) 
        var strSaleBuyFlag  = "";                                                        // 판매분매입구분 -- MARIO OUTLET

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
        var strPumBunType   = "0";                                                       // 브랜드유형(0:정상)
        var strBizType      = "2";                                                       // 거래형태
        var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
        var strBizFlag      = "";                                                        // 거래구분
        
        var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
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
     * clearDataSetRow(DataSet)
     * 작 성 자 : 박래형
     * 작 성 일 : 2010-03-08
     * 개    요 : 선택 로우의 데이터를 Clear한다.
     * 사용방법 : copyDataSet("DS_MASTER", "DS_DETAIL");
     *          fromDs -> 원본 데이터셋
     *          toDs   -> 복사 데이터셋
     *          컬럼명이 같은 데이터셋을 복사한다.
     **/
    function clearDataSetRow(DataSet){
        var intToColCnt       = DataSet.CountColumn;       // 대상 데이터셋 컬럼수
        var strColNM          = "";                        // 원본 데이터셋 컬럼명
        for(var i = 1; i <= intToColCnt; i++){
            strColNM = DataSet.ColumnID(i);
            DataSet.NameValue(DataSet.RowPosition, strColNM) = ""; 
        }
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "MG_RATE")    = EM_O_MG_RATE.Text;
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
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
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
        if(showMessage(QUESTION, YESNO, "GAUCE-1000", "변경된 내역이 있습니다. <br> 이동 하시겠습니까?") != 1 ){
            return false;
        }else {
            if(DS_LIST.NameValue(row, "SLIP_NO") == "")
                DS_LIST.DeleteRow(row);
    
            DS_IO_MASTER.NameValue(row,"ORD_TOT_QTY")   = DS_IO_MASTER.OrgNameValue(row,"ORD_TOT_QTY");
            DS_IO_MASTER.NameValue(row,"NEW_COST_TAMT") = DS_IO_MASTER.OrgNameValue(row,"NEW_COST_TAMT");
            DS_IO_MASTER.NameValue(row,"NEW_SALE_TAMT") = DS_IO_MASTER.OrgNameValue(row,"NEW_SALE_TAMT");
            return true;
        }
    }else{
        return true;
    }    
</script>

<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)>    
	if(clickSORT)
	    return;

    GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "false";

    var strSlipNo       = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_NO");          // 발주번호
    var strSlipProcStat = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_PROC_STAT");   // 전표상태
    
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        if(strSlipNo != ""){
            setEventFlagDs();  //행사구분 행사율 데이터셋 복사
            getMaster();
            getDetail();        
        }      
        if(strSlipNo != ""){
            if(inta == 0){  
                inta++;
            }else{
                setPorcCount("SELECT", DS_IO_DETAIL.CountRow);      
            }           
        }
    }
    
    var strSlipNo       = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_NO");          // 발주번호
    var strSlipProcStat = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_PROC_STAT");   // 전표상태

    if(strSlipNo == ""){
        GR_DETAIL.Editable    = true;
        enableControl(IMG_ADD, true);
        enableControl(IMG_DEL, true);
        RD_SLIP_FLAG.Enable   = true;             //전표구분
        EM_O_ETC.Enable       = true;             //비고
        LC_I_SH_GBN.Enable    = true;             //사후구분
    	
    }else if(strSlipProcStat =="00"){
        GR_DETAIL.Editable    = true;
        enableControl(IMG_ADD, true);
        enableControl(IMG_DEL, true);
        RD_SLIP_FLAG.Enable   = false;             //전표구분
        EM_O_ETC.Enable       = true;              //비고
        LC_I_SH_GBN.Enable    = true;              //사후구분
    }else{
        GR_DETAIL.Editable    = false;
        enableControl(IMG_ADD, false);
        enableControl(IMG_DEL, false);
        RD_SLIP_FLAG.Enable   = false;             //전표구분
        EM_O_ETC.Enable       = false;             //비고
        LC_I_SH_GBN.Enable    = false;             //사후구분
    }

    if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1){   //신규입력행에 대하여
//        setObject(true);    
    }else{                                                        //기존데이터에 대하여
        if( strSlipNo != "" || strSlipProcStat == "00"){          //전표상태가 발주등록(00)일 경우에만 수정가능하다.
            setObject(false);
//            EM_O_ETC.Enable  = true;
        }else{
            setObject(false);
        } 
    }
    
    EM_I_VAT_TAMT.Enable = false;
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
</script>
<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>

    var strBjDt = DS_IO_MASTER.NameValue(row,"ORD_DT");     //발주일
    var strNpDt = DS_IO_MASTER.NameValue(row,"DELI_DT");    //납품예정일
    var strMgDt = DS_IO_MASTER.NameValue(row,"MG_APP_DT");  //마진적용일
        
    var strBuyerCd = EM_O_BUYER_CD.Text;
    
    var nextDay = addDate("d", 1, strToday);
        
    if(colid == "PUMBUN_CD"){
    	/*        
        if(EM_I_PB_CD.Text == ""){
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
        return;
    }    
//    }else if(EM_I_PB_CD.Text.length == 6 && getPumbunInfo("0")){
//        DS_IO_DETAIL.ClearData();
//        LC_I_HS_GBN.Enable = true;  
//    }
 

        LC_I_HS_RATE.Enable = false;   
        LC_I_HS_GBN.Text = "";
        LC_I_HS_RATE.Text = ""; 
*/
    }
/*   
    
    if(LC_I_SH_GBN.BindColVal == '0'){      //사전전표일 경우   (아닐때는 과거 현재 미래 일자로 수정가능)
           if(colid == "ORD_DT"){
               if(strToday > strBjDt){
                   showMessage(EXCLAMATION, OK, "GAUCE-1000", "현재 이전 날짜로 입력할 수  없습니다.");
                   EM_I_BJDATE.Text = strToday; 
                   EM_I_NPYJDATE.Text = addDate("d", 1, strToday); 
                   EM_I_MAJINDATE.Text = addDate("d", 1, strToday); 
               }       
           }else if(colid == "DELI_DT"){
               if(strBjDt > strNpDt){
                   showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");
                   EM_I_NPYJDATE.Text = addDate("d", 1, strBjDt);
                   EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text
               }                
               if(strNpDt > strMgDt){
//                 showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");
                   EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text;
               }                
           }else if(colid == "MG_APP_DT"){
               if(strNpDt > strMgDt){
                   showMessage(EXCLAMATION, OK, "USER-1020", "마진적용일","납품예정일");
                   EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text 
                   if(EM_I_MAJINDATE.Text.length == 8 && EM_I_PB_CD.Text != ''){
                       LC_I_HS_GBN.Enable = true;
                       getMarginFlag(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text);         
                   }       
               }
           }
    }else{                                 //사후전표, 재고조정전표
        if(colid == "ORD_DT"){
            EM_I_NPYJDATE.Text = strBjDt; 
            EM_I_MAJINDATE.Text = strBjDt;      
        }else if(colid == "DELI_DT"){
            EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text;
            if(strBjDt > strNpDt){
                showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");
                EM_I_NPYJDATE.Text  = strBjDt;
                EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text;
            }   
        }else if(colid == "MG_APP_DT"){
            if(strNpDt > strMgDt){
                showMessage(EXCLAMATION, OK, "USER-1020", "마진적용일","납품예정일");
                EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text  
                if(EM_I_MAJINDATE.Text.length == 8 && EM_I_PB_CD.Text != ''){
                    LC_I_HS_GBN.Enable = true;
                    getMarginFlag(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text);         
                }       
            }
        }        
    }   
    
    if(colid == "MG_APP_DT"){    	
    	getMarginFlag(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text);    
        LC_I_HS_RATE.Text = "";
        LC_I_HS_RATE.Enable = false;
    }
*/


/*    
    if(colid == "EVENT_FLAG"){
    	alert("변경");
        LC_I_HS_RATE.Enable = true;
        getMarginRate();   
        
        alert(LC_I_HS_GBN.Text.length);
        if(LC_I_HS_GBN.Text.length == 0){
        	alert("1");
            LC_I_HS_RATE.Enable = false;
        }else
            alert("2");
            LC_I_HS_RATE.Enable = true;
            
    }
*/    
    if(colid == "BUYER_CD"){
       // SM, 바이어여부를 가져온다.
       strBuyerYN = getBuyerYN("DS_O_RESULT", LC_O_STR.BindColVal, EM_I_PB_CD.Text, EM_I_BJDATE.Text);

    }
    
    if(colid == "VEN_CD"){        
        roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, LC_I_STORE.BindColVal, EM_O_HRS_CD.Text);
    }
</script>
<!--  ===================DS_IO_DETAIL============================ -->
<!--  DS_IO_DETAIL 변경시 -->
<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>
	if (colid == "ORD_QTY"){
		//alert("colid : " + colid);
	    calDetail3(row);
	}
    if (colid == "NEW_SALE_PRC"){
    	//alert("colid : " + colid);
        calDetail2(row);
    } 
    if (colid == "VAT_AMT"){
    	//alert("colid : " + colid);
    	var totVatTamt = DS_IO_DETAIL.Sum(25,0,0);  // VAT 금액 합
    	var totCostTamt = DS_IO_DETAIL.Sum(16,0,0); // 원가금액 합
    	//var vatAmt = DS_IO_DETAIL.NameValue(row, "VAT_AMT")
    	//alert("vatAmt="+vatAmt);
    	//DS_IO_DETAIL.NameValue(row, "VAT_AMT") = vatAmt; 
    	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VAT_TAMT") = totVatTamt;
    	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SUP_AMT") = totVatTamt + totCostTamt;
    } 
	if(colid == "NEW_COST_PRC"){
    	// alert("colid : " + colid);
    	var str_TaxFlag  = EM_TAX_FLAG.Text;
    	var ord_qty  = 0;    // 발주수량
    	var old_cost = 0;    // 매입단가
    	var new_cost = 0;    // 매입단가
    	var vat_Amt  = 0;    // 부가세
    	var gap_cost = 0;

    	ord_qty  = DS_IO_DETAIL.NameValue(row, "ORD_QTY");         // 발주수량
    	if (DS_IO_DETAIL.NameValue(row, "OLD_COST_PRC") != undefined ) {
    		old_cost = DS_IO_DETAIL.NameValue(row, "OLD_COST_PRC");    // 매입단가
	    }
    	new_cost = DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC");    // 매입단가

    	// alert("old_cost : " + old_cost + " new_cost : " + new_cost);
    	if (old_cost != undefined){
    		
    		if (ord_qty != 0 && old_cost == 0 && new_cost == 0 ){
	    		setFocusGrid(GR_DETAIL, DS_IO_DETAIL,row,"NEW_SALE_PRC");
	            GR_DETAIL.SetColumn("NEW_SALE_PRC");
	            GR_DETAIL.Focus();
    		}
    		
	    	if (old_cost != new_cost)
	    	{
	    		//alert("old_cost=["+old_cost+"],new_cost=["+new_cost+"]");
	    		gap_cost = old_cost - new_cost;
	    		//alert("Math.abs(gap_cost)=["+Math.abs(gap_cost)+"]");
		    	if (Math.abs(gap_cost) > 10) 
		    	{ 
		    		showMessage(EXCLAMATION, OK, "USER-1000", "입력하신 매입 단가는 입력하신 단가와 10원이상 차이가 납니다.");
		    		DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC") = old_cost;
		    		//setFocusGrid(GR_DETAIL, DS_IO_DETAIL,row,"NEW_COST_PRC");
		            //GR_DETAIL.SetColumn("NEW_COST_PRC");
		            //GR_DETAIL.Focus();
		    	}else {
		    	       // 원가금액
		    	       DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC") = new_cost;
		    	       
		    	       DS_IO_DETAIL.NameValue(row, "NEW_COST_AMT") = getRoundDec(roundFlag, new_cost * ord_qty, 0);
		    	       
		    	       vat_Amt = getCalcPord("VAT_AMT", new_cost * ord_qty, "", "", str_TaxFlag, roundFlag);
		    	       DS_IO_DETAIL.NameValue(row, "VAT_AMT") = vat_Amt;      // 부가세
		    	       //setFocusGrid(GR_DETAIL, DS_IO_DETAIL,row,"NEW_COST_PRC");
			           //GR_DETAIL.SetColumn("NEW_COST_PRC");
			           //GR_DETAIL.Focus();
		    	}
	    	}
	    	
    	}
    	calDetail3(row);
    } 
    
</script>

<!-- 디테일 삭제시 컴퍼넌트 총금액-->
<script language=JavaScript for=DS_IO_DETAIL event=OnRowDeleted(row)>   
    calDetail2(row);
</script>

<!-- 디테일 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_DETAIL event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHECK1") {
        if (bCheck == 1) {
            GR_DETAIL.Redraw = false;
            for (var i = 0; i < DS_IO_DETAIL.CountRow; i++)
            {
                DS_IO_DETAIL.NameValue(i + 1, "CHECK1") = "T";
            }    
            GR_DETAIL.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_DETAIL.Redraw = false;
            for (var i = 0; i < DS_IO_DETAIL.CountRow; i++)
            {
                DS_IO_DETAIL.NameValue(i + 1, "CHECK1") = "F";
            } 
            GR_DETAIL.Redraw = true;
        }
    }
</script>

<!--  ===================GR_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>

    sortColId( eval(this.DataID), row , colid, "DS_IO_MASTER,DS_IO_DETAIL" );
/*
    if (row < 1) {
        alert(DS_LIST.RowStatus(DS_LIST.RowPosition));
        if (DS_LIST.RowStatus(DS_LIST.RowPosition) != 0) {
            showMessage(EXCLAMATION, OK, "USER-1065", "AAAAAAA");
            return;
        }
        sortColId( eval(this.DataID), row, colid);  
    }
*/  

</script>
<!--  ===================GR_DETAIL============================ -->
<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
    setObject(false);               //디테일 그리드 클릭시 우츨 입력부 비활성화
    
    EM_I_PB_CD.Enable = false;     //디테일 그리드 브랜드코드 팝업 비활성화
    enableControl(IMG_PUMBUN_CD, false);

</script>
<!-- Grid GR_DETAIL OnExit event 처리 -->
<!-- 그리드 내용 변경시 금액 및 총수량, 금액 변경  -->
<script language=JavaScript for=GR_DETAIL
	event=OnExit(row,colid,olddata)>
//var strW_Dan_AMT = parseInt(DS_IO_DETAIL.NameValue(row, "NEW_COST_PRC"));  

</script>


<!-- DETAIL 그리드 품목코드 팜업 -->
<script language=JavaScript for=GR_DETAIL event=OnPopup(row,colid,data)>
	if(colid == "PUMMOK_SRT_CD"){
    	getPbnPmkSrtPop(row, colid, '1');
	}else if (colid == "PUMMOK_CD") {
    	getPbnPmkPop(row, colid, '1');
	}
</script>

<!-- GR_DETAIL CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript" for=GR_DETAIL event=CanColumnPosChange(Row,Colid)>

    switch (Colid) {
    case "PUMMOK_SRT_CD":
    	if(DS_IO_DETAIL.NameValue(Row, "PUMMOK_SRT_CD") == "")
    		return;
    	
        if(!getPmkSrtInfo()){
            showMessage(EXCLAMATION, OK, "USER-1065", "정확한 품목 단축코드");
            clearDataSetRow(DS_IO_DETAIL);
            
            DS_IO_DETAIL.NameValue(Row, "CHECK1") = 'T';
            GR_MASTER.SetColumn("PUMMOK_SRT_CD");
            GR_DETAIL.Focus();
            return false;
            
        }else {
            getPbnPmkSrtPop2(Row);
            return true;        	
        }
        break;
        /*
    case "PUMMOK_CD":
    	if(DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD") == "")
    		return;
    	
        if(!getPummokInfo()){
            showMessage(EXCLAMATION, OK, "USER-1065", "정확한 품목코드");
            clearDataSetRow(DS_IO_DETAIL);
            
            DS_IO_DETAIL.NameValue(Row, "CHECK1") = 'T';
            GR_MASTER.SetColumn("PUMMOK_CD"); 
            GR_DETAIL.Focus();
            return false;
            
        }else {
            getPbnPmkPop2(Row);
            return true;        	
        }
        */
        /*      
        if (blnPummokChanged) {
            if(DS_IO_DETAIL.NameValue(row,"PUMMOK_CD") != "")
               showMessage(EXCLAMATION, OK, "USER-1065", "정확한 브랜드코드");
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD") = "";
            GR_DETAIL.Focus();
            blnPummokChanged = false;
            return false;
        }else{
            return true;
        }
        
      
        if(getPbnPmkPop2(Row, Colid)){
            return true;            
        }else if (!getPbnPmkPop2(Row, Colid) && DS_IO_DETAIL.NameValue(Row,"PUMMOK_CD") == ""){
            return true;
        }else {
            showMessage(EXCLAMATION, OK, "USER-1065", "정확한 품목코드");
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD") = "";
            GR_DETAIL.Focus();
            return false;
        }
        */
        //break;
    }
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
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
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
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
</script>

<!-- PC(조회)  변경시  -->
<script language=JavaScript for=LC_O_PC event=OnSelChange()>
	EM_S_PB_CD.Text  = "";
	EM_S_PB_NM.Text  = "";
</script>

<!-- 사후구분(입력)  변경시  -->
<script language=JavaScript for=LC_I_SH_GBN event=OnSelChange()>
    var strSlipNo    = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_NO");
    var aft_ord_flag = LC_I_SH_GBN.BindColVal;

    
    if(strSlipNo != ""){    //수정건이면 사후구분만 수정하고 넘어간다
    	return;
    }

    if (DS_LIST.RowStatus(DS_LIST.RowPosition) == "1") {
	    if(aft_ord_flag == "0"){                    //사전전표
	        var nextDay  = addDate("d", 1, strToday);
	        var nextDay2 = addDate("d", 2, strToday);
	        // MARIO OUTLET
	        // 일 발주 타임아웃 이면. 
	        if (!orderCloseCheck()) {
	            EM_I_BJDATE.Text      = nextDay;
	            EM_I_NPYJDATE.Text    = nextDay2;
	            EM_I_MAJINDATE.Text   = nextDay2;
	        } else {
	            EM_I_BJDATE.Text      = strToday;
	            EM_I_NPYJDATE.Text    = nextDay;
	            EM_I_MAJINDATE.Text   = nextDay;
	    	}
	
	        EM_I_BJDATE.Enable    = "true";
	        EM_I_NPYJDATE.Enable  = "true";
	        EM_I_MAJINDATE.Enable = "true";
	        setCalImgDis(true);                     //달력이미지 보임
	
	    }else{                                      //사후전표  , 재고조정 
	        EM_I_BJDATE.Text      = strToday;
	        EM_I_NPYJDATE.Text    = strToday;
	        EM_I_MAJINDATE.Text   = strToday;
	        EM_I_BJDATE.Enable    = "true";
	        EM_I_NPYJDATE.Enable  = "true";
	        EM_I_MAJINDATE.Enable = "true";
	        setCalImgDis(true);
	    }
    }
    
    if(EM_I_PB_CD.Text != ""){
        LC_I_HS_GBN.Text      = "";
        LC_I_HS_RATE.Text     = "";
        EM_O_MG_RATE.Text     = "";
        setTimeout("LC_I_HS_RATE.Enable = false", 50);
    }

</script>

<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PB_CD event=onKillFocus()>
	
	if(EM_S_PB_CD.Text != ""){
	    	searchPumbunNonPop();
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
        EM_S_VEN_NM.Text = ""        
    }
</script>

<!-- 점(입력)  변경시  -->
<script language=JavaScript for=LC_I_STORE event=OnSelChange()>  
	EM_I_PB_CD.Text      = "";
	EM_I_PB_NM.Text      = "";
	EM_O_BUYER_CD.Text   = "";
	EM_O_BUYER_NM.Text   = "";
	EM_O_HRS_CD.Text     = "";
	EM_O_HRS_NM.Text     = "";
	EM_O_GS_GBN.Text     = "";
	LC_I_HS_GBN.Text     = "";
    LC_I_HS_RATE.Text    = "";
    LC_I_HS_RATE.Text    = "";
	EM_O_MG_RATE.Text    = 0;
	RD_SLIP_FLAG.CodeValue = "A";
	LC_I_SH_GBN.BindColVal    = 0;
	LC_I_HS_GBN.Enable   = false;
	LC_I_HS_RATE.Enable  = false;
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
        EM_O_MG_RATE.Text    = 0;
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
        EM_O_MG_RATE.Text    = 0;
        LC_I_HS_GBN.Enable   = false;
        LC_I_HS_RATE.Enable  = false;
//        getPumbunInfo(); 
    }
</script>

<!-- 행사구분 변경시 행사율 변경 -->
<script language=JavaScript for=LC_I_HS_GBN event=OnSelChange()>
    getMarginRate(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text, LC_I_HS_GBN.BindColVal);
    LC_I_HS_RATE.Enable = true;
    EM_O_MG_RATE.Text = 0;
</script>

<!-- 행사율 변경시 -->
<script language=JavaScript for=LC_I_HS_RATE event=OnSelChange()>
    EM_O_MG_RATE.Text = DS_EVENT_RATE.NameValue(DS_EVENT_RATE.RowPosition, "NORM_MG_RATE");
</script>

<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_START_DT event=OnKillFocus()>    
    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_START_DT, strSyyyymmdd );
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_END_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_END_DT );
</script>

<!-- 발주일 변경시  -->
<script lanaguage=JavaScript for=EM_I_BJDATE event=OnKillFocus()>
//    checkDateTypeYMD( EM_I_BJDATE );    
    if(!this.Modified)
        return;
   
    checkDateTypeYMD(EM_I_BJDATE, strToday);

    var strBjDt = EM_I_BJDATE.Text;
    var strNpDt = EM_I_NPYJDATE.Text;
    var strMgDt = EM_I_MAJINDATE.Text;

    if(LC_I_SH_GBN.BindColVal == '0'){      //사전전표일 경우   (아닐때는 과거 현재 미래 일자로 수정가능)
        if(strToday > EM_I_BJDATE.Text){
//        	showMessage(EXCLAMATION, OK, "USER-1180", "발주일");
//            EM_I_BJDATE.Text = strToday;             
//            if(strNpDt> strBjDt){
//            	return;
//            }else{
//                EM_I_NPYJDATE.Text = addDate("d", 1, strToday); 
//                EM_I_MAJINDATE.Text = addDate("d", 1, strToday); 
            EM_I_NPYJDATE.Text = strBjDt; 
            EM_I_MAJINDATE.Text = strBjDt;
//            }            
        }else{            
//            if(strNpDt> strBjDt){
//                return;
//            }else{
	            EM_I_NPYJDATE.Text = addDate("d", 1, strBjDt); 
	            EM_I_MAJINDATE.Text = addDate("d", 1, strBjDt); 
//            }
        }
    }else{                                 //사후전표, 재고조정전표        
//        if(strNpDt> strBjDt){
//            return;
//        }else{
            EM_I_NPYJDATE.Text = strBjDt; 
            EM_I_MAJINDATE.Text = strBjDt;     
//        }
    }   

    LC_I_HS_GBN.Enable = true;
    LC_I_HS_RATE.Enable = false;
    //LC_I_HS_RATE.Enable = false;
    if (EM_I_PB_NM.Text != "")
    	getMarginFlag(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text);   
</script>

<!-- 납품예정일 변경시  -->
<script lanaguage=JavaScript for=EM_I_NPYJDATE event=OnKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;

    var strBjDt = EM_I_BJDATE.Text;
    var strNpDt = EM_I_NPYJDATE.Text;
    var strMgDt = EM_I_MAJINDATE.Text;
    
    if(LC_I_SH_GBN.BindColVal == '0'){
        checkDateTypeYMD( EM_I_NPYJDATE, addDate("d", 1, strBjDt));   
        
        if(EM_I_BJDATE.Text > EM_I_NPYJDATE.Text){
            showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");           
            EM_I_NPYJDATE.Text = addDate("d", 1, strBjDt);
//            if(EM_I_MAJINDATE.Text>=EM_I_NPYJDATE.Text){
//            	return;
//            }else{
                EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text
//            }
        }   
//        if(EM_I_MAJINDATE.Text> EM_I_NPYJDATE.Text){
//            return;
//        }else{
            EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text
//        }
    }else{
        checkDateTypeYMD( EM_I_NPYJDATE, strBjDt);     

        if(EM_I_BJDATE.Text > EM_I_NPYJDATE.Text){
            showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");
            EM_I_NPYJDATE.Text  = strBjDt;          

//            if(EM_I_MAJINDATE.Text>=EM_I_NPYJDATE.Text){
//                return;
//            }else{
                EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text;
//            }
        }      
        
//        if(EM_I_MAJINDATE.Text> EM_I_NPYJDATE.Text){
//            return;
//        }else{
            EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text
//        }
    }
/*    
    if(LC_I_SH_GBN.BindColVal == '0'){      //사전전표일 경우   (아닐때는 과거 현재 미래 일자로 수정가능)
	    if(EM_I_BJDATE.Text > EM_I_NPYJDATE.Text){
	        showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");	        
	        EM_I_NPYJDATE.Text = addDate("d", 1, strBjDt);
	        EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text
	    }                
	    if(EM_I_NPYJDATE.Text > EM_I_MAJINDATE.Text){
	        EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text;
	    }
    }else{                                 //사후전표, 재고조정전표
        EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text;
        if(EM_I_BJDATE.Text > EM_I_NPYJDATE.Text){
            showMessage(EXCLAMATION, OK, "USER-1020", "납품예정일","발주일");
            EM_I_NPYJDATE.Text  = strBjDt;
            EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text;
        }      
    }   
*/
	LC_I_HS_GBN.Enable = true;
	LC_I_HS_RATE.Enable = false;
	//LC_I_HS_RATE.Enable = false;
	getMarginFlag(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text);   
</script>

<!-- 마진적용일 변경시  -->
<script lanaguage=JavaScript for=EM_I_MAJINDATE event=OnKillFocus()>
    var strBjDt = EM_I_BJDATE.Text;
    var strNpDt = EM_I_NPYJDATE.Text;
    var strMgDt = EM_I_MAJINDATE.Text;

    checkDateTypeYMD( EM_I_MAJINDATE, strNpDt);
    
    if(LC_I_SH_GBN.BindColVal == '0'){      //사전전표일 경우   (아닐때는 과거 현재 미래 일자로 수정가능)
	    if(EM_I_NPYJDATE.Text > EM_I_MAJINDATE.Text){
//	        alert("1");
	        showMessage(EXCLAMATION, OK, "USER-1020", "마진적용일","납품예정일");
	        EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text; 
	    }
        if(EM_I_PB_CD.Text != ''){
            LC_I_HS_GBN.Index = 0;
            LC_I_HS_RATE.Text = "";
            EM_O_MG_RATE.Text = "";
            LC_I_HS_GBN.Enable = true;
            LC_I_HS_RATE.Enable = false;
            //LC_I_HS_RATE.Enable = false;
            getMarginFlag(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text);         
        }       
    }else{                                 //사후전표, 재고조정전표
	    if(EM_I_NPYJDATE.Text > EM_I_MAJINDATE.Text){
	        showMessage(EXCLAMATION, OK, "USER-1020", "마진적용일","납품예정일");
	        EM_I_MAJINDATE.Text = EM_I_NPYJDATE.Text;       
	    }
        if(EM_I_PB_CD.Text != ''){
            LC_I_HS_GBN.Enable = true;
            getMarginFlag(LC_I_STORE.BindColVal, EM_I_PB_CD.Text, EM_I_MAJINDATE.Text);         
        }  
    }   
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
<object id="DS_I_PUMMOK_SRT_INFO" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_PUMMOK_SRT_INFO" classid=<%=Util.CLSID_DATASET%>></object>
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

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top) {
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
						<th width="70">팀</th>
						<td width="110"><comment id="_NSID_"> <object
							id=LC_O_BUMUN classid=<%=Util.CLSID_LUXECOMBO%> width=100
							align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="70">파트</th>
						<td width="110"><comment id="_NSID_"> <object
							id=LC_O_TEAM classid=<%=Util.CLSID_LUXECOMBO%> width=100
							align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="70">PC</th>
						<td><comment id="_NSID_"> <object id=LC_O_PC
							classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"
							tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">기준일</th>
						<td><comment id="_NSID_"> <object id=LC_O_GJDATE
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100
							align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th class="point">조회기간</th>
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
						<th>전표상태</th>
						<td><comment id="_NSID_"> <object id=LC_O_JPST
							classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle"
							tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>브랜드</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_PB_CD classid=<%=Util.CLSID_EMEDIT%> width=88 tabindex=1
							align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							align="absmiddle" onclick="javascript:searchPumbunPop();" /> <comment
							id="_NSID_"> <object id=EM_S_PB_NM
							classid=<%=Util.CLSID_EMEDIT%> width=184 tabindex=1
							align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
						<th>협력사</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=88 tabindex=1
							align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							align="absmiddle"
							onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM);" /> <comment
							id="_NSID_"> <object id=EM_S_VEN_NM
							classid=<%=Util.CLSID_EMEDIT%> width=184 tabindex=1
							align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>전표구분</th>
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
				<td width="500">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"> <OBJECT id=GR_MASTER
							width=100% height=431 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_LIST">
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
								<th width="70" class="point">점</th>
								<td width="105"><comment id="_NSID_"> <object
									id=LC_I_STORE classid=<%=Util.CLSID_LUXECOMBO%> width=100
									align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
								<th width="90">전표번호</th>
								<td width="105"><comment id="_NSID_"> <object
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
								<th class="point">사후구분</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=LC_I_SH_GBN classid=<%=Util.CLSID_LUXECOMBO%> width=105
									align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th class="point">브랜드</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_I_PB_CD classid=<%=Util.CLSID_EMEDIT%> width=80
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
									id=IMG_PUMBUN_CD align="absmiddle"
									onclick="javascript:getPumbunInfo('0');" /> <comment
									id="_NSID_"><object id=EM_I_PB_NM
									classid=<%=Util.CLSID_EMEDIT%> width=211 tabindex=1
									align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
								<th>발주주체</th>
								<td><comment id="_NSID_"> <object id=EM_O_BALJUJC
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 value="0"
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th>협력사</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_O_HRS_CD classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								&nbsp;<comment id="_NSID_"> <object id=EM_O_HRS_NM
									classid=<%=Util.CLSID_EMEDIT%> width=210 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
								<th>과세구분</th>
								<td><comment id="_NSID_"> <object id=EM_O_GS_GBN
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th class="point">발주일</th>
								<td><comment id="_NSID_"> <object id=EM_I_BJDATE
									classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script> <img
									src="/<%=dir%>/imgs/btn/date.gif" id="IMG_BJ_DATE"
									onclick="javascript:openCal('G',EM_I_BJDATE)" align="absmiddle" />
								</td>
								<th>발주확정일</th>
								<td><comment id="_NSID_"> <object
									id=EM_I_BJHJDATE classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
								<th>바이어</th>
								<td><comment id="_NSID_"> <object
									id=EM_O_BUYER_CD classid=<%=Util.CLSID_EMEDIT%> width=45
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								<comment id="_NSID_"> <object id=EM_O_BUYER_NM
									classid=<%=Util.CLSID_EMEDIT%> width=52 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

							<tr>
								<th class="point">납품예정일</th>
								<td><comment id="_NSID_"> <object
									id=EM_I_NPYJDATE classid=<%=Util.CLSID_EMEDIT%> width=80
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_NPYJ_DATE"
									onclick="javascript:openCal('G',EM_I_NPYJDATE)"
									align="absmiddle" /></td>
								<th>검품확정일</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_O_GPWJ_DATE classid=<%=Util.CLSID_EMEDIT%> width=100
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								</td>
							</tr>

							<tr>
								<th class="point">마진적용일</th>
								<td><comment id="_NSID_"> <object
									id=EM_I_MAJINDATE classid=<%=Util.CLSID_EMEDIT%> width=80
									tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_MJ_DATE
									onclick="javascript:openCal('G',EM_I_MAJINDATE)"
									align="absmiddle" /></td>
								<th class="point">행사구분/행사율</th>
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
								<th>부가세</th>
								<td><comment id="_NSID_"> <object id=EM_I_VAT_TAMT
									classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
								<th>공급가액</th>
								<td><comment id="_NSID_"> <object
									id=EM_O_SUP classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>								
								<th>비고</th>
								<td><comment id="_NSID_"> <object
									id=EM_O_ETC classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script></td>
							</tr>

						</table>
						</td>
					</tr>
					<tr>
						<td class="right" valign="bottom"><img
							src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD" width="52"
							height="18" hspace="2" onclick="javascript:addDetailRow();" /><img
							src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL" width="52"
							height="18" onclick="javascript:delDetailRow();" /></td>
					</tr>
					<tr>
						<td class="PT05">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td><comment id="_NSID_"> <OBJECT id=GR_DETAIL
											width=100% height=176 classid=<%=Util.CLSID_GRID%>>
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
        <c>Col=SLIP_NO             Ctrl=EM_O_SLIP_NO            param=Text</c>
        <c>Col=SLIP_PROC_STAT_NM   Ctrl=EM_O_SLIP_PROC_STAT_NM  param=Text</c>        
        <c>Col=PUMBUN_CD           Ctrl=EM_I_PB_CD              param=Text</c>
        <c>Col=PUMBUN_NM           Ctrl=EM_I_PB_NM              param=Text</c>        
        <c>Col=VEN_CD              Ctrl=EM_O_HRS_CD             param=Text</c>
        <c>Col=VEN_NM              Ctrl=EM_O_HRS_NM             param=Text</c>
        <c>Col=ORD_OWN_FLAG_NM     Ctrl=EM_O_BALJUJC            param=Text</c>
        <c>Col=ORD_DT              Ctrl=EM_I_BJDATE             param=Text</c>
        <c>Col=DELI_DT             Ctrl=EM_I_NPYJDATE           param=Text</c>
        <c>Col=CHK_DT              Ctrl=EM_O_GPWJ_DATE          param=Text</c> 
        <c>Col=ORD_CONF_DT         Ctrl=EM_I_BJHJDATE           param=Text</c>
        <c>Col=MG_APP_DT           Ctrl=EM_I_MAJINDATE          param=Text</c>
        <c>Col=BUYER_CD            Ctrl=EM_O_BUYER_CD           param=Text</c>
        <c>Col=BUYER_NM            Ctrl=EM_O_BUYER_NM           param=Text</c>
        <c>Col=TAX_FLAG_NM         Ctrl=EM_O_GS_GBN             param=Text</c>
        <c>Col=TAX_FLAG            Ctrl=EM_TAX_FLAG             param=Text</c>
        <c>Col=REMARK              Ctrl=EM_O_ETC                param=Text</c>
        <c>Col=VAT_TAMT            Ctrl=EM_I_VAT_TAMT           param=Text</c>
        <c>Col=ORD_TOT_QTY         Ctrl=EM_O_SRG                param=Text</c>
        <c>Col=NEW_COST_TAMT       Ctrl=EM_O_WGG                param=Text</c>
        <c>Col=NEW_SALE_TAMT       Ctrl=EM_O_MGG                param=Text</c>     
        <c>Col=MG_RATE             Ctrl=EM_O_MG_RATE            param=Text</c>     
        <c>Col=SUP_AMT             Ctrl=EM_O_SUP            	param=Text</c>
              
        <c>Col=STR_CD              Ctrl=LC_I_STORE              param=BindColVal</c>   
        <c>Col=AFT_ORD_FLAG        Ctrl=LC_I_SH_GBN             param=BindColVal</c>
        <c>Col=EVENT_FLAG          Ctrl=LC_I_HS_GBN             param=BindColVal</c>
        <c>Col=EVENT_RATE          Ctrl=LC_I_HS_RATE            param=BindColVal</c>
        <c>Col=SLIP_FLAG           Ctrl=RD_SLIP_FLAG            param=CodeValue</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<body>
</html>

