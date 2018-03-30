<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > POS기준정보> POS단축기관리
 * 작 성 일 : 2010.05.24
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod8080.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS 단축키를 관리한다.
 * 이    력 :
 *        2010.05.24 (정진영) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.Date2"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");
  String strStartDate = Date2.addDay(+1);//내일날짜
  String strToday     = Date2.YYYYMMDD();//오늘날짜
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

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var bfStrCd;
var bfMasterRow = 0;
var bfShortCutFlag;
var btnSaveYn = false;
var isOnPopup = false;

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
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //상세

    // EMedit에 초기화
    initEmEdit(EM_POS_NO      , "CODE^4^0" ,  NORMAL);  //POS번호(조회)
    initEmEdit(EM_POS_NAME    , "GEN^20"   ,  NORMAL);  //POS번호명(조회)
    initEmEdit(EM_SHOP_NAME   , "GEN^20"   ,  NORMAL);  //매장명(조회) 
    initEmEdit(EM_POS_NO_D    , "CODE^4^0" ,  READ);    //POS번호(상세)
    initEmEdit(EM_POS_NAME_D  , "GEN^20"   ,  READ);    //POS번호명(상세)
    initEmEdit(EM_SHOP_NAME_D , "GEN^20"   ,  READ);    //매장명(상세)
    //콤보 초기화 
    initComboStyle(LC_STR_CD        ,DS_STR_CD   , "CODE^0^30,NAME^0^140", 1, PK);    //점(조회)
    initComboStyle(LC_POS_FLAG_D    ,DS_POS_FLAG , "CODE^0^30,NAME^0^80", 1, READ);  //POS구분(상세)
    initComboStyle(LC_USE_YN_D      ,DS_USE_YN   , "CODE^0^30,NAME^0^80", 1, READ);  //사용여부(상세)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_POS_FLAG"      , "D", "P082", "N");
    getEtcCode("DS_USE_YN"        , "D", "D022", "N");
    
    getEtcCode("DS_SHORTCUT_FLAG" , "D", "P088", "N");
    
    
    // 점코드 조회
    getStore("DS_STR_CD"  , "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    
    bfStrCd = LC_STR_CD.BindColVal;

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod808","DS_MASTER,DS_DETAIL" );
    LC_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}       width=25   align=center name="NO"        </FC>'
                     + '<FC>id=POS_NO         width=55   align=center name="POS번호"   </FC>'
                     + '<FC>id=POS_NAME       width=90   align=left   name="POS명"     </FC>'
                     + '<FC>id=SHOP_NAME      width=90   align=left   name="매장명 "    </FC>'
                     + '<FC>id=SHORT_KEY      width=120   align=left   name="단축키 "    </FC>'
                     ;
 
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}


function gridCreate2(){
    var hdrProperies = '<FC>id={currow}        width=25  align=center edit=none     name="NO"         </FC>'
                     + '<FC>id=SHORTCUT_NO     width=65  align=right  edit=Numeric  name="*단축번호  "    </FC>'
                     + '<FC>id=SHORTCUT_FLAG   width=140 align=left                 name="*단축구분"    EditStyle=Lookup Data="DS_SHORTCUT_FLAG:CODE:NAME" </FC>'
                     + '<FC>id=ITEM_CD         width=120 align=left   edit="false"  name="*상품코드 "     </FC>'
                     + '<FC>id=MIX_CD1         width=120 align=left   edit=Numeric  name="*조합코드1"   edit={DECODE(SHORTCUT_FLAG,"0","false","true")}  </FC>'
                     + '<FC>id=MIX_CD2         width=120 align=left   edit=Numeric  name="*조합코드2"   edit={IF(SHORTCUT_FLAG="2" AND MIX_CD1 <> "", "ture", IF(SHORTCUT_FLAG="3" AND MIX_CD1 <> "", "true", "false"))}  </FC>'
                     + '<FC>id=MIX_CD3         width=120 align=left   edit=Numeric  name="*조합코드3"   EditStyle=Lookup Data="DS_HS_MG:EVENT_FLAG:EVENT_FLAG" edit={IF(SHORTCUT_FLAG="3" AND MIX_CD2 <> "", "ture", "false")}  </FC>'
                     + '<FC>id=ITEM_NAME       width=120 align=left                 name="*상품명 "     edit={IF(SHORTCUT_FLAG <>"0","true","false")}</FC>'
                     + '<FC>id=SALE_PRC        width=80  align=right  edit=Numeric  name="판매매가 "     edit={IF(SALE_PRC_YN="Y" AND SHORTCUT_FLAG <>"0","true","false")}</FC>'
                     ;
                     

    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
                     
    GD_DETAIL.ColumnProp('ITEM_CD', 'Edit') = 'None';  
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
    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    
    if( DS_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_DETAIL.Focus();
            return ;
        }
    }
    bfMasterRow = 0;
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
    if (!DS_DETAIL.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if(DS_DETAIL.CountRow > 0){
            GD_DETAIL.Focus();
            return;
        }
        if( DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }

    if( !checkValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','04','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_DETAIL.Focus();
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        GD_DETAIL.Focus();
        return; 
    }
    
    TR_MAIN.Action="/dps/pcod808.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();    
    
    if(TR_MAIN.ErrorCode == 0){
        searchDetail();        
    }
    GD_DETAIL.Focus();

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
 * btn_addRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  행 추가
 * return값 : void
 */
function btn_addRow(){
    var masterRow = DS_MASTER.RowPosition;
    if( masterRow < 1){
        showMessage(INFORMATION, OK, "USER-1000", "POS 선택 후 행추가가 가능합니다.");
        if(DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }
    if( DS_MASTER.NameValue(masterRow,"USE_YN")=="N"){
        showMessage(INFORMATION, OK, "USER-1000", "사용할 수 없는 POS입니다.");
        GD_MASTER.Focus();
        return;     
    }
    var strCd      = DS_MASTER.NameValue(masterRow,"STR_CD");
    var posNO      = DS_MASTER.NameValue(masterRow,"POS_NO");

    DS_DETAIL.AddRow();
    var row = DS_DETAIL.CountRow;
    DS_DETAIL.NameValue(row,"STR_CD")        = strCd;
    DS_DETAIL.NameValue(row,"POS_NO")        = posNO;
    DS_DETAIL.NameValue(row,"SHORTCUT_FLAG") = "4";
    DS_DETAIL.NameValue(row,"DEL_YN")        = "Y";
    
    GD_DETAIL.ColumnProp("ITEM_CD","EditStyle")     = "Popup";
    GD_DETAIL.ColumnProp("ITEM_CD","EditLimitText") = 13;
    DS_DETAIL.NameValue(row,"SALE_PRC_YN")          = "N";
    
    setFocusGrid(GD_DETAIL, DS_DETAIL, row, "SHORTCUT_NO");
}
/**
 * btn_delRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  행 삭제
 * return값 : void
 */
function btn_delRow(){
    if(DS_DETAIL.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        if(DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;     
    }
    var ckeckYn = DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "DEL_YN");
    if(ckeckYn == "N"){
        showMessage(INFORMATION, OK, "USER-1000", "당일 등록한 건만 삭제 가능합니다.");
        GD_DETAIL.Focus();
        return;
    }
    DS_DETAIL.DeleteRow(DS_DETAIL.RowPosition);
}
/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  POS 리스트 조회
 * return값 : void
 */
function searchMaster(){

    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    
    var strStrCd      = LC_STR_CD.BindColVal;
    var strPosNo      = EM_POS_NO.Text;
    var strPosName    = EM_POS_NAME.Text;
    var strShopName   = EM_SHOP_NAME.Text;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="	+encodeURIComponent(strStrCd)
                   + "&strPosNo="	+encodeURIComponent(strPosNo)
                   + "&strPosName=" +encodeURIComponent(strPosName)
                   + "&strShopName="+encodeURIComponent(strShopName);
    TR_SUB.Action="/dps/pcod808.pc?goTo="+goTo+parameters;      
    TR_SUB.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_SUB.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 
/**
 * searchDetail()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  POS 단축키 리스트 조회
 * return값 : void
 */
function searchDetail(){
    DS_DETAIL.ClearData();
    
    var masterRow    = DS_MASTER.RowPosition;
    if( masterRow < 1){
        if(DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }
    var strStrCd   = DS_MASTER.NameValue(masterRow,"STR_CD");
    var strPosNo   = DS_MASTER.NameValue(masterRow,"POS_NO");

    
    var goTo       = "searchDetail" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strPosNo="+encodeURIComponent(strPosNo);
    TR_MAIN.Action="/dps/pcod808.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_DETAIL);

} 
/**
 * getPosNo()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : POS 번호를 조회한다.
 * return값 : void
 */
function getPosNo( evnFlag){

    var codeObj = EM_POS_NO;
    var nameObj = EM_POS_NAME;
    var strObj  = LC_STR_CD;
    
    if( strObj.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        strObj.Focus();
        return;
    }
    var strCd = strObj.BindColVal;
    
    if( codeObj.Text == "" && evnFlag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnFlag == "POP" ){
        posNoPop(codeObj,nameObj, strCd);
        codeObj.Focus();
    }else if( evnFlag == "NAME" ){
        setPosNoNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 0, strCd);
    }
    
}

/**
 * setSkuCodeToGrid()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품 팝업을 실행한다.(그리드)
 * return값 : void
**/
function setSkuCodeToGrid(evnFlag, row){
    var codeStr = DS_DETAIL.NameValue(row,"MIX_CD1");
    var strCd   = DS_DETAIL.NameValue(row,"STR_CD");
    
    if( codeStr == "" && evnFlag != 'POP'){
    	DS_DETAIL.NameValue(row,"ITEM_CD")       = "";
    	DS_DETAIL.NameValue(row,"ITEM_NAME")     = "";
    	DS_DETAIL.NameValue(row,"ORG_ITEM_NAME") = "";
        DS_DETAIL.NameValue(row,"SALE_PRC")      = "";
        DS_DETAIL.NameValue(row,"SALE_PRC_YN")   = "N";
        return;
    }
    var rtnMap;
    if( evnFlag == 'POP'){
        rtnMap = strSkuToGridPop(codeStr,'','Y', '', strCd, '', '', '', 'Y');
    }else{
        DS_MASTER.NameValue(row,"ORG_ITEM_NAME")  = "";
        DS_MASTER.NameValue(row,"ITEM_NAME") = "";
        rtnMap = setStrSkuNmWithoutToGridPop("DS_SEARCH_NM", codeStr, '' ,'Y', 1, '', strCd, '', '', '', 'Y');
    }
    
    if( rtnMap == null){
        if( DS_DETAIL.NameValue(row,"ORG_ITEM_NAME") == ""){
        	DS_DETAIL.NameValue(row,"ITEM_CD")    = "";
            DS_DETAIL.NameValue(row,"ITEM_NAME")  = "";
            DS_DETAIL.NameValue(row,"SALE_PRC")   = "";
            DS_DETAIL.NameValue(row,"SALE_PRC_YN")= "N";
        }       
        return;
    }
    if( codeStr == rtnMap.get("SKU_CD") && evnFlag == 'POP'){
    	return;
    }

    DS_DETAIL.NameValue(row,"MIX_CD1")       = rtnMap.get("SKU_CD");
    DS_DETAIL.NameValue(row,"ITEM_CD")       = rtnMap.get("SKU_CD");
    DS_DETAIL.NameValue(row,"ITEM_NAME")     = rtnMap.get("SKU_NAME");
    DS_DETAIL.NameValue(row,"ORG_ITEM_NAME") = rtnMap.get("SKU_NAME");
    DS_DETAIL.NameValue(row,"SALE_PRC_YN")   = rtnMap.get("SKU_TYPE")=='2'?'Y':'N';
    DS_DETAIL.NameValue(row,"SALE_PRC")      = "";
    
}
/**
 * setPumbunCodeToGrid()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드 팝업을 실행한다.(그리드)
 * return값 : void
**/
function setPumbunCodeToGrid(evnFlag, row){
    var codeStr = DS_DETAIL.NameValue(row,"MIX_CD1");
    var strCd   = DS_DETAIL.NameValue(row,"STR_CD");
    
    if( codeStr == "" && evnFlag != 'POP'){
    	DS_DETAIL.NameValue(row,"ITEM_CD")         = "";
    	DS_DETAIL.NameValue(row,"MIX_CD2")         = "";
    	DS_DETAIL.NameValue(row,"MIX_CD3")         = "";
        DS_DETAIL.NameValue(row,"ITEM_NAME")       = "";
        DS_DETAIL.NameValue(row,"ORG_ITEM_NAME")   = "";
        return;
    }
    var rtnMap;
    if( evnFlag == 'POP'){
        rtnMap = strPbnToGridPop(codeStr,'','Y', '', strCd, '', '', '', '', 'Y');
    }else{
        DS_MASTER.NameValue(row,"ORG_ITEM_NAME")  = "";
        DS_MASTER.NameValue(row,"ITEM_NAME") = "";
        rtnMap = setStrPbnNmWithoutToGridPop("DS_SEARCH_NM", codeStr, '' ,'Y', 1, '', strCd, '', '', '', '', 'Y');
    }
    
    if( rtnMap == null){
        if( DS_DETAIL.NameValue(row,"ORG_ITEM_NAME") == ""){
            DS_DETAIL.NameValue(row,"ITEM_CD")   = "";
            DS_DETAIL.NameValue(row,"MIX_CD1")   = "";
            DS_DETAIL.NameValue(row,"ITEM_NAME") = "";
        }       
 		DS_DETAIL.NameValue(row,"MIX_CD1")      = "";
        return;
    }
    
    DS_DETAIL.NameValue(row,"MIX_CD1")      = rtnMap.get("PUMBUN_CD");
    DS_DETAIL.NameValue(row,"ITEM_CD")      = rtnMap.get("PUMBUN_CD");
    DS_DETAIL.NameValue(row,"ITEM_NAME")    = rtnMap.get("PUMBUN_NAME");
    DS_DETAIL.NameValue(row,"ORG_ITEM_NAME")= rtnMap.get("PUMBUN_NAME");
    DS_DETAIL.NameValue(row,"MIX_CD2")      = "";
    DS_DETAIL.NameValue(row,"MIX_CD3")      = "";
    
    /* 해당 브랜드의 행사구분 값을 가져온다. */
   if(DS_DETAIL.NameValue(row,"SHORTCUT_FLAG") == "3"){ 
	   searchMgHs(row);
// 	   if(DS_HS_MG.CountRow > 0){
// 	   	DS_DETAIL.NameValue(row,"MIX_CD3") = DS_HS_MG.NameValue(1, "EVENT_FLAG");
// 	   }
   } 
}
 
 /**
  * setPumbunCodeToGrid()
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-04-04
  * 개    요 : 품목 팝업을 실행한다.(그리드)
  * return값 : void
 **/
 function setPumMokCodeToGrid(evnFlag, row){
	 
     var codeStr     = DS_DETAIL.NameValue(row,"MIX_CD2");
     var strCd       = DS_DETAIL.NameValue(row,"STR_CD");
     var strPumbunCd = DS_DETAIL.NameValue(row,"MIX_CD1");
     
     if( codeStr == "" && evnFlag != 'POP'){
			DS_DETAIL.NameValue(row,"ITEM_CD")       =  DS_DETAIL.NameValue(row,"ITEM_CD").substring(0,6);
         return;
     }
     var rtnMap;
     if( evnFlag == 'POP'){
         rtnMap = pbnPmkToGridPop(codeStr , '' , strPumbunCd);
         
     }else{
         DS_MASTER.NameValue(row,"ITEM_NAME") = "";
         rtnMap = setPbnPmkNmWithoutToGridPop("DS_SEARCH_NM", codeStr, '' , strPumbunCd , '1');
     }
     
     if( rtnMap == null){
    	 DS_DETAIL.NameValue(row,"ITEM_CD") =  DS_DETAIL.NameValue(row,"ITEM_CD").substring(0,6);
         return;
     }
 	 
     DS_DETAIL.NameValue(row,"MIX_CD2") = rtnMap.get("PUMMOK_SRT_CD");
     DS_DETAIL.NameValue(row,"ITEM_CD") =  DS_DETAIL.NameValue(row,"ITEM_CD").substring(0,6) + rtnMap.get("PUMMOK_SRT_CD");
  }
 
/**
 * checkValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 입력 값을 검증한다.
 * return값 : void
 */
function checkValidation(){
    var row;
    var colid;
    var errYn = false;

    var dupRow = checkDupKey(DS_DETAIL,"SHORTCUT_NO");
    if( dupRow > 0){
        showMessage(EXCLAMATION, OK, "USER-1044");
        setFocusGrid(GD_DETAIL,DS_DETAIL,dupRow,"SHORTCUT_NO");
        return false;
    }
    
    for(var i=1; i<=DS_DETAIL.CountRow; i++){
        var rowStatus = DS_DETAIL.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;
        if( DS_MASTER.NameValue(DS_MASTER.RowPosition,"USE_YN")=="N"){
            showMessage(INFORMATION, OK, "USER-1000", "사용할 수 없는 POS 입니다.");
            GD_MASTER.Focus();
            return;     
        }
        row = i;
        if( DS_DETAIL.NameValue(i,"SHORTCUT_NO")=="" ){
            showMessage(EXCLAMATION, OK, "USER-1008", "단축번호",0);
            errYn = true;
            colid = "SHORTCUT_NO";
            break;
        }
        if( DS_DETAIL.NameValue(i,"SHORTCUT_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "단축구분");
            colid = "SHORTCUT_FLAG";    
            errYn = true;
            break;
        }
        var shortCutFlag = DS_DETAIL.NameValue(i,"SHORTCUT_FLAG");
        // 단축구분 none 일 경우 상품코드, 상품명, 판매매가 입력 받지 않음
        if( shortCutFlag == "0")
            continue;

        if( DS_DETAIL.NameValue(i,"ITEM_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "상품코드");
            colid = "ITEM_CD";    
            errYn = true;
            break;
        }
        
        if( shortCutFlag =="4" || shortCutFlag =="1" ){
        	if( DS_DETAIL.NameValue(i,"ORG_ITEM_NAME")==""){
                showMessage(EXCLAMATION, OK, "USER-1036", "상품코드");
                colid = "ITEM_CD";    
                errYn = true;
                break;
            }
        }else{
        	var itemCdLen = replaceStr(DS_DETAIL.NameValue(i,"ITEM_CD")," ","").length;
           
        	if(shortCutFlag == "2" && itemCdLen != 10){
                showMessage(EXCLAMATION, OK, "USER-1000", "단축구분 [ 브랜드+품목 ] 일 경우 <br>(상품코드:10자리)의 자리수가 잘못되었습니다.");
                colid = "ITEM_CD";    
                errYn = true;
                break;
        	}else if(shortCutFlag == "3" && itemCdLen != 12){
                showMessage(EXCLAMATION, OK, "USER-1000", "단축구분 [ 브랜드+품목+상품구분 ] 일 경우 <br>(상품코드:12자리)의 자리수가 잘못되었습니다.");
                colid = "ITEM_CD";    
                errYn = true;
                break;
        	}
        }
        /*
        if( DS_DETAIL.NameValue(i,"ITEM_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "상품명");
            colid = "ITEM_NAME";    
            errYn = true;
            break;
        }
        

        if( !checkInputByte( GD_DETAIL, DS_DETAIL, i, "ITEM_NAME", "상품명") ){
            return false;
        }
        */

        /*
        if( DS_DETAIL.NameValue(i,"SALE_PRC_YN")=="N")
            continue;
        if( Number(DS_DETAIL.NameString(i,"SALE_PRC")) < 1){
            showMessage(EXCLAMATION, OK, "USER-1008", "판매가",0);
            errYn = true;
            colid = "SALE_PRC";
            break;
        }*/
    }
    
    if(errYn){
        setFocusGrid(GD_DETAIL,DS_DETAIL,row,colid);
        return false;
    }
    return true;
}


/**
 * searchMgHs()
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-16
 * 개    요 : 행사구분 마진 조회
 * return값 : void
 */
function searchMgHs(nRow) {
    
    // 행사구분 데이터셋 클리어
    DS_HS_MG.ClearData();

    var strStrCd     = DS_DETAIL.NameValue(nRow,"STR_CD");
    var strPumBunCd  = DS_DETAIL.NameValue(nRow,"MIX_CD1");
    var strSaleDt    = "<%=strToday%>" ;
    
    var goTo       = "searchMgHs" ;    
    var action     = "O";     
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                   + "&strPumBunCd=" + encodeURIComponent(strPumBunCd)
                   + "&strSaleDt="   + encodeURIComponent(strSaleDt)
                   ;
    
    TR_MAIN.Action="/dps/pcod808.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_HS_MG=DS_HS_MG)"; //조회는 O
    TR_MAIN.Post();
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

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_DETAIL event=OnDataError(row,colid)>
    var errorCode = DS_DETAIL.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        showMessage(EXCLAMATION, OK, "USER-1003", "단축번호");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_DETAIL.ErrorMsg);       
    }
</script>
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
    if(btnSaveYn || row < 1)
        return true;

    if(DS_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 이동하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1049")!=1)
            return false;
        DS_DETAIL.ClearData();
    }
    return true;
</script>
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if(row < 1 || bfMasterRow == row)
        return;
    bfMasterRow = row;
    searchDetail();
</script>

<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
    if(row < 1)
        return;

    switch(DS_DETAIL.NameValue(row,"SHORTCUT_FLAG")){
        case '0':
            break;
        /* 품번  */
        case '1':
            GD_DETAIL.ColumnProp("MIX_CD1","EditStyle")     = "Popup";
            GD_DETAIL.ColumnProp("MIX_CD1","EditLimitText") = 6;
            DS_DETAIL.NameValue(row,"SALE_PRC_YN")          = "N";
            break;
        /* 품번 + 품목  */
        case '2':
            GD_DETAIL.ColumnProp("MIX_CD1","EditStyle")     = "Popup";
            GD_DETAIL.ColumnProp("MIX_CD1","EditLimitText") = 6;
            GD_DETAIL.ColumnProp("MIX_CD2","EditStyle")     = "Popup";
            GD_DETAIL.ColumnProp("MIX_CD2","EditLimitText") = 4;
            DS_DETAIL.NameValue(row,"SALE_PRC_YN")          = "N";
            break;
        /* 품번 + 품목 + 행사구분  */    
        case '3':
            GD_DETAIL.ColumnProp("MIX_CD1","EditStyle")     = "Popup";
            GD_DETAIL.ColumnProp("MIX_CD1","EditLimitText") = 6;
            GD_DETAIL.ColumnProp("MIX_CD2","EditStyle")     = "Popup";
            GD_DETAIL.ColumnProp("MIX_CD2","EditLimitText") = 4;
            DS_DETAIL.NameValue(row,"SALE_PRC_YN")          = "Y";
            break;
        /* 단품  */
        case '4': 
            GD_DETAIL.ColumnProp("MIX_CD1","EditStyle")     = "Popup";
            GD_DETAIL.ColumnProp("MIX_CD1","EditLimitText") = 13;
            DS_DETAIL.NameValue(row,"SALE_PRC_YN")          = "N";
            break;
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );    
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );    
</script>

<script language=JavaScript for=GD_DETAIL event=OnDropDown(row,colid)> 
    bfShortCutFlag = DS_DETAIL.NameValue(row,colid);
</script>
<script language=JavaScript for=GD_DETAIL event=OnListSelect(index,row,colid)>
    if( row < 1 || bfShortCutFlag == DS_DETAIL.NameValue(row,colid))
        return;
    
    if(colid=='SHORTCUT_FLAG'){
    	switch(DS_DETAIL.NameValue(row,colid)){
            case '0':
                break;
            /* 품번  */
            case '1':
                GD_DETAIL.ColumnProp("MIX_CD1","EditStyle")     = "Popup";
                GD_DETAIL.ColumnProp("MIX_CD1","EditLimitText") = 6;
                DS_DETAIL.NameValue(row,"SALE_PRC_YN")          = "N";
                break;
            /* 품번 + 품목  */
            case '2':
                GD_DETAIL.ColumnProp("MIX_CD1","EditStyle")     = "Popup";
                GD_DETAIL.ColumnProp("MIX_CD1","EditLimitText") = 6;
                GD_DETAIL.ColumnProp("MIX_CD2","EditStyle")     = "Popup";
                GD_DETAIL.ColumnProp("MIX_CD2","EditLimitText") = 4;
                DS_DETAIL.NameValue(row,"SALE_PRC_YN")          = "N";
                break;
            /* 품번 + 품목 + 행사구분  */    
            case '3':
                GD_DETAIL.ColumnProp("MIX_CD1","EditStyle")     = "Popup";
                GD_DETAIL.ColumnProp("MIX_CD1","EditLimitText") = 6;
                GD_DETAIL.ColumnProp("MIX_CD2","EditStyle")     = "Popup";
                GD_DETAIL.ColumnProp("MIX_CD2","EditLimitText") = 4;
                DS_DETAIL.NameValue(row,"SALE_PRC_YN")          = "Y";
                break;
            /* 단품  */
            case '4': 
                GD_DETAIL.ColumnProp("MIX_CD1","EditStyle")     = "Popup";
                GD_DETAIL.ColumnProp("MIX_CD1","EditLimitText") = 13;
                DS_DETAIL.NameValue(row,"SALE_PRC_YN")          = "N";
                break;
    	}
    	/* 단축구분 변경에 따라 초기화 */
        DS_DETAIL.NameValue(row,"ITEM_CD")       = "";
        DS_DETAIL.NameValue(row,"ITEM_NAME")     = "";
        DS_DETAIL.NameValue(row,"ORG_ITEM_NAME") = "";
        DS_DETAIL.NameValue(row,"SALE_PRC")      = "";
        DS_DETAIL.NameValue(row,"MIX_CD1")       = "";
        DS_DETAIL.NameValue(row,"MIX_CD2")       = "";
        DS_DETAIL.NameValue(row,"MIX_CD3")       = "";
    }
    /* 행사구분 값 변경시 상품코드에 셋팅 */
    if(colid=='MIX_CD3'){
    	DS_DETAIL.NameValue(row,"ITEM_CD") =  DS_DETAIL.NameValue(row,"ITEM_CD").substring(0,10)+DS_DETAIL.NameValue(row,"MIX_CD3");
    	
    }
</script> 
<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,oldData)>
    if( row < 1 || isOnPopup)
        return;
    var value = DS_DETAIL.NameValue(row,colid);
    if( oldData == value )
        return;
    switch(colid){
        /* 조합코드 1 */
    	case 'MIX_CD1':
    		switch(DS_DETAIL.NameValue(row,"SHORTCUT_FLAG")){
    		case '0' :
    			break;
    		/* 품번  */
    		case '1' :
    			setPumbunCodeToGrid('NAME',row);
    			break;
    		/* 품번 + 품목 */
    		case '2' :
    			setPumbunCodeToGrid('NAME',row);
				break;
    		/* 품번  + 품목 + 행사구분 */
    		case '3' :
    			setPumbunCodeToGrid('NAME',row);
				break;
    		/* 단품 */
    		case '4' :
    			setSkuCodeToGrid('NAME',row);
				break;
    		}
	    	break;
	    	
	    /* 조합코드 2 */
    	case 'MIX_CD2':
    		switch(DS_DETAIL.NameValue(row,"SHORTCUT_FLAG")){
    		case '0' :
    			break;
    		/* 품번  */
    		case '1' :
    			break;
    		/* 품번 + 품목 */
    		case '2' :
    			setPumMokCodeToGrid('NAME',row);
				break;
    		/* 품번  + 품목 + 행사구분 */
    		case '3' :
    			setPumMokCodeToGrid('NAME',row);
				break;
    		/* 단품 */
    		case '4' :
				break;
    		}
	    	break;
    }
</script>
<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
    if( row < 1 )
        return;
    isOnPopup = true;
    switch(colid){
        /* 조합코드 1 */
    	case 'MIX_CD1':
    		switch(DS_DETAIL.NameValue(row,"SHORTCUT_FLAG")){
    		case '0' :
    			break;
    		/* 품번  */
    		case '1' :
    			setPumbunCodeToGrid('POP',row);
    			break;
    		/* 품번 + 품목 */
    		case '2' :
    			setPumbunCodeToGrid('POP',row);
				break;
    		/* 품번  + 품목 + 행사구분 */
    		case '3' :
    			setPumbunCodeToGrid('POP',row);
				break;
    		/* 단품 */
    		case '4' :
    			setSkuCodeToGrid('POP',row);
				break;
    		}
	    	break;
	    	
	    /* 조합코드 2 */
    	case 'MIX_CD2':
    		switch(DS_DETAIL.NameValue(row,"SHORTCUT_FLAG")){
    		case '0' :
    			break;
    		/* 품번  */
    		case '1' :
    			break;
    		/* 품번 + 품목 */
    		case '2' :
    			setPumMokCodeToGrid('POP',row);
				break;
    		/* 품번  + 품목 + 행사구분 */
    		case '3' :
    			setPumMokCodeToGrid('POP',row);
				break;
    		/* 단품 */
    		case '4' :
				break;
    		}
	    	break;
    }
    isOnPopup = false;
</script>
<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    if( bfStrCd == this.BindColVal)
        return;
    
    if( DS_DETAIL.IsUpdated ){
        // 변경된 상세내역이 존재합니다. 점을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","점") != 1 ){
            setComboData(LC_STR_CD,bfStrCd);
            GD_DETAIL.Focus();
            return;
        }
    }
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    EM_POS_NO.Text    = "";
    EM_POS_NAME.Text  = "";
    EM_SHOP_NAME.Text = "";
    
    bfStrCd = this.BindColVal;
</script>

<!-- POS 번호(조회) -->
<script language=JavaScript for=EM_POS_NO event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getPosNo('NAME');
</script>

<!-- POS구분 (상세) -->
<script language=JavaScript for=LC_POS_FLAG_D event=OnSelChange()>
    var value = this.BindColVal;
    // PDA POS 경우 단축번호 1~9만 등록 가능
    if( value == '05'){
    	GD_DETAIL.ColumnProp("SHORTCUT_NO","EditLimitText") = 1;
    }else{
        GD_DETAIL.ColumnProp("SHORTCUT_NO","EditLimitText") = 2;    	
    }
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
<comment id="_NSID_"><object id="DS_POS_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SHORTCUT_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_HS_MG"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
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
            <th width="80" class="point">점</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" >POS 번호</th>
            <td width="200" >
              <comment id="_NSID_">
                <object id=EM_POS_NO classid=<%=Util.CLSID_EMEDIT%>  width=40  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getPosNo('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_POS_NAME classid=<%=Util.CLSID_EMEDIT%>  width=130  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80" >매장명</th>
            <td >
               <comment id="_NSID_">
                 <object id=EM_SHOP_NAME classid=<%= Util.CLSID_EMEDIT %> width=160 tabindex=1 align="absmiddle"></object>
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
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width="430"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=504 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
        <td class="PL10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td ><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="50" >POS번호</th>
                    <td width="190">
                      <comment id="_NSID_">
                        <object id=EM_POS_NO_D classid=<%=Util.CLSID_EMEDIT%>  width=60  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_POS_NAME_D classid=<%=Util.CLSID_EMEDIT%>  width=123  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th width="50" >매장명</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_SHOP_NAME_D classid=<%=Util.CLSID_EMEDIT%>  width=155  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th >POS구분</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_POS_FLAG_D classid=<%= Util.CLSID_LUXECOMBO %> width=188 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th >사용여부</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_USE_YN_D classid=<%= Util.CLSID_LUXECOMBO %> width=155 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="right PB03"><img 
                 src="/<%=dir%>/imgs/btn/add_row.gif" onClick="javascript:btn_addRow();" hspace="2" /><img 
                 src="/<%=dir%>/imgs/btn/del_row.gif" onClick="javascript:btn_delRow();"  /></td>
              </tr>
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <object id=GD_DETAIL width=100% height=428 classid=<%=Util.CLSID_GRID%>>
                          <param name="DataID" value="DS_DETAIL">
                        </object>
                      </comment>
                      <script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
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
<object id=BO_HEADER classid=<%= Util.CLSID_BIND %>>
        <param name=DataID          value=DS_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>col=POS_NO          ctrl=EM_POS_NO_D        param=Text </c>
            <c>col=POS_NAME        ctrl=EM_POS_NAME_D      param=Text </c>
            <c>col=SHOP_NAME       ctrl=EM_SHOP_NAME_D     param=Text </c>
            <c>col=POS_FLAG        ctrl=LC_POS_FLAG_D      param=BindColVal </c>
            <c>col=USE_YN          ctrl=LC_USE_YN_D        param=BindColVal </c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

