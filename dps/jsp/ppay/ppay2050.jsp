<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 선지불/보류/공제 > 공제등록
 * 작 성 일 : 2010.05.31
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : ppay2050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 공제등록
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

var strToday        = "";                            // 현재날짜
var strYYYYMM       = "";                            // 현재년월

var roundFlag       = "";                            // 반올림구분
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var rtnVal            = false;
 var intSearchCnt      = 0;                             // 조회버튼클릭 여부(0일 경우 마스터조회 건수)
 var bfListRowPosition = 0;                             // 이전 List Row Position
 var strToday          = "";                            // 현재날짜
 /*************************************************************************
  * 1. 초기설정
  *************************************************************************/

/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-31
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 350;		//해당화면의 동적그리드top위치
 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


     strToday  = getTodayDB("DS_O_RESULT");
     strYYYYMM = strToday.substring(2, 6);

     // Output Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>' );
     DS_IO_DETAIL1.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
     DS_IO_DETAIL2.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
     DS_IO_DETAIL3.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
     DS_O_PAY_CNT.setDataHeader('CODE:STRING(2),NAME:STRING(40)'   );
     DS_SETVAT.setDataHeader   ('<gauce:dataset name="H_SETVAT"/>' );
     
     //그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일
     gridCreate3(); //디테일2
     gridCreate4(); //디테일3
     
     // EMedit에 초기화
     initEmEdit(EM_YYYYMM          ,"THISMN"    ,PK    		 );        // 지불년월
     initEmEdit(EM_SALE_S_DT       ,"YYYYMMDD"  ,READ  		 );        // 매입기간 시작일
     initEmEdit(EM_SALE_E_DT       ,"YYYYMMDD"  ,READ  		 );        // 매입매출기간 종료일
     initEmEdit(EM_S_VEN_CD        ,"000000"    ,NORMAL 	 );        // 협력사코드  
     initEmEdit(EM_S_VEN_NM        ,"GEN"       ,READ  		 );        // 협력사명
     initEmEdit(EM_S_PUMBUN_CD,      "000000",      NORMAL);         // 브랜드코드
     initEmEdit(EM_S_PUMBUN_NM,      "GEN^40",      READ);           // 브랜드명
     
    

     //콤보 초기화
     initComboStyle(LC_STR_CD,DS_IO_STR_CD    			,"CODE^0^30,NAME^0^80"  ,1  ,PK);       // 점(조회)
     initComboStyle(LC_PAY_CYC,DS_O_PAY_CYC  			,"CODE^0^30,NAME^0^80"  ,1  ,PK);       // 지불주기
     initComboStyle(LC_PAY_CNT,DS_O_PAY_CNT  			,"CODE^0^30,NAME^0^80"  ,1  ,PK);       // 지불회차
     initComboStyle(LC_REASON_CD,DS_O_REASON_CD 		,"CODE^0^30,NAME^0^80"  ,1  ,NORMAL);       // 공제구분
         
     
     getStore  ("DS_IO_STR_CD"    ,"Y"   ,""      ,"N" );   
     getEtcCode("DS_O_PAY_CYC"    ,"D"   ,"P052"  ,"N" );         // 조회지불주기
     getEtcCode("DS_O_PAY_CNT"    ,"D"   ,"P407"  ,"N" );         // 조회지불회차
     getEtcCode("DS_I_PAY_CYC"    ,"D"   ,"P052"  ,"N" );         // 지불주기
     getEtcCode("DS_I_PAY_CNT"    ,"D"   ,"P407"  ,"N" );         // 지불회차
     getEtcCode("DS_I_REASON_CD"  ,"D"   ,"P412"  ,"N" );         // 공제
     getEtcCode("DS_O_REASON_CD"  ,"D"   ,"P412"  ,"Y" );         // 공제
     getEtcCode("DS_I_VAT_YN"     ,"D"   ,"P417"  ,"N" );         // VAT여부
     getEtcCode("DS_I_CASH_IN_YN" ,"D"   ,"P419"  ,"N" );         //입금 여부
     getEtcCode("DS_O_PROC_STAT"  ,"D"   ,"P235"  ,"N" );    // 전표확정상태 (Y:확정, N:미확정)

     LC_STR_CD.index  = 0;
     LC_PAY_CYC.index = 0;
     LC_PAY_CNT.index = 0;
     LC_REASON_CD.index = 0; 
     LC_STR_CD.Focus();
 }
 
 
 function gridCreate1(){
	
	     var hdrProperies = '<FC>id={currow}          name="NO"                width=30    Edit=none sumtext="합계"  align=center</FC>'
	    				  + '<FC>id=SEL               name="확정"               width=60    align=center EditStyle=CheckBox   HeadCheckShow="true"  </FC>'/* Edit={IF(CONF_FLAG="N","true","false")} */
	                      + '<FC>id=STR_CD            name="점"                width=80    Edit=none EditStyle=Lookup Data="DS_IO_STR_CD:CODE:NAME" align=center</FC>'
	                      + '<FC>id=PAY_YM            name="지불년월"          width=80    Edit=none Mask="XXXX/XX" align=center</FC>'
	                      + '<FC>id=PAY_CYC           name="지불주기"          width=80    Edit=none EditStyle=Lookup Data="DS_O_PAY_CYC:CODE:NAME" align=center</FC>'
	                      + '<FC>id=PAY_CNT           name="지불회차"          width=80    Edit=none EditStyle=Lookup Data="DS_O_PAY_CNT:CODE:NAME" align=center</FC>'
	                      + '<FC>id=TAX_ISSUE_DT      name="세금계산서발행일"    width=110    Edit=none align=center show=false</FC>'
	                      + '<FC>id=TAX_ISSUE_SEQ_NO  name="순번"              width=40    Edit=none align=center show=false</FC>'
	                      + '<FC>id=VEN_CD            name="협력사코드"        width=70    Edit=none align=left</FC>'
	                      + '<FC>id=VEN_NM            name="협력사명"          width=90    Edit=none align=left</FC>'
	                      + '<FC>id=PUMBUN_CD   	  name="*브랜드코드"         width=70     align=center Edit=none</FC>'
	                      + '<FC>id=PUMBUN_NM    	  name="브랜드명"           width=120     align=left Edit=none</FC>'
	                      + '<FC>id=PAY3              name="선급금금액"        width=95    Edit=none sumtext=@sum align=right</FC>'
	                      + '<FC>id=PAY1              name="보류금액"          width=90    Edit=none sumtext=@sum align=right</FC>'
	                      + '<FC>id=REASON_NAME       name="공제구분"          width=100    Edit=none  align=right</FC>'
	                      + '<FC>id=PAY21             name="공제금액(공제)"     width=90    Edit=none sumtext=@sum align=right</FC>'
	                      + '<FC>id=PAY22             name="공제금액(입금)"     width=90    Edit=none sumtext=@sum align=right</FC>';
	                     // + '<FC>id=CONF_FLAG         name="확정구분"            width=120   align=left   Edit=none show="false"</FC>';
	                      ;
	 
     initGridStyle(GR_MASTER, "common", hdrProperies, true);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}          name="NO"               width=30     Edit=none sumtext="합계" align=center shoe=false</FC>'
                      + '<FC>id=INPUT_DT          name="선급금지불일"      width=80     EditStyle=Popup Mask="XXXX/XX/XX" align=center</FC>'
                      + '<FC>id=SEQ_NO            name="순번"              width=50     Edit=none align=center </FC>'
                      + '<FC>id=REASON_CD         name="선급금코드"        width=70     align=center</FC>'
                      + '<FC>id=REASON_NM         name="선급금명"          width=100    Edit=none align=left</FC>'
                      + '<FC>id=INPUT_AMT         name="선급금금액"        width=80     sumtext=@sum align=rigth</FC>'
                      + '<FC>id=REMARK            name="비고"              width=80     align=left</FC>';
         
     initGridStyle(GR_DETAIL1, "common", hdrProperies, false);
 }

 function gridCreate3(){
     var hdrProperies = '<FC>id={currow}         name="NO"                width=30     Edit=none sumtext="합계" align=center shoe=false</FC>'
			         + '<FC>id=INPUT_DT          name="보류등록일"        width=80     EditStyle=Popup Mask="XXXX/XX/XX" align=center</FC>'
			         + '<FC>id=SEQ_NO            name="순번"              width=50     Edit=none align=center </FC>'
			         + '<FC>id=REASON_CD         name="보류코드"          width=50     align=center</FC>'
			         + '<FC>id=REASON_NM         name="보류명"            width=100    Edit=none align=left</FC>'
			         + '<FC>id=INPUT_AMT         name="보류금액"          width=80     sumtext=@sum align=rigth</FC>'
			         + '<FC>id=REMARK            name="비고"              width=80     align=left</FC>';
     initGridStyle(GR_DETAIL2, "common", hdrProperies, false);
 }

 function gridCreate4(){
     var hdrProperies = '<FC>id={currow}         name="NO"               width=30     Edit=none sumtext="합계" align=center shoe=false</FC>'
			         + '<FC>id=INPUT_DT          name="공제등록일"        width=80     EditStyle=Popup Mask="XXXX/XX/XX" align=center</FC>'
			         + '<FC>id=SEQ_NO            name="순번"             width=50     Edit=none align=center </FC>'
			         + '<FC>id=REASON_CD         name="공제코드"         width=50     align=center</FC>'
                     + '<FC>id=REASON_NM         name="공제명"           width=100    Edit=none align=left</FC>'
                     + '<FC>id=VAT_YN            name="VAT여부"          width=70     align=left</FC>'
                     + '<FC>id=CASH_IN_YN        name="입금여부"          width=70     align=left</FC>'
			         + '<FC>id=INPUT_AMT         name="공제금액"         width=80     sumtext=@sum align=rigth</FC>'
			         + '<FC>id=REMARK            name="비고"             width=80     align=left</FC>';
     initGridStyle(GR_DETAIL3, "common", hdrProperies, false);
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
  * 작 성 자     : 박래형
  * 작 성 일     : 2010-05-31
  * 개    요        : 조회시 필수 조회조건을 체크한 후 조회한다.
  * return값 : void
  */
 function btn_Search() {
      // 변경, 추가내역이 있을 경우
      if (DS_IO_MASTER.IsUpdated){
          if( showMessage(STOPSIGN, YESNO, "USER-1073") != 1 )
             return;
      }
      
      GR_MASTER.ColumnProp('CHECK1','HeadCheck')= "false";
      
      if(checkValidation("Search")){
          DS_IO_MASTER.ClearData();  
          // 조회조건 셋팅
          var strStrCd         = LC_STR_CD.BindColVal;                  // 점
          var strYyyymm        = EM_YYYYMM.Text;                        // 지불년월
          var strPayCyc        = LC_PAY_CYC.BindColVal;                 // 지불주기   
          var strPayCnt        = LC_PAY_CNT.BindColVal;                 // 지불회차
          var strVenCd         = EM_S_VEN_CD.Text;                      // 협력사코드
          var strPumCd         = EM_S_PUMBUN_CD.Text;                   // 브랜드코드
          var strRsCd          = LC_REASON_CD.BindColVal;                 // 공제구분
           
        

          getMaster("DS_IO_MASTER",strStrCd, strYyyymm, strPayCyc, strPayCnt, strVenCd, strPumCd, strRsCd );
          GR_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";
          
          // 조회결과 Return
          setPorcCount("SELECT", GR_MASTER);
          GR_MASTER.SetColumn("SEL");
          GR_MASTER.Focus();
      }
 }

 /**
  * getMaster(strStrCd, strYyyymm, strPayCyc, strPayCnt, strVenCd, strRsCd)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요   : 마스터를 조회한다.
  * return값 : void
  */
function getMaster(dataSet, strStrCd, strYyyymm, strPayCyc, strPayCnt, strVenCd, strPumCd, strRsCd){
	var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strYyyymm="+encodeURIComponent(strYyyymm)    
                    + "&strPayCyc="+encodeURIComponent(strPayCyc)      
                    + "&strPayCnt="+encodeURIComponent(strPayCnt)     
                    + "&strVenCd="+encodeURIComponent(strVenCd)
                    + "&strPumCd="+encodeURIComponent(strPumCd)
                    + "&strRsCd="+encodeURIComponent(strRsCd)
                    ;
    				
    TR_MAIN.Action  = "/dps/ppay205.pp?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER="+dataSet+")"; // 조회는 O
    TR_MAIN.Post();    
}
 
/**
 * btn_New()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-08
 * 개    요 : 신규 추가
 * return값 : void
 */
function btn_New() {
	 
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-31
 * 개    요 : 삭제
 * return값 : void
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-31
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	   
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-08
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-08
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-08
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
	 
	if(!DS_IO_MASTER.IsUpdated){
	       showMessage(INFORMATION, OK, "USER-1002", "변경사항"); 
	       return;
	    }
	if(!confRej())
        return;
        
	btn_Search();      
}
/**
 * confRej()
 * 작 성 자 : 
 * 작 성 일 : 2010-07-12
 * 개    요 : 확정 처리
 * return값 : void
 */
function confRej() {  
	 
	 
	
	 
	if( showMessage(QUESTION, YESNO, "USER-1000", "확정 또는 확정취소 하시겠습니까?") != 1 )
         return;
	 for(var masterChkCnt = 1; masterChkCnt<=DS_IO_MASTER.CountRow; masterChkCnt++){
		
         if(DS_IO_MASTER.NameValue(masterChkCnt,"SEL") == "T"){
        	 
             if(!closeCheck(DS_IO_MASTER.NameValue(masterChkCnt, "SEL"), masterChkCnt)){
                
             }  
         }else{
        	 if(!closeCheck(DS_IO_MASTER.NameValue(masterChkCnt, "SEL"), masterChkCnt)){
        		             
             }
         }
	 }
	
      TR_MAIN.Action="/dps/ppay205.pp?goTo=saveconf&strFlag=saveconf";
      TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
      TR_MAIN.Post();
      
     // 정상 처리일 경우 조회
     if( TR_MAIN.ErrorCode == 0){
         btn_Search();
     }
}
/**
* closeCheck()
* 작 성 자 : 박래형
* 작 성 일 : 2010-03-10
* 개    요    : 저장시 일마감체크를 한다.
* return값 : void
*/
function closeCheck(strChkDt, row){
    var strStrCd         = LC_STR_CD.BindColVal;       // 점 
    var strCloseDt       = EM_YYYYMM.text;             // 마감체크일자
    var strCloseTaskFlag = "PPAY";                 // 업무구분(매입월마감)
    if(LC_PAY_CYC.BindColVal=="1"){
  		 var strCloseUnitFlag = "52";                      // 단위업무(1주기, 1회차 일때 : 52)
   }else if(LC_PAY_CYC.BindColVal=="2" &&LC_PAY_CNT.BindColVal=="1"){ //        (2주기, 1회차 일때 : 53)
  	 	var strCloseUnitFlag = "53";
   }else if(LC_PAY_CYC.BindColVal=="2" &&LC_PAY_CNT.BindColVal=="2"){ //        (2주기, 2회차 일대 : 54)
  		 var strCloseUnitFlag = "54";
   }
    var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
    var strCloseFlag     = "M";                    // 마감구분(월마감:M)
   
    var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                  , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
    
    if(closeFlag == "TRUE"){
        showMessage(INFORMATION, OK, "USER-1220", "매입월");
        setFocusGrid(GR_MASTER, DS_IO_MASTER ,row, "SEL");      // 선택으로 포커스
       
        return false;
    }else{
    	
        return true;
    }
}  


/*************************************************************************
 * 3. 함수
 *************************************************************************/

 
  
   
  function checkValidation(Gubun) {  //행추가시..........    
	   
       var messageCode = "USER-1001";
       
       //조회버튼 클릭시 Validation Check
       if(Gubun == "Search"){   
           if(EM_YYYYMM.Text.length == 0){                                // 지불년월
               showMessage(INFORMATION, OK, "USER-1002", "지불년월");
               EM_YYYYMM.Focus();
               return false;
           }
       }
       
       // 저장버튼 클릭시 Validation Check
       if(Gubun == "Save"){          
           var intRowCount   = DS_IO_MASTER.CountRow;
           var strStrCd      = "";                     // 점
           var strPayYm      = "";                     // 지불년월        
           var strPayCyc     = "";                     // 지불주기
           var strPayCnt     = "";                     // 지불회차 
           var strIssueSdt   = "";                     // 시작일자
           var strIssueEdt   = "";                     // 종료일자
           var intInputAmt   = "";                     // 종료일자
           var strPayVenCd   = "";
           
           if(intRowCount > 0){
               for(var i=1; i <= intRowCount; i++){
                   
            	   strRowStatus = DS_IO_MASTER.RowStatus(i);               //신규, 수정 구분값            	   
            	   strStrCd     = DS_IO_MASTER.NameValue(i, "STR_CD");
            	   strPayYm     = DS_IO_MASTER.NameValue(i, "PAY_YM");
            	   strPayCyc    = DS_IO_MASTER.NameValue(i, "PAY_CYC");
                   strPayCnt    = DS_IO_MASTER.NameValue(i, "PAY_CNT");
                   strVenCd     = DS_IO_MASTER.NameValue(i, "VEN_CD");
                   strPayVenCd  = DS_IO_MASTER.NameValue(i, "DED_VEN_CD");
                   strPumCd     = DS_IO_MASTER.NameValue(i, "PUMBUN_CD");
                   strReasonCd  = DS_IO_MASTER.NameValue(i, "REASON_CD");
                   intInputAmt  = DS_IO_MASTER.NameValue(i, "INPUT_AMT");
                   
            	   if(strStrCd.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "점");
                       GR_MASTER.SetColumn("STR_CD");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
            	   
            	   if(strPayYm.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "지불년월");
                       GR_MASTER.SetColumn("PAY_YM");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
            	   
                   if(strPayCyc.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "지불주기");
                       GR_MASTER.SetColumn("PAY_CYC");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   if(strPayCnt.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "지불회차");
                       GR_MASTER.SetColumn("PAY_CNT");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   if(!checkVenCd(i)){
                       showMessage(INFORMATION, OK, "USER-1003", "협력사");
                       GR_MASTER.SetColumn("VEN_CD");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   if(!checkVenCd(i)){
                       showMessage(INFORMATION, OK, "USER-1003", "지불협력사");
                       GR_MASTER.SetColumn("DED_VEN_CD");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   
                   if(strReasonCd.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "공제");
                       GR_MASTER.SetColumn("REASON_CD");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }        
                   
                   if(intInputAmt <= 0){
                       showMessage(EXCLAMATION, OK, "USER-1008", "입력금액",  "0");
                       GR_MASTER.SetColumn("INPUT_AMT");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }    
                   
                   // 신규와 수정일때를 구분한다.
                   if(strRowStatus == "1"){        //신규일때
                       if(!checkKeyVlaue(i)){
                           showMessage(INFORMATION, OK, "USER-1044", "KEY값");
                           DS_IO_MASTER.RowPosition = i;  
                           DS_IO_MASTER.NameValue(i,"SEL") = "T";
                           GR_MASTER.SetColumn("SEL");
                           return false;
                       }
                   
                       if(!closeCheck(i, strPayCyc, strPayCnt)){    //마감체크
                           DS_IO_MASTER.NameValue(i,"SEL") = "T";
                           GR_MASTER.SetColumn("SEL");
                           return false;
                       }    
                       
                   }else if(strRowStatus == "3"){  //수정일때
                       if(!closeCheck(i, strPayCyc, strPayCnt)){    //마감체크
                           DS_IO_MASTER.NameValue(i,"SEL") = "T";
                           GR_MASTER.SetColumn("SEL");
                           return false;
                       }    
                   }  
                   
/*                
                   if(!checkKeyVlaue(i)){
                       showMessage(INFORMATION, OK, "USER-1044", "KEY값");
                       GR_MASTER.SetColumn("REASON_CD");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   
                   // 중복체크
                   var dupRow = checkDupKey(DS_IO_MASTER, "KEY");
                   if (dupRow > 0) {
                       showMessage(StopSign, Ok,  "USER-1044", dupRow);
          
                       DS_IO_MASTER.RowPosition = dupRow;
                       //DS_IO_MASTER.NameValue(dupRow,"SEL") = "T";
                       GR_MASTER.SetColumn("SEL");
                       GR_MASTER.Focus(); 

                       return false;
                   }
*/                  
/*                   
                   // 등록된 발행기간이 있는지 조회한다.      
                   if(DS_IO_MASTER.RowStatus(i) == "1"){
	                   getMaster("DS_O_VAL_CHECK", strStrCd, strPayYm, strPayCyc, strPayCnt, "", "");
	                   if(DS_O_VAL_CHECK.CountRow > 0){
	                	   showMessage(StopSign, Ok,  "USER-1044", i);
	                	   return false;
	                   }
                   }
*/
               }
           }
       }
       return true; 
  }

   
  /**
   * getDetail()
   * 작 성 자 : 김경은
   * 작 성 일 : 2010-05-03
   * 개    요 :  상세조회
   * return값 : void
   */
   function getDetail(){
      // 조회조건 셋팅
      var strStrCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");   // 점
      var strYyyymm  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_YM");   // 매입년월
      var strPayCyc  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_CYC");  // 지불주기
      var strPayCnt  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_CNT");  // 지불회차
      var strVenCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");   // 협력사코드
      var strPumCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");   // 브랜드코드
      var strRsCd    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REASON_CD");   // 공제 구분

      var goTo         = "getDetail" ;    
      var action       = "O";     
      var parameters   =  "&strStrCd="+encodeURIComponent(strStrCd)
  				     +  "&strYyyymm="+encodeURIComponent(strYyyymm)
  				     +  "&strPayCyc="+encodeURIComponent(strPayCyc)
  				     +  "&strPayCnt="+encodeURIComponent(strPayCnt)
  				     +  "&strVenCd="+encodeURIComponent(strVenCd)
  				   	 +  "&strPumCd="+encodeURIComponent(strPumCd)
  				   	 +  "&strRsCd="+encodeURIComponent(strRsCd)
  				   	 ;
      
      TR_DETAIL.Action="/dps/ppay205.pp?goTo="+goTo+parameters;  
      TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL1=DS_IO_DETAIL1,"
                                   +action+":DS_IO_DETAIL2=DS_IO_DETAIL2,"
                                   +action+":DS_IO_DETAIL3=DS_IO_DETAIL3)"; //조회는 O
      TR_DETAIL.Post();
   }

   /**
    * getVenInfo(code, name, btnFlag)
    * 작 성 자 : 김경은
    * 작 성 일 : 2010-05-31
    * 개    요 :  브랜드에 따른 협력사 팝업
    * return값 : void
    */
   function getVenInfo(code, name, btnFlag){
       var strStrCd        = LC_STR_CD.BindColVal;  
       var strUseYn        = "Y";                             // 사용여부
       var strPumBunType   = "";                              // 브랜드유형
       var strBizType      = "";                              // 거래형태
       var strMcMiGbn      = "";                              // 매출처/매입처구분
       var strBizFlag      = "";                              // 거래구분
      
       if(!btnFlag){
           var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                   ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                   ,strBizFlag);
       }else{
//           alert("btnFlag = " + btnFlag);
           var rtnMap = venPop(code, name
                              ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                              ,strBizFlag);
       }
   }

   /**
    * getPopGridVenInfo()
    * 작 성 자 : 김경은
    * 작 성 일 : 2010-05-31
    * 개    요 :  그리드협력사 팝업
    * return값 : void
    */
   function getPopGridVenInfo(strVenCd, strVenNm){
       var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");   // 점
       var strUseYn        = "Y";                                                          // 사용여부
       var strPumBunType   = "";                                                           // 브랜드유형
       var strBizType      = "";                                                           // 거래형태
       var strMcMiGbn      = "";                                                           // 매출처/매입처구분
       var strBizFlag      = "";                                                           // 거래구분

       var rtnMap = venToGridPop(strVenCd, ''
                            ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                            ,strBizFlag);
       if(rtnMap != null){
           DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD") = rtnMap.get("VEN_CD");
           DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM") = rtnMap.get("VEN_NAME");
           return true;
       }else{ 
           return false;
       }
   }

   /** 그리드협력사 넌팝업
    * getNonPopGridVenInfo(code, name)
    * 작 성 자 : 김경은
    * 작 성 일 : 2010-05-31
    * 개    요 :  그리드협력사  넌팝업
    * return값 : void
    */
   function getNonPopGridVenInfo(){
       
       var strVenCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
       var strVenNm        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM");
       var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");    // 점
       var strUseYn        = "Y";                                                           // 사용여부
       var strPumBunType   = "";                                                            // 브랜드유형
       var strBizType      = "";                                                            // 거래형태
       var strMcMiGbn      = "";                                                            // 매출처/매입처구분
       var strBizFlag      = "";                                                            // 거래구분

       var rtnMap = setVenNmWithoutToGridPop( "DS_O_RESULT", strVenCd, '', "1"
                                           ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                           ,strBizFlag);
       if(rtnMap != null){
           DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD") = rtnMap.get("VEN_CD");
           DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM") = rtnMap.get("VEN_NAME"); 
           return true;
       }else{
           DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD") = "";    
           DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM") = "";
           return false;
       }      
  }

   /**
    * searchPumbunPop()
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-18
    * 개    요 :  조회조건 브랜드팝업
    * return값 : void
    */
    function searchPumbunPop(){
        var tmpOrgCd        = LC_STR_CD.BindColVal;
        var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
        var strStrCd        = LC_STR_CD.BindColVal;                                      // 점
        var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
        var strVenCd        = EM_S_VEN_CD.Text;                                            // 협력사
        var strBuyerCd      = "";                                                        // 바이어
        var strPumbunType   = "";                                                        // 브랜드유형
        var strUseYn        = "Y";                                                       // 사용여부
        var strSkuFlag      = "";                                                        // 단품구분
        var strSkuType      = "";                                                        // 단품종류(1:규격단품)
        var strItgOrdFlag   = "";                                                        // 통합발주여부
        var strBizType      = "";                                                       // 거래형태(2:특정) 
        var strSaleBuyFlag  = "";                                                        // 판매분매입구분


        var rtnMap = strPbnPop( EM_S_PUMBUN_CD, EM_S_PUMBUN_NM, 'Y'
                               , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                               , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                               , strBizType,strSaleBuyFlag);
        if(rtnMap != null){
            return true;
        }else{
            return false;
        }
    }

    /**
     * searchPumbunNonPop()
     * 작 성 자 : 박래형
     * 작 성 일 : 2010-03-18
     * 개    요 :  조회조건 브랜드팝업
     * return값 : void
     */
     function searchPumbunNonPop(){
         var tmpOrgCd        = LC_STR_CD.BindColVal;
         var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
         var strStrCd        = LC_STR_CD.BindColVal;                                    // 점
         var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
         var strVenCd        = EM_S_VEN_CD.Text;                                          // 협력사
         var strBuyerCd      = "";                                                        // 바이어
         var strPumbunType   = "";                                                        // 브랜드유형
         var strUseYn        = "Y";                                                       // 사용여부
         var strSkuFlag      = "";                                                        // 단품구분
         var strSkuType      = "";                                                        // 단품종류(1:규격단품)
         var strItgOrdFlag   = "";                                                        // 통합발주여부
         var strBizType      = "";                                                       // 거래형태(2:특정) 
         var strSaleBuyFlag  = "";                                                        // 판매분매입구분


         var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PUMBUN_CD, EM_S_PUMBUN_NM, "Y", "1"
                                , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                , strBizType,strSaleBuyFlag);           

         if(rtnMap != null){
             return true;
         }else{
             return false;
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
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--  ===================DS_IO_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid); 
</script>
<script language=JavaScript for=GR_DETAIL1 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GR_DETAIL2 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GR_DETAIL3 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
	var strStrCd  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
	var strPayYm  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_YM");
	var strPayCyc = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_CYC");
	var strPayCnt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_CNT");
	var strRsCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REASON_CD");
//	var strKey    = strStrCd + strPayYm + strPayCyc + strPayCnt;
//	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"KEY") = strKey;

    switch (colid) {
    
    case "PAY_YM":
        getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt, strRsCd);
        DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE"); 
    	break;
    	
    case "PAY_CYC":
        if(strPayCyc == "1"){
        	DS_IO_MASTER.NameValue(row,"PAY_CNT") = "";
            getEtcCode("DS_I_PAY_CNT", "D", "P407", "N");         // 지불회차
            getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt, strRsCd);
            DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");       
            
        }else if(strPayCyc == "2"){
            DS_IO_MASTER.NameValue(row,"PAY_CNT") = "";
            getEtcCode("DS_I_PAY_CNT", "D", "P408", "N");         // 지불회차
            getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt, strRsCd);
            DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");    
            
        }else if(strPayCyc == "3"){
            DS_IO_MASTER.NameValue(row,"PAY_CNT") = "";
            getEtcCode("DS_I_PAY_CNT", "D", "P409", "N");         // 지불회차
            getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt, strRsCd);
            DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");        
        }
        break;
            
    case "PAY_CNT":
    	getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt, strRsCd);
    	DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
        break;
        
    case "REASON_CD":
    	setVatXYN(row);   
        break;
        
    case "VAT_YN":
        calcAmt(row);
        break;
        
    case "INPUT_AMT":
        calcAmt(row);
        break;
    }

</script>

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
	if(clickSORT)
	    return;

    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        getDetail();
        if(intSearchCnt == 0){
            // 조회결과 Return
            setPorcCount("SELECT", GR_MASTER);
            intSearchCnt++;
        }else
            setPorcCount("SELECT", DS_IO_DETAIL1.CountRow);

    }

</script>
<script language=JavaScript for=DS_IO_DETAIL1 event=onRowPosChanged(row)>
    if(clickSORT)
        return;
</script>
<script language=JavaScript for=DS_IO_DETAIL2 event=onRowPosChanged(row)>
    if(clickSORT)
        return;
</script>
<script language=JavaScript for=DS_IO_DETAIL3 event=onRowPosChanged(row)>
    if(clickSORT)
        return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 마스터 그리드 헤더 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_MASTER event="OnHeadCheckClick(Col,Colid,bCheck)">
    if (Colid == "SEL") {
        if (bCheck == 1) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_IO_MASTER.CountRow; i++)
            {
            	DS_IO_MASTER.NameValue(i + 1, "SEL") = "T";
            }    
            GR_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_IO_MASTER.CountRow; i++)
            {
            	DS_IO_MASTER.NameValue(i + 1, "SEL") = "F";
            } 
            GR_MASTER.Redraw = true;
        }
    }
</script>

<!-- GR_MASTER 데이터변경  -->
<script language=JavaScript for=GR_MASTER event=CanColumnPosChange(row,colid)>
/* 
    if(row < 1)
        return true;
    
    switch(colid){
    
    case "STR_CD":
        if(DS_IO_MASTER.NameValue(row, "STR_CD") == ""){
            showMessage(EXCLAMATION, OK, "USER-1003", "점");
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            GR_MASTER.SetColumn("STR_CD");
            GR_MASTER.Focus();
            return false;
        }else{
            return true;
        }
        break;
        
    case "PAY_YM":
//        if(DS_IO_MASTER.NameValue(row, "PAY_YM") == "")
//            return true;
        if(!checkDateTypeYM(this,colid,'')){
            showMessage(EXCLAMATION, OK, "USER-1003", "지불년월");
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            GR_MASTER.SetColumn("PAY_YM");
            GR_MASTER.Focus();
            return false;        	
        }else{
            return true;   
        }
        break;
        
    case "PAY_CYC":
        if(DS_IO_MASTER.NameValue(row, "PAY_CYC") == ""){
            showMessage(EXCLAMATION, OK, "USER-1003", "지불주기");
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            GR_MASTER.SetColumn("PAY_CYC");
            GR_MASTER.Focus();
            return false;
        }else{
            return true;
        }
        break;
        
    case "PAY_CNT":
        if(DS_IO_MASTER.NameValue(row, "PAY_CNT") == ""){
            showMessage(EXCLAMATION, OK, "USER-1003", "지불회차");
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            GR_MASTER.SetColumn("PAY_CNT");
            GR_MASTER.Focus();
            return false;
        }else{
            return true;
        }
        break;
        
    case "VEN_CD":
        if(!checkVenCd(row)){
            showMessage(EXCLAMATION, OK, "USER-1003", "협력사코드");
            DS_IO_MASTER.NameValue(row, "VEN_NM") = "";
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            GR_MASTER.SetColumn("VEN_CD");
            GR_MASTER.Focus();
            return false;           
        }
    	break; */
/*    	
    case "INPUT_AMT":
        if(DS_IO_MASTER.NameValue(row, "INPUT_AMT") == ""){
            showMessage(EXCLAMATION, OK, "USER-1003", "입력금액");
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            GR_MASTER.SetColumn("INPUT_AMT");
            GR_MASTER.Focus();
            return false;
        }else{
            return true;
        }
        break;

  }*/
</script>


<!-- GR_MASTER OnPopup event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnPopup(row,colid,data)>
	
    switch(colid){
    
    case "PAY_YM":    	
    	openCal(GR_MASTER,row,colid,'M');
        break;
       
    case "VEN_CD":
        var strVenCd = DS_IO_MASTER.NameValue(row, "VEN_CD");
        var strVenNm = DS_IO_MASTER.NameValue(row, "VEN_NM");
        var check=1;
    	getPopGridVenInfo(strVenCd, strVenNm, check);
    	break;
    	
    case "PUMBUN_CD":
        var strPumCd = DS_IO_MASTER.NameValue(row, "PUMBUN_CD");
        var strPumNm = DS_IO_MASTER.NameValue(row, "PUMBUN_NM");
    	getPopGridPumInfo(strPumCd, strPumNm);
    	break;
    	
    case "DED_VEN_CD":
        var strVenCd = DS_IO_MASTER.NameValue(row, "DED_VEN_CD");
        var strVenNm = DS_IO_MASTER.NameValue(row, "DED_VEN_NM");
        var check=2;
    	getPopGridVenInfo(strVenCd, strVenNm, check); 
    	break;
    
    }
</script>


<!-- 지불년월 KillFocus -->
<script language=JavaScript for=EM_YYYYMM event=onKillFocus()>

    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    checkDateTypeYM(EM_YYYYMM);
    EM_SALE_S_DT.Text = "";
    EM_SALE_E_DT.Text = "";
    getSaleDate("DS_O_SALE_DATE", EM_YYYYMM.Text, LC_PAY_CYC.BindColVal, LC_PAY_CNT.BindColVal);
    EM_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");

</script>


<!-- 지불주기 변경시  -->

<script language=JavaScript for=LC_PAY_CYC event=OnSelChange()>
	
	EM_SALE_S_DT.Text = "";
	EM_SALE_E_DT.Text = "";
	
	DS_O_PAY_CNT.ClearData();
	
    if(LC_PAY_CYC.BindColVal == "%")
    	
	    insComboData(LC_PAY_CNT, "%", "전체",1);
    else if(LC_PAY_CYC.BindColVal == "1")
	    getEtcCode("DS_O_PAY_CNT", "D", "P407", "N");         // 지불회차
	else if(LC_PAY_CYC.BindColVal == "2")
		getEtcCode("DS_O_PAY_CNT", "D", "P408", "N");         // 지불회차
	else if(LC_PAY_CYC.BindColVal == "3")
		getEtcCode("DS_O_PAY_CNT", "D", "P409", "N");         // 지불회차
		
	LC_PAY_CNT.index = 0;
		   
</script>

<!-- 지불회차 변경시  -->
<script language=JavaScript for=LC_PAY_CNT event=OnSelChange()>

	EM_SALE_S_DT.Text = "";
	EM_SALE_E_DT.Text = "";

    getSaleDate("DS_O_SALE_DATE", EM_YYYYMM.Text, LC_PAY_CYC.BindColVal, LC_PAY_CNT.BindColVal);
    EM_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
	
</script>


	
</script>
<!-- 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>

    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return
        
    if(EM_S_VEN_CD.Text != ""){
    	   	
        getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, false);        
    }
    else{
        EM_S_VEN_NM.Text = "";
    }
    
    
</script>

<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PUMBUN_CD event=onKillFocus()>

    if(EM_S_PUMBUN_CD.Text != ""){
        searchPumbunNonPop();
    }else
        EM_S_PUMBUN_NM.Text = "";  
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>



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
<comment id="_NSID_"><object id="DS_I_PAY_CYC"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PAY_CNT"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SETVAT"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CASH_IN_YN"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_STR_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CYC"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CNT"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_REASON_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_VAL_CHECK"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_REASON_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_VAT_YN"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL1"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL2"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL3"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PROC_STAT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
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
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
 
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
	            <td width="110">
		            <comment id="_NSID_">
		                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
		                </object>
		            </comment><script>_ws_(_NSID_);</script>
	            </td>
            <th width="80" class="point">지불년월</th>
            <td width="110">
                  <comment id="_NSID_">
                      <object id=EM_YYYYMM classid=<%=Util.CLSID_EMEDIT%>  width=75 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:javascript:openCal('M',EM_YYYYMM)"  align="absmiddle"/>
            </td>
            <th class="point" width="80">지불주기</th>
            <td width="110">
                    <comment id="_NSID_">
                        <object id=LC_PAY_CYC classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th class="point" width="80">지불회차</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_PAY_CNT classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1  align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
         
          <tr>
            <th>매입매출기간</th>
            <td colspan="3">
                  <comment id="_NSID_">
                      <object id=EM_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  ~
                  <comment id="_NSID_">
                      <object id=EM_SALE_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
            
            </td>
            <th>공제구분</th>
            <td colspan="3">
            	    <comment id="_NSID_">
                        <object id=LC_REASON_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1  align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
           </tr>
           <tr>
             <th>협력사</th>
             <td colspan="3">
               <comment id="_NSID_"> 
                   <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"> </object> 
               </comment><script> _ws_(_NSID_);</script>
               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, true);" />
               <comment id="_NSID_"> 
                   <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle" > </object> 
               </comment><script>_ws_(_NSID_);</script>              
             </td> 
             <th>브랜드</th>
             <td colspan="3">
               <comment id="_NSID_"> 
                   <object id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"> </object> 
               </comment><script> _ws_(_NSID_);</script>
               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop();"  />
               <comment id="_NSID_"> 
                   <object id=EM_S_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=186 tabindex=1 align="absmiddle" > </object> 
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
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
          <tr>
            <td width="100%">
                <comment id="_NSID_">
                    <OBJECT id=GR_MASTER width=100% height=300 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_IO_MASTER">
                    </OBJECT>
                </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
   <tr valign="top" align="">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr valign="top">
            <td width="270" class="BD4A">
	            <comment id="_NSID_">
	                <OBJECT id=GR_DETAIL1 width=100% height=156 classid=<%=Util.CLSID_GRID%>>
	                    <param name="DataID" value="DS_IO_DETAIL1">
	                    <Param Name="ViewSummary"   value="1" >
	                </OBJECT>
	            </comment><script>_ws_(_NSID_);</script>
            </td>
            <td width="3">
            </td>
            <td width="270" class="BD4A">
	                <comment id="_NSID_">
	                    <OBJECT id=GR_DETAIL2 width=100% height=156 classid=<%=Util.CLSID_GRID%>>
	                        <param name="DataID" value="DS_IO_DETAIL2">
	                        <Param Name="ViewSummary"   value="1" >
	                    </OBJECT>
	                </comment><script>_ws_(_NSID_);</script>
            </td>
            <td width="3">
            </td>
            <td class="BD4A">
	            <comment id="_NSID_">
	                <OBJECT id=GR_DETAIL3 width=100% height=156 width=100% classid=<%=Util.CLSID_GRID%>>
	                    <param name="DataID" value="DS_IO_DETAIL3">
	                    <Param Name="ViewSummary"   value="1" >
	                </OBJECT>
	            </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table>
    </td>
  </tr>
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            
        <c>Col=SLIP_NO             Ctrl=EM_O_SLIP_NO               param=Text</c>
        <c>Col=SLIP_PROC_STAT_NM   Ctrl=EM_O_SLIP_PROC_STAT_NM     param=Text</c>
        
        <c>Col=PUMBUN_CD        Ctrl=EM_I_PB_CD     param=Text</c>
        <c>Col=PUMBUN_NM        Ctrl=EM_I_PB_NM     param=Text</c>        
        <c>Col=VEN_CD           Ctrl=EM_O_HRS_CD    param=Text</c>
        <c>Col=VEN_NM           Ctrl=EM_O_HRS_NM    param=Text</c>
        <c>Col=ORD_OWN_FLAG_NM  Ctrl=EM_O_BALJUJC   param=Text</c>
        <c>Col=ORD_DT           Ctrl=EM_I_BJDATE    param=Text</c>
        <c>Col=DELI_DT          Ctrl=EM_I_NPYJDATE  param=Text</c>
        <c>Col=ORD_CF_DT        Ctrl=EM_I_BJHJDATE  param=Text</c>
        <c>Col=MG_APP_DT        Ctrl=EM_I_MAJINDATE param=Text</c>
        <c>Col=BUYER_CD         Ctrl=EM_O_BUYER_CD  param=Text</c>
        <c>Col=BUYER_NM         Ctrl=EM_O_BUYER_NM  param=Text</c>
        <c>Col=TAX_FLAG_NM      Ctrl=EM_O_GS_GBN    param=Text</c>
        <c>Col=TAX_FLAG         Ctrl=EM_TAX_FLAG    param=Text</c>
        <c>Col=REMARK           Ctrl=EM_O_ETC       param=Text</c>
        <c>Col=ORD_TOT_QTY      Ctrl=EM_O_SRG       param=Text</c>
        <c>Col=NEW_COST_TAMT    Ctrl=EM_O_WGG       param=Text</c>
        <c>Col=NEW_SALE_TAMT    Ctrl=EM_O_MGG       param=Text</c>     
        <c>Col=MG_RATE          Ctrl=EM_O_MG_RATE   param=Text</c>  
        
        <c>Col=STR_CD           Ctrl=LC_I_STORE     param=BindColVal</c>   
        <c>Col=AFT_ORD_FLAG     Ctrl=LC_I_SH_GBN    param=BindColVal</c>
        <c>Col=EVENT_FLAG       Ctrl=LC_I_HS_GBN    param=BindColVal</c>
        <c>Col=EVENT_RATE       Ctrl=LC_I_HS_RATE   param=BindColVal</c>
        <c>Col=SLIP_FLAG        Ctrl=RD_SLIP_FLAG   param=CodeValue</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

