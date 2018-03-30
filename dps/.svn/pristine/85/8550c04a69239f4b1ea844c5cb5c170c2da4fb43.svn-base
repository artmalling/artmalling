<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품가격> 긴급매가변경등록
 * 작 성 일 : 2010.01.18
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod6050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 단품의 긴급매가를 등록한다.
          (당일만 등록 가능)
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
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var bfStrCd;
 var bfPumbunCd;
 var bfEventGb;
 var bfEventCd;
 var onPopFlag = false;
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
            +',VEN_CD:STRING(6)'
            +',PUMMOK_CD:STRING(8)'
            +',SKU_CD:STRING(13)'
            +',SKU_NAME:STRING(40)'
            +',EVENT_CD:STRING(11)'
            +',EVENT_NAME:STRING(40)'
            +',EVENT_GUBUN:STRING(1)'
            +',SKU_TYPE:STRING(1)'
            +',A_BRAND_CD:STRING(2)'
            +',A_SUB_BRD_CD:STRING(2)'
            +',PLAN_YEAR_CD:STRING(1)'
            +',SEASON_CD:STRING(1)'
            +',ITEM_CD:STRING(2)'
            +',A_STYLE_CD:STRING(11)'
            +',A_STYLE_NAME:STRING(40)'
            +',B_BRAND_CD:STRING(2)'
            +',B_SUB_BRD_CD:STRING(2)'
            +',MNG_CD1:STRING(10)'
            +',MNG_CD2:STRING(10)'
            +',MNG_CD3:STRING(10)'
            +',MNG_CD4:STRING(10)'
            +',MNG_CD5:STRING(10)'
            +',B_STYLE_CD:STRING(54)'
            +',B_STYLE_NAME:STRING(40)');
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
    initEmEdit(EM_EVENT_CD         , "CODE^11"    , PK);          //행사코드
    initEmEdit(EM_EVENT_NAME       , "GEN^40"     , READ);        //행사명
    initEmEdit(EM_VEN_CD           , "CODE^6"     , NORMAL);      //협력사코드(조회)
    initEmEdit(EM_VEN_NAME         , "GEN"        , READ);        //협력사명(조회)
 
    initEmEdit(EM_A_STYLE_CD       , "CODE^11"    , NORMAL);      //스타일코드A
    initEmEdit(EM_A_STYLE_NAME     , "GEN^40"     , NORMAL);      //스타일명A
    
    initEmEdit(EM_MNG_CD1          , "CODE^10"    , NORMAL);      //관리항목1
    initEmEdit(EM_MNG_NAME1        , "GEN^40"     , READ);        //관리항목1명
    initEmEdit(EM_MNG_CD2          , "CODE^10"    , NORMAL);      //관리항목2
    initEmEdit(EM_MNG_NAME2        , "GEN^40"     , READ);        //관리항목2명
    initEmEdit(EM_MNG_CD3          , "CODE^10"    , NORMAL);      //관리항목3
    initEmEdit(EM_MNG_NAME3        , "GEN^40"     , READ);        //관리항목3명
    initEmEdit(EM_MNG_CD4          , "CODE^10"    , NORMAL);      //관리항목4
    initEmEdit(EM_MNG_NAME4        , "GEN^40"     , READ);        //관리항목4명
    initEmEdit(EM_MNG_CD5          , "CODE^10"    , NORMAL);      //관리항목5
    initEmEdit(EM_MNG_NAME5        , "GEN^40"     , READ);        //관리항목5명
    initEmEdit(EM_B_STYLE_CD       , "CODE^54"    , NORMAL);      //스타일코드B
    initEmEdit(EM_B_STYLE_NAME     , "GEN^40"     , NORMAL);      //스타일명B

    //콤보 초기화
    initComboStyle(LC_STR_CD       , DS_STR_CD       , "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle(LC_PUMMOK_CD    , DS_PUMMOK_CD    , "CODE^0^60,NAME^0^80", 1, NORMAL);  //품목(조회)
    initComboStyle(LC_A_BRAND_CD   , DS_A_BRAND_CD   , "CODE^0^30,NAME^0^80", 1, NORMAL);  //브랜드A(조회)
    initComboStyle(LC_A_SUB_BRD_CD , DS_A_SUB_BRD_CD , "CODE^0^30,NAME^0^80", 1, NORMAL);  //서브브랜드A(조회)
    initComboStyle(LC_PLAN_YEAR_CD , DS_PLAN_YEAR_CD , "CODE^0^30,NAME^0^80", 1, NORMAL);  //기획연도(조회)
    initComboStyle(LC_SEASON_CD    , DS_SEASON_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //시즌(조회)
    initComboStyle(LC_ITEM_CD      , DS_ITEM_CD      , "CODE^0^30,NAME^0^80", 1, NORMAL);  //아이템(조회)
    initComboStyle(LC_B_BRAND_CD   , DS_B_BRAND_CD   , "CODE^0^30,NAME^0^80", 1, NORMAL);  //브랜드B(조회)
    initComboStyle(LC_B_SUB_BRD_CD , DS_B_SUB_BRD_CD , "CODE^0^30,NAME^0^80", 1, NORMAL);  //서브브랜드B(조회)

    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_PUMMOK_CD.setDataHeader('CODE:STRING(8),NAME:STRING(40)');
    DS_A_BRAND_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_A_SUB_BRD_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_B_BRAND_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_B_SUB_BRD_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_PLAN_YEAR_CD", "D", "P012", "Y");
    getEtcCode("DS_SEASON_CD", "D", "P035", "Y");
    getEtcCode("DS_ITEM_CD", "D", "P036", "Y");
    
    // 기본값 입력( gauce.js )
    insComboData( LC_PUMMOK_CD, "%", "전체", 1 );
    insComboData( LC_A_BRAND_CD, "%", "전체", 1 );
    insComboData( LC_A_SUB_BRD_CD, "%", "전체", 1 );
    insComboData( LC_B_BRAND_CD, "%", "전체", 1 );
    insComboData( LC_B_SUB_BRD_CD, "%", "전체", 1 );
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_PUMMOK_CD,"%");
    setComboData(LC_A_BRAND_CD,"%");
    setComboData(LC_A_SUB_BRD_CD,"%");
    setComboData(LC_PLAN_YEAR_CD,"%");
    setComboData(LC_SEASON_CD,"%");
    setComboData(LC_ITEM_CD,"%");
    setComboData(LC_B_BRAND_CD,"%");
    setComboData(LC_B_SUB_BRD_CD,"%");
    
    RD_EVENT_GUBUN.CodeValue = '0';
    bfEventGb = '0';
    enableEventCnt(false);
    
    seachEnable();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod605","DS_MASTER" );
    LC_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=30  align=center edit=none        name="NO"        </FC>'
                     + '<FC>id=CHECK           width=30  align=center                  name="선택"      EditStyle=checkbox </FC>'
                     + '<FC>id=SKU_CD          width=120 align=center edit=Numeric     name="*단품코드" EditStyle=Popup edit={IF(SysStatus="I","true","false")} </FC>'
                     + '<FC>id=SKU_NAME        width=130 align=left   edit=none        name="단품명"    </FC>'
                     + '<C> id=STYLE_CD        width=110 align=left   edit=none        name="스타일"    show=false </C>'
                     + '<C> id=COLOR_NAME      width=90  align=left   edit=none        name="칼라"      show=false </C>'
                     + '<C> id=SIZE_NAME       width=90  align=left   edit=none        name="사이즈"    show=false </C>'
                     + '<C> id=APP_S_DT        width=90  align=center edit=none        name="시작일"    mask="XXXX/XX/XX"</C>'
                     + '<C> id=APP_E_DT        width=90  align=center edit=none        name="종료일"    mask="XXXX/XX/XX"</C>'
                     + '<G> name="변경전"   '                           
                     + '<C> id=AF_EMG_COST_PRC width=90  align=right  edit=none        name="판매원가"      </C>'
                     + '<C> id=AF_EMG_SALE_PRC width=90  align=right  edit=none        name="판매매가"      </C>'
                     + '<C> id=AF_EMG_MG_RATE  width=90  align=rignt  edit=none        name="마진율"    </C>'
                     + '</G>   '                                      
                     + '<G> name="변경후"   '                         
                     + '<C> id=BF_EMG_COST_PRC width=90  align=right  edit=none        name="판매원가"      </C>'
                     + '<C> id=BF_EMG_SALE_PRC width=90  align=right  edit=Numeric     name="*판매매가"     </C>'
                     + '<C> id=BF_EMG_MG_RATE  width=90  align=right  edit=RealNumeric name="*마진율"   edit={IF(BIZ_TYPE="1","false","true")} </C>'
                     + '</G>   ';

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
    if( RD_EVENT_GUBUN.CodeValue == '1' ){

        if( EM_EVENT_CD.Text == ""){
            // (행사코드)은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1003", "행사코드");
            EM_EVENT_CD.Focus();
            return;
        }

        if( EM_EVENT_NAME.Text == ""){
            // 존재하지 않는 행사입니다.
            showMessage(EXCLAMATION, OK, "USER-1036", "행사코드");
            EM_EVENT_CD.Focus();
            return;
        }    
    }
    DS_SEARCH_COND.UserStatus(1) = '1';
    var goTo       = "searchMaster" ;    
    var action     = "O";
    TR_MAIN.Action="/dps/pcod605.pc?goTo="+goTo;  
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
    // 저장할 데이터 없는 경우
    if (countSaveList() < 1 ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
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
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_MASTER.Focus();
        return;
    }
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
    	GD_MASTER.Focus();
        return;
    }
    
    var parameters = "&strPumbunCd="+encodeURIComponent(EM_PUMBUN_CD.Text)
    		       + "&strRdEventGubun="	+ encodeURIComponent(RD_EVENT_GUBUN.CodeValue);
    			
    
    TR_MAIN.Action="/dps/pcod605.pc?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }
    GD_MASTER.Focus();
    
    
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

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * countSaveList()
  * 작 성 자 : 
  * 작 성 일 : 2010-03-16
  * 개    요 : 저장할 리스트 수를 조회한다.
  * return값 : void
 */
function countSaveList(){
	if( DS_MASTER.CountRow<1)
		return 0;
	var cnt = 0;
	for(var i=1; i<=DS_MASTER.CountRow; i++){
		if(DS_MASTER.NameString( i,"CHECK")=="T"){
            cnt++;			
		}
	}
	return cnt;	
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
	    if(DS_MASTER.NameString( i,"CHECK")!="T")
	        continue;
	    
	    if(DS_MASTER.NameString( i, "SKU_CD")==""){
	        // (단품코드)은/는 반드시 입력해야 합니다.
	        showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
	        setFocusGrid(GD_DETAIL,DS_DETAIL,i,"SKU_CD");
	    	return false;
	    }
        if(DS_MASTER.NameString( i, "SKU_NAME")==""){
            // 존재하지 않는 단품코드 입니다.
            showMessage(EXCLAMATION, OK, "USER-1036", "단품코드");
            setFocusGrid(GD_DETAIL,DS_DETAIL,i,"SKU_CD");
            return false;
        }
        if( Number(DS_MASTER.NameString( i, "BF_EMG_COST_PRC")) < 0 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "변경 후 원가","0");
            setFocusGrid(GD_MASTER,DS_MASTER,i,'BF_EMG_COST_PRC');
            return false;                    
        }
        if( Number(DS_MASTER.NameString( i, "BF_EMG_SALE_PRC")) < 1 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "변경 후 매가","1");
            setFocusGrid(GD_MASTER,DS_MASTER,i,'BF_EMG_SALE_PRC');
            return false;                    
        }
        if( Number(DS_MASTER.NameString( i, "AF_EMG_SALE_PRC")) == Number(DS_MASTER.NameString( i, "BF_EMG_SALE_PRC")) ){
            showMessage(EXCLAMATION, Ok,  "USER-1000", "변경 전 매가와 변경 후 매가가 같습니다.");
            setFocusGrid(GD_MASTER,DS_MASTER,i,'BF_EMG_SALE_PRC');
            return false;                    
        }
        
     	// MARIO OUTLET 2011-08-11 
        // getRoundDec() 원단위 절사함수
        if(Number(DS_MASTER.NameString( i, "BF_EMG_SALE_PRC")) > 0) {
            if((Number(DS_MASTER.NameString( i, "BF_EMG_SALE_PRC"))%10) > 0) {
            	showMessage(EXCLAMATION, Ok,  "USER-1000", "변경 후 매가는 원단위로 입력 할 수 없습니다.");
            	setFocusGrid(GD_MASTER,DS_MASTER,i,"BF_EMG_SALE_PRC");
            	return false;	
            }
        }
     
        if( Number(DS_MASTER.NameString( i, "BF_EMG_MG_RATE")) < 0 ){
        	if(DS_MASTER.NameString( i, "BIZ_TYPE") == "1"){
                if(showMessage(QUESTION, YESNO, "USER-1000", "변경 후 마진율이 0 보다 작습니다.<br>진행하시겠습니까?") != 1){
                    setFocusGrid(GD_MASTER,DS_MASTER,i,'BF_EMG_MG_RATE');
                    return false;                    
                }
        	}else{
                showMessage(EXCLAMATION, Ok,  "USER-1020", "변경 후 마진율","0");
                setFocusGrid(GD_MASTER,DS_MASTER,i,'BF_EMG_MG_RATE');
                return false;                    
        	}
        }
        if( Number(DS_MASTER.NameString( i, "BF_EMG_MG_RATE")) > 100 ){
            showMessage(EXCLAMATION, Ok,  "USER-1021", "변경 후 마진율","100");
            setFocusGrid(GD_MASTER,DS_MASTER,i,'BF_EMG_MG_RATE');
            return false;                    
        }
	}
	
	return true;
	
}
/**
 * btn_addRow()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 행을 추가한다.
 * return값 : void
*/
function btn_addRow(){

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
   if( RD_EVENT_GUBUN.CodeValue == '1' ){

       if( EM_EVENT_CD.Text == ""){
           // (행사코드)은/는 반드시 입력해야 합니다.
           showMessage(EXCLAMATION, OK, "USER-1003", "행사코드");
           EM_EVENT_CD.Focus();
           return;
       }

       if( EM_EVENT_NAME.Text == ""){
           // 존재하지 않는 행사입니다.
           showMessage(EXCLAMATION, OK, "USER-1036", "행사코드");
           EM_EVENT_CD.Focus();
           return;
       }    
   }
   
   DS_MASTER.AddRow();
   setFocusGrid(GD_MASTER,DS_MASTER,DS_MASTER.CountRow,"SKU_CD");
}

/**
 * btn_delRow()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 행사코드 입력 상태 지정
 * return값 : void
*/
function btn_delRow(){

    if( DS_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_STR_CD.Focus();
        return;    	
    }
    if( DS_MASTER.RowStatus(DS_MASTER.RowPosition) != "1"){
        // 신규입력 데이터만 삭제 가능합니다.
        showMessage(INFORMATION, OK, "USER-1052");
        GD_MASTER.Focus();
        return;
    }    
    DS_MASTER.DeleteRow(DS_MASTER.RowPosition);
    GD_MASTER.Focus();
}
/**
 * enableEventCnt()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 행사코드 입력 상태 지정
 * return값 : void
*/
function enableEventCnt(flag){
    document.getElementById('TH_EVENT_CD').className= flag?'point':'';    
    enableControl(EM_EVENT_CD     , flag);  
    enableControl(IMG_EVENT_CD    , flag);
    if(!flag){
    	EM_EVENT_CD.Text = "";
        EM_EVENT_NAME.Text = "";
    }
}
/**
 * seachEnable()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 스타일 구분에 따른 입력 컴포넌트 지정
 * return값 : void
 */
function seachEnable( flag){
    enableControl(LC_A_BRAND_CD  , flag==null? false:flag);
    enableControl(LC_A_SUB_BRD_CD, flag==null? false:flag);
    enableControl(LC_PLAN_YEAR_CD, flag==null? false:flag);
    enableControl(LC_SEASON_CD   , flag==null? false:flag);
    enableControl(LC_ITEM_CD     , flag==null? false:flag);
    enableControl(EM_A_STYLE_CD  , flag==null? false:flag);
    enableControl(EM_A_STYLE_NAME, flag==null? false:flag);
    enableControl(IMG_A_STYLE_CD , flag==null? false:flag);
    enableControl(LC_B_BRAND_CD  , flag==null? false:!flag);
    enableControl(LC_B_SUB_BRD_CD, flag==null? false:!flag);
    enableControl(EM_MNG_CD1     , flag==null? false:!flag);
    enableControl(EM_MNG_CD2     , flag==null? false:!flag);
    enableControl(EM_MNG_CD3     , flag==null? false:!flag);
    enableControl(EM_MNG_CD4     , flag==null? false:!flag);
    enableControl(EM_MNG_CD5     , flag==null? false:!flag);
    enableControl(EM_B_STYLE_CD  , flag==null? false:!flag);
    enableControl(EM_B_STYLE_NAME, flag==null? false:!flag);
    enableControl(IMG_B_STYLE_CD , flag==null? false:!flag);
    enableControl(IMG_MNG_CD1    , flag==null? false:!flag);
    enableControl(IMG_MNG_CD2    , flag==null? false:!flag);
    enableControl(IMG_MNG_CD3    , flag==null? false:!flag);
    enableControl(IMG_MNG_CD4    , flag==null? false:!flag);
    enableControl(IMG_MNG_CD5    , flag==null? false:!flag);
    
    // 아무것도 선택되지 않으면 조회 값 초기화
    if(flag == null){
        setComboData(LC_A_BRAND_CD,"%");
        setComboData(LC_A_SUB_BRD_CD,"%");
        setComboData(LC_PLAN_YEAR_CD,"%");
        setComboData(LC_SEASON_CD,"%");
        setComboData(LC_ITEM_CD,"%");
        setComboData(LC_B_BRAND_CD,"%");
        setComboData(LC_B_SUB_BRD_CD,"%");
        EM_A_STYLE_CD.Text = "";
        EM_A_STYLE_NAME.Text = "";
        EM_B_STYLE_CD.Text = "";
        EM_B_STYLE_NAME.Text = "";
        EM_MNG_CD1.Text = "";
        EM_MNG_CD2.Text = "";
        EM_MNG_CD3.Text = "";
        EM_MNG_CD4.Text = "";
        EM_MNG_CD5.Text = "";
        EM_MNG_NAME1.Text = "";
        EM_MNG_NAME2.Text = "";
        EM_MNG_NAME3.Text = "";
        EM_MNG_NAME4.Text = "";
        EM_MNG_NAME5.Text = "";
    }else{
        // A 타입일 경우 B타입  입력 값 초기화
        if( flag){
            setComboData(LC_B_BRAND_CD,"%");
            setComboData(LC_B_SUB_BRD_CD,"%");
            EM_B_STYLE_CD.Text = "";
            EM_B_STYLE_NAME.Text = "";
            EM_MNG_CD1.Text = "";
            EM_MNG_CD2.Text = "";
            EM_MNG_CD3.Text = "";
            EM_MNG_CD4.Text = "";
            EM_MNG_CD5.Text = "";
            EM_MNG_NAME1.Text = "";
            EM_MNG_NAME2.Text = "";
            EM_MNG_NAME3.Text = "";
            EM_MNG_NAME4.Text = "";
            EM_MNG_NAME5.Text = "";     
        // B 타입 일경우 A 타입 입력 값 초기화
        }else{
            setComboData(LC_A_BRAND_CD,"%");
            setComboData(LC_A_SUB_BRD_CD,"%");
            setComboData(LC_PLAN_YEAR_CD,"%");
            setComboData(LC_SEASON_CD,"%");
            setComboData(LC_ITEM_CD,"%");       
            EM_A_STYLE_CD.Text = "";
            EM_A_STYLE_NAME.Text = "";  
        }
    }
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
    var pmkComboObj = LC_PUMMOK_CD;
    var strCd = LC_STR_CD.BindColVal;
    
    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 브랜드을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","브랜드") != 1 ){
        	codeObj.Text = bfPumbunCd;
            GD_MASTER.Focus();
            return;
        }
    }
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        DS_SEARCH_COND.NameValue(1,'SKU_TYPE') = '';
        eval(pmkComboObj.ComboDataID).ClearData();
        // 기본값 입력( gauce.js )
        insComboData( pmkComboObj, "%", "전체", 1 );
        setComboData( pmkComboObj,"%");
        DS_MASTER.ClearData();
        seachEnable();
        clearStyleCnt();
        return;     
    }
    
    var result = null;
    if( evnflag == "POP" ){
       result = strPbnPop2(codeObj,nameObj,'Y','', strCd,'','','','','Y','1');
       codeObj.Focus();
    }else if( evnflag == "NAME" ){
        result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'', strCd,'','','','','Y','1');
    }
    
    if( result != null || DS_SEARCH_NM.CountRow == 1){
        DS_MASTER.ClearData();
        var pumbunCd = codeObj.Text;
        var skuType = result != null ? result.get('SKU_TYPE'): DS_SEARCH_NM.NameValue(1,'SKU_TYPE');
        var styleType = result != null ? result.get('STYLE_TYPE'): DS_SEARCH_NM.NameValue(1,'STYLE_TYPE');
        // 신선 제외
        if( skuType == '2'){
        	showMessage(INFORMATION, OK, "USER-1000", "규격단품, 의류잡화단품만 긴급매가를 등록할 수 있습니다.");
        	codeObj.Text = "";
            nameObj.Text = "";
            DS_SEARCH_COND.NameValue(1,'SKU_TYPE') = '';
            eval(pmkComboObj.ComboDataID).ClearData();
            // 기본값 입력( gauce.js )
            insComboData( pmkComboObj, "%", "전체", 1 );
            setComboData( pmkComboObj,"%");
            DS_MASTER.ClearData();
            seachEnable();
            clearStyleCnt();
            return;
        }
        
        DS_SEARCH_COND.NameValue(1,'SKU_TYPE') = skuType;
        
        seachEnable(skuType!='3'?null:styleType=='1');
        
        getPbnPmkCode(pmkComboObj.ComboDataID,pumbunCd,"Y");
        if(skuType=='3'){
            GD_MASTER.ColumnProp('STYLE_CD', 'show') = "TRUE";
            if(styleType=='1'){
                GD_MASTER.ColumnProp('COLOR_NAME', 'show') = "TRUE";
                GD_MASTER.ColumnProp('SIZE_NAME', 'show') = "TRUE";
                //공통코드에서 가지고 오기( popup_dps.js )
                getStyleBrand("DS_A_BRAND_CD", pumbunCd, "Y");
                getStyleSubBrand("DS_A_SUB_BRD_CD", pumbunCd, "Y");
                
                //콤보데이터 기본값 설정( gauce.js )
                setComboData(LC_A_BRAND_CD,"%");
                setComboData(LC_A_SUB_BRD_CD,"%");
            }else{
                GD_MASTER.ColumnProp('COLOR_NAME', 'show') = "FALSE";
                GD_MASTER.ColumnProp('SIZE_NAME', 'show') = "FALSE";
                //공통코드에서 가지고 오기( popup_dps.js )
                getStyleBrand("DS_B_BRAND_CD", pumbunCd, "Y");
                getStyleSubBrand("DS_B_SUB_BRD_CD", pumbunCd, "Y");
                
                //콤보데이터 기본값 설정( gauce.js )
                setComboData(LC_B_BRAND_CD,"%");
                setComboData(LC_B_SUB_BRD_CD,"%");
                
            }
        }else{
            GD_MASTER.ColumnProp('STYLE_CD', 'show') = "FALSE";
            GD_MASTER.ColumnProp('COLOR_NAME', 'show') = "FALSE";
            GD_MASTER.ColumnProp('SIZE_NAME', 'show') = "FALSE";
        }
        bfPumbunCd = pumbunCd;
        //콤보데이터 기본값 설정( gauce.js )
        setComboData(pmkComboObj,"%");
        return;
    }
    if(nameObj.Text == ""){
        seachEnable();
        codeObj.Text = "";
        nameObj.Text = "";   
        DS_SEARCH_COND.NameValue(1,'SKU_TYPE') = '';
        eval(pmkComboObj.ComboDataID).ClearData();  
        insComboData( pmkComboObj, "%", "전체", 1 );
        setComboData( pmkComboObj,"%");   
        DS_MASTER.ClearData();
        clearStyleCnt();
    }
}
/**
 * clearAllSearchCnt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 조회 입력 화면을  초기화 한다.
 * return값 : void
**/
function clearAllSearchCnt(){
	DS_SEARCH_COND.ClearData();
    DS_SEARCH_COND.Addrow();
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_PUMMOK_CD,"%");
    RD_EVENT_GUBUN.CodeValue = '0';
    enableEventCnt(false);
    seachEnable();
	clearStyleCnt();
}
/**
 * clearStyleCnt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 의류잡화단품 정보를 초기화 한다.
 * return값 : void
**/
function clearStyleCnt(){
    GD_MASTER.ColumnProp('STYLE_CD', 'show') = "FALSE";
    GD_MASTER.ColumnProp('COLOR_NAME', 'show') = "FALSE";
    GD_MASTER.ColumnProp('SIZE_NAME', 'show') = "FALSE";
    DS_A_BRAND_CD.ClearData();
    DS_B_BRAND_CD.ClearData();
    DS_A_SUB_BRD_CD.ClearData();
    DS_B_SUB_BRD_CD.ClearData();
    // 기본값 입력( gauce.js )
    insComboData( LC_A_BRAND_CD, "%", "전체", 1 );
    insComboData( LC_A_SUB_BRD_CD, "%", "전체", 1 );
    insComboData( LC_B_BRAND_CD, "%", "전체", 1 );
    insComboData( LC_B_SUB_BRD_CD, "%", "전체", 1 );
    setComboData( LC_A_BRAND_CD,"%");
    setComboData( LC_A_SUB_BRD_CD,"%");
    setComboData( LC_B_BRAND_CD,"%");
    setComboData( LC_B_SUB_BRD_CD,"%");
	
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

    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 행사코드을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","행사코드") != 1 ){
            codeObj.Text = bfEventCd;
            GD_MASTER.Focus();
            return;
        }
    }
    DS_MASTER.ClearData();
    if( evnFlag == 'POP'){
    	eventPop(codeObj,nameObj,LC_STR_CD.BindColVal,'','','2','','','',getTodayFormat("YYYYMMDD"),'Y');
        codeObj.Focus();
        bfEventCd = codeObj.Text;
        return;
    }

    if( codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    setEventNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 1,LC_STR_CD.BindColVal,'','','2','','','',getTodayFormat("YYYYMMDD"),'Y');
    bfEventCd = codeObj.Text;

}
/**
 * setStyleCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 스타일 팝업을 실행한다.
 * return값 : void
**/
function setStyleCode(evnFlag,styleFlag){
    var codeObj = styleFlag=='A'?EM_A_STYLE_CD:EM_B_STYLE_CD;
    var nameObj = styleFlag=='A'?EM_A_STYLE_NAME:EM_B_STYLE_NAME;

    if( evnFlag == 'POP'){
        stylePop(codeObj,nameObj,'Y','',EM_PUMBUN_CD.Text,'Y');
        codeObj.Focus();
        return;
    }

    if( codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    setStyleNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 'Y', 0,'',EM_PUMBUN_CD.Text,'Y');

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
 * setSkuCodeGrid()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품 팝업을 실행한다.(그리드)
 * return값 : void
**/
function setSkuCodeGrid( row, evnFlag){
	//
	var codeValue = DS_MASTER.NameValue(row,"SKU_CD");
	 var retrnMap;
	if( evnFlag == 'POP'){
	    retrnMap = strSkuToGridPop( codeValue, "", "Y","",LC_STR_CD.BindColVal,EM_PUMBUN_CD.Text,"","","Y");
	}else{
        for(var i=1; i<=DS_MASTER.CountColumn; i++){
            if( DS_MASTER.ColumnID(i) == 'SKU_CD' && codeValue != "")
                continue;
            DS_MASTER.NameValue(row,DS_MASTER.ColumnID(i))="";
        }
        if( codeValue == ""){
            GD_MASTER.Focus();
            return;
        }
        retrnMap = setStrSkuNmWithoutToGridPop( "DS_SEARCH_NM", codeValue, "", "Y", "1", "",LC_STR_CD.BindColVal,EM_PUMBUN_CD.Text,"","","Y");
	}
	
    if( retrnMap == null){
        if( DS_MASTER.NameValue(row,"SKU_NAME")==""){
            for(var i=1; i<=DS_MASTER.CountColumn; i++){
                DS_MASTER.NameValue(row,DS_MASTER.ColumnID(i))="";
            }
        }
        GD_MASTER.Focus();
        return;
    }
    
    DS_MASTER.NameValue(row,"SKU_CD")  = retrnMap.get("SKU_CD");
    DS_MASTER.NameValue(row,"SKU_NAME")= retrnMap.get("SKU_NAME");
    var dupRow = checkDupKey( DS_MASTER,"SKU_CD");
    if( dupRow > 0){
        showMessage(EXCLAMATION, OK,  "USER-1044");
        DS_MASTER.NameValue(row,"SKU_CD")  = "";
        DS_MASTER.NameValue(row,"SKU_NAME")= "";
        GD_MASTER.Focus();
    	return;
    }
    var eventCd = "";
    if(DS_SEARCH_COND.NameValue(1,"EVENT_GUBUN")=='0'){
    	eventCd = "00000000000";
    }else{
    	eventCd=DS_SEARCH_COND.NameValue(1,"EVENT_CD");
    }
    
    var goTo       = "searchSkuMaster" ;    
    var action     = "O";
    var parameter  = "&strStrCd="+encodeURIComponent(DS_SEARCH_COND.NameValue(1,"STR_CD"))
                   + "&strEventCd="+encodeURIComponent(eventCd)
                   + "&strSkuType="+encodeURIComponent(DS_SEARCH_COND.NameValue(1,"SKU_TYPE"))
                   + "&strPumbunCd="+encodeURIComponent(DS_SEARCH_COND.NameValue(1,"PUMBUN_CD"))
                   + "&strSkuCd="+encodeURIComponent(retrnMap.get("SKU_CD"));
    TR_MAIN.Action="/dps/pcod605.pc?goTo="+goTo+parameter;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_RESULT=DS_SEARCH_NM)"; //조회는 O
    TR_MAIN.Post();
    
    if( DS_SEARCH_NM.CountRow != 1){
        showMessage(EXCLAMATION, OK,  "USER-1000", "("+ retrnMap.get("SKU_CD") + ") 의 가격 정보나 행사 정보를 확인하십시요." );
        for(var i=1; i<=DS_MASTER.CountColumn; i++){
            DS_MASTER.NameValue(row,DS_MASTER.ColumnID(i))="";
        }
        return;
    }

    for(var i=1; i<=DS_MASTER.CountColumn; i++){
        DS_MASTER.NameValue(row,DS_MASTER.ColumnID(i)) = DS_SEARCH_NM.NameValue(1,DS_MASTER.ColumnID(i));
    }
}

 /**
  * setVenCode()
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-04-04
  * 개    요 : 협력사 팝업을 실행한다.
  * return값 : void
 **/
 function setVenCode(evnFlag){
     var codeObj = EM_VEN_CD;
     var nameObj = EM_VEN_NAME;

     if( evnFlag == 'POP'){
         venPop(codeObj,nameObj,LC_STR_CD.BindColVal,'Y');
         codeObj.Focus();
         return;
     }

     if( codeObj.Text ==""){
         nameObj.Text = "";      
         return;
     }
     
     setVenNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 1,LC_STR_CD.BindColVal,'Y');

 }
/**
 * setInitCommonPop()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 공통코드 팝업 및 이름  조회
 * return값 : void
 */
function setInitCommonPop(title, comId, evnflag, codeObj, nameObj, svcFlg){
    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }
    var comSqlId = svcFlg == 'S' ? 'SEL_COMM_CODE_USE_NONE_ONLY' : (svcFlg == 'I'?'SEL_COMM_CODE_ONLY':'SEL_COMM_CODE_USE_REFER_ONLY');
    var mngCd1   = svcFlg == 'S2'?EM_MNG_CD1.Text:'';
    mngCd1 = mngCd1 == ''? '**********' : mngCd1;
    
    if( evnflag == "POP" ){
        if( svcFlg =='S'|| svcFlg == 'I' )
            commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
        else
            commonPop(title,comSqlId,codeObj ,nameObj,'D',comId, svcFlg == 'S2'?'':'Y', mngCd1 );
        
        codeObj.Focus();
        return;
    }

    nameObj.Text = "";

    if( svcFlg =='S'|| svcFlg == 'I' )
        setNmWithoutPop('DS_SEARCH_NM',title,comSqlId,codeObj ,nameObj,'D',comId);
    else
        setNmWithoutPop('DS_SEARCH_NM',title,comSqlId,codeObj ,nameObj,'D',comId, svcFlg == 'S2'?'':'Y', mngCd1 );
    
    
    if( DS_SEARCH_NM.CountRow == 1){
        codeObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
        nameObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
        return;
    }
    if( svcFlg =='S'|| svcFlg == 'I' )
        commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
    else
        commonPop(title,comSqlId,codeObj ,nameObj,'D',comId, svcFlg == 'S2'?'':'Y', mngCd1 );

    codeObj.Focus();
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
<script language=JavaScript for=DS_MASTER event=OnDataError(row,colid)>
    var errorCode = DS_MASTER.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_MASTER.ErrorMsg);       
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,oldData)>
    if(row < 1)
        return;
    if( onPopFlag)
    	return;    
    if( oldData == DS_MASTER.NameValue(row,colid))
        return;
    switch(colid){
        case 'SKU_CD':
            setSkuCodeGrid( row, 'NAME');
        	break;
        case 'BF_EMG_SALE_PRC':
        case 'BF_EMG_MG_RATE':
        	if( DS_MASTER.NameValue(row,"SKU_CD") == ""){
                showMessage(INFORMATION, OK, "USER-1000", "단품코드 조회 후 입력하세요");
                DS_MASTER.NameString(row,"BF_EMG_SALE_PRC") = 0;
                DS_MASTER.NameString(row,"BF_EMG_MG_RATE") = 0;
                return;
        	}
        	
            var bizType = DS_MASTER.NameValue(row,"BIZ_TYPE");
            var taxFlag = DS_MASTER.NameValue(row,"TAX_FLAG");
            var roundFlag = DS_MASTER.NameValue(row,"ROUND_FLAG");
            var costPrc = DS_MASTER.NameString(row,"BF_EMG_COST_PRC");
            var salePrc = DS_MASTER.NameString(row,"BF_EMG_SALE_PRC");
            var mgRate = DS_MASTER.NameString(row,"BF_EMG_MG_RATE");

            costPrc = Number(costPrc);
            salePrc = Number(salePrc);
            mgRate = Number(mgRate);
            // 거래형태[직매입]
            if( bizType == "1"){
                // 판매원가와 판매매가을 등록하면 마진율을 계산
                DS_MASTER.NameValue(row,"BF_EMG_MG_RATE") = getSaleMgRate(costPrc, salePrc, roundFlag, taxFlag);
            // 거래형태[특정매입]
            }else {
                // 판매매가와 마진율을 등록하면 판매원가을 계산
                DS_MASTER.NameValue(row,"BF_EMG_COST_PRC") = getSalCostPrc(salePrc, mgRate, roundFlag, taxFlag);
            }
            
            if( (DS_MASTER.NameValue(row,"BF_EMG_MG_RATE") == 0 && DS_MASTER.NameValue(row,"BF_EMG_SALE_PRC") == 0 )){
                DS_MASTER.NameValue(row,"CHECK") = "F";
            }else{
                DS_MASTER.NameValue(row,"CHECK") = "T";
            }
            break;
    }
</script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    onPopFlag = true;
    setSkuCodeGrid( row, 'POP');
    onPopFlag = false;    
</script>
<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setPumbunCode("NAME");
</script>
<!-- 협력사(조회) -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setVenCode('NAME');
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
<!-- 스타일A(조회) -->
<script language=JavaScript for=EM_A_STYLE_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setStyleCode('NAME','A');
</script>
<!-- 스타일B(조회) -->
<script language=JavaScript for=EM_B_STYLE_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setStyleCode('NAME','B');
</script>
<!-- 관리항목1(조회) -->
<script language=JavaScript for=EM_MNG_CD1 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목1','P005','NAME',EM_MNG_CD1,EM_MNG_NAME1,'S');
</script>
<!-- 관리항목2(조회) -->
<script language=JavaScript for=EM_MNG_CD2 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목2','P006','NAME',EM_MNG_CD2,EM_MNG_NAME2,'S2');
</script>
<!-- 관리항목3(조회) -->
<script language=JavaScript for=EM_MNG_CD3 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목3','P007','NAME',EM_MNG_CD3,EM_MNG_NAME3,'S2');
</script>
<!-- 관리항목4(조회) -->
<script language=JavaScript for=EM_MNG_CD4 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목4','P008','NAME',EM_MNG_CD4,EM_MNG_NAME4,'S2');
</script>
<!-- 관리항목5(조회) -->
<script language=JavaScript for=EM_MNG_CD5 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목5','P009','NAME',EM_MNG_CD5,EM_MNG_NAME5,'S2');
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
        DS_MASTER.ClearData();
    }
    bfStrCd = this.BindColVal;
</script>
 
<script language=JavaScript for=RD_EVENT_GUBUN event=OnSelChange()>
    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 구분을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","구분") != 1 ){
        	this.CodeValue = bfEventGb;
            GD_MASTER.Focus();
            return;
        }
    }
    DS_MASTER.ClearData();
    bfEventGb = this.CodeValue;
    enableEventCnt(this.CodeValue=='1');
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
<comment id="_NSID_"><object id="DS_PUMMOK_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_A_BRAND_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_A_SUB_BRD_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_B_BRAND_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_B_SUB_BRD_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PLAN_YEAR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEASON_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_ITEM_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_SEARCH_COND" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width="53" class="point" >점</th>
            <td width="190">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="57" class="point">브랜드</th>
            <td width="190">
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%= Util.CLSID_EMEDIT %> width=52 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setPumbunCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%= Util.CLSID_EMEDIT %> width=105 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="53">품목</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_PUMMOK_CD classid=<%= Util.CLSID_LUXECOMBO %> width=200 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th class="point" >구분</th>
            <td >
              <comment id="_NSID_"> 
                <object id="RD_EVENT_GUBUN" classid="<%=Util.CLSID_RADIO%>" width=160 height=18 align="absmiddle">
                  <param name="Cols" value="2">
                  <param name="Format" value="0^정상,1^행사">
                </object> 
              </comment><script>_ws_(_NSID_);</script>    
            </td>
            <th id=TH_EVENT_CD >행사코드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_EVENT_CD classid=<%= Util.CLSID_EMEDIT %> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_EVENT_CD onclick="javascipt:setEventCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_EVENT_NAME classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >단품</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_SKU_CD classid=<%= Util.CLSID_EMEDIT %> width=94 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setSkuCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_SKU_NAME classid=<%= Util.CLSID_EMEDIT %> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>          
            <th>협력사</th>
            <td colspan="5">
              <comment id="_NSID_">
                <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"> </object>
              </comment> <script> _ws_(_NSID_);</script><img
              src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:setVenCode('POP')" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1 align="absmiddle"> </object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="53" >브랜드</th>
            <td width="190">
              <comment id="_NSID_">
                <object id=LC_A_BRAND_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="65">서브브랜드</th>
            <td width="190">
              <comment id="_NSID_">
                <object id=LC_A_SUB_BRD_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="53">기획년도</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_PLAN_YEAR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=200 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >시즌</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_SEASON_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >아이템</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_ITEM_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >스타일</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_A_STYLE_CD classid=<%= Util.CLSID_EMEDIT %> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_A_STYLE_CD onclick="javascipt:setStyleCode('POP','A');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_A_STYLE_NAME classid=<%= Util.CLSID_EMEDIT %> width=94 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="53" >브랜드</th>
            <td width="200">
              <comment id="_NSID_">
                <object id=LC_B_BRAND_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="65">서브브랜드</th>
            <td width="210">
              <comment id="_NSID_">
                <object id=LC_B_SUB_BRD_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="53">관리항목1</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MNG_CD1 classid=<%=Util.CLSID_EMEDIT%> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MNG_CD1 onclick="javascript:setInitCommonPop('관리항목1','P005','POP',EM_MNG_CD1,EM_MNG_NAME1,'S');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MNG_NAME1 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >관리항목2</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MNG_CD2 classid=<%=Util.CLSID_EMEDIT%> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MNG_CD2 onclick="javascript:setInitCommonPop('관리항목2','P006','POP',EM_MNG_CD2,EM_MNG_NAME2,'S2');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MNG_NAME2 classid=<%=Util.CLSID_EMEDIT%> width=84 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >관리항목3</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MNG_CD3 classid=<%=Util.CLSID_EMEDIT%> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MNG_CD3 onclick="javascript:setInitCommonPop('관리항목3','P007','POP',EM_MNG_CD3,EM_MNG_NAME3,'S2');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MNG_NAME3 classid=<%=Util.CLSID_EMEDIT%> width=84 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >관리항목4</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MNG_CD4 classid=<%=Util.CLSID_EMEDIT%> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MNG_CD4 onclick="javascript:setInitCommonPop('관리항목4','P008','POP',EM_MNG_CD4,EM_MNG_NAME4,'S2');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MNG_NAME4 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >관리항목5</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MNG_CD5 classid=<%=Util.CLSID_EMEDIT%> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MNG_CD5 onclick="javascript:setInitCommonPop('관리항목5','P009','POP',EM_MNG_CD5,EM_MNG_NAME5,'S2');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MNG_NAME5 classid=<%=Util.CLSID_EMEDIT%> width=84 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >스타일</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_B_STYLE_CD classid=<%= Util.CLSID_EMEDIT %> width=167 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_B_STYLE_CD onclick="javascipt:setStyleCode('POP','B');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_B_STYLE_NAME classid=<%= Util.CLSID_EMEDIT %> width=259 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
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
    <td class="right PT03 PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif" onClick="javascript:btn_addRow();" hspace="2" /><img src="/<%=dir%>/imgs/btn/del_row.gif" onClick="javascript:btn_delRow();" />
    </td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_MASTER width="100%" height=277 classid=<%=Util.CLSID_GRID%>>
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
            <c>col=VEN_CD          ctrl=EM_VEN_CD         param=Text       </c>
            <c>col=PUMMOK_CD       ctrl=LC_PUMMOK_CD      param=BindColVal </c>
            <c>col=SKU_CD          ctrl=EM_SKU_CD         param=Text       </c>
            <c>col=SKU_NAME        ctrl=EM_SKU_NAME       param=Text       </c>
            <c>col=EVENT_CD        ctrl=EM_EVENT_CD       param=Text       </c>
            <c>col=EVENT_NAME      ctrl=EM_EVENT_NAME     param=Text       </c>
            <c>col=EVENT_GUBUN     ctrl=RD_EVENT_GUBUN    param=CodeValue  </c>
            <c>col=A_BRAND_CD      ctrl=LC_A_BRAND_CD     param=BindColVal </c>
            <c>col=A_SUB_BRD_CD    ctrl=LC_A_SUB_BRD_CD   param=BindColVal </c>
            <c>col=PLAN_YEAR_CD    ctrl=LC_PLAN_YEAR_CD   param=BindColVal </c>
            <c>col=SEASON_CD       ctrl=LC_SEASON_CD      param=BindColVal </c>
            <c>col=ITEM_CD         ctrl=LC_ITEM_CD        param=BindColVal </c>
            <c>col=A_STYLE_CD      ctrl=EM_A_STYLE_CD     param=Text       </c>
            <c>col=A_STYLE_NAME    ctrl=EM_A_STYLE_NAME   param=Text       </c>
            <c>col=B_BRAND_CD      ctrl=LC_B_BRAND_CD     param=BindColVal </c>
            <c>col=B_SUB_BRD_CD    ctrl=LC_B_SUB_BRD_CD   param=BindColVal </c>
            <c>col=MNG_CD1         ctrl=EM_MNG_CD1        param=Text       </c>
            <c>col=MNG_CD2         ctrl=EM_MNG_CD2        param=Text       </c>
            <c>col=MNG_CD3         ctrl=EM_MNG_CD3        param=Text       </c>
            <c>col=MNG_CD4         ctrl=EM_MNG_CD4        param=Text       </c>
            <c>col=MNG_CD5         ctrl=EM_MNG_CD5        param=Text       </c>
            <c>col=B_STYLE_CD      ctrl=EM_B_STYLE_CD     param=Text       </c>
            <c>col=B_STYLE_NAME    ctrl=EM_B_STYLE_NAME   param=Text       </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

