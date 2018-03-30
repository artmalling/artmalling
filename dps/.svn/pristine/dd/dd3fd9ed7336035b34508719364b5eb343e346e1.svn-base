<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 협력사 평가
 * 작 성 일 : 2011.06.13
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : psal7010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 평가항목배점관리
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
 * 작 성 일 : 2011-06-13
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){

     strToday = getTodayDB("DS_O_RESULT");
     
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_LIST"/>');
     DS_O_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');
     DS_O_CHECK.setDataHeader('<gauce:dataset name="H_CHECK"/>');
     // Output Data Set Header 초기화
     

     //그리드 초기화
     gridCreate1(); //마스터
     
     // EMedit에 초기화
     initEmEdit(EM_S_EVALU_YM         ,"THISMN"        ,PK);             // 평가년월
     initEmEdit(EM_EVALU_YM           ,"0000/00"       ,READ);           // 평가년월
                               
     initEmEdit(EM_STR_CD             ,"GEN"           ,READ);           // 점코드
     initEmEdit(EM_STR_NM             ,"GEN"           ,READ);           // 점명
//     initEmEdit(LC_VEN_EVALU_CD       ,"00"            ,PK);             // 평가항목
//     initEmEdit(EM_VEN_EVALU_NAME     ,"GEN^40"        ,PK);             // 평가항목명
     initEmEdit(EM_ALLOT_SCORE        ,"NUMBER^2^0"    ,NORMAL);         // 배점
     initTxtAreaEdit(TA_ALLOC_BASE    , NORMAL);                         // 점수부여기준
     

     // 콤보 초기화(조회조건)
     initComboStyle(LC_VEN_EVALU_CD   , DS_O_EVALU     ,"CODE^0^30,NAME^0^80", 1, PK);        // 평가항목    

     initComboStyle(LC_S_STR_CD       , DS_O_STR_CD    ,"CODE^0^30,NAME^0^80", 1, PK);        // 점(조회)
    
     getStore("DS_O_STR_CD", "Y", "", "N"); 
     getEtcCode("DS_O_EVALU",    "D", "P604", "N");       // 평가항목
     
     LC_S_STR_CD.index = 0;
     LC_S_STR_CD.Focus(); 
 
     setMasterObject(false, false);
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}          name="NO"             width=30    align=center</FC>'
                      + '<FC>id=VEN_EVALU_CD      name="평가항목"        width=60    Edit=none align=center sumtext="합계"</FC>'
                      + '<FC>id=VEN_EVALU_NAME    name="평가항목명"      width=115   Edit=none align=left</FC>'
                      + '<FC>id=ALLOT_SCORE       name="배점"            width=35    Edit=none align=rigth sumtext=@sum</FC>';
                      
     initGridStyle(GR_LIST, "common", hdrProperies, true);
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
 * 작 성 일 : 2011-06-13
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	// 변경, 추가내역이 있을 경우
    if (DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
           return;
    }
	
	 if(checkValidation("Search")){
		 DS_IO_MASTER.ClearData();  
	     intSearchCnt = 0;
	     bfListRowPosition = 0;
	     getList();
	     searchFlag = true;
	     // 조회결과 Return
	     setPorcCount("SELECT", GR_LIST);
	 }
}

/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-06-13
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	if (!searchFlag){
        showMessage(QUESTION, YESNO, "USER-1075", "신규등록")
         return;
    }
    
    // 전표마스터 추가후 행추가, 삭제 버튼 활성화 (저장되지 않은 내용이 있을경우 추가되지 않음)
    if(DS_IO_MASTER.IsUpdated){
          if(showMessage(QUESTION, YESNO, "USER-1072") != 1 ){
              setMasterObject(true, true);
              return;
          }else{
              DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
          }
    }
    
    DS_IO_MASTER.ClearData(); 
    DS_O_LIST.Addrow(); 
    DS_IO_MASTER.Addrow(); 

    var idx;
    if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1){        // 신규입력일 경우만 체크
    	EM_STR_CD.Text        = LC_S_STR_CD.BindColVal;
    	EM_STR_NM.Text        = LC_S_STR_CD.Text;
	    EM_EVALU_YM.Text      = EM_S_EVALU_YM.Text;  
    }
    
    setMasterObject(true, true);
    LC_VEN_EVALU_CD.Focus();
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-06-13
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
       
        TR_MAIN.Action="/dps/psal701.ps?goTo=delete&strFlag=delete"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_O_LIST=DS_O_LIST)"; //조회는 O
        TR_MAIN.Post();
        
        btn_Search();
    }
}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2011-06-13
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
     
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
        TR_MAIN.Action="/dps/psal701.ps?goTo=save&strFlag=save"; 
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
 * 작 성 일 : 2011-04-25
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
  * 작 성 일     : 2011-06-13
  * 개    요        : 마스터 Object의 활성화/비활성화를 제어한다.
  * return값 : void
  */
 function setMasterObject(flag, upFlag){
	 enableControl(LC_VEN_EVALU_CD  , upFlag);
	 enableControl(EM_ALLOT_SCORE   , flag);
	 //TA_ALLOC_BASE.Enable           = flag;
	 
	 if(flag == false)
		 TA_ALLOC_BASE.ReadOnly = true;
	 else
		 TA_ALLOC_BASE.ReadOnly = false;
 }  
 
  /**
  * getList()
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-06-13
  * 개    요 :  리스트  조회
  * return값 : void
  */
  function getList(){
     // 조회조건 셋팅
     var strStrCd      = LC_S_STR_CD.BindColVal;                    // 점
     var strEvaluYm    = EM_S_EVALU_YM.Text;                        // 평가년월

     var goTo       = "getList" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                    + "&strEvaluYm="+encodeURIComponent(strEvaluYm); 
     
     TR_MAIN.Action  = "/dps/psal701.ps?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_LIST=DS_O_LIST)"; //조회는 O
     TR_MAIN.Post();
 
  }
  
 /**
 * getMaster()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-06-13
 * 개    요 :  마스터  조회
 * return값 : void
 */
 function getMaster(){
    var strVenCd = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "VEN_CD");

    // 조회조건 셋팅
    var strStrCd      = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "STR_CD");           // 점
    var strEvaluYm    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "EVALU_YM");         // 평가년월
    var strVenEvaluCd = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "VEN_EVALU_CD");     // 평가항목

    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                   + "&strEvaluYm="+encodeURIComponent(strEvaluYm)   
                   + "&strVenEvaluCd="+encodeURIComponent(strVenEvaluCd); 
    
    TR_S_MAIN.Action  = "/dps/psal701.ps?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_S_MAIN.Post();
 }

 /**
  * checkValidation()
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-06-13
  * 개    요        :  값 체크 
  * return값 : void
  */
 function checkValidation(Gubun) {
 
	  var strStrCd      = LC_S_STR_CD.BindColVal;                               // 점
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
	      if(LC_VEN_EVALU_CD.BindColVal == "" ){                                    // 평가항목코드
	          showMessage(EXCLAMATION, OK, "USER-1003", "평가항목");
	          LC_VEN_EVALU_CD.Focus();
	          return false;
	      } 
     
	      if( !checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "ALLOC_BASE", "점수부여기준", "TA_ALLOC_BASE") )  // 점수부여기준
	             return false;
	      
	      DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"VEN_EVALU_CD")   = LC_VEN_EVALU_CD.BindColVal;
	      DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"VEN_EVALU_NAME") = LC_VEN_EVALU_CD.Text;
	      DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"ALLOT_SCORE")    = EM_ALLOT_SCORE.Text;
	      
	      var dupRow = checkDupKey(DS_O_LIST, "VEN_EVALU_CD");
          if (dupRow > 0) {
              showMessage(EXCLAMATION, OK,  "USER-1044", dupRow);
              //DS_IO_DETAIL.NameValue( dupRow, "SKU_CD")  = "";
              
              DS_O_LIST.RowPosition = dupRow;
              GR_LIST.Focus(); 

              return false;
          }
          
	      var totScore = DS_O_LIST.Sum(6,0,0);
	      if(totScore > 100){
	    	  showMessage(EXCLAMATION, OK, "USER-1021","배점합계","100");
              return false;
	      }
	    	  
	      if(!confCheck(strStrCd, strEvaluYm)){                              // 확정여부확인
              showMessage(EXCLAMATION, OK, "USER-1194","등록/수정 ");
              return false;
          }
      }
      
      // 전월내역복사 클릭시 Validation Check
      if(Gubun == "Copy"){

	   	  if(!confCheck(strStrCd, strEvaluYm)){                              // 확정여부확인
	          showMessage(EXCLAMATION, OK, "USER-1194","복사");
	          return false;
	      }
	   	      
   	      if(!copyValCheck(strStrCd, strEvaluYm)){                  // 등록할 평가년월이 등록되어있는지 확인한다.
        	  showMessage(EXCLAMATION, OK, "USER-1192");
        	  return false;
          }
	   	  
   	      if(copyValCheck(strStrCd, strPreEvaluYm)){               // 전월등록된 내역이 있는지 확인한다.
	          showMessage(EXCLAMATION, OK, "USER-1193");
	          return false;
	      }
      }
      
      // 삭제버튼 클릭시 Validation Check
      if(Gubun == "Delete"){     
    	  if(DS_O_LIST.RowStatus(DS_O_LIST.RowPosition) != 1){
	    	  if(!confCheck(strStrCd, strEvaluYm)){                              // 확정여부확인
	              showMessage(EXCLAMATION, OK, "USER-1194","삭제");
	              return false;
	          }
    	  }
      }
      return true;
  }
 
 /**
  * copyValCheck()
  * 작 성 자 : 김경은
  * 작 성 일 : 2011-06-13
  * 개    요 :  복사시 데이터 존재여부 확인
  * return값 : void
  */
  function copyValCheck(strStrCd, strEvaluYm){

     var goTo       = "getList" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                    + "&strEvaluYm="+encodeURIComponent(strEvaluYm); 
     
     TR_MAIN.Action  = "/dps/psal701.ps?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_LIST=DS_O_VALCHECK)"; //조회는 O
     TR_MAIN.Post();
     
     if(DS_O_VALCHECK.CountRow == 0)
    	 return true;
     else
    	 return false;
  }
 
  /**
   * confCheck()
   * 작 성 자 : 김경은
   * 작 성 일 : 2011-06-13
   * 개    요 :  확정여부 체크
   * return값 : void
   */
   function confCheck(strStrCd, strEvaluYm){

      var goTo       = "confCheck" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                     + "&strEvaluYm="+encodeURIComponent(strEvaluYm); 
      
      TR_MAIN.Action  = "/dps/psal701.ps?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_CHECK=DS_O_CHECK)"; //조회는 O
      TR_MAIN.Post();
      
      if(DS_O_CHECK.CountRow == 0)
          return true;
      else
          return false;
   }
 
 /**
  * copy()
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-06-13
  * 개    요        : 전월내역복사
  * return값 : void
  */
 function copy() {
	 if (!searchFlag){
		 showMessage(QUESTION, OK, "USER-1075", "전월내역복사")
		  return;
	 }
	 
	 // 복사시 등록된 내역이 있는지 확인한ㄷ.
	 if(!checkValidation("Copy"))
	      return;
	  
	 if(DS_O_LIST.CountRow == 0)
		  DS_O_LIST.Addrow();
    
	 var strStrCd      = LC_S_STR_CD.BindColVal;                    // 점
	 var strEvaluYm    = EM_S_EVALU_YM.Text;                        // 평가년월
	  
	 var action     = "I"; 
	 var goTo       = "copy" ;    
	 var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
	                + "&strEvaluYm="+encodeURIComponent(strEvaluYm);
	 
     //변경또는 신규 내용을 저장하시겠습니까?
     if( showMessage(QUESTION, YESNO, "USER-1191", "전월내역") == 1 ){    // validation 체크
    	    
   	    TR_S_MAIN.Action  = "/dps/psal701.ps?goTo="+goTo+parameters;  
   	    TR_S_MAIN.KeyValue= "SERVLET("+action+":DS_O_LIST=DS_O_LIST)"; //조회는 O
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

</script>

<script language=JavaScript for=DS_O_LIST event=CanRowPosChange(row)>
    if (DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            return false;
        }else {
            if(DS_O_LIST.RowStatus(row) == 1)   // 신규일경우
                DS_O_LIST.DeleteRow(row);
            
            return true;
        }
    }else{
        return true;
    }
</script>
<script language=JavaScript for=DS_O_LIST event=onRowPosChanged(row)>
	if(clickSORT)
	    return;
	    
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        if(DS_O_LIST.RowStatus(row) != 1){   // 수정일경우
             getMaster();
             setMasterObject(true, false);
        }else{
        	setMasterObject(true, true);
        }

         
        
        if(intSearchCnt == 0){
            intSearchCnt++;
        }else{
            setPorcCount("SELECT", DS_IO_MASTER.CountRow);
        }

    }

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- GR_MASTER 데이터변경  -->
<script language=JavaScript for=GR_MASTER event=CanColumnPosChange(row,colid)>

</script>

<!-- 점(입력)  변경시  -->
<script language=JavaScript for=LC_STR event=OnSelChange()>
    searchFlag = false;
</script>

<!-- 평가년월 KillFocus -->
<script language=JavaScript for=EM_S_EVALU_YM event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    searchFlag = false;
    checkDateTypeYM(EM_S_EVALU_YM);
</script>

<!-- 점수부여기준 KillFocus -->
<script language=JavaScript for=TA_ALLOC_BASE event=onKillFocus()>  
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;
	
    checkInputByte( null, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "ALLOC_BASE", "점수부여기준", "TA_ALLOC_BASE");
</script>


<!-- 평가항목  변경시  -->
<script language=JavaScript for=LC_VEN_EVALU_CD event=OnSelChange()>
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_EVALU_NAME") = LC_VEN_EVALU_CD.Text;
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

<comment id="_NSID_"><object id="DS_O_STR_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_LIST"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_VALCHECK"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CHECK"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_EVALU"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


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
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">

          <tr>
            <th width="80" class="point">점</th>
            <td width="115">
                  <comment id="_NSID_">
                      <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=110 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">평가년월</th>
            <td colspan = 5>
                  <comment id="_NSID_">
                      <object id=EM_S_EVALU_YM classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_S_EVALU_YM)"  align="absmiddle"/>
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
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td width="280">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"><object id=GR_LIST
                            width="100%" height=505 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID"        value="DS_O_LIST">
                            <Param Name="ViewSummary"   value="1" >
                        </object></comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
                <td class="PL10">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="sub_title PB03 PT10"><img
                                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                                    align="absmiddle" /> 평가항목 </td>
                                <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/copy_last.gif"
                                    hspace="2" onclick="javascript:copy();" /> </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0"
                            class="s_table">
                            <tr>
                                <th width="65" class="point">점코드</th>
                                <td width="100"><comment id="_NSID_"> <object
                                    id=EM_STR_CD classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="60" class="point">점명</th>
                                <td width="85">
				                  <comment id="_NSID_">
				                      <object id=EM_STR_NM classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
				                      </object>
				                  </comment>
				                  <script> _ws_(_NSID_);</script>
                                </td>
                                <th width="80" class="point">평가년월</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_EVALU_YM classid=<%=Util.CLSID_EMEDIT%> width=80
                                    tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th class="point">평가항목</th>
                                <td>
				                    <comment id="_NSID_">
				                         <object id=LC_VEN_EVALU_CD classid=<%= Util.CLSID_LUXECOMBO %> width=95 tabindex=1 align="absmiddle">
				                         </object>
				                    </comment><script>_ws_(_NSID_);</script>
					            </td>                                
                                <th>배점</th>
                                <td colspan="3"><comment id="_NSID_"> <object id=EM_ALLOT_SCORE
                                    classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    <tr>
	                    <td  height="20">
	                    </td>
                    </tr>
                    <tr>
                        <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="sub_title PB03 PT10"><img
                                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                                    align="absmiddle" /> 점수부여기준</td>
                                
                            </tr>
                        </table>
                        </td>
                    </tr>
                    <tr>          
						<td>						
	                        <table width="100%" border="1" cellspacing="0" cellpadding="0"
                            class="s_table">
		                        <tr>
			                        <td align=left>
										<comment id="_NSID_">
											<object id=TA_ALLOC_BASE classid=<%=Util.CLSID_TEXTAREA%> height=384   width=100% tabindex=1 > 
                                                <param name=Border value=False>
											</object>
										</comment><script>_ws_(_NSID_);</script>
									</td>									
								</tr>								
							</table>
						</td>				
                    </tr>
                </table>
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
        
            <c>Col=STR_CD           Ctrl=EM_STR_CD              param=Text</c>
            <c>Col=STR_NM           Ctrl=EM_STR_NM              param=Text</c>
            <c>Col=EVALU_YM         Ctrl=EM_EVALU_YM            param=Text</c>
            <c>Col=ALLOT_SCORE      Ctrl=EM_ALLOT_SCORE         param=Text</c>
            <c>Col=ALLOC_BASE       Ctrl=TA_ALLOC_BASE          param=Text</c>
            
            <c>Col=VEN_EVALU_CD     Ctrl=LC_VEN_EVALU_CD        param=BindColVal</c>   
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>

</body>
</html>

