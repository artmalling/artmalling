<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 행사코드> 점별행사관리(단품)
 * 작 성 일 : 2010.01.18
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod7060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 점별 단품행사 정보를 등록한다
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
var bfEventCd = "";
var bfStrCd = "";
var bfPumbunCd = "";
var onPopup   = false;
var skuType   = "";
var bizType   = "";
var taxFlag   = "";
var roundFlag = "";
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_EVTMST.setDataHeader('<gauce:dataset name="H_SEL_EVTMST"/>');
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_TEMP.setDataHeader('<gauce:dataset name="H_SEL_TEMP"/>');
    
    
    //그리드 초기화
    gridCreate1(); //행사정보
    gridCreate2(); //점별브랜드행사
   
    

    // EMedit에 초기화
    initEmEdit(EM_EVENT_CD      , "CODE^11"  ,  PK);        //행사코드
    initEmEdit(EM_EVENT_NAME    , "GEN^40"   ,  READ);      //행사명
    initEmEdit(EM_PUMBUN_CD     , "CODE^6^0" ,  NORMAL);        //브랜드코드
    initEmEdit(EM_PUMBUN_NAME   , "GEN^40"   ,  READ);      //브랜드명
    initEmEdit(EM_EVENT_CD_CP   , "CODE^11"  ,  PK);        //행사코드(복사)
    initEmEdit(EM_EVENT_NAME_CP , "GEN^40"   ,  READ);      //행사명(복사)

    //콤보 초기화
    initComboStyle(LC_STR_CD   ,DS_STR_CD   , "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle(LC_STR_CD_CP,DS_STR_CD_CP, "CODE^0^30,NAME^0^80", 1, PK);  //점(복사)

    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "N");
    getStore("DS_STR_CD_CP", "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    // 삭제된 로우 표시여부
    //DS_MASTER.ViewDeletedRow = true;
    
    enableMaster(false);

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod706","DS_EVTMST,DS_MASTER" );
    bfStrCd = LC_STR_CD.BindColVal;
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}             width=25   align=center edit=none    name="NO"         </FC>'
                     + '<FG>name="행사테마"'
                     + '<FC>id=EVENT_THME_CD        width=60   align=center edit=none    name="코드"       </FC>'
                     + '<FC>id=EVENT_THME_NAME      width=150  align=left   edit=none    name="명"         </FC>'
                     + '</FG>'
                     + '<FC>id=EVENT_S_DT           width=80   align=center edit=none    name="행사시작일 " mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=EVENT_E_DT           width=80   align=center edit=none    name="행사종료일" mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=EVENT_TYPE_NAME      width=60   align=left   edit=none    name="행사;종류"   </FC>'
                     + '<FC>id=EVENT_PLU_FLAG_NAME  width=110   align=left   edit=none    name="행사;유형"   </FC>'
                     + '<FC>id=EVENT_MNG_FLAG_NAME  width=60   align=left   edit=none    name="행사;주관"   </FC>'
                     + '<FC>id=EVENT_ORG_NAME       width=125  align=left   edit=none    name="주관조직"   </FC>'
                     + '<FC>id=EVENT_CHAR_NAME      width=100  align=left   edit=none    name="담당자"     </FC>';

    initGridStyle(GD_EVTMST, "common", hdrProperies, true);
}
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}        width=25  align=center edit=none        name="NO"               </FC>'
    				 + '<C>id=PUMBUN_CD       width=80 align=center   edit=none        name="브랜드"            </FC>'
    				 + '<C>id=PUMBUN_NAME     width=130 align=left   edit=none        name="브랜드명"            </FC>'
                     + '<C>id=SKU_CD          width=100 align=center edit=Numeric     name="*단품코드"         EditStyle=Popup  edit={IF(SysStatus="I","true","false")} </FC>'
                     + '<C>id=SKU_NAME        width=150 align=left   edit=none        name="단품명"            </FC>'
                     + '<C>id=BIZ_TYPE        width=30 align=left   edit=none        name="BIZ_TYPE"       show="false"     </FC>'
                     + '<C>id=SKU_TYPE        width=30 align=left   edit=none        name="SKU_TYPE"        show="false"    </FC>'
                     + '<C>id=TAX_FLAG        width=30 align=left   edit=none        name="TAX_FLAG"       show="false"     </FC>'
                     + '<C>id=RUND_FLAG        width=30 align=left   edit=none        name="RUND_FLAG"     show="false"     </FC>'
                     + '<C>id=APP_S_DT        width=80  align=center edit=none        name="적용시작일"        mask="XXXX/XX/XX" </C>'
                     + '<C>id=APP_E_DT        width=80  align=center edit=Numeric     name="*적용종료일"       mask="XXXX/XX/XX" EditStyle=Popup edit={IF(SysStatus="U" OR (APP_E_DT>="'+getTodayFormat("YYYYMMDD")+'" AND CONF_YN="N" ),"true","false")} </C>'
                     + '<C>id=REDU_RATE       width=50  align=right  edit=Numeric     name="*행사율"           edit={IF(SysStatus="I","true",IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'" AND CONF_YN="N","true","false"))} </C>'
                     + '<G>name="정상가"'
                     + '<C>id=NORM_COST_PRC   width=90  align=right  edit=none        name="원가"              </C>'
                     + '<C>id=NORM_SALE_PRC   width=90  align=right  edit=none        name="판매가"            </C>'
                     + '<C>id=NORM_MG_RATE    width=90  align=right  edit=none        name="마진율"            </C>'
                     + '</G>'
                     + '<G>name="행사가"'
                     + '<C>id=EVENT_COST_PRC  width=90  align=right  edit=Numeric     name="*원가"              edit={IF(SysStatus="I",IF(BIZ_TYPE=1,"true","false"),IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'" AND CONF_YN="N",IF(BIZ_TYPE=1,"true","false"),"false"))} </C>'
                     + '<C>id=EVENT_PRICE     width=90  align=right  edit=Numeric     name="*판매가"            edit={IF(SysStatus="I",IF(BIZ_TYPE=1 AND SKU_TYPE=2,"false","true"),IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'" AND CONF_YN="N",IF(BIZ_TYPE=1 AND SKU_TYPE=2,"false","true"),"false"))} </C>'
                     + '<C>id=EVENT_MG_RATE   width=90  align=right  edit=RealNumeric name="*마진율"            edit={IF(SysStatus="I",IF(BIZ_TYPE=1 AND (SKU_TYPE=1 OR SKU_TYPE=3) ,"false","true"),IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'" AND CONF_YN="N",IF(BIZ_TYPE=1 AND (SKU_TYPE=1 OR SKU_TYPE=3),"false","true"),"false"))} </C>'
                     + '</G>'
                     + '<C>id=LIMIT_SALE_QTY  width=90  align=right  edit=Numeric     name="한정판매;수량"      edit={IF(SysStatus="I","true",IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'" AND CONF_YN="N","true","false"))} </C>'
                     + '<C>id=DC_DIV_RATE     width=90  align=right  edit=none        name="당사에누리;분담율"  show="false" </C>'
                     + '<C>id=CPN_ISSUE_QTY   width=90  align=right  edit=none        name="쿠폰발행;수량"      show="false" </C>'
                     + '<C>id=CPN_BARCODE     width=90  align=center edit=none        name="쿠폰;바코드 "        show="false" </C>'
                     + '<C>id=CONF_YN         width=90  align=center edit=none        name="확정;여부"          </C>';

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

    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_MASTER.Focus();
            return ;
        }
    }
    
    searchEvtMst();
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
    // 저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if( DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }

    if( !checkMasterValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','03','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_MASTER.Focus();
        return;
    }
    
    //  점별브랜드 입력사용
    fn_pumbunAdd();
   
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        GD_MASTER.Focus();
        return; 
    }
    
    if(DS_EVTMST.NameValue(1,"NEW_YN")=='Y'){
    	DS_EVTMST.UserStatus(1) = '1';
    }
    var strCd    = LC_STR_CD.BindColVal;
    var eventCd  = EM_EVENT_CD.Text;
    var pumbunCd = EM_PUMBUN_CD.Text;
    var EventSDt = DS_EVTMST.NameValue(1,"EVENT_S_DT");
    var EventEDt = DS_EVTMST.NameValue(1,"EVENT_E_DT");
    
    
    
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strEventCd="+encodeURIComponent(eventCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strEventSDt="+encodeURIComponent(EventSDt)
                   + "&strEventEDt="+encodeURIComponent(EventEDt)
                   ;    
    var skuCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SKU_CD");
    
    TR_MAIN.Action="/dps/pcod706.pc?goTo=save"+parameters; 
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER,I:DS_TEMP=DS_TEMP)"; //조회는 O
    TR_MAIN.Post();    
    
    if(TR_MAIN.ErrorCode == 0){
        searchEvtMst();
        searchMaster();
        
        DS_MASTER.RowPosition = DS_MASTER.NameValueRow("SKU_CD",skuCd);
    }
    GD_MASTER.Focus();
}


function fn_pumbunAdd() {
	
	DS_TEMP.ClearData();
	
	var strTmpCheck = "0";
	
	for( var i = 1; i<=DS_MASTER.CountRow; i++)
	{
		//insert
		strTmpCheck = "0";
		if(DS_MASTER.RowStatus(i) == "1") { 
			
			for(var j = 1; j<=DS_TEMP.CountRow; j++)
			{
			
				if(DS_TEMP.NameValue(j,"PUMBUN_CD") == DS_MASTER.NameValue(i,"PUMBUN_CD")){
					strTmpCheck = "1";
				}
			}
			
			if(strTmpCheck == "0") {
				DS_TEMP.AddRow();
				var row = DS_TEMP.CountRow;
				DS_TEMP.NameValue(row,"PUMBUN_CD") = DS_MASTER.NameValue(i,"PUMBUN_CD");
			}
		}
	}
	
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
//
/**
 * btn_addRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행추가
 * return값 : void
 */
function btn_addRow(){
    if(DS_EVTMST.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1025");
        LC_STR_CD.Focus();
        return;     
    }
    DS_MASTER.AddRow();
    var row = DS_MASTER.CountRow;
    DS_MASTER.NameValue(row,"STR_CD")   = LC_STR_CD.BindColVal;
    DS_MASTER.NameValue(row,"EVENT_CD") = EM_EVENT_CD.Text;
    DS_MASTER.NameValue(row,"APP_S_DT") = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_S_DT");
    DS_MASTER.NameValue(row,"APP_E_DT") = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_E_DT");
    
    DS_MASTER.NameValue(row,"CONF_YN")  = "N";
    
    setFocusGrid(GD_MASTER,DS_MASTER,row,"SKU_CD");
}
/**
 * btn_delRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행삭제
 * return값 : void
 */
function btn_delRow(){
    if(DS_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_STR_CD.Focus();
        return;     
    }
    var row  = DS_MASTER.RowPosition;
    if( DS_MASTER.NameValue(row,"APP_S_DT") <= getTodayFormat("YYYYMMDD") ){
        showMessage(INFORMATION, OK, "USER-1000", "이미 시작된 행사 입니다.");
        GD_MASTER.Focus();
        return;
    }
    if( DS_MASTER.NameValue(row,"CONF_YN") == "Y" ){
        showMessage(INFORMATION, OK, "USER-1000", "확정된 행사 입니다.");
        GD_MASTER.Focus();
        return;
    }
    DS_MASTER.DeleteRow(row);
}
/**
 * btn_copy()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  마스터 컨트롤러 상요여부지정
 * return값 : void
 */
function btn_copy(){
    if( LC_STR_CD_CP.BindColVal == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "복사점");
        LC_STR_CD_CP.Focus();
        return;
    }
    if( EM_EVENT_CD_CP.Text == ""){
        // (행사코드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "복사행사");
        EM_EVENT_CD_CP.Focus();
        return;
    }

    if( EM_EVENT_NAME_CP.Text == ""){
        // 존재하지 않는 행사코드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "복사행사");
        EM_EVENT_CD_CP.Focus();
        return;
    }

    if(DS_MASTER.CountRow > 0){
        if(showMessage(QUESTION, YESNO, "USER-1000","복사를 실행하면 데이터가 초기화 됩니다<br>실행하시겠습나까?")!=1){
            GD_MASTER.Focus();
            return;
        }     
    }
    DS_MASTER.ClearData();

    var strCd       = LC_STR_CD.BindColVal;
    var eventCd     = EM_EVENT_CD.Text;
    var pumbunCd    = EM_PUMBUN_CD.Text;
    var fromStrCd   = LC_STR_CD_CP.BindColVal;
    var fromEventCd = EM_EVENT_CD_CP.Text;
    var goTo        = "searchCopyData" ;    
    var action      = "O";  
    var parameters  = "&strStrCd="+encodeURIComponent(strCd)
                    + "&strEventCd="+encodeURIComponent(eventCd)
                    + "&strPumbunCd="+encodeURIComponent(pumbunCd)
                    + "&strSkuType="+encodeURIComponent(skuType)
                    + "&strBizType="+encodeURIComponent(bizType)
                    + "&strFromStrCd="+encodeURIComponent(fromStrCd)
                    + "&strFromEventCd="+encodeURIComponent(fromEventCd);
    TR_MAIN.Action  ="/dps/pcod706.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_RESULT=DS_SEARCH_NM)"; //조회는 O
    TR_MAIN.Post();    
    
    if(DS_SEARCH_NM.CountRow < 1){
    	showMessage(INFORMATION, OK, "GAUCE-1003");
    	LC_STR_CD.Focus();
    	return;
    }
    DS_MASTER.ImportData( DS_SEARCH_NM.ExportData(1, DS_SEARCH_NM.CountRow, true));
    
    if(DS_MASTER.CountRow > 0){
    	for( var i=1; i<= DS_MASTER.CountRow; i++){
    		setEventPrc(i);
    	}    	
    }
}
/**
 * enableMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  마스터 컨트롤러 상요여부지정
 * return값 : void
 */
function enableMaster(flag){

    enableControl(LC_STR_CD_CP,flag);
    enableControl(EM_EVENT_CD_CP,flag);
    enableControl(IMG_ADD_ROW,flag);
    enableControl(IMG_ADD_ROW,flag);
    enableControl(IMG_DEL_ROW,flag);
    enableControl(IMG_EVENT_CD_CP,flag);
    enableControl(IMG_COPY,flag);
    if(!flag){
    	setComboData(LC_STR_CD_CP,"");
    	EM_EVENT_CD_CP.Text = "";
    	EM_EVENT_NAME_CP.Text = "";
    }
}
/**
 * searchEvtMst()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행사마스터 조회
 * return값 : void
 */
function searchEvtMst(){    

    DS_MASTER.ClearData();
    DS_EVTMST.ClearData();
    var strCd    = LC_STR_CD.BindColVal;
    var eventCd  = EM_EVENT_CD.Text;
    var pumbunCd = EM_PUMBUN_CD.Text;
    
    var goTo       = "searchEvtmst" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strEventCd="+encodeURIComponent(eventCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd);
    TR_MAIN.Action="/dps/pcod706.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_EVTMST=DS_EVTMST)"; //조회는 O
    TR_MAIN.Post();
    enableMaster(false);
    if(DS_EVTMST.CountRow > 0){
        var eventType = DS_EVTMST.NameValue(1,"EVENT_TYPE");
        var eventSDt  = DS_EVTMST.NameValue(1,"EVENT_S_DT");
        if( eventSDt > getTodayFormat("YYYYMMDD")){
            enableMaster(true);
        }
        
    }
    //조회후 결과표시
    setPorcCount("SELECT",GD_EVTMST);  

}
/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  점별행사브랜드 리스트 조회
 * return값 : void
 */
function searchMaster(){

    var strCd      = LC_STR_CD.BindColVal;
    var eventCd    = EM_EVENT_CD.Text;
    var pumbunCd   = EM_PUMBUN_CD.Text;
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strEventCd="+encodeURIComponent(eventCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strSkuType="+encodeURIComponent(skuType)
                   + "&strBizType="+encodeURIComponent(bizType);
    TR_MAIN.Action="/dps/pcod706.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 


/**
 * setEventCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 행사명을 등록한다.
 * return값 : void
 */
function setEventCode(evnflag, svcFlag){
    var codeObj = svcFlag=='S'?EM_EVENT_CD:EM_EVENT_CD_CP;
    var nameObj = svcFlag=='S'?EM_EVENT_NAME:EM_EVENT_NAME_CP;
    var strCd = svcFlag=='S'?LC_STR_CD.BindColVal:LC_STR_CD_CP.BindColVal;

    if(svcFlag=='S'){
        if( DS_MASTER.IsUpdated){
            // 변경된 상세내역이 존재합니다. 행사코드을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","행사코드") != 1 ){
                codeObj.Text = bfEventCd;
                GD_MASTER.Focus();
                return;
            }
        }
        DS_EVTMST.ClearData();
        DS_MASTER.ClearData();
        enableMaster(false);
    }
    if( strCd == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", svcFlag=='S'?"점":"복사점");
        (svcFlag=='S'?LC_STR_CD:LC_STR_CD_CP).Focus();
        return;
    }
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        if(svcFlag=='S')
            bfEventCd = "";
        return;     
    }
    
    if( evnflag == "POP" ){
        eventPop(codeObj,nameObj,strCd,'','','2');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setEventNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 1,strCd,'','','2');
    }    
    if(svcFlag=='S')
        bfEventCd = codeObj.Text;
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

    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 브랜드을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","브랜드") != 1 ){
            codeObj.Text = bfPumbunCd;
            GD_MASTER.Focus();
            return;
        }
    }
    DS_EVTMST.ClearData();
    DS_MASTER.ClearData();
    enableMaster(false);
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        bfPumbunCd = "";
        skuType     = "";
        bizType     = "";
        taxFlag     = "";
        roundFlag   = "";
        return;     
    }

    if( strCd == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD.Focus();
        return;
    }
    var rtnMap = null;
    if( evnflag == "POP" ){
    	rtnMap = strPbnPop(codeObj,nameObj,'Y','', strCd,'','','','0','','1');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
    	rtnMap = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'', strCd,'','','','0','','1');
    }    
    bfPumbunCd = codeObj.Text;
    
    if( codeObj.Text == ""){
        skuType = "";
        bizType = "";
        taxFlag = "";
        roundFlag   = "";
        return;
    }
    skuType = rtnMap != null?rtnMap.get("SKU_TYPE"):DS_SEARCH_NM.NameValue(1,"SKU_TYPE");
    bizType = rtnMap != null?rtnMap.get("BIZ_TYPE"):DS_SEARCH_NM.NameValue(1,"BIZ_TYPE");
    taxFlag = rtnMap != null?rtnMap.get("TAX_FLAG"):DS_SEARCH_NM.NameValue(1,"TAX_FLAG");
    var venCd = rtnMap != null?rtnMap.get("VEN_CD"):DS_SEARCH_NM.NameValue(1,"VEN_CD");
    setVenNmWithoutToGridPop( "DS_SEARCH_NM", venCd, '', 0, strCd);
    roundFlag  = DS_SEARCH_NM.NameValue(1,"RUND_FLAG"); 
}

/**
 * setSkuCodeToGrid()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품명을 등록한다.(Grid)
 * return값 : void
 */
function setSkuCodeToGrid(evnflag, row){
    var code     = DS_MASTER.NameValue(row,"SKU_CD");
    var strCd    = DS_MASTER.NameValue(row,"STR_CD");
    var pumbunCd = EM_PUMBUN_CD.Text;
    if( code == "" && evnflag != "POP" ){
        DS_MASTER.NameValue(row,"SKU_NAME")    = "";
        setNormPrc(row);
        return;     
    }
    
    
    var rtnMap = null;
    if( evnflag == "POP" ){
        rtnMap = strSkuMultiSelPop_Pcod(code,'','%','%','%','Y','', strCd, pumbunCd,'0','','Y');
       
    }else if( evnflag == "NAME" ){
        DS_MASTER.NameValue(row,"SKU_NAME") = "";
        setNormPrc(row);
        rtnMap = setStrSkuNmWithoutToGridPop_Pcod("DS_SEARCH_NM",code,'','%','%','%','Y',1,'', strCd, pumbunCd,'0','','Y');
        	    
    }    
    if( rtnMap != null){
        DS_MASTER.NameValue(row,"SKU_CD")   = rtnMap.get("SKU_CD");
        DS_MASTER.NameValue(row,"SKU_NAME") = rtnMap.get("SKU_NAME");
        setNormPrc(row);
    }else{
        if( DS_MASTER.NameValue(row,"SKU_NAME") == ""){
            DS_MASTER.NameValue(row,"SKU_CD")   = "";
            setNormPrc(row);
        }
    }
}


 /**
  * setSkuCodeToGrid()
  * 작 성 자 : 
  * 작 성 일 : 2010-04-04
  * 개    요 : 단품명을 등록한다.(Grid)
  * return값 : void
  */
 function setSkuCodeMultiToGrid(evnflag, row){
     var code     = DS_MASTER.NameValue(row,"SKU_CD");
     var strCd    = DS_MASTER.NameValue(row,"STR_CD");
     var pumbunCd = EM_PUMBUN_CD.Text;
     
     if( code == "" && evnflag != "POP" ){
         DS_MASTER.NameValue(row,"SKU_NAME")    = "";
         DS_MASTER.NameValue(row,"PUMBUN_CD") 	= "";
         DS_MASTER.NameValue(row,"PUMBUN_NAME") = "";
         DS_MASTER.NameValue(row,"SKU_TYPE")    = "";
         DS_MASTER.NameValue(row,"BIZ_TYPE") 	= "";
         DS_MASTER.NameValue(row,"RUND_FLAG") 	= "";
         DS_MASTER.NameValue(row,"TAX_FLAG") 	= "";
         
         setNormPrc(row);
         return;     
     }
     
     var rtn = null;
     
     if( evnflag == "POP" ){
    	 rtn = strSkuMultiSelPop_Pcod(code,'','%','%','%','Y','', strCd, pumbunCd,'0','','Y');
     }else if( evnflag == "NAME" ){
         DS_MASTER.NameValue(row,"SKU_NAME") 	= "";
         DS_MASTER.NameValue(row,"PUMBUN_CD") 	= "";
         DS_MASTER.NameValue(row,"PUMBUN_NAME") = "";
         DS_MASTER.NameValue(row,"SKU_TYPE")    = "";
         DS_MASTER.NameValue(row,"BIZ_TYPE") 	= "";
         DS_MASTER.NameValue(row,"RUND_FLAG") 	= "";
         DS_MASTER.NameValue(row,"TAX_FLAG") 	= "";
      
         setNormPrc(row);
         
         rtn = setStrSkuNmWithoutToGridPop_Pcod("DS_SEARCH_NM",code,'','%','%','%','Y',1,'', strCd, pumbunCd,'0','','Y');
     }    
     
	if( rtn != null){
		if( evnflag == "NAME"){
			DS_MASTER.NameValue(row,"PUMBUN_CD")   = rtn.get("PUMBUN_CD");
			DS_MASTER.NameValue(row,"PUMBUN_NAME") = rtn.get("PUMBUN_NAME");
			DS_MASTER.NameValue(row,"SKU_CD")   = rtn.get("SKU_CD");
			DS_MASTER.NameValue(row,"SKU_NAME") = rtn.get("SKU_NAME");
			DS_MASTER.NameValue(row,"SKU_TYPE") = rtn.get("SKU_TYPE");
			DS_MASTER.NameValue(row,"BIZ_TYPE") = rtn.get("BIZ_TYPE");
			DS_MASTER.NameValue(row,"RUND_FLAG") = rtn.get("RUND_FLAG");
			DS_MASTER.NameValue(row,"TAX_FLAG") = rtn.get("TAX_FLAG");
			DS_MASTER.NameValue(row,"CONF_YN")  = "N";
            
			setNormPrc(row);
            return;
		} else {
    		
			var rtnTotal = rtn.length;
			var tmpRow = row;
			
			if(rtnTotal > 0){
				
				for( var i = 0; i<rtnTotal; i++)
				{
    				 
    				 
					if( i != 0 ){
						DS_MASTER.AddRow();
						tmpRow = DS_MASTER.CountRow;
					}
                            
					DS_MASTER.NameValue(tmpRow,"STR_CD")   = LC_STR_CD.BindColVal;
					DS_MASTER.NameValue(tmpRow,"EVENT_CD") = EM_EVENT_CD.Text;
					DS_MASTER.NameValue(tmpRow,"APP_S_DT") = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_S_DT");
					DS_MASTER.NameValue(tmpRow,"APP_E_DT") = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_E_DT");
					
					DS_MASTER.NameValue(tmpRow,"SKU_CD")   = rtn[i].SKU_CD;
					DS_MASTER.NameValue(tmpRow,"SKU_NAME") = rtn[i].SKU_NAME;
					
					DS_MASTER.NameValue(tmpRow,"PUMBUN_CD") 	= rtn[i].PUMBUN_CD;
					DS_MASTER.NameValue(tmpRow,"PUMBUN_NAME") 	= rtn[i].PUMBUN_NAME;
					
					DS_MASTER.NameValue(tmpRow,"SKU_TYPE") 	= rtn[i].SKU_TYPE;
					DS_MASTER.NameValue(tmpRow,"BIZ_TYPE") 	= rtn[i].BIZ_TYPE;
					DS_MASTER.NameValue(tmpRow,"TAX_FLAG") 	= rtn[i].TAX_FLAG;
					DS_MASTER.NameValue(tmpRow,"RUND_FLAG") 	= rtn[i].RUND_FLAG;
					DS_MASTER.NameValue(tmpRow,"CONF_YN")  	= "N";
   
					setNormPrc(row+i);
				}
    		}
			return;
		}
    	 	
	}
     
	if( DS_MASTER.NameValue(row,"SKU_NAME") == ""){
	    DS_MASTER.NameValue(row,"SKU_CD")   = "";
	    setNormPrc(row);
	}
}


/**
 * setNormPrc()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 점별단품가격마스터에서 정상가을 조회한다.(Popup.js) 
 * return값 : void
 */
function setNormPrc(row){
    var strCd     = DS_MASTER.NameValue(row,"STR_CD");
    var skuCd     = DS_MASTER.NameValue(row,"SKU_CD");
    var skuName   = DS_MASTER.NameValue(row,"SKU_NAME");
    var appSDt    = DS_MASTER.NameValue(row,"APP_S_DT");

    DS_MASTER.NameValue(row,"NORM_YN")         = "N";
    if( strCd == "" 
        || skuCd == ""
        || skuName == ""
        || appSDt == ""){
    	DS_MASTER.NameValue(row,"NORM_COST_PRC") = "";
        DS_MASTER.NameValue(row,"NORM_SALE_PRC") = "";
        DS_MASTER.NameValue(row,"NORM_MG_RATE")  = "";
        DS_MASTER.NameValue(row,"EVENT_COST_PRC")= "";
        DS_MASTER.NameValue(row,"EVENT_PRICE")   = "";
        DS_MASTER.NameValue(row,"EVENT_MG_RATE") = "";
    	return;
    }
    
    setDataSet("DS_SEARCH_NM","SEL_STRSKUPRCMST_NORM_PRC", strCd, skuCd, appSDt);
    if( DS_SEARCH_NM.CountRow == 1){
        DS_MASTER.NameValue(row,"NORM_COST_PRC")   = DS_SEARCH_NM.NameValue(1,"COL1");
        DS_MASTER.NameValue(row,"NORM_SALE_PRC")   = DS_SEARCH_NM.NameValue(1,"COL2");
        DS_MASTER.NameValue(row,"NORM_MG_RATE")    = DS_SEARCH_NM.NameValue(1,"COL3");
        DS_MASTER.NameValue(row,"EVENT_COST_PRC")  = DS_MASTER.NameValue(row,"BIZ_TYPE")=="1"?DS_SEARCH_NM.NameValue(1,"COL1"):'';
        DS_MASTER.NameValue(row,"EVENT_MG_RATE")   = DS_MASTER.NameValue(row,"BIZ_TYPE")=="2"?DS_SEARCH_NM.NameValue(1,"COL3"):'';
        DS_MASTER.NameValue(row,"NORM_YN")         = "Y";
        setEventPrc(row);
        return;
    }
	
    DS_MASTER.NameValue(row,"NORM_COST_PRC") = "";
    DS_MASTER.NameValue(row,"NORM_SALE_PRC") = "";
    DS_MASTER.NameValue(row,"NORM_MG_RATE")  = "";
    DS_MASTER.NameValue(row,"EVENT_COST_PRC")= "";
    DS_MASTER.NameValue(row,"EVENT_PRICE")   = "";
    DS_MASTER.NameValue(row,"EVENT_MG_RATE") = "";
    showMessage(EXCLAMATION, OK, "USER-1000", "["+skuCd+"/"+skuName+"]<br>"+"정상가가 존재하지 않습니다.");
    return ;
}

/**
 * checkMasterValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 입력 값을 검증한다.
 * return값 : void
 */
function checkMasterValidation(){
    var row;
    var colid;
    var errYn = false;
    
    for(var i=1; i<=DS_MASTER.CountRow; i++){
        var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;
        row = i;
        if( DS_MASTER.NameValue(i,"SKU_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
            errYn = true;
            colid = "SKU_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"SKU_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "단품코드");
            errYn = true;
            colid = "SKU_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"NORM_YN")!="Y"){
            showMessage(EXCLAMATION, OK, "USER-1000", "정상가가 존재하지 않습니다.");
            errYn = true;
            colid = "SKU_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"APP_E_DT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "적용종료일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( DS_MASTER.NameValue(i,"APP_E_DT") < getTodayFormat("YYYYMMDD")){
            showMessage(EXCLAMATION, OK, "USER-1030", "적용종료일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( DS_MASTER.NameValue(i,"APP_E_DT")< DS_MASTER.NameValue(i,"APP_S_DT")){
            showMessage(EXCLAMATION, OK, "USER-1020", "적용종료일", "적용시작일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( DS_MASTER.NameValue(i,"REDU_RATE")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "행사율");
            errYn = true;
            colid = "REDU_RATE";
            break;
        }
        if( Number(DS_MASTER.NameString( i, "EVENT_COST_PRC")) < 0 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "행사가 원가","0");
            errYn = true;
            colid = "EVENT_COST_PRC";
            break;
        }
        if( Number(DS_MASTER.NameString( i, "EVENT_PRICE")) < 1 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "행사가 판매가","1");
            colid = "EVENT_PRICE";
            errYn = true;
            break;     
        }
        if( Number(DS_MASTER.NameValue(i,"EVENT_MG_RATE"))< 0){
            var tmpCheck = showMessage(EXCLAMATION, YESNO, "USER-1000", "행사가 마진율이 0보다 작습니다. 진행하시겠습니까?");
            errYn = tmpCheck != 1;
            colid = "EVENT_MG_RATE";
            
            if(errYn)
                break;
        }
        if( Number(DS_MASTER.NameValue(i,"EVENT_MG_RATE"))>100){
            showMessage(EXCLAMATION, OK, "USER-1021", "행사가 마진율", 100);
            errYn = true;
            colid = "EVENT_MG_RATE";
            break;
        }
        if(checkDupDtSkuCD(i)){
            showMessage(EXCLAMATION, OK, "USER-1000", "단품의 중복되는 행사기간이 존재합니다.");
            errYn = true;
            colid = "SKU_CD";
            break;
        }
        
    }
    
    if(errYn){
        setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
        return false;
    }
    return true;
}

/**
 * setEventPrc()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 행사가를 설정한다.
 * return값 : void
 */
function setEventPrc(row){
	
	if( row < 1){
		return;
	}
	
	var eventPrice = 0;
	var reduRate = DS_MASTER.NameValue(row,"REDU_RATE");
    var salePrc = DS_MASTER.NameString(row,"NORM_SALE_PRC");
    //DS_MASTER.NameString(row,"EVENT_COST_PRC") = DS_MASTER.NameString(row,"NORM_COST_PRC");

    // 행사가에 1원 단위 값이 존재하면 원단위 금액을 절사한다. - MARIO OUTLET
    //eventPrice = getRoundDec(roundFlag, (salePrc * ( 100 - reduRate ) / 100), -1);
    eventPrice = getRoundDec("2", (salePrc * ( 100 - reduRate ) / 100), -1);
    
    DS_MASTER.NameString(row,"EVENT_PRICE") = eventPrice;
    setCostSaleMg(row);
    
    
}

/**
 * setReduRate()
 * 작 성 자 : 배임주
 * 작 성 일 : 2011-08-10
 * 개    요 : 행사율을 설정한다.(MARIO OUTLET)
 * return값 : void
 */
function setReduRate(row){
	
	if( row < 1){
		return;
	}
	var reduRate = 0;
    
	var normPrc = DS_MASTER.NameString(row,"NORM_SALE_PRC");
	// 행사가에 1원 단위 값이 존재하면 원단위 금액을 절사한다. - MARIO OUTLET
    var salePrc = getRoundDec("2", DS_MASTER.NameString(row,"EVENT_PRICE"), -1);
    DS_MASTER.NameString(row,"EVENT_PRICE") = salePrc;
    // 행사가에 1원 단위 값이 존재하면 원단위 금액을 절사한다. - MARIO OUTLET
 
    
    
    // 행사율 계산 시 소숫점 이하 절사한다.
    reduRate = getRoundDec("2", (normPrc - salePrc) / normPrc * 100);
    
    DS_MASTER.NameValue(row,"REDU_RATE") = reduRate;
}


/**
 * checkDupDtSkuCD()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품의 기간을 중복을 체크한다.
 * return값 : void
 */
function checkDupDtSkuCD(row){
    var skuCd     = DS_MASTER.NameValue(row,"SKU_CD");
    var evtSDt    = DS_MASTER.NameValue(row,"APP_S_DT");
    var evtEDt    = DS_MASTER.NameValue(row,"APP_E_DT");
    for( var i=1; i<=DS_MASTER.CountRow; i++ ){
        if(i==row)
            continue;
        if( DS_MASTER.NameValue(i,"SKU_CD") == skuCd
            && ((DS_MASTER.NameValue(i,"APP_S_DT") <= evtSDt
            && DS_MASTER.NameValue(i,"APP_E_DT") >= evtSDt)
            || (DS_MASTER.NameValue(i,"APP_S_DT") <= evtEDt
            && DS_MASTER.NameValue(i,"APP_E_DT") >= evtEDt)))
            return true;
    }
    return false;
    
}

/**
 * setCostSaleMg()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 로우의 타입에 따라 원가 매가 마진율을 계산한다.
 * return값 : void
 */
function setCostSaleMg( row){

    var bizType = DS_MASTER.NameValue(row,"BIZ_TYPE");
    var skuType = DS_MASTER.NameValue(row,"SKU_TYPE");
    var costPrc = DS_MASTER.NameString(row,"EVENT_COST_PRC");
    var salePrc = DS_MASTER.NameString(row,"EVENT_PRICE");
    var mgRate = DS_MASTER.NameString(row,"EVENT_MG_RATE");
    var roundFlag = DS_MASTER.NameValue(row,"RUND_FLAG");
    var taxFlag = DS_MASTER.NameValue(row,"TAX_FLAG");

    costPrc = Number(costPrc);
    salePrc = Number(salePrc);
    mgRate = Number(mgRate);
    // 거래형태[직매입]
    if( bizType == "1"){
        // 단품종류 [규격],[의류]
        if(skuType =="1"||skuType =="3"){
            // 판매원가와 판매매가을 등록하면 마진율을 계산
            DS_MASTER.NameValue(row,"EVENT_MG_RATE") = getSaleMgRate(costPrc, salePrc, roundFlag, taxFlag);
        // 단품종류 [신선]
        }else if(skuType =="2"){
            // 판매원가와 마진율을 등록하면 판매매가을 계산
            DS_MASTER.NameValue(row,"EVENT_PRICE") = getSalePrc(costPrc, mgRate, roundFlag, taxFlag);
            
        }
    // 거래형태[특정매입]
    }else if( bizType == "2"){
        // 단품종류 [규격],[의류]
        if(skuType =="1"||skuType =="3"){
            // 판매매가와 마진율을 등록하면 판매원가을 계산
            DS_MASTER.NameValue(row,"EVENT_COST_PRC") =  getSalCostPrc(salePrc, mgRate, roundFlag, taxFlag);
        // 단품종류 [신선]
        }else if(skuType =="2"){
            // 판매원가와 마진율을 등록하면 판매매가을 계산
            DS_MASTER.NameValue(row,"EVENT_COST_PRC") = getSalCostPrc(salePrc, mgRate, roundFlag, taxFlag);
            
        }
    }
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
<!-- 팝업  -->
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    if(row < 1){
        return;
    }
    onPopup = true;
    switch(colid){
        case 'SKU_CD':
        	setSkuCodeMultiToGrid('POP', row);
            break;
        case 'APP_E_DT':
            var eventEDt = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_E_DT");
            openCal(GD_MASTER,row,colid);
            if( DS_MASTER.NameValue(row,"APP_E_DT") < getTodayFormat("YYYYMMDD")){
                showMessage(EXCLAMATION, OK, "USER-1030", "적용종료일");
                if(DS_MASTER.RowStatus(row)=="1"){
                    DS_MASTER.NameValue(row,"APP_E_DT")  = eventEDt;
                }else{
                    DS_MASTER.NameValue(row,"APP_E_DT")  = DS_MASTER.OrgNameValue(row,"APP_E_DT");                                
                }
                setTimeout("setFocusGrid(GD_MASTER,DS_MASTER,"+row+",'APP_E_DT');",50);
            }
            break;
            
    }
    onPopup = false;
</script>
<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
    if(row < 1 || onPopup){
        return;
    }
    
    var bizType = DS_MASTER.NameValue(row,"BIZ_TYPE");
    var skuType = DS_MASTER.NameValue(row,"SKU_TYPE");
    

    var value = DS_MASTER.NameValue(row,colid);
    if( value == olddata)
        return;
    
    switch(colid){
        case 'SKU_CD':
        	//setSkuCodeToGrid('NAME', row);
        	setSkuCodeMultiToGrid('NAME', row);
            break;
        case 'APP_E_DT':
            var eventEDt = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_E_DT");
            if(!checkDateTypeYMD(GD_MASTER,colid,eventEDt))
                return;
            if( DS_MASTER.NameValue(row,"APP_E_DT") < getTodayFormat("YYYYMMDD")){
                showMessage(EXCLAMATION, OK, "USER-1030", "적용종료일");
                if(DS_MASTER.RowStatus(row)=="1"){
                    DS_MASTER.NameValue(row,"APP_E_DT")  = eventEDt;
                }else{
                    DS_MASTER.NameValue(row,"APP_E_DT")  = DS_MASTER.OrgNameValue(row,"APP_E_DT");                                
                }
                setTimeout("setFocusGrid(GD_MASTER,DS_MASTER,"+row+",'APP_E_DT');",50);
                return;
            }
            break;
        case 'REDU_RATE':
            setEventPrc(row);
            break;
        case 'EVENT_COST_PRC':
        	// CENTRAL SQURE 2011.08.11  직매입 - (규격 OR 의류) 행사 원가 수정 시 마진율 재계산	
			if (bizType == '1' && (skuType == '1'||skuType == '3')) setCostSaleMg(row);
        	
			// CENTRAL SQURE 2011.08.11 특정 - (신선) 행사 원가 수정 시 마진율 재계산	
			if (bizType == '2' && skuType == '2') setCostSaleMg(row);
            break;
        case 'EVENT_PRICE':
            // CENTRAL SQURE 2011.08.11 행사 판매가 수정 시 행사율 재계산, 마진율 재계산
        	setReduRate(row);
        	setCostSaleMg(row);
        	break;
        case 'EVENT_MG_RATE':
        	// CENTRAL SQURE 2011.08.11  직매입 - (신선) 행사 원가 수정 시 마진율 재계산	
			if (bizType == '1' && skuType == '2') setCostSaleMg(row);
        	
        	// CENTRAL SQURE 2011.08.11  특정  - (규격 OR 의류) 행사 원가 수정 시 마진율 재계산	
        	if (bizType == '2' && (skuType == '1'||skuType == '3')) setCostSaleMg(row);
            break;
    
    }
</script>

<!-- 행사코드(조회) -->
<script language=JavaScript for=EM_EVENT_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setEventCode('NAME','S');
</script> 
 
<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPumbunCode('NAME');
</script> 

<!-- 행사코드(복사) -->
<script language=JavaScript for=EM_EVENT_CD_CP event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setEventCode('NAME','C');
</script> 
 
<!-- 점 (조회) -->
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
        DS_EVTMST.ClearData();
        DS_MASTER.ClearData();
        EM_EVENT_CD.Text = "";
        EM_EVENT_NAME.Text = "";
        bfEventCd = "";    
        EM_PUMBUN_CD.Text = "";
        EM_PUMBUN_NAME.Text = "";
        bfPumbunCd = "";    
        skuType    = "";
        bizType    = "";
        taxFlag    = "";
        roundFlag  = "";
        enableMaster(false);
    }
    bfStrCd = this.BindColVal;
</script>
<!-- 복사점 -->
<script language=JavaScript for=LC_STR_CD_CP event=OnSelChange()>
    EM_EVENT_CD_CP.Text = "";
    EM_EVENT_NAME_CP.Text = "";
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
<comment id="_NSID_"><object id="DS_STR_CD"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR_CD_CP"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_FLAG"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVTMST"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TEMP"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1  align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60" class="point">행사코드</th>
            <td width="220">
              <comment id="_NSID_">
                <object id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setEventCode('POP','S');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=109 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="60" >브랜드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPumbunCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1 align="absmiddle"></object>
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
    <td  class="PT01 PB03">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td width="100%" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td width="100%" >
                  <comment id="_NSID_"><object id=GD_EVTMST width="100%" height=103 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_EVTMST">
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
          <td class="PT03 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
            <tr>
              <td width="505" ><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                <tr>
                  <th width="60" class="point">복사점</th>
                  <td width="120">
                    <comment id="_NSID_">
                      <object id=LC_STR_CD_CP classid=<%= Util.CLSID_LUXECOMBO %> width=120 tabindex=1  align="absmiddle"></object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th width="60" class="point">복사행사</th>
                  <td >
                    <comment id="_NSID_">
                      <object id=EM_EVENT_CD_CP classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
                    </comment><script> _ws_(_NSID_);</script><img 
                    src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_EVENT_CD_CP class="PR03" onclick="javascript:setEventCode('POP','C');"  align="absmiddle" />
                    <comment id="_NSID_">
                      <object id=EM_EVENT_NAME_CP classid=<%=Util.CLSID_EMEDIT%> width=109 tabindex=1 align="absmiddle"></object>
                    </comment><script> _ws_(_NSID_);</script>
                  </td>
                </tr>
              </table></td>
              <td width="45" class="right PT03 "><img 
                    src="/<%=dir%>/imgs/btn/copy.gif" id=IMG_COPY onClick="javascript:btn_copy();"  />
              </td>
              <td class="right PT03 " ><img 
              src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ADD_ROW onClick="javascript:btn_addRow();" hspace="2" /><img 
              src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL_ROW onClick="javascript:btn_delRow();"  />
              </td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_MASTER width="100%" height=360 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_MASTER">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </td >
        </tr>
      </table></td>
    </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

