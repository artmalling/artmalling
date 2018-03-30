<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품가격> 긴급매가변경확정
 * 작 성 일 : 2010.04.19
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod6070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 등록된 긴급매가를 확정한다.
          (당일만 확정 가능)
 * 이    력 :
 *        2010.04.19 (정진영) 신규작성
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
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var bfStrCd;
 var bfPumbunCd;
 var bizType;
 var bfConfYn;
 var bfAppDt = getTodayFormat("YYYYMMDD");
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){


    // Input Data Set Header 초기화
    DS_SEARCH_COND.setDataHeader(
            'STR_CD:STRING(2)'
            +',PUMBUN_CD:STRING(6)'
            +',CONF_YN:STRING(1)'
            +',SKU_CD:STRING(13)'
            +',SKU_NAME:STRING(40)'
            +',EVENT_CD:STRING(11)'
            +',EVENT_NAME:STRING(40)'
            +',APP_DT:STRING(8)');
    DS_SEARCH_COND.ClearData();
    DS_SEARCH_COND.Addrow();

    // Output Data Set Header 초기화    
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_PUMBUN_CD        , "CODE^6"     , PK);          //브랜드코드
    initEmEdit(EM_PUMBUN_NAME      , "GEN"        , READ);        //브랜드명
    initEmEdit(EM_SKU_CD           , "CODE^13^0"  , NORMAL);      //단품코드
    initEmEdit(EM_SKU_NAME         , "GEN^40"     , NORMAL);      //단품명
    initEmEdit(EM_EVENT_CD         , "CODE^11"    , NORMAL);      //행사코드
    initEmEdit(EM_EVENT_NAME       , "GEN^40"     , NORMAL);      //행사명
    initEmEdit(EM_APP_DT           , "TODAY"      , PK);          //적용일

    //콤보 초기화
    initComboStyle(LC_STR_CD       , DS_STR_CD    , "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle(LC_CONF_YN      , DS_CONF_YN   , "CODE^0^30,NAME^0^80", 1, NORMAL);  //확정여부


    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_CONF_YN", "D", "D022", "Y");
    
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_CONF_YN,"N");
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod607","DS_MASTER" );
    
    LC_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     width=25  align=center edit=none   name="NO"        </FC>'
                     + '<FC>id=CHECK        width=45  align=center             name="선택"      EditStyle=checkbox HeadCheckShow=true edit={IF(CONF_YN="N" AND APP_S_DT="'+getTodayFormat("YYYYMMDD")+'","true","false")}</FC>'
                     + '<FC>id=STR_CD       width=70  align=left   edit=none   name="점"        EditStyle=Lookup data="DS_STR_CD:CODE:NAME" </FC>'
                     + '<FC>id=SKU_CD       width=100 align=center edit=none   name="단품코드"  </FC>'
                     + '<FC>id=SKU_NAME     width=145 align=left   edit=none   name="단품명"    </FC>'
                     + '<C> id=APP_S_DT     width=75  align=center edit=none   name="시작일"    mask="XXXX/XX/XX"</C>'
                     + '<C> id=SEQ_NO       width=55  align=right  edit=none   name="순번"     </C>'
                     + '<C> id=APP_E_DT     width=75  align=center edit=none   name="종료일"    mask="XXXX/XX/XX"</C>'
                     + '<C> id=EMG_COST_PRC width=80  align=right  edit=none   name="판매원가"      </C>'
                     + '<C> id=EMG_SALE_PRC width=80  align=right  edit=none   name="판매매가"      </C>'
                     + '<C> id=EMG_MG_RATE  width=80  align=right  edit=none   name="마진율"    </C>'
                     + '<C> id=CONF_YN      width=70  align=center edit=none   name="확정여부"  </C>'
                     + '<C> id=EVENT_CD     width=90  align=center edit=none   name="행사코드"  </C>'
                     + '<C> id=EVENT_NAME   width=90  align=left   edit=none   name="행사명"    </C>';

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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if( DS_MASTER.IsUpdated ){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1059")!=1){
            GD_MASTER.Focus();
            return;
        }
    }  
    if( LC_STR_CD.BindColVal == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD.Focus();
        return;
    }
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
    if( EM_APP_DT.Text == ""){
        // (적용일)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "적용일");
        EM_APP_DT.Focus();
        return;
    }
    clearMasterGrid();
    DS_SEARCH_COND.UserStatus(1) = '1';
    var goTo       = "searchMaster" ;    
    var action     = "O";
    TR_MAIN.Action="/dps/pcod607.pc?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_SEARCH_COND=DS_SEARCH_COND,"+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);    
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
    if ( !DS_MASTER.IsUpdated ){
        //확정할 데이터를 선택하세요
        showMessage(INFORMATION, OK, "USER-1090");
        if( DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
            return;
        }           
        GD_MASTER.Focus();
        return;
    }
    
    if(!checkMasterValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1083", "", "");
        GD_MASTER.Focus();
        return;
    }
    //확정하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1024") != 1 ){
        GD_MASTER.Focus();
        return;
    }
    
    TR_MAIN.Action="/dps/pcod607.pc?goTo=conf";
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }
    GD_MASTER.Focus();
    
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

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
    
    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 브랜드을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","브랜드") != 1 ){
            codeObj.Text = bfPumbunCd;
            GD_MASTER.Focus();
            return;
        }
    }
    clearMasterGrid();
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        bfPumbunCd = "";
        bizType = "";
        return;     
    }
    
    var result = null;
    if( evnflag == "POP" ){
    	result = strPbnPop2(codeObj,nameObj,'Y','', strCd,'','','','','Y','1');
       codeObj.Focus();
    }else if( evnflag == "NAME" ){
    	result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'', strCd,'','','','','Y','1');
    }
    
    if( bfPumbunCd != codeObj.Text)
        bizType = result!=null?result.get("BIZ_TYPE"):DS_SEARCH_NM.NameValue(1,"BIZ_TYPE");
        
    bfPumbunCd = codeObj.Text;
    
}
/**
 * setStrSkuCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품 팝업을 실행한다.
 * return값 : void
**/
function setSkuCode(evnFlag){
    var codeObj = EM_SKU_CD;
    var nameObj = EM_SKU_NAME;

    if( evnFlag == 'POP'){
        strSkuPop(codeObj,nameObj,'Y','','',EM_PUMBUN_CD.Text, '','','Y');
        codeObj.Focus();
        return;
    }

    if( codeObj.Text ==""){
        nameObj.Text = "";
        return;
    }
    
    setStrSkuNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 'Y', 0,'','',EM_PUMBUN_CD.Text, '','','Y');

}

/**
 * setEventCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 행사 팝업을 실행한다.
 * return값 : void
**/
function setEventCode(evnFlag){
    var codeObj = EM_EVENT_CD;
    var nameObj = EM_EVENT_NAME;

    if( evnFlag == 'POP'){
        eventPop(codeObj,nameObj,LC_STR_CD.BindColVal,'','','2','','','',EM_APP_DT.Text,'Y');
        codeObj.Focus();
        return;
    }

    if( codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    setEventNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 0,LC_STR_CD.BindColVal,'','','2','','','',EM_APP_DT.Text,'Y');

}

/**
 * setCalAppDt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 달력 팝업을 실행한다.
 * return값 : void
**/
function setCalAppDt(evnFlag){
    var obj = EM_APP_DT;
    
    if( evnFlag == 'POP'){
        openCal('G',obj);
    }
    
    if(!checkDateTypeYMD( obj , bfAppDt))
        return;
    
    
    if( bfAppDt != obj.Text){
        if( DS_MASTER.IsUpdated ){
            // 변경된 상세내역이 존재합니다. 적용일을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","적용일") != 1 ){
                obj.Text = bfAppDt;
                GD_MASTER.Focus();
                return;
            }
        }
    }
    clearMasterGrid();
    bfAppDt = obj.Text;

}

/**
 * clearMasterGrid()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 그리드를 초기화한다.
 * return값 : void
**/
function clearMasterGrid(){
    GD_MASTER.ColumnProp("CHECK","HeadCheck") = "false";
    DS_MASTER.ClearData();  
}

/**
 * checkMasterValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 저장할 데이터의 값을 검증한다.
 * return값 : void
*/
function checkMasterValidation(){
    for(var i=1; i<=DS_MASTER.CountRow; i++){
        if(DS_MASTER.RowStatus(i) != 3)
            continue;
        
        if( Number(DS_MASTER.NameString( i, "EMG_COST_PRC")) < 0 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "원가","0");
            setFocusGrid(GD_MASTER,DS_MASTER,i,'EMG_COST_PRC');
            return false;                    
        }
        if( Number(DS_MASTER.NameString( i, "EMG_SALE_PRC")) < 1 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "매가","1");
            setFocusGrid(GD_MASTER,DS_MASTER,i,'EMG_SALE_PRC');
            return false;                    
        }
        if( Number(DS_MASTER.NameString( i, "EMG_MG_RATE")) < 0 ){
            if(bizType == "1"){
                if(showMessage(QUESTION, YESNO, "USER-1000", "마진율이 0 보다 작습니다.<br>진행하시겠습니까?") != 1){
                    setFocusGrid(GD_MASTER,DS_MASTER,i,'EMG_MG_RATE');
                    return false;                    
                }
            }else{
                showMessage(EXCLAMATION, Ok,  "USER-1020", "마진율","0");
                setFocusGrid(GD_MASTER,DS_MASTER,i,'EMG_MG_RATE');
                return false;                    
            }
        }
        if( Number(DS_MASTER.NameString( i, "EMG_MG_RATE")) > 100 ){
            showMessage(EXCLAMATION, Ok,  "USER-1021", "마진율","100");
            setFocusGrid(GD_MASTER,DS_MASTER,i,'EMG_MG_RATE');
            return false;                    
        }
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

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    var flag = bCheck == 1?'T':'F';
    for(var i=1; i<=DS_MASTER.CountRow; i++){
    	if(DS_MASTER.NameValue(i,"APP_S_DT")== getTodayFormat("YYYYMMDD")
    			&& DS_MASTER.NameValue(i,"CONF_YN")== "N" ){
    		DS_MASTER.NameValue(i,"CHECK") = flag;
    	}else{
            DS_MASTER.NameValue(i,"CHECK") = "F";
    	}
    }
</script>

<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setPumbunCode("NAME");
</script>
<!-- 단품(조회) -->
<script language=JavaScript for=EM_SKU_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setSkuCode('NAME');
</script>
<!-- 행사코드(조회) -->
<script language=JavaScript for=EM_EVENT_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setEventCode('NAME');
</script>
<!-- 적용일(조회) -->
<script language=JavaScript for=EM_APP_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalAppDt('NAME');
</script>

<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    if( bfStrCd != this.BindColVal){
        if( DS_MASTER.IsUpdated ){
            // 변경된 상세내역이 존재합니다. 점을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","점") != 1 ){
                setComboData(LC_STR_CD,bfStrCd);
                GD_MASTER.Focus();
                return;
            }
        }
        clearMasterGrid();
    }
    bfStrCd = this.BindColVal;
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
<comment id="_NSID_"><object id="DS_STR_CD"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CONF_YN"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_SEARCH_COND"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width="80" class="point" >점</th>
            <td width="195">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=195 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">브랜드</th>
            <td width="200">
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%= Util.CLSID_EMEDIT %> width=52 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setPumbunCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%= Util.CLSID_EMEDIT %> width=105 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">확정여부</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_CONF_YN classid=<%= Util.CLSID_LUXECOMBO %> width=205 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >단품</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_SKU_CD classid=<%= Util.CLSID_EMEDIT %> width=92 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setSkuCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_SKU_NAME classid=<%= Util.CLSID_EMEDIT %> width=75 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >행사코드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_EVENT_CD classid=<%= Util.CLSID_EMEDIT %> width=77 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setEventCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_EVENT_NAME classid=<%= Util.CLSID_EMEDIT %> width=90 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th class="point">적용일</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_APP_DT classid=<%= Util.CLSID_EMEDIT %> width=179 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setCalAppDt('POP');" align="absmiddle" />
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
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_MASTER width="100%" height=479 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object></comment><script>_ws_(_NSID_);</script>
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
<object id=BO_SEARCH_COND classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_SEARCH_COND>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=STR_CD          ctrl=LC_STR_CD         param=BindColVal </c>
            <c>col=PUMBUN_CD       ctrl=EM_PUMBUN_CD      param=Text       </c>
            <c>col=CONF_YN         ctrl=LC_CONF_YN        param=BindColVal </c>
            <c>col=SKU_CD          ctrl=EM_SKU_CD         param=Text       </c>
            <c>col=SKU_NAME        ctrl=EM_SKU_NAME       param=Text       </c>
            <c>col=EVENT_CD        ctrl=EM_EVENT_CD       param=Text       </c>
            <c>col=EVENT_NAME      ctrl=EM_EVENT_NAME     param=Text       </c>
            <c>col=APP_DT          ctrl=EM_APP_DT         param=Text       </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>


