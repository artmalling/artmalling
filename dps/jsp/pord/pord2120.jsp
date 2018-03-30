<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주결재 > 일괄 검품 확정
 * 작 성 일 : 2010.04.08
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord2120.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 일괄 검품 확정
 * 이    력 :
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var strToday        = "";                            // 현재날짜
var prinCount       = 0;
var bfListRowPosition = 0;                             // 이전 List Row Position
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-09
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 150;		//해당화면의 동적그리드top위치

 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

     // Input  Data Set Header 초기화
     
     strToday        = getTodayDB("DS_O_RESULT");  
     
     // Output Data Set Header 초기화     
     DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');                     // 신규등록시
     DS_O_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');                   // 등록시 체크
     DS_O_PRE_SLIP_NO.setDataHeader('<gauce:dataset name="H_PRE_SLIP_NO"/>');     // 검품확정된 전표 체크
     DS_PAY_CLOSE_CHK.setDataHeader('<gauce:dataset name="H_PAY_CLOSE_CHK"/>');   // 대금지불마감체크
     DS_MG_RATE.setDataHeader('<gauce:dataset name="H_MG_RATE"/>');
     DS_APPDT_PRICE.setDataHeader('<gauce:dataset name="H_APPDT_PRICE"/>');
     DS_CHK_JG_FLAG.setDataHeader('<gauce:dataset name="H_CHK_JG_FLAG"/>');     
     
     // 그리드 초기화
     gridCreate1(); //마스터
     
     // EMedit에 초기화
     initEmEdit(EM_S_START_DT,"TODAY", PK); //조회용 시작일
     
     //콤보 초기화
     initComboStyle(LC_O_STR,DS_STR, "CODE^0^30,NAME^0^80", 1, PK);  //조회용 점코드     
     getStore("DS_STR", "Y", "", "N"); // 점        
     LC_O_STR.Index      = 0; 
   
     registerUsingDataset("pord212","DS_LIST");
 } 
 
  
 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}           name="NO"         width=30    edit=none align=center  sumtext=""     </FC>'
                      + '<FC>id=CHECK1             name="선택"       width=50     align=center  HeadCheckShow=true EditStyle=CheckBox</FC>'
                      + '<FC>id=SLIP_NO            name="* 전표번호"    width=110    align=center Mask="XXXX-X-XXXXXXX"</FC>'
                      + '<FC>id=SLIP_FLAG          name="전표구분코드" width=80   edit=none align=left show=false</FC>'
                      + '<FC>id=SLIP_FLAG_NM       name="전표구분"    width=80    edit=none align=left </FC>'
                      + '<FC>id=ORD_DT             name="발주일"      width=93    edit=none align=left Mask="XXXX/XX/XX"</FC>'
                      + '<FC>id=PUMBUN_CD          name="브랜드코드"    width=60    edit=none align=left </FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드"        width=130   edit=none align=left</FC>'
                      + '<FC>id=VEN_CD             name="협력사코드"  width=70    edit=none align=left </FC>'
                      + '<FC>id=VEN_NM             name="협력사"      width=130   edit=none align=left </FC>'
                      + '<FC>id=SLP_TQTY           name="수랑계"      width=80    edit=none align=right </FC>'
                      + '<FC>id=SLP_COST_TAMT      name="원가계"      width=80    edit=none align=right </FC>'
                      + '<FC>id=SLP_COST_TAMT      name="매가계"      width=80    edit=none align=right </FC>'
                      + '<FC>id=SLP_GAP_RATE       name="차익율"      width=80    edit=none align=right </FC>'
                      + '<FC>id=SLP_GAP_TOT_AMT    name="차익액합"    width=80    edit=none align=right show=false </FC>'
                      + '<FC>id=SKU_FLAG           name="단품구분"    width=80    edit=none align=right show=false </FC>'
                      + '<FC>id=STR_CD             name="점코드"      width=65    edit=none align=left show=false </FC>'
                      + '<FC>id=STR_NM             name="점"          width=60    edit=none align=left show=false </FC>'
                      + '<FC>id=BOTTLE_SLIP_YN     name="공병유무"    width=60    edit=none align=left show=false </FC>'
                      //+ '<FC>id=BIZ_TYPE           name="BIZ_TYPE"    width=60    edit=none align=left show=false </FC>'
                      //+ '<FC>id=FILE_CHECK         name="FILE_CHECK"  width=60    edit=none align=left show=false </FC>'
                      ;
                    
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
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

}

/**
 * btn_New()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {  
/*     
     if(!checkValidation("Save"))
         return false;
     
     DS_LIST.Addrow(); 
     GR_MASTER.SetColumn("SLIP_NO");
     GR_MASTER.Focus();     
*/     
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요    : 삭제버튼 클릭 (신규등록일 경우 DS_IO_MASTER 삭제, 기존데이터일 경우 삭제 Action실행)
 * return값 : void
 */
function btn_Delete() {
    
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
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
function btn_Print(){   
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */
 function btn_Conf() {
	 
	var checkCnt = 0;
	for (var i = 0; i < DS_LIST.CountRow; i++)
    {
        if(DS_LIST.NameValue(i + 1, "CHECK1") == "T"){ 
        	checkCnt = checkCnt + 1;
        }
        
        if(DS_LIST.NameValue(i + 1, "SLIP_NO") == ""){ 
            DS_LIST.DeleteRow(i + 1);
        }
    }
    
    if(checkCnt == 0){
        showMessage(INFORMATION, OK, "USER-1002", "처리할 전표"); 
        return;
    }
    
	//전표정합성체크
	if(!checkValidation("Save"))
		return false;	
	
	//검품확정 하시겠습니까?
	if( showMessage(STOPSIGN, YESNO, "USER-1187") != 1 )
	  return;
	
	var strConDt       = EM_S_START_DT.Text;         //검품확정일
	var k = 0;
	
	for (var i = 0; i < DS_LIST.CountRow; i++)
	{
	    if(DS_LIST.NameValue(i + 1, "CHECK1") == "T"){ 
	        
	        var strStrCd     = DS_LIST.NameValue(i + 1,"STR_CD");
	        var strSlipNo    = DS_LIST.NameValue(i + 1,"SLIP_NO");
	        var strSlipFlag  = DS_LIST.NameValue(i + 1,"SLIP_FLAG");
	        var strBotFlag   = DS_LIST.NameValue(i + 1,"BOTTLE_SLIP_YN");
	        var strOrdDt     = DS_LIST.NameValue(i + 1,"ORD_DT");
	        var strVenCd     = DS_LIST.NameValue(i + 1, "VEN_CD");
	        var strchkDt     = EM_S_START_DT.Text; // 검품확정일
            var strSkuFlag   = DS_LIST.NameValue(i + 1, "SKU_FLAG");
	        
	        // MARIO OUTLET
	        var strBizType   = DS_LIST.NameValue(i + 1, "BIZ_TYPE");
            var strFileCheck = DS_LIST.NameValue(i + 1, "FILE_CHECK");
            // MARIO OUTLET
         
	        //alert("strStrCd = " + strStrCd);
            // 검품확정상태 체크
            if(!getPreslipNo(i+1, strStrCd)){                                       
                DS_LIST.NameValue(i, "CHECK1") = 'F';
                setTimeout("GR_MASTER.SetColumn('SLIP_NO')", 50);
                GR_MASTER.Focus();
                return false;
            }

            // 재고실사 마감여부
            if(!chechJgDtFlag(strStrCd, strchkDt, DS_LIST.RowPosition)){
                returnflag = false;
                return false;         
            }

            
            // MARIO OUTLET
            if (strSlipFlag == "B" && strBizType == "1") {
            	if (strFileCheck == 0) {
            		showMessage(EXCLAMATION, OK, "GAUCE-1000", "직매입 반품 전표에 대한 증빙자료 첨부를 확인하세요.");
            		return false;
            	}
            }
            // MARIO OUTLET
            
//             // 시재 마감체크
//             if(!dayCloseCheck(strStrCd))
//                 return false;
            
            // 대금지불마감체크
            if(!chkPayClose(DS_LIST.RowPosition, strStrCd, strVenCd, strchkDt)){
                returnflag = false;
                return false;               
            }
            
            // 월 마감체크
            if(!closeCheck(strStrCd))
                return false;
            
            // 품목발주인지 단품발주인지 체크해야됨
            if(strSkuFlag == "2"){
                // 품목발주 마진율 비교하기위함
                if(!chkMgRate(strStrCd, strSlipNo, "", DS_LIST.RowPosition)){
                    return false;               
                }
            }else if(strSkuFlag == "1"){
                // 단품발주 매가비교하기위함
                if(!chkAppDtPrice(strStrCd, strSlipNo, "", DS_LIST.RowPosition)){
                    return;             
                }
            }
            
			var params = "&strConDt="+encodeURIComponent(strConDt)
			              + "&strStrCd="+encodeURIComponent(strStrCd)
			              + "&strSlipNo="+encodeURIComponent(strSlipNo)
			              + "&strSlipFlag="+encodeURIComponent(strSlipFlag)
			              + "&strBotFlag="+encodeURIComponent(strBotFlag);
			TR_MAIN.Action="/dps/pord212.po?goTo=conf"+params;
			TR_MAIN.Post();
	        
	        k = k+1;
	    }   
	}
	if (k==0){
	    showMessage(INFORMATION, OK, "USER-1002", "처리할 전표"); 
	} else{
	    showMessage(INFORMATION, OK, "USER-1202", k); 
	}    
	DS_LIST.ClearData();
 }
/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
 * getList(row)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  확정된 전표인지 확인
 * return값 : void
 */
 function getPreslipNo(row, strStrCd){

    var strSlpNo    = DS_LIST.NameValue(row,"SLIP_NO"); 
    
    var goTo        = "getPreslipNo" ;    
    var action      = "O";     
    var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)    
                    + "&strSlpNo="+encodeURIComponent(strSlpNo); 
    TR_L_MAIN.Action="/dps/pord212.po?goTo="+goTo+parameters;  
    TR_L_MAIN.KeyValue="SERVLET("+action+":DS_O_PRE_SLIP_NO=DS_O_PRE_SLIP_NO)"; //조회는 O
    TR_L_MAIN.Post();
     
    //해당전표가 존재하지 않는경우
    if(DS_O_PRE_SLIP_NO.CountRow >= 1){
        showMessage(EXCLAMATION, OK, "USER-1207");  
        return false;        
    }else{  
        return true;    
    } 
 }
 
 /**
 * getList(row)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getList(row){

    var strStrCd    = LC_O_STR.BindColVal;        //점    
    var strSlpNo    = DS_LIST.NameValue(row,"SLIP_NO"); 
    
    var goTo        = "getList" ;    
    var action      = "O";     
    var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strSlpNo="+encodeURIComponent(strSlpNo); 
    TR_L_MAIN.Action="/dps/pord212.po?goTo="+goTo+parameters;  
    TR_L_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_O_LIST)"; //조회는 O
    TR_L_MAIN.Post();
     
    //해당전표가 존재하지 않는경우
    if(DS_O_LIST.CountRow <= 0){
        showMessage(EXCLAMATION, OK, "USER-1069", "전표번호");   
        return false;
        
    }else{
        DS_LIST.NameValue(row,"SLIP_NO")          =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO")         ;
        DS_LIST.NameValue(row,"SLIP_FLAG")        =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_FLAG")       ;
        DS_LIST.NameValue(row,"SLIP_FLAG_NM")     =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_FLAG_NM")    ;
        DS_LIST.NameValue(row,"ORD_DT")           =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"ORD_DT")          ;
        DS_LIST.NameValue(row,"PUMBUN_CD")        =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"PUMBUN_CD")       ;
        DS_LIST.NameValue(row,"PUMBUN_NM")        =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"PUMBUN_NM")       ;
        DS_LIST.NameValue(row,"VEN_CD")           =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"VEN_CD")          ;
        DS_LIST.NameValue(row,"VEN_NM")           =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"VEN_NM")          ;
        DS_LIST.NameValue(row,"SLP_TQTY")         =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLP_TQTY")        ;
        DS_LIST.NameValue(row,"SLP_COST_TAMT")    =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLP_COST_TAMT")   ;
        DS_LIST.NameValue(row,"SLP_COST_TAMT")    =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLP_COST_TAMT")   ;
        DS_LIST.NameValue(row,"SLP_GAP_RATE")     =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLP_GAP_RATE")    ;
        DS_LIST.NameValue(row,"SLP_GAP_TOT_AMT")  =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLP_GAP_TOT_AMT") ;
        DS_LIST.NameValue(row,"SKU_FLAG")         =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SKU_FLAG")        ;
        DS_LIST.NameValue(row,"STR_CD")           =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_CD")          ;
        DS_LIST.NameValue(row,"STR_NM")           =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_NM")          ;
        DS_LIST.NameValue(row,"BOTTLE_SLIP_YN")   =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"BOTTLE_SLIP_YN")  ;    
        // MARIO OUTLET
        DS_LIST.NameValue(row,"BIZ_TYPE")         =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"BIZ_TYPE")        ;    
        DS_LIST.NameValue(row,"FILE_CHECK")       =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"FILE_CHECK")      ;    
        // MARIO OUTLET
        DS_LIST.NameValue(row, "CHECK1") = 'T';
  
        return true;    
    } 
 }
 /**
  * getListCheck(row)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-02-15
  * 개    요 :  마스터 리스트 조회
  * return값 : void
  */
  function getListCheck(row){

     var strStrCd    = LC_O_STR.BindColVal;        //점    
     var strSlpNo    = DS_LIST.NameValue(row,"SLIP_NO"); 
     
     var goTo        = "getList" ;    
     var action      = "O";     
     var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)     
                     + "&strSlpNo="+encodeURIComponent(strSlpNo); 
     TR_L_MAIN.Action="/dps/pord212.po?goTo="+goTo+parameters;  
     TR_L_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_O_LIST)"; //조회는 O
     TR_L_MAIN.Post();
      
     //해당전표가 존재하지 않는경우
     if(DS_O_LIST.CountRow <= 0){
         showMessage(EXCLAMATION, OK, "USER-1069", "전표번호");   
         return false;
         
     }else{
         DS_LIST.NameValue(row,"SLIP_NO")          =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_NO")         ;
         DS_LIST.NameValue(row,"SLIP_FLAG")        =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_FLAG")       ;
         DS_LIST.NameValue(row,"SLIP_FLAG_NM")     =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLIP_FLAG_NM")    ;
         DS_LIST.NameValue(row,"ORD_DT")           =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"ORD_DT")          ;
         DS_LIST.NameValue(row,"PUMBUN_CD")        =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"PUMBUN_CD")       ;
         DS_LIST.NameValue(row,"PUMBUN_NM")        =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"PUMBUN_NM")       ;
         DS_LIST.NameValue(row,"VEN_CD")           =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"VEN_CD")          ;
         DS_LIST.NameValue(row,"VEN_NM")           =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"VEN_NM")          ;
         DS_LIST.NameValue(row,"SLP_TQTY")         =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLP_TQTY")       ;
         DS_LIST.NameValue(row,"SLP_COST_TAMT")    =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLP_COST_TAMT")   ;
         DS_LIST.NameValue(row,"SLP_COST_TAMT")    =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLP_COST_TAMT")   ;
         DS_LIST.NameValue(row,"SLP_GAP_RATE")     =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLP_GAP_RATE")    ;
         DS_LIST.NameValue(row,"SLP_GAP_TOT_AMT")  =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SLP_GAP_TOT_AMT") ;
         DS_LIST.NameValue(row,"SKU_FLAG")         =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"SKU_FLAG")        ;
         DS_LIST.NameValue(row,"STR_CD")           =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_CD")          ;
         DS_LIST.NameValue(row,"STR_NM")           =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"STR_NM")          ;
         DS_LIST.NameValue(row,"BOTTLE_SLIP_YN")   =   DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"BOTTLE_SLIP_YN")  ;    
            
         return true;    
     } 
  }

/**
 * checkValidation(Gubun)
 * 작 성 자     : 박래형
 * 작 성 일     : 2010-02-28
 * 개    요        : 조회조건 값 체크 
 * Gubun : Search, Save, Delete
 * return값 : void
 */
function checkValidation(Gubun) {
     
     var messageCode = "USER-1001";

     switch (Gubun) {
     case "Search": 
         if(LC_O_STR.Text.length == 0){                                         // 점
               showMessage(EXCLAMATION, OK, messageCode, "점");
               LC_O_STR.Focus();
               return false;
         }  

         if(EM_S_START_DT.Text.length == 0){                                    // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회시작일");
             EM_S_START_DT.Focus();
             return false;
         }
         return true;
         break;
         
     case "Save":

         if(DS_LIST.CountRow<=0)
             return true;            

         var intRowCount   = DS_LIST.CountRow;
         
         if(intRowCount > 0){        	 
             for(var i=1; i <= intRowCount; i++){           

                 //var strOrdDt = DS_LIST.NameValue(i, "ORD_DT");
                 var strStrCd = DS_LIST.NameValue(i, "STR_CD");
                
                //저장시 체크된것만 확정 처리 한다.                
//                if(DS_LIST.NameValue(i, "CHECK1") == "T"){  // 체크된 전표만 정합성체크및 확정처리 한다	 
                	
                    //전표별 마감체크
                    if(!closeCheck(strStrCd)){                        
                        DS_LIST.NameValue(i, "CHECK1") = 'F';
                        setTimeout("GR_MASTER.SetColumn('SLIP_NO')", 50);
                        GR_MASTER.Focus();
                        return false;
                    }
                    
                    // 검품확정상태 체크
                    if(!getPreslipNo(i, strStrCd)){                                       
                        DS_LIST.NameValue(i, "CHECK1") = 'F';
                        setTimeout("GR_MASTER.SetColumn('SLIP_NO')", 50);
                        GR_MASTER.Focus();
                        return false;
                    }
                    
                    // 전표번호 체크
                    if(!getListCheck(i)){                                       
                        DS_LIST.NameValue(i, "CHECK1") = 'F';
                        setTimeout("GR_MASTER.SetColumn('SLIP_NO')", 50);
                        GR_MASTER.Focus();
                        return false;
                    }
                    
                    // 중복체크
                    var dupRow = checkDupKey(DS_LIST, "SLIP_NO");
                    if (dupRow > 0) {
                        showMessage(StopSign, Ok,  "USER-1044", dupRow);
                         
                        DS_LIST.RowPosition = dupRow;
                        GR_MASTER.SetColumn("SLIP_NO");
                        GR_MASTER.Focus(); 
    
                        return false;
                    }
//                }
             }
         }         
         
         return true;
         break;
     }     
}

/**
 * dayCloseCheck()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-08-25
 * 개    요    : 확정시 일 시재마감 체크
 * return값 : void
 */
 function dayCloseCheck(strStrCd){

     var strCloseDt       = EM_S_START_DT.Text;     // 검품확정일
     var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
     var strCloseUnitFlag = "06";                   // 단위업무
     var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
     var strCloseFlag     = "T";                    // 마감구분(시재마감:T)
    
     var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                   , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
     
     if(closeFlag == "TRUE"){
    	 showMessage(EXCLAMATION, OK, "USER-1150", "시재마감","검품확정");
         return false;
     }else{
         return true;
     }
 }  

/**
 * closeCheck()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-10
 * 개    요    : 저장시 일마감체크를 한다.
 * return값 : void
 */
 function closeCheck(strStrCd){

     var strCloseDt       = EM_S_START_DT.Text;     // 검품확정일
     var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
     var strCloseUnitFlag = "42";                   // 단위업무
     var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
     var strCloseFlag     = "M";                    // 마감구분(월마감:M)
    
     var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                   , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
     
     if(closeFlag == "TRUE"){
         showMessage(INFORMATION, OK, "USER-1068", "매입일","발주매입");
         return false;
     }else{
         return true;
     }
 }  
 
 /**
  * chkPayClose()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-08-12
  * 개    요 :  대금지불 마감 체크
  * return값 : void
  */
  function chkPayClose(row, strStrCd, strVenCd, strChkDt){
      
      
     var goTo       = "chkPayClose" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strVenCd="+encodeURIComponent(strVenCd)    
                    + "&strChkDt="+encodeURIComponent(strChkDt);     
     TR_MAIN.Action="/dps/pord212.po?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_PAY_CLOSE_CHK=DS_PAY_CLOSE_CHK)"; //조회는 O
     TR_MAIN.Post(); 
     if(DS_PAY_CLOSE_CHK.NameValue(DS_PAY_CLOSE_CHK.RowPosition, "RET_FLAG") == "TRUE"){
         showMessage(INFORMATION, OK, "USER-1220", "대금지불");
         return false;
     }else{
         return true;
     }
     
      return true;
  }

  /**
   * chkMgRate(strStrCd, strSlipNo, strSendFlag)
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-07-24
   * 개    요    : 확정시 비단품 마진적용일 체크
   * return값 : void
   */
   function chkMgRate(strStrCd, strSlipNo, strSendFlag, rowPosition){    
     
     var strreturnValue = "";
     
     var goTo       = "chkMgRate" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                    + "&strSlipNo="+encodeURIComponent(strSlipNo) 
                    + "&strSendFlag="+encodeURIComponent(strSendFlag);  
     TR_MAIN.Action="/dps/pord212.po?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_MG_RATE=DS_MG_RATE)"; //조회는 O
     TR_MAIN.Post(); 
     
     strreturnValue = parseInt(DS_MG_RATE.NameValue(1, "RETURN_INT"));             
     var ssssmmm    = DS_MG_RATE.NameValue(1, "RETURN_MESSAGE");
     if(strreturnValue != 0){  
         showMessage(EXCLAMATION, OK, "SCRIPT-1000", ssssmmm);
         return false;
     }
     return true;
   }

   /**
    * chkAppDtPrice(strStrCd, strSlipNo, strSendFlag)
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-07-21
    * 개    요    : 확정시 단품 가격정합성체크
    * return값 : void
    */
    function chkAppDtPrice(strStrCd, strSlipNo, strSendFlag, rowPosition){    

        var strreturnValue = null;
        
        var goTo       = "chkAppDtPrice" ;    
        var action     = "O";     
        var parameters = "&strStrCd="+encodeURIComponent(strStrCd)  
                       + "&strSlipNo="+encodeURIComponent(strSlipNo)
                       + "&strSendFlag="+encodeURIComponent(strSendFlag);  
        TR_MAIN.Action="/dps/pord212.po?goTo="+goTo+parameters;  
        TR_MAIN.KeyValue="SERVLET("+action+":DS_APPDT_PRICE=DS_APPDT_PRICE)"; //조회는 O
        TR_MAIN.Post(); 
          
        var ssssmmm    = DS_APPDT_PRICE.NameValue(1, "RETURN_MESSAGE");
        strreturnValue = parseInt(DS_APPDT_PRICE.NameValue(1, "RETURN_INT")); 
        
        //alert(ssssmmm);
        if(strreturnValue != 0){  
          setFocusGrid(GR_MASTER, DS_O_LIST, rowPosition, "CHECK1");      // 선택으로 포커스
            showMessage(EXCLAMATION, OK, "SCRIPT-1000", ssssmmm);
          return false;
        }
    
        return true;
    }
    /**
     * chechJgDtFlag(strStrCd, strChkDt, strSendFlag)
     * 작 성 자 : 박래형
     * 작 성 일 : 2011-09-29
     * 개    요    : 검품확정시 재고실사마감체크여부
     * return값 : void
     */
     function chechJgDtFlag(strStrCd, strChkDt, rowPosition){    
         var strreturnValue = "";
         
         var goTo       = "chechJgDtFlag" ;    
         var action     = "O";     
         var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                        + "&strChkDt="+encodeURIComponent(strChkDt);  
         TR_MAIN.Action="/dps/pord212.po?goTo="+goTo+parameters;  
         TR_MAIN.KeyValue="SERVLET("+action+":DS_CHK_JG_FLAG=DS_CHK_JG_FLAG)"; //조회는 O
         TR_MAIN.Post(); 

         strreturnValue = DS_CHK_JG_FLAG.NameValue(1, "CHK_JG_FLAG");     
         var ssssmmm = "재고실사가 마감되어 실사일 이전으로 검품확정할수 없습니다.";
         if(strreturnValue == "FALSE"){  
             setFocusGrid(GR_MASTER, DS_O_LIST, rowPosition, "CHECK1");      // 선택으로 포커스
             showMessage(EXCLAMATION, OK, "SCRIPT-1000", ssssmmm);
             return false;
         }
         return true;
     }

 /**
 * addDetailRow()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-17
 * 개    요    : 행추가
 * return값 : void
 */

 function addDetailRow(){
	      
     if(!checkValidation("Save"))
         return false;
     
     DS_LIST.Addrow(); 
     GR_MASTER.SetColumn("SLIP_NO");
     GR_MASTER.Focus();     

 }

 /**
 * delDetailRow()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-17
 * 개    요    : 행삭제
 * return값 : void
 */

 function delDetailRow(){
	
	if(DS_LIST.CountRow == 0){
	    showMessage(EXCLAMATION, OK, "USER-1019");
	    return;
	}
	
	sel_DeleteRow( DS_LIST, "CHECK1" );
	
	//그리드 CHEKCBOX헤더 체크해제
	GR_MASTER.ColumnProp('CHECK1','HeadCheck')= "false";   
 }
 
/**
* setEventFlagDs()
* 작 성 자 : 박래형
* 작 성 일 : 2010-03-17
* 개    요    : 행사구분 데이터셋 복사
* return값 : void
*/

function setMasterDs(){

    DS_CHECKMASTER.ClearData();         //복사될 데이터셋 초기화  
    var setChkMaster = DS_LIST.ExportData(1,DS_LIST.CountRow, true ); 
    DS_CHECKMASTER.ImportData(setChkMaster);   
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
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>


<script language=JavaScript for=TR_L_MAIN event=onSuccess>
    for(i=0;i<TR_L_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_L_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_L_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--  ===================DS_IO_MASTER============================ -->
<!-- Grid DS_IO_MASTER 변경시 DS_LIST의 마스터 내용 변경 -->

<!--  ===================DS_IO_MASTER============================ -->

<script language=JavaScript for=DS_LIST event=CanRowPosChange(row)>
</script>

<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)>
</script>

<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
</script>

<script language=JavaScript for=DS_MASTER event=onRowPosChanged(row)>
</script>

<script language=JavaScript for=DS_MASTER
    event=OnColumnChanged(row,colid)>

</script>

<!--  ===================DS_LIST============================ -->
<!--  DS_LIST 변경시 -->
<script language=JavaScript for=DS_LIST event=OnColumnChanged(row,colid)>

    if(clickSORT) 
       return;

    var newValue = DS_LIST.NameValue(row, "SLIP_NO"); 
    //var strStrCd = DS_LIST.NameValue(row, "STR_CD"); 
    var strStrCd = LC_O_STR.BindColVal;
    switch (colid) {
       case "SLIP_NO":
    	   if(DS_LIST.NameValue(row, "SLIP_NO").length == 11){
    		   
               if(!getPreslipNo(row, strStrCd)){
                   
                   DS_LIST.NameValue(i, "CHECK1") = 'F';
                   setTimeout("GR_MASTER.SetColumn('SLIP_NO')", 50);
                   GR_MASTER.Focus();
                   return;
               }
            	   
               if(getList(row)){
	        	   DS_LIST.Addrow(); 
	        	   setTimeout("GR_MASTER.SetColumn('SLIP_NO')", 50);
	        	   GR_MASTER.Focus();  
                   return;
               }else{
                   DS_LIST.NameValue(row, "CHECK1") = 'F';
                   setTimeout("GR_MASTER.SetColumn('SLIP_NO')", 50);
                   GR_MASTER.Focus();
               }    		   
    	   }
        break;   
     } 
</script>

<!-- 디테일 삭제시 컴퍼넌트 총금액-->
<script language=JavaScript for=DS_LIST event=OnRowDeleted(row)>   
 
</script>


<!-- GR_MASTER CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_MASTER event=CanColumnPosChange(Row,Colid)>

</script>

<!-- 디테일 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_MASTER
    event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHECK1") {
        if (bCheck == 1) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHECK1") = "T";
            }    
            GR_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHECK1") = "F";
            } 
            GR_MASTER.Redraw = true;
        }
    }
</script>

<!--  ===================GR_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->

<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); 
</script>



<!--*************************************************************************-->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_START_DT event=OnKillFocus()>
//    checkDateTypeYMD( EM_S_START_DT );
    
    var strSyyyymmdd = strToday ;
    checkDateTypeYMD( EM_S_START_DT, strSyyyymmdd );
    if (EM_S_START_DT.Text < strToday){
        showMessage(StopSign, OK, "USER-1180", "검품확정일");
        EM_S_START_DT.Text = strToday;
    } 
     
</script>


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
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DEPT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_TEAM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PC" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_GJDATE_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PROC_STAT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_LIST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_LIST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PRE_SLIP_NO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_CHECKMASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_PAY_CLOSE_CHK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_MG_RATE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_APPDT_PRICE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_CHK_JG_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_L_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
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
<body onLoad="doInit();" class="PL10 PT15 ">

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
                        <th class="point" width="70">점</th>
                        <td width="210"><comment id="_NSID_"> <object
                            id=LC_O_STR classid=<%=Util.CLSID_LUXECOMBO%> 
                            width=200 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th class="point">검품확정일</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_S_START_DT classid=<%=Util.CLSID_EMEDIT%> width=200
                            tabindex=1 align="absmiddle" > </object> </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:openCal('G',EM_S_START_DT)" align="absmiddle" />
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
        <td class="right" valign="bottom"><img
            src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD" width="52"
            height="18" hspace="2" onclick="javascript:addDetailRow();" /><img
            src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL" width="52"
            height="18" onclick="javascript:delDetailRow();" /></td>
    </tr>     
    <tr>
        <td height="5"></td>
    </tr> 
    <tr valign="top">
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_MASTER
                            width=100% height=482 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_LIST">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table> 
                </td>
            </tr>            
        </table> 
        </td>
    </tr>
</table>
</div>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_LIST>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
<body>
</html>



