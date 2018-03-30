<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 협력사 평가
 * 작 성 일 : 2011.06.21
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : psal7030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 매장등급추이현황
 * 이    력 :
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button"%>
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
<script language="javascript"   src="/<%=dir%>/js/common.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/gauce.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/global.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/message.js"       type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup_dps.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var rtnVal            = false;
var intSearchCnt      = 0;                             // 조회버튼클릭 여부(0일 경우 마스터조회 건수)
var bfListRowPosition = 0;                             // 이전 List Row Position
var strToday          = "";
var roundFlag         = "";
var searchFlag        = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-06-21
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){

	 strToday = getTodayDB("DS_O_RESULT");
	 
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     // Output Data Set Header 초기화

     //그리드 초기화
     gridCreate1(); //마스터
     
     // EMedit에 초기화
     initEmEdit(EM_S_EVALU_YY         ,"YYYY"        ,PK);             // 년도
     EM_S_EVALU_YY.alignment = 1;
     
     //콤보 초기화 (조회용)
     initComboStyle(LC_S_STR         ,DS_O_STR           ,"CODE^0^30,NAME^0^80"   ,1  ,PK);         // 점     
     initComboStyle(LC_S_BUMUN       ,DS_O_DEPT          ,"CODE^0^30,NAME^0^80"   ,1  ,PK);         // 팀     
     initComboStyle(LC_S_TEAM        ,DS_O_TEAM          ,"CODE^0^30,NAME^0^80"   ,1  ,NORMAL);     // 파트     
     initComboStyle(LC_S_PC          ,DS_O_PC            ,"CODE^0^30,NAME^0^80"   ,1  ,NORMAL);     // PC  
     
     getStore("DS_O_STR", "Y", "", "N");
     getEtcCode("DS_O_GRADE", "D", "P605", "N");         // 등급
     
     LC_S_STR.index = 0;
     LC_S_STR.Focus(); 
     EM_S_EVALU_YY.text = strToday.substring(0,4);
 
     setMasterObject(false, false);
 }

 function gridCreate1(){
	 
	 var arrGubun = new Array("면적"      , "등급"         , "가중치"        , "C/S점수"  , "바이어점수");
	 var arrColid = new Array("AREA_SIZE", "PUMBUN_GRADE" , "PUMBUN_WEIGHT" , "CS_SCORE" , "BUYER_SCORE");
	 
	 var hdrProperies = '<COLUMNINFO>'
     
		  + '       <COLUMN id="ID_PUMBUN_CD" refcolid="PUMBUN_CD" index="1">'
		  + '           <HEADER left="0" top="0" right="60" bottom="25" text="브랜드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
		  + ' <SUPPRESS>            <REFCOLID>PUMBUN_CD</REFCOLID>           </SUPPRESS>'
		  + '           <VIEW left="0" top="0" right="60" bottom="100" edit=""  borderstyle="Line" bordercolor="#dddddd"/>'
		  + '       </COLUMN>'
		    
		  + '       <COLUMN id="ID_PUMBUN_NM"  refcolid="PUMBUN_NM" index="2">'
		  + '           <HEADER left="60" top="0" right="180" bottom="25" text="브랜드명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
		  + ' <SUPPRESS>            <REFCOLID>PUMBUN_CD</REFCOLID>           </SUPPRESS>'
		  + '           <VIEW left="60" top="0" right="180" bottom="100" align="LeftCenter" borderstyle="Line" bordercolor="#dddddd"/>'
		  + '       </COLUMN>'

	     for(var k=0;k<arrGubun.length;k++){
	    	  for(var i=1;i<= 12; i++){
			       hdrProperies += '       <COLUMN id="ID_GUBUN"  refcolid="" index="3">'
                                + '           <HEADER fix="true" left="180" top="0" right="260" bottom="25" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                                + '           <VIEW left="180" top="'+(0+(k*20))+'" right="260" bottom="'+(20+(k*20))+'" text="'+arrGubun[k]+'" align="LeftCenter" borderstyle="Line" bordercolor="#dddddd"/>'
                                + '       </COLUMN>'
                                
		           hdrProperies += '       <COLUMN id="ID_AREA_SIZE'+i+'"  refcolid="AREA_SIZE'+i+'" index="4">'
		                        +  '           <HEADER left="'+(180+(i*80))+'" top="0" right="'+(260+(i*80))+'" bottom="25" text="'+i+'월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
		                        +  '           <VIEW left="'+(180+(i*80))+'" top="'+(0+(k*20))+'" right="'+(260+(i*80))+'" bottom="'+(20+(k*20))+'" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,###.00"/>'
		                        +  '       </COLUMN>'
                        
                   if(arrGubun[k] == "등급"){ 
	                   hdrProperies += '       <COLUMN id="ID_PUMBUN_GRADE'+i+'"  refcolid="PUMBUN_GRADE'+i+'" index="5">'
	                                +  '           <HEADER left="'+(180+(i*80))+'" top="0" right="'+(260+(i*80))+'" bottom="25" text="'+i+'월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
	                                +  '           <VIEW left="'+(180+(i*80))+'" top="'+(0+(k*20))+'" right="'+(260+(i*80))+'" bottom="'+(20+(k*20))+'" align="Center" borderstyle="Line" bordercolor="#dddddd"/>'
	                                +  '       </COLUMN>'
                   }
                   
                   if(arrGubun[k] == "가중치"){ 
	                   hdrProperies += '       <COLUMN id="ID_PUMBUN_WEIGHT'+i+'"  refcolid="PUMBUN_WEIGHT'+i+'" index="6">'
	                                +  '           <HEADER left="'+(180+(i*80))+'" top="0" right="'+(260+(i*80))+'" bottom="25" text="'+i+'월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
	                                +  '           <VIEW left="'+(180+(i*80))+'" top="'+(0+(k*20))+'" right="'+(260+(i*80))+'" bottom="'+(20+(k*20))+'" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,###.00"/>'
	                                +  '       </COLUMN>'
                   }    
                   
                   if(arrGubun[k] == "C/S점수"){ 
	                   hdrProperies += '       <COLUMN id="ID_CS_SCORE'+i+'"  refcolid="CS_SCORE'+i+'" index="7">'
	                                +  '           <HEADER left="'+(180+(i*80))+'" top="0" right="'+(260+(i*80))+'" bottom="25" text="'+i+'월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
	                                +  '           <VIEW left="'+(180+(i*80))+'" top="'+(0+(k*20))+'" right="'+(260+(i*80))+'" bottom="'+(20+(k*20))+'" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
	                                +  '       </COLUMN>'
                   }
                   
                   if(arrGubun[k] == "바이어점수"){              
	                   hdrProperies += '       <COLUMN id="ID_BUYER_SCORE'+i+'"  refcolid="BUYER_SCORE'+i+'" index="8">'
	                                +  '           <HEADER left="'+(180+(i*80))+'" top="0" right="'+(260+(i*80))+'" bottom="25" text="'+i+'월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
	                                +  '           <VIEW left="'+(180+(i*80))+'" top="'+(0+(k*20))+'" right="'+(260+(i*80))+'" bottom="'+(20+(k*20))+'" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
	                                +  '       </COLUMN>'                                            
                   }
	    	  }
	     }
                   
		  hdrProperies +=  '     </COLUMNINFO>';
	                  
	 initMGridStyle(GR_MASTER, "common", hdrProperies);
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
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-06-15
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 if(checkValidation("Search")){
		 DS_IO_MASTER.ClearData();  
	     intSearchCnt = 0;
	     bfListRowPosition = 0;
	     getMaster();
	     searchFlag = true;
	     // 조회결과 Return
	     setPorcCount("SELECT", GR_MASTER);
	 }
}

/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-06-15
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

 }

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
     
}


/**
 * btn_Excel()
 * 작 성 자 : 김경은
 * 작 성 일 :
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 김경은
 * 작 성 일 : 
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김경은
 * 작 성 일 : 
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * setMasterObject(flag, updateFlag)
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-06-15
  * 개    요        : 마스터 Object의 활성화/비활성화를 제어한다.
  * return값 : void
  */
 function setMasterObject(flag, updateFlag){
//     GR_MASTER.Editable                 = flag;

 }  
 /**
 * getMaster()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-06-21
 * 개    요 :  마스터  조회
 * return값 : void
 */
 function getMaster(){

    // 조회조건 셋팅
    var strStrCd         = LC_S_STR.BindColVal;                      // 점
    var strBumun         = LC_S_BUMUN.BindColVal;                    // 팀
    var strTeam          = LC_S_TEAM.BindColVal;                     // 파트
    var strPc            = LC_S_PC.BindColVal;                       // PC
    var strOrgCd         = strStrCd + strBumun + strTeam + strPc;    // 조직   
    var strEvaluYY       = EM_S_EVALU_YY.Text;                       // 년도
   
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
				   + "&strBumun="+encodeURIComponent(strBumun)     
				   + "&strTeam="+encodeURIComponent(strTeam)      
				   + "&strPc="+encodeURIComponent(strPc)     
				   + "&strOrgCd="+encodeURIComponent(strOrgCd)
				   + "&strEvaluYY="+encodeURIComponent(strEvaluYY); 
    
    TR_S_MAIN.Action  = "/dps/psal703.ps?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_S_MAIN.Post();
    
 }

 /**
  * checkValidation()
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-06-21
  * 개    요        :  값 체크 
  * return값 : void
  */
 function checkValidation(Gubun) {
 
	  var strStrCd      = LC_S_STR.BindColVal;                                  // 점
      var strEvaluYm    = EM_S_EVALU_YY.Text;                                   // 년도
      
      //조회버튼 클릭시 Validation Check
      if(Gubun == "Search"){   
          if(EM_S_EVALU_YY.Text.length == 0){
              showMessage(INFORMATION, OK, "USER-1002", "년도");
              EM_S_EVALU_YY.Focus();
              return false;
          }
         
	      //계획년도 자릿수, 공백 체크
	      if (EM_S_EVALU_YY.text.replace(" ","").length != 4 ) {
	          showMessage(INFORMATION, OK, "USER-1027","년도","4");
	          EM_S_EVALU_YY.Focus();
	          return;
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
<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GR_MASTER event=OnSelChanged(colid,index)>

	GR_MASTER.ActivateEdit();
    GR_MASTER. EnableDblClkAtNotEditable = true;

</script>

<script language=JavaScript for=GR_MASTER event=OnSelChange(colid,index)>
  return true;
</script>

<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- GR_MASTER OnPopup event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnPopup(row,colid,data)>
    openCal(GR_MASTER,row,colid);
</script>

<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GR_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    var dataSet = eval(this.DataID);
    for( var i=1 ; i<=dataSet.CountRow; i++){
        dataSet.NameValue(i,Colid) = bCheck=='0'?'F':'T';
    }
</script>


<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR event=OnSelChange()>
    if(LC_S_STR.BindColVal != "%"){
        getDept("DS_O_DEPT", "Y", LC_S_STR.BindColVal, "N");   // 팀 
        LC_S_BUMUN.Index = 0;
    }

    searchFlag = false;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_S_BUMUN event=OnSelChange()>
    if(LC_S_BUMUN.BindColVal != "%"){
        getTeam("DS_O_TEAM", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, "Y"); // 파트  
    }else{
        DS_O_TEAM.ClearData();
        insComboData( LC_S_TEAM, "%", "전체",1);
        DS_O_PC.ClearData();
        insComboData( LC_S_PC, "%", "전체",1);
    }
    LC_S_TEAM.Index = 0;
    
    searchFlag = false;
    
</script>

<!-- 파트(조회)  변경시  -->
<script language=JavaScript for=LC_S_TEAM event=OnSelChange()>
    if(LC_S_TEAM.BindColVal != "%"){
        getPc("DS_O_PC", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, LC_S_TEAM.BindColVal, "Y");     // PC  
    }else{
        DS_O_PC.ClearData();
        insComboData( LC_S_PC, "%", "전체",1);
    }
    LC_S_PC.Index = 0;
    
    searchFlag = false;
    
</script>

<!-- PC(조회)  변경시  -->
<script language=JavaScript for=LC_S_PC event=OnSelChange()>
    searchFlag = false;
</script>

<!-- 년도 KillFocus -->
<script language=JavaScript for=EM_S_EVALU_YY event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    searchFlag = false;
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

<comment id="_NSID_"><object id="DS_O_STR"          classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GRADE"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
   <tr>
      <td class="PT01 PB03">
      <table width="100%" border="0" cellspacing="0" cellpadding="0"
         class="o_table">
         <tr>
            <td>
	            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
	            <tr>
	                <th class="point" width="70">점</th>
	                <td width="110">
	                  <comment id="_NSID_"> 
	                      <object id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100 align="absmiddle" tabindex=1> </object> 
	                  </comment><script>_ws_(_NSID_);</script>
	                </td>
	                <th class="point" width="70">팀</th>
	                <td width="110">
	                  <comment id="_NSID_"> 
	                      <object id=LC_S_BUMUN classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1> </object> 
	                  </comment><script>_ws_(_NSID_);</script>
	                </td>
	                <th width="70">파트</th>
	                <td width="110">
	                  <comment id="_NSID_"> 
	                      <object id=LC_S_TEAM classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1> </object> 
	                  </comment><script>_ws_(_NSID_);</script>
	                </td>
	                <th width="70">PC</th>
	                <td>
	                  <comment id="_NSID_"> 
	                      <object id=LC_S_PC classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1> </object> 
	                  </comment><script>_ws_(_NSID_);</script>
	                </td>
	            </tr>
	            <tr>
	            <th class="point">년도</th>
	            <td colspan = 7>
	                  <comment id="_NSID_">
	                      <object id=EM_S_EVALU_YY classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
	                      </object>
	                  </comment>
	                  <script> _ws_(_NSID_);</script>
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
    <tr>
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GR_MASTER width=100% height=482 classid=<%=Util.CLSID_MGRID%> tabindex=1>
                     <param name="DataID" value="DS_IO_MASTER">
                     <Param Name="IndicatorInfo"       value='
                       <INDICATORINFO width="20" fontsize="9" indexnumber="false"/>'>
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


</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
    <object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>

</body>
</html>

