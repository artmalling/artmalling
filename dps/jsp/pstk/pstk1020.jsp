<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> 장부재고조회
 * 작 성 일 : 2010.05.12
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk102.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 브랜드별 장부재고 현황을 조회 할 수 있다.
 * 이    력 :
 *        2010.05.12 (이재득) 작성
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
	// PID 확인을 위한
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
 var excelDeptCd;
 var excelTeamCd;
 var excelPcCd;
 var excelStkDt;
 var excelPumbunCd;
 var excelVenCd;
 
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
    initEmEdit(EM_O_STK_DT, "TODAY",  PK); //일자    
    initEmEdit(EM_O_PUMBUN_CD,    "CODE^6^0",  NORMAL); //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME,  "GEN^40",    READ);   //브랜드명
    initEmEdit(EM_O_VEN_CD,       "CODE^6^0",  NORMAL); //협력사코드
    initEmEdit(EM_O_VEN_NAME,     "GEN^40",    READ);   //협력사명
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회)
    initComboStyle(LC_O_DEPT_CD,DS_O_DEPT_CD, "CODE^0^30,NAME^0^110", 1, PK);  //팀    
    initComboStyle(LC_O_TEAM_CD,DS_O_TEAM_CD, "CODE^0^30,NAME^0^110", 1, PK);  //파트
    initComboStyle(LC_O_PC_CD,DS_O_PC_CD, "CODE^0^30,NAME^0^110", 1, PK);  //PC
    
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_DEPT_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_TEAM_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    
    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N");    
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"               width=30     align=center   edit=none  sumtext="" SubSumText=""                                        SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=VEN_CD           name="협력사;코드"       width=55     align=center  edit=none   suppress=3 SubSumText=""                                        SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=VEN_NAME         name="협력사명"          width=120    align=left    edit=none   suppress=3 SubSumText={decode(curlevel,1,"",2,"",3,"협력사계")} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'                     
                     + '<FC>id=PUMBUN_CD        name="브랜드코드"          width=55     align=center  edit=none   suppress=2 SubSumText=""                                        SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=PUMBUN_NAME      name="브랜드명"            width=100    align=left    edit=none   suppress=2 SubSumText={decode(curlevel,1,"",2,"브랜드계",3,"")}   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>' 
                     + '<FC>id=PUMMOK_CD        name="품목코드"          width=80     align=center  edit=none   suppress=1 SubSumText=""                                        SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=PUMMOK_NAME      name="품목명"            width=100    align=left    edit=none   suppress=1 SubSumText={decode(curlevel,1,"품목계",2,"",3,"")}   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FG> name="마진코드" '
                     + '<FC>id=EVENT_FLAG       name="행사구분"          width=60     align=center  edit=none   SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>' 
                     + '<FC>id=EVENT_RATE       name="행사율"            width=50     align=center  edit=none   SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=MG_RATE          name="마진율"            width=50     align=center  edit=none   SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> '
                     + '<FC>id=DEPT_CD          name="행사구분"          width=60     align=center  edit=none   SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}  show="false"</FC>' 
                     + '<FC>id=TEAM_CD          name="행사율"            width=50     align=center  edit=none   SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}  show="false"</FC>'
                     + '<FC>id=PC_CD            name="마진율"            width=50     align=center  edit=none   SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}  show="false"</FC>'
                     + '<FG> name="기초재고" '
                     + '<FC>id=BASE_QTY         name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=BASE_AMT         name="금액"              width=120     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> ' 
                     + '<FG> name="당일매입" '
                     + '<FC>id=BUY_TOT_QTY_SDAY      name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=BUY_TOT_SALE_AMT_SDAY name="금액"              width=120     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> ' 
                     + '<FG> name="당일매출" '
                     + '<FC>id=SALE_QTY_SDAY         name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_AMT_SDAY    name="금액"              width=120     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> '
                     + '<FG> name="누계매입" '
                     + '<FC>id=BUY_TOT_QTY      name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=BUY_TOT_SALE_AMT name="금액"              width=120     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> ' 
                     + '<FG> name="누계매출" '
                     + '<FC>id=SALE_QTY         name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SALE_SALE_AMT    name="금액"              width=120     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> '
                     + '<FG> name="재고조정" '
                     + '<FC>id=STK_ADJ_QTY      name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=STK_ADJ_SALE_AMT name="금액"              width=120     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> '
                     + '<FG> name="기말재고" '
                     + '<FC>id=SRVY_E_QTY       name="수량"              width=70     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SRVY_E_AMT       name="금액"              width=120     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> '; 
                                          
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
                     
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.ColumnProp("PUMBUN_NAME", "sumtext")        = "합계";
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
    }
    /* 조직구분 팀 이하는 필수입력에서 제외한다 20100827 서부장님 요청 박래형 수정
    }else if( LC_O_DEPT_CD.BindColVal == "" || LC_O_DEPT_CD.BindColVal == "%"){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "팀");            
        LC_O_DEPT_CD.Focus();
        return false;
    }else if( LC_O_TEAM_CD.BindColVal == "" || LC_O_TEAM_CD.BindColVal == "%"){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "파트");            
        LC_O_TEAM_CD.Focus();
        return false;
    }else if( LC_O_PC_CD.BindColVal == "" || LC_O_PC_CD.BindColVal == "%"){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "PC");            
        LC_O_PC_CD.Focus();
        return false;
    }
    */
    else if( EM_O_STK_DT.Text == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "일자");            
        EM_O_STK_DT.Focus();
        return false;
    }
    
    if(chkbox.checked == true)
		 {
        DS_IO_MASTER.SubSumExpr  = "3:VEN_CD,2:PUMBUN_CD,1:PUMMOK_CD" ; 
		 }else{
	 DS_IO_MASTER.SubSumExpr  = "" ;
    }
    
    DS_IO_MASTER.ClearData();
    
    var strStrCd      = LC_O_STR_CD.BindColVal;
    var strDeptCd     = LC_O_DEPT_CD.BindColVal;
    var strTeamCd     = LC_O_TEAM_CD.BindColVal;
    var strPcCd       = LC_O_PC_CD.BindColVal;   
    var strStkEDt     = EM_O_STK_DT.Text;
    var strPumbunCd   = EM_O_PUMBUN_CD.Text;
    var strVenCd      = EM_O_VEN_CD.Text;
    
    var strStkYm      = strStkEDt.substring(0, 6);
    var strStkSDt     = strStkEDt.substring(0, 6) + "01";
    
    setSearchValue2Excel();
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strDeptCd="+encodeURIComponent(strDeptCd)
                    +"&strTeamCd="+encodeURIComponent(strTeamCd)
                    +"&strPcCd="+encodeURIComponent(strPcCd)
                    +"&strStkSDt="+encodeURIComponent(strStkSDt)
                    +"&strStkEDt="+encodeURIComponent(strStkEDt)
                    +"&strStkYm="+encodeURIComponent(strStkYm)
                    +"&strPumbunCd="+encodeURIComponent(strPumbunCd)
                    +"&strVenCd="+encodeURIComponent(strVenCd);   
    
    TR_MAIN.Action="/dps/pstk102.pt?goTo="+goTo+parameters;  
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
                   + " -팀="+nvl(excelDeptCd,'전체')    
                   + " -파트="+nvl(excelTeamCd,'전체')     
                   + " -PC="+nvl(excelPcCd,'전체')    
                   + " -일자="+nvl(excelStkDt,'전체')
                   + " -브랜드="+nvl(excelPumbunCd,'전체')
                   + " -협력사="+nvl(excelVenCd,'전체');
	
	//openExcel3(GD_MASTER, GD_DETAIL, "조직별장부재고조회", "adfadsfa", "스타일 #가가가가#");
	//openExcelS(GD_MASTER, "장부재고조회", parameters, true );
    openExcelM2(GD_MASTER, "장부재고조회", parameters, true ,g_strPid );
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
     excelDeptCd   = LC_O_DEPT_CD.Text;
     excelTeamCd   = LC_O_TEAM_CD.Text;
     excelPcCd     = LC_O_PC_CD.Text;
     excelStkDt    = EM_O_STK_DT.Text;
     excelPumbunCd = EM_O_PUMBUN_CD.Text;
     excelVenCd    = EM_O_VEN_CD.Text;
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
     
     var strStrCd  = LC_O_STR_CD.BindColVal; 
     var strDeptCd  = LC_O_DEPT_CD.BindColVal;
     var strTeamCd = LC_O_TEAM_CD.BindColVal;  
     var strPcCd  = LC_O_PC_CD.BindColVal;
     var strCornerCd = "00";
     
     var strOrgCd = strStrCd+strDeptCd+strTeamCd+strPcCd+strCornerCd;
     
     if(LC_O_TEAM_CD.BindColVal == "%" || LC_O_PC_CD.BindColVal == "%")
         strOrgCd = "";
     
     if(codeObj.Text == "" && evnflag != "POP" ){
         nameObj.Text = "";
         return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = strPbnPop(codeObj,nameObj,'Y', '',strStrCd, strOrgCd);
          
     }else if( evnflag == "NAME" ){
         result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y", '1','',strStrCd, strOrgCd);
             
     }
 } 

 /**
  * setVenCdPopup()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.05.12
  * 개    요 : 협력사POPUP를 조회한다.
  * return값 : void
  */
 function setVenCdPopup(evnflag){
     var codeObj = EM_O_VEN_CD;
     var nameObj = EM_O_VEN_NAME;
     
     if(codeObj.Text == "" && evnflag != "POP" ){ 
    	 nameObj.Text = "";
         return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = venPop(codeObj,nameObj);
          
     }else if( evnflag == "NAME" ){
    	 setVenNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,1);         
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
    
    getDept("DS_O_DEPT_CD", "Y", LC_O_STR_CD.BindColVal, "Y");
    if(DS_O_DEPT_CD.CountRow < 1){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);       
    }
    LC_O_DEPT_CD.Index = 0;

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
                LC_O_DEPT_CD.BindColVal, "Y");

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
                LC_O_DEPT_CD.BindColVal, LC_O_TEAM_CD.BindColVal, "Y");

    if(DS_O_PC_CD.CountRow < 1){
        insComboData(LC_O_PC_CD, "%", "전체", 1);       
    }
    LC_O_PC_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_PC_CD event=OnSelChange>
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
</script>

<!-- 브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setPumbunCdPopup("NAME");
</script>

<!-- 협력사코드 변경시 -->
<script language=JavaScript for=EM_O_VEN_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setVenCdPopup("NAME");
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
            <th class="point" width="80">점</th>
            <td width="165">
                 <comment id="_NSID_">
                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                    </object>
                </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">팀</th>
            <td width="165"><comment id="_NSID_"> <object id=LC_O_DEPT_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th width="80">파트</th>
            <td><comment id="_NSID_"> <object id=LC_O_TEAM_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=195 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td> 
          </tr>
          <tr>
            <th width="80">PC</th>
            <td><comment id="_NSID_"> <object id=LC_O_PC_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th class="point" width="80">일자</th>
            <td width="165">
                <comment id="_NSID_">
                      <object id=EM_O_STK_DT classid=<%=Util.CLSID_EMEDIT%>  width=138 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('G',EM_O_STK_DT)" align="absmiddle" /></td>
            </td>
            <th width="80">브랜드</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=55 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPumbunCdPopup('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
            </td>            
          </tr>
          <tr>
              <th width="80">협력사코드</th>
              <td colspan="5">
                <comment id="_NSID_">
                      <object id=EM_O_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=55 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setVenCdPopup('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=170 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=checkbox id=chkbox>합계출력                
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

