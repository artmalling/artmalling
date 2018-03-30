<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 세금계산서
 * 작 성 일 : 2010.04.07
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : ppay1010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 세금계산서 발행기간 설정
 * 이    력 :
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-07
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){

     // Input Data Set Header 초기화

     // Output Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_O_PAY_CNT.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     
     //그리드 초기화
     gridCreate1(); //마스터
     // EMedit에 초기화
     initEmEdit(EM_YYYYMM, "THISMN", PK);                 // 기준년월
     initEmEdit(EM_SALE_S_DT, "YYYYMMDD", READ);          // 매입기간 시작일
     initEmEdit(EM_SALE_E_DT, "YYYYMMDD", READ);          // 매입매출기간 종료일


     //콤보 초기화
     initComboStyle(LC_STR_CD,DS_IO_STR_CD,  "CODE^0^30,NAME^0^80", 1, PK);       // 점(조회)
     initComboStyle(LC_PAY_CYC,DS_O_PAY_CYC, "CODE^0^30,NAME^0^80", 1, NORMAL);   // 지불주기
     initComboStyle(LC_PAY_CNT,DS_O_PAY_CNT, "CODE^0^30,NAME^0^80", 1, NORMAL);   // 지불회차
     
     getStore("DS_IO_STR_CD", "Y", "", "N");   
     getEtcCode("DS_O_PAY_CYC", "D", "P052", "Y");         // 조회지불주기
     insComboData(LC_PAY_CNT, "%", "전체",1);              // 조회지불회차     
     getEtcCode("DS_I_PAY_CYC", "D", "P052", "N");         // 지불주기
     getEtcCode("DS_I_PAY_CNT", "D", "P409", "N");         // 지불회차

     LC_STR_CD.index  = 0;
     LC_PAY_CYC.index = 0;
     LC_PAY_CNT.index = 0;
     LC_STR_CD.Focus();
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}     name="NO"                width=30    align=center</FC>'
                      + '<FC>id=SEL          name="선택"              width=70    align=center EditStyle=CheckBox  HeadCheckShow="true"   </FC>'
                      + '<FC>id=STR_CD       name="*점"               width=120   align=center Edit=none EditStyle=Lookup   Data="DS_IO_STR_CD:CODE:NAME"</FC>'
                      + '<FC>id=PAY_YM       name="*기준년월"         width=100    align=center EditStyle=Popup Edit=Numeric Mask="XXXX/XX" </FC>'
                      + '<FC>id=PAY_CYC      name="*지불주기"         width=100    align=center Edit=none EditStyle=Lookup Data="DS_I_PAY_CYC:CODE:NAME"</FC>'
                      + '<FC>id=PAY_CNT      name="*지불회차"         width=100    align=center Edit=none EditStyle=Lookup Data="DS_I_PAY_CNT:CODE:NAME"</FC>'
                      + '<FC>id=ISSUE_S_DT   name="*발행시작일"       width=130    align=center EditStyle=Popup Edit=Numeric Mask="XXXX/XX/XX" </FC>'
                      + '<FC>id=ISSUE_E_DT   name="*발행종료일"       width=130    align=center EditStyle=Popup Edit=Numeric Mask="XXXX/XX/XX" </FC>';
                      
     initGridStyle(GR_MASTER, "common", hdrProperies, true);
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
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-04-08
  * 개    요        : 조회시 필수 조회조건을 체크한 후 조회한다.
  * return값 : void
  */
 function btn_Search() {
      // 변경, 추가내역이 있을 경우
      if (DS_IO_MASTER.IsUpdated){
          if( showMessage(STOPSIGN, YESNO, "USER-1073") != 1 )
             return;
      }
     
      if(checkValidation("Search")){
          DS_IO_MASTER.ClearData();  
          // 조회조건 셋팅
          var strStrCd         = LC_STR_CD.BindColVal;                  // 점
          var strYyyymm        = EM_YYYYMM.Text;                        // 기준년월
          var strPayCyc        = LC_PAY_CYC.BindColVal;                 // 지불주기
          var strPayCnt        = LC_PAY_CNT.BindColVal;                 // 지불회차
          var strSaleSdt       = EM_SALE_S_DT.Text;                     // 매입매출시작일   
          var strSaleEdt       = EM_SALE_E_DT.Text;                     // 매입매출종료일

          getMaster("DS_IO_MASTER",strStrCd, strYyyymm, strPayCyc, strPayCnt, strSaleSdt, strSaleEdt);
          GR_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";
          
          // 조회결과 Return
          setPorcCount("SELECT", GR_MASTER);
      }
 }

 /**
  * getMaster(strStrCd, strYyyymm, strPayCyc, strPayCnt, strSaleSdt, strSaleEdt)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-04-08
  * 개    요   : 마스터를 조회한다.
  * return값 : void
  */
function getMaster(dataSet, strStrCd, strYyyymm, strPayCyc, strPayCnt, strSaleSdt, strSaleEdt){
	var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strYyyymm="+encodeURIComponent(strYyyymm)     
                    + "&strPayCyc="+encodeURIComponent(strPayCyc)      
                    + "&strPayCnt="+encodeURIComponent(strPayCnt)     
                    + "&strSaleSdt="+encodeURIComponent(strSaleSdt)
                    + "&strSaleEdt="+encodeURIComponent(strSaleEdt); 
    TR_MAIN.Action  = "/dps/ppay101.pp?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER="+dataSet+")"; // 조회는 O
    TR_MAIN.Post();
    
}
 
/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-08
 * 개    요 : 신규 추가
 * return값 : void
 */
function btn_New() {
	 
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-08
 * 개    요 : 삭제
 * return값 : void
 */
function btn_Delete() {
/*	
    // 삭제 메세지 
    if(showMessage(Question, YESNO, "USER-1023") != 1)
        return;
    
    var intRowCount =  DS_IO_MASTER.CountRow;
    var intDelCnt   = 0;
    for(var i=intRowCount; i >= 1; i--){
        if(DS_IO_MASTER.NameValue(i, "SEL") == 'T'){
        	if(DS_IO_MASTER.RowStatus(i) == "1"){
        		DS_IO_MASTER.DeleteRow(i);
        	}else{
        		DS_IO_MASTER.DeleteRow(i);
        		intDelCnt++;
        	}
        		
        }
    }
       
    if(intDelCnt > 0){
	    var params = "&strFlag=delete" ;
	    
	    TR_MAIN.Action="/dps/ppay101.pp?goTo=save"+params; 
	    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	    TR_MAIN.Post();	    
	    btn_search();
    }
    GR_MASTER.ColumnProp('SEL','HeadCheck')= "false";   //그리드 CHEKCBOX헤더 체크해제   
*/
}

/**
 * btn_Save()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-08
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	// 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(StopSign, OK, "USER-1028");
       return;
    }

    if(!checkValidation("Save"))    // validation 체크
        return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(STOPSIGN, YESNO, "USER-1010") == 1 ){

        TR_MAIN.Action="/dps/ppay101.pp?goTo=save&strFlag=save"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_MAIN.Post();

        btn_Search();
    }
      
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

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * addRow()
  * 작 성 자     :김경은
  * 작 성 일     : 2010-05-09
  * 개    요        : ROW 추가
  * return값 : void
  */
 function addRow(){
	  if(checkValidation("Save")){
          DS_IO_MASTER.AddRow();
          setMaster();
      }
 }
  
 /**
 * delRow()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-09
 * 개    요    : ROW 삭제
 * return값 : void
 */
 function delRow(){
	// 삭제 메세지 
    if(showMessage(Question, YESNO, "USER-1023") != 1)
        return;
    
    var intRowCount =  DS_IO_MASTER.CountRow;
    for(var i=intRowCount; i >= 1; i--){
        if(DS_IO_MASTER.NameValue(i, "SEL") == 'T'){
            DS_IO_MASTER.DeleteRow(i);
        }
    }
 }
 
 /**
  * setMaster()
  * 작 성 자 : 
  * 작 성 일 : 2010-04-07
  * 개    요 : 신규시 기본정보 세팅
  * return값 : void
  */

 function setMaster() {
	  //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD") = LC_STR_CD.BindColVal;
	  //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_YM") = EM_YYYYMM.Text;
	  

 }

 /**
  * columnEditType(flag)
  * 작 성 자 : 
  * 작 성 일 : 2010-04-07
  * 개    요 : 그리드에 EditMode설정
  * return값 : void
  */
function columnEditType(flag){
	GR_MASTER.ColumnProp("STR_CD",  "Edit")       = flag;  
    GR_MASTER.ColumnProp("PAY_CYC", "Edit")       = flag; 
    GR_MASTER.ColumnProp("PAY_CNT", "Edit")       = flag; 
    //GR_MASTER.ColumnProp("ISSUE_S_DT", "Edit")    = flag; 
    //GR_MASTER.ColumnProp("ISSUE_E_DT", "Edit")    = flag;
    
    if(flag == "none")
    	GR_MASTER.ColumnProp("PAY_YM",  "Edit")   = flag;
    else
    	GR_MASTER.ColumnProp("PAY_YM",  "Edit")   = "Numeric";
}
  
  
  /**
   * checkValidation()
   * 작 성 자     : 김경은
   * 작 성 일     : 2010-04-08
   * 개    요        : validation 체크
   * return값 : void
   */
  function checkValidation(Gubun) {
       
       var messageCode = "USER-1001";
       
       //조회버튼 클릭시 Validation Check
       if(Gubun == "Search"){   
           if(EM_YYYYMM.Text.length == 0){                                // 기준년월
               showMessage(INFORMATION, OK, "USER-1002", "기준년월");
               EM_YYYYMM.Focus();
               return false;
           }
       }
       
       // 저장버튼 클릭시 Validation Check
       if(Gubun == "Save"){
          
           var intRowCount   = DS_IO_MASTER.CountRow;
           var strStrCd      = "";                     // 점
           var strPayYm      = "";                     // 기준년월        
           var strPayCyc     = "";                     // 지불주기
           var strPayCnt     = "";                     // 지불회차 
           var strIssueSdt   = "";                     // 시작일자
           var strIssueEdt   = "";                     // 종료일자
           
           if(intRowCount > 0){
               for(var i=1; i <= intRowCount; i++){
                   
            	   strStrCd    = DS_IO_MASTER.NameValue(i, "STR_CD");
            	   strPayYm    = DS_IO_MASTER.NameValue(i, "PAY_YM");
            	   strPayCyc   = DS_IO_MASTER.NameValue(i, "PAY_CYC");
            	   strPayCnt   = DS_IO_MASTER.NameValue(i, "PAY_CNT");
            	   strIssueSdt = DS_IO_MASTER.NameValue(i, "ISSUE_S_DT");
            	   strIssueEdt = DS_IO_MASTER.NameValue(i, "ISSUE_E_DT");

            	   if(strStrCd.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "점");
                       GR_MASTER.SetColumn("STR_CD");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
            	   
            	   if(strPayYm.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "기준년월");
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
                   
                   if(strIssueSdt.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "발행시작일");
                       GR_MASTER.SetColumn("ISSUE_S_DT");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   if(strIssueSdt < strPayYm + "01"){
                       showMessage(INFORMATION, OK, "USER-1020", "발행시작일","기준년월");
                       GR_MASTER.SetColumn("ISSUE_S_DT");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   if(strIssueEdt.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "발행종료일");
                       GR_MASTER.SetColumn("ISSUE_E_DT");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   if(strIssueEdt < strPayYm + "01"){
                       showMessage(INFORMATION, OK, "USER-1020", "발행종료일","기준년월");
                       GR_MASTER.SetColumn("ISSUE_E_DT");  
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
                   
                   if(strIssueSdt > strIssueEdt){                     // 조회일 정합성
                       showMessage(INFORMATION, OK, "USER-1015");
                       GR_MASTER.SetColumn("ISSUE_E_DT");  
                       DS_IO_MASTER.RowPosition = i; 
                       return false;
                   }
                   
                   // 등록된 발행기간이 있는지 조회한다.      
                   if(DS_IO_MASTER.RowStatus(i) == "1"){
	                   getMaster("DS_O_VAL_CHECK", strStrCd, strPayYm, strPayCyc, strPayCnt, "", "");
	                   if(DS_O_VAL_CHECK.CountRow > 0){
	                	   showMessage(StopSign, Ok,  "USER-1044", i);
	                	   return false;
	                   }
                   }
               }
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--  ===================DS_IO_MASTER============================ -->
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
	var strStrCd  = this.NameValue(row, "STR_CD");
	var strPayYm  = this.NameValue(row, "PAY_YM");
	var strPayCyc = this.NameValue(row, "PAY_CYC");
	var strPayCnt = this.NameValue(row, "PAY_CNT");
	var strKey    = strStrCd + strPayYm + strPayCyc + strPayCnt;
	this.NameValue(row,"KEY") = strKey;

    switch (colid) {
    case "PAY_YM":
    	break;
    case "PAY_CYC":
    	this.NameValue(row, "PAY_CNT") = "";
    	/*
        if(strPayCyc == "1")
            getEtcCode("DS_I_PAY_CNT", "D", "P407", "N");         // 지불회차
        else if(strPayCyc == "2")
            getEtcCode("DS_I_PAY_CNT", "D", "P408", "N");         // 지불회차
        else if(strPayCyc == "3")
            getEtcCode("DS_I_PAY_CNT", "D", "P409", "N");         // 지불회차
        */
        break;
            
    case "PAY_CNT":
    	
		if(strPayCyc != "" && strPayCyc < strPayCnt){
			showMessage(INFORMATION, OK, "GAUCE-1000", "선택할 수 없는 지불회차입니다.");
			this.NameValue(row, "PAY_CNT") = "";
		}
    	 
    	getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, this.NameValue(row, "PAY_CNT"));
    	DS_IO_MASTER.NameValue(row,"TERM_S_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    	DS_IO_MASTER.NameValue(row,"TERM_E_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
        break;
    }

</script>
<!--  -->
<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
	if(DS_IO_MASTER.RowStatus(row) == 1)
		columnEditType("any");
	else
		columnEditType("none");
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GR_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
            DS_IO_MASTER.NameValue(i, "SEL") = 'T';
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_IO_MASTER.CountRow; i++){
            DS_IO_MASTER.NameValue(i, "SEL") = 'F';
        }
    }
</script>

<!-- GR_MASTER 데이터변경  -->
<script language=JavaScript for=GR_MASTER event=CanColumnPosChange(row,colid)>
    if(row < 1)
        return true;
    switch(colid){
    case "PAY_YM":
    	if(DS_IO_MASTER.NameValue(row, "PAY_YM") == "")
            return true;
    	if(!checkDateTypeYM(this,colid,''))
    		return false;
    	break;
    case "ISSUE_S_DT":
    	if(DS_IO_MASTER.NameValue(row, "ISSUE_S_DT") == "")
    		return true;
    	if(!checkDateTypeYMD(this,colid,''))
    		return false;
    	
        var strPayYm    = DS_IO_MASTER.NameValue(row,"PAY_YM");
        var strIssueSdt = DS_IO_MASTER.NameValue(row,"ISSUE_S_DT");
        if(strIssueSdt < strPayYm + "01"){
        	showMessage(INFORMATION, OK, "USER-1020", "발행시작일","기준년월");
            //DS_IO_MASTER.NameValue(row, "ISSUE_S_DT") = "";
            return false;
        }
        break;
    case "ISSUE_E_DT":
    	if(DS_IO_MASTER.NameValue(row, "ISSUE_E_DT") == "")
            return true;
    	if(!checkDateTypeYMD(this,colid,''))
            return false;
    	if(DS_IO_MASTER.NameValue(row, "ISSUE_S_DT") > DS_IO_MASTER.NameValue(row, "ISSUE_E_DT")){ // 조회일 정합성
            showMessage(INFORMATION, OK, "USER-1015");
            DS_IO_MASTER.NameValue(row, "ISSUE_E_DT") = "";
            return false;
        }
    	var strPayYm    = DS_IO_MASTER.NameValue(row,"PAY_YM");
        var strIssueEdt = DS_IO_MASTER.NameValue(row,"ISSUE_E_DT");
        if(strIssueEdt < strPayYm + "01"){
        	showMessage(INFORMATION, OK, "USER-1020", "발행종료일","기준년월");
            //DS_IO_MASTER.NameValue(row, "ISSUE_E_DT") = "";
            return false;
        }
        break;
    }
</script>

<!-- GR_MASTER OnPopup event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnPopup(row,colid,data)>
    switch(colid){
    case "PAY_YM":    	
    	openCal(GR_MASTER,row,colid,'M');
        break;
    default:
    	openCal(GR_MASTER,row,colid);
        break;
    }
</script>

<!-- 기준년월 KillFocus -->
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
	    getEtcCode("DS_O_PAY_CNT", "D", "P407", "Y");         // 지불회차
	else if(LC_PAY_CYC.BindColVal == "2")
		getEtcCode("DS_O_PAY_CNT", "D", "P408", "Y");         // 지불회차
	else if(LC_PAY_CYC.BindColVal == "3")
		getEtcCode("DS_O_PAY_CNT", "D", "P409", "Y");         // 지불회차
		
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
<comment id="_NSID_"><object id="DS_I_PAY_CYC"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PAY_CNT"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_PAY_DATE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SALE_DATE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CYC"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CNT"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEAL_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DUTY_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_VAL_CHECK" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width="80" class="point">기준년월</th>
            <td width="110">
                  <comment id="_NSID_">
                      <object id=EM_YYYYMM classid=<%=Util.CLSID_EMEDIT%>  width=75 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:javascript:openCal('M',EM_YYYYMM)"  align="absmiddle"/>
            </td>
            <th width="80">지불주기</th>
            <td width="110">
                    <comment id="_NSID_">
                        <object id=LC_PAY_CYC classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">지불회차</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_PAY_CNT classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1  align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
         
          <tr>
            <th>매입매출기간</th>
            <td colspan="7">
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
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  
  <tr>
    <td class="dot"></td>
  </tr>
  
  <tr align="right">
    <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
    <td class="right">
     <img src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD"  width="52" height="18" hspace="2" onclick="javascript:addRow();" /><img src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL" width="52" height="18" onclick="javascript:delRow();" />
    </td>
         </tr>
      </table>
    </td>
  </tr>
  
  
  
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
          <tr>
            <td width="100%">
                <comment id="_NSID_">
                    <OBJECT id=GR_MASTER width=100% height=459 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_IO_MASTER">
                    </OBJECT>
                </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
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

