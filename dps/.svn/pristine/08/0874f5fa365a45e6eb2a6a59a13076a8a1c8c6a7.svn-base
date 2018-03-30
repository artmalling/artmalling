<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고조사 > 재고조정확정(집계)관리
 * 작 성 일 : 2010.04.19
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk214.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 재고조정확정(집계)관리.
 * 이    력 :
 *        2010.04.19 (이재득) 작성
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
var strSkuType = "0";
var strToday = '<%=Util.getToday("yyyyMMdd")%>'

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 135;		//해당화면의 동적그리드top위치

function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');    
    //그리드 초기화
    gridCreate1(); //마스터    
    
    // EMedit에 초기화( gauce.js )    
    initEmEdit(EM_O_STK_YM,       "THISMN",    PK);     //실사년월
    initEmEdit(EM_O_PUMBUN_CD,    "CODE^6^0",  NORMAL); //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME,  "GEN^40",    READ);   //브랜드명    
    
    
    
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회) 
    initComboStyle(LC_O_DEPT_CD,DS_O_DEPT_CD, "CODE^0^30,NAME^0^110", 1, PK);  //팀    
    initComboStyle(LC_O_TEAM_CD,DS_O_TEAM_CD, "CODE^0^30,NAME^0^110", 1, PK);  //파트
    initComboStyle(LC_O_PC_CD,DS_O_PC_CD, "CODE^0^30,NAME^0^110", 1, PK);  //PC    
    
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_DEPT_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_TEAM_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_I_COST_CAL_WAY", "D", "P039", "N");    //재고평가구분
    getEtcCode("DS_I_COLOR_CD", "D", "P062", "N");        //칼라  
    getEtcCode("DS_I_SIZE_CD", "D", "P026", "N");         //사이즈
    getEtcCode("DS_I_SALE_UNIT_CD", "D", "P013", "N");    //판매단위
    getEtcCode("DS_I_CMP_SPEC_UNIT", "D", "P013", "N");   //구성규격단위

    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N");    
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    var strUserId = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
    LC_O_STR_CD.Focus();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pstk214","DS_IO_MASTER" );
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}       name="NO"               width=30     align=center    edit=none</FC>' 
    	             + '<FC>id=CHECK1         name="확정"             width=40    align=center   HeadCheckShow=false EditStyle=CheckBox</FC>'
    	             + '<FC>id=FLAG           name="구분"            width=120    align=center  edit=none  show="false"</FC>' 
                     + '<FC>id=STR_CD         name="점코드"            width=120    align=center  edit=none  show="false"</FC>' 
                     + '<FC>id=DEPT_CD        name="팀코드"          width=120    align=center  edit=none  show="false"</FC>'   
                     + '<FC>id=TEAM_CD        name="파트코드"            width=120    align=center  edit=none  show="false"</FC>'                     
                     + '<FC>id=PC_CD          name="PC코드"            width=70    align=center   edit=none  show="false"</FC>'                     
                     + '<FC>id=PUMBUN_CD      name="브랜드코드"          width=80    align=center  edit=none</FC>'
                     + '<FC>id=PUMBUN_NAME    name="브랜드명"            width=130    align=left    edit=none</FC>'
                     + '<FC>id=CONF_DT        name="*확정일자"          width=100    align=center  EditStyle=Popup  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CONF_ID        name="확정자ID"           width=80    align=left    show="false"</FC>' 
                     + '<FC>id=CONF_NAME      name="확정자"            width=80    align=left    EditStyle=PopupFix</FC>' 
                     + '<FG>                  name="장부재고"'
                     + '<FC>id=STK_QTY        name="수량"              width=70    align=right    edit=none </FC>'
                     + '<FC>id=STK_AMT        name="금액"              width=110    align=right    edit=none </FC>'
                     + '</FG>' 
                     + '<FG>                  name="실사재고"'
                     + '<FC>id=NORM_QTY       name="정상수량"           width=70    align=right    edit=none </FC>'
                     + '<FC>id=NORM_AMT       name="정상금액"           width=90    align=right    edit=none </FC>'
                     + '<FC>id=INFRR_QTY      name="불량수량"           width=70    align=right    edit=none </FC>'
                     + '<FC>id=INFRR_AMT      name="불량금액"           width=90    align=right    edit=none </FC>'
                     + '<FC>id=SRVY_QTY       name="합계수량"           width=70    align=right    edit=none </FC>'
                     + '<FC>id=SRVY_AMT       name="합계금액"           width=90    align=right    edit=none </FC>'
                     + '</FG>' 
                     + '<FG>                  name="매출"'
                     + '<FC>id=SALE_QTY       name="수량"               width=70    align=right    edit=none </FC>'
                     + '<FC>id=SALE_AMT       name="금액"               width=110    align=right    edit=none </FC>'
                     + '</FG>' 
                     + '<FG>                  name="차이(장부-실사)"'
                     + '<FC>id=LOSS_QTY       name="수량"               width=70    align=right    edit=none </FC>'
                     + '<FC>id=LOSS_AMT       name="금액"               width=110    align=right    edit=none </FC>'
                     + '</FG>' 
                     + '<FC>id=LOSS_RATE      name="LOSS율"             width=70    align=right    edit=none </FC>'
                     + '<FC>id=APP_LOSS_RATE  name="인정LOSS율"         width=70    align=right    edit=none </FC>'
                     + '<FC>id=LOSS_ADD_AMT   name="인정LOSS;초과금액"   width=90    align=right    edit=none </FC>'
                     + '<FC>id=STK_YM         name="실사년월"            width=70    align=right    edit=none  show="false"</FC>'
                     + '<FC>id=SRVY_DT        name="재고실사일"          width=70    align=right    edit=none  show="false"</FC>'
                     + '<FC>id=TODAY_DT       name="SYSTEM날짜"          width=70    align=right    edit=none  show="false"</FC>';  
                     
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
 * 작 성 일 : 2010.04.12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
     
    //저장되지 않은 내용이 있을경우 경고
    if (DS_IO_MASTER.IsUpdated ) {
        ret = showMessage(QUESTION , YESNO, "USER-1059");
        if (ret != "1") {
            return;
        } 
    }   
     
    if(!checkValidation()){
        return;
    }
     
    searchMaster();         
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.12
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	 
 }
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
    
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.12
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {
    
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
     
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.12
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
	 /*
	 var delRow = 0;
	 for( var i=1; i<=DS_IO_MASTER.CountRow; i++){
		 
        if( DS_IO_MASTER.NameValue(i,"CHECK1")=='T'){
            DS_IO_MASTER.RowMark(i) = 1;
            delRow++;
        }else{
            DS_IO_MASTER.RowMark(i) = 0;
        }
    }
    
    if( delRow < 1){
        DS_IO_MASTER.ClearAllMark();
        showMessage(INFORMATION, OK, "USER-1090");
        if(DS_IO_MASTER.CountRow < 1)
            EM_O_PUMBUN_CD.Focus();
        else
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"CHECK1");
        
        return;
    }
    
    */
    // 확정할 데이터 없는 경우
    if ( !DS_IO_MASTER.IsUpdated ){
        //확정할 데이터를 선택하세요
        showMessage(INFORMATION, OK, "USER-1090");
        if( DS_IO_MASTER.CountRow < 1){            
            return;
        }           
        GD_MASTER.Focus();
        return;
    }
    
    //DS_IO_MASTER.DeleteMarked();
    for( var i=1; i<=DS_IO_MASTER.CountRow; i++){
    	var strConfDt = DS_IO_MASTER.NameValue(i, "CONF_DT");    	
        var strCheck = DS_IO_MASTER.NameValue(i, "CHECK1"); 
        var strTodayDt = DS_IO_MASTER.NameValue(i, "TODAY_DT");
        var strSrvyDt = DS_IO_MASTER.NameValue(i, "SRVY_DT");
        
        if (strConfDt == "" && strCheck == "T"){
            showMessage(EXCLAMATION, Ok,  "USER-1003", "확정일자");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"CONF_DT");
            return;
        }else if(strCheck == "F" && DS_IO_MASTER.IsUpdated && strConfDt != ""){
        	showMessage(EXCLAMATION, Ok,  "GAUCE-1000", "확정일자가 입력되어 있어 확정취소 할수 없습니다.");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"CONF_DT");
            return;
        }
        if(strSrvyDt > strTodayDt){
        	showMessage(EXCLAMATION, Ok,  "GAUCE-1000", "재고조사 후 확정처리 가능 합니다.");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"CHECK1");
            return;
        }
        
        if(strConfDt < strSrvyDt && strCheck == "T"){
            showMessage(EXCLAMATION, Ok,  "USER-1008", "확정일자", "실사재고일자");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"CHECK1");
            return;
        }
    }    
    
    var strStkDt = DS_O_SRVY_DT.NameValue(1, "SRVY_DT");
    
    if( getCloseCheck('DS_CLOSECHECK','',strToday,'PSTK','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        LC_O_STR_CD.Focus();
        return;
    }
    
    if( showMessage(QUESTION, YESNO, "USER-1024") != 1 ){
    	GD_MASTER.Focus();
        return;
    }    
        
    var parameters = "&strStkDt="+encodeURIComponent(strStkDt); 
    
    TR_MAIN.Action="/dps/pstk214.pt?goTo=conf"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * searchMaster
  * 작 성 자 : 
  * 작 성 일 : 2010-03-04
  * 개    요 : 마스터을 조회한다.
  * return값 : void
 **/
 function searchMaster() {
     
     DS_IO_MASTER.ClearData();
     
     searchSrvyDt();
     
     var strSrvyDt     = DS_O_SRVY_DT.NameValue(1, "SRVY_DT");
     var strStrCd      = LC_O_STR_CD.BindColVal;    
     var strStkYm      = EM_O_STK_YM.Text;
     var strDeptCd     = LC_O_DEPT_CD.BindColVal;
     var strTeamCd     = LC_O_TEAM_CD.BindColVal;
     var strPcCd       = LC_O_PC_CD.BindColVal;
     var strStkYyyy    = EM_O_STK_YM.Text.substring(0, 4);
     
     var strPumbunCd   = EM_O_PUMBUN_CD.Text;
        
     var goTo       = "searchMaster" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                     +"&strStkYm="+encodeURIComponent(strStkYm)                
                     +"&strDeptCd="+encodeURIComponent(strDeptCd)
                     +"&strTeamCd="+encodeURIComponent(strTeamCd)
                     +"&strPcCd="+encodeURIComponent(strPcCd)                      
                     +"&strPumbunCd="+encodeURIComponent(strPumbunCd)
                     +"&strSrvyDt="+encodeURIComponent(strSrvyDt)
                     +"&strStkYyyy="+encodeURIComponent(strStkYyyy);   
        
     TR_MAIN.Action="/dps/pstk214.pt?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
     TR_MAIN.Post();
        
     //조회후 결과표시
     setPorcCount("SELECT", GD_MASTER);
     
     
 }
 
 /**
  * searchSrvyDt
  * 작 성 자 : 
  * 작 성 일 : 2010-03-04
  * 개    요 : 마스터을 조회한다.
  * return값 : void
 **/
 function searchSrvyDt() {
     
	 DS_O_SRVY_DT.ClearData();
        
     var strStrCd      = LC_O_STR_CD.BindColVal;    
     var strStkYm      = EM_O_STK_YM.Text;
     
     var goTo       = "searchSrvyDt" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                     +"&strStkYm="+encodeURIComponent(strStkYm);   
        
     TR_MAIN.Action="/dps/pstk214.pt?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_O_SRVY_DT=DS_O_SRVY_DT)"; //조회는 O
     TR_MAIN.Post();
 }
 
 /**
  * checkValidation
  * 작 성 자 : 
  * 작 성 일 : 2010-04-17
  * 개    요 : checkValidation.
  * return값 : void
 **/
 function checkValidation(){
     if( LC_O_STR_CD.BindColVal == "" ){
         showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "점");            
         LC_O_STR_CD.Focus();
         return false;
     }else if( LC_O_DEPT_CD.BindColVal == "" || LC_O_DEPT_CD.BindColVal == "%"){
         showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "팀");            
         LC_O_DEPT_CD.Focus();
         return false;
     }else if( LC_O_TEAM_CD.BindColVal == "" || LC_O_TEAM_CD.BindColVal == "%"){
         showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "파트");            
         LC_O_TEAM_CD.Focus();
         return false;
     }else if( LC_O_PC_CD.BindColVal == "" || LC_O_PC_CD.BindColVal == "%"){
         showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "PC");            
         LC_O_PC_CD.Focus();
         return false;
     }else if( EM_O_STK_YM.Text == "" ){
         showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "실사년월");            
         EM_O_STK_YM.Focus();
         return false;
     }
     return true;
 }
 
 /**
  * stkQtySumAtm()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.03.18
  * 개    요 : LOSS 수량/금액 게산을 한다.
  * return값 : void
  */
 function stkQtySumAtm(){
     for( var i = 1 ; i <= DS_IO_MASTER.CountRow; i++){      
         var stkAmt     = DS_IO_MASTER.NameValue(i, "BASE_SALE_AMT");    //장부재고금액        
         var stkQty     = DS_IO_MASTER.NameValue(i, "STK_QTY");         //장부재고수량
         var normAmt    = DS_IO_MASTER.NameValue(i, "NORM_AMT");         //정상금액        
         var normQty    = DS_IO_MASTER.NameValue(i, "NORM_QTY");         //정상수량
         var infrrAmt   = DS_IO_MASTER.NameValue(i, "INFRR_AMT");        //불량금액        
         var infrrQty   = DS_IO_MASTER.NameValue(i, "INFRR_QTY");        //불량수량
         var srvyAmt    = DS_IO_MASTER.NameValue(i, "SRVY_AMT");         //합계금액        
         var srvyQty    = DS_IO_MASTER.NameValue(i, "SRVY_QTY");         //합계수량
         var lossQty    = DS_IO_MASTER.NameValue(i, "LOSS_QTY");         //LOSS수량
         
         DS_IO_MASTER.NameValue(i, "SRVY_AMT")      = normAmt + infrrAmt;         
         DS_IO_MASTER.NameValue(i, "LOSS_QTY")      = stkQty - srvyQty;  //장부재고수량 - 합계수량
         DS_IO_MASTER.NameValue(i, "LOSS_SALE_AMT") = stkQty - srvyQty;  //LOSS수량*단가
         DS_IO_MASTER.NameValue(i, "LOSS_RATE")     = stkQty - srvyQty;  //LOSS율
         DS_IO_MASTER.NameValue(i, "APP_LOSS_RATE") = stkAmt - srvyAmt;  //인정Loss율
     }
 } 
 
/**
  * setPumbunCdCombo()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.04.12
  * 개    요 : 브랜드POPUP를 조회한다.
  * return값 : void
  */
 function setPumbunCdSkuType(evnflag){
      
     var strStrCd  = LC_O_STR_CD.BindColVal; 
     var strDeptCd  = LC_O_DEPT_CD.BindColVal;
     var strTeamCd = LC_O_TEAM_CD.BindColVal;  
     var strPcCd  = LC_O_PC_CD.BindColVal;
     
     
     var strOrgCd = strStrCd+strDeptCd+strTeamCd+strPcCd+"00"; 
     var codeObj = EM_O_PUMBUN_CD;
     var nameObj = EM_O_PUMBUN_NAME;
      
     if(codeObj.Text == "" && evnflag != "POP" ){
    	 nameObj.Text = "";
         return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = strPbnPop(codeObj,nameObj,'Y', '',strStrCd, strOrgCd,'','','','','','','','','','');
          
     }else if( evnflag == "NAME" ){
         result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y", '1','',strStrCd, strOrgCd,'','','','','','','','','','');

     }

     if( result != null ){           
         strSkuType = result.get("SKU_TYPE");        
     }
     EM_O_PUMBUN_CD.Focus();
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

<script language=JavaScript for=TR_SUB event=onSuccess>
    for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER
    event=OnDataError(row,colid)>
var colName = GD_MASTER.GetHdrDispName(-3, colid);
if( this.ErrorCode == "50018" ) {
    showMessage(STOPSIGN, OK, "GAUCE-1005", colName);
} else if ( this.ErrorCode == "50019") {
    showMessage(STOPSIGN, OK, "GAUCE-1007", row);
} else {
    showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
}
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 적용기준일 -->
<script language=JavaScript for=EM_O_STK_YM event=onKillFocus()>
    if(!checkDateTypeYM(this)){
        return;
    }else{
        //getPbnStk();
    }
</script>

<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    if (!checkValidation()){
        return false;
    }
    switch (colid) {
    case "PUMBUN_CD" :
    	getPumbunPop(row , colid , '1'); 
    	var strPumbunCd  = DS_IO_MASTER.NameValue(row,"PUMBUN_CD");
    	if (strPumbunCd == "")
    		return false;
        break;
    case "PUMMOK_CD" :    	           
    	getPummokPop(row , colid , '1');                  
        break;
    } 
    
</script>
<script language=JavaScript for=GD_MASTER event=CanColumnPosChange(row,colid)>
    if (!checkValidation()){
        return false;
    }    
    if(row < 1 )
        return true;
    switch (colid) {
    case "PUMBUN_CD" :    	
        getPumbunPop(row , colid , ''); 
        var strPumbunCd  = DS_IO_MASTER.NameValue(row,"PUMBUN_CD");
        if (strPumbunCd == "")
            return false;
        break;
    case "PUMMOK_CD" :    	
        getPummokPop(row , colid , '');                
        break;
    }    
</script>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
    
    DS_O_DEPT_CD.ClearData();
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD, "%");
        return;     
    }
    
    getDept("DS_O_DEPT_CD", "Y", LC_O_STR_CD.BindColVal, "N");
    if(DS_O_DEPT_CD.CountRow < 1){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);       
    }
    LC_O_DEPT_CD.Index = 0;
    
    if (EM_O_STK_YM.Text != "" && EM_O_STK_YM.Text.length == 6){
        //getPbnStk();
    }
</script>

<script language=JavaScript for=LC_O_DEPT_CD event=OnSelChange>
    
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);
        setComboData(LC_O_TEAM_CD, "%");
        return;     
    }
    
    getTeam("DS_O_TEAM_CD", "Y", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, "N");

    if(DS_O_TEAM_CD.CountRow < 1){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);       
    }
    LC_O_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_TEAM_CD event=OnSelChange>
    
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_PC_CD, "%", "전체", 1);
        setComboData(LC_O_PC_CD, "%");
        return;     
    }
    getPc("DS_O_PC_CD", "Y", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, LC_O_TEAM_CD.BindColVal, "N");

    if(DS_O_PC_CD.CountRow < 1){
        insComboData(LC_O_PC_CD, "%", "전체", 1);       
    }
    LC_O_PC_CD.Index = 0;
</script>

<!-- 브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setPumbunCdSkuType("NAME");
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
    if(row < 1)
        return true;
    var strUserId = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
    var strUserNm = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
    switch(colid){
    case "CONF_DT":      	
    	if (DS_IO_MASTER.NameValue(row, "CONF_DT") == ""){ 
            DS_IO_MASTER.NameValue(row, "CONF_ID") = "";
            DS_IO_MASTER.NameValue(row, "CONF_NAME") = "";
            return true;  
        }else{
            DS_IO_MASTER.NameValue(row, "CONF_ID") = strUserId;
            DS_IO_MASTER.NameValue(row, "CONF_NAME") = strUserNm;
            return true; 
        }   
        if(!checkDateTypeYMD(GD_MASTER,colid,''))           
            return false;
        break;
    case "CHECK1":        
        if( DS_IO_MASTER.NameValue(row,colid) =="T"){            
            DS_IO_MASTER.NameValue(row,"CONF_DT") = getTodayFormat("YYYYMMDD");            
        }else
        	DS_IO_MASTER.NameValue(row,"CONF_DT") = "";        
    /*
    case "CONF_ID":
    	
        if (DS_IO_MASTER.NameValue(row, "CONF_ID") == strUserId){ 
            DS_IO_MASTER.NameValue(row, "CONF_ID") = strUserId;
            return true;  
        }else{
            DS_IO_MASTER.NameValue(row, "CONF_ID") = DS_IO_MASTER.NameValue(row, "CONF_ID");
            return true; 
        }    
        
        break;
        */    
    }
</script>

<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    switch (colid) {
    case "CONF_DT":
        openCal(GD_MASTER, row, colid, "G");   //그리드 달력    
        break;
    case "CONF_NAME":
        var rtnVal = commonPopToGrid('사원','SEL_USR_MST_TEST',DS_IO_MASTER.NameValue(row,"CONF_ID"));
        if( rtnVal.size() > 1){
        	eval(this.DataID).NameValue(row,"CONF_ID") = rtnVal.get("CODE_CD");
            eval(this.DataID).NameValue(row,colid) = rtnVal.get("CODE_NM");
            return;
        }
        if( DS_IO_MASTER.NameValue(row, colid) == ""){
            DS_IO_MASTER.NameValue(row,"CONF_ID")   = "";
        }
        break;
    } 

</script>

<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++)         
            DS_IO_MASTER.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for (var i=1; i<=DS_IO_MASTER.CountRow; i++) DS_IO_MASTER.NameString(i, colid) = 'F';
    }
    this.ReDraw = "true";       
</script>

<!-- Grid Detail oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PUMBUN_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SRVY_DT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SKU_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DEPT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_TEAM_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PC_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CORNER_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_MARGIN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COST_CAL_WAY" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COLOR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SIZE_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SALE_UNIT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CMP_SPEC_UNIT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_NAME" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transacti
on  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CLOSECHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

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
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th class="point" width="70">점</th>
            <td width="165">
                 <comment id="_NSID_">
                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                    </object>
                </comment><script>_ws_(_NSID_);</script>
            </td>
            <th class="point" width="70">팀</th>
            <td width="165"><comment id="_NSID_"> <object id=LC_O_DEPT_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th class="point" width="70">파트</th>
            <td><comment id="_NSID_"> <object id=LC_O_TEAM_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=195 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td> 
          </tr>
          <tr>
            <th class="point" width="70">PC</th>
            <td><comment id="_NSID_"> <object id=LC_O_PC_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>            
            <th class="point" width="80">실사년월</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_STK_YM classid=<%=Util.CLSID_EMEDIT%>  width=140 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('M',EM_O_STK_YM)" align="absmiddle" /></td>
            <th width="70">브랜드</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=55 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPumbunCdSkuType('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
            </td>            
            </tr>                        
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>  
  <tr>
    <td class="dot"></td>
  </tr>
    <tr>
        <td class="PT05">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"><object id=GD_MASTER
                    width="100%" height=475 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_MASTER">
                </object></comment><script>_ws_(_NSID_);</script></td>
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
<object id=BO_COND classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_IO_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='            
            <c></c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

