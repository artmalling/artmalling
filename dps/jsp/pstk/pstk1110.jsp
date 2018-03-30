<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> 장부재고조회(의류잡화)
 * 작 성 일 : 2010.05.13
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk111.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 의류잡화 단품별 장부재고 현황을 조회 할 수 있다.
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
<%
	String dir = BaseProperty.get("context.common.dir");
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
//엑셀 다운을 위한 조회조건 전역 선언
 var excelStrCd;
 var excelStkDt;
 var excelPumbunCd;
 var excelPummokCd;
 var excelStyleCd;
 
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

var top = 140;		//해당화면의 동적그리드top위치
var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화( gauce.js )    i
    initEmEdit(EM_O_STK_DT,      "TODAY",     PK);     //일자    
    initEmEdit(EM_O_PUMBUN_CD,   "CODE^6^0",  PK);     //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME, "GEN^40",    READ);   //브랜드명
    initEmEdit(EM_O_PUMMOK_CD,   "CODE^8^0",  NORMAL); //품목코드
    initEmEdit(EM_O_PUMMOK_NAME, "GEN^40",    READ);   //품목명
    initEmEdit(EM_O_STYLE_CD,    "CODE^54^0", NORMAL); //STYLE코드
    initEmEdit(EM_O_STYLE_NAME,  "GEN^40",    READ);   //STYLE명
    initEmEdit(EM_O_ORG_NAME,    "GEN^40",    READ);   //조직명
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회)
    
    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N"); 
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js ) 
    getEtcCode("DS_I_COLOR_CD", "D", "P062", "N");        //칼라  
    getEtcCode("DS_I_SIZE_CD", "D", "P026", "N");         //사이즈
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"               width=30     align=center   edit=none  sumtext="" SubSumText=""  SubBgColor=#FFFFE0</FC>'
    	             + '<FC>id=PUMMOK_CD        name="품목코드"          width=80     align=center  edit=none  SubSumText=""  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=PUMMOK_NAME      name="품목명"            width=100    align=left    edit=none   SubSumText="품목계"   SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=SKU_CD           name="단품코드"          width=110     align=center  edit=none  SubSumText=""  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=SKU_NAME         name="단품명"            width=140    align=left    edit=none   SubSumText=""  SubBgColor=#FFFFE0</FC>' 
                     + '<FG> name="기초재고" '
                     + '<FC>id=BASE_QTY         name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=BASE_AMT         name="금액"              width=110     align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '</FG> ' 
                     + '<FG> name="매입" '
                     + '<FC>id=BUY_TOT_QTY      name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=BUY_TOT_SALE_AMT name="금액"              width=110     align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '</FG> ' 
                     + '<FG> name="매출" '
                     + '<FC>id=SALE_QTY         name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=SALE_SALE_AMT    name="금액"              width=110     align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '</FG> '
                     + '<FG> name="재고조정" '
                     + '<FC>id=STK_ADJ_QTY      name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=STK_ADJ_SALE_AMT name="금액"              width=110    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '</FG> '
                     + '<FG> name="기말재고" '
                     + '<FC>id=SRVY_E_QTY       name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=SRVY_E_AMT       name="금액"              width=110    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '</FG> '
                     + '<FC>id=STYLE_CD         name="STYLE코드"         width=50     align=center edit=none   SubBgColor=#FFFFE0  show="false"</FC>'
                     + '<FC>id=STYLE_NAME       name="STYLE명"           width=100    align=left   edit=none   SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=COLOR_CD         name="칼라명"            width=80     align=left   edit=none   EditStyle=Lookup   Data="DS_I_COLOR_CD:CODE:NAME"   SubBgColor=#FFFFE0  </FC>'
                     + '<FC>id=SIZE_CD          name="사이즈"            width=60     align=left   edit=none   EditStyle=Lookup   Data="DS_I_SIZE_CD:CODE:NAME"    SubBgColor=#FFFFE0  </FC>'; 
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
                     
    GD_MASTER.ViewSummary = "1";
    DS_IO_MASTER.SubSumExpr  = "PUMMOK_CD" ; 
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
    }else if( EM_O_PUMBUN_CD.Text == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "브랜드");            
        EM_O_PUMBUN_CD.Focus();
        return false;
    }else if( EM_O_PUMBUN_NAME.Text == "" ){
        showMessage(EXCLAMATION , Ok,  "USER-1069", "브랜드");            
        EM_O_PUMBUN_CD.Focus();
        return false;
    }
    
    DS_IO_MASTER.ClearData();
    
    var strStrCd      = LC_O_STR_CD.BindColVal;  
    var strStkEDt     = EM_O_STK_DT.Text;
    var strPumbunCd   = EM_O_PUMBUN_CD.Text;
    var strPummokCd   = EM_O_PUMMOK_CD.Text;
    var strStyleCd    = EM_O_STYLE_CD.Text;
    
    var strStkYm      = strStkEDt.substring(0, 6);
    var strStkSDt     = strStkEDt.substring(0, 6) + "01";
    
    setSearchValue2Excel();
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strStkSDt="+encodeURIComponent(strStkSDt)
                    +"&strStkEDt="+encodeURIComponent(strStkEDt)
                    +"&strStkYm="+encodeURIComponent(strStkYm)
                    +"&strPumbunCd="+encodeURIComponent(strPumbunCd)
                    +"&strPummokCd="+encodeURIComponent(strPummokCd)
                    +"&strStyleCd="+encodeURIComponent(strStyleCd);   
    
    TR_MAIN.Action="/dps/pstk111.pt?goTo="+goTo+parameters;  
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
                   + " -브랜드="+nvl(excelPumbunCd,'전체')
                   + " -품목="+nvl(excelPummokCd,'전체')
                   + " -STYLE="+nvl(excelStyleCd,'전체');
	
	//openExcel3(GD_MASTER, GD_DETAIL, "조직별장부재고조회", "adfadsfa", "스타일 #가가가가#");
    //openExcel2(GD_MASTER, "장부재고조회(의류잡화)", parameters, true );
    openExcel5(GD_MASTER, "장부재고조회(의류잡화)", parameters, true , "",g_strPid );

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
     excelPumbunCd = EM_O_PUMBUN_CD.Text;
     excelPummokCd = EM_O_PUMMOK_CD.Text;
     excelStyleCd  = EM_O_STYLE_CD.Text;
 }
 
 /**
  * setPumbunCdPopup()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.05.12
  * 개    요 : 브랜드POPUP를 조회한다.
  * return값 : void
  */
 function setPumbunCdPopup(evnflag){
     var codeObj = EM_O_PUMBUN_CD;
     var nameObj = EM_O_PUMBUN_NAME;
     
     if(codeObj.Text == "" && evnflag != "POP" ){
         nameObj.Text = "";
         EM_O_ORG_NAME.Text = "";
         return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = strPbnPop(codeObj,nameObj,'Y','','','','','','','','','3');
          
     }else if( evnflag == "NAME" ){
         setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,'Y',1,'','','','','','','','','3');
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
     
     if(codeObj.Text == "" && evnflag != "POP" ){ 
    	 nameObj.Text = "";
         return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = pbnPmkPop(codeObj,nameObj, EM_O_PUMBUN_CD.Text);
          
     }else if( evnflag == "NAME" ){
    	 setPbnPmkNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, EM_O_PUMBUN_CD.Text, 1);         
     }
 } 
 
 /**
  * setStyleCdPopup()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.05.12
  * 개    요 : StylePOPUP를 조회한다.
  * return값 : void
  */
 function setStyleCdPopup(evnflag){
     var codeObj = EM_O_STYLE_CD;
     var nameObj = EM_O_STYLE_NAME;
     
     if(codeObj.Text == "" && evnflag != "POP" ){ 
         nameObj.Text = "";
         return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = stylePop(codeObj,nameObj, 'Y' , '' , EM_O_PUMBUN_CD.Text );
          
     }else if( evnflag == "NAME" ){
    	 setStyleNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 'Y', 1, '' , EM_O_PUMBUN_CD.Text);         
     }
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

<!-- STYLE코드 변경시 -->
<script language=JavaScript for=EM_O_STYLE_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setStyleCdPopup("NAME");
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
<object id="DS_I_COLOR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SIZE_CD" classid=<%= Util.CLSID_DATASET %>></object>
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
            <th class="point" width="70">점</th>
            <td width="175">
                 <comment id="_NSID_">
                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=175 tabindex=1 align="absmiddle">
                    </object>
                </comment><script>_ws_(_NSID_);</script>
            </td> 
            <th class="point" width="70">일자</th>
            <td width="165">
                <comment id="_NSID_">
                      <object id=EM_O_STK_DT classid=<%=Util.CLSID_EMEDIT%>  width=140 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('G',EM_O_STK_DT)" align="absmiddle" />
            </td>
            <th class="point" width="70">브랜드</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=55 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPumbunCdPopup('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=105 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
            </td>       
          </tr>
          <tr>
              <th width="70">품목</th>
              <td>
                <comment id="_NSID_">
                      <object id=EM_O_PUMMOK_CD classid=<%=Util.CLSID_EMEDIT%>  width=60 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPummokCdPopup('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMMOK_NAME classid=<%=Util.CLSID_EMEDIT%>  width=85 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
              </td>
              <th width="70">STYLE코드</th>
              <td colspan="3">
                <comment id="_NSID_">
                      <object id=EM_O_STYLE_CD classid=<%=Util.CLSID_EMEDIT%>  width=250 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setStyleCdPopup('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_STYLE_NAME classid=<%=Util.CLSID_EMEDIT%>  width=165 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
              </td>
          </tr>
          <tr>
              <th width="70">조직명</th>
              <td colspan="5">
                <comment id="_NSID_">
                      <object id=EM_O_ORG_NAME classid=<%=Util.CLSID_EMEDIT%>  width=430 tabindex=1>
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

