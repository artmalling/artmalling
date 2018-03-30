<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 행사코드> 행사확정
 * 작 성 일 : 2010.01.18
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod7090.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 점별 브랜드행사 정보를 등록 수정 한다.
 * 이    력 :
 *        2010.01.18 (정진영) 신규작성
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
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var bfStrCd = "";
var bfEventCd = "";
var bfPumbunCd = "";
var eventPluFlag = "2";
var bfEventGb = "";
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

	//탭초기화
	initTab('TAB_MAIN');
	    
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_STRPBNEVT.setDataHeader('<gauce:dataset name="H_SEL_STRPBNEVT"/>');
    DS_STRSKUEVT.setDataHeader('<gauce:dataset name="H_SEL_STRSKUEVT"/>');
    
    //그리드 초기화
    gridCreate1(); // 행사마스터
    gridCreate2(); // 점별브랜드행사
    gridCreate3(); // 점별단품행사

    // EMedit에 초기화
    initEmEdit(EM_EVENT_CD   , "CODE^11"  ,  PK);  //행사코드
    initEmEdit(EM_EVENT_NAME , "GEN^40"   ,  READ);  //행사명
    initEmEdit(EM_PUMBUN_CD  , "CODE^6^0" ,  PK);  //브랜드코드
    initEmEdit(EM_PUMBUN_NAME, "GEN^40"   ,  READ);  //브랜드명

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)

    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod709","DS_MASTER,DS_STRPBNEVT,DS_STRSKUEVT" );
    bfStrCd = LC_STR_CD.BindColVal;
    LC_STR_CD.Focus();

    RD_EVENT_GUBUN.CodeValue = '1';
    bfEventGb = '1';
    setEventType('1');
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}             width=25   align=center name="NO"         </FC>'
                     + '<FG>name="행사테마"'
                     + '<FC>id=EVENT_THME_CD        width=50   align=center name="코드"       </FC>'
                     + '<FC>id=EVENT_THME_NAME      width=100  align=left   name="명"         </FC>'
                     + '</FG>'
                     + '<FC>id=EVENT_S_DT           width=80   align=center name="행사시작일 " mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=EVENT_E_DT           width=80   align=center name="행사종료일" mask="XXXX/XX/XX"</FC>'
                     + '<FG>name="행사목표"'
                     + '<FC>id=GOAL_SALE_AMT        width=90   align=right  name="매출액"     </FC>'
                     + '<FC>id=GOAL_PROF_AMT        width=90   align=right  name="이익액"     </FC>'
                     + '</FG>'
                     + '<FC>id=EVENT_TYPE_NAME      width=60   align=left   name="행사;종류"   </FC>'
                     + '<FC>id=EVENT_PLU_FLAG_NAME  width=110   align=left   name="행사;유형"   </FC>'
                     + '<FC>id=EVENT_MNG_FLAG_NAME  width=60   align=left   name="행사;주관"   </FC>'
                     + '<FC>id=EVENT_ORG_NAME       width=125  align=left   name="주관조직"   </FC>'
                     + '<FC>id=EVENT_CHAR_NAME      width=100  align=left   name="담당자"     </FC>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}        width=25 align=center edit=none        name="NO"               </FC>'
                     + '<FC>id=CONF_YN         width=50 align=center                  name="확정"             EditStyle=checkbox HeadCheckShow=true edit={IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'" ,"true","false")}  </FC>'
                     + '<FC>id=PUMBUN_CD       width=90 align=center edit=none        name="브랜드코드"         </FC>'
                     + '<FC>id=PUMBUN_NAME     width=130 align=left   edit=none        name="브랜드명"            </FC>'
                     + '<FC>id=EVENT_FLAG      width=90 align=center edit=none        name="행사구분"         </FC>'
                     + '<FC>id=EVENT_RATE      width=90 align=right  edit=none        name="행사율"           </FC>'
                     + '<FC>id=APP_S_DT        width=90 align=center edit=none        name="행사시작일"        mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=APP_E_DT        width=90 align=center edit=none        name="행사종료일"       mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=NORM_MG_RATE    width=90 align=right  edit=none        name="정상;마진율"       </FC>'
                     + '<FC>id=EVENT_MG_RATE   width=90 align=right  edit=none        name="행사;마진율"      </FC>'
                     + '<FG>name="행사목표"'
                     + '<FC>id=GOAL_SALE_AMT   width=90 align=right  edit=none        name="매출액"            </FC>'
                     + '<FC>id=GOAL_PROF_AMT   width=90 align=right  edit=none        name="이익액"            </FC>'
                     + '</FG>'
                     + '<FC>id=LIMIT_SALE_QTY  width=90 align=right  edit=none        name="한정판매;수량"      </FC>'
                     + '<FC>id=DC_DIV_RATE     width=90 align=right  edit=none        name="당사에누리;분담율"  show="false" </FC>'
                     + '<FC>id=CPN_ISSUE_QTY   width=90 align=right  edit=none        name="쿠폰발행;수량"      show="false" </FC>'
                     + '<FC>id=CPN_BARCODE     width=90 align=center edit=none        name="쿠폰;바코드 "        show="false" </FC>';

    initGridStyle(GD_STRPBNEVT, "common", hdrProperies, true);
}

function gridCreate3(){
    var hdrProperies = '<FC>id={currow}        width=25  align=center edit=none        name="NO"               </FC>'
                     + '<FC>id=CONF_YN         width=50  align=center                  name="확정"             EditStyle=checkbox HeadCheckShow=true edit={IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'" ,"true","false")}  </FC>'
                     + '<FC>id=SKU_CD          width=120 align=center edit=none        name="단품코드"         </FC>'
                     + '<FC>id=SKU_NAME        width=150 align=left   edit=none        name="단품명"            </FC>'
                     + '<FC>id=APP_S_DT        width=90  align=center edit=none        name="적용시작일"        mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=APP_E_DT        width=90  align=center edit=none        name="적용종료일"       mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=REDU_RATE       width=60  align=right  edit=none        name="행사율"           </FC>'
                     + '<FG>name="정상가"'
                     + '<FC>id=NORM_COST_PRC   width=90  align=right  edit=none        name="원가"              </FC>'
                     + '<FC>id=NORM_SALE_PRC   width=90  align=right  edit=none        name="판매가"            </FC>'
                     + '<FC>id=NORM_MG_RATE    width=90  align=right  edit=none        name="마진율"            </FC>'
                     + '</FG>'
                     + '<FG>name="행사가"'
                     + '<FC>id=EVENT_COST_PRC  width=90  align=right  edit=none        name="원가"              </FC>'
                     + '<FC>id=EVENT_PRICE     width=90  align=right  edit=none        name="판매가"            </FC>'
                     + '<FC>id=EVENT_MG_RATE   width=90  align=right  edit=none        name="마진율"            </FC>'
                     + '</FG>'
                     + '<FC>id=LIMIT_SALE_QTY  width=90  align=right  edit=none        name="한정판매;수량"      </FC>'
                     + '<FC>id=DC_DIV_RATE     width=90  align=right  edit=none        name="당사에누리;분담율"  show="false" </FC>'
                     + '<FC>id=CPN_ISSUE_QTY   width=90  align=right  edit=none        name="쿠폰발행;수량"      show="false" </FC>'
                     + '<FC>id=CPN_BARCODE     width=90  align=center edit=none        name="쿠폰;바코드 "        show="false" </FC>';

    initGridStyle(GD_STRSKUEVT, "common", hdrProperies, true);
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
	//

    if( LC_STR_CD.BindColVal == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( EM_EVENT_CD.Text == ""){
        // (행사코드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "행사코드");
        EM_EVENT_CD.Focus();
        return;
    }

    if( EM_EVENT_NAME.Text == ""){
        // 존재하지 않는 행사코드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "행사코드");
        EM_EVENT_CD.Focus();
        return;
    }

    if(eventPluFlag=="2"){
        if( EM_PUMBUN_CD.Text == ""){
            // (브랜드)은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
            EM_PUMBUN_CD.Focus();
            return;
        }

        if( EM_PUMBUN_NAME.Text == ""){
            // 존재하지 않는 브랜드입니다.
            showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
            EM_PUMBUN_CD.Focus();
            return;
        }
    }else{

        if( EM_PUMBUN_CD.Text != "" && EM_PUMBUN_NAME.Text == ""){
            // 존재하지 않는 브랜드입니다.
            showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
            EM_PUMBUN_CD.Focus();
            return;
        }
    }
    if( DS_STRPBNEVT.IsUpdated || DS_STRSKUEVT.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_MASTER.Focus();
            return ;
        }
    }

    searchMaster();
    if( eventPluFlag=="2"){
        searchStrSkuEvt();    	
    }else{
        searchStrPbnEvt();    	
    }
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
	// 확정할 데이터 없는 경우
    if ( !DS_STRPBNEVT.IsUpdated && !DS_STRSKUEVT.IsUpdated ){
        //확정할 데이터를 선택하세요
        showMessage(INFORMATION, OK, "USER-1090");
        if( DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
            return;
        }
        if(getTabItemSelect("TAB_MAIN") == 1){
            GD_STRSKUEVT.Focus(); 
        }else{       	
            GD_STRPBNEVT.Focus();
        }
        return;
    }

    if(getTabItemSelect("TAB_MAIN") == 1){
        if( !checkSkuEvtValidation())
            return;
    }else{          
        if( !checkPbnEvtValidation())
            return;
    }
    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','03','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1083", "", "");
        if(getTabItemSelect("TAB_MAIN") == 1){
            GD_STRSKUEVT.Focus(); 
        }else{          
            GD_STRPBNEVT.Focus();
        }
        return;
    }
    //확정하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1024") != 1 ){
        if(getTabItemSelect("TAB_MAIN") == 1){
            GD_STRSKUEVT.Focus(); 
        }else{          
            GD_STRPBNEVT.Focus();
        }
        return;
    }


    var strCd    = LC_STR_CD.BindColVal;
    var eventCd  = EM_EVENT_CD.Text;
    var pumbunCd = EM_PUMBUN_CD.Text;
    var eventSDt = DS_MASTER.NameValue(1,'EVENT_S_DT');
    var confFlag = DS_MASTER.NameValue(1,'CONF_YN');
    
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strEventCd="+encodeURIComponent(eventCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strEventPluFlag="+encodeURIComponent(eventPluFlag)
                   + "&strEventSDt="+encodeURIComponent(eventSDt)
                   + "&strConfFlag="+encodeURIComponent(confFlag);
    
    TR_MAIN.Action="/dps/pcod709.pc?goTo=conf"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_STRPBNEVT=DS_STRPBNEVT,I:DS_STRSKUEVT=DS_STRSKUEVT)"; //조회는 O
    TR_MAIN.Post();
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        searchMaster();
        if( eventPluFlag=="2"){
            searchStrSkuEvt();      
        }else{
            searchStrPbnEvt();      
        }
    }
    GD_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
//

/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행사마스터 조회
 * return값 : void
 */
function searchMaster(){    

    DS_MASTER.ClearData();
    DS_STRSKUEVT.ClearData();
    DS_STRPBNEVT.ClearData();

    GD_STRSKUEVT.ColumnProp("CONF_YN","HeadCheck") = "false";
    GD_STRPBNEVT.ColumnProp("CONF_YN","HeadCheck") = "false";
    var strCd    = LC_STR_CD.BindColVal;
    var eventCd  = EM_EVENT_CD.Text;
    var pumbunCd = EM_PUMBUN_CD.Text;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strEventCd="+encodeURIComponent(eventCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strEventPluFlag="+encodeURIComponent(eventPluFlag);
    TR_MAIN.Action="/dps/pcod709.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

}
/**
 * searchStrSkuEvt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  점별행사단품 리스트 조회
 * return값 : void
 */
function searchStrSkuEvt(){

    var strCd      = LC_STR_CD.BindColVal;
    var eventCd    = EM_EVENT_CD.Text;
    var pumbunCd   = EM_PUMBUN_CD.Text;
    var goTo       = "searchStrSkuEvt" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strEventCd="+encodeURIComponent(eventCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd);
    TR_MAIN.Action="/dps/pcod709.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_STRSKUEVT=DS_STRSKUEVT)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_STRSKUEVT);  

} 
/**
 * searchStrPbnEvt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  점별행사브랜드 리스트 조회
 * return값 : void
 */
function searchStrPbnEvt(){

    var strCd      = LC_STR_CD.BindColVal;
    var eventCd    = EM_EVENT_CD.Text;
    var pumbunCd   = EM_PUMBUN_CD.Text;
    var goTo       = "searchStrPbnEvt" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strEventCd="+encodeURIComponent(eventCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd);
    TR_MAIN.Action="/dps/pcod709.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_STRPBNEVT=DS_STRPBNEVT)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_STRPBNEVT);  

} 

/**
 * setEventCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 행사명을 등록한다.
 * return값 : void
 */
function setEventCode(evnflag){
    var codeObj = EM_EVENT_CD;
    var nameObj = EM_EVENT_NAME;
    var strCd = LC_STR_CD.BindColVal;
    
    if( DS_STRPBNEVT.IsUpdated || DS_STRSKUEVT.IsUpdated){
        // 변경된 상세내역이 존재합니다. 행사코드을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","행사코드") != 1 ){
            codeObj.Text = bfEventCd;
            GD_MASTER.Focus();
            return;
        }
    }

    DS_MASTER.ClearData();
    DS_STRPBNEVT.ClearData();
    DS_STRSKUEVT.ClearData();
    
    if( strCd == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        bfEventCd = "";
        return;     
    }
    var rtnMap = null;
    if( evnflag == "POP" ){
    	rtnMap = eventPop(codeObj,nameObj,strCd,'','',eventPluFlag);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
    	rtnMap = setEventNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 1, strCd,'','',eventPluFlag);
    }
    
    if( bfEventCd == codeObj.Text)
    	return;
    var tmpEventPluFlag = rtnMap == null? DS_SEARCH_NM.NameValue(1,"EVENT_PLU_FLAG"):rtnMap.get("EVENT_PLU_FLAG");
    
    if(!(tmpEventPluFlag =="0" || tmpEventPluFlag =="1" || tmpEventPluFlag == "2")){
        showMessage(EXCLAMATION, OK, "USER-1000", "단품행사 또는 브랜드행사 만 확정이 가능 합니다.");
    	codeObj.Text = "";
        nameObj.Text = "";
        bfEventCd = "";
        return;     
    }
    bfEventCd = codeObj.Text;
    
    if(tmpEventPluFlag !="0"){
    	RD_EVENT_GUBUN.CodeValue = tmpEventPluFlag;
        setEventType(tmpEventPluFlag);
    }
    
    
}

/**
 * setEventType()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 행사 타입을 설정 합니다.
 * return값 : void
 */
function setEventType(flag){
    
    if(flag == "1"){
        GD_MASTER.ColumnProp("GOAL_SALE_AMT","show") = false;
        GD_MASTER.ColumnProp("GOAL_PROF_AMT","show") = false;
        document.getElementById("TH_PUMBUN").className = "";
        setObjTypeStyle( EM_PUMBUN_CD, "EMEDIT", NORMAL);
        setTabItemIndex('TAB_MAIN',2);
    }else{
        GD_MASTER.ColumnProp("GOAL_SALE_AMT","show") = true;
        GD_MASTER.ColumnProp("GOAL_PROF_AMT","show") = true;
        document.getElementById("TH_PUMBUN").className = "point";  
        setObjTypeStyle( EM_PUMBUN_CD, "EMEDIT", PK);
        setTabItemIndex('TAB_MAIN',1);
    }
    eventPluFlag = flag;
}
/**
 * setPumbunCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function setPumbunCode(evnflag){
    var codeObj = EM_PUMBUN_CD;
    var nameObj = EM_PUMBUN_NAME;
    var strCd = LC_STR_CD.BindColVal;
    
    if( eventPluFlag == "2"){
        if( DS_STRPBNEVT.IsUpdated || DS_STRSKUEVT.IsUpdated){
            // 변경된 상세내역이 존재합니다. 브랜드을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","브랜드") != 1 ){
                codeObj.Text = bfPumbunCd;
                GD_MASTER.Focus();
                return;
            }
        }
    }
    DS_MASTER.ClearData();
    DS_STRPBNEVT.ClearData();
    DS_STRSKUEVT.ClearData();
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        bfPumbunCd = "";
        return;     
    }

    if( strCd == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( evnflag == "POP" ){
        strPbnPop(codeObj,nameObj,'Y','', strCd,'','','','0','',eventPluFlag == "2"?'1':'2');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'', strCd,'','','','0','',eventPluFlag == "2"?'1':'2');
    }    
    bfPumbunCd = codeObj.Text;
}

/**
 * checkPbnEvtValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드행사 값을 검증한다.
 * return값 : void
 */
function checkPbnEvtValidation(){
    var row;
    var colid;
    var errYn = false;
    
    for(var i=1; i<=DS_STRPBNEVT.CountRow; i++){
        var rowStatus = DS_STRPBNEVT.RowStatus(i);
        if( !(rowStatus == "3") || DS_STRPBNEVT.NameValue(i,"SEL") == "F" )
            continue;
        row = i;
        if( DS_STRPBNEVT.NameValue(i,"PUMBUN_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "브랜드코드");
            errYn = true;
            colid = "PUMBUN_CD";
            break;
        }
        if( DS_STRPBNEVT.NameValue(i,"PUMBUN_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "브랜드코드");
            errYn = true;
            colid = "PUMBUN_CD";
            break;
        }
        if( DS_STRPBNEVT.NameValue(i,"EVENT_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "행사구분");
            errYn = true;
            colid = "EVENT_FLAG";
            break;
        }
        if( DS_STRPBNEVT.NameValue(i,"NORM_MG_RATE")==""){
            showMessage(EXCLAMATION, OK, "USER-1000", "정상마진율이 존재하지 않습니다.");
            errYn = true;
            colid = "EVENT_FLAG";
            break;
        }
        if( DS_STRPBNEVT.NameValue(i,"EVENT_RATE")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "행사율");
            errYn = true;
            colid = "EVENT_RATE";
            break;
        }
        if( DS_STRPBNEVT.NameValue(i,"APP_E_DT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "행사종료일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( DS_STRPBNEVT.NameValue(i,"APP_E_DT") < getTodayFormat("YYYYMMDD")){
            showMessage(EXCLAMATION, OK, "USER-1030", "행사종료일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( DS_STRPBNEVT.NameValue(i,"APP_E_DT")< DS_STRPBNEVT.NameValue(i,"APP_S_DT")){
            showMessage(EXCLAMATION, OK, "USER-1020", "행사종료일", "행사시작일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( Number(DS_STRPBNEVT.NameValue(i,"EVENT_MG_RATE"))<=0){
            showMessage(EXCLAMATION, OK, "USER-1008", "행사마진율", 0);
            errYn = true;
            colid = "EVENT_MG_RATE";
            break;
        }
        if( Number(DS_STRPBNEVT.NameValue(i,"EVENT_MG_RATE"))>100){
            showMessage(EXCLAMATION, OK, "USER-1021", "행사마진율", 100);
            errYn = true;
            colid = "EVENT_MG_RATE";
            break;
        }
        
    }
    
    if(errYn){
        setFocusGrid(GD_STRPBNEVT,DS_STRPBNEVT,row,colid);
        return false;
    }
    return true;
}
/**
 * checkSkuEvtValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품행사 값을 검증한다.
 * return값 : void
 */
function checkSkuEvtValidation(){
    var row;
    var colid;
    var errYn = false;
    
    for(var i=1; i<=DS_STRSKUEVT.CountRow; i++){
        var rowStatus = DS_STRSKUEVT.RowStatus(i);
        if( !(rowStatus == "3")|| DS_STRSKUEVT.NameValue(i,"SEL") == "F"  )
            continue;
        row = i;
        if( DS_STRSKUEVT.NameValue(i,"SKU_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
            errYn = true;
            colid = "SKU_CD";
            break;
        }
        if( DS_STRSKUEVT.NameValue(i,"SKU_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "단품코드");
            errYn = true;
            colid = "SKU_CD";
            break;
        }
        if( Number(DS_STRSKUEVT.NameString( i, "NORM_COST_PRC")) < 0 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "정상가 원가","0");
            errYn = true;
            colid = "NORM_COST_PRC";
            break;
        }
        if( Number(DS_STRSKUEVT.NameString( i, "NORM_SALE_PRC")) < 1 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "정상가 판매가","1");
            colid = "NORM_SALE_PRC";
            errYn = true;
            break;     
        }
        if( Number(DS_STRSKUEVT.NameString( i, "NORM_MG_RATE")) < 0 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "정상가 마진율","0");
            colid = "NORM_MG_RATE";
            errYn = true;
            break;     
        }
        if( Number(DS_STRSKUEVT.NameValue(i,"NORM_MG_RATE"))>100){
            showMessage(EXCLAMATION, OK, "USER-1021", "정상가 마진율", 100);
            errYn = true;
            colid = "NORM_MG_RATE";
            break;
        }
        if( DS_STRSKUEVT.NameValue(i,"APP_E_DT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "적용종료일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( DS_STRSKUEVT.NameValue(i,"APP_E_DT") < getTodayFormat("YYYYMMDD")){
            showMessage(EXCLAMATION, OK, "USER-1030", "적용종료일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( DS_STRSKUEVT.NameValue(i,"APP_E_DT")< DS_STRSKUEVT.NameValue(i,"APP_S_DT")){
            showMessage(EXCLAMATION, OK, "USER-1020", "적용종료일", "적용시작일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( DS_STRSKUEVT.NameValue(i,"REDU_RATE")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "행사율");
            errYn = true;
            colid = "REDU_RATE";
            break;
        }
        if( Number(DS_STRSKUEVT.NameString( i, "EVENT_COST_PRC")) < 0 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "행사가 원가","0");
            errYn = true;
            colid = "EVENT_COST_PRC";
            break;
        }
        if( Number(DS_STRSKUEVT.NameString( i, "EVENT_PRICE")) < 1 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "행사가 판매가","1");
            colid = "EVENT_PRICE";
            errYn = true;
            break;     
        }
        if( Number(DS_STRSKUEVT.NameValue(i,"EVENT_MG_RATE"))< 0){
            var tmpCheck = showMessage(EXCLAMATION, YESNO, "USER-1000", "행사가 마진율이 0보다 작습니다. 진행하시겠습니까?");
            errYn = tmpCheck != 1;
            colid = "EVENT_MG_RATE";
            
            if(errYn)
                break;
        }
        if( Number(DS_STRSKUEVT.NameValue(i,"EVENT_MG_RATE"))>100){
            showMessage(EXCLAMATION, OK, "USER-1021", "행사가 마진율", 100);
            errYn = true;
            colid = "EVENT_MG_RATE";
            break;
        }
        
    }
    
    if(errYn){
        setFocusGrid(GD_STRSKUEVT,DS_STRSKUEVT,row,colid);
        return false;
    }
    return true;
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

<script language=JavaScript for=GD_STRPBNEVT event=OnHeadCheckClick(Col,Colid,bCheck)>
    var flag = bCheck == 1?'T':'F';
    for(var i=1; i<=DS_STRPBNEVT.CountRow; i++){
        if(DS_STRPBNEVT.NameValue(i,"APP_S_DT") > getTodayFormat("YYYYMMDD")){
            DS_STRPBNEVT.NameValue(i,"CONF_YN") = flag;
        }
    }
</script>
<script language=JavaScript for=GD_STRSKUEVT event=OnHeadCheckClick(Col,Colid,bCheck)>
    var flag = bCheck == 1?'T':'F';
    for(var i=1; i<=DS_STRSKUEVT.CountRow; i++){
        if(DS_STRSKUEVT.NameValue(i,"APP_S_DT") > getTodayFormat("YYYYMMDD")){
            DS_STRSKUEVT.NameValue(i,"CONF_YN") = flag;
        }
    }
</script>


<!-- 행사코드(조회) -->
<script language=JavaScript for=EM_EVENT_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setEventCode('NAME');
</script> 
 
<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPumbunCode('NAME');
</script> 

<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    if( bfStrCd != this.BindColVal){
        if( DS_STRPBNEVT.IsUpdated || DS_STRSKUEVT.IsUpdated){
            // 변경된 상세내역이 존재합니다. 점을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","점") != 1 ){
                setComboData(LC_STR_CD,bfStrCd);
                GD_MASTER.Focus();
                return;
            }
        }

        DS_MASTER.ClearData();
        DS_STRPBNEVT.ClearData();
        DS_STRSKUEVT.ClearData();
        EM_EVENT_CD.Text = "";
        EM_EVENT_NAME.Text = "";
        bfEventCd = "";    
        EM_PUMBUN_CD.Text = "";
        EM_PUMBUN_NAME.Text = "";
        bfPumbunCd = ""; 
    }
    bfStrCd = this.BindColVal;
</script>
 
<script language=JavaScript for=RD_EVENT_GUBUN event=OnSelChange()>
    if( DS_STRPBNEVT.IsUpdated || DS_STRSKUEVT.IsUpdated){
        // 변경된 상세내역이 존재합니다. 구분을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","구분") != 1 ){
            this.CodeValue = bfEventGb;
            GD_MASTER.Focus();
            return;
        }
    }
    DS_MASTER.ClearData();
    DS_STRPBNEVT.ClearData();
    DS_STRSKUEVT.ClearData();
    EM_PUMBUN_CD.Text   = "";
    EM_PUMBUN_NAME.Text = "";
    bfEventGb = this.CodeValue;
    setEventType(this.CodeValue);
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
<comment id="_NSID_"><object id="DS_STR_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STRPBNEVT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STRSKUEVT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width="60" class="point">점</th>
            <td width="140">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60" class="point" >구분</th>
            <td width="180" style="border-right:0px">
              <comment id="_NSID_"> 
                <object id="RD_EVENT_GUBUN" classid="<%=Util.CLSID_RADIO%>" width=180 height=18 align="absmiddle">
                  <param name="Cols" value="2">
                  <param name="Format" value="2^단품행사,1^브랜드행사">
                </object> 
              </comment><script>_ws_(_NSID_);</script>    
            </td>            
            <td width="60" style="border-left:0px;border-right:0px">&nbsp;
            </td>            
            <td style="border-left:0px;border-right:0px">&nbsp;
            </td>
          </tr>
          <tr>
            <th class="point">행사코드</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setEventCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=250 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th id=TH_PUMBUN class="point" width="60" >브랜드</th>
            <td  >
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPumbunCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="absmiddle"></object>
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
    <td class="PT01 PB03">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_MASTER width="100%" height=103 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_MASTER">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </td>  
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td valign="top"  class="PT05">
            <div id=TAB_MAIN  width="100%" height=370 TitleWidth=90 TitleAlign="center" >
              <menu TitleName="단품행사"       DivId="tab_page1" Enable='false' />
              <menu TitleName="브랜드행사"       DivId="tab_page2" Enable='false' />
            </div>
            <div id=tab_page1 width="100%" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_STRSKUEVT width="100%" height=342 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_STRSKUEVT">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
            </div>
            <div id=tab_page2 width="100%" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_STRPBNEVT width="100%" height=342 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_STRPBNEVT">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
            </div>
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

