<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> PDA실사재고수정및확정
 * 작 성 일 : 2010.04.12
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk205.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : PDA실사재고수정및확정을 관리한다.
 * 이    력 :
 *        2010.04.12 (이재득) 작성
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
var bfMasterRowPos = 0;

var strSkuType = "0";
var strPummokCd ="";

var strStrCd       = "";
var strStkYm       = "";
var strPumbunCd    = "";
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

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    
    // EMedit에 초기화( gauce.js )
    initEmEdit(EM_O_STK_YM,       "THISMN",    PK);     //실사년월
    initEmEdit(EM_O_PUMBUN_CD,    "CODE^6^0",  NORMAL); //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME,  "GEN^40",    READ); //브랜드명
    initEmEdit(EM_O_ORG_NAME,     "GEN^40",    READ); //조직명    
    initEmEdit(EM_O_STK_DT,       "YYYYMMDD",  READ); //재고조사일
    initEmEdit(EM_O_STK_FLAG,     "GEN^10",    READ); //재고실사구분
    initEmEdit(EM_O_STATE,        "GEN^40",    READ); //상태
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회)   
    
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
    getPbnStk();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pstk205","DS_IO_DETAIL" );
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"              width=30     align=center    edit=none</FC>'    	             
    	             + '<FC>id=STR_CD          name="점"              width=50    align=center  show="false"</FC>'
    	             + '<FC>id=PDA_NO          name="PDA번호"         width=60    align=center  edit=none</FC>'
                     + '<FC>id=PUMBUN_CD       name="브랜드"            width=60    align=center  edit=none</FC>'
                     + '<FC>id=PUMBUN_NAME     name="브랜드명"          width=110    align=left  edit=none</FC>'
                     + '<FC>id=STK_YM          name="실사년월"        width=100    align=left  edit=none  show="false"</FC>';                     
                      
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}        name="NO"              width=30     align=center    edit=none   sumtext=""</FC>' 
                     + '<FC>id=SKU_CD          name="*단품코드"         width=120    align=center edit={IF(FLAG=1,"false","true")}  sumtext="합계"  EditStyle=Popup</FC>'
                     + '<FC>id=SKU_NAME        name="단품명"           width=130    align=left  edit=none</FC>' 
                     + '<FC>id=BUY_COST_PRC    name="매가"             width=60    align=right  edit=none  show="false"</FC>'
                     + '<FC>id=BUY_SALE_PRC    name="단가"             width=60    align=right  edit=none  </FC>'                     
                     + '<FG> name="실사재고" '
                     + '<FC>id=NORM_QTY        name="정상수량"         width=70    align=right   sumtext=@sum  edit=Numeric</FC>'
                     + '<FC>id=NORM_AMT        name="정상금액"         width=90    align=right   edit=none  sumtext=@sum</FC>'
                     + '<FC>id=INFRR_QTY       name="불량수량"         width=70    align=right   sumtext=@sum  edit=Numeric</FC>'
                     + '<FC>id=INFRR_AMT       name="불량금액"         width=90    align=right   edit=none  sumtext=@sum</FC>'
                     + '<FC>id=SRVY_QTY        name="합계수량"         width=70    align=right  edit=none   sumtext=@sum</FC>'
                     + '<FC>id=SRVY_QTY_AMT    name="합계금액"         width=90    align=right   edit=none  sumtext=@sum</FC>'
                     + '<FC>id=SRVY_COST_AMT   name="재고실사원가금액"  width=90    align=right  edit=none  show="false"</FC>'
                     + '<FC>id=SRVY_SALE_AMT   name="재고실사매가금액"  width=90    align=right  edit=none   show="false"</FC>'
                     + '</FG> '
                     + '<FC>id=STYLE_CD        name="STYLE코드"        width=70    align=center  edit=none show="false"</FC>'
                     + '<FC>id=STYLE_NAME      name="STYLE"           width=100    align=left  edit=none  </FC>'
                     + '<FC>id=COLOR_CD        name="칼라"            width=70    align=left  edit=none  EditStyle=Lookup    Data="DS_I_COLOR_CD:CODE:NAME"</FC>'
                     + '<FC>id=SIZE_CD         name="사이즈"           width=70    align=left  edit=none  EditStyle=Lookup    Data="DS_I_SIZE_CD:CODE:NAME"</FC>'                     
                     + '<FC>id=INPUT_PLU_CD    name="소스마킹코드"     width=100    align=left  edit=none  show="false"</FC>'
                     + '<FC>id=SALE_UNIT_CD    name="판매단위"         width=60    align=left  edit=none  show="false"  EditStyle=Lookup    Data="DS_I_SALE_UNIT_CD:CODE:NAME"</FC>'
                     + '<FC>id=CMP_SPEC_UNIT   name="구성규격단위"     width=80    align=left  edit=none  show="false"  EditStyle=Lookup    Data="DS_I_CMP_SPEC_UNIT:CODE:NAME"</FC>'
                     + '<FC>id=FLAG            name="EDIT구분자"       width=50    align=left  edit=none  show="false" </FC>'
                     + '<FC>id=PUMMOK_CD       name="품목코드"       width=50    align=left  edit=none   show="false"</FC>'
                     + '<FC>id=SKU_TYPE        name="단품구분"        width=50    align=left  edit=none  show="false" </FC>';
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
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
	         return false;
	     } 
	 } 
	 
	if( LC_O_STR_CD.BindColVal == "" ){
        showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "점");            
        LC_O_STR_CD.Focus();
        return false;
    }else if( EM_O_STK_YM.Text == "" ){
    	showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "실사년월");            
    	EM_O_STK_YM.Focus();
        return false;
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
	/**  2010/04/29 신규버튼 제거
	//기존의 신규로우 존재 시 데이타 클리어 
    var insRow = DS_IO_MASTER.RowPosition;
    if(insRow < 1){
        //조회 후 신규 등록이 가능합니다.
        showMessage(INFORMATION, OK, "USER-1025");
        GD_MASTER.Focus();
        return;
    }
	var strPumbunCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition ,"PUMBUN_CD")	
    if (strPumbunCd != ""){         
        DS_IO_DETAIL.Addrow(); 
        setFocusGrid(GD_DETAIL,DS_IO_DETAIL, DS_IO_DETAIL.RowPosition ,"SKU_CD");
    }
	*/
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
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION , OK, "USER-1028");
        return;
    }    
        
    if( LC_O_STR_CD.BindColVal == "%" || LC_O_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "점");            
        LC_O_STR_CD.Focus;
        return false;
    }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STK_YM") == "" ){
        showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "실사년월");            
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STK_YM");
        return false;
    } 

    if( DS_IO_DETAIL.NameValue(DS_IO_MASTER.CountRow, "SKU_CD") == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "단품코드");            
        setFocusGrid(GD_DETAIL,DS_IO_DETAIL,DS_IO_DETAIL.CountRow,"PUMBUN_CD");
        return false;
    }
    if( DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "SKU_NAME") == "" ){
        showMessage(EXCLAMATION , Ok,  "USER-1036", "단품코드");            
        setFocusGrid(GD_DETAIL,DS_IO_DETAIL,DS_IO_DETAIL.CountRow,"PUMBUN_CD");
        return false;
    }  
    
    if( getCloseCheck('DS_CLOSECHECK','',strToday,'PSTK','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        LC_O_STR_CD.Focus();
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
    var strStrCd = LC_O_STR_CD.BindColVal;
    var strStkYm = EM_O_STK_YM.Text;
    var strPumbunCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");
    var strPdaNo = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PDA_NO");
    
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strStkYm="+encodeURIComponent(strStkYm)
                    +"&strPumbunCd="+encodeURIComponent(strPumbunCd)
                    +"&strPdaNo="+encodeURIComponent(strPdaNo);    
    
    TR_MAIN.Action="/dps/pstk205.pt?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }else{
    	setFocusGrid(GD_DETAIL,DS_IO_DETAIL,DS_IO_DETAIL.RowPosition,"SKU_CD");
    }
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
	 DS_IO_DETAIL.ClearData();
	 bfMasterRowPos = 0;
	    
	 strStrCd      = LC_O_STR_CD.BindColVal;    
	 strStkYm      = EM_O_STK_YM.Text;
	 strPumbunCd   = EM_O_PUMBUN_CD.Text;
	   
	 var goTo       = "searchMaster" ;    
	 var action     = "O";     
	 var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
	                 +"&strStkYm="+encodeURIComponent(strStkYm)
	                 +"&strPumbunCd="+encodeURIComponent(strPumbunCd);   
	    
	 TR_MAIN.Action="/dps/pstk205.pt?goTo="+goTo+parameters;  
	 TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	 TR_MAIN.Post();
	    
	 //조회후 결과표시
	 setPorcCount("SELECT", GD_MASTER);
	    
	 if (DS_IO_MASTER.CountRow > 0){
	    getcolumnSetting(strSkuType); 
	 }else if (DS_IO_MASTER.CountRow == 0){
	  	DS_IO_DETAIL.ClearData();
	 }	   
 }
 

 /**
  * searchDetail
  * 작 성 자 : 
  * 작 성 일 : 2010-03-02
  * 개    요 : 상세내역을 조회한다.
  * return값 : void
 **/
 function searchDetail() {

     var strStrCd    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
     var strPumbunCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");
     var strStkDt    = EM_O_STK_DT.Text;

     
         
     var goTo       = "searchDetail" ;    
     var action     = "O";
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                    + "&strStkDt="+encodeURIComponent(strStkDt);
     TR_SUB.Action="/dps/pstk205.pt?goTo="+goTo+parameters;  
     TR_SUB.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
     TR_SUB.Post();

     //조회후 결과표시
     setPorcCount("SELECT",GD_DETAIL); 
     
     if (DS_IO_DETAIL.CountRow > 0){
    	 var strSkuType = DS_IO_DETAIL.NameValue(1, "SKU_TYPE");
    	 getcolumnSetting(strSkuType);
    	 gridEditable();
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
     var codeObj = EM_O_PUMBUN_CD;
     var nameObj = EM_O_PUMBUN_NAME;
     
     //nameObj.Text = "";
      
     if(codeObj.Text == "" && evnflag != "POP" ){ 
    	 nameObj = "";
    	 return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = strPbnPop(codeObj,nameObj,'Y');
          
     }else if( evnflag == "NAME" ){
         result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1);
             getPbnInf();
     }

     if( result != null ){         
    	 getPbnInf();
    	 //getPbnStk();
    	 strSkuType = result.get("SKU_TYPE");  
    	 getcolumnSetting(strSkuType);
     }
     //EM_O_PUMBUN_CD.Focus();
 } 
 
 /**
  * getPbnStk()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 브랜드에 따른 재고실사 조회
  * return값 : void
  */
 function getPbnStk() {
	 
      var strStrCd       = LC_O_STR_CD.BindColVal;
      var strPumbunCd    = EM_O_PUMBUN_CD.Text;           
      var strStkYm       = EM_O_STK_YM.Text;              
      
      var goTo       = "searchPbnStk" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strStkYm="+encodeURIComponent(strStkYm);
      
      TR_PBN.Action="/dps/pstk205.pt?goTo="+goTo+parameters;  
      TR_PBN.KeyValue="SERVLET("+action+":DS_O_PBNSTK=DS_O_PBNSTK)"; //조회는 O
      TR_PBN.Post();     
      
      EM_O_STK_DT.Text = DS_O_PBNSTK.NameValue(1, "SRVY_DT");
      EM_O_STK_FLAG.Text = DS_O_PBNSTK.NameValue(1, "STK_FLAG_NAME"); 
      EM_O_STATE.Text = DS_O_PBNSTK.NameValue(1, "CLOSE_DT");
      
     //return DS_O_MARGIN.NameValue(1, "LOW_MG_RATE");
 }
 
 /**
  * getPbnInf()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 브랜드정보(조직) 조회
  * return값 : void
  */
 function getPbnInf() {
      var strStrCd       = LC_O_STR_CD.BindColVal;
      var strPumbunCd    = EM_O_PUMBUN_CD.Text;       
      
      var goTo       = "searchPbnInf" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strPumbunCd="+encodeURIComponent(strPumbunCd);
      
      TR_MAIN.Action="/dps/pstk205.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_O_PBNINF=DS_O_PBNINF)"; //조회는 O
      TR_MAIN.Post();     
      
      EM_O_ORG_NAME.Text = DS_O_PBNINF.NameValue(1, "ORG_NAME");   
 }

 /**
  * getSkuPop()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.03.28
  * 개    요 :  단품GridPopup
  * return값 : void
  */
  function getSkuPop(row, colid , popFlag){   
    var strSkuCd  = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SKU_CD"); //단품코드  
    var strPumbunCd  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PUMBUN_CD");
    var strSkuNm  ="";  
    var strStrCd  = LC_O_STR_CD.BindColVal; //단품코드
    
    if(popFlag != "1"){        
        var rtnMap = setStrSkuNmWithoutToGridPop("DS_O_RESULT", strSkuCd, strSkuNm , 'Y' , '1','',strStrCd, strPumbunCd,'','','','','','','','','');
        if(rtnMap != null){
        	DS_IO_DETAIL.NameValue(row, "SKU_CD")         = rtnMap.get("SKU_CD");
            strSkuCd  = DS_IO_DETAIL.NameValue(row, "SKU_CD");
        	searchSkuCd(strSkuCd , strPumbunCd, row);      
        }       
    }else{
        if (popFlag =="1"){   
            var rtnMap = strSkuToGridPop(strSkuCd , strSkuNm,'Y','',strStrCd, strPumbunCd,'','','','','','','','','');
            if(rtnMap != null){ 
            	DS_IO_DETAIL.NameValue(row, "SKU_CD")         = rtnMap.get("SKU_CD");
            	strSkuCd  = DS_IO_DETAIL.NameValue(row, "SKU_CD");
            }
        }
    }    
        
 }
 
 /**
  * searchSkuCd()
  * 작 성 자 : 
  * 작 성 일 : 2010.04.12
  * 개     요 : 단품코드 조회
  * return값 : void
  */
 function searchSkuCd(strSkuCd , strPumbunCd , row) {
	  var strStkDt    = EM_O_STK_DT.Text;
	  var strStrCd   = LC_O_STR_CD.BindColVal;
      var goTo       = "searchSkuCd" ;    
      var action     = "O"; 
      var parameters = "&strSkuCd="+encodeURIComponent(strSkuCd)
                      +"&strPumbunCd="+encodeURIComponent(strPumbunCdF)
                      +"&strStkDt="+encodeURIComponent(strStkDt)
                      +"&strStrCd="+encodeURIComponent(strStrCd);
      
      TR_MAIN.Action="/dps/pstk205.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_SKUCD=DS_IO_SKUCD)"; //조회는 O
      TR_MAIN.Post();
      
      if (DS_IO_SKUCD.CountRow > 0){
    	  DS_IO_DETAIL.NameValue(row, "SKU_CD")         = DS_IO_SKUCD.NameValue(1, "SKU_CD");
          DS_IO_DETAIL.NameValue(row, "SKU_NAME")       = DS_IO_SKUCD.NameValue(1, "SKU_NAME");
          DS_IO_DETAIL.NameValue(row, "STYLE_CD")       = DS_IO_SKUCD.NameValue(1, "STYLE_CD");
          DS_IO_DETAIL.NameValue(row, "STYLE_NAME")     = DS_IO_SKUCD.NameValue(1, "STYLE_NAME");
          DS_IO_DETAIL.NameValue(row, "COLOR_CD")       = DS_IO_SKUCD.NameValue(1, "COLOR_CD");
          DS_IO_DETAIL.NameValue(row, "SIZE_CD")        = DS_IO_SKUCD.NameValue(1, "SIZE_CD");          
          DS_IO_DETAIL.NameValue(row, "INPUT_PLU_CD")   = DS_IO_SKUCD.NameValue(1, "INPUT_PLU_CD");
          DS_IO_DETAIL.NameValue(row, "SALE_UNIT_CD")   = DS_IO_SKUCD.NameValue(1, "SALE_UNIT_CD");
          DS_IO_DETAIL.NameValue(row, "CMP_SPEC_UNIT")  = DS_IO_SKUCD.NameValue(1, "CMP_SPEC_UNIT");
          DS_IO_DETAIL.NameValue(row, "BUY_SALE_PRC")   = DS_IO_SKUCD.NameValue(1, "BUY_SALE_PRC");
          DS_IO_DETAIL.NameValue(row, "BUY_COST_PRC")   = DS_IO_SKUCD.NameValue(1, "BUY_COST_PRC");
          DS_IO_DETAIL.NameValue(row, "PUMMOK_CD")      = DS_IO_SKUCD.NameValue(1, "PUMMOK_CD"); 
      }
         
 }
 
 /**
  * getcolumnSetting()
  * 작 성 자 : 
  * 작 성 일 : 2010.04.12
  * 개     요 : 단품구분에 따라 컬럼 셋팅
  * return값 : void
  */
 function getcolumnSetting(skuType) {
	  //DS_IO_MASTER.ClearData();
	  //DS_IO_DETAIL.ClearData();
	  if (skuType == "1"){
		  GD_DETAIL.ColumnProp('STYLE_NAME','show')= "FALSE";
		  GD_DETAIL.ColumnProp('COLOR_CD','show')= "FALSE";
		  GD_DETAIL.ColumnProp('SIZE_CD','show')= "FALSE";
		  GD_DETAIL.ColumnProp('INPUT_PLU_CD','show')= "TRUE";
		  GD_DETAIL.ColumnProp('SALE_UNIT_CD','show')= "TRUE";
		  GD_DETAIL.ColumnProp('CMP_SPEC_UNIT','show')= "TRUE";
	  }else if (skuType == "2"){
		  GD_DETAIL.ColumnProp('STYLE_NAME','show')= "FALSE";
		  GD_DETAIL.ColumnProp('COLOR_CD','show')= "FALSE";
		  GD_DETAIL.ColumnProp('SIZE_CD','show')= "FALSE";
		  GD_DETAIL.ColumnProp('INPUT_PLU_CD','show')= "FALSE";
		  GD_DETAIL.ColumnProp('SALE_UNIT_CD','show')= "TRUE";
		  GD_DETAIL.ColumnProp('CMP_SPEC_UNIT','show')= "FALSE";
	  }else if (skuType == "3"){
		  GD_DETAIL.ColumnProp('STYLE_NAME','show')= "TRUE";
		  GD_DETAIL.ColumnProp('COLOR_CD','show')= "TRUE";
		  GD_DETAIL.ColumnProp('SIZE_CD','show')= "TRUE";
		  GD_DETAIL.ColumnProp('INPUT_PLU_CD','show')= "FALSE";
		  GD_DETAIL.ColumnProp('SALE_UNIT_CD','show')= "FALSE";
		  GD_DETAIL.ColumnProp('CMP_SPEC_UNIT','show')= "FALSE";
	  }	 
 }
 
 /**
  * srvyDtValidation()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-14
  * 개    요 : 실사종료일자에 따라 그리드 Edit 설정을 한다.
  * return값 : void
 **/
 function gridEditable(){
	  
      getPbnStk();
     var srvyEDt  = DS_O_PBNSTK.NameValue(1, "SRVY_E_DT");    
     var strToDay = DS_O_PBNSTK.NameValue(1, "TODAY_DT"); 
     
     
     if (srvyEDt < strToDay){    	 
         GD_DETAIL.Editable = "false";          
     }else{
         GD_DETAIL.Editable = "true";          
     }
    
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

<script language=JavaScript for=TR_PBN event=onSuccess>
    for(i=0;i<TR_PBN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_PBN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>

<script language=JavaScript for=TR_PBN event=onFail>
    trFailed(TR_PBN.ErrorMsg);
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
    if( row > 0 ) { 
        searchDetail();
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 적용기준일 -->
<script language=JavaScript for=EM_O_STK_YM event=onKillFocus()>
    if(!checkDateTypeYM(this))
        return;
    getPbnStk();
</script>

<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,oldData)>
    switch (colid) {
    case "NORM_QTY" :
        var buyCostPrc = DS_IO_DETAIL.NameValue(row, "BUY_COST_PRC");
        var buySalePrc = DS_IO_DETAIL.NameValue(row, "BUY_SALE_PRC");
        var normQty = DS_IO_DETAIL.NameValue(row, "NORM_QTY");
        var infrrQty = DS_IO_DETAIL.NameValue(row, "INFRR_QTY"); 
        
        var orgNormQty = DS_IO_DETAIL.OrgNameValue(row, "NORM_QTY");
        var orgInfrrQty = DS_IO_DETAIL.OrgNameValue(row, "INFRR_QTY");
        
        if(normQty == orgNormQty && infrrQty == orgInfrrQty){
        	return;
        }
        
        DS_IO_DETAIL.NameValue(row, "NORM_AMT") = buySalePrc*normQty;
        DS_IO_DETAIL.NameValue(row, "SRVY_QTY") = normQty+infrrQty;
        
        var srvyQty = DS_IO_DETAIL.NameValue(row, "SRVY_QTY");
        DS_IO_DETAIL.NameValue(row, "SRVY_QTY_AMT") = buySalePrc*srvyQty; 
        DS_IO_DETAIL.NameValue(row, "SRVY_COST_AMT") = buySalePrc*srvyQty;
        DS_IO_DETAIL.NameValue(row, "SRVY_SALE_AMT") = buyCostPrc*srvyQty;
    break;
    case "INFRR_QTY" :
        var buyCostPrc = DS_IO_DETAIL.NameValue(row, "BUY_COST_PRC");
        var buySalePrc = DS_IO_DETAIL.NameValue(row, "BUY_SALE_PRC");
        var normQty = DS_IO_DETAIL.NameValue(row, "NORM_QTY");
        var infrrQty = DS_IO_DETAIL.NameValue(row, "INFRR_QTY");
        
        if(normQty == orgNormQty && infrrQty == orgInfrrQty){
            return;
        }        
        
        DS_IO_DETAIL.NameValue(row, "INFRR_AMT") = buySalePrc*infrrQty;
        DS_IO_DETAIL.NameValue(row, "SRVY_QTY") = normQty+infrrQty;        
        
        var srvyQty = DS_IO_DETAIL.NameValue(row, "SRVY_QTY");
        DS_IO_DETAIL.NameValue(row, "SRVY_QTY_AMT") = buySalePrc*srvyQty;
        DS_IO_DETAIL.NameValue(row, "SRVY_COST_AMT") = buySalePrc*srvyQty;
        DS_IO_DETAIL.NameValue(row, "SRVY_SALE_AMT") = buyCostPrc*srvyQty;
        
    break;
    }
</script>

<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
//var orgValue = DS_IO_DETAIL.OrgNameValue(row,colid);
//var newValue = DS_IO_DETAIL.NameValue(row,colid);
//var changeFlag = (orgValue != newValue || DS_IO_DETAIL.RowStatus(row) == 1) ;
    /**
    switch (colid) {
        case "SKU_CD" :        	
        	var popupData = strSkuToGridPop(data, '', 'Y');
            if(popupData != null){
                eval(this.DataID).NameValue(row,"SKU_CD") = popupData.get("SKU_CD");
                eval(this.DataID).NameValue(row,"SKU_NAME") = popupData.get("SKU_NAME");               
            } else {
                eval(this.DataID).NameValue(row,"SKU_CD") = "";
                eval(this.DataID).NameValue(row,"SKU_NAME") = "";
                strPummokCd = popupData.get("PUMMOK_CD");
        }
        break;   
    }
    */
    var pumbunCd = DS_IO_DETAIL.NameValue(row, "PUMBUN_CD");
    if (pumbunCd != ""){
        if (colid == "SKU_CD" && pumbunCd != ""){         
            getSkuPop(row , colid , '1');
        }
    }else{
          showMessage(EXCLAMATION, OK, "USER-1045" , "브랜드정보");
          setFocusGrid(GD_MASTER,DS_IO_MASTER, row ,"PUMBUN_CD");
          return false;
    } 
</script>
<script language=JavaScript for=GD_DETAIL event=CanColumnPosChange(row,colid)>

    //var orgValue = DS_IO_MASTER.OrgNameValue(row,colid);
    //var newValue = DS_IO_MASTER.NameValue(row,colid);
    //var changeFlag = (orgValue != newValue || DS_IO_MASTER.RowStatus(row) == 1) ;
    var pumbunCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");
    
    if(row < 1 )
        return true;
    
    if (pumbunCd != ""){
        if (colid == "SKU_CD" && pumbunCd != ""){         
            getSkuPop(row , colid , '');
        }
    }else{
        showMessage(EXCLAMATION, OK, "USER-1045" , "브랜드정보");
        setFocusGrid(GD_MASTER,DS_IO_MASTER, row ,"PUMBUN_CD");
        return false;
    } 
   
    
</script>

<!-- 브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setPumbunCdSkuType("NAME");
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    if( row < 1 || bfMasterRowPos == row)
         return;
    bfMasterRowPos = row;
    searchDetail();
</script>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- Grid Detail oneClick event 처리 -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
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
<object id="DS_O_PBNINF" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="DS_IO_SKUCD" classid=<%= Util.CLSID_DATASET %>></object>
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

<comment id="_NSID_">
<object id="TR_PBN" classid=<%=Util.CLSID_TRANSACTION%>>
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
            <th class="point" width="80">실사년월</th>
            <td width="166">
                <comment id="_NSID_">
                      <object id=EM_O_STK_YM classid=<%=Util.CLSID_EMEDIT%>  width=138 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('M',EM_O_STK_YM)" align="absmiddle" /></td>
            </td>
            <th width="80">브랜드</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=55 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPumbunCdSkuType('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=85 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
            </td>
          </tr>
          <tr>
            <th width="80">조직명</th>
            <td colspan="5">
                <comment id="_NSID_">
                      <object id=EM_O_ORG_NAME classid=<%=Util.CLSID_EMEDIT%>  width=425 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
            </td>            
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
          <td width="165">
              <comment id="_NSID_">
                    <object id=EM_O_STK_FLAG classid=<%=Util.CLSID_EMEDIT%>  width=157 tabindex=1>
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
  <tr valign="top">
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="300">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"><object id=GD_MASTER
                            width=100% height=449 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_MASTER">
                        </object></comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
                <td class="PL10">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"><object id=GD_DETAIL
                            width=100% height=449 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_DETAIL">
                            <Param Name="ViewSummary"   value="1" >
                        </object></comment><script>_ws_(_NSID_);</script></td>
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

</body>
</html>

