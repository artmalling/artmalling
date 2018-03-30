<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 입/출고> 사고/해지 등록
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif2090.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :2011.01.18 (김성미) 신규작성
          2011.03.28 (김정민) 프로그램작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<%
    request.setCharacterEncoding("utf-8");
%>

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
<script language="javascript" src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var gv_preRowno = "1";  //이전ROWNO
var lcstrVal    = "";   //이전LC_O_STR_CD
var strSaveFlag = false;

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 280;		//해당화면의 동적그리드top위치
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
 //   DS_MASTER.AddRow();
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);                    					 //기간 : 시작
    initEmEdit(EM_E_DT, "YYYYMMDD", PK);                    					 //기간 : 종료
    initEmEdit(EM_ACDT_DT, "YYYYMMDD", NORMAL);             					 //사고일자
    initEmEdit(EM_CAN_DT, "YYYYMMDD", NORMAL);           						 //해지일자 
    initEmEdit(EM_STR_SPNO, "GEN^18", NORMAL);           						 //상품권번호 (필수) 
    initEmEdit(EM_STR_SPAMT, "NUMBER^12^0", READ);       						 //상품권금액 
    initEmEdit(EM_STR_SGBIGO, "GEN^50", NORMAL);         						 //사고사유비고 
    initEmEdit(EM_STR_CANBIGO, "GEN^50", NORMAL);        						 //해지사유비고 
    initEmEdit(EM_O_CANSABUNCD, "GEN^10", NORMAL);       						 //해지등록자코드
    initEmEdit(EM_O_CANSABUNNM, "GEN^40", READ);         						 //해지등록자명
    
    //콤보 초기화  
    initComboStyle(LC_O_STR_CD, DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점(조회)
    initComboStyle(LC_I_STR_CD1, DS_I_STR_CD1, "CODE^0^30,NAME^0^80", 1, PK);    //해지등록점
    initComboStyle(LC_I_SG, DS_I_SG, "CODE^0^30,NAME^0^80", 1, PK);              //사고점 
    initComboStyle(LC_O_SGSU, DS_O_SGSU, "CODE^0^30,NAME^0^80", 1, NORMAL);      //사고사유
    initComboStyle(LC_O_CANSU, DS_O_CANSU, "CODE^0^30,NAME^0^80", 1, NORMAL);    //해지사유
    initComboStyle(LC_STR_SPGBN, DS_STR_SPGBN, "CODE^0^30,NAME^0^100", 1, READ); //상품권종류
    initComboStyle(LC_STR_GJ, DS_STR_GJ, "CODE^0^30,NAME^0^100", 1, READ);       //금종 
  
    //공통코드에서 가져 오기
    getStore("DS_O_STR_CD", "Y", "1", "N");   //점(조회)
    getStore("DS_I_STR_CD1", "N", "1", "N");  //해지등록점
    getStore("DS_I_SG", "Y", "1", "N");  //사고점
    
    getEtcCode("DS_O_SGSU", "D", "M012", "N", "N", LC_O_SGSU);   //사고사유
    getEtcCode("DS_O_CANSU", "D", "M013", "N", "N", LC_O_CANSU);   //해지사유
    
    getEtcCodeSub("DS_STR_SPGBN",  "1");                // 상품권종류       
    getEtcCodeSub("DS_STR_GJ",  "2");                // 금종          
    
    EM_S_DT.Text    = getTodayFormat("YYYYMM01");   //기간(조회)
    EM_E_DT.Text    = getTodayFormat("YYYYMMDD");   //기간(조회)
    EM_ACDT_DT.Text = getTodayFormat("YYYYMMDD");   //사고일자
    EM_CAN_DT.Text  = getTodayFormat("YYYYMMDD");   //해지일자
     
    //점(조회) 
    LC_O_STR_CD.Index = 0;
    
    //해지등록점 
    LC_I_STR_CD1.Index = 0;

    //사고점
    LC_I_SG.Index = 0;
    
    LC_O_STR_CD.Focus();
    //해지내역 체크
    chkExcp();
    

    EM_ACDT_DT.Enable = false;
    LC_I_SG.Enable = false;
    EM_STR_SPNO.Enable = false; 
    enableControl(btnactdt, false);
    

    EM_ACDT_DT.Text = "";
    LC_I_SG.BindColVal = "";
    EM_STR_SPNO.Text = "";  
    
  //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif209", "DS_MASTER"); 
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"'
                     + '                                  width=25   align=center </FC>' 
                     + '<FC>id=ACDT_STR         name="사고점"'       
                     + '                                  width=80   align=left EDITSTYLE=LOOKUP   DATA="DS_I_SG:CODE:NAME" </FC>'
                     + '<FC>id=ACDT_DT          name="사고일자"'
                     + '                                  width=80   align=center  MASK="XXXX/XX/XX" </FC>'
                     + '<FC>id=ACDT_RSN_CD      name="사고사유"'     
                     + '                                  width=80   align=left  EDITSTYLE=LOOKUP   DATA="DS_O_SGSU:CODE:NAME"  </FC>'
                     + '<FC>id=GIFTCARD_NO      name="상품권번호"'   
                     + '                                  width=150  align=left   </FC>'
                     + '<FC>id=ACDT_SEQ_NO      name="사고순번"'
                     + '                                  width=80   align=left  Show="false" </FC>'
                     + '<FC>id=REG_ID           name="사고등록자"'   
                     + '                                  width=80   align=left Show="false"   </FC>'
                     + '<FC>id=REG_NM           name="사고등록자"'   
                     + '                                  width=80   align=left   </FC>'
                     + '<FC>id=GIFT_AMT_NAME    name="금종"'
                     + '                                  width=80   align=left </FC>'
                     + '<FC>id=CAN_STR          name="해지등록점"'
                     + '                                  width=80   align=left EDITSTYLE=LOOKUP   DATA="DS_I_STR_CD1:CODE:NAME" </FC>'
                     + '<FC>id=ACDT_PROC_FLAG   name="사고처리구분"'
                     + '                                  width=80   align=left  Show="false" </FC>'
                     + '<FC>id=ISSUE_TYPE      name="발행형태"'
                     + '                                  width=80   align=left  Show="false" </FC>'
                     + '<FC>id=CAN_DT           name="해지일자"'
                     + '                                  width=80   align=center  MASK="XXXX/XX/XX" </FC>'
                     + '<FC>id=CAN_RSN_CD       name="해지사유"'
                     + '                                  width=80   align=left EDITSTYLE=LOOKUP   DATA="DS_O_CANSU:CODE:NAME" </FC>'
                     + '<FC>id=CAN_REG_ID       name="해지등록자"'
                     + '                                  width=80   align=left  Show="false" </FC>' 
                     + '<FC>id=CAN_REG_NM       name="해지등록자"'
                     + '                                  width=80   align=left   </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
 * 작 성 자 : 김정민
 * 작 성 일 : 2011-03-28
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    if(DS_MASTER.CountRow > 1){ 
        if (DS_MASTER.IsUpdated) {
            var ret = showMessage(Question, YesNo, "USER-1059");
            if (ret != "1") {
                DS_MASTER.RowPosition = gv_preRowno;
                return;
            }
        } 
    }
    
    EM_ACDT_DT.Enable = false;
    LC_I_SG.Enable = false;
    EM_STR_SPNO.Enable = false; 
    enableControl(btnactdt, false); 

    if (EM_S_DT.Text > EM_E_DT.Text){  //기간
        showMessage(INFORMATION, OK, "USER-1008", "종료일자", "시작일자");
        EM_E_DT.Focus()
        return;
    }

    
    DS_MASTER.ClearData();

    var strStr      = LC_O_STR_CD.BindColVal;     //점코드
    var strSrart    = EM_S_DT.Text;               //기간 from
    var strEnd      = EM_E_DT.Text;               //기간 To
    var strChk      = "";
    
    if(CHK_SINGLE.checked) {
    	strChk = "2";
    }
    else {
    	strChk = "1";
    } 
    var goTo       = "getMaster";
    var action     = "O";
    var parameters = "&strStr="   + encodeURIComponent(strStr)
                   + "&strSrart=" + encodeURIComponent(strSrart) 
                   + "&strEnd="   + encodeURIComponent(strEnd)
                   + "&strChk="   + encodeURIComponent(strChk);

    TR_MAIN.Action   = "/mss/mgif209.mg?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_MASTER=DS_MASTER)";
    TR_MAIN.Post();

    if (DS_MASTER.CountRow != 0) { 
    	LC_O_SGSU.Enable=false;     
        LC_O_CANSU.Enable=false;
        GD_MASTER.Focus();    
    } 
     
    // 조회결과 Return
    setPorcCount("SELECT", DS_MASTER.CountRow);  
    
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {   
 
    for(var i=1; i<=DS_MASTER.CountRow; i++){
         if(DS_MASTER.NameValue(i,"ACDT_SEQ_NO")== ""){
            return false; 
         }       
    }
     DS_MASTER.AddRow();
     
   //  EM_S_DT.Text    = getTodayFormat("YYYYMMDD");   //기간(조회)
   //  EM_E_DT.Text    = getTodayFormat("YYYYMMDD");   //기간(조회)
    EM_ACDT_DT.Text = getTodayFormat("YYYYMMDD");   //사고일자
    EM_CAN_DT.Text  = getTodayFormat("YYYYMMDD");   //해지일자
     
    //콤보
    LC_O_STR_CD.Index = 0;      //점(조회) 
    LC_I_STR_CD1.Index = 0;     //해지등록점 
    LC_I_SG.Index = 0;          //사고점
    LC_O_SGSU.Index = 0;          //사고사유
    LC_O_CANSU.Index = 0;          //해지사유

    LC_O_SGSU.Enable=true;      

    EM_STR_SPNO.Focus();
    //해지내역 체크
    chkExcp();
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save() 
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
     if (DS_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
            //필수 입력값 체크
            if (!checkValidate()) return;
     
            if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"ACDT_PROC_FLAG") == "2") {   //사고처리구분 1:사고 , 2:사고해지
            	if(EM_CAN_DT.Text == "") {
            		showMessage(INFORMATION, OK, "USER-1002", "해지일자");
                    setTimeout("EM_CAN_DT.Focus()",100); 
                    return false;
            	}
            	
            	if(EM_O_CANSABUNCD.Text == "") {
            		showMessage(INFORMATION, OK, "USER-1002", "해지등록자");
                    setTimeout("EM_O_CANSABUNCD.Focus()",100); 
                    return false;
            	}
            }

           // alert(DS_MASTER.Text);
           //변경또는 신규 내용을 저장하시겠습니까?
            if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            	GD_MASTER.Focus();
                return;
            }
            strSaveFlag = true;
            //저장
            var goTo = "save"; 
            TR_MAIN.Action = "/mss/mgif209.mg?goTo=" + goTo;
            TR_MAIN.KeyValue = "SERVLET(I:DS_MASTER=DS_MASTER)";
            TR_MAIN.Post();
          //  alert(DS_MASTER.NameValue(DS_MASTER.RowPosition,""));
            DS_MASTER.ClearData();
            btn_Search();
            
            strSaveFlag = false;
        } else {
            showMessage(INFORMATION, OK, "USER-1028");
            return;
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

 /**
  * getEtcCodeSub()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.10
  * 개    요 : 공통코드가져오기
  * return값 :
  */
 function getEtcCodeSub(objDateSet, objCode) {  
     var goTo = "getEtcCodeSub";
     var parameters = ""
         + "&strDSName="      + encodeURIComponent(objDateSet)
         + "&strEtcCode="     + encodeURIComponent(objCode);
      //   alert(objCode);
     TR_MAIN.Action = "/mss/mgif209.mg?goTo=" + goTo + parameters; 
     TR_MAIN.KeyValue = "SERVLET(O:"+objDateSet+"="+objDateSet+")";
     TR_MAIN.StatusResetType= "2";
     TR_MAIN.Post();
 }
 
 /**
  * chkExcp()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011.03.29
  * 개    요 : 체크박스 클릭시 컨트롤 활성화
  * return값 :
  */
 function chkExcp(){
 // CHK_EXCP 
       if(CHK_EXCP.checked == true){
           //alert(CHK_EXCP.checked);
           EM_CAN_DT.Enable = true; 
           EM_STR_CANBIGO.Enable = true; 
           //LC_I_STR_CD1.Enable = true; 
           LC_I_STR_CD1.BindColVal = LC_I_SG.BindColVal;
           EM_O_CANSABUNCD.Enable = false; 
           LC_O_CANSU.Enable = true;
 
            enableControl(imgSb, false);
            enableControl(CanDate, true);
            if(DS_MASTER.CountRow > 0)
            {
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"ACDT_PROC_FLAG") = "2";   //1:사고 , 2:사고해지
                EM_CAN_DT.Text = getTodayFormat("YYYYMMDD");
                LC_I_STR_CD1.Index = 0;
                LC_O_CANSU.Index = 0;
                EM_STR_CANBIGO.Text ="";
                EM_O_CANSABUNCD.Text = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />'; 
                EM_O_CANSABUNNM.Text = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';  
            }
       }
       else{
        //   alert(CHK_EXCP.checked);
           EM_CAN_DT.Enable = false;
           EM_STR_CANBIGO.Enable = false;
           LC_I_STR_CD1.Enable = false;
           EM_O_CANSABUNCD.Enable = false; 
           LC_O_CANSU.Enable = false;
 
            enableControl(imgSb, false);
            enableControl(CanDate, false);
             
            EM_CAN_DT.Text = "";
            LC_I_STR_CD1.BindColVal = "";
            LC_O_CANSU.BindColVal = "";
            EM_O_CANSABUNCD.Text = ""; 
            EM_O_CANSABUNNM.Text = "";  
             
            if(DS_MASTER.CountRow > 0)
            {
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"ACDT_PROC_FLAG") = "1";   // 1:사고 , 2:사고해지
                EM_CAN_DT.Text = "";
             //   LC_I_STR_CD1.BindColVal = "";  
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"CAN_STR") = ""; 
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"CAN_RSN_CD") = ""; 
                EM_STR_CANBIGO.Text ="";
            }
       }
 }
 
 /**
  * checkValidate()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.14
  * 개    요 : 값체크(저장)
  * return값 :
  */
 function checkValidate() { 
      for (i=1; i<=DS_MASTER.CountRow; i++) {
          if (DS_MASTER.RowStatus(i) != 0 ) {
               //사고점코드        
               if (DS_MASTER.NameValue(i,"ACDT_STR") == "") {
                   DS_MASTER.RowPosition = i;
                   GD_MASTER.SetColumn("LC_I_SG");
                   showMessage(INFORMATION, OK, "USER-1002", "사고점");
                   setTimeout("LC_I_SG.Focus()",100); 
                   return false;
               }
               
              //사고일자
               if (DS_MASTER.NameValue(i,"ACDT_DT") == "") {
                   DS_MASTER.RowPosition = i;
                   GD_MASTER.SetColumn("EM_ACDT_DT");
                   showMessage(INFORMATION, OK, "USER-1003", "사고일자");
                   setTimeout("EM_ACDT_DT.Focus()",100); 
                   return false;
               }
             
              //상품권번호
               if (DS_MASTER.NameValue(i,"GIFTCARD_NO") == "") {
                   DS_MASTER.RowPosition = i;
                   GD_MASTER.SetColumn("EM_STR_SPNO");
                   showMessage(INFORMATION, OK, "USER-1003", "상품권번호");
                   setTimeout("EM_STR_SPNO.Focus()",100); 
                   return false;
               }
               
              //사고사유
               if (DS_MASTER.NameValue(i,"ACDT_RSN_CD") == "") {
                   DS_MASTER.RowPosition = i;
                   GD_MASTER.SetColumn("LC_O_SGSU");
                   showMessage(INFORMATION, OK, "USER-1002", "사고사유");
                   setTimeout("LC_O_SGSU.Focus()",100); 
                   return false;
               } 
              
 
            }
        }     
        return true;
 } 
  
  /**
   * Search_Click()
   * 작 성 자 : 김정민
   * 작 성 일 : 2011.03.31
   * 개    요 : 값체크(조회)
   * return값 :
   */
  function Search_Click(){
    //  alert(); 
      if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"ACDT_PROC_FLAG")== "2")  //1:사고 , 2:사고해지
      { 
          CHK_EXCP.checked = true;  
          CHK_EXCP.disabled = true;
      }
      else
      { 
          CHK_EXCP.checked = false;
          
      }
      
      if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"ACDT_SEQ_NO") == "")
      { 
          EM_ACDT_DT.Enable = true;
          LC_I_SG.Enable = true;
          EM_STR_SPNO.Enable = true;  
          enableControl(btnactdt, true);
          CHK_EXCP.disabled = false;  
        //  chkExcp();
      }
      else
      {
          //alert("seqno");
          
          EM_ACDT_DT.Enable = false;
          LC_I_SG.Enable = false;
          EM_STR_SPNO.Enable = false; 
          enableControl(btnactdt, false);
          enableControl(imgSb, false);   
         // chkExcp();                                                                      
          if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"ACDT_PROC_FLAG")== "2")   //1:사고 , 2:사고해지
          {
              EM_CAN_DT.Enable = false;
              LC_I_STR_CD1.Enable = false;
              EM_O_CANSABUNCD.Enable = false; 
              enableControl(CanDate, false);
              enableControl(imgSb, false);

              CHK_EXCP.disabled = true;
              LC_O_CANSU.Enable = false; 
            //  LC_O_CANSU.Index = 0;
              EM_STR_CANBIGO.Enable = true;
              
          }
          else
          {  
              EM_CAN_DT.Enable = false;
              LC_I_STR_CD1.Enable = false;
              EM_O_CANSABUNCD.Enable = false; 
              enableControl(CanDate, false);
              enableControl(imgSb, false); 
              
              LC_O_CANSU.Enable = false;
              EM_STR_CANBIGO.Enable = false;
              
              CHK_EXCP.disabled = false;
              
          }
      } 
  }
   
function getDate(){
	openCal('G',EM_CAN_DT);
	if(EM_CAN_DT.Text < EM_ACDT_DT.Text){
		showMessage(EXCLAMATION, OK, "USER-1008", "해지일자", "사고일자");
		EM_CAN_DT.Text = EM_ACDT_DT.Text;
		return;
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
   /* showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_MASTER event=onRowPosChanged(row)>
if(clickSORT) return;
   if(DS_MASTER.CountRow > 0){  
       Search_Click();
   }
</script> 

<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)> 
if (!strSaveFlag) {
    if (DS_MASTER.CountRow > 0) {
        if (DS_MASTER.RowStatus(row) == 1) { // 신규행작성시
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
                DS_MASTER.DeleteRow(row);
                return true;    
            } else {
                return false;   
            }
        } else if (DS_MASTER.RowStatus(row) == 3) { //데이터 변경시
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
                rollBackRowData(DS_MASTER, row);
                return true;    
            } else {
                return false;   
            }
        }
        return true;
    }
    return true;
}
</script>


<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }
</script>

<script language=JavaScript for=EM_STR_SPNO event=onKillFocus()>
    if(EM_STR_SPNO.Text.length > 0)
    {
        if (EM_STR_SPNO.Text.length !=12 && EM_STR_SPNO.Text.length !=13 && EM_STR_SPNO.Text.length !=16 && EM_STR_SPNO.Text.length !=18)
        {
            showMessage(INFORMATION, OK, "USER-1000", "13,16,18 자리 중 입력하셔야 합니다.");
        }
        else
        {
            DS_O_RESULT.ClearData();
     
            var strSpno    = EM_STR_SPNO.Text;               //상품권번호(필수)
    
            var goTo       = "getSpno";
            var action     = "O";
            var parameters = "&strSpno=" + encodeURIComponent(strSpno);
         
            TR_MAIN.Action   = "/mss/mgif209.mg?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_O_RESULT=DS_O_RESULT)";
            TR_MAIN.Post();
    
            gv_preRowno = "1"; 
            
            if (DS_O_RESULT.CountRow != 0) { 
                if(DS_O_RESULT.NameValue(i,"ACDT_FLAG")== "Y") { 
                    showMessage(STOPSIGN, OK, "USER-1000",  "이미 사고로 등록되어있는 <br>상품권 번호입니다.");
                    EM_STR_SPNO.Text="";
                    setTimeout("EM_STR_SPNO.Focus()",100);
                }
                else{
                    LC_STR_SPGBN.BindColVal = DS_O_RESULT.NameValue(i,"GIFT_TYPE_CD");
                    LC_STR_GJ.BindColVal    = DS_O_RESULT.NameValue(i,"GIFT_AMT_TYPE");
                    EM_STR_SPAMT.Text       = DS_O_RESULT.NameValue(i,"GIFTCERT_AMT");     
                    DS_MASTER.NameValue(DS_MASTER.RowPosition,"ISSUE_TYPE")     = DS_O_RESULT.NameValue(i,"ISSUE_TYPE");  
                    //alert();
                    setTimeout("LC_O_SGSU.Focus()",100);  
                } 
            }else { 
             //   showMessage(STOPSIGN, OK, "GAUCE-1003", TR_MAIN.SrvErrMsg('GAUCE',i));
                showMessage(STOPSIGN, OK, "USER-1000",  "등록되지 않은 상품권번호 입니다.");
                EM_STR_SPNO.Text="";
                setTimeout("EM_STR_SPNO.Focus()",100);
                EM_STR_SPNO.Text="";
                LC_STR_SPGBN.BindColVal = ""; 
                LC_STR_GJ.BindColVal = ""; 
                EM_STR_SPAMT.Text = "";  
                setTimeout("EM_STR_SPNO.Focus()",100);
            }
            
            // 조회결과 Return
            setPorcCount("SELECT", DS_O_RESULT.CountRow);
        }
    }
    else {
    	 EM_STR_SPNO.Text="";
         LC_STR_SPGBN.BindColVal = ""; 
         LC_STR_GJ.BindColVal = ""; 
         EM_STR_SPAMT.Text = "";  
      //   setTimeout("EM_STR_SPNO.Focus()",100);
    }
</script>
  
<script language=JavaScript for=EM_O_CANSABUNCD event=onKillFocus()>
 //   if (EM_O_CANSABUNCD.Text.length > 0 ) {
	 
	if(!this.Modified)
	        return;
	        
	    if(this.text==''){
	    	EM_O_CANSABUNNM.Text = "";
	        return;
	    }
	    
        getUserNonPop("DS_O_RESULT", EM_O_CANSABUNCD, EM_O_CANSABUNNM, 'E', 'Y');
            
     /*   if (DS_O_RESULT.CountRow == 1 ) {
            EM_O_CANSABUNCD.Text = DS_O_RESULT.NameValue(1, "CODE");
            EM_O_CANSABUNNM.Text = DS_O_RESULT.NameValue(1, "NAME");
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출
            getUserPop(EM_O_CANSABUNCD, EM_O_CANSABUNNM, 'S');
        }*/
  //  }  
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
<object id="DS_O_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_STR_CD1" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_SG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_SGSU" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CANSU" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 필터사용 DATASET -->
<comment id="_NSID_">
<object id="DS_STR_SPGBN" classid=<%=Util.CLSID_DATASET%>>
    <param name=UseFilter value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_STR_GJ" classid=<%=Util.CLSID_DATASET%>>
    <param name=UseFilter value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>


<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
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
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width="80">점</th>
                        <td width="140"><comment id="_NSID_"> <object
                            id=LC_O_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100 tabindex=1
                            width=140 align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script>
                        </td>
                        <th width="80" class="point">기간</th>
                        <td width="260"><comment id="_NSID_"> <object id=EM_S_DT tabindex=1
                            classid=<%=Util.CLSID_EMEDIT%> width=100 align="absmiddle"
                            onblur="javascript:checkDateTypeYMD(this);"> </object> </comment> <script>_ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" id="btndate1"
                            align="absmiddle" onclick="javascript:openCal('G',EM_S_DT)" /> ~
                        <comment id="_NSID_"> <object id=EM_E_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=100 align="absmiddle" tabindex=1
                            onblur="javascript:checkDateTypeYMD(this);"> </object> </comment> <script>_ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" id="btndate1"
                            align="absmiddle" onclick="javascript:openCal('G',EM_E_DT)" /></td>
                       <th  width="100">해지여부</th>
                       <td>
                            <input type="checkbox" id=CHK_SINGLE align="absmiddle"  tabindex=1 > 
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
                <td class="PB05">
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width="83" class="point">사고일자</th>
                        <td width="146"><comment id="_NSID_"> <object
                            id=EM_ACDT_DT classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
                            align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                        </object> </comment> <script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" id="btnactdt" align="absmiddle"
                            onclick="javascript:openCal('G',EM_ACDT_DT)" /></td>
                        <th width="80" class="point">사고점</th>
                        <td width="140"><comment id="_NSID_"> <object id=LC_I_SG
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=140 tabindex=1
                            align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
                        <th width="80" class="point">상품권번호</th>
                        <td><comment id="_NSID_"> <object id=EM_STR_SPNO
                            classid=<%=Util.CLSID_EMEDIT%> width=220 tabindex=1
                            align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="80">상품권종류</th>
                        <td  width="146"><comment id="_NSID_"> <object id=LC_STR_SPGBN
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=145 tabindex=1
                            align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
                        <th width="80">금종</th>
                        <td  width="140"><comment id="_NSID_"> <object id=LC_STR_GJ
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=140 tabindex=1
                            align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
                        <th width="80">상품권금액</th>
                        <td><comment id="_NSID_"> <object id=EM_STR_SPAMT
                            classid=<%=Util.CLSID_EMEDIT%> width=220 tabindex=1
                            align="absmiddle" tabindex=1> </object> </comment> <script>_ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="80" class="point">사고사유</th>
                        <td  width="150"><comment id="_NSID_"> <object id=LC_O_SGSU
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=145
                            align="absmiddle" tabindex=1> </object> </comment> <script>_ws_(_NSID_);</script></td>
                        <th width="80">사고사유비고</th>
                        <td  width="462" colspan=3><comment id="_NSID_"> <object
                            id=EM_STR_SGBIGO classid=<%=Util.CLSID_EMEDIT%> width=462
                            tabindex=1 onkeyup="javascript:checkByteStr(this, 100, 'Y');" tabindex=1 align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <td colspan=6>해지내역 <input type="checkbox" id=CHK_EXCP
                            onclick="javascript:chkExcp();" tabindex=1 ></td>
                    </tr>  
                    <tr>
                        <th width="80" class="point">해지일자</th>
                        <td><comment id="_NSID_"> <object id=EM_CAN_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=120 align="absmiddle" tabindex=1
                            onblur="javascript:checkDateTypeYMD(this);"> </object> </comment> <script>_ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" id="CanDate"
                            align="absmiddle" onclick="javascript:getDate()" />
                        </td>
                        <th width="80" class="point">해지등록점</th>
                        <td><comment id="_NSID_"> <object id=LC_I_STR_CD1
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=140
                            align="absmiddle" tabindex=1 > </object> </comment> <script>_ws_(_NSID_);</script></td>
                        <th width="80" class="point">해지등록자</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_O_CANSABUNCD classid=<%=Util.CLSID_EMEDIT%> width=70
                            align="absmiddle" tabindex=1></object> </comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=imgSb
                            class="PR03" align="absmiddle"
                            onclick="javascript:getUserPop(EM_O_CANSABUNCD, EM_O_CANSABUNNM, 'S');" />
                        <comment id="_NSID_"> <object id=EM_O_CANSABUNNM
                            classid=<%=Util.CLSID_EMEDIT%> width=125 align="absmiddle"
                            tabindex=1></object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr> 
                    <tr>
                        <th width="80" class="point">해지사유</th>
                        <td><comment id="_NSID_"> <object id=LC_O_CANSU
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=145
                            align="absmiddle" tabindex=1> </object> </comment> <script>_ws_(_NSID_);</script></td>
                        <th width="80">해지사유비고</th>
                        <td colspan=3><comment id="_NSID_"> <object
                            id=EM_STR_CANBIGO classid=<%=Util.CLSID_EMEDIT%> width=462
                             onkeyup="javascript:checkByteStr(this, 100, 'Y');" align="absmiddle" tabindex=1> </object> </comment> <script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
            <!--  그리드의 구분dot 여백  -->
            <tr>
                <td class="dot"></td>
            </tr>
            <!-- 그리드의 구분dot 여백  -->
            <tr>
                <td class="sub_title"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
                    align="absmiddle" class="PR03" />사고/해지 내역</td>
            </tr>
            <tr valign=top>
                <td width=100%>
                <table width="100%" border="1" cellpadding="0" cellspacing="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"><OBJECT id=GD_MASTER
                            width=100% height=600 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_MASTER">
                        </OBJECT></comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
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
    <param name=DataID value=DS_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=ACDT_STR         Ctrl=LC_I_SG                param=BindColVal</c>  
        <c>Col=ACDT_DT          Ctrl=EM_ACDT_DT             param=Text</c>   
        <c>Col=GIFTCARD_NO      Ctrl=EM_STR_SPNO            param=Text</c>  
        <c>Col=GIFT_TYPE_CD     Ctrl=LC_STR_SPGBN           param=BindColVal</c>  
        <c>Col=GIFT_AMT_TYPE    Ctrl=LC_STR_GJ              param=BindColVal</c>   
        <c>Col=GIFTCERT_AMT     Ctrl=EM_STR_SPAMT           param=Text</c>  
        <c>Col=ACDT_RSN_CD      Ctrl=LC_O_SGSU              param=BindColVal</c>    
        <c>Col=ACDT_REASON      Ctrl=EM_STR_SGBIGO          param=Text</c>  
        <c>Col=CAN_DT           Ctrl=EM_CAN_DT              param=Text</c>   
        <c>Col=CAN_STR          Ctrl=LC_I_STR_CD1           param=BindColVal</c>   
        <c>Col=CAN_REG_ID       Ctrl=EM_O_CANSABUNCD        param=Text</c>   
        <c>Col=CAN_REG_NM       Ctrl=EM_O_CANSABUNNM        param=Text</c>  
        <c>Col=CAN_RSN_CD       Ctrl=LC_O_CANSU             param=BindColVal</c>  
        <c>Col=CAN_REASON       Ctrl=EM_STR_CANBIGO         param=Text</c>  
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

