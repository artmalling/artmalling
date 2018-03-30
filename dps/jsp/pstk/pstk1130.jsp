<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> 장부재고조회(규격/신선)
 * 작 성 일 : 2010.05.13
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk113.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 규격/신선 단품별 장부재고 현황을 조회 할 수 있다.
 * 이    력 :
 *        2010.05.13 (이재득) 작성
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

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
//엑셀 다운을 위한 조회조건 전역 선언
 var excelStrCd;
 var excelStkDt;
 var excelMakerCd;
 var excelPumbunCd;
 var excelPummokCd;
 var excelSkuCd;
 
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

var top = 140;		//해당화면의 동적그리드top위치

function doInit(){
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화( gauce.js )    i
    initEmEdit(EM_O_STK_DT,      "TODAY"    , PK);     //일자    
    initEmEdit(RD_SLIP_FLAG,     "GEN"      , PK);     // 전표구분 
    initEmEdit(EM_O_MAKER_CD,    "CODE^6^0" , NORMAL); //메이커코드
    initEmEdit(EM_O_MAKER_NAME,  "GEN^40"   , READ);   //메이커명
    initEmEdit(EM_O_PUMBUN_CD,   "CODE^6^0" , NORMAL); //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME, "GEN^40"   , READ);   //브랜드명
    initEmEdit(EM_O_PUMMOK_CD,   "CODE^8^0" , NORMAL); //품목코드
    initEmEdit(EM_O_PUMMOK_NAME, "GEN^40"   , READ);   //품목명
    initEmEdit(EM_O_SKU_CD,      "CODE^54^0", NORMAL); //단품코드
    initEmEdit(EM_O_SKU_NAME,    "GEN^40"   , READ);   //단품명
    initEmEdit(EM_O_ORG_NAME,    "GEN^40"   , READ);   //조직명
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회)
    
    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N"); 
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js ) 
    getEtcCode("DS_I_SALE_UNIT_CD", "D", "P013", "N");    //판매단위
    getEtcCode("DS_I_CMP_SPEC_UNIT", "D", "P013", "N");   //구성규격단위
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"               width=30     align=center   edit=none  sumtext="" SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=PUMBUN_CD        name="브랜드코드"          width=65     align=center  edit=none  SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=PUMBUN_NAME      name="브랜드명"            width=100    align=left    edit=none   SubSumText={decode(curlevel,1,"",2,"브랜드소계")}   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
    	             + '<FC>id=PUMMOK_CD        name="품목코드"          width=65     align=center  edit=none  SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=PUMMOK_NAME      name="품목명"            width=100    align=left    edit=none   SubSumText={decode(curlevel,2,"",1,"품목소계")}   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SKU_CD           name="단품코드"          width=110     align=center  edit=none  SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SKU_NAME         name="단품명"            width=140    align=left    edit=none   SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>' 
                     + '<FG> name="기초재고" '
                     + '<FC>id=BASE_QTY         name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=BASE_AMT         name="금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> '  
                     + '<FG> name="매출" '
                     + '<FC>id=SALE_1QTY         name="1월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_1AMT    name="1월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_2QTY         name="2월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_2AMT    name="2월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_3QTY         name="3월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_3AMT    name="3월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_4QTY         name="4월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_4AMT    name="4월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_5QTY         name="5월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_5AMT    name="5월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_6QTY         name="6월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_6AMT    name="6월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_7QTY         name="7월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_7AMT    name="7월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_8QTY         name="8월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_8AMT    name="8월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_9QTY         name="9월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_9AMT    name="9월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_10QTY         name="10월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_10AMT    name="10월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_11QTY         name="11월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_11AMT    name="11월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_12QTY         name="12월수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_12AMT    name="12월금액"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_13QTY         name="수량합계"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_13AMT    name="금액합계"              width=90     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> '
                     + '<FC>id=INPUT_PLU_CD     name="소스마킹"          width=100    align=left   edit=none   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'                     
                     + '<FC>id=SALE_UNIT_CD     name="판매단위"          width=60     align=left   edit=none   EditStyle=Lookup   Data="DS_I_SALE_UNIT_CD:CODE:NAME"   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}  </FC>'
                     + '<FC>id=CMP_SPEC_UNIT    name="구성단위"          width=60     align=left   edit=none   EditStyle=Lookup   Data="DS_I_CMP_SPEC_UNIT:CODE:NAME"    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}  </FC>'; 
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
                     
    GD_MASTER.ViewSummary = "1";
    DS_IO_MASTER.SubSumExpr  = "2:PUMBUN_CD, 1:PUMMOK_CD" ; 
    GD_MASTER.ColumnProp("PUMMOK_NAME", "sumtext")        = "합계";
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
 * 작 성 일 : 2010.05.12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
    if( LC_O_STR_CD.BindColVal == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "점");            
        LC_O_STR_CD.Focus();
        return false;
    }else if( EM_O_STK_DT.Text == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "일자");            
        EM_O_STK_DT.Focus();
        return false;
    }
    
    DS_IO_MASTER.ClearData();
    
    var strStrCd      = LC_O_STR_CD.BindColVal;  
    var strStkEDt     = EM_O_STK_DT.Text;
    var strMakerCd    = EM_O_MAKER_CD.Text;
    var strPumbunCd   = EM_O_PUMBUN_CD.Text;
    var strPummokCd   = EM_O_PUMMOK_CD.Text;
    var strSkuCd      = EM_O_SKU_CD.Text;
    var strSkuFlag = RD_SLIP_FLAG.CodeValue;
    var strSkuType  = "";

    if(strSkuFlag == "A"){
        strSkuType = "1";
    }else if(strSkuFlag == "B"){
        strSkuType = "2"
    }
    
    var strStkYm      = strStkEDt.substring(0, 4);
    var strStkSDt     = strStkEDt.substring(0, 6) + "01";
    
    setSearchValue2Excel();
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strStkSDt="+encodeURIComponent(strStkSDt)
                    +"&strStkEDt="+encodeURIComponent(strStkEDt)
                    +"&strStkYm="+encodeURIComponent(strStkYm)
                    +"&strMakerCd="+encodeURIComponent(strMakerCd)
                    +"&strPumbunCd="+encodeURIComponent(strPumbunCd)
                    +"&strPummokCd="+encodeURIComponent(strPummokCd)
                    +"&strSkuCd="+encodeURIComponent(strSkuCd)
                    +"&strSkuType="+encodeURIComponent(strSkuType);   
    
    TR_MAIN.Action="/dps/pstk113.pt?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT", GD_MASTER);     
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     
 }
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {  
    
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {    
     
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 
	var parameters = "점="+nvl(excelStrCd,'전체')  
                   + " -일자="+nvl(excelStkDt,'전체')
                   + " -MAKER="+nvl(excelMakerCd,'전체')
                   + " -브랜드="+nvl(excelPumbunCd,'전체')
                   + " -품목="+nvl(excelPummokCd,'전체')
                   + " -단품="+nvl(excelSkuCd,'전체');
		
    openExcel2(GD_MASTER, "장부재고조회(월)", parameters, true );
    GD_MASTER.Focus();
    
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
 /**
  * setSearchValue2Excel()
  * 작 성 자 : 
  * 작 성 일 : 2010.05.12
  * 개    요 : 엑셀다운시 조회조건 입력을 위한 값 바인드
  * return값 : void
  */
 function setSearchValue2Excel(){
     excelStrCd    = LC_O_STR_CD.Text;
     excelStkDt    = EM_O_STK_DT.Text;
     excelMakerCd  = EM_O_MAKER_CD.Text;
     excelPumbunCd = EM_O_PUMBUN_CD.Text;
     excelPummokCd = EM_O_PUMMOK_CD.Text;
     excelSkuCd    = EM_O_SKU_CD.Text;
 }
 
 /**
  * setPumbunCdPopup()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.05.12
  * 개    요 : 브랜드POPUP를 조회한다.
  * return값 : void
  */
 function setPumbunCdPopup(evnflag){
     var codeObj     = EM_O_PUMBUN_CD;
     var nameObj     = EM_O_PUMBUN_NAME;
     var strSkuFlag = RD_SLIP_FLAG.CodeValue;
     var strSkuType  = "";
     
     if(codeObj.Text == "" && evnflag != "POP" ){
         nameObj.Text = "";
         EM_O_ORG_NAME.Text = "";
         return;
     }
     
     if(strSkuFlag == "A"){
    	 strSkuType = "1";
     }else if(strSkuFlag == "B"){
    	 strSkuType = "2"
     }

     var result = null;

     if( evnflag == "POP" ){
         result = strPbnPop(codeObj,nameObj,'Y','','','','','','','','',strSkuType);
          
     }else if( evnflag == "NAME" ){
         setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,'Y',1,'','','','','','','','',strSkuType);
         getPbnInf();
     }
     
     if(result != null){
    	 getPbnInf();
     }
 } 

 /**
  * setPummokCdPopup()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.05.12
  * 개    요 : 품목POPUP를 조회한다.
  * return값 : void
  */
 function setPummokCdPopup(evnflag){
     var codeObj = EM_O_PUMMOK_CD;
     var nameObj = EM_O_PUMMOK_NAME;
     var strSkuFlag     = RD_SLIP_FLAG.CodeValue;
     var strFreshYn = "";
     
     if(codeObj.Text == "" && evnflag != "POP" ){ 
    	 nameObj.Text = "";
         return;
     }         
     
     if(strSkuFlag == "A"){
    	 strFreshYn = "Y";
     }else if(strSkuFlag == "B"){
    	 strFreshYn = "N"
     }
     
     var result = null;
     
     if(EM_O_PUMBUN_CD.Text == "" && EM_O_PUMBUN_NAME.Text == ""){
    	 if( evnflag == "POP" ){
             result = pummokPop(codeObj,nameObj, strFreshYn);
              
         }else if( evnflag == "NAME" ){
        	 setPummokNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 1 , strFreshYn);         
         }
     }else{
    	 if( evnflag == "POP" ){
             result = pbnPmkPop(codeObj,nameObj, EM_O_PUMBUN_CD.Text);
              
         }else if( evnflag == "NAME" ){
             setPbnPmkNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, EM_O_PUMBUN_CD.Text, 1);         
         }           
     }
 } 
 
 /**
  * setSkuCdPopup()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.05.12
  * 개    요 : 단품POPUP를 조회한다.
  * return값 : void
  */
 function setSkuCdPopup(evnflag){
     var codeObj = EM_O_SKU_CD;
     var nameObj = EM_O_SKU_NAME;
     
     if(codeObj.Text == "" && evnflag != "POP" ){ 
         nameObj.Text = "";
         return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = strSkuPop(codeObj,nameObj, 'Y', '' , '' , EM_O_PUMBUN_CD.Text );
          
     }else if( evnflag == "NAME" ){
    	 setStrSkuNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 'Y', 1 , '' , '' , EM_O_PUMBUN_CD.Text);         
     }
 } 
 
 /**
  * setCommonPop()
  * 작 성 자 : 
  * 작 성 일 : 2010-03-10
  * 개    요 : 공통코드/명을 등록한다.
  * return값 : void
  */
 function setIndiCommonPop(evnflag){
	 var codeObj = EM_O_MAKER_CD;
	 var nameObj = EM_O_MAKER_NAME;

     if(codeObj.Text == "" && evnflag != "POP" ){
         nameObj.Text = "";
         return;
     }
     
     var strtitle = "MAKER";
     
     if( evnflag == "POP" ){
         commonPop(strtitle,'SEL_COMM_CODE_ONLY',codeObj ,nameObj,"D","P019");
         codeObj.Focus();
         return;
     }

     nameObj.Text = "";
     setNmWithoutPop('DS_SEARCH_NM',strtitle,'SEL_COMM_CODE_ONLY',codeObj ,nameObj,"D","P019");
     
     if( DS_SEARCH_NM.CountRow == 1){
         codeObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
         nameObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
         return;
     }else{
         nameObj.Text = "";
     }
     
     commonPop(strtitle,'SEL_COMM_CODE_ONLY',codeObj ,nameObj,"D","P019");
     codeObj.Focus();
 }
 
 /**
  * getPbnInf()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 브랜드정보(조직명) 조회
  * return값 : void
  */
 function getPbnInf() {
      var strStrCd       = LC_O_STR_CD.BindColVal;
      var strPumbunCd    = EM_O_PUMBUN_CD.Text;       
      
      var goTo       = "searchPbnInf" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strPumbunCd="+encodeURIComponent(strPumbunCd);
      
      TR_MAIN.Action="/dps/pstk111.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_O_PBNINF=DS_O_PBNINF)"; //조회는 O
      TR_MAIN.Post();     
      
      EM_O_ORG_NAME.Text = DS_O_PBNINF.NameValue(1, "ORG_NAME");   
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
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. Excelupload  --------------------------------------->

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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 적용기준일 -->
<script language=JavaScript for=EM_O_STK_DT event=onKillFocus()>
    if(!checkDateTypeYMD(this))
        return;    
</script>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>

</script>

<!-- SKU코드 변경시 -->
<script language=JavaScript for=EM_O_MAKER_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setIndiCommonPop("NAME");
</script>

<!-- 브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setPumbunCdPopup("NAME");
</script>

<!-- 품목코드 변경시 -->
<script language=JavaScript for=EM_O_PUMMOK_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setPummokCdPopup("NAME");
</script>

<!-- SKU코드 변경시 -->
<script language=JavaScript for=EM_O_SKU_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setSkuCdPopup("NAME");
</script>

<!-- RD_SLIP_FLAG oneClick event 처리 -->
<script language=JavaScript for=RD_SLIP_FLAG event=OnSelChange()>
    var strSkuFlag     = RD_SLIP_FLAG.CodeValue;
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
    
    if(strSkuFlag == "A"){
    	GD_MASTER.ColumnProp('INPUT_PLU_CD','show')= "TRUE";
        GD_MASTER.ColumnProp('SALE_UNIT_CD','show')= "TRUE";
        GD_MASTER.ColumnProp('CMP_SPEC_UNIT','show')= "TRUE";
    }else if(strSkuFlag == "B"){
    	GD_MASTER.ColumnProp('INPUT_PLU_CD','show')= "FALSE";
        GD_MASTER.ColumnProp('SALE_UNIT_CD','show')= "TRUE";
        GD_MASTER.ColumnProp('CMP_SPEC_UNIT','show')= "FALSE";
    }
</script>

<!-- Grid Master oneClick event 처리 -->
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
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
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
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
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
            <th class="point" width="50">점</th>
            <td width="200">
                 <comment id="_NSID_">
                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=210 tabindex=1 align="absmiddle">
                    </object>
                </comment><script>_ws_(_NSID_);</script>
            </td> 
            <th class="point" width="50">일자</th>
            <td width="200">
                <comment id="_NSID_">
                      <object id=EM_O_STK_DT classid=<%=Util.CLSID_EMEDIT%>  width=175 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('G',EM_O_STK_DT)" align="absmiddle" />
            </td>
            <th class="point" width="50">단품구분</th>
            <td>
                <comment id="_NSID_">
                    <object id=RD_SLIP_FLAG classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:180">
                    <param name=Cols    value="2">
                    <param name=Format  value="A^규격,B^신선">
                    <param name=CodeValue  value="A">
                    </object>  
                </comment><script> _ws_(_NSID_);</script>  <font color = "red"> * 설정된 일자의 연도로 검색 됩니다.</font>
            </td> 
          </tr>
          <tr>
            <th width="50">MAKER</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_MAKER_CD classid=<%=Util.CLSID_EMEDIT%>  width=55 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setIndiCommonPop('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_MAKER_NAME classid=<%=Util.CLSID_EMEDIT%>  width=125 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
            </td>
            <th width="50">브랜드</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=55 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPumbunCdPopup('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=115 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
            </td>
            <th width="50">품목</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_PUMMOK_CD classid=<%=Util.CLSID_EMEDIT%>  width=60 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPummokCdPopup('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMMOK_NAME classid=<%=Util.CLSID_EMEDIT%>  width=95 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
            </td>
          </tr>
          <tr>
            <th width="50">단품</th>
            <td colspan="3">
                <comment id="_NSID_">
                      <object id=EM_O_SKU_CD classid=<%=Util.CLSID_EMEDIT%>  width=190 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setSkuCdPopup('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_SKU_NAME classid=<%=Util.CLSID_EMEDIT%>  width=260 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
            </td>
            <th width="50">조직명</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_ORG_NAME classid=<%=Util.CLSID_EMEDIT%>  width=180 tabindex=1>
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
     <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
            <tr>
                <td>
                    <comment id="_NSID_">
                        <OBJECT id=GD_MASTER width=100% height=455 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_MASTER">
                        </OBJECT>
                    </comment><script>_ws_(_NSID_);</script>
                </td>
            </tr>
        </table>
     </td>
  </tr>  
</table>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

