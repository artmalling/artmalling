<!-- 
/*******************************************************************************
 * 시스템 명 : 백화점 영업관리 > 매출관리 > 실행계획
 * 작  성  일 : 2010.03.31
 * 작  성  자 : 박종은
 * 수  정  자 : 
 * 파  일  명 : psal2030.jsp
 * 버       전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요 : 실행브랜드별일매출계획수정및확정
 * 이       력 :
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
   import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
   request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
   String dir = BaseProperty.get("context.common.dir");
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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 350;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');   
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    
    // EMedit에 초기화
    initEmEdit(EM_PLAN_YM,                      "YYYYMM",                PK);   //년월
    EM_PLAN_YM.alignment = 1;
    initEmEdit(EM_SALE_DAY_CNT,                 "NUMBER^5^2",            READ); //영업일수
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD,         "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD,       "CODE^0^30,NAME^0^80", 1, PK);  //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD,       "CODE^0^30,NAME^0^80", 1, PK);  //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD,           "CODE^0^30,NAME^0^80", 1, NORMAL);  //PC(조회)
    
    getStore("DS_STR_CD", "Y", "",                   "N");                                                // 점        
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                                                // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "N");                         // 파트  
    getPc("DS_PC_CD",     "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y"); // PC  
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index     = 0;
    LC_TEAM_CD.Index     = 0;
    LC_PC_CD.Index       = 0;
    
    //현재년도 셋팅
    EM_PLAN_YM.text = varToMon;
    
    var lastDate    = new Date(EM_PLAN_YM.text.substr(0,4), EM_PLAN_YM.text.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();                                                     //마지막일자
    EM_SALE_DAY_CNT.text = strEndDate;
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal203","DS_IO_DETAIL" );

}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}                name="NO"           width=30     align=center     BgColor={decode(ERROR_CHECK,"","white","yellow")} </FC>'
                     + '<FC>id=CONF_FLAG               name="확정"          width=50     align=center    Edit="" EditStyle=CheckBox HeadCheck=false HeadCheckShow=true</FC>'
                     + '<FC>id=STR_CD                  name="점"            width=40     align=center     Edit=none    show=false</FC>'
                     + '<FC>id=DEPT_CD                 name="팀"          width=40     align=center    Edit=none    show=false</FC>'
                     + '<FC>id=TEAM_CD                 name="파트"            width=40     align=center    Edit=none    show=false</FC>'
                     + '<FC>id=PC_CD                   name="PC"           width=40     align=center    Edit=none    </FC>'
                     + '<FC>id=ORG_NAME                name="PC명"          width=80     align=left      Edit=none    SumText="합계"</FC>'
                     + '<FC>id=YYYYMM                  name="목표년도"       width=100    align=left      Edit=""      show=false</FC>'
                     + '<FC>id=CONF_DT                 name="확정일자"       width=100    align=center   Edit=Numeric Mask="XXXX/XX/XX"   EditStyle=Popup  </FC>'
                     + '<G>                            name="PC별월매출목표합계"'
                     + '<C>id=ORIGIN_NORM_SAMT         name="정상매출"       width=100     align=right     SumText={SubSum(ORIGIN_NORM_SAMT)}   Edit=none</C>'
                     + '<C>id=ORIGIN_EVT_SAMT          name="행사매출"       width=100     align=right     SumText={SubSum(ORIGIN_EVT_SAMT)}    Edit=none</C>'
                     + '<C>id=ORIGIN_SALE_TAMT         name="총매출"        width=100     align=right     SumText={SubSum(ORIGIN_SALE_TAMT)}   Edit=none</C>'
                     + '<C>id=ORIGIN_PROF_TAMT         name="이익"          width=100     align=right     SumText={SubSum(ORIGIN_PROF_TAMT)}   Edit=none</C>'
                     + '<C>id=ORIGIN_SALE_CRATE        name="매출구성비"     width=80     align=right     Dec=2                                    Edit=none</C>'
                     + '<C>id=ORIGIN_PROF_CRATE        name="이익구성비"     width=80     align=right     Dec=2                                    Edit=none</C>'
                     + '</G>'  
                     ;
                    
    
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
}

function gridCreate2(lastday){
	var strNormAmt  = 0;
    var strEvtAmt   = 0;
    var strSaleTAmt = 0;
    var strProfTAmt = 0;
   
    strNormAmt  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORIGIN_NORM_SAMT");
    strEvtAmt   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORIGIN_EVT_SAMT");
    strSaleTAmt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORIGIN_SALE_TAMT");
    strProfTAmt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORIGIN_PROF_TAMT");
	
    //background color #eaf3f9
    //border color #cacaca


    var hdrProperies = '<COLUMNINFO>'
                    
                     + '       <COLUMN id="PUMBUNCD" refcolid="PUMBUN_CD" index="1">'
                     + '           <HEADER left="0" top="0" right="100" bottom="40" text="브랜드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="0" top="0" right="100" bottom="120" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
                    
                     + '       <COLUMN id="NAME"  refcolid="PUMBUN_NAME" index="2">'
                     + '           <HEADER left="100" top="0" right="200" bottom="40" text="브랜드명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="100" top="0" right="200" bottom="120" align="leftCenter" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY  text="합계"  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
                
                     + '       <COLUMN id="JUNGSANG_G"  refcolid="JUNGSANG">'
                     + '           <HEADER  left="200" top="0" right="300" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="200" top="0" right="300" bottom="20"  align="leftCenter" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="정상"   align="leftCenter" bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="TOTAL_BFYY_ORIGIN"   >'
                     + '           <HEADER left="300" top="0" right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYNORMSAMTTOTALJUNG"  refcolid="BFYY_NORM_SAMT_TOTAL_JUNG" >'
                     + '           <HEADER left="300" top="20" right="400" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="300" top="0" right="400" bottom="20" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY  text="@GFSUM(BFYY_NORM_SAMT_TOTAL_JUNG)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINNORMSAMTTOTALJUNG"  refcolid="ORIGIN_NORM_SAMT_TOTAL_JUNG" >'
                     + '           <HEADER left="400" top="20" right="500" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="400" top="0" right="500" bottom="20" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_NORM_SAMT_TOTAL_JUNG)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="TOTAL_BFYY_ORIGIN"   >'
                     + '           <HEADER left="500" top="0" right="600" bottom="20" text="오차" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="GABJUNGSANG"  refcolid="GAB_JUNGSANG" >'
                     + '           <HEADER fix="true" left="500" top="20" right="600" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="500" top="0" right="600" bottom="20" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_NORM_SAMT_TOTAL_JUNG)-'+ strNormAmt+'"   bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
                     
    var j = 0;
    var thisDate = null;
    var thisWeek = "";
    var strWeek = "";
    var strDay  = "";
    
    if(lastday == null){
	    var lastDate = new Date(varToMon.substr(0,4), varToMon.substr(4,2), 0);
	    lastday  = lastDate.getDate();
    }
    
    for(i=1;i<= lastday; i++){
    	if(i < 10){
    		strDay = varToMon + "0"+i
    	}
    	else{
    		strDay = varToMon + i
    	}
    		
    	
    	
    	hdrProperies +=  
			           '       <COLUMN id="BFYYNORMSAMT"  view="true">'
			         + '           <HEADER left="'+(400+(i*200))+'" top="0" right="'+(600+(i*200))+'" bottom="20" text="'+i+'일" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
			         + '       </COLUMN>'
			         thisDate = new Date(strDay.substr(0,4)-1, strDay.substr(4,2)-1, strDay.substr(6,2));
			         thisWeek = thisDate.getDay();
			         strWeek  = thisWeek+1;
			         strWeek  = rtuWeek(strWeek);

	    hdrProperies +=  
	                   '       <COLUMN id="BFYYWEEK' +i+'"  view="true">'
                     + '           <HEADER left="'+(500+((i+j)*100))+'" top="20" right="'+(530+((i+j)*100))+'" bottom="40" text="'+strWeek+'" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
	                 + '       </COLUMN>'	         
        hdrProperies +=   
                       '       <COLUMN id="BFYYNORMSAMT' +i+'"  refcolid="BFYY_NORM_SAMT'+i+'"   view="true">'
                     + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="'+(500+((i+j)*100))+'" top="0" right="'+(600+((i+j)*100))+'" bottom="20" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_NORM_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        j++;
                     thisDate = new Date(strDay.substr(0,4), strDay.substr(4,2)-1, strDay.substr(6,2));
                     thisWeek = thisDate.getDay();
                     strWeek  = thisWeek+1;
                     strWeek  = rtuWeek(strWeek);
        hdrProperies +=  
                       '       <COLUMN id="ORIGINWEEK' +i+'"  view="true">'
                     + '           <HEADER left="'+(500+((i+j)*100))+'" top="20" right="'+(530+((i+j)*100))+'" bottom="40" text="'+strWeek+'" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'          
        hdrProperies +=
                       '       <COLUMN id="ORIGINNORMSAMT' +i+'"  refcolid="ORIGIN_NORM_SAMT'+i+'"   view="true">'
                     + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="'+(500+((i+j)*100))+'" top="0" right="'+(600+((i+j)*100))+'" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_NORM_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD  type="edit" inputtype="num" decimal="0" editable="@DECODE(CONF,[Y],[false],[N],[true])"  />'
                     + '       </COLUMN>'
                     
    }
        hdrProperies +=
                       '       <COLUMN id="EVENT_G"  refcolid="EVENT" >'
                     + '           <HEADER fix="true" left="200" top="0" right="300" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="200" top="20" right="300" bottom="40"  align="leftCenter" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="행사"   align="leftCenter" bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYEVTSAMTTOTALEVENT"  refcolid="BFYY_EVT_SAMT_TOTAL_EVENT" >'
                     + '           <HEADER left="300" top="20" right="400" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="300" top="20" right="400" bottom="40" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_EVT_SAMT_TOTAL_EVENT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="ORIGINEVTSAMTTOTALEVENT"  refcolid="ORIGIN_EVT_SAMT_TOTAL_EVENT" >'
                     + '           <HEADER left="400" top="20" right="500" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="400" top="20" right="500" bottom="40" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_EVT_SAMT_TOTAL_EVENT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="GABEVENT"  refcolid="GAB_EVENT" >'
                     + '           <HEADER left="500" top="20" right="600" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="500" top="20" right="600" bottom="40" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_EVT_SAMT_TOTAL_EVENT)-'+ strEvtAmt+'"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
    j = 0;
    for(i=1;i<= lastday; i++){
        hdrProperies +=  
                       '       <COLUMN id="BFYYEVTSAMT' +i+'"  refcolid="BFYY_EVT_SAMT'+i+'"   view="true">'
                       + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                       + '           <VIEW left="'+(500+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_EVT_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        j++;
        hdrProperies +=
                       '       <COLUMN id="ORIGINEVTSAMT' +i+'"  refcolid="ORIGIN_EVT_SAMT'+i+'"   view="true">'
                     + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="'+(500+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_EVT_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="@DECODE(CONF,[Y],[false],[N],[true])"/>' 
                     + '       </COLUMN>'
    }
        hdrProperies +=                  
                       '       <COLUMN id="TOTALSALE_G"  refcolid="TOTALSALE" >'
                     + '           <HEADER fix="true" left="200" top="0" right="300" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="200" top="40" right="300" bottom="60"  align="leftCenter" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="총매출"   align="leftCenter" bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYSALETAMTTOTALSALE"  refcolid="BFYY_SALE_TAMT_TOTAL_SALE" >'
                     + '           <HEADER left="300" top="20" right="400" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="300" top="40" right="400" bottom="60" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_SALE_TAMT_TOTAL_SALE)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINSALETAMTTOTALSALE"  refcolid="ORIGIN_SALE_TAMT_TOTAL_SALE" >'
                     + '           <HEADER left="400" top="20" right="500" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="400" top="40" right="500" bottom="60" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_TAMT_TOTAL_SALE)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="GABSALE"  refcolid="GAB_SALE" >'
                     + '           <HEADER left="500" top="20" right="600" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="500" top="40" right="600" bottom="60" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_TAMT_TOTAL_SALE)-'+ strSaleTAmt+'"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
    j = 0;
    for(i=1;i<= lastday; i++){
        hdrProperies +=  
                       '       <COLUMN id="BFYYSALETAMT' +i+'"  refcolid="BFYY_SALE_TAMT'+i+'"   view="true">'
                     + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="'+(500+((i+j)*100))+'" top="40" right="'+(600+((i+j)*100))+'" bottom="60" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_SALE_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        j++;
        hdrProperies +=
                       '       <COLUMN id="ORIGINSALETAMT' +i+'"  refcolid="ORIGIN_SALE_TAMT'+i+'"   view="true">'
                     + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="'+(500+((i+j)*100))+'" top="40" right="'+(600+((i+j)*100))+'" bottom="60" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
    }
        hdrProperies += 
                       '       <COLUMN id="PROF_G"  refcolid="PROF" >'
                     + '           <HEADER fix="true" left="200" top="0" right="300" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="200" top="60" right="300" bottom="80"  align="leftCenter" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="이익"   align="leftCenter" bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYPROFTAMTTOTALPROF"  refcolid="BFYY_PROF_TAMT_TOTAL_PROF" >'
                     + '           <HEADER left="300" top="20" right="400" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="300" top="60" right="400" bottom="80" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_PROF_TAMT_TOTAL_PROF)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINPROFTAMTTOTALPROF"  refcolid="ORIGIN_PROF_TAMT_TOTAL_PROF" >'
                     + '           <HEADER left="400" top="20" right="500" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="400" top="60" right="500" bottom="80" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_PROF_TAMT_TOTAL_PROF)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="GABPROF"  refcolid="GAB_PROF" >'
                     + '           <HEADER left="500" top="20" right="600" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="500" top="60" right="600" bottom="80" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_PROF_TAMT_TOTAL_PROF)-'+ strProfTAmt+'"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
    j = 0;
    for(i=1;i<= lastday; i++){
        hdrProperies +=  
                       '       <COLUMN id="BFYYPROFTAMT' +i+'"  refcolid="BFYY_PROF_TAMT'+i+'"   view="true">'
                     + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="'+(500+((i+j)*100))+'" top="60" right="'+(600+((i+j)*100))+'" bottom="80" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_PROF_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        j++; 
        hdrProperies +=
                       '       <COLUMN id="ORIGINPROFTAMT' +i+'"  refcolid="ORIGIN_PROF_TAMT'+i+'"   view="true">'
                     + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="'+(500+((i+j)*100))+'" top="60" right="'+(600+((i+j)*100))+'" bottom="80" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_PROF_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="@DECODE(CONF,[Y],[false],[N],[true])"/>' 
                     + '       </COLUMN>'
    }
        hdrProperies +=                                 
                       '       <COLUMN id="SCRATE_G"  refcolid="SALECRATE" >'
                     + '           <HEADER fix="true" left="200" top="0" right="300" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="200" top="80" right="300" bottom="100"  align="leftCenter" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="매출구성비"   align="leftCenter" bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYSALECRATETOTALSALE"  refcolid="BFYY_SALE_CRATE_TOTAL_SALE" >'
                     + '           <HEADER left="300" top="20" right="400" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="300" top="80" right="400" bottom="100" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_SALE_CRATE_TOTAL_SALE)"  bgcolor="#b9d9ea"  align="RightCenter" />' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINSALECRATETOTALSALE"  refcolid="ORIGIN_SALE_CRATE_TOTAL_SALE" >'
                     + '           <HEADER left="400" top="20" right="500" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="400" top="80" right="500" bottom="100" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_CRATE_TOTAL_SALE)"  bgcolor="#b9d9ea"  align="RightCenter" />' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="GABSALERATE"  refcolid="GAB_SALE_RATE" >'
                     + '           <HEADER left="500" top="20" right="600" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="500" top="80" right="600" bottom="100" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_TAMT_TOTAL_SALE)/@GFSUM(ORIGIN_SALE_TAMT_TOTAL_SALE)"  bgcolor="#b9d9ea"  align="RightCenter" />' 
                     + '       </COLUMN>'
    j = 0;
    for(i=1;i<= lastday; i++){
        hdrProperies +=  
                       '       <COLUMN id="BFYYSALECRATE' +i+'"  refcolid="BFYY_SALE_CRATE'+i+'"   view="true">'
                     + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="'+(500+((i+j)*100))+'" top="80" right="'+(600+((i+j)*100))+'" bottom="100" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_SALE_CRATE'+i+')"  bgcolor="#b9d9ea"  align="RightCenter" />' 
                     + '       </COLUMN>'
        j++;
        hdrProperies +=
                       '       <COLUMN id="ORIGINSALECRATE' +i+'"  refcolid="ORIGIN_SALE_CRATE'+i+'"   view="true">'
                     + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="'+(500+((i+j)*100))+'" top="80" right="'+(600+((i+j)*100))+'" bottom="100" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_CRATE'+i+')"  bgcolor="#b9d9ea"  align="RightCenter" />' 
                     + '       </COLUMN>'
    }
        hdrProperies +=                              
                       '       <COLUMN id="PCRATE_G"  refcolid="PROFCRATE" >'
                     + '           <HEADER fix="true" left="200" top="0" right="300" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="200" top="100" right="300" bottom="120"  align="leftCenter" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="이익구성비"  align="leftCenter"  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
                
                     + '       <COLUMN id="BFYYPROFCRATETOTALPROF"  refcolid="BFYY_PROF_CRATE_TOTAL_PROF" >'
                     + '           <HEADER left="300" top="20" right="400" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="300" top="100" right="400" bottom="120" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_PROF_CRATE_TOTAL_PROF)"  bgcolor="#b9d9ea"  align="RightCenter" />' 
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="ORIGINPROFCRATETOTALPROF"  refcolid="ORIGIN_PROF_CRATE_TOTAL_PROF" >'
                     + '           <HEADER left="400" top="20" right="500" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="400" top="100" right="500" bottom="120" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_PROF_CRATE_TOTAL_PROF)"  bgcolor="#b9d9ea"  align="RightCenter" />' 
                     + '       </COLUMN>'
                
                     + '       <COLUMN id="GABPROFRATE"  refcolid="GAB_PROF_RATE" >'
                     + '           <HEADER left="500" top="20" right="600" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="500" top="100" right="600" bottom="120" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
    j = 0;
    for(i=1;i<= lastday; i++){
        hdrProperies +=  
                       '       <COLUMN id="BFYYPROFCRATE' +i+'"  refcolid="BFYY_PROF_CRATE'+i+'"   view="true">'
                     + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="대비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="'+(500+((i+j)*100))+'" top="100" right="'+(600+((i+j)*100))+'" bottom="120" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_PROF_CRATE'+i+')"  bgcolor="#b9d9ea"  align="RightCenter" />' 
                     + '       </COLUMN>'
        j++;
        hdrProperies +=
                       '       <COLUMN id="ORIGINPROFCRATE' +i+'"  refcolid="ORIGIN_PROF_CRATE'+i+'"   view="true">'
                     + '           <HEADER left="'+(530+((i+j)*100))+'" top="20" right="'+(600+((i+j)*100))+'" bottom="40" text="실행" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="'+(500+((i+j)*100))+'" top="100" right="'+(600+((i+j)*100))+'" bottom="120" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_PROF_CRATE'+i+')"  bgcolor="#b9d9ea"  align="RightCenter" />' 
                     + '       </COLUMN>'
    }
                                              

        hdrProperies +=
		               '       <COLUMN id="CONF"  refcolid="CONF_FLAG" view="false">'
		             + '           <VIEW left="100" top="0" right="200" bottom="120" align="leftCenter" borderstyle="Line" bordercolor="#cacaca"/>'
		             + '       </COLUMN>'
       
        	         + '     </COLUMNINFO>';
                    
    
    initMGridStyle(GD_DETAIL, "common", hdrProperies);
    DS_IO_DETAIL.UseChangeInfo = true;  
    GD_DETAIL.ViewSummary = 1;
}

function rtuWeek(week){
	
	switch(week){
	case 1 :
		return "일";
		break;
	case 2 :
		return "월";
        break;
    case 3 :
        return "화";
        break;
    case 4 :
        return "수";
        break;
    case 5 :
        return "목";
        break;
    case 6 :
        return "금";
        break;
    case 7 :
        return "토";
        break;
    
	}
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
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-25
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
    	ret = showMessage(QUESTION, YESNO, "USER-1084");
        if (ret != "1") {
            return false;
        } 
    }
    
    //마스터, 디테일 그리드 클리어
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
	
    //1. validation 
    if(!chkValidation("search")) return;
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strPlanYm       = EM_PLAN_YM.text;           //년월
    
    var lastDate    = new Date(strPlanYm.substr(0,4), strPlanYm.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strPlanYm="          +encodeURIComponent(strPlanYm);
    
    TR_MAIN.Action="/dps/psal203.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    GD_DETAIL.ReDraw = false;
    gridCreate2(strEndDate);
    detailCnt();
    GD_DETAIL.ReDraw = true;
	  
   
    //확정된 내역은 확정일자 수정 불가능
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
        GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
    }
    else{
        GD_MASTER.ColumnProp("CONF_DT","Edit")="";
    }
    
    GD_MASTER.ColumnProp('CONF_FLAG','HeadCheck')= "false";
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
}

/**
 * btn_New()
 * 작 성 자 :   
 * 작 성 일 : 
 * 개     요 :  
 * return값 : 
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 
 * return값 : 
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-25
 * 개    요 : DB에 저장  / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	if (!DS_IO_DETAIL.IsUpdated) {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    changeSum();
    
    //1. validation Master 그리드 필수 입력 체크 
    if(!chkValidation("save")) return;
    
    var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");           //점
    var strDeptCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DEPT_CD");          //팀
    var strTeamCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TEAM_CD");          //파트
    var strPCCd         = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PC_CD");            //PC
    var strYYYYMM       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "YYYYMM");           //년월
    var lastDate        = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate      = lastDate.getDate();                                                 //마지막일자
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if (showMessage(QUESTION, YESNO, "USER-1010") != 1)
        return;

    var parameters =  "&strStrCd="        +encodeURIComponent(strStrCd)
                    + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                    + "&strTeamCd="       +encodeURIComponent(strTeamCd)
                    + "&strPCCd="         +encodeURIComponent(strPCCd)
                    + "&strYYYYMM="       +encodeURIComponent(strYYYYMM)
                    + "&strEndDate="      +encodeURIComponent(strEndDate);
    
    TR_MAIN.Action = "/dps/psal203.ps?goTo=save"+parameters;
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MAIN.Post();


    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-21
 * 개    요 : 확정, 확정취소 처리
 * return값 : void
 */

 function btn_Conf() {

    if (DS_IO_DETAIL.IsUpdated ){
        ret = showMessage(INFORMATION, OK, "USER-1091");
        return ;
    }
	// 저장할 데이터 없는 경우
     if (!DS_IO_MASTER.IsUpdated ){
         showMessage(INFORMATION, OK, "USER-1000","확정할 데이터가 없습니다.");
         return;
     }
     
     if(!chkValidation("conf")) return;
     
     
     
     if( showMessage(QUESTION, YESNO, "USER-1000", "확정 또는 확정취소 하시겠습니까?") != 1 )
         return;
     
     TR_MAIN.Action="/dps/psal203.ps?goTo=saveconf";
     TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
     TR_MAIN.Post();
     

     // 정상 처리일 경우 조회
     if( TR_MAIN.ErrorCode == 0){
         btn_Search();
     }

 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/


/**
* searchDetail()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-16
* 개    요 : 당초브랜드별월매출계획 조회
* return값 : void
*/
function searchDetail(){
    var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");           //점
    var strDeptCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DEPT_CD");          //팀
    var strTeamCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TEAM_CD");          //파트
    var strPCCd         = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PC_CD");            //PC
    var strYYYYMM       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "YYYYMM");           //년월
    
    
    var lastDate    = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();                                                     //마지막일자
    
    //gridCreate2(strEndDate);
    var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="             +encodeURIComponent(strStrCd)
                   + "&strDeptCd="            +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="            +encodeURIComponent(strTeamCd)
                   + "&strPCCd="              +encodeURIComponent(strPCCd)
                   + "&strYYYYMM="            +encodeURIComponent(strYYYYMM)
                   + "&strEndDate="           +encodeURIComponent(strEndDate);
   
    TR_DETAIL.Action="/dps/psal203.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    GD_DETAIL.ReDraw = false;
    
    var originTotal = 0;
    var originProf  = 0;  
    for(j=1; j <= DS_IO_DETAIL.CountRow; j++){
        originTotal = getRoundDec("1",getRoundDec("1",originTotal,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT_TOTAL_SALE"),0),0);
        originProf  = getRoundDec("1",getRoundDec("1",originProf,0)   + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT_TOTAL_PROF"),0),0);
    }
       
    for(j=1; j <= DS_IO_DETAIL.CountRow; j++){
        if(getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT_TOTAL_SALE"),0) != 0){
            DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_CRATE_TOTAL_SALE") 
            = getRoundDec("1", getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT_TOTAL_SALE"),0)/getRoundDec("1",originTotal,0)*100,2);
        }
        else{
            DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_CRATE_TOTAL_SALE") = 0;
        }
        if(getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT_TOTAL_PROF"),0) != 0){
            DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_CRATE_TOTAL_PROF") 
            = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT_TOTAL_PROF"),0) /getRoundDec("1",originProf,0)*100,2);
        }
        else{
            DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_CRATE_TOTAL_PROF") = 0;
        }
    }
    
    DS_IO_DETAIL.ResetStatus();
   
    
    gridCreate2(strEndDate);
    
    GD_DETAIL.ReDraw = true;
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_DETAIL.CountRow);
    
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
    	
    }
    GD_DETAIL.focus();
    GD_MASTER.Focus();
}

/**
 * chkValidation(gbn)
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-21
 * 개    요 :  확정,확정취소
 * return값 : void
 */
function chkValidation(gbn){
    
    switch (gbn) {
    case "search" :  
        //점 체크
        if (isNull(LC_STR_CD.BindColVal)==true ) {
            showMessage(INFORMATION, OK, "USER-1003","점");
            return false;
        }
        //팀 체크
        if (isNull(LC_DEPT_CD.BindColVal)==true ) {
            showMessage(INFORMATION, OK, "USER-1003","팀");
            return false;
        }
        //파트 체크
        if (isNull(LC_TEAM_CD.BindColVal)==true ) {
            showMessage(INFORMATION, OK, "USER-1003","파트");
            return false;
        }
        //계획년도
        if (isNull(EM_PLAN_YM.text) ==true ) {
            showMessage(INFORMATION, OK, "USER-1003","목표년도"); 
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_PLAN_YM.text.replace(" ","").length != 6 ) {
            showMessage(INFORMATION, OK, "USER-1027","년월","6");
            return false;
        }
        return true;
        break;
    case "save" : 
        if(DS_IO_MASTER.ORGNameValue(DS_IO_MASTER.RowPosition, "CONF_FLAG") == "T"){
        	showMessage(INFORMATION, OK, "USER-1000", "확정된 데이터입니다. 확정 취소 후 수정하십시오.");
        	return false;
        }
        var Morigin_norm_samt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORIGIN_NORM_SAMT");
        var Morigin_evt_samt  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORIGIN_EVT_SAMT");
        var Morigin_prof_tamt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORIGIN_PROF_TAMT");
        var Dorigin_norm_samt = 0;
        var Dorigin_evt_samt  = 0;
        var Dorigin_prof_tamt = 0;
        for(i=1; i<= DS_IO_DETAIL.CountRow;i++){    
        	Dorigin_norm_samt = getRoundDec("1",Dorigin_norm_samt,0)+getRoundDec("1",DS_IO_DETAIL.NameValue(i, "ORIGIN_NORM_SAMT_TOTAL_JUNG"),0);
        	Dorigin_evt_samt  = getRoundDec("1",Dorigin_evt_samt,0)+getRoundDec("1",DS_IO_DETAIL.NameValue(i, "ORIGIN_EVT_SAMT_TOTAL_EVENT"),0);
        	Dorigin_prof_tamt = getRoundDec("1",Dorigin_prof_tamt,0)+getRoundDec("1",DS_IO_DETAIL.NameValue(i, "ORIGIN_PROF_TAMT_TOTAL_PROF"),0);
            
        }
        
        if(Morigin_norm_samt != Dorigin_norm_samt){
        	showMessage(INFORMATION, OK, "USER-1000", "정상금액에 오차가 있습니다. 확인하십시오");
            return false;
        }
        
        if(Morigin_evt_samt != Dorigin_evt_samt){
        	showMessage(INFORMATION, OK, "USER-1000", "행사금액에 오차가 있습니다. 확인하십시오");
            return false;
        }
        
        if(Morigin_prof_tamt != Dorigin_prof_tamt){
        	showMessage(INFORMATION, OK, "USER-1000", "이익금액에 오차가 있습니다. 확인하십시오");
            return false;
        }
        return true;
        break;
    case "conf" :

        //데이터 길이 체크
        for(j=1; j <= DS_IO_MASTER.CountRow; j++ ){

            //확정체크 체크
            if(DS_IO_MASTER.OrgNameValue(j,"CONF_DT") != DS_IO_MASTER.NameValue(j,"CONF_DT") && DS_IO_MASTER.OrgNamevalue(j,"CONF_FLAG") =="F" && DS_IO_MASTER.Namevalue(j,"CONF_FLAG") =="F" ){
                showMessage(INFORMATION, OK, "USER-1000","확정 체크하셔야 합니다.");
                setFocusGrid(GD_MASTER, DS_IO_MASTER,1,"CONF_FLAG");
                return false;
            }
            if(DS_IO_MASTER.NameValue(j, "CONF_FLAG") == "T" && DS_IO_MASTER.RowStatus(j) != 0){
                if(DS_IO_MASTER.NameValue(j, "CONF_DT") == ""){
                    showMessage(INFORMATION, OK, "USER-1003","확정일자");
                    setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"CONF_DT");
                    return false;
                }
                if(DS_IO_MASTER.NameValue(j, "CONF_DT").replace(" ","").length != 8){
                    showMessage(INFORMATION, OK, "USER-1027","확정일자","8");
                    setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"CONF_DT");
                    return false;
                }
                if(DS_IO_MASTER.NameValue(j, "CONF_DT") < varToday){
                    showMessage(INFORMATION, OK, "USER-1020","확정일자", "당일");
                    setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"CONF_DT");
                    return false;
                }
            }
        }
        return true;
        break;
    }
}


/**
 * chkSave()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-21
 * 개    요 :  확정,확정취소
 * return값 : void
 */
function chkSave(){
	changeSum();
    //1. validation Master 그리드 필수 입력 체크 
    if(!chkValidation("save")) return;

    var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");           //점
    var strDeptCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DEPT_CD");          //팀
    var strTeamCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TEAM_CD");          //파트
    var strPCCd         = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PC_CD");            //PC
    var strYYYYMM       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "YYYYMM");           //년월
    var lastDate        = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate      = lastDate.getDate();                                                 //마지막일자
    
    var parameters =  "&strStrCd="        +encodeURIComponent(strStrCd)
                    + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                    + "&strTeamCd="       +encodeURIComponent(strTeamCd)
                    + "&strPCCd="         +encodeURIComponent(strPCCd)
                    + "&strYYYYMM="       +encodeURIComponent(strYYYYMM)
                    + "&strEndDate="      +encodeURIComponent(strEndDate);
    
    TR_MAIN.Action = "/dps/psal203.ps?goTo=save"+parameters;
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MAIN.Post();

}

/**
 * changeSum()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-29
 * 개    요 :  컬럼변경시 합계, 오차 계산
 * return값 : void
 */
function changeSum(){
	var bfyyTotal       = 0;
	var originNorm      = 0;
	var originEvt       = 0;
	var originTotal     = 0;
	var originProf      = 0;
	var gab             = 0;
	
    var strYYYYMM       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "YYYYMM");           //년월
    
    var lastDate    = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();                                                       //마지막일자
    
    
	for(i=1; i <= strEndDate; i++){
		DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT"+i) = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_NORM_SAMT"+i),0)
		                                                                       +       getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_EVT_SAMT"+i),0),0)
		//originTotal = getRoundDec("1",getRoundDec("1",originTotal,0) + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT"+i),0),0);
		//originProf  = getRoundDec("1",getRoundDec("1",originProf,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_TAMT"+i),0),0);
		//originNorm  = getRoundDec("1",getRoundDec("1",originNorm,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_NORM_SAMT"+i),0),0);
		//originEvt   = getRoundDec("1",getRoundDec("1",originEvt,0)   + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_EVT_SAMT"+i),0),0);
		
	}
    
	for(i=1; i <= strEndDate; i++){
		originTotal = 0;
        originProf  = 0;
        originNorm  = 0;
        originEvt   = 0;
		for(j=1; j <= DS_IO_DETAIL.CountRow; j++){
			originTotal = getRoundDec("1",getRoundDec("1",originTotal,0) + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT"+i),0),0);
	        originProf  = getRoundDec("1",getRoundDec("1",originProf,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT"+i),0),0);
	        originNorm  = getRoundDec("1",getRoundDec("1",originNorm,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_NORM_SAMT"+i),0),0);
	        originEvt   = getRoundDec("1",getRoundDec("1",originEvt,0)   + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_EVT_SAMT"+i),0),0);
		}
		for(j=1; j <= DS_IO_DETAIL.CountRow; j++){
			if(getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT"+i),0) != 0){
	            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_CRATE"+i) 
	            = getRoundDec("1", getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT"+i),0)/getRoundDec("1",originTotal,0)*100,2);
	        }
	        else{
	            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_CRATE"+i) = 0;
	        }
	        if(getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_TAMT"+i),0) != 0){
	            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_CRATE"+i) 
	            = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_TAMT"+i),0) /getRoundDec("1",originProf,0)*100,2);
	        }
	        else{
	            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_CRATE"+i) = 0;
	        }
		}
		
    }
	
	originTotal = 0;
    originProf  = 0;
    originNorm  = 0;
    originEvt   = 0;
    for(i=1; i <= strEndDate; i++){
        originTotal = getRoundDec("1",getRoundDec("1",originTotal,0) + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT"+i),0),0);
        originProf  = getRoundDec("1",getRoundDec("1",originProf,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_TAMT"+i),0),0);
        originNorm  = getRoundDec("1",getRoundDec("1",originNorm,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_NORM_SAMT"+i),0),0);
        originEvt   = getRoundDec("1",getRoundDec("1",originEvt,0)   + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_EVT_SAMT"+i),0),0);
        
    }
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_NORM_SAMT_TOTAL_JUNG") = originNorm;
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_EVT_SAMT_TOTAL_EVENT") = originEvt;
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT_TOTAL_SALE") = originTotal;
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_TAMT_TOTAL_PROF") = originProf;
        
    originTotal = 0;
    originProf  = 0;  
    for(j=1; j <= DS_IO_DETAIL.CountRow; j++){
    	originTotal = getRoundDec("1",getRoundDec("1",originTotal,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT_TOTAL_SALE"),0),0);
        originProf  = getRoundDec("1",getRoundDec("1",originProf,0)   + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT_TOTAL_PROF"),0),0);
    }
       
    for(j=1; j <= DS_IO_DETAIL.CountRow; j++){
        if(getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT_TOTAL_SALE"),0) != 0){
            DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_CRATE_TOTAL_SALE") 
            = getRoundDec("1", getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT_TOTAL_SALE"),0)/getRoundDec("1",originTotal,0)*100,2);
        }
        else{
            DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_CRATE_TOTAL_SALE") = 0;
        }
        if(getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT_TOTAL_PROF"),0) != 0){
            DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_CRATE_TOTAL_PROF") 
            = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT_TOTAL_PROF"),0) /getRoundDec("1",originProf,0)*100,2);
        }
        else{
            DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_CRATE_TOTAL_PROF") = 0;
        }
    }
}

 /**
  * detailCnt()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010-03-29
  * 개    요 :  컬럼을 해당월의 마지막날까지만 보여준다
  * return값 : void
  */
function detailCnt(){
    var strYYYYMM   = EM_PLAN_YM.text;                                                        //년월
	var lastDate    = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
	var strEndDate  = lastDate.getDate();                                                     //마지막일자
	var sValue      = "";
	var j           = 0;
	
	

    var strStrCd        = "";      //점
    var strYYYYMM       = "";      //년월
    var sBfyyValue      = "";
    
	for(i=1; i<= strEndDate; i++){
		j = i;
		if(DS_IO_MASTER.CountRow > 0){
		    strStrCd     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD");         //점
	        strYYYYMM    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"YYYYMM");         //계획년월

            if(i < 10 ){
                var thisDate     = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2)-1, "0"+i);
                var thisBFYYDate = new Date(strYYYYMM.substr(0,4)-1, strYYYYMM.substr(4,2)-1, "0"+i);
                strYYYYMM        = strYYYYMM + "0"+i;
            }
            else {
                var thisDate = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2)-1, i);
                var thisBFYYDate = new Date(strYYYYMM.substr(0,4)-1, strYYYYMM.substr(4,2)-1, i);
                strYYYYMM        = strYYYYMM + i;
            }
            
            var thisWeek     = thisDate.getDay();
            var thisBfyyWeek = thisBFYYDate.getDay();
            var strWeek      = thisWeek+1;
            var strBfyyWeek  = thisBfyyWeek+1;
            sValue       = rtuWeek(strWeek);
            sBfyyValue   = rtuWeek(strBfyyWeek);
            
		    //대비요일 조회
	        var goTo       = "searchBfyyWeek" ;    
	        var action     = "O";     
	        var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
	                       + "&strYYYYMM="          +encodeURIComponent(strYYYYMM);
	
	        TR_MAIN.Action="/dps/psal203.ps?goTo="+goTo+parameters;  
	        TR_MAIN.KeyValue="SERVLET("+action+":DS_O_WEEK=DS_O_WEEK)"; 
	        TR_MAIN.Post();
	        
	        i = j;
	        
	        if (DS_O_WEEK.countRow != 0) {
	        	sBfyyValue  = rtuWeek(DS_O_WEEK.NameValue(1,"CMPR_DAY"));
	        }

	        if(i <= strEndDate){
	            GD_DETAIL.LayoutInfo("ColumnInfo", "BFYYWEEK"+i+"::<HEADER>::text")   = sBfyyValue ;
	            GD_DETAIL.LayoutInfo("ColumnInfo", "ORIGINWEEK"+i+"::<HEADER>::text") = sValue ;
	        }
		}
		else{

		    strStrCd        = LC_STR_CD.BindColVal;      //점
		    strYYYYMM       = EM_PLAN_YM.text;           //년월
		    
			if(i < 10 ){
                var thisDate     = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2)-1, "0"+i);
                var thisBFYYDate = new Date(strYYYYMM.substr(0,4)-1, strYYYYMM.substr(4,2)-1, "0"+i);
                strYYYYMM        = strYYYYMM + "0"+i;
            }
            else {
                var thisDate = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2)-1, i);
                var thisBFYYDate = new Date(strYYYYMM.substr(0,4)-1, strYYYYMM.substr(4,2)-1, i);
                strYYYYMM        = strYYYYMM + i;
            }
            
            var thisWeek     = thisDate.getDay();
            var thisBfyyWeek = thisBFYYDate.getDay();
            var strWeek      = thisWeek+1;
            var strBfyyWeek  = thisBfyyWeek+1;
            sValue       = rtuWeek(strWeek);
            sBfyyValue   = rtuWeek(strBfyyWeek);

            if(i <= strEndDate){
                GD_DETAIL.LayoutInfo("ColumnInfo", "BFYYWEEK"+i+"::<HEADER>::text")   = sBfyyValue ;
                GD_DETAIL.LayoutInfo("ColumnInfo", "ORIGINWEEK"+i+"::<HEADER>::text") = sValue ;
            }
		}
		
		
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
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>



<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid GD_DETAIL OnExit event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>


if(row > 0 && old_Row > 0){  
    if(DS_IO_DETAIL.CountRow == 0){
        GD_MASTER.ReDraw = "false";
        GD_MASTER.Editable = false;
        GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") = "F";
        DS_IO_MASTER.NameValue(row,"CONF_DT") = "";

        GD_MASTER.ReDraw = "true";
    }
    else{
        if(DS_IO_MASTER.RowStatus(row) == 0 && DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
            GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
        }
        else{
            GD_MASTER.ColumnProp("CONF_DT","Edit")="";
        }
    } 
} 
else{
        setFocusGrid(GD_MASTER, DS_IO_MASTER,0,colid);
        sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    
}

GD_MASTER.Editable = true;

   
</script>

 <!-- Grid GD_MASTER OnPopup event 처리 -->
 <script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    switch (colid) {
    case "CONF_DT" :
        openCal(GD_MASTER, row, colid);   //그리드 달력 
        break;
    }
     
 </script>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

if(row > 0 && old_Row > 0){
    if (DS_IO_DETAIL.IsUpdated ){
    	ret = showMessage(QUESTION, YESNO, "USER-1074");
        if (ret != "1") {
            DS_IO_MASTER.RowPosition = old_Row;
            return false;
        } 
    }
   
	searchDetail();
    
    if(DS_IO_DETAIL.CountRow == 0 && DS_IO_MASTER.RowStatus(row) == 0){
        
        GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") = "F";
        DS_IO_MASTER.NameValue(row,"CONF_DT") = "";
        setFocusGrid(GD_MASTER, DS_IO_MASTER,row,"CONF_DT");
    }
    else{
        if(DS_IO_MASTER.RowStatus(row) == 0 && DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
            GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
            setFocusGrid(GD_MASTER, DS_IO_MASTER,row,"STR_CD");
        }
        else{
            GD_MASTER.ColumnProp("CONF_DT","Edit")="";
            setFocusGrid(GD_MASTER, DS_IO_MASTER,row,"STR_CD");
        }
        
    } 
}


old_Row = row;
</script>

<script language="javascript">
    var today    = new Date();
    var oldColid = "";
    var old_Row = 0;

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
    var changeAmt = 0;
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "N");                       // 파트  
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC 
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    if(LC_DEPT_CD.BindColVal != "%"){
        getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "N");                       // 파트   
    }else{
        DS_TEAM_CD.ClearData();
        insComboData( LC_TEAM_CD, "%", "전체",1);
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_TEAM_CD.Index = 0;
</script>

<!-- TEAM(조회)  변경시  -->
<script language=JavaScript for=LC_TEAM_CD event=OnSelChange()>
    if(LC_TEAM_CD.BindColVal != "%"){
        getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC   
    }else{
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_PC_CD.Index   = 0;
</script>

<script language=JavaScript for=DS_IO_MASTER
   event=onColumnChanged(Row,Colid)>
old_Row = Row
</script>

 
<script language=JavaScript for=GD_DETAIL event=OnSelChanged(colid,index)>
GD_DETAIL.EnableDblClkAtNotEditable = "false";
if(DS_IO_DETAIL.NameValue(index, "CONF_FLAG") == "N"){
	//GD_DETAIL.LayoutInfo("ColumnInfo", colid + "::<CHILD>::editable")= true;
    //GD_DETAIL.LayoutInfo("ColumnInfo", colid + "::<CHILD>::type")="edit";
    GD_DETAIL.ActivateEdit();
}
else{
	GD_DETAIL.LayoutInfo("ColumnInfo", colid + "::<CHILD>::type")="none";
	GD_DETAIL.EnableDblClkAtNotEditable = "false";
}
changeAmt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, GD_DETAIL.GetRefColumnID(colid)) ;

oldColid = colid;
</script>

<script language=JavaScript for=GD_DETAIL event=OnSelChange(colid,index)>

if(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, GD_DETAIL.GetRefColumnID(oldColid)) != changeAmt){
	changeSum();
	changeAmt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, GD_DETAIL.GetRefColumnID(colid)) ;
	oldColid = colid;
}

  return true;
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_PLAN_YM event=onKillFocus()>

    //영업조회월
    if (isNull(EM_PLAN_YM.text) ==true ) {
        showMessage(INFORMATION, OK, "USER-1003","년월"); 
        EM_PLAN_YM.text = varToMon;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_PLAN_YM.text.replace(" ","").length != 6 ) {
        showMessage(INFORMATION, OK, "USER-1027","년월","6");
        EM_PLAN_YM.text = varToMon;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMM(EM_PLAN_YM.text) ) {
        showMessage(INFORMATION, OK, "USER-1069","년월");
        EM_PLAN_YM.text = varToMon;
        return ;
    }
    
    var lastDate    = new Date(EM_PLAN_YM.text.substr(0,4), EM_PLAN_YM.text.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();                                                     //마지막일자
    EM_SALE_DAY_CNT.text = strEndDate;
</script>

<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

    if(bCheck == "1"){
    	for(i=1; i <= DS_IO_MASTER.CountRow; i++){
            DS_IO_MASTER.NameValue(i,"CONF_FLAG") = "T";
        }
    }
    else{
        for(i=1; i <= DS_IO_MASTER.CountRow; i++){
            DS_IO_MASTER.NameValue(i,"CONF_FLAG") = "F";
        }
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
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_PC_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_WEEK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_MCHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
   <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                           *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

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
            <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0"
               class="s_table">
               <tr>
                  <th width="70" class="point">점</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70" class="point">팀</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70"  class="point">파트</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">PC</th>
                  <td ><comment id="_NSID_"> <object
                     id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <th class="point">년월</th>
                  <td ><comment id="_NSID_"> <object
                     id=EM_PLAN_YM classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('M',EM_PLAN_YM)" align="absmiddle" />
                  </td>
                  <th>영업일수</th>
                  <td colspan="5"><comment id="_NSID_"> <object
                     id=EM_SALE_DAY_CNT classid=<%=Util.CLSID_EMEDIT%> width=72
                     align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  </td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>

   <tr>
      <td class="dot"></td>
   </tr>


   <tr valign="top">
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_MASTER width=100% height=167 classid=<%=Util.CLSID_GRID%>>
                     <param name="DataID" value="DS_IO_MASTER">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>

    
   <tr valign="top" class="PT10">
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object 
                  id=GD_DETAIL width=100% height=301 classid=<%=Util.CLSID_MGRID%>>
                     <param name="DataID" value="DS_IO_DETAIL"> 
                     <Param Name="IndicatorInfo"       value='
                       <INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                     <Param Name="sort"      value="false">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>
</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</div>
<body>
</html>
