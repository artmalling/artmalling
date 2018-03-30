<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 협력사 평가
 * 작 성 일 : 2011.06.15
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : psal7020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 매장등급 및 C/S 평가등록
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
var score             = "";                            // 등록 평가점수
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-06-15
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){

     strToday = getTodayDB("DS_O_RESULT");
     
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     //DS_O_CHECK.setDataHeader('<gauce:dataset name="H_CHECK"/>');
     DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     // Output Data Set Header 초기화

     //그리드 초기화
     gridCreate1(); //마스터
     
     // EMedit에 초기화
     initEmEdit(EM_S_EVALU_YM         ,"THISMN"        ,PK);             // 평가년월
     
     //콤보 초기화 (조회용)
     initComboStyle(LC_S_STR         ,DS_O_STR           ,"CODE^0^30,NAME^0^80"   ,1  ,PK);         // 점     
     initComboStyle(LC_S_BUMUN       ,DS_O_DEPT          ,"CODE^0^30,NAME^0^80"   ,1  ,PK);         // 팀     
     initComboStyle(LC_S_TEAM        ,DS_O_TEAM          ,"CODE^0^30,NAME^0^80"   ,1  ,NORMAL);     // 파트     
     initComboStyle(LC_S_PC          ,DS_O_PC            ,"CODE^0^30,NAME^0^80"   ,1  ,NORMAL);     // PC  
     
     getStore("DS_O_STR", "Y", "", "N");
     getEtcCode("DS_O_GRADE", "D", "P605", "N");         // 등급
     
     LC_S_STR.index = 0;
     LC_S_STR.Focus(); 
 
     // 배점가져오기
     getAllotScore();
     
     setMasterObject(false, false);
 }

 function gridCreate1(){
	 var hdrProperies = '<COLUMNINFO>'
     
					  + '       <COLUMN id="ID_PUMBUN_CD" refcolid="PUMBUN_CD" index="1">'
					  + '           <HEADER left="0" top="0" right="60" bottom="50" text="브랜드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
					  + ' <SUPPRESS>            <REFCOLID>PUMBUN_CD</REFCOLID>           </SUPPRESS>'
					  + '           <VIEW left="0" top="0" right="60" bottom="40" edit=""  borderstyle="Line" bordercolor="#dddddd"/>'
					  + '       </COLUMN>'
					    
					  + '       <COLUMN id="ID_PUMBUN_NM"  refcolid="PUMBUN_NM" index="2">'
					  + '           <HEADER left="60" top="0" right="180" bottom="50" text="브랜드명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
					  + ' <SUPPRESS>            <REFCOLID>PUMBUN_CD</REFCOLID>           </SUPPRESS>'
					  + '           <VIEW left="60" top="0" right="180" bottom="40" align="LeftCenter" borderstyle="Line" bordercolor="#dddddd"/>'
					  + '       </COLUMN>'
					 
					  + '       <COLUMN id="ID_GUBUN"  refcolid="" index="3">'
					  + '           <HEADER left="180" top="0" right="230" bottom="50" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
					  + '           <VIEW left="180" top="0" right="230" bottom="20" text="전월" borderstyle="Line" bordercolor="#dddddd"/>'
					  + '       </COLUMN>'
					 
					  + '       <COLUMN id="ID_J_AREA_SIZE"  refcolid="J_AREA_SIZE" index="4">'
					  + '           <HEADER left="230" top="0" right="310" bottom="50" text="면적" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
					  + '           <VIEW left="230" top="0" right="310" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,###.00"/>'
					  + '       </COLUMN>'
					 
					  + '       <COLUMN id="ID_J_PUMBUN_GRADE"  refcolid="J_PUMBUN_GRADE" index="5">'
					  + '           <HEADER fix="true" left="310" top="0" right="370" bottom="50" text="등급" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
					  + '           <VIEW left="310" top="0" right="370" bottom="20" borderstyle="Line" bordercolor="#dddddd"/>'
					  + '           <CHILD type="lookup" lookupdataid="DS_O_GRADE" lookupcode="CODE" lookuptext="NAME" showitemcount="5" editable="false"/>'
					  + '       </COLUMN>'
					  
					  + '       <COLUMN id="ID_J_PUMBUN_WEIGHT"  refcolid="J_PUMBUN_WEIGHT" index="6">'
                      + '           <HEADER fix="true" left="370" top="0" right="420" bottom="50" text="가중치" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="370" top="0" right="420" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,###.00"/>'
                      + '       </COLUMN>'
                      
                      + '       <COLUMN id="ID_J_CNT"  refcolid="">'
                      + '           <HEADER left="420" top="0" right="780" bottom="25" text="매장 CS 평가 (평가배점 /점)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '       </COLUMN>'
                      + '       <COLUMN id="ID_J_CNT1"  refcolid="J_CNT1">'
                      + '           <HEADER fix="true" left="420" top="25" right="510" bottom="50" text="약속전체건수" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="420" top="0" right="510" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
                      + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" />' 
                      + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>'
                      + '       </COLUMN>'
                      + '       <COLUMN id="ID_J_CNT2"  refcolid="J_CNT2" >'
                      + '           <HEADER fix="true" left="510" top="25" right="600" bottom="50" text="약속불이행건수" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="510" top="0" right="600" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
                      + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" />' 
                      + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>'
                      + '       </COLUMN>'
                      + '       <COLUMN id="ID_J_CNT3"  refcolid="J_CNT3" >'
                      + '           <HEADER fix="true" left="600" top="25" right="690" bottom="50" text="고객수선건수" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="600" top="0" right="690" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
                      + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" />' 
                      + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>'
                      + '       </COLUMN>'
                      + '       <COLUMN id="ID_J_EVALU_SCORE"  refcolid="J_EVALU_SCORE">'
                      + '           <HEADER fix="true" left="690" top="25" right="780" bottom="50" text="평가점수" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="690" top="0" right="780" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd" displayformat="#,##0"/>'
                      + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" />' 
                      + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>'
                      + '       </COLUMN>'
                      
                      + '       <COLUMN id="ID_GUBUN"  refcolid="" index="3">'
                      + '           <HEADER left="180" top="0" right="230" bottom="50" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="180" top="20" right="230" bottom="40" text="당월" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '       </COLUMN>'
                     
                      + '       <COLUMN id="ID_AREA_SIZE"  refcolid="AREA_SIZE">'
                      + '           <HEADER left="230" top="0" right="310" bottom="50" text="면적" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="230" top="20" right="310" bottom="40" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,###.00"/>'
                      + '           <CHILD type="edit" inputtype="num"  decimal="2" editable="true"/>'
                      + '       </COLUMN>'
                     
                      + '       <COLUMN id="ID_PUMBUN_GRADE"  refcolid="PUMBUN_GRADE">'
                      + '           <HEADER fix="true" left="310" top="0" right="370" bottom="50" text="등급" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="310" top="20" right="370" bottom="40" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <CHILD type="lookup" lookupdataid="DS_O_GRADE" lookupcode="CODE" lookuptext="NAME" showitemcount="5"/>'
                      + '       </COLUMN>'
                      
                      + '       <COLUMN id="ID_PUMBUN_WEIGHT"  refcolid="PUMBUN_WEIGHT">'
                      + '           <HEADER left="370" top="0" right="420" bottom="50" text="가중치" align="right" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="370" top="20" right="420" bottom="40" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,###.00"/>'
                      + '           <CHILD type="edit" inputtype="num"  decimal="2" editable="true"/>' 
                      + '       </COLUMN>'
                      
                      + '       <COLUMN id="ID_CNT"  refcolid="">'
                      + '           <HEADER left="420" top="0" right="780" bottom="25" text="매장 CS 평가 (평가배점 /점)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '       </COLUMN>'
                      + '       <COLUMN id="ID_CNT1"  refcolid="CNT1">'
                      + '           <HEADER fix="true" left="420" top="25" right="510" bottom="50" text="약속전체건수" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="420" top="20" right="510" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
                      + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" />' 
                      + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>'
                      + '       </COLUMN>'
                      + '       <COLUMN id="ID_CNT2"  refcolid="CNT2" >'
                      + '           <HEADER fix="true" left="510" top="25" right="600" bottom="50" text="약속불이행건수" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="510" top="20" right="600" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
                      + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" />' 
                      + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>'
                      + '       </COLUMN>'
                      + '       <COLUMN id="ID_CNT3"  refcolid="CNT3" >'
                      + '           <HEADER fix="true" left="600" top="25" right="690" bottom="50" text="고객수선건수" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="600" top="20" right="690" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
                      + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" />' 
                      + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>'
                      + '       </COLUMN>'
                      + '       <COLUMN id="ID_EVALU_SCORE"  refcolid="EVALU_SCORE">'
                      + '           <HEADER fix="true" left="690" top="25" right="780" bottom="50" text="평가점수" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '           <VIEW left="690" top="20" right="780" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
                      + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" />' 
                      + '           <CHILD type="edit" inputtype="num"  editable="true"/>'
                      + '       </COLUMN>'
                      
	                  + '     </COLUMNINFO>';
	                  
	 initMGridStyle(GR_MASTER, "common", hdrProperies);
     DS_IO_MASTER.UseChangeInfo = false; 
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
	     //searchFlag = true;
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
	DS_IO_MASTER.ClearData();
    LC_S_STR.index      = 0;
    LC_S_BUMUN.index    = 0;
    LC_S_TEAM.index     = 0;  
    LC_S_PC.index       = 0;    
    LC_S_STR.Focus(); 
   // searchFlag = false;
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-06-15
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	 if(DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "SEL") == "F")
         DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "SEL")  = "T";
     else 
         DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "SEL")  = "F";
	 
	 
	// 삭제할 데이터 없는 경우
	if (!DS_O_LIST.IsUpdated){
	       //저장할 내용이 없습니다
	       showMessage(EXCLAMATION, OK, "USER-1019");
	       return;
	 }
	
    if(!checkValidation("Delete"))
         return;
    
    // 삭제 메세지 
    if(showMessage(Question, YESNO, "USER-1023") == 1){  
    	
    	DS_O_LIST.DeleteRow(DS_O_LIST.RowPosition);
    	
    	// 기존데이터일 경우 삭제 Action실행 
        var params = "&strFlag=delete" ;
       
        TR_MAIN.Action="/dps/psal702.ps?goTo=delete&strFlag=delete"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_O_LIST=DS_O_LIST)"; //조회는 O
        TR_MAIN.Post();
        
        btn_Search();
    }
}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-06-15
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
     
	
	//if (!searchFlag){
    //    showMessage(QUESTION, OK, "USER-1075", "저장")
    //     return;
    //}
	
    // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION, OK, "USER-1028");
       return;
    }
    if(!checkValidation("Save"))
      return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){    // validation 체크
        TR_MAIN.Action="/dps/psal702.ps?goTo=save&strFlag=save"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_MAIN.Post();

        btn_Search();
    }  
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
 * 작 성 일 : 2011-06-15
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
    var strEvaluYm       = EM_S_EVALU_YM.Text;                       // 평가년월
   
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
				   + "&strBumun="+encodeURIComponent(strBumun)    
				   + "&strTeam="+encodeURIComponent(strTeam)      
				   + "&strPc="+encodeURIComponent(strPc)     
				   + "&strOrgCd="+encodeURIComponent(strOrgCd)
				   + "&strEvaluYm="+encodeURIComponent(strEvaluYm); 
    
    TR_S_MAIN.Action  = "/dps/psal702.ps?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_S_MAIN.Post();
    
    getAllotScore();
    
    if(score == 0){
        showMessage(EXCLAMATION, OK, "USER-1195", "매장 C/S평가 배점", "매장등록 및 C/S평가 등록");
        return false;
    }
    
 }

 /**
  * checkValidation()
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-06-15
  * 개    요        :  값 체크 
  * return값 : void
  */
 function checkValidation(Gubun) {
 
	  var strStrCd      = LC_S_STR.BindColVal;                               // 점
      var strEvaluYm    = EM_S_EVALU_YM.Text;                                   // 평가년월
      var strPreEvaluYm = addDate("m", -1, strEvaluYm+"01", "").substring(0,6); // 평가년월
      
      //조회버튼 클릭시 Validation Check
      if(Gubun == "Search"){   
         if(EM_S_EVALU_YM.Text.length == 0){
              showMessage(INFORMATION, OK, "USER-1002", "평가년월");
              EM_S_EVALU_YM.Focus();
              return false;
          }
      
      }
      
      // 저장버튼 클릭시 Validation Check
      if(Gubun == "Save"){
    	  
    	  if(score == 0){
              showMessage(EXCLAMATION, OK, "USER-1195", "매장 C/S평가 배점", "매장등록 및 C/S평가 등록");
              return false;
          }
    	  
    	  if(!confCheck(strStrCd, strEvaluYm)){                              // 확정여부확인
              showMessage(EXCLAMATION, OK, "USER-1194","등록/수정 ");
              return false;
          }
	      
	      
          var intRowCount   = DS_IO_MASTER.CountRow;
          var intEvaluScore = 0;                     // 평가점수                    
         
          if(intRowCount > 0){
              for(var i=1; i <= intRowCount; i++){
            	  intEvaluScore = DS_IO_MASTER.NameValue(i, "EVALU_SCORE");
            	  if(intEvaluScore > score){
            		  showMessage(EXCLAMATION, OK, "USER-1021", "평가점수", score);
            		  GR_MASTER.RowPosition    = i;
                      GR_MASTER.ColumnPosition = "ID_EVALU_SCORE";
            		  return false;
                     // DS_IO_MASTER.NameValue(i, "EVALU_SCORE") = 0;
            	  }            	  
              }
          }
      }
      
      // 전월내역복사 클릭시 Validation Check
      if(Gubun == "Copy"){

    	  if(score == 0){
              showMessage(EXCLAMATION, OK, "USER-1195", "매장 C/S평가 배점", "전월내역복사");
              return false;
          }
    	  
	   	  if(!confCheck(strStrCd, strEvaluYm)){                              // 확정여부확인
	          showMessage(EXCLAMATION, OK, "USER-1194","복사");
	          return false;
	      }
	   	      
   	      if(!copyValCheck(strEvaluYm)){                           // 등록할 평가년월이 등록되어있는지 확인한다.
        	  showMessage(EXCLAMATION, OK, "USER-1192");
        	  return false;
          }
	   	  
   	      if(copyValCheck(strPreEvaluYm)){                         // 전월등록된 내역이 있는지 확인한다.
	          showMessage(EXCLAMATION, OK, "USER-1193");
	          return false;
	      }
      }
      
      return true;
  }
 
 /**
  * copyValCheck()
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-06-15
  * 개    요 :  복사시 데이터 존재여부 확인
  * return값 : void
  */
  function copyValCheck(strEvaluYm){

	// 조회조건 셋팅
    var strStrCd         = LC_S_STR.BindColVal;                      // 점
    var strBumun         = LC_S_BUMUN.BindColVal;                    // 팀
    var strTeam          = LC_S_TEAM.BindColVal;                     // 파트
    var strPc            = LC_S_PC.BindColVal;                       // PC
    var strOrgCd         = strStrCd + strBumun + strTeam + strPc;    // 조직   
   
    var goTo       = "valCheck" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                   + "&strBumun="+encodeURIComponent(strBumun)     
                   + "&strTeam="+encodeURIComponent(strTeam)      
                   + "&strPc="+encodeURIComponent(strPc)     
                   + "&strOrgCd="+encodeURIComponent(strOrgCd)
                   + "&strEvaluYm="+encodeURIComponent(strEvaluYm); 
    
    TR_S_MAIN.Action  = "/dps/psal702.ps?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue= "SERVLET("+action+":DS_O_VALCHECK=DS_O_VALCHECK)"; //조회는 O
    TR_S_MAIN.Post();
     
     if(DS_O_VALCHECK.CountRow == 0)
    	 return true;
     else
    	 return false;
  }
 
  /**
   * confCheck()
   * 작 성 자 : 김경은
   * 작 성 일 : 2011-06-15
   * 개    요 :  확정여부 체크
   * return값 : void
   */
   function confCheck(strStrCd, strEvaluYm){

      var goTo       = "confCheck" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                     + "&strEvaluYm="+encodeURIComponent(strEvaluYm); 
      
      TR_MAIN.Action  = "/dps/psal702.ps?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_CHECK=DS_O_CHECK)"; //조회는 O
      TR_MAIN.Post();
      
      if(DS_O_CHECK.CountRow == 0)
          return true;
      else
          return false;
   }
  
  /**
   * getAllotScore()
   * 작 성 자 : 김경은
   * 작 성 일 : 2011-06-15
   * 개    요 :  평가배점 가져오기
   * return값 : void
   */
   function getAllotScore(){
       var strStrCd         = LC_S_STR.BindColVal;                      // 점
       var strEvaluYm       = EM_S_EVALU_YM.Text;                       // 평가년월
       
       var goTo       = "getAllotScore" ;    
       var action     = "O";     
       var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                      + "&strEvaluYm="+encodeURIComponent(strEvaluYm); 
       
       TR_MAIN.Action  = "/dps/psal702.ps?goTo="+goTo+parameters;  
       TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_SCORE=DS_O_SCORE)"; //조회는 O
       TR_MAIN.Post();
     
       if(DS_O_SCORE.CountRow > 0)
    	   score = DS_O_SCORE.NameValue(DS_O_SCORE.RowPosition, "ALLOT_SCORE")
       else
    	   score = 0;
    
   	   GR_MASTER.LayoutInfo("ColumnInfo", "ID_J_CNT::<HEADER>::text") = "매장 CS 평가 (평가배점 / "+score+"점)";
       GR_MASTER.LayoutInfo("ColumnInfo", "ID_CNT::<HEADER>::text") = "매장 CS 평가 (평가배점 / "+score+"점)";
       
   }
    	   
 
 /**
  * copy()
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-06-15
  * 개    요        : 전월내역복사
  * return값 : void
  */
 function copy() {
	 //if (!searchFlag){
		//showMessage(QUESTION, OK, "USER-1075", "전월내역복사")
		//return;
	 //}
	 
	 // 복사시 등록된 내역이 있는지 확인한다.
	 if(!checkValidation("Copy"))
	      return;
	  
   
	 var strStrCd         = LC_S_STR.BindColVal;                      // 점
     var strBumun         = LC_S_BUMUN.BindColVal;                    // 팀
     var strTeam          = LC_S_TEAM.BindColVal;                     // 파트
     var strPc            = LC_S_PC.BindColVal;                       // PC
     var strOrgCd         = strStrCd + strBumun + strTeam + strPc;    // 조직   
     var strEvaluYm       = EM_S_EVALU_YM.Text;                       // 평가년월
	  
	 var action     = "I"; 
	 var goTo       = "copy" ;    
	 var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
				    + "&strBumun="+encodeURIComponent(strBumun)     
				    + "&strTeam="+encodeURIComponent(strTeam)      
				    + "&strPc="+encodeURIComponent(strPc)     
				    + "&strOrgCd="+encodeURIComponent(strOrgCd)
				    + "&strEvaluYm="+encodeURIComponent(strEvaluYm); 
	 
     //변경또는 신규 내용을 저장하시겠습니까?
     if( showMessage(QUESTION, YESNO, "USER-1191", "전월내역") == 1 ){    // validation 체크
    	    
   	    TR_S_MAIN.Action  = "/dps/psal702.ps?goTo="+goTo+parameters;  
   	    TR_S_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
   	    TR_S_MAIN.Post();

        btn_Search();
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

    switch (colid) {
    case "EVALU_SCORE":
    	var evaluScore = this.NameValue(row,colid);

    	/*
    	if (!searchFlag){
    		showMessage(QUESTION, OK, "USER-1075", "평가점수 등록/수정")
            break;
        }
    	*/
    	if(score == 0 && evaluScore > score){
    		showMessage(EXCLAMATION, OK, "USER-1195", "매장 C/S평가 배점", "매장등록 및 C/S평가 등록");
    		DS_IO_MASTER.NameValue(row, "EVALU_SCORE") = 0;
    		break;
    	}
    	
        if(evaluScore > score){
        	 showMessage(EXCLAMATION, OK, "USER-1021", "평가점수", score);
             //GR_MASTER.Draw           = false;
             //alert(row+":"+DS_IO_MASTER.NameValue(row, "EVALU_SCORE"));
//             DS_IO_MASTER.NameValue(row, "EVALU_SCORE") = 0;
             //GR_MASTER.Draw           = true;
             setTimeout("GR_MASTER.RowPosition    = "+row+";",50);
             setTimeout("GR_MASTER.ColumnPosition = 'ID_EVALU_SCORE';",50);
//             GR_MASTER.ColumnPosition = "ID_EVALU_SCORE";
             
        break;
        }
    default:
    	break;
    }
   
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
    DS_IO_MASTER.ClearData();
    //searchFlag = false;
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
    
    DS_IO_MASTER.ClearData();
    //searchFlag = false;
    
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
    
    DS_IO_MASTER.ClearData();
    //searchFlag = false;
    
</script>

<!-- PC(조회)  변경시  -->
<script language=JavaScript for=LC_S_PC event=OnSelChange()>
    DS_IO_MASTER.ClearData();
    //searchFlag = false;
</script>

<!-- 평가년월 KillFocus -->
<script language=JavaScript for=EM_S_EVALU_YM event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    DS_IO_MASTER.ClearData();
    //searchFlag = false;
    checkDateTypeYM(EM_S_EVALU_YM);
    getAllotScore();
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
<comment id="_NSID_"><object id="DS_O_LIST"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_VALCHECK"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CHECK"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SCORE"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


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
	            <th class="point">평가년월</th>
	            <td colspan = 7>
	                  <comment id="_NSID_">
	                      <object id=EM_S_EVALU_YM classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
	                      </object>
	                  </comment>
	                  <script> _ws_(_NSID_);</script>
	                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_S_EVALU_YM)"  align="absmiddle"/>
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
         <tr>
            <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/copy_last.gif"
                             hspace="2" onclick="javascript:copy();" /> </td>
         </tr>
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GR_MASTER width=100% height=460 classid=<%=Util.CLSID_MGRID%> tabindex=1>
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

