<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> 실사재고등록(비단품)
 * 작 성 일 : 2010.04.13
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk207.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 실사재고등록(비단품).
 * 이    력 :
 *        2010.04.13 (이재득) 작성
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
var top = 205;		//해당화면의 동적그리드top위치

function doInit(){
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>'); 
    DS_IO_EXCEL.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_O_SKU.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터    
    gridCreate2(); //엑셀용
    // EMedit에 초기화( gauce.js )    
    initEmEdit(EM_O_STK_YM,       "THISMN",    PK);     //실사년월
    initEmEdit(EM_O_PUMBUN_CD,    "CODE^6^0",  NORMAL);     //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME,  "GEN^40",    READ);   //브랜드명    
    initEmEdit(EM_O_STK_DT,       "YYYY/MM/DD",READ);   //재고조사일
    initEmEdit(EM_O_STK_FLAG,     "GEN^10",    READ);   //재고실사구분
    initEmEdit(EM_O_STATE,        "GEN^10"   , READ);   //상태
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회) 
    initComboStyle(LC_O_DEPT_CD,DS_O_DEPT_CD, "CODE^0^30,NAME^0^110", 1, PK);  //팀    
    initComboStyle(LC_O_TEAM_CD,DS_O_TEAM_CD, "CODE^0^30,NAME^0^110", 1, PK);  //파트
    initComboStyle(LC_O_PC_CD,DS_O_PC_CD, "CODE^0^30,NAME^0^110", 1, PK);  //PC
    initComboStyle(LC_O_CORNER_CD,DS_O_CORNER_CD, "CODE^0^30,NAME^0^110", 1, NORMAL);  //PC 
    
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
    
    LC_O_STR_CD.Focus();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pstk207","DS_IO_MASTER" );
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"              width=30     align=center  sumtext=""   edit=none</FC>'
    	             + '<FC>id=CHECK1          name="선택"             width=45    align=center  sumtext=""  EditStyle=CheckBox  HeadCheckShow="true"  edit={IF(CLOSE_DT="", "true", "false")}</FC>'
                     + '<FC>id=PUMBUN_CD       name="*브랜드코드"         width=75    align=center sumtext=""  edit={IF(FLAG="","true","false")}  EditStyle=Popup  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=PUMBUN_NAME     name="브랜드명"           width=120    align=left    sumtext=""  edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>' 
                     + '<FC>id=PUMMOK_CD       name="*품목코드"         width=85    align=center   EditStyle=Popup  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=PUMMOK_NAME     name="품목명"           width=90    align=left    sumtext=""  edit=none</FC>' 
                     + '<FG> name="마진코드" '
                     /*
                     + '<FC>id=EVENT_FLAG      name="*행사구분"        width=60    align=center   sumtext=""  EditStyle=Lookup    Data="DS_IO_FLAG:EVENT_FLAG:EVENT_FLAG"  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=EVENT_RATE      name="*행사율"           width=50    align=center  sumtext=""  EditStyle=Lookup    Data="DS_IO_RATE:EVENT_RATE:EVENT_RATE"  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=MG_RATE         name="*마진율"           width=50    align=center  sumtext=""  EditStyle=Lookup    Data="DS_IO_MG:REDU_RATE:REDU_RATE"  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     */
                     + '<FC>id=EVENT_FLAG      name="*행사구분"        width=60    align=center   sumtext=""   edit=Numeric BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=EVENT_RATE      name="*행사율"           width=50    align=center  sumtext=""   edit=Numeric BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=MG_RATE         name="*마진율"           width=50    align=center  sumtext=""   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     
                     + '</FG> '
                     
                     /*
                     + '<G> name="장부재고" '
                     + '<C>id=STK_QTY         name="수량"            width=70    align=right  sumtext=@sum  edit=none  BgColor={if(ERROR_CHECK = "","white","orange") }</C>'
                     + '<C>id=STK_AMT         name="금액"           width=90    align=right   sumtext=@sum edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</C>'
                     + '</G> '                                       
                     */
                     + '<G> name="실사재고" '
                     + '<C>id=SRVY_QTY        name="수량"            width=70    align=right  sumtext=@sum  edit=Numeric   BgColor={if(ERROR_CHECK = "","white","orange") }</C>'
                     + '<C>id=SRVY_AMT        name="금액"            width=110    align=right  sumtext=@sum  edit=Numeric   BgColor={if(ERROR_CHECK = "","white","orange") }</C>'
                     + '</G> '                                        
                     + '<C>id=STR_CD          name="점"              width=50    align=left  edit=none  show="false"  BgColor={if(ERROR_CHECK = "","white","orange") }</C>'
                     + '<C>id=STK_YM          name="실사년월"        width=50    align=left  edit=none  show="false"  BgColor={if(ERROR_CHECK = "","white","orange") }</C>'
                     + '<C>id=TAX_FLAG        name="과세구분"        width=50    align=left  edit=none  show="false"  BgColor={if(ERROR_CHECK = "","white","orange") }</C>'
                     + '<C>id=SRVY_COST_AMT   name="단가"            width=50    align=left  edit=none  show="false"  BgColor={if(ERROR_CHECK = "","white","orange") }</C>'
                     + '<C>id=SRVY_COST_AMT   name="단가"            width=50    align=left  edit=none  show="false"  BgColor={if(ERROR_CHECK = "","white","orange") }</C>'
                     + '<C>id=FLAG            name="EDIT구분자"       width=50    align=left  edit=none  show="false"   BgColor={if(ERROR_CHECK = "","white","orange") }</C>'
                     + '<C>id=ERROR_CHECK     name="에러체크"        width=50    align=left  edit=none  show="false"   BgColor={if(ERROR_CHECK = "","white","orange") }</C>'
                     + '<C>id=CLOSE_DT        name="확정일자"        width=50    align=left  edit=none  show="false"   BgColor={if(ERROR_CHECK = "","white","orange") }</C>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    GD_MASTER.ViewSummary = "1";     
    GD_MASTER.ColumnProp("PUMMOK_CD", "sumtext")        = "합계";
}

function gridCreate2(){
    var hdrProperies = '<FC>id=CHECK1          name="선택"             width=45    align=center EditStyle=CheckBox  HeadCheckShow="true"  edit={IF(CLOSE_DT="", "true", "false")}</FC>'
    	             + '<FC>id=PUMBUN_CD       name="*브랜드코드"        width=120    align=center edit={IF(FLAG="","true","false")}  EditStyle=Popup</FC>'
                     + '<FC>id=PUMBUN_NAME     name="브랜드명"           width=130    align=left  edit=none</FC>' 
                     + '<FC>id=PUMMOK_CD       name="*품목코드"        width=120    align=center   EditStyle=Popup</FC>'
                     + '<FC>id=PUMMOK_NAME     name="품목명"           width=130    align=left  edit=none</FC>' 
                     + '<FG> name="마진코드" '
                     + '<FC>id=EVENT_FLAG      name="*행사구분"        width=70    align=center    edit=none</FC>'
                     + '<FC>id=EVENT_RATE      name="*행사율"          width=70    align=center    edit=none</FC>'
                     + '<FC>id=MG_RATE         name="*마진율"          width=70    align=center    edit=none</FC>'
                     + '</FG> '
                     /*
                     + '<FG> name="장부재고" '
                     + '<FC>id=STK_QTY         name="수량"            width=70    align=left   edit=none</FC>'
                     + '<FC>id=STK_AMT         name="금액"            width=90    align=left  edit=none </FC>'
                     + '</FG> '                                       
                     */
                     + '<FG> name="실사재고" '
                     + '<FC>id=SRVY_QTY        name="수량"            width=70    align=right    edit=Numeric </FC>'
                     + '<FC>id=SRVY_AMT        name="금액"            width=110    align=right    edit=Numeric </FC>'
                     + '</FG> ' 
                     + '<FC>id=STR_CD          name="점"              width=50    align=left  edit=none  </FC>'
                     + '<FC>id=STK_YM          name="실사년월"        width=60    align=left  edit=none </FC>'
                     + '<FC>id=TAX_FLAG        name="과세구분"        width=50    align=left  edit=none</FC>'
                     + '<FC>id=SRVY_COST_AMT   name="단가"              width=50    align=left  edit=none  show="false"</FC>'
                     + '<FC>id=SRVY_COST_AMT   name="단가"              width=50    align=left  edit=none  show="false"</FC>';
                     
    initGridStyle(GD_EXCEL, "common", hdrProperies, true);
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
	 
	 var srvyEDt  = DS_O_PBNSTK.NameValue(1, "SRVY_E_DT");
     var strToDay = DS_O_PBNSTK.NameValue(1, "TODAY_DT");
     if(srvyEDt < strToDay && srvyEDt != "") {
         showMessage(INFORMATION , OK, "GAUCE-1000" , "실사재고기간에만 삭제 가능합니다.");
         return; 
     } 
	 var delRow = 0;
	 var delNewRow = 0;
	 var noNewData = 0;
	 var newInsData = '';
	 for( var i=1; i<=DS_IO_MASTER.CountRow; i++){
	     if( DS_IO_MASTER.NameValue(i,"CHECK1")=='T'){           
	         DS_IO_MASTER.RowMark(i) = 1;          
	         if(DS_IO_MASTER.RowStatus(i)!='1')
	             noNewData++;
	            
	         delRow++;
	     }else{
	         if(DS_IO_MASTER.RowStatus(i)=='1')
	             newInsData += DS_IO_MASTER.ExportData(i,1,true);
	         DS_IO_MASTER.RowMark(i) = 0;
	     }
	 }
	 if( delRow < 1){
	     DS_IO_MASTER.ClearAllMark();
	     showMessage(INFORMATION, OK, "USER-1019");
	     if(DS_IO_MASTER.CountRow < 1)
	         EM_O_PUMBUN_CD.Focus();
	     else
	         setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"CHECK1");	        
	     return;
	 }
	 
	//선택한 항목을 삭제하겠습니까?
	    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
	        GD_MASTER.Focus();
	        return;
	    }
	 
	 DS_IO_MASTER.DeleteMarked();
	    
	 if(noNewData <1 )
	     return;
	 var strUserId = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
	 
	 var parameters = "&strUserId="+encodeURIComponent(strUserId); 
	 
	 TR_MAIN.Action="/dps/pstk207.pt?goTo=delete"+parameters;
	 TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	 TR_MAIN.Post();
	    
	 btn_Search();
	    
	 if( newInsData != '')
	     DS_IO_MASTER.ImportData(newInsData);

	 GD_MASTER.ColumnProp('CHECK1','HeadCheck') = false;
	}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.12
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {
	 var srvyEDt  = DS_O_PBNSTK.NameValue(1, "SRVY_E_DT");
     var strToDay = DS_O_PBNSTK.NameValue(1, "TODAY_DT");
     if(srvyEDt < strToDay && srvyEDt != "") {
         showMessage(INFORMATION , OK, "GAUCE-1000" , "실사재고기간에만 저장/수정이 가능합니다.");
         return; 
     }
	 
	// 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION , OK, "USER-1028");
        return;
    }    
        
    if (!checkSaveValidation()){
    	return;
    }  
    
    if (!errorChk()){
    	showMessage(INFORMATION , OK, "USER-1000","마진 정보가 잘못되었습니다.");
    	return;
    }
    
    if( getCloseCheck('DS_CLOSECHECK','',strToday,'PSTK','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        LC_O_STR_CD.Focus();
        return;
    }    
    
    if(DS_IO_MASTER.NameValue(1, "CLOSE_DT") != ""){
        showMessage(EXCLAMATION , Ok,  "USER-1068", "확정/", "");
        return;
    }

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION , YESNO, "USER-1010") != 1 )
        return;
    
    //중복된 데이터 체크 
    //var retChk  = checkDupKey(DS_IO_MASTER, "STR_CD||STK_YM");
    
    //if (retChk != 0) {
    //    showMessage(Information, OK, "USER-1044",retChk);
    //    setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"STR_CD");
    //    return;
    //}
    for( var i=1; i<=DS_IO_MASTER.CountRow; i++){
    	var strStrCd = LC_O_STR_CD.BindColVal;
        var strStkYm = EM_O_STK_YM.Text;
        var strPumbunCd     = DS_IO_MASTER.NameValue(i, "PUMBUN_CD");
        var strOrgPummokCd  = DS_IO_MASTER.OrgNameValue(i, "PUMMOK_CD");
        var strOrgEventFlag = DS_IO_MASTER.OrgNameValue(i, "EVENT_FLAG");
        var strOrgEventRate = DS_IO_MASTER.OrgNameValue(i, "EVENT_RATE");
        var strOrgMgRate    = DS_IO_MASTER.OrgNameValue(i, "MG_RATE");
        
        var strTaxFlag      = DS_IO_MASTER.NameValue(i, "TAX_FLAG");
        var strSrvyQty      = DS_IO_MASTER.NameValue(i, "SRVY_QTY");
        var strSrvyAmt      = DS_IO_MASTER.NameValue(i, "SRVY_AMT");
        var strOrgSrvyQty   = DS_IO_MASTER.OrgNameValue(i, "SRVY_QTY");
        var strOrgSrvyAmt   = DS_IO_MASTER.OrgNameValue(i, "SRVY_AMT");
        var strFlag         = DS_IO_MASTER.NameValue(i, "FLAG");
        
        if(strFlag == "" && strSrvyQty != 0){        	
        	DS_IO_MASTER.NameValue(i, "SRVY_SALE_PRC") = getRoundDec("2",strSrvyAmt / strSrvyQty);
            if (strTaxFlag == "1"){         
                DS_IO_MASTER.NameValue(i, "SRVY_COST_AMT") = getRoundDec("2",(strSrvyAmt / 1.1) * ((100 - strOrgMgRate)/100));
            }else{
                DS_IO_MASTER.NameValue(i, "SRVY_COST_AMT") = getRoundDec("2",strSrvyAmt * ((100 - strOrgMgRate)/100));
            }
        }else if(strFlag != "" && strSrvyQty != 0){
        	if(strSrvyQty != strOrgSrvyQty || strSrvyAmt != strOrgSrvyAmt){
        		DS_IO_MASTER.NameValue(i, "SRVY_SALE_PRC") = getRoundDec("2",strSrvyAmt / strSrvyQty);
                if (strTaxFlag == "1"){         
                    DS_IO_MASTER.NameValue(i, "SRVY_COST_AMT") = getRoundDec("2",(strSrvyAmt / 1.1) * ((100 - strOrgMgRate)/100));
                }else{
                    DS_IO_MASTER.NameValue(i, "SRVY_COST_AMT") = getRoundDec("2",strSrvyAmt * ((100 - strOrgMgRate)/100));
                }           
            }
        }
        
        
    }
   
  
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strStkYm="+encodeURIComponent(strStkYm);    
    
    TR_MAIN.Action="/dps/pstk207.pt?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }else{
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"PUMBUN_CD");
    }
}

/**
 * errorChk()
 * 작 성 자     : 이재득
 * 작 성 일     : 2010-04-25
 * 개    요        : UPLOAD된 값 체크 
 * return값 : void
 */
 function errorChk(){
	 
     for(var i=1; i <= DS_IO_MASTER.CountRow; i++){
    	 DS_IO_CHECK.ClearData();
         var strStrCd = LC_O_STR_CD.BindColVal;
         
         var strPumbunCd     = DS_IO_MASTER.NameValue(i,"PUMBUN_CD");        
         var strPummokCd     = DS_IO_MASTER.NameValue(i,"PUMMOK_CD");
         var strEventFlag    = DS_IO_MASTER.NameValue(i,"EVENT_FLAG");
         var strEventRate    = DS_IO_MASTER.NameValue(i,"EVENT_RATE");
         var strMgRate       = DS_IO_MASTER.NameValue(i,"MG_RATE");
         
         
         var goTo       = "searchCheck" ;    
         var action     = "O";    
         var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                        + "&strPumbunCd="        +encodeURIComponent(strPumbunCd)
                        + "&strPummokCd="        +encodeURIComponent(strPummokCd)
                        + "&strEventFlag="        +encodeURIComponent(strEventFlag)
                        + "&strEventRate="        +encodeURIComponent(strEventRate)
                        + "&strMgRate="        +encodeURIComponent(strMgRate)
                        ;
         
         TR_MAIN.Action="/dps/pstk207.pt?goTo="+goTo+parameters;  
         TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CHECK=DS_IO_CHECK)"; //조회는 O
         TR_MAIN.Post();
               
         if (DS_IO_CHECK.NameValue(1 , "CNT") < 1) {
        	DS_IO_MASTER.RowPosition = i;
           	return false;
         }
      }
      return true;
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
        
     var strStrCd      = LC_O_STR_CD.BindColVal;    
     var strStkYm      = EM_O_STK_YM.Text;
     var strDeptCd     = LC_O_DEPT_CD.BindColVal;
     var strTeamCd     = LC_O_TEAM_CD.BindColVal;
     var strPcCd       = LC_O_PC_CD.BindColVal;
     var strCornerCd   = LC_O_CORNER_CD.BindColVal;
     var strPumbunCd   = EM_O_PUMBUN_CD.Text;
     var strStkDt      = EM_O_STK_DT.Text;
     GD_MASTER.ColumnProp('CHECK1','HeadCheck') = false;   
        
     var goTo       = "searchMaster" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                     +"&strStkYm="+encodeURIComponent(strStkYm)
                     +"&strStkDt="+encodeURIComponent(strStkDt)
                     +"&strDeptCd="+encodeURIComponent(strDeptCd)
                     +"&strTeamCd="+encodeURIComponent(strTeamCd)
                     +"&strPcCd="+encodeURIComponent(strPcCd)
                     +"&strCornerCd="+encodeURIComponent(strCornerCd)
                     +"&strPumbunCd="+encodeURIComponent(strPumbunCd);   
        
     TR_MAIN.Action="/dps/pstk207.pt?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
     TR_MAIN.Post();
     
     getPbnStk();
        
     //조회후 결과표시
     setPorcCount("SELECT", GD_MASTER);
     
     if (DS_IO_MASTER.CountRow > 0){
    	 for( var i = 1 ; i <= DS_IO_MASTER.CountRow; i++){     		      
             var strPumbunCd = DS_IO_MASTER.NameValue(i, "PUMBUN_CD");
             var strPummokCd = DS_IO_MASTER.NameValue(i, "PUMMOK_CD");
           //  searchMargin(strStrCd , strPumbunCd , strPummokCd , i);
           //  searchMg(strStrCd , strPumbunCd , strPummokCd , i);
         }
     }
     
   //실사종료일에 따라 그리드 Edit설정
     gridEditable();
 }
 
 /**
  * srvyDtValidation()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-14
  * 개    요 : 실사년월기간내 등록가능 여부를체크한다.
  * return값 : void
 **/
 function srvyDtValidation(){
      getPbnStk();
      var srvySDt  = DS_O_PBNSTK.NameValue(1, "SRVY_S_DT");
      var srvyEDt  = DS_O_PBNSTK.NameValue(1, "SRVY_E_DT");
      var strToDay = DS_O_PBNSTK.NameValue(1, "TODAY_DT");
      var stkDt    = EM_O_STK_DT.Text;
      if (srvySDt <= strToDay && srvyEDt >= strToDay){
    	  GD_MASTER.ColumnProp('SKU_CD','edit')= "true";
          GD_MASTER.ColumnProp('NORM_QTY','edit')= "true";
          GD_MASTER.ColumnProp('INFRR_QTY','edit')= "true";
          return true;  
      }else{
          showMessage(EXCLAMATION , Ok,  "USER-1093");
          GD_MASTER.ColumnProp('SKU_CD','edit')= "false";
          GD_MASTER.ColumnProp('NORM_QTY','edit')= "false";
          GD_MASTER.ColumnProp('INFRR_QTY','edit')= "false";
          //DS_IO_MASTER.ClearData();
          return false;     
      }
      return true;
  }
 
 /**
  * gridEditable()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-14
  * 개    요 : 실사종료일자에 따라 그리드 Edit 설정을 한다.
  * return값 : void
 **/
 function gridEditable(){    
     var srvyEDt  = DS_O_PBNSTK.NameValue(1, "SRVY_E_DT");
     var strToDay = DS_O_PBNSTK.NameValue(1, "TODAY_DT"); 
     var strCloseDt = "";
    
     if(DS_IO_MASTER.CountRow > 0) strCloseDt += DS_IO_MASTER.NameValue(1, "CLOSE_DT");
     
     var strCloseState = EM_O_STATE.Text;
  	
 	 
     if (srvyEDt < strToDay || strCloseState == "마감" || strCloseDt != ""){
         GD_MASTER.Editable = "false"; 
         enableControl(Excel_Up_Load, false);
     }else{
         GD_MASTER.Editable = "true"; 
         enableControl(Excel_Up_Load, true);
     }
     
    
	 
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
  * checkSaveValidation
  * 작 성 자 : 
  * 작 성 일 : 2010-04-17
  * 개    요 : checkSaveValidation.
  * return값 : void
 **/
 function checkSaveValidation(){
	 if( LC_O_STR_CD.BindColVal == "%" || LC_O_STR_CD.BindColVal == ""){
	        showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "점");            
	        LC_O_STR_CD.Focus;
	        return false;
	    }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "PUMBUN_CD") == "" ){
	        showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "브랜드코드");            
	        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"PUMBUN_CD");
	        return false;
	    }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "PUMBUN_NAME") == "" ){
	        showMessage(EXCLAMATION, Ok,  "USER-1036", "브랜드코드");            
	        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"PUMBUN_CD");
	        return false;
	    }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "PUMMOK_CD") == "" ){
            showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "품목코드");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"PUMMOK_CD");
            return false;
        }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "PUMMOK_NAME") == "" ){
            showMessage(EXCLAMATION, Ok,  "USER-1036", "품목코드");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"PUMMOK_CD");
            return false;
        }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "EVENT_FLAG") == "" ){
            showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "행사구분");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"EVENT_FLAG");
            return false;
        }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "EVENT_RATE") == "" ){
            showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "행사율");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"EVENT_RATE");
            return false;
        }
     return true;
 }
 
 /**
  * getCloseDt()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 마감여부 체크
  * return값 : void
  */
 function getCloseDt() { 
	  var strStrCd       = LC_O_STR_CD.BindColVal;              
      var strStkYm       = EM_O_STK_YM.Text;    
      
      var goTo       = "searchCloseDt" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strStkYm="+encodeURIComponent(strStkYm);
     
      TR_MAIN.Action="/dps/pstk207.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CLOSE=DS_IO_CLOSE)"; //조회는 O
      TR_MAIN.Post();
      
      if (DS_IO_CLOSE.NameValue(1, "CNT") > 0 ){
          showMessage(EXCLAMATION , Ok,  "USER-1068", "확정/", "");          
        //확정/마감 된 브랜드일 경우 그리드 에디트 사용불가
          GD_MASTER.Editable = "false";
          return false;
      }else{
        //확정/마감 된 브랜드일 경우 그리드 에디트 사용가능
          GD_MASTER.Editable = "true";
          return true;
      }
      return true ;
 }
 
 /**
  * btn_Add1()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-02-10
  * 개    요 : 그리드 Row추가 
  * return값 : void
 */
 function btn_Add1(){     
	 if (!srvyDtValidation())
         return;
     
     if (!getCloseDt())
         return;
     
     DS_IO_MASTER.Addrow();
     setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"PUMBUN_CD");
     GD_MASTER.ColumnProp('CHECK1','HeadCheck') = false;
 }

 /**
  * btn_Del1()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-02-10
  * 개    요 : 그리드 Row 삭제 
  * return값 : void
 */
 function btn_Del1(){
    var row = DS_IO_MASTER.RowPosition;
    if( DS_IO_MASTER.RowStatus(row) == "1")
        DS_IO_MASTER.DeleteRow(row);
    else
        showMessage(INFORMATION, OK, "USER-1052");
    
    GD_MASTER.Focus();
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
     var strCornerCd = "00";
     if (LC_O_CORNER_CD.BindColVal == "%" || LC_O_CORNER_CD.BindColVal == ""){
         strCornerCd  = "00";  
     }else
         strCornerCd  = LC_O_CORNER_CD.BindColVal;
     
     var strOrgCd = strStrCd+strDeptCd+strTeamCd+strPcCd+strCornerCd; 
     var codeObj = EM_O_PUMBUN_CD;
     var nameObj = EM_O_PUMBUN_NAME;
     
     if(DS_IO_MASTER.CountRow > 0){
         DS_IO_MASTER.ClearData();
     }
      
     if(codeObj.Text == "" && evnflag != "POP" ){  
    	 nameObj.Text = "";
         EM_O_STK_DT.Text = "";
         EM_O_STK_FLAG.Text = ""; 
         EM_O_STATE.Text = "";
         return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = strPbnPop(codeObj,nameObj,'Y', '',strStrCd, strOrgCd,'','','','','2','','','','','');
          
     }else if( evnflag == "NAME" ){
         setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y", '1','',strStrCd, strOrgCd,'','','','','2','','','','','');
         getPbnInf();
         strSkuType = DS_SEARCH_NM.NameValue(1, "SKU_TYPE");   
     }

     if( result != null ){ 
    	 getPbnInf();
         strSkuType = result.get("SKU_TYPE");        
     }
 } 
 
 
 /**
  * getPbnInf()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 브랜드정보(조직/재고평가구분) 조회
  * return값 : void
  */
 function getPbnInf() {
      var strStrCd       = LC_O_STR_CD.BindColVal;
      var strPumbunCd    = EM_O_PUMBUN_CD.Text;       
      
      var goTo       = "searchPbnInf" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strPumbunCd="+encodeURIComponent(strPumbunCd);
      
      TR_MAIN.Action="/dps/pstk207.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_O_PBNINF=DS_O_PBNINF)"; //조회는 O
      TR_MAIN.Post();     
      
      if (DS_O_PBNINF.CountRow > 0) {
	      if (DS_O_PBNINF.NameValue(1, "BIZ_TYPE") != '1' && DS_O_PBNINF.NameValue(1, "BIZ_TYPE") != '2') {
			showMessage(EXCLAMATION, OK, "USER-2003"); 
			EM_O_PUMBUN_CD.Text = "";
			EM_O_PUMBUN_NAME.Text = "";
			EM_O_PUMBUN_CD.Focus();
	      }
      }     
 }
  
 /**
  * getPbnStk()
  * 작 성 자 : 
  * 작 성 일 : 2010.04.12
  * 개     요 : 재고실사 조회
  * return값 : void
  */
 function getPbnStk() {
      var strStrCd       = LC_O_STR_CD.BindColVal;
      var strPumbunCd    = EM_O_PUMBUN_CD.Text;           
      var strStkYm       = EM_O_STK_YM.Text;
      
      EM_O_STK_DT.Text = "";
      EM_O_STK_FLAG.Text = "";
      EM_O_STATE.Text = "";
      
      var goTo       = "searchPbnStk" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)                      
                      +"&strStkYm="+encodeURIComponent(strStkYm);
      
      TR_MAIN.Action="/dps/pstk207.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_O_PBNSTK=DS_O_PBNSTK)"; //조회는 O
      TR_MAIN.Post();     
      
      EM_O_STK_DT.Text = DS_O_PBNSTK.NameValue(1, "SRVY_DT");
      EM_O_STK_FLAG.Text = DS_O_PBNSTK.NameValue(1, "STK_FLAG_NAME"); 
      EM_O_STATE.Text = DS_O_PBNSTK.NameValue(1, "CLOSE_DT");
 }
 
 /**
  * getPumbunPop()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.03.28
  * 개    요 :  브랜드GridPopup
  * return값 : void
  */
 function getPumbunPop(row, colid , popFlag){
    var strStrCd  = LC_O_STR_CD.BindColVal; 
    var strDeptCd  = LC_O_DEPT_CD.BindColVal;
    var strTeamCd = LC_O_TEAM_CD.BindColVal;  
    var strPcCd  = LC_O_PC_CD.BindColVal;
    var strCornerCd = "00";
    if (LC_O_CORNER_CD.BindColVal == "%" || LC_O_CORNER_CD.BindColVal == ""){
        strCornerCd  = "00";  
    }else
        strCornerCd  = LC_O_CORNER_CD.BindColVal;
    
    var strFirstPumbunCd  = DS_IO_MASTER.NameValue(1,"PUMBUN_CD");
    var strPumbunCd  = DS_IO_MASTER.NameValue(row,"PUMBUN_CD");
    DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") = "";
    var strPumbunNm  ="";  
    var strOrgCd = strStrCd+strDeptCd+strTeamCd+strPcCd+strCornerCd; 
    
    // 입력인 경우
    if(popFlag != "1"){        
        var rtnMap = setStrPbnNmWithoutToGridPop("DS_O_RESULT", strPumbunCd, strPumbunNm , 'Y' , '1','',strStrCd, strOrgCd,'','','','','2','','','','','');
        if(rtnMap != null){
        	
        	/*
        	if(strFirstPumbunCd != "" && strFirstPumbunCd != rtnMap.get("PUMBUN_CD")){
        		showMessage(EXCLAMATION , Ok,  "GAUCE-1000", "동일 브랜드만 등록 가능합니다.");
        		setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"PUMBUN_CD");
        		return;
        	}
        	*/
        	
            // MARIO OUTLET 2011-10-21
            if (rtnMap.get("BIZ_TYPE") != "1" && rtnMap.get("BIZ_TYPE") != "2") {
            	DS_IO_MASTER.NameValue(row,"PUMBUN_CD")   = "";
            	DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") = "";
            	showMessage(EXCLAMATION, OK, "USER-2003");
            	return;
            }
        	// MARIO OUTLET 2011-10-21
        	
            DS_IO_MASTER.NameValue(row, "PUMBUN_CD")    = rtnMap.get("PUMBUN_CD");
            DS_IO_MASTER.NameValue(row, "PUMBUN_NAME")  = rtnMap.get("PUMBUN_NAME");
            DS_IO_MASTER.NameValue(row, "TAX_FLAG")     = rtnMap.get("TAX_FLAG");

            if (strPumbunCd != DS_IO_MASTER.NameValue(row, "PUMBUN_CD")){
            	DS_IO_MASTER.NameValue(row, "PUMMOK_CD")    = "";
                DS_IO_MASTER.NameValue(row, "PUMMOK_NAME")  = "";
                DS_IO_MASTER.NameValue(row, "TAX_FLAG")     = "";
            }            
        } 
    // POPUP인 경우
    }else{
        if (popFlag =="1"){         
            var rtnMap = strPbnToGridPop(strPumbunCd , strPumbunNm,'Y','',strStrCd, strOrgCd,'','','','','2','','','','','');
            if(rtnMap != null){
            	/*
            	if(strFirstPumbunCd != "" && strFirstPumbunCd != rtnMap.get("PUMBUN_CD")){
                    showMessage(EXCLAMATION , Ok,  "GAUCE-1000", "동일 브랜드만 등록 가능합니다.");
                    setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"PUMBUN_CD");
                    return;
                }
            	*/
            	
                // MARIO OUTLET 2011-10-21
                if (rtnMap.get("BIZ_TYPE") != "1" && rtnMap.get("BIZ_TYPE") != "2") {
                	DS_IO_MASTER.NameValue(row,"PUMBUN_CD")   = "";
                	DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") = "";
                	showMessage(EXCLAMATION, OK, "USER-2003");
                	return;
                }
            	// MARIO OUTLET 2011-10-21
            	
            	DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") = "";
                DS_IO_MASTER.NameValue(row, "PUMBUN_CD")    = rtnMap.get("PUMBUN_CD");
                DS_IO_MASTER.NameValue(row, "PUMBUN_NAME")  = rtnMap.get("PUMBUN_NAME");
                DS_IO_MASTER.NameValue(row, "TAX_FLAG")     = rtnMap.get("TAX_FLAG");
                if (strPumbunCd != DS_IO_MASTER.NameValue(row, "PUMBUN_CD")){
                    DS_IO_MASTER.NameValue(row, "PUMMOK_CD")    = "";
                    DS_IO_MASTER.NameValue(row, "PUMMOK_NAME")  = "";
                    DS_IO_MASTER.NameValue(row, "TAX_FLAG")     = "";
                } 
            }
        }
    }    
        
 }
 
 /**
  * getSkuPop()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.03.28
  * 개    요 :  품목GridPopup
  * return값 : void
  */
 function getPummokPop(row, colid , popFlag){   
     var strStrCd  = LC_O_STR_CD.BindColVal;    
     
     var strPumbunCd  = DS_IO_MASTER.NameValue(row,"PUMBUN_CD");
     if (strPumbunCd == ""){
         showMessage(EXCLAMATION, Ok,  "USER-1045", "브랜드"); 
         setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"PUMMOK_CD");
         return;
     }
       
     var strPummokCd  = DS_IO_MASTER.NameValue(row,"PUMMOK_CD");
     var strPummokNm  ="";  
     DS_IO_MASTER.NameValue(row,"PUMMOK_NAME") = "";
     
     if(strPumbunCd != "" && popFlag != "1"){        
         var rtnMap = setPbnPmkNmWithoutToGridPop("DS_O_RESULT", strPummokCd, strPummokNm , strPumbunCd , '1');
         if(rtnMap != null){
             DS_IO_MASTER.NameValue(row, "PUMMOK_CD")    = rtnMap.get("PUMMOK_CD");
             DS_IO_MASTER.NameValue(row, "PUMMOK_NAME")  = rtnMap.get("PUMMOK_NAME");
             strPummokCd = DS_IO_MASTER.NameValue(row, "PUMMOK_CD");
            // searchMargin(strStrCd , strPumbunCd , strPummokCd, row);
            // searchMg(strStrCd , strPumbunCd , strPummokCd , row);
         }       
     }else{
         if (popFlag =="1"){         
             var rtnMap = pbnPmkToGridPop(strPummokCd , strPummokNm , strPumbunCd);
             if(rtnMap != null){         
                 DS_IO_MASTER.NameValue(row, "PUMMOK_CD")    = rtnMap.get("PUMMOK_CD");
                 DS_IO_MASTER.NameValue(row, "PUMMOK_NAME")  = rtnMap.get("PUMMOK_NAME");
                 strPummokCd = DS_IO_MASTER.NameValue(row, "PUMMOK_CD");
                // searchMargin(strStrCd , strPumbunCd , strPummokCd, row);
                // searchMg(strStrCd , strPumbunCd , strPummokCd , row);
             }
         }
     }   
  }
 
 /**
  * searchMargin()
  * 작 성 자 : 
  * 작 성 일 : 2010.04.12
  * 개     요 : 행사구분,행사율 조회
  * return값 : void
  */
 function searchMargin(strStrCd , strPumbunCd , strPummokCd , row) { 
      var action     = "O"; 
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strPumbunCd="+encodeURIComponent(strPumbunCd);
      
      TR_MAIN.Action="/dps/pstk207.pt?goTo="+"searchFlag"+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_FLAG=DS_IO_FLAG)"; //조회는 O
      TR_MAIN.Post();
      
      TR_MAIN.Action="/dps/pstk207.pt?goTo="+"searchRate"+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_RATE=DS_IO_RATE)"; //조회는 O
      TR_MAIN.Post();
 }
  
  /**
   * searchMg()
   * 작 성 자 : 
   * 작 성 일 : 2010.04.12
   * 개     요 : 마진율 조회
   * return값 : void
   */
  function searchMg(strStrCd , strPumbunCd , strPummokCd , row) { 
	   var strEventFlag = DS_IO_MASTER.NameValue(row, "EVENT_FLAG");
	   var strEventRate = DS_IO_MASTER.NameValue(row, "EVENT_RATE");
	   
       var action     = "O"; 
       var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                       +"&strEventFlag="+encodeURIComponent(strEventFlag)
                       +"&strEventRate="+encodeURIComponent(strEventRate)
                       +"&strPumbunCd="+encodeURIComponent(strPumbunCd);
       
       TR_MAIN.Action="/dps/pstk207.pt?goTo="+"searchMg"+parameters;  
       TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MG=DS_IO_MG)"; //조회는 O
       TR_MAIN.Post();
  }
  
  /**
   * searchJb()
   * 작 성 자 : 
   * 작 성 일 : 2010.04.12
   * 개     요 : 장부재고  조회
   * return값 : void
   */
  /*
   function searchJb(strStrCd , row) {	   
	   var strStkYm     = EM_O_STK_YM.Text;
	   var strStkDt     = EM_O_STK_DT.Text;
       var strPumbunCd  = DS_IO_MASTER.NameValue(row, "PUMBUN_CD");       
       var strEventFlag = DS_IO_MASTER.NameValue(row, "EVENT_FLAG");
       var strEventRate = DS_IO_MASTER.NameValue(row, "EVENT_RATE");
       var strMgRate    = DS_IO_MASTER.NameValue(row, "MG_RATE");
       var strPummokCd  = DS_IO_MASTER.NameValue(row, "PUMMOK_CD");
       
       var action     = "O"; 
       var parameters = "&strStrCd="+strStrCd
                       +"&strStkYm="+strStkYm
                       +"&strStkDt="+strStkDt
                       +"&strPumbunCd="+strPumbunCd
                       +"&strEventRate="+strEventRate
                       +"&strEventFlag="+strEventFlag
                       +"&strMgRate="+strMgRate
                       +"&strPummokCd="+strPummokCd;
       
       TR_MAIN.Action="/dps/pstk207.pt?goTo="+"searchJb"+parameters;  
       TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_JB=DS_IO_JB)"; //조회는 O
       TR_MAIN.Post();
       
       if(DS_IO_JB.CountRow > 0){
    	   DS_IO_MASTER.NameValue(row, "STK_QTY") = DS_IO_JB.NameValue(1, "JB_QTY");
    	   DS_IO_MASTER.NameValue(row, "STK_AMT") = DS_IO_JB.NameValue(1, "JB_AMT");
       }
  }
 */
 /**
  * getExcelUpLoadPop()
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-02-23 
  * 개    요 : 의류단품 엑셀 업로드  팝업
  * 사용방법 : getExcelUpLoadPop()
  * return값 : array
  */
  function getExcelUpLoadPop(){
	  
	  if (!srvyDtValidation())
          return;
 
      var rtnMap  = new Map();
      var arrArg  = new Array();
      
      arrArg.push(rtnMap);
      arrArg.push(LC_O_STR_CD.BindColVal);      // 점
      arrArg.push(EM_O_PUMBUN_CD.Text);      // 브랜드
      arrArg.push(EM_O_STK_YM.Text);     // 실사년월
           
      DS_O_SKU.ClearData();
      //DS_IO_DETAIL.ClearData();
      
   // 필수 입력 내용 체크
      //if(checkValidation("Save")){
          var returnVal = window.showModalDialog("/dps/pstk207.pt?goTo=popUpList",
                                                 arrArg,
                                                 "dialogWidth:900px;dialogHeight:378px;scroll:no;" +
                                                 "resizable:no;help:no;unadorned:yes;center:yes;status:no");         
         
          if(returnVal != ""){
              DS_O_SKU.ImportData(returnVal);
              
              for(var i = 1; i<= DS_O_SKU.CountRow; i++){
                  
                  if(DS_O_SKU.NameValue(i, "CHECK1") == "T"){
                      DS_IO_MASTER.AddRow();
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD")        = DS_O_SKU.NameValue(i, "PUMBUN_CD");         // 단품코드
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_NAME")      = DS_O_SKU.NameValue(i, "PUMBUN_NAME");        // 수량
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMMOK_CD")        = DS_O_SKU.NameValue(i, "PUMMOK_CD"); 
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMMOK_NAME")        = DS_O_SKU.NameValue(i, "PUMMOK_NAME"); 
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "EVENT_FLAG")  = DS_O_SKU.NameValue(i, "EVENT_FLAG"); 
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "EVENT_RATE")  = DS_O_SKU.NameValue(i, "EVENT_RATE"); 
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MG_RATE")       = DS_O_SKU.NameValue(i, "MG_RATE"); 
                    //  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STK_QTY")       = DS_O_SKU.NameValue(i, "STK_QTY"); 
                    //  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STK_AMT")      = DS_O_SKU.NameValue(i, "STK_AMT"); 
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_QTY")      = DS_O_SKU.NameValue(i, "SRVY_QTY"); 
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_AMT")     = DS_O_SKU.NameValue(i, "SRVY_AMT"); 
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD")     = DS_O_SKU.NameValue(i, "STR_CD"); 
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STK_YM")      = DS_O_SKU.NameValue(i, "STK_YM"); 
                      
                      /* 과세구분 추가 */
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAX_FLAG")      = DS_O_SKU.NameValue(i, "TAX_FLAG");
                  }
              }
          }
     //}
   
     
  }

 /**
  * ExcelDownData()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010.01.24
  * 개     요 : 엑셀다운
  * return값 :
  */
  function ExcelDownData() {
	  
	  var strStrCd      = LC_O_STR_CD.BindColVal;    
	  var strStkYm      = EM_O_STK_YM.Text;
	  var strDeptCd     = LC_O_DEPT_CD.BindColVal;
	  var strTeamCd     = LC_O_TEAM_CD.BindColVal;
	  var strPcCd       = LC_O_PC_CD.BindColVal;
	  var strCornerCd   = LC_O_CORNER_CD.BindColVal;
	  var strPumbunCd   = EM_O_PUMBUN_CD.Text;
	  var strStkDt      = EM_O_STK_DT.Text;
	  
	  var goTo       = "searchMasterExcel" ;    
	  var action     = "O";     
	  var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
	                  +"&strStkYm="+encodeURIComponent(strStkYm)
	                  +"&strStkDt="+encodeURIComponent(strStkDt)
	                  +"&strDeptCd="+encodeURIComponent(strDeptCd)
	                  +"&strTeamCd="+encodeURIComponent(strTeamCd)
	                  +"&strPcCd="+encodeURIComponent(strPcCd )
	                  +"&strCornerCd="+encodeURIComponent(strCornerCd)
	                  +"&strPumbunCd="+encodeURIComponent(strPumbunCd);      
      
      TR_MAIN.Action="/dps/pstk207.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_EXCEL=DS_IO_EXCEL)"; //조회는 O
      TR_MAIN.Post();
            
      //if(DS_IO_EXCEL.CountRow <= 0){
      //  showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
      //    return;
      //}
      
      var strTitle = "실사재고등록(비단품)";

      var parameters = "";
      
      openExcel4(GD_EXCEL, strTitle, parameters, true );      
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
<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
   style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
   <param name="Text" value='FileOpen'>
   <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>
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
        getPbnStk();
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
    case "EVENT_RATE" : 
    	var strStrCd = LC_O_STR_CD.BindColVal;
    	var strPumbunCd  = DS_IO_MASTER.NameValue(row,"PUMBUN_CD");
    	var strPummokCd  = DS_IO_MASTER.NameValue(row,"PUMMOK_CD");
        //searchMg(strStrCd , strPumbunCd , strPummokCd, row);             
        break;
    case "MG_RATE" : 
        var strStrCd = LC_O_STR_CD.BindColVal;
        //searchJb(strStrCd , row);  
        //setFocusGrid(GD_MASTER, DS_IO_MASTER, row, "SRVY_QTY");
        break;
    }      
</script>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
    
    DS_O_DEPT_CD.ClearData();
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
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
        getPbnStk();
    }
</script>

<script language=JavaScript for=LC_O_DEPT_CD event=OnSelChange>
    
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
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
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
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

<script language=JavaScript for=LC_O_PC_CD event=OnSelChange>
    DS_O_CORNER_CD.ClearData();
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
    if (this.BindColVal == '%'){
        insComboData(LC_O_CORNER_CD, "%", "전체", 1);
        setComboData(LC_O_CORNER_CD, "%");
        return;
    }

    getCorner("DS_O_CORNER_CD", LC_O_STR_CD.BindColVal,
        LC_O_DEPT_CD.BindColVal, LC_O_TEAM_CD.BindColVal, LC_O_PC_CD.BindColVal, "Y");
        
    if(DS_O_CORNER_CD.CountRow < 1){
        insComboData(LC_O_CORNER_CD, "%", "전체", 1);       
    }
    LC_O_CORNER_CD.Index = 0;
</script>

<!-- 브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setPumbunCdSkuType("NAME");
</script>

<script language=JavaScript for=LC_O_CORNER_CD event=OnSelChange>
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
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
<object id="DS_O_PBNSTK" classid=<%= Util.CLSID_DATASET %>></object>
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
<comment id="_NSID_">
<object id="DS_O_SKU" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PBNINF" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="DS_IO_EXCEL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_CHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_CLOSE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_RATE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_MG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_JB" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="DS_CLOSECHECK" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
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
            <th class="point" width="80">점</th>
            <td width="165">
                 <comment id="_NSID_">
                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                    </object>
                </comment><script>_ws_(_NSID_);</script>
            </td>
            <th class="point" width="80">팀</th>
            <td width="165"><comment id="_NSID_"> <object id=LC_O_DEPT_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th class="point" width="80">파트</th>
            <td><comment id="_NSID_"> <object id=LC_O_TEAM_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=170 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td> 
          </tr>
          <tr>
            <th class="point" width="80">PC</th>
            <td><comment id="_NSID_"> <object id=LC_O_PC_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th width="80">코너</th>
            <td><comment id="_NSID_"> <object id=LC_O_CORNER_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th class="point" width="80">년월</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_STK_YM classid=<%=Util.CLSID_EMEDIT%>  width=145 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('M',EM_O_STK_YM)" align="absmiddle" /></td>            
            </tr>
            <tr>
            <th width="80">브랜드</th>
            <td colspan="5">
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=70 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPumbunCdSkuType('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=168 tabindex=1>
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
      <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
        <tr>
          <th width="84">재고조사일</th>
          <td width="164">
              <comment id="_NSID_">
                    <object id=EM_O_STK_DT classid=<%=Util.CLSID_EMEDIT%>  width=164 tabindex=1>
                    </object>
              </comment><script> _ws_(_NSID_);</script>
          </td>
          <th width="80">재고실사구분</th>
          <td width="162">
              <comment id="_NSID_">
                    <object id=EM_O_STK_FLAG classid=<%=Util.CLSID_EMEDIT%>  width=162 tabindex=1>
                    </object>
              </comment><script> _ws_(_NSID_);</script>
          </td>
          <th width="80">상태</th>
          <td>
              <comment id="_NSID_">
                    <object id=EM_O_STATE classid=<%=Util.CLSID_EMEDIT%>  width=165 tabindex=1>
                    </object>
              </comment><script> _ws_(_NSID_);</script>
          </td>
        </tr>
      </table></td>
    </tr>
  <tr>
      <td class="dot"></td>
  </tr>
  <tr>
    <td class="right PB03">
        <table width="160" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <th><img src="/<%=dir%>/imgs/btn/add_row.gif" 
                  onclick="javascript:btn_Add1();" hspace="2" /></th> 
              <th><img src="/<%=dir%>/imgs/btn/del_row.gif" 
                  onclick="javascript:btn_Del1();" /></th>
              <th><img src="/<%=dir%>/imgs/btn/excel_s.gif" id="Excel_Up_Load"
                  onclick="getExcelUpLoadPop();" align="absmiddle" /></th>
              <th><img src="/<%=dir%>/imgs/btn/excel_down.gif" id="Excel_Down_Load"
                  onclick="ExcelDownData();" align="absmiddle" /></th>
            </tr>
        </table>
    </td>
  </tr>
  <tr>
      <td class="PT05">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"><object id=GD_MASTER
                    width="100%" height=397 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_MASTER">
                </object></comment><script>_ws_(_NSID_);</script></td>
            </tr>
            <tr>
            <td><comment id="_NSID_"><object id=GD_EXCEL
                    width="0" height=0 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_EXCEL">
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

</body>
</html>

