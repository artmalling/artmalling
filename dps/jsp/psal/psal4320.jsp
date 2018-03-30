<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 도면매출 > 도면매출정보(층)
 * 작 성 일 : 2010.06.07
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : psal4320.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.06.07 (정진영) 신규작성
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
<%String dir = BaseProperty.get("context.common.dir");
  String uploadDir = BaseProperty.get("dps.upload.http")+"floorPlan";
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
<style>
<!--
.dragme{position:absolute;}
.v_table{Border:solid 1px #b4d0e1; padding-left:1px; font-size:12px;}
.v_table TH{Border:solid 1px #b4d0e1; background-color:#ebf2f8;  color:#146ab9; height:15px; letter-spacing: -0.1ex; font-size:12px; font-weight:100; text-align:left; padding-left:2px; padding-right:1px;} 
.v_table TD{Border:solid 1px #b4d0e1;  padding-right:2px; padding-left:1px; background-color:#ffffff;  height:15px; letter-spacing:0.0ex; font-size:12px;} 


-->
</style>

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
//var imgDir = '/<%=dir%>/imgs/test';
var imgDir = '<%=uploadDir%>';

var spotClickYn = false;
var ie=document.all;
var nn6=document.getElementById&&!document.all;

var isdrag=false;
var x,y;
var dobj;
var lobj;
var SPOT_X,SPOT_Y;
var spotPx = 12;
var pumbunPopPx = 140;
var imgDivHeight = 525;
var masterX = 218;
var masterY = 44;
var firstSearch = true;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	
    // Input Data Set Header 초기화
    DS_FLOOR_PLAN.setDataHeader('<gauce:dataset name="H_SEL_FLOOR_PLAN"/>');
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화

    // EMedit에 초기화
    
    //콤보 초기화
    initComboStyle( LC_STR_CD,   DS_STR_CD,   "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle( LC_FLOOR_CD, DS_FLOOR_CD, "CODE^0^30,NAME^0^110", 1, PK);  //층
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "N");
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_FLOOR_CD", "D", "P061", "N");

    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_FLOOR_CD,"B2");
    
    // 도면 조회
    //searchFloorPlan();
    
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
//

/**
 * btn_Search()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 searchFloorPlan();
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

}
/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * searchFloorPlan()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 도면을 조회합니다.
 * return값 : void
 */
function searchFloorPlan(){
    var strCd        = LC_STR_CD.BindColVal;
    var floorCd      = LC_FLOOR_CD.BindColVal;

    var goTo       = "searchFloorPlan" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strFloorCd="+encodeURIComponent(floorCd);
    TR_MAIN.Action="/dps/psal432.ps?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_FLOOR_PLAN=DS_FLOOR_PLAN)"; //조회는 O
    TR_MAIN.Post();

    
    if( DS_FLOOR_PLAN.CountRow < 1){
        DIV_BACK_IMG_NO.style.display="";
        DIV_BACK_IMG.style.display="none";
        clearSpot();
        clearSum();
        DS_MASTER.ClearData();        
    }else{
        IMG_BACKGROUND.src = imgDir+"/"+DS_FLOOR_PLAN.NameValue(1,"FILENAME");
        DIV_BACK_IMG_NO.style.display="none";
        DIV_BACK_IMG.style.display="";
        
        serachMaster();
    }
}
/**
 * searchFloorPlan()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 도면을 조회합니다.
 * return값 : void
 */
function serachMaster(){

    var strCd        = LC_STR_CD.BindColVal;
    var floorCd      = LC_FLOOR_CD.BindColVal;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strFloorCd="+encodeURIComponent(floorCd);
    TR_MAIN.Action="/dps/psal432.ps?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER,O:DS_TIME=DS_SEARCH_NM)"; //조회는 O
    TR_MAIN.Post();
    if( DS_SEARCH_NM.CountRow > 0 ){
    	var searchDate = DS_SEARCH_NM.NameValue(1,"TIME");
    	var tmpDate = new Date(searchDate.substring(0,4),Number(searchDate.substring(2,6))-1,searchDate.substring(6,8),searchDate.substring(8,10),searchDate.substring(10,12),0);
    	TD_NOW_DATE.innerText = tmpDate.toFormatString("YYYY년 MM월 DD일  HH24:MI") + " 현재";    
    }else{
        TD_NOW_DATE.innerText = getTodayFormat("YYYY년 MM월 DD일  HH24:MI") + " 현재";    	
    }
    
    clearSum();
    if(firstSearch){
        clearSpot();
        initPumbun( );
        firstSearch = false;

    }else{
    	refreshPumbun();
    }

    initFlorSum();
}
/**
 * spotClick()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 점 클릭 여부를 설정합니다.
 * return값 : void
 */
function spotClick(btnFlag){
	if(btnFlag == 1){
		spotClickYn = !spotClickYn;
	}
}
/**
 * cnvStrVetical()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 명칭을 세로로 표시합니다.
 * return값 : void
 */
function cnvStrVetical(str){

    var totalNum = str.length;
    if( totalNum < 1)
    	return str;

    var rtnStr = "";
    for( var i = 0; i< totalNum ; i++){
        rtnStr += str.charAt(i);
        if( i+1 != totalNum)
        	rtnStr += "<br>";
    }
    return rtnStr; 
}

/**
 * numberFormatSetting()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 숫자 형식을 천자리마다 ', '처리를 합니다.
 * return값 : void
 */
function numberFormatSetting(num){
	var tmpStr = String(num);
	var tmpNums = tmpStr.split("\.");
	var tmpNum = tmpNums[0];
	var totalNum = tmpNum.length;
	if( totalNum < 4)
		return tmpStr;
	var tmpAtcnt = 3-(totalNum%3);
	
	var rtnStr = "";
	for( var i = 0; i< totalNum ; i++){
		rtnStr += tmpNum.charAt(i);
		rtnStr += (((i+tmpAtcnt)%3)==2)&&(totalNum-1!=i)?",":"";
	}
	if(tmpNums.length == 2){
		rtnStr += "."+tmpNums[1];
	}
	return rtnStr; 
}
/**
 * spotMouseOver()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 표시점에 마우스 선택 시 팝업창 표시를 설정 합니다.
 * return값 : void
 */
function spotMouseOver( spotObj){
	var id = spotObj.id;
	var pumbunId = id.substring(0,(id.length-5));
	var pumbunObj = document.getElementById(pumbunId)
	if( pumbunObj.style.display != ""){
		pumbunObj.style.display = "";
		document.getElementById(pumbunId+"_LINE").style.display = "";
	}else{
		spotClickYn = true;
	}
}
/**
 * spotMouseOut()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 표시점에서 마우스 아웃시 팝업창 표시를 설정 합니다.
 * return값 : void
 */
function spotMouseOut( spotObj){
    var id = spotObj.id;
    var pumbunId = id.substring(0,(id.length-5));
    var pumbunObj = document.getElementById(pumbunId)
    if( pumbunObj.style.display == "" && !spotClickYn){
        pumbunObj.style.display = "none";
        document.getElementById(pumbunId+"_LINE").style.display = "none";
    }
    spotClickYn = false;
}

/**
 * selPumbunMouseOver()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 브랜드에 마우스 오버시 실행합니다.
 * return값 : void
 */
function selPumbunMouseOver( pumbunObj){
    var id = pumbunObj.id;
    var selSpotObj = document.getElementById(id+"_SPOT_SEL")
    var spotObj    = document.getElementById(id+"_SPOT")
    if( selSpotObj.style.display != ""){
    	selSpotObj.style.display = "";
    	spotObj.style.display    = "none";
    	
    	if(parseInt(document.getElementById(id+"_LINE").style.width+0) != 0)
            document.getElementById(id+"_LINE").style.borderStyle = "solid";
    }
}
/**
 * selPumbunMouseOut()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 브랜드에 마우스 아웃시 실행 합니다.
 * return값 : void
 */
function selPumbunMouseOut( pumbunObj){
	var id = pumbunObj.id;
	var selSpotObj = document.getElementById(id+"_SPOT_SEL")
    var spotObj    = document.getElementById(id+"_SPOT")
    if( selSpotObj.style.display == "" ){
    	selSpotObj.style.display = "none";
        spotObj.style.display    = "";
    	if(parseInt(document.getElementById(id+"_LINE").style.width+0) != 0)
            document.getElementById(id+"_LINE").style.borderStyle = "dashed";
    }
}
/**
 * getGoalRate()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 달성율을 계산합니다.
 * return값 : void
 */
function getGoalRate(goalSaleAmt, saleAmt){
	if( goalSaleAmt == 0 )
		return 0;
	return getRoundDec("1",saleAmt/goalSaleAmt*100,2);
}
/**
 * initFlorSum()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 합계 내역을 표시합니다.
 * return값 : void
 */
function initFlorSum(){
	
	var goalSaleAmt = DS_MASTER.sum(DS_MASTER.ColumnIndex("GOAL_SALE_AMT"),0,0);
    var saleAmt     = DS_MASTER.sum(DS_MASTER.ColumnIndex("SALE_AMT"),0,0);
    var custCnt     = DS_MASTER.sum(DS_MASTER.ColumnIndex("CUST_CNT"),0,0);

    document.getElementById("TH_FLOR_PUMBUN_CNT").innerText = numberFormatSetting(DS_MASTER.CountRow);
    document.getElementById("TH_FLOR_GOAL_SALE_AMT").innerText = numberFormatSetting(goalSaleAmt);
    document.getElementById("TH_FLOR_SALE_AMT").innerText = numberFormatSetting(saleAmt);
    document.getElementById("TH_FLOR_CUST_CNT").innerText = numberFormatSetting(custCnt);
    document.getElementById("TH_FLOR_GOAL_RATE").innerText = numberFormatSetting(getGoalRate(goalSaleAmt,saleAmt))+"%";

    if( DS_MASTER.CountRow < 1){
        return;
    }   
    var total = DS_MASTER.CountRow;
    DS_MASTER.Sortexpr = "+ORG_CD";
    DS_MASTER.Sort();
    var bfOrgCd;
    var teamName;
    var bfCnt = 0;
    var bfGoalSaleAmt = 0;
    var bfSaleAmt = 0;
    var bfCcustCnt = 0;
    
    var tmpTableStr =  '<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">';    
    for( var i= 1; i<= total; i++){
    	var orgCd = DS_MASTER.NameValue(i,"ORG_CD");
    	
    	if( bfOrgCd == orgCd.substring(0,6)+"0000" ){
    		bfGoalSaleAmt += Number(DS_MASTER.NameValue(i,"GOAL_SALE_AMT"));
    		bfSaleAmt     += Number(DS_MASTER.NameValue(i,"SALE_AMT"));
    		bfCcustCnt    += Number(DS_MASTER.NameValue(i,"CUST_CNT"));
    		bfCnt++;
    	}else{
    		if( i != 1 )
    			tmpTableStr += getTeamTable( teamName, bfCnt, bfGoalSaleAmt, bfSaleAmt, bfCcustCnt );
    		
    		bfOrgCd       = orgCd.substring(0,6)+"0000";
    		bfCnt         = 1;
    		teamName      = DS_MASTER.NameValue(i,"TEAM_NAME");
            bfGoalSaleAmt = Number(DS_MASTER.NameValue(i,"GOAL_SALE_AMT"));
            bfSaleAmt     = Number(DS_MASTER.NameValue(i,"SALE_AMT"));
            bfCcustCnt    = Number(DS_MASTER.NameValue(i,"CUST_CNT"));
    	}
    }
    tmpTableStr += getTeamTable( teamName, bfCnt, bfGoalSaleAmt, bfSaleAmt, bfCcustCnt );
    tmpTableStr += "</table>";
    document.getElementById("DIV_TEAM_SUM").innerHTML = teamName==""?getDummyTable():tmpTableStr;
}
/**
 * getDummyTable()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 빈 테이블을 입력한다.
 * return값 : void
 */
function getDummyTable(){
	var tmpTableStr = '<table width="100%" border="0" cellpadding="0" cellspacing="0" >';  
	tmpTableStr    += "  <tr>";
    tmpTableStr    += "   <td >&nbsp;</td>";
    tmpTableStr    += "  </tr>";
	tmpTableStr    += "</table>";
	return tmpTableStr
}
/**
 * getTeamTable()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 파트별 합계 내역을 표시하기 위한 테이블를 생성합니다.
 * return값 : void
 */
function getTeamTable( teamName, storeCnt, goalSaleAmt, saleAmt, custCnt ){

    var tmpTableStr  ="  <tr>";
    tmpTableStr     +="    <th width='10' rowSpan='5' valign='middle' align='center' >"+cnvStrVetical(teamName)+"</th>";
    tmpTableStr     +="    <th width='45'>총매장수</th>";
    tmpTableStr     +="    <td class='right' style='letter-spacing:0.0ex;'>"+numberFormatSetting(storeCnt)+"</td>";
    tmpTableStr     +="  </tr>";
    tmpTableStr     +="  <tr>";
    tmpTableStr     +="    <th>총매출</th>";
    tmpTableStr     +="    <td class='right' style='letter-spacing:0.0ex;'>"+numberFormatSetting(saleAmt)+"</td>";
    tmpTableStr     +="  </tr>";
    tmpTableStr     +="  <tr>";
    tmpTableStr     +="    <th>목표</th>";
    tmpTableStr     +="    <td class='right' style='letter-spacing:0.0ex;'>"+numberFormatSetting(goalSaleAmt)+"</td>";
    tmpTableStr     +="  </tr>";
    tmpTableStr     +="  <tr>";
    tmpTableStr     +="    <th>고객</th>";
    tmpTableStr     +="    <td class='right' style='letter-spacing:0.0ex;'>"+numberFormatSetting(custCnt)+"</td>";
    tmpTableStr     +="  </tr>";
    tmpTableStr     +="  <tr>";
    tmpTableStr     +="    <th>달성율</th>";
    tmpTableStr     +="    <td class='right' style='letter-spacing:0.0ex;'>"+numberFormatSetting(getGoalRate(goalSaleAmt,saleAmt))+"% </td>";
    tmpTableStr     +="  </tr>";
    return tmpTableStr;
}
/**
 * initPumbun()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 도면에 브랜드 내역을 표시합니다.
 * return값 : void
 */
function initPumbun( ){	
	if( DS_MASTER.CountRow < 1){
		return;
	}	
	var total = DS_MASTER.CountRow;
	for( var i= 1; i<= total; i++){	
		createPumbunObj( i );
	}
}
/**
 * refreshPumbun()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 도면에 브랜드 의 요약 정보를 재 표시합니다.
 * return값 : void
 */
function refreshPumbun(){

	var total = DS_MASTER.CountRow;
    if( total < 1){
    	clearSpot();
        return;
    }

    var pumbunList = document.getElementById("DIV_BACK_PUMBUN").getElementsByTagName('div');
    var delList = new Array();
    for(var i = 0 ;i<pumbunList.length; i++){
    	var tmpDivId    = pumbunList[i].id;
    	var tmpPumbunId = tmpDivId.split("_")[1];
    	var pumbunRow   = DS_MASTER.NameValueRow("PUMBUN_CD",tmpPumbunId);
    	if(pumbunRow < 1){
    		delList.push(tmpDivId);
    	}
    }
    if(delList.length > 0){
        var lineDiv    = document.getElementById("DIV_BACK_LINE");
        var selSpotDiv = document.getElementById("DIV_BACK_SEL_SPOT");
        var spotDiv    = document.getElementById("DIV_BACK_SPOT");
        var pumbunDiv  = document.getElementById("DIV_BACK_PUMBUN");
        
    	for(var i = 0 ;i<delList.length; i++){
    		var tmpId = delList[i];
    		lineDiv.removeChild(document.getElementById(tmpId+"_LINE"));
    		selSpotDiv.removeChild(document.getElementById(tmpId+"_SPOT_SEL"));
    		spotDiv.removeChild(document.getElementById(tmpId+"_SPOT"));
    		pumbunDiv.removeChild(document.getElementById(tmpId));    		
    	}
    }
    
    for( var i= 1; i<= total; i++){
        var blockId       = DS_MASTER.NameValue(i,"BLOCK_ID");
        var pumbunCd      = DS_MASTER.NameValue(i,"PUMBUN_CD");
        var pumbunObj     = document.getElementById(blockId+"_"+pumbunCd);
        
        if(pumbunObj){
            var pumbunName    = DS_MASTER.NameValue(i,"PUMBUN_NAME");
            var goalSaleAmt   = DS_MASTER.NameValue(i,"GOAL_SALE_AMT");
            var saleAmt       = DS_MASTER.NameValue(i,"SALE_AMT");
            var custCnt       = DS_MASTER.NameValue(i,"CUST_CNT");
            var goalRate      = getGoalRate(goalSaleAmt,saleAmt);
            pumbunObj.innerHTML = getPumbunInfoTable( pumbunName, goalSaleAmt, saleAmt, custCnt, goalRate);
        }else{
        	 createPumbunObj( i );
        }
    }
}
/**
 * createPumbunObj()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 브랜드 내역을 생성합니다.
 * return값 : void
 */
function createPumbunObj( row ){

    var blockId       = DS_MASTER.NameValue(row,"BLOCK_ID");
    var pumbunCd      = DS_MASTER.NameValue(row,"PUMBUN_CD");
    var pumbunName    = DS_MASTER.NameValue(row,"PUMBUN_NAME");
    var infoViewYn    = DS_MASTER.NameValue(row,"INFO_VIEW_YN");
    var detailViewYn  = DS_MASTER.NameValue(row,"DETAIL_VIEW_YN");
    var spotX         = DS_MASTER.NameValue(row,"SPOT_X");
    var spotY         = DS_MASTER.NameValue(row,"SPOT_Y");
    var goalSaleAmt   = DS_MASTER.NameValue(row,"GOAL_SALE_AMT");
    var saleAmt       = DS_MASTER.NameValue(row,"SALE_AMT");
    var custCnt       = DS_MASTER.NameValue(row,"CUST_CNT");
    var goalRate      = getGoalRate(goalSaleAmt,saleAmt);
    
    var tmpLine    = document.createElement("div");
    var tmpSpot    = new Image();
    var tmpSelSpot = new Image();
    var tmpPumbun  = document.createElement("div");
    
    tmpLine.id    = blockId+"_"+pumbunCd+"_LINE";
    tmpSpot.id    = blockId+"_"+pumbunCd+"_SPOT";
    tmpSelSpot.id = blockId+"_"+pumbunCd+"_SPOT_SEL";
    tmpPumbun.id  = blockId+"_"+pumbunCd;
    
    tmpLine.style.position = "absolute";
    tmpLine.style.top      = parseInt(spotY)+"px";
    tmpLine.style.left     = parseInt(spotX)+"px";
    tmpLine.style.width    = "0px";
    tmpLine.style.height   = "0px";
    tmpLine.innerText      = "";
    tmpLine.style.display  = infoViewYn=="Y"?"":"none";
    
    tmpSpot.style.position = "absolute";
    tmpSpot.style.top      = (parseInt(spotY)-parseInt(spotPx/2))+"px";
    tmpSpot.style.left     = (parseInt(spotX)-parseInt(spotPx/2))+"px";
    tmpSpot.style.width    = parseInt(spotPx)+"px";
    tmpSpot.style.height   = parseInt(spotPx)+"px";
    tmpSpot.style.cursor   = "pointer";
    tmpSpot.src            = goalRate<100?"/<%=dir%>/imgs/btn/no_goal_spot.gif":"/<%=dir%>/imgs/btn/goal_spot.gif";
    tmpSpot.onmouseover    = function(){spotMouseOver(this);};
    tmpSpot.onmouseout     = function(){spotMouseOut(this);};
    tmpSpot.onmousedown    = function(){spotClick(event.button);};

    tmpSelSpot.style.position = "absolute";
    tmpSelSpot.style.top      = (parseInt(spotY)-parseInt(spotPx/2))+"px";
    tmpSelSpot.style.left     = (parseInt(spotX)-parseInt(spotPx/2))+"px";
    tmpSelSpot.style.width    = parseInt(spotPx)+"px";
    tmpSelSpot.style.height   = parseInt(spotPx)+"px";
    tmpSelSpot.src            = goalRate<100?"/<%=dir%>/imgs/btn/no_goal_spot_over.gif":"/<%=dir%>/imgs/btn/goal_spot_over.gif";
   // tmpSelSpot.style.filter   = "alpha(opacity:100,style:2,finishOpacity:0)";
    tmpSelSpot.style.display  = "";
    
    tmpPumbun.style.position = "absolute";
    tmpPumbun.style.top      = (parseInt(spotY)-80-parseInt(spotPx/2))+"px";
    tmpPumbun.style.left     = (parseInt(spotX)-parseInt(pumbunPopPx/2))+"px";
    tmpPumbun.style.width    = pumbunPopPx+"px";
    tmpPumbun.style.height   = "80px";
    tmpPumbun.style.padding  = "0px";
    tmpPumbun.style.border   = "1px solid black";
    tmpPumbun.style.overflow = "hidden";
    tmpPumbun.className      = "dragme";
    tmpPumbun.style.cursor   = detailViewYn=="Y"?"pointer":"default";
    tmpPumbun.style.backgroundColor = "#FFFFFF";
    tmpPumbun.style.display  = infoViewYn=="Y"?"":"none";
    tmpPumbun.onmouseover    = function(){selPumbunMouseOver(this);};
    tmpPumbun.onmouseout     = function(){selPumbunMouseOut(this);};
    
    
    tmpPumbun.innerHTML = getPumbunInfoTable( pumbunName, goalSaleAmt, saleAmt, custCnt, goalRate);
    document.getElementById("DIV_BACK_LINE").appendChild(tmpLine);
    document.getElementById("DIV_BACK_SEL_SPOT").appendChild(tmpSelSpot);
    document.getElementById("DIV_BACK_SPOT").appendChild(tmpSpot);
    document.getElementById("DIV_BACK_PUMBUN").appendChild(tmpPumbun);
    
    
}
/**
 * getPumbunInfoTable()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 도면에 브랜드 의 요약 정보를 표시합니다.
 * return값 : void
 */
function getPumbunInfoTable( pumbunName, goalSaleAmt, saleAmt, custCnt, goalRate){
	var tmpPumbunNm = checkByteLengthStr(pumbunName,19,"N");
	var tmpTableStr = "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='v_table'>";
    tmpTableStr     +="  <tr>";
    //tmpTableStr     +="    <th width='45' >품명</th>";
    tmpTableStr     +="    <th colspan='2'>"+(tmpPumbunNm!=null?(tmpPumbunNm+"..."):pumbunName)+"</th>";
    tmpTableStr     +="  </tr>";
    tmpTableStr     +="  <tr>";
    tmpTableStr     +="    <th width='45'>총매출</th>";
    tmpTableStr     +="    <td class='right'>"+numberFormatSetting(saleAmt)+"</td>";
    tmpTableStr     +="  </tr>";
    tmpTableStr     +="  <tr>";
    tmpTableStr     +="    <th width='45'>목표</th>";
    tmpTableStr     +="    <td class='right'>"+numberFormatSetting(goalSaleAmt)+"</td>";
    tmpTableStr     +="  </tr>";
    tmpTableStr     +="  <tr>";
    tmpTableStr     +="    <th width='45'>고객수</th>";
    tmpTableStr     +="    <td class='right'>"+numberFormatSetting(custCnt)+"</td>";
    tmpTableStr     +="  </tr>";
    tmpTableStr     +="  <tr>";
    tmpTableStr     +="    <th width='45'>달성율</th>";
    tmpTableStr     +="    <td class='right'>"+numberFormatSetting(goalRate)+"% </td>";
    tmpTableStr     +="  </tr>";
    tmpTableStr     +="</table>";
    
    return tmpTableStr;
}
/**
 * showDetail()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 선택된 브랜드의 상세 내역을 조회합니다.
 * return값 : void
 */
function showDetail( gubn){
	var tmpDoObjId = dobj.id;
	var tmpDoInfo = tmpDoObjId.split("_");
	
	var strCd       = LC_STR_CD.BindColVal;
    var floorCd     = LC_FLOOR_CD.BindColVal;
    var pumbunCd    = tmpDoInfo[1];
    var strDate     = DS_MASTER.NameValue(DS_MASTER.NameValueRow("PUMBUN_CD",pumbunCd),"SALE_DT");;
    var pumbunName  = DS_MASTER.NameValue(DS_MASTER.NameValueRow("PUMBUN_CD",pumbunCd),"PUMBUN_NAME");;
    var teamName    = DS_MASTER.NameValue(DS_MASTER.NameValueRow("PUMBUN_CD",pumbunCd),"TEAM_NAME");;
    var goTo        = "";
    var width       = 0;
    var height      = 0;
    var arrArg      = new Array();  
    
    arrArg.push(strCd); 
    arrArg.push(floorCd);
    arrArg.push(pumbunCd);    
    arrArg.push(strDate);    
    arrArg.push(pumbunName);  
    arrArg.push(teamName);    
    
	switch(gubn){
	    case "1": // 브랜드매출정보
	    	goTo     = "brandSearch";
	        width    = 900;
	        height   = 415;
		    break;
        case "2": // 일별매출정보
        	goTo     = "daySearch";
            width    = 800;
            height   = 600;
            break;
        case "3": // 월별매출정보
            goTo     = "monthSearch";
            width    = 800;
            height   = 600;
            break;
        case "4": // 시간별매출정보
            goTo     = "timeSearch";
            width    = 800;
            height   = 600;
            break;
        case "5": // 고객매출정보
            goTo     = "custSearch";
            width    = 900;
            height   = 650;
            break;
        case "6":
            break;
	}
	if( goTo == "")
		return;
	
    var returnVal = window.showModalDialog("/dps/psal432.ps?goTo="+goTo,
                                           arrArg,
                                           "dialogWidth:"+width+"px;dialogHeight:"+height+"px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");    
}
/**
 * moveline()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 브랜드 내용 이동 시 표시 선을 이동 합니다. 
 * return값 : void
 */
function moveline(e){
	if (isdrag){		 
		var doLeft = parseInt(dobj.style.left+0)+parseInt(pumbunPopPx/2);
		var doTop  = parseInt(dobj.style.top+0)+40;
		
		var lLeftLineYn         = doLeft > SPOT_X ;
		var lTopLineYn          = doTop  > SPOT_Y ;
		
		lobj.style.left         = doLeft < SPOT_X ? doLeft : SPOT_X;
		lobj.style.top          = doTop  < SPOT_Y ? doTop  : SPOT_Y;
		lobj.style.width        = Math.abs( SPOT_X - doLeft);
		lobj.style.height       = Math.abs( SPOT_Y - doTop);
		 
		/*
	  	2번 속성값 : none - 스타일 사용 안함. 즉 boder-width = 0
                 dotted - 점선
                 dashed - 굵은 점선
                 solid - 실선
                 double - 이중 실선
                 groove - 오목하게 들어간 액자 테두리
                 ridge - 내용이 잠긴 느낌의 입체선 모양
                 inset - 내용이 튀어나온 느낌의 입체선 모양
                 outset - 


		*/
		lobj.style.borderTop    = lTopLineYn?" 0px solid black":"1px solid black";
        lobj.style.borderLeft   = lLeftLineYn?"1px solid black":"0px solid black";
        lobj.style.borderBottom = lTopLineYn?" 1px solid black":"0px solid black";
        lobj.style.borderRight  = lLeftLineYn?"0px solid black":"1px solid black";
    }
}

/**
 * movemouse()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 마우스 이동시 브랜드 이동을 설정 합니다.
 * return값 : void
 */
function movemouse(e)
{
	
    if(isdrag){
        dobj.style.left = nn6 ? tx + e.clientX - x : tx + event.clientX - x;
        dobj.style.top  = nn6 ? ty + e.clientY - y : ty + event.clientY - y;
        
        if( parseInt(dobj.style.left+0) < 0)
        	dobj.style.left = 0;
        
        if( parseInt(dobj.style.top+0) < 0)
        	dobj.style.top = 0;
        var backImg = document.getElementById("IMG_BACKGROUND");
        
        if( parseInt(backImg.width+0) - (pumbunPopPx+1) < parseInt(dobj.style.left+0) )
        	dobj.style.left = parseInt(backImg.width+0) - (pumbunPopPx+1);

        if( imgDivHeight - 80 < parseInt(dobj.style.top+0) )
        	dobj.style.top = imgDivHeight - 80;
        
        moveline(e);
        return false;
    }
}

/**
 * selectmouse()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 마우스 드래그를  설정 합니다.
 * return값 : void
 */
function selectmouse(e) 
{
    var fobj       = nn6 ? e.target : event.srcElement;
    var topelement = nn6 ? "HTML" : "BODY";
    var tmpObj     = fobj;
    var divWidth   = parseInt(document.getElementById("DIV_BACK_IMG").clientWidth+0);
    
    while(fobj.tagName != topelement && fobj.className != "dragme"){
        fobj = nn6 ? fobj.parentNode : fobj.parentElement;
    }
    
    while( tmpObj.tagName != topelement &&  tmpObj.id != "DETAIL_SEARCH_POP" && tmpObj.id != "CONTROL_POP"){
    	tmpObj = nn6 ? tmpObj.parentNode : tmpObj.parentElement;
    }
    
    var dtlSearchPop = document.getElementById("DETAIL_SEARCH_POP");
    if( tmpObj.id != "DETAIL_SEARCH_POP" && dtlSearchPop )
    	dtlSearchPop.style.display="none";
    
    var controlPop = document.getElementById("CONTROL_POP");    
    if( tmpObj.id != "CONTROL_POP" && controlPop )
    	controlPop.style.display="none";
    
    if(fobj.className=="dragme"){
        dobj = fobj;
    	if( (nn6 ? e.button:event.button) == 1){
    		isdrag = true;
            tx = parseInt(dobj.style.left+0);
            ty = parseInt(dobj.style.top+0);

            x = nn6 ? e.clientX : event.clientX;
            y = nn6 ? e.clientY : event.clientY;
         
            var spotObj = document.getElementById(dobj.id+"_SPOT");
            lobj = document.getElementById(dobj.id+"_LINE");
         
            if(spotObj){
                SPOT_Y = parseInt(spotObj.style.top+0)+parseInt(spotPx/2);
                SPOT_X = parseInt(spotObj.style.left+0)+parseInt(spotPx/2);
            }else{
                SPOT_X = 0;
                SPOT_Y = 0;
            }
         
            document.onmousemove=movemouse;
    	}else{
    		if( dobj.style.cursor == 'default')
    			return;
    		
    		var tmpX = nn6 ? e.clientX : event.clientX;
    		var tmpY = nn6 ? e.clientY : event.clientY;
            
    		tmpX = tmpX-masterX;
    		tmpY = tmpY-masterY
            
            if( tmpX + 120 > divWidth){
            	tmpX = divWidth - 120;
            }
            if( tmpY + 80 > imgDivHeight){
            	tmpY = imgDivHeight - 80;
            }
            if( dtlSearchPop){
                dtlSearchPop.style.left = tmpX;
                dtlSearchPop.style.top  = tmpY;
                dtlSearchPop.style.display = "";            	
            }
            
            
    	}
        return false;
    }
    else{
        if( (nn6 ? e.button:event.button) == 2 ){
            var tmpX = nn6 ? e.clientX : event.clientX;
            var tmpY = nn6 ? e.clientY : event.clientY;
            if( tmpX < masterX || tmpY < masterY || tmpX  > (divWidth + masterX) || tmpY> (imgDivHeight + masterY) ){
            	return;
            }

            tmpX = tmpX-masterX;
            tmpY = tmpY-masterY
            
            if( tmpX + 80 > divWidth){
                tmpX = divWidth - 80;
            }
            if( tmpY + 105 > imgDivHeight){
                tmpY = imgDivHeight - 105;
            }
            if(controlPop){
                controlPop.style.left = tmpX;
                controlPop.style.top  = tmpY;
                controlPop.style.display = "";
            }
        	
        }
    }
}

/**
 * clearSpot()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 도면의 위치 정보을 삭제한다.
 * return값 : void
 */
function clearSpot(){
    var lineDiv    = document.getElementById("DIV_BACK_LINE");
    var selSpotDiv = document.getElementById("DIV_BACK_SEL_SPOT");
    var spotDiv    = document.getElementById("DIV_BACK_SPOT");
    var pumbunDiv  = document.getElementById("DIV_BACK_PUMBUN");
    if( lineDiv ){
        document.getElementById("DIV_BACK_IMG").removeChild(lineDiv);
    }
    if( selSpotDiv ){
        document.getElementById("DIV_BACK_IMG").removeChild(selSpotDiv);
    }
    if( spotDiv ){
        document.getElementById("DIV_BACK_IMG").removeChild(spotDiv);
    }
    if( pumbunDiv ){
        document.getElementById("DIV_BACK_IMG").removeChild(pumbunDiv);
    }
    lineDiv    = document.createElement("div");
    selSpotDiv = document.createElement("div");
    spotDiv    = document.createElement("div");
    pumbunDiv  = document.createElement("div");

    lineDiv.id    = "DIV_BACK_LINE";
    selSpotDiv.id = "DIV_BACK_SEL_SPOT";
    spotDiv.id    = "DIV_BACK_SPOT";
    pumbunDiv.id  = "DIV_BACK_PUMBUN";

    lineDiv.style.position = "absolute";
    lineDiv.style.top      = "0px";
    lineDiv.style.left     = "0px";

    selSpotDiv.style.position = "absolute";
    selSpotDiv.style.top      = "0px";
    selSpotDiv.style.left     = "0px";
    
    spotDiv.style.position = "absolute";
    spotDiv.style.top      = "0px";
    spotDiv.style.left     = "0px";

    pumbunDiv.style.position = "absolute";
    pumbunDiv.style.top      = "0px";
    pumbunDiv.style.left     = "0px";
    
    document.getElementById("DIV_BACK_IMG").appendChild(lineDiv);
    document.getElementById("DIV_BACK_IMG").appendChild(selSpotDiv);
    document.getElementById("DIV_BACK_IMG").appendChild(spotDiv);
    document.getElementById("DIV_BACK_IMG").appendChild(pumbunDiv);
}
/**
 * clearSum()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 도면의 합계정보을 삭제한다.
 * return값 : void
 */
function clearSum(){
    document.getElementById("TH_FLOR_PUMBUN_CNT").innerText = "";
    document.getElementById("TH_FLOR_GOAL_SALE_AMT").innerText =  "";
    document.getElementById("TH_FLOR_SALE_AMT").innerText =  "";
    document.getElementById("TH_FLOR_CUST_CNT").innerText =  "";
    document.getElementById("TH_FLOR_GOAL_RATE").innerText = "";

    document.getElementById("DIV_TEAM_SUM").innerHTML = getDummyTable();
}

/**
 * onImgLoadError()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 이미지 로드 실패 시 실행.
 * return값 : void
 */
function onImgLoadError(){

    DIV_BACK_IMG_NO.style.display="";
    DIV_BACK_IMG.style.display="none";
    DS_MASTER.ClearData();
    clearSpot();
    clearSum();
}

/**
 * setPumbunObjView()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드의 표시 여부를 설정한다. (1:기본,2:모두보기,3:모두숨김)
 * return값 : void
 */
function setPumbunObjView( gubn){
    var total = DS_MASTER.CountRow;
    document.getElementById("CONTROL_POP").style.display="none";
    if(total < 1)
        return;

    var displayYn = !(gubn == 3);
    
    for( var i= 1; i<= total; i++){ 
        var blockId       = DS_MASTER.NameValue(i,"BLOCK_ID");
        var pumbunCd      = DS_MASTER.NameValue(i,"PUMBUN_CD");
        var infoViewYn    = DS_MASTER.NameValue(i,"INFO_VIEW_YN");
        var pumbunObj     = document.getElementById(blockId+"_"+pumbunCd);        
        if( !pumbunObj)
            continue;
        var lineObj    = document.getElementById(blockId+"_"+pumbunCd+"_LINE");
        if(gubn == 1)
            displayYn = infoViewYn=='Y';
        
        if(displayYn){
            pumbunObj.style.display = "";   
            lineObj.style.display = "";     	
        } else{
            pumbunObj.style.display = "none";
            lineObj.style.display = "none";
        	
        }
        
    }
}
/**
 * setPumbunObjSort()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드의 정렬를 설정한다. (1:점위로위치,2:모아보기)
 * return값 : void
 */
function setPumbunObjSort( gubn){
    var total = DS_MASTER.CountRow;
    document.getElementById("CONTROL_POP").style.display="none";
	if(total < 1)
		return;
    var divWidth  = parseInt(document.getElementById("DIV_BACK_IMG").clientWidth+0);
    var divHeight = parseInt(document.getElementById("DIV_BACK_IMG").clientHeight+0);
    var imgWidth  = parseInt(document.getElementById("IMG_BACKGROUND").style.width+0);
    var baseX     = 1;
    var baseY     = 1;
    
    if(gubn==2){
        document.getElementById("DIV_BACK_IMG").scrollLeft =0;
        document.getElementById("DIV_BACK_IMG").scrollTop  =0;
    }
    for( var i= 1; i<= total; i++){ 

        var blockId       = DS_MASTER.NameValue(i,"BLOCK_ID");
        var pumbunCd      = DS_MASTER.NameValue(i,"PUMBUN_CD");
        var infoViewYn    = DS_MASTER.NameValue(i,"INFO_VIEW_YN");
        var spotX         = DS_MASTER.NameValue(i,"SPOT_X");
        var spotY         = DS_MASTER.NameValue(i,"SPOT_Y");
        var pumbunObj     = document.getElementById(blockId+"_"+pumbunCd);
        if( !pumbunObj)
            continue;
        switch(gubn){
            case 1: // 점의 위치로 브랜드요약정보를 이동시킵니다.
            	if( pumbunObj.style.display == "none")
            		continue;
            	
            	setPumbunObjMove( blockId, pumbunCd, (spotX-parseInt(pumbunPopPx/2)), (spotY-80-parseInt(spotPx/2)));
                break;
            case 2: // 브랜드요약정보를 표시되는 화면으로 모아 표시합니다.
                if( pumbunObj.style.display == "none")
                    continue;
                                
                setPumbunObjMove( blockId, pumbunCd, baseX, baseY );

                baseY = baseY + 82; 
                
                if( (baseY + 80) > imgDivHeight){
                    baseX = baseX + pumbunPopPx + 2;
                    baseY = 1;
                }
                break;
        }
    }
}
/**
 * setPumbunObjMove()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드의 을 이동 시킨다.
 * return값 : void
 */
function setPumbunObjMove( blockId, pumbunCd, posX, posY , displayYn){
	displayYn        = displayYn==null?true:displayYn;
	
    var pumbunObj    = document.getElementById(blockId+"_"+pumbunCd);
    if( !pumbunObj)
    	return;
    var lineObj    = document.getElementById(blockId+"_"+pumbunCd+"_LINE");
    var spotObj    = document.getElementById(blockId+"_"+pumbunCd+"_SPOT");
    var backImg    = document.getElementById("IMG_BACKGROUND");
    
    var spotX      = parseInt(spotObj.style.left+0)+parseInt(spotPx/2);
    var spotY      = parseInt(spotObj.style.top+0)+parseInt(spotPx/2);
    
    if( posX < 1)
    	posX = 1;

    if( posY < 1)
    	posY = 1;
    
    if( parseInt(backImg.width+0) - (pumbunPopPx+1) < posX )
    	posX = parseInt(backImg.width+0) - (pumbunPopPx+1);

    if( imgDivHeight - 80 < posY )
    	posY = imgDivHeight - 80;

    pumbunObj.style.left = posX;
    pumbunObj.style.top  = posY;
    if(displayYn)
    	pumbunObj.style.display = "";
    else
    	pumbunObj.style.display = "none";

    var pumbunX        = parseInt(pumbunObj.style.left+0)+parseInt(pumbunPopPx/2);
    var pumbunY        = parseInt(pumbunObj.style.top+0)+40;    
    var lLeftLineYn    = pumbunX > spotX ;
    var lTopLineYn     = pumbunY > spotY ;
    
    lineObj.style.left         = pumbunX < spotX ? pumbunX : spotX;
    lineObj.style.top          = pumbunY < spotY ? pumbunY : spotY;
    lineObj.style.width        = Math.abs( spotX - pumbunX);
    lineObj.style.height       = Math.abs( spotY - pumbunY);
    

    lineObj.style.borderTop    = lTopLineYn?" 0px dashed black":"1px dashed black";
    lineObj.style.borderLeft   = lLeftLineYn?"1px dashed black":"0px dashed black";
    lineObj.style.borderBottom = lTopLineYn?" 1px dashed black":"0px dashed black";
    lineObj.style.borderRight  = lLeftLineYn?"0px dashed black":"1px dashed black";

    if(displayYn)
    	lineObj.style.display = "";
    else
    	lineObj.style.display = "none";
}

document.onmousedown=selectmouse;
document.onmouseup=new Function("isdrag=false");

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

<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    clearSpot();
    clearSum();
    DS_MASTER.ClearData();
</script>

<!-- 층 (조회) -->
<script language=JavaScript for=LC_FLOOR_CD event=OnSelChange()>
    clearSpot();
    clearSum();
    DS_MASTER.ClearData();
    if( LC_STR_CD.BindColVal !="" && LC_FLOOR_CD.BindColVal !=""){
        searchFloorPlan();        
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

<comment id="_NSID_"><object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FLOOR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_FLOOR_PLAN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
<body onLoad="doInit();" class="PL10 PT15" >

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // 
<table width="100%" height="21" border="0" cellspacing="0" cellpadding="0" class="PB03 PR05">
  <tr>
    <td width="200" class="title"><img 
      src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>
      <span id="spanPGNM" class="title"></span>
      <script LANGUAGE="JavaScript"> 
        document.all.spanPGNM.innerHTML= getProgramName('<%=pid%>');
      </script>
    </td>
    <td class="PT01 right" id=TD_TOP ><img 
      src="/<%=dir%>/imgs/btn/search.gif" width="50" height="21"   onClick="searchFloorPlan();" />
    </td>
  </tr>
</table>
-->
<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td width=200px valign="top" >
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td class="PT01 PB03" ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
            <tr>
              <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                <tr>
                  <th width="60" class="point">점</th>
                  <td >
                    <comment id="_NSID_">
                      <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1  align="absmiddle"></object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
                <tr>
                  <th class="point">층</th>
                  <td >
                    <comment id="_NSID_">
                      <object id=LC_FLOOR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1  align="absmiddle"></object>
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
          <td class="PB03" id=TD_NOW_DATE ></td>
        </tr>
        <tr>
          <td class="dot"></td>
        </tr>
        <tr>
          <td class="sub_title PB03 PT03"><img
            src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
            align="absmiddle" /> 층 총계</td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
              <th width=54 >총매장수</th>
              <td id=TH_FLOR_PUMBUN_CNT class="right"  style='letter-spacing:0.0ex;'></td>
            </tr>
            <tr>
              <th >총매출</th>
              <td id=TH_FLOR_SALE_AMT class="right"  style='letter-spacing:0.0ex;'></td>
            </tr>
            <tr>
              <th >목표</th>
              <td id=TH_FLOR_GOAL_SALE_AMT class="right"  style='letter-spacing:0.0ex;'></td>
            </tr>
            <tr>
              <th >고객</th>
              <td id=TH_FLOR_CUST_CNT class="right"  style='letter-spacing:0.0ex;'></td>
            </tr>
            <tr>
              <th >달성율</th>
              <td id=TH_FLOR_GOAL_RATE class="right"  style='letter-spacing:0.0ex;'></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class="sub_title PB03 PT05"><img
            src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
            align="absmiddle" /> 파트별합계</td>
        </tr>
        <tr>
          <td ><div id=DIV_TEAM_SUM style="overflow:auto;width:100%;height:295px;"></div></td>
        </tr>
      </table>
    </td>
    <td class="PL05"><table width="100%" height="543" border="0" cellspacing="0" cellpadding="0" class="s_table">
      <tr>
        <td class="PT01 PB03"><div onContextMenu="return false;"
          style="position:relative;height:543px;
          width:100%;border:0px;" id="DIV_FLOOR_PLAN">
            <div id="DIV_BACK_IMG" style="position:absolute;top:0px;left:0px;
              overflow:auto;width:100%;height:543px;" ><img onerror="javascript:onImgLoadError();"
              id="IMG_BACKGROUND" src="/<%=dir%>/imgs/comm/ms03.gif" show=false />
              <div id=DIV_BACK_LINE style="position:absolute;top:0px;left:0px;"> </div>
              <div id=DIV_BACK_SEL_SPOT style="position:absolute;top:0px;left:0px;"> </div>
              <div id=DIV_BACK_SPOT style="position:absolute;top:0px;left:0px;"> </div>
              <div id=DIV_BACK_PUMBUN style="position:absolute;top:0px;left:0px;"> </div>
            </div>
            <div id="DIV_BACK_IMG_NO" style="position:absolute;top:0px;left:0px;
              overflow:auto;width:100%;height:543px;" align="center">
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" height="543px" style="border:0px;">
                <tr>                
                  <td style="border:0px;" width="50%" class="right"><img src= "/<%=dir%>/imgs/comm/ms03.gif" show=false ></td>                
                  <td style="border:0px;" valign="middle" > 도면 정보가 존재하지 않습니다.</td>
                </tr>
              </table>
            </div>
            <div id=DETAIL_SEARCH_POP style="position:absolute;height:80px;
              width:120px;border:0px;top:0px;left:0px;display:'none'">
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="v_table" >
                <tr><td style="border:0px;padding:0px;"><a href="#" onclick="javascript:showDetail('1');" OnFocus="this.blur()"> ☞ 브랜드매출정보</a></td>
                </tr>
                <tr><td style="border:0px;padding:0px;"><a href="#" onclick="javascript:showDetail('2');" OnFocus="this.blur()"> ☞ 일별매출정보</a></td>
                </tr>
                <tr><td style="border:0px;padding:0px;"><a href="#" onclick="javascript:showDetail('3');" OnFocus="this.blur()"> ☞ 월별매출정보</a></td>
                </tr>
                <tr><td style="border:0px;padding:0px;"><a href="#" onclick="javascript:showDetail('4');" OnFocus="this.blur()"> ☞ 시간별매출정보</a></td>
                </tr>
                <tr><td style="border:0px;padding:0px;"><a href="#" onclick="javascript:showDetail('5');" OnFocus="this.blur()"> ☞ 고객매출정보</a></td>
                </tr>
              </table>
            </div><!-- 표시및 정렬, 새로고침 기능 (오른쪽 버튼 클릭) 주석 제거하면 사용가능 합니다. 
            <div id=CONTROL_POP style="position:absolute;height:105px;
              width:80px;border:0px;top:0px;left:0px;display:'none'">
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="v_table" >
                <tr><th style="border:0px;padding:0px;"><a                                                                         >정보</a></th></tr>
                <tr><td style="border:0px;padding:0px;"><a href="#" onclick="javascript:searchFloorPlan();" OnFocus="this.blur()"  >&nbsp;&nbsp;&nbsp;새로고침</a></td></tr>
                <tr><th style="border:0px;padding:0px;"><a                                                                         >정렬</a></th></tr>
                <tr><td style="border:0px;padding:0px;"><a href="#" onclick="javascript:setPumbunObjSort(1);" OnFocus="this.blur()">&nbsp;&nbsp;&nbsp;점위로</a></td></tr>
                <tr><td style="border:0px;padding:0px;"><a href="#" onclick="javascript:setPumbunObjSort(2);" OnFocus="this.blur()">&nbsp;&nbsp;&nbsp;모아보기</a></td></tr>
                <tr><th style="border:0px;padding:0px;"><a                                                                         >표시</a></th></tr>
                <tr><td style="border:0px;padding:0px;"><a href="#" onclick="javascript:setPumbunObjView(1);" OnFocus="this.blur()">&nbsp;&nbsp;&nbsp;초기화</a></td></tr>
                <tr><td style="border:0px;padding:0px;"><a href="#" onclick="javascript:setPumbunObjView(2);" OnFocus="this.blur()">&nbsp;&nbsp;&nbsp;모두보기</a></td></tr>
                <tr><td style="border:0px;padding:0px;"><a href="#" onclick="javascript:setPumbunObjView(3);" OnFocus="this.blur()">&nbsp;&nbsp;&nbsp;모두숨김</a></td></tr>
              </table>
            </div>-->
          </div>          
        </td>
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

