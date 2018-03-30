<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품코드> 점별단품조회
 * 작 성 일 : 2010.07.15
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod5100.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 점별 단품 정보를 조회한다.
 * 이    력 :
 *        2010.07.15 (정진영) 신규작성
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
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
//엑셀 다운로드를 위한 전역 변수
var excelStr;
var excelVenCd;
var excelVenName;
var excelPumbunCd;
var excelPumbunName;
var excelSkuCd;
var excelSkuName;
var excelStyle;
var excelPummokCd;
var excelPummokName;
var excelEvent;
var excelBasPrcDt;

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_SEARCH.setDataHeader('STR_CD:STRING(2)'
    		              +',VEN_CD:STRING(6)'
                          +',VEN_NAME:STRING(40)'
                          +',PUMBUN_CD:STRING(6)'
                          +',PUMBUN_NAME:STRING(40)'
                          +',SKU_CD:STRING(13)'
                          +',SKU_NAME:STRING(40)'
                          +',STYLE_CD:STRING(54)'
                          +',PUMMOK_CD:STRING(8)'
                          +',PUMMOK_NAME:STRING(40)'
                          +',EVENT_CD:STRING(11)'
                          +',BAS_PRC_DT:STRING(8)');
    
    DS_SEARCH.AddRow();
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_VEN_CD       , "CODE^6^0" ,  NORMAL);  //협력사코드(조회)
    initEmEdit(EM_VEN_NAME     , "GEN^40"   ,  NORMAL);  //협력사명(조회)
    initEmEdit(EM_PUMBUN_CD    , "CODE^6^0" ,  NORMAL);  //브랜드코드(조회)
    initEmEdit(EM_PUMBUN_NAME  , "GEN^40"   ,  NORMAL);  //브랜드명(조회)
    initEmEdit(EM_SKU_CD       , "CODE^13^0",  NORMAL);  //단품코드(조회)
    initEmEdit(EM_SKU_NAME     , "GEN^40"   ,  NORMAL);  //단품명(조회)
    initEmEdit(EM_STYLE_CD     , "CODE^54^0",  NORMAL);  //스타일코드(조회)
    initEmEdit(EM_STYLE_NAME   , "GEN^40"   ,  READ);    //스타일명(조회)
    initEmEdit(EM_PUMMOK_CD    , "CODE^8"   ,  NORMAL);  //품목코드(조회)
    initEmEdit(EM_PUMMOK_NAME  , "GEN^40"   ,  NORMAL);  //품목명(조회)
    initEmEdit(EM_EVENT_CD     , "CODE^11^0",  NORMAL);  //행사코드(조회)
    initEmEdit(EM_EVENT_NAME   , "GEN^40"   ,  READ);    //행사명(조회)
    initEmEdit(EM_BAS_PRC_DT   , "TODAY"    ,  PK);      //가격기준일(조회)
    //콤보 초기화 
    initComboStyle(LC_STR_CD        ,DS_STR_CD        , "CODE^0^30,NAME^0^140", 1, NORMAL);  //점(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )    
    
    // 점코드 조회
    getStore("DS_STR_CD"  , "Y", "", "Y");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    
    LC_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}       width=25   align=center name="NO"            </FC>'
                     + '<FC>id=STR_CD         width=90   align=left   name="점"            editStyle=Lookup   data="DS_STR_CD:CODE:NAME"</FC>'
                     + '<FG>name="단품"'
                     + '<FC>id=SKU_CD         width=110  align=center name="코드"          </FC>'
                     + '<FC>id=SKU_NAME       width=150  align=left   name="명"            </FC>'
                     + '</FG>'
                     + '<C> id=INPUT_PLU_CD   width=110  align=left   name="스캔코드"       </C>'
                     + '<C> id=MODEL_NO       width=110  align=left   name="모델코드"       </C>'
                     + '<G> name="브랜드"'
                     + '<C> id=PUMBUN_CD      width=80   align=center name="코드"          </C>'
                     + '<C> id=PUMBUN_NAME    width=150  align=left   name="명"            </C>'
                     + '</G>'
                     + '<G> name="협력사"'
                     + '<C> id=VEN_CD         width=80   align=center name="코드"          </C>'
                     + '<C> id=VEN_NAME       width=150  align=left   name="명"            </C>'
                     + '</G>'
                     + '<G> name="품목"'
                     + '<C> id=PUMMOK_CD      width=80   align=center name="코드"          </C>'
                     + '<C> id=PUMMOK_NAME    width=150  align=left   name="명"            </C>'
                     + '</G>'
                     + '<G> name="정상가격"'
                     + '<C> id=NORM_COST_PRC  width=100  align=right  name="판매원가"       </C>'
                     + '<C> id=NORM_SALE_PRC  width=100  align=right  name="판매매가"       </C>'
                     + '<C> id=NORM_MG_RATE   width=100  align=right  name="판매마진율"     </C>'
                     + '</G>'
                     + '<G> name="판매가격"'
                     + '<C> id=SALE_COST_PRC  width=100  align=right  name="판매원가"       </C>'
                     + '<C> id=SALE_SALE_PRC  width=100  align=right  name="판매매가"       </C>'
                     + '<C> id=SALE_MG_RATE   width=100  align=right  name="판매마진율"     </C>'
                     + '</G>'
                     + '<C> id=APP_S_DT       width=90   align=center name="적용시작일 "     mask="XXXX/XX/XX" </C>'
                     + '<C> id=APP_E_DT       width=90   align=center name="적용종료일 "     mask="XXXX/XX/XX" </C>'
                     + '<G> name="행사코드"'
                     + '<C> id=EVENT_CD       width=100  align=center name="코드"           </C>'
                     + '<C> id=EVENT_NAME     width=150  align=left   name="명"             </C>'
                     + '</G>'
                     + '<C> id=AVG_SALE_PRC   width=100  align=right  name="일평균;판매금액"   </C>'
                     + '<C> id=AVG_SALE_QTY   width=100  align=right  name="일평균;판매수량" </C>'
                     + '<C> id=GOAL_PROF_RATE width=100  align=right  name="목표이익율"      </C>'
                     + '<C> id=USE_YN         width=65   align=left   name="사용여부 "       EditStyle=Combo Data="Y:YES,N:NO"</C>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if( EM_BAS_PRC_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "가격기준일");
        EM_BAS_PRC_DT.Focus();
        return;
    }
    searchMaster();
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
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

    // openExcel2(GD_MASTER, "점별단품조회", getSearchValue2Excel(), true );
    openExcel5(GD_MASTER, "점별단품조회", getSearchValue2Excel(), true , "",g_strPid );

    if(DS_MASTER.CountRow < 1)
        LC_STR_CD.Focus();
    else
        GD_MASTER.Focus();


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
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  F&B매장 리스트 조회
 * return값 : void
 */
function searchMaster(){

    DS_MASTER.ClearData();

    DS_SEARCH.UserStatus(1) = '1';
    
    // 엑셀 다운을 위한 조회조건 저장
    setSearchValue2Excel();
    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    
    TR_MAIN.Action="/dps/pcod510.pc?goTo="+goTo;      
    TR_MAIN.KeyValue="SERVLET(I:DS_SEARCH=DS_SEARCH,"+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 

/**
 * setSearchValue2Excel()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀다운시 조회조건 입력을 위한 값 바인드
 * return값 : void
 */
function setSearchValue2Excel(){

    excelStr           = LC_STR_CD.Text;
    excelVenCd         = EM_VEN_CD.Text;
    excelVenName       = EM_VEN_NAME.Text;
    excelPumbunCd      = EM_PUMBUN_CD.Text;
    excelPumbunName    = EM_PUMBUN_NAME.Text;
    excelSkuCd         = EM_SKU_CD.Text;
    excelSkuName       = EM_SKU_NAME.Text;
    excelStyle         = EM_STYLE_CD.Text;
    excelPummokCd      = EM_PUMMOK_CD.Text;
    excelPummokName    = EM_PUMMOK_NAME.Text;
    excelEvent         = EM_EVENT_CD.Text;
    excelBasPrcDt      = EM_BAS_PRC_DT.Text;

}
/**
 * getSearchValue2Excel()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회조건 입력 값 조회
 * return값 : void
 */
function getSearchValue2Excel(){
    //
    var parameters = "점="+nvl(excelStr,'전체')                      
                   + " -협력사코드="+nvl(excelVenCd,'전체')       
                   + " -협력사명="+nvl(excelVenName,'전체')               
                   + " -브랜드코드="+nvl(excelPumbunCd,'전체')   
                   + " -브랜드명="+nvl(excelPumbunName,'전체')       
                   + " -단품코드="+nvl(excelSkuCd,'전체')       
                   + " -단품명="+nvl(excelSkuName,'전체')               
                   + " -스타일코드="+nvl(excelStyle,'전체')   
                   + " -품목코드="+nvl(excelPummokCd,'전체')    
                   + " -품목명="+nvl(excelPummokName,'전체')               
                   + " -행사코드="+nvl(excelEvent,'전체')   
                   + " -가격기준일="+nvl(excelBasPrcDt,'전체');
    return parameters;
}

/**
 * getVenCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사 팝업을 실행한다.
 * return값 : void
**/
function getVenCode(evnFlag){
    var codeObj = EM_VEN_CD;
    var nameObj = EM_VEN_NAME;


    if( evnFlag == 'NAME' && codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    if( evnFlag == 'POP'){
        venPop(codeObj,nameObj,LC_STR_CD.BindColVal);
        codeObj.Focus();
        return;
    }
    
    setVenNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj,0,LC_STR_CD.BindColVal);

}

/**
 * getPumbunCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드 팝업을 실행한다.
 * return값 : void
**/
function getPumbunCode(evnFlag){
    var codeObj = EM_PUMBUN_CD;
    var nameObj = EM_PUMBUN_NAME;


    if( evnFlag == 'NAME' && codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    if( evnFlag == 'POP'){
    	strPbnPop2(codeObj,nameObj,'Y','',LC_STR_CD.BindColVal,'',EM_VEN_CD.Text,'','','','1');
        codeObj.Focus();
        return;
    }
    
    setStrPbnNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj,'Y',0,'',LC_STR_CD.BindColVal,'',EM_VEN_CD.Text,'','','','1');

}
/**
 * getSkuCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 스타일 팝업을 실행한다.
 * return값 : void
**/
function getSkuCode(evnFlag){
    var codeObj = EM_SKU_CD;
    var nameObj = EM_SKU_NAME;


    if( evnFlag == 'NAME' && codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    if( evnFlag == 'POP'){
        strSkuPop(codeObj,nameObj,'Y','',LC_STR_CD.BindColVal,EM_PUMBUN_CD.Text);
        codeObj.Focus();
        return;
    }
    
    setStrSkuNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 'Y', 0,'',LC_STR_CD.BindColVal,EM_PUMBUN_CD.Text);

}

/**
 * getStyleCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 스타일 팝업을 실행한다.
 * return값 : void
**/
function getStyleCode(evnFlag){
    var codeObj = EM_STYLE_CD;
    var nameObj = EM_STYLE_NAME;


    if( evnFlag == 'NAME' && codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    if( evnFlag == 'POP'){
        stylePop(codeObj,nameObj,'Y','',EM_PUMBUN_CD.Text);
        codeObj.Focus();
        return;
    }
    
    setStyleNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 'Y', 1,'',EM_PUMBUN_CD.Text);

}

/**
 * getPummokCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 품목 팝업을 실행한다.
 * return값 : void
**/
function getPummokCode(evnFlag){
    var codeObj = EM_PUMMOK_CD;
    var nameObj = EM_PUMMOK_NAME;


    if( evnFlag == 'NAME' && codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    if( evnFlag == 'POP'){
    	pummokPop(codeObj,nameObj,'','4');
        codeObj.Focus();
        return;
    }
    
    setPummokNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 0,'','4');

}

/**
 * getEventCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 행사 팝업을 실행한다.
 * return값 : void
**/
function getEventCode(evnFlag){
    var codeObj = EM_EVENT_CD;
    var nameObj = EM_EVENT_NAME;


    if( evnFlag == 'NAME' && codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    if( evnFlag == 'POP'){
    	eventPop(codeObj,nameObj);
        codeObj.Focus();
        return;
    }
    
    setEventNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj,1);

}
-->
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

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );    
</script>
<!-- 협력사(조회) -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getVenCode('NAME');
</script>
<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getPumbunCode('NAME');
</script>
<!-- 단품(조회) -->
<script language=JavaScript for=EM_SKU_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getSkuCode('NAME');
</script>
<!-- 스타일(조회) -->
<script language=JavaScript for=EM_STYLE_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getStyleCode('NAME');
</script>
<!-- 품목(조회) -->
<script language=JavaScript for=EM_PUMMOK_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getPummokCode('NAME');
</script>
<!-- 행사코드(조회) -->
<script language=JavaScript for=EM_EVENT_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getEventCode('NAME');
</script>
<!-- 가격기준일(조회) -->
<script language=JavaScript for=EM_BAS_PRC_DT event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    checkDateTypeYMD(EM_BAS_PRC_DT);
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
<comment id="_NSID_"><object id="DS_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_SEARCH"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

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

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="60" >점</th>
            <td width="190">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle">
                 </object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60" >협력사</th>
            <td width="190" >
              <comment id="_NSID_">
                <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getVenCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=110  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="60" >브랜드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getPumbunCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=100  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >단품코드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_SKU_CD classid=<%=Util.CLSID_EMEDIT%>  width=95 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getSkuCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_SKU_NAME classid=<%=Util.CLSID_EMEDIT%>  width=65  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th >스타일</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_STYLE_CD classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getStyleCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_STYLE_NAME classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th >품목</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_PUMMOK_CD classid=<%=Util.CLSID_EMEDIT%>  width=60 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getPummokCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMMOK_NAME classid=<%=Util.CLSID_EMEDIT%>  width=90  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >행사코드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getEventCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th class="point" >가격기준일</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_BAS_PRC_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"   onclick="javascript:openCal('G',EM_BAS_PRC_DT);"  align="absmiddle" />
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=457 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

<comment id="_NSID_">
<object id=BO_SEARCH classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_SEARCH>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=STR_CD        ctrl=LC_STR_CD        param=BindColVal </c>
            <c>col=VEN_CD        ctrl=EM_VEN_CD        param=Text </c>
            <c>col=VEN_NAME      ctrl=EM_VEN_NAME      param=Text </c>
            <c>col=PUMBUN_CD     ctrl=EM_PUMBUN_CD     param=Text </c>
            <c>col=PUMBUN_NAME   ctrl=EM_PUMBUN_NAME   param=Text </c>
            <c>col=SKU_CD        ctrl=EM_SKU_CD        param=Text </c>
            <c>col=SKU_NAME      ctrl=EM_SKU_NAME      param=Text </c>
            <c>col=STYLE_CD      ctrl=EM_STYLE_CD      param=Text </c>
            <c>col=PUMMOK_CD     ctrl=EM_PUMMOK_CD     param=Text </c>
            <c>col=PUMMOK_NAME   ctrl=EM_PUMMOK_NAME   param=Text </c>
            <c>col=EVENT_CD      ctrl=EM_EVENT_CD      param=Text </c>
            <c>col=BAS_PRC_DT    ctrl=EM_BAS_PRC_DT    param=Text </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
