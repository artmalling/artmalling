<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주매입 > 택발행 > 자동TAG발행
 * 작 성 일 : 2010.01.18
 * 작 성 자 : 심명섭
 * 수 정 자 : 
 * 파 일 명 : pord3030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : TAG발행의뢰 발행
 * 이    력 : 2010.01.25 박래형
 * 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"          prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
String dir = BaseProperty.get("context.common.dir");
//기본 URL
String u = javax.servlet.http.HttpUtils.getRequestURL(request).toString(); 
String webDir = u.substring(0, u.lastIndexOf("dps")-1);
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

var inta              = 0;
var bfListRowPosition = 0;                           // 이전 List Row Position
var strToday          = "";

var g_checkCnt        = 0;  //마스터 체크수(택 출력할때 1건 체크시 VS 아닐때 구분하기 위함)
var g_masterCheckRow  = 0;  //마스터 한건 체크시 해당로우

var g_CanrowPosChangedFlag = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top2 = 550;		//해당화면의 동적그리드top위치

 function doInit(){
	 
     //Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";
	
     strToday        = getTodayDB("DS_O_RESULT");

     // Input Data Set Header 초기화

     // Output Data Set Header 초기화
     DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
     DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
     DS_IO_DETAIL2.setDataHeader('<gauce:dataset name="H_SEL_DETAIL2"/>');  
     
     //탭 초기화(품목)
     initTab('TAB_01');
     
     //그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일(품목)
     gridCreate3(); //디테일(단품)
     
     // EMedit에 초기화
     initEmEdit(EM_DELI_DT1     ,"SYYYYMMDD"       , PK);      //납품예정일
     initEmEdit(EM_DELI_DT2     ,"TODAY"           , PK);      //납품예정일2
     initEmEdit(EM_S_PUMBUN_CD  ,"000000"          , NORMAL);  //브랜드코드
     initEmEdit(EM_S_PUMBUN_NM  ,"GEN"             , READ);    //브랜드명                                                                    
     initEmEdit(RD_FLAG         ,"GEN"             , PK);      //구분  
     initEmEdit(EM_S_SLIP_NO    ,"0000-0-0000000"  , NORMAL);  //전표번호
     initEmEdit(EM_S_PRT_YYYY   ,"0000"            , PK);      //생산년도  

     initComboStyle(LC_S_STR_CD,DS_O_STR_FLAG, "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
     getStore("DS_O_STR_FLAG", "Y", "", "N");                   // 점      
     
     //콤보 초기화
     initComboStyle(LC_I_TAG_FLAG, DS_TAG_FLAG,  "CODE^0^30,NAME^0^80", 1, PK);       //조회용 택구분    
     initComboStyle(LC_O_PRT_FLAG, DS_O_PRT_FLAG, "CODE^0^30,NAME^0^80", 1, PK);  //발행기(출력)
     
     //시스템 코드 공통코드에서 발행기 가지고 오기    
     getEtcCode("DS_O_PRT_FLAG",   "D", "P232", "N");       // 발행기 
     getEtcCode("DS_ORD_UNIT_CD",  "D", "P013", "N");       // 단위 
     getEtcCode("DS_TAG_FLAG",     "D", "P063", "N");       // 택구분      

    
    //사용되는 데이터셋 등록
    //argument[0] : Program ID
    //argument[1] : 변경여부 확인 대상 데이터셋 ','로 구분
    //registerUsingDataset("tcom101","DS_IO_DETAIL,DS_O_DETAIL")
    registerUsingDataset("pord303","DS_IO_DETAIL,DS_O_DETAIL" );
    registerUsingDataset("pord303","DS_IO_DETAIL2,DS_O_DETAIL2" );
     
//    EM_DELI_DT1.Text = "20100331";
    LC_S_STR_CD.Index   = 0;
    LC_O_PRT_FLAG.Index = 0;
    LC_I_TAG_FLAG.Index = 0;
 }

function gridCreate1(){
    var hdrProperies = '<FC>id=CHECK1                 name="선택"        width=50     align=center EditStyle=CheckBox  HeadCheckShow=true </FC>'
                     + '<FC>id=STR_CD                name="점"          width=60     edit=none align=left show=false</FC>'
                     + '<FC>id=DELI_DT               name="납품예정일"   width=80     edit=none align=center mask=XXXX-XX-XX </FC>'
                     + '<FC>id=SLIP_NO               name="전표번호"     width=130    edit=none align=center mask=XXXX-X-XXXXXXX</FC>'
                     + '<FG> name = "브랜드" '
                     + '<FC>id=PUMBUN_CD             name="코드"     width=70     edit=none align=center</FC>'
                     + '<FC>id=PUMBUN_NM             name="명"       width=100    edit=none align=left</FC>'
                     + '</FG>'
                     + '<FG> name = "협력사" '
                     + '<FC>id=VEN_CD                name="코드"   width=60    edit=none align=center</FC>'
                     + '<FC>id=VEN_NM                name="명"     width=120    edit=none align=left </FC>'
                     + '</FG>'
                     + '<FC>id=BIZ_TYPE_NM           name="거래형태"     width=60    edit=none align=left </FC>'
                     + '<FG> name = "TAG 발행" '
                     + '<FC>id=TAG_PRT_YN            name="여부"     width=40    edit=none align=center show=false </FC>'
                     + '<FC>id=TAG_PRT_DT            name="일자"     width=80    edit=none align=center show=false mask=XXXX-XX-XX </FC>'
                     + '<FC>id=TAG_PRT_CNT           name="수량"     width=40    edit=none align=right  show=false </FC>'
                     + '</FG>'
                     + '<FG> name = "단품" '
                     + '<FC>id=SKU_FLAG              name="구분"     width=100    edit=none align=right show=false</FC>'
                     + '<FC>id=SKU_TYPE              name="종류"     width=100    edit=none align=right show=false</FC>'
                     + '</FG>'
                     + '<FC>id=TAG_FLAG              name="택구분"   width=60    edit=none align=right </FC>';                   
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, true);
}

// 품목  mask="###,###" 
function gridCreate2(){
    var hdrProperies = '<FC>id=CHECK1                name="선택"         width=50     align=center EditStyle=CheckBox  HeadCheckShow=true </FC>'
			         + '<FC>id=PUMBUN_CD             name="브랜드코드"     width=70     edit=none align=center show=false</FC>'
			         + '<FC>id=PUMBUN_NM             name="브랜드명"       width=100    edit=none align=left show=false</FC>'
			         + '<FC>id=PBN_RECP_NM           name="영수증명"       width=100    edit=none align=left show=false</FC>'
                     + '<FC>id=PUMMOK_SRT_CD         name="단축코드"      width=60   align=center   edit=none </FC>'
                     + '<FC>id=PUMMOK_CD             name="품목코드"      width=80   align=center   edit=none </FC>'
                     + '<FC>id=PMK_RECP_NM           name="품목명"        width=120  align=left</FC>'
                     + '<FC>id=ORD_UNIT_CD           name="단위"          width=80   align=center   edit=none  EditStyle=Lookup  Data="DS_ORD_UNIT_CD:CODE:NAME"</FC>'
                     + '<FC>id=ORD_QTY               name="수량"          width=80   align=right    mask="###,###" edit=none </FC>'
                     + '<FG> name = "매가"'           
                     + '<FC>id=NEW_SALE_PRC          name="단가"          width=100   align=right   mask="###,###" edit=none </FC>'
                     + '<FC>id=NEW_SALE_PRC1         name="단가"          width=100   align=right   mask="###,###" edit=none show=false</FC>'
                     + '<FC>id=NEW_SALE_AMT          name="금액"          width=100   align=right   mask="###,###" edit=none </FC></FG>'
                     + '<FC>id=PRINT_QTY             name="출력수량"       width=80   align=right    mask="###,###"  </FC>'
                     ;

    initGridStyle(GR_DETAIL, "common", hdrProperies, true);
}

// 단품  mask="###,###" 
function gridCreate3(){
    var hdrProperies = '<FC>id=CHECK1                name="선택"          width=50     align=center EditStyle=CheckBox  HeadCheckShow=true </FC>'
			          + '<FC>id=PUMBUN_CD             name="브랜드코드"     width=70     edit=none align=center show=false</FC>'
			          + '<FC>id=PUMBUN_NM             name="브랜드명"       width=100    edit=none align=left show=false</FC>'
			          + '<FC>id=PBN_RECP_NM           name="영수증명"       width=100    edit=none align=left show=false</FC>'
  		             + '<FC>id=PUMMOK_SRT_CD         name="단축코드"       width=60   align=center   edit=none </FC>'
  		             + '<FC>id=PUMMOK_NM             name="품목명"        width=60   align=center   edit=none show=false </FC>'
                     + '<FC>id=PMK_RECP_NM           name="품목영수증명"        width=120  align=left</FC>'
                     + '<FC>id=SKU_CD                name="단품코드"       width=100    align=center    edit=none </FC>'
                     + '<FC>id=SKU_RECP_NM           name="단품명"        width=120    align=left</FC>'
                     + '<FC>id=STYLE_CD              name="스타일"        width=100    align=left      edit=none </FC>'
                     + '<FC>id=COLOR_CD              name="칼라"          width=100    align=left      edit=none </FC>'
                     + '<FC>id=SIZE_CD               name="사이즈"        width=100    align=center    edit=none </FC>'
                     + '<FC>id=ORD_UNIT_CD           name="단위"          width=80     align=center    edit=none  EditStyle=Lookup  Data="DS_ORD_UNIT_CD:CODE:NAME"</FC>'
                     + '<FC>id=ORD_QTY               name="수량"          width=80     align=right    mask="###,###" edit=none </FC>'
                     + '<FG> name = "매가"'          
                     + '<FC>id=NEW_SALE_PRC          name="단가"          width=100    align=right    mask="###,###" edit=none </FC>'
                     + '<FC>id=NEW_SALE_AMT          name="금액"          width=100    align=right    mask="###,###" edit=none </FC></FG>'
                     + '<FC>id=PRINT_QTY             name="출력수량"       width=80   align=right    mask="###,###" </FC>'
                     ;
                     
    initGridStyle(GR_DETAIL2, "common", hdrProperies, true);
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
 * 작 성 일 : 2010-01-25
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

	g_checkCnt        = 0;
	g_masterCheckRow  = 0;
	g_CanrowPosChangedFlag = false;
	
    GR_MASTER.ColumnProp('CHECK','HeadCheck')= "false";   
    DS_O_MASTER.ClearData();  
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL2.ClearData();
    DS_PRINT.ClearData();
    inta = 0;
    bfListRowPosition = 0;
    
    if(!checkValidation("Search"))
        return false;
    showMaster();   //마스터 조회

    GR_DETAIL.Editable  = true;
    GR_DETAIL2.Editable = true; 
    setPorcCount("SELECT", GR_MASTER);  
}

/**
 * btn_New()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개       요 : 
 * return값 : void
 */
function btn_New() {
    //그리드 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    DS_IO_DETAIL2.setDataHeader('<gauce:dataset name="H_SEL_DETAIL2"/>');
    tagflag.checked = true;
    initEmEdit(EM_DELI_DT1, "TODAY", PK);    //납품예정기간
}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개       요 : 
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개       요 : 
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개       요 : 
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010.06.03
 * 개       요 : 택발행기에 보낼 리스트 셋팅
 * return값 : void
 */
function btn_Print() {
	 
//     if(EM_S_PRT_YYYY.Text.length == 0){
//         showMessage(EXCLAMATION, OK, "USER-1002", "생산년도");
//         EM_S_PRT_YYYY.Focus();
//         return false;
//     }

	 if(!DS_O_MASTER.IsUpdated){
	     showMessage(EXCLAMATION, OK, "USER-1210");
         return;
	 }
	 
     if(!tagPrint()){     // 택발행한다.
    	 
         return;
     }     

     updTagFlagData(); // 택발행한 데이터 정보를 수정한다.

     //alert("업데이트함수 두번째");
     btn_Search();   // 데이터 수정하기때문에 데이터 재조회한다.
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개       요 : 
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/


 /**
  * tagPrint()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010.06.03
  * 개       요 : 택발행기에 보낼 리스트 셋팅
  * return값 : void
  */
 function tagPrint(){
    // 선택박스 체크 해제
    GR_MASTER.ColumnProp('CHECK','HeadCheck')= "false";
    var returnFlag = null;  //리턴값(true 일때 정상적으로 실행됨)
    
    var strMMYY     = strToday.substring(2,4) + strToday.substring(4,6) ; 
    var strPrtYY    = EM_S_PRT_YYYY.Text.substring(3,4);
    
    var arrStrCd    = new Array();       // 점코드
    var arrSlipNo   = new Array();       // 전표번호    
    var strSkuflag  = "";                // 단품구분             
    var strSkuType  = new Array();       // 1:규격단품 3:의류단품
    var strTagType  = "";                // 1S:단품(규격, 의류))  2M,2H,2S:비단품
    var strTagSize  = "";                // 택사이즈
    var tempBarCode = "";                // 바크드에 체크 코드 및 12자기 코드 만들기 LINE3의 체크디지트
    var tempBarCode2= "";                // 바크드에 체크 코드 및 12자기 코드 만들기 LINE4의 체크디지트
    var dataset     = "";                // 택발행할 데이터셋 정하기 위한 가상데이터셋 셋팅(단품VS품목)
    var retVal      = false;
    
    // 단품(규격, 의류)
    var arrLines1   = new Array();
    var arrLines2   = new Array();
    var arrLines3   = new Array();
    var arrLines4   = new Array();
    var arrLines5   = new Array();
    var arrLines6   = new Array();
    var arrLines7   = new Array(); 
    var arrLines8   = new Array();
    var arrCnts     = new Array();

	arrayIndex = 0;     
    
    arrLines1[arrayIndex] = "";
    arrLines2[arrayIndex] = "";
    arrLines3[arrayIndex] = "";
    arrLines4[arrayIndex] = "";
    arrLines5[arrayIndex] = "";
    arrLines6[arrayIndex] = "";
    arrLines7[arrayIndex] = "";
    arrLines8[arrayIndex] = "";
    arrCnts[arrayIndex] = "";

    strSkuflag      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SKU_FLAG");      // 품목인지 단품인지 알기위함
    strTagType      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TAG_FLAG");      // 택구분 1S:단품(규격, 의류))  2M,2H,2S:비단품
    
    var intLoofCount    = 0;    // 데이터셋의 총로우
    var arrSkuTypeIndex = 0;    // 선택된 마스터별 단품종류(단품일때만 사용 1:규격, 3:의류)
    var arrayIndex      = 0;    // 배열 변수의 인덱스
    var detailCnt       = 0;    // 디테일 조회수(하나의 마스터에 대한)
    intLoofCount        = DS_O_MASTER.CountRow;
    
    if(g_checkCnt > 1){ //마스터 체크가 멀티일때(디테일 체크 못함)
    	if(strSkuflag == "1"){  //단품
            for(var i=1; i<=intLoofCount; i++){
                if(DS_O_MASTER.NameValue(i, "CHECK1") == "T"){
                    printDetail2(i);     
                    strSkuType = DS_O_MASTER.NameValue(i, "SKU_TYPE");      //단품종류(1:규격, 3:의류)
                 
                    for(detailCnt=1; detailCnt<=DS_TMP.CountRow; detailCnt++){  
                        
                        arrLines1[arrayIndex] = "";
                        arrLines2[arrayIndex] = "";
                        arrLines3[arrayIndex] = "";
                        arrLines4[arrayIndex] = "";
                        arrLines5[arrayIndex] = "";
                        arrLines6[arrayIndex] = "";
                        arrLines7[arrayIndex] = "";
                        arrLines8[arrayIndex] = "";
                        arrCnts[arrayIndex] = "";
                        
                        if(strSkuType == "1"){                //규격단품   
                            
							// 1. line1 : // STR_NM (점명)                                                   
							// 2. line2 : // PBN_RECP_NM+(BIZ_TYPE_NM+TAX_FLAG_NM) (브랜드 영수증명+거래형태(특,직)+과세구분) 
							// 3. line3 : // SKU_CD (단품코드)                                                  
							// 4. line4 : // SKU_NM (단품코드 명)                                                
							// 5. line5 : // SALE_PRC (금액)                                                  
							// 8. line8 : // strSkuType (단품종류(1:규격, 3:의류))                                  
							
							arrLines1[arrayIndex] = DS_TMP.NameValue(detailCnt, "STR_NM"); 
							arrLines2[arrayIndex] = DS_TMP.NameValue(detailCnt, "PBN_RECP_NM") 
							                      + "("
											      + DS_TMP.NameValue(detailCnt, "BIZ_TYPE_NM") 
											      + DS_TMP.NameValue(detailCnt, "TAX_FLAG_NM")
							                      + ")";
							arrLines3[arrayIndex] = DS_TMP.NameValue(detailCnt, "SKU_CD");
							arrLines4[arrayIndex] = DS_TMP.NameValue(detailCnt, "SKU_NM");
							arrLines5[arrayIndex] = DS_TMP.NameValue(detailCnt, "NEW_SALE_PRC");
							arrLines6[arrayIndex] = "";
							arrLines7[arrayIndex] = "";
							arrLines8[arrayIndex] = strSkuType;
//                             arrCnts[arrayIndex]   = DS_TMP.NameValue(detailCnt, "ORD_QTY"); 
                            arrCnts[arrayIndex]   = DS_TMP.NameValue(detailCnt, "PRINT_QTY"); 
                            
                            if(arrCnts[arrayIndex] % 2 == 0){
                                arrCnts[arrayIndex] = arrCnts[arrayIndex] / 2;
                            }else{
                                arrCnts[arrayIndex] = (arrCnts[arrayIndex] + 1) / 2;
                            }
                            arrayIndex = arrayIndex + 1;
                            
                        }else if(strSkuType == "3"){          //의류단품         
                        	
                        	// 1. line1 : // STR_NM (점명)                                                   
                        	// 2. line2 : // strMMYY (년월)
                        	// 3. line3 : // SEASON_NM+PUMMOK_NM (시즌+품목명)                                                           
                        	// 4. line4 : // SKU_CD (단품코드)                                       
                        	// 5. line5 : // SKU_NM+COLOR_NM+SIZE_NM (단품명+컬러+사이즈)         
                        	// 6. line6 : // SALE_PRC (금액) 
                        	// 8. line8 : // strSkuType (단품종류(1:규격, 3:의류))

                        	arrLines1[arrayIndex] = DS_TMP.NameValue(detailCnt, "STR_NM");
                        	arrLines2[arrayIndex] = strMMYY;
                        	arrLines3[arrayIndex] = DS_TMP.NameValue(detailCnt, "SEASON_NM") + " "
                        	                      + DS_TMP.NameValue(detailCnt, "PUMMOK_NM");
                        	arrLines4[arrayIndex] = DS_TMP.NameValue(detailCnt, "SKU_CD");
                        	arrLines5[arrayIndex] = DS_TMP.NameValue(detailCnt, "SKU_NM")   + " "
                        	                      + DS_TMP.NameValue(detailCnt, "COLOR_NM") + " "
                        	                      + DS_TMP.NameValue(detailCnt, "SIZE_NM");
                        	arrLines6[arrayIndex] = DS_TMP.NameValue(detailCnt, "SALE_PRC");
                        	arrLines7[arrayIndex] = "";
                        	arrLines8[arrayIndex] = strSkuType;
//                             arrCnts[arrayIndex]   = DS_TMP.NameValue(detailCnt, "ORD_QTY"); 
                            arrCnts[arrayIndex]   = DS_TMP.NameValue(detailCnt, "PRINT_QTY"); 
                            
                            if(arrCnts[arrayIndex] % 2 == 0){
                                arrCnts[arrayIndex] = arrCnts[arrayIndex] / 2;
                            }else{
                                arrCnts[arrayIndex] = (arrCnts[arrayIndex] + 1) / 2;
                            }
                            
                            arrayIndex = arrayIndex + 1;                              
                        }                       
                    }
                 }
            } 
        
        }else{                  //품목
            if(strTagType == "2M" || strTagType == "2H" || strTagType == "2S"){
                for(var i=1; i<=intLoofCount; i++){
                    if(DS_O_MASTER.NameValue(i, "CHECK1") == "T"){
                        printDetail1(i);
                                                
                        for(detailCnt=1; detailCnt<=DS_TMP.CountRow; detailCnt++){
                            
                            arrLines1[arrayIndex] = "";		// STR_NM + BIZ_TYPE_NM (점명 + 거래형태(특, 직))
                            arrLines2[arrayIndex] = "";		// PBN_RECP_NM (브랜드 영수증명)
                            arrLines3[arrayIndex] = "";		// EVENT_FLAG (행사구분)
                            arrLines4[arrayIndex] = "";		// PMK_RECP_NM (품목 영수증명) 
                            arrLines5[arrayIndex] = "";		// 21+PUMBUN_CD+PUMMOK_SRT_CD+C/D (21+브랜드코드+품목단축코드+C/D) 
                            arrLines6[arrayIndex] = "";		// 29+EVENT_FLAG+SALE_PRC+C/D (21+행사구분+단가+C/D)
                            arrLines7[arrayIndex] = "";		// SALE_PRC (금액)
                            arrLines8[arrayIndex] = "";
                            arrCnts[arrayIndex]   = "";		// 수량
                            
                        	// 2M
							// 1. line1 : STR_NM + BIZ_TYPE_NM (점명 + 거래형태(특, 직))
							// 2. line2 : PBN_RECP_NM (브랜드 영수증명)
							// 3. line3 : EVENT_FLAG (행사구분)
							// 4. line4 : PMK_RECP_NM (품목 영수증명) 
							// 5. line5 : 21+PUMBUN_CD+PUMMOK_SRT_CD+C/D (21+브랜드코드+품목단축코드+C/D) 
							// 6. line6 : 29+EVENT_FLAG+SALE_PRC+C/D (21+행사구분+단가+C/D)
							// 7. line7 : SALE_PRC (금액)
							
							arrLines1[arrayIndex] = DS_TMP.NameValue(detailCnt, "STR_NM") + "" + DS_TMP.NameValue(detailCnt, "BIZ_TYPE_NM");
							arrLines2[arrayIndex] = DS_TMP.NameValue(detailCnt, "PBN_RECP_NM");
							arrLines3[arrayIndex] = DS_TMP.NameValue(detailCnt, "EVENT_FLAG");
							arrLines4[arrayIndex] = DS_TMP.NameValue(detailCnt, "PMK_RECP_NM");
							tempBarCode  = "21" + DS_TMP.NameValue(detailCnt, "PUMBUN_CD")
							                    + DS_TMP.NameValue(detailCnt, "PUMMOK_SRT_CD");
							arrLines5[arrayIndex] = tempBarCode + getSkuCdCheckSum(tempBarCode);
							tempBarCode2 = "29" + DS_TMP.NameValue(detailCnt, "EVENT_FLAG")
							                    + lpad(DS_TMP.NameValue(detailCnt, "NEW_SALE_PRC")+"", 8, "0");
							arrLines6[arrayIndex] = tempBarCode2 + getSkuCdCheckSum(tempBarCode2);
                            arrLines7[arrayIndex] = DS_TMP.NameValue(detailCnt, "NEW_SALE_PRC"); 
//                             arrCnts[arrayIndex]   = DS_TMP.NameValue(detailCnt, "ORD_QTY");
                            arrCnts[arrayIndex]   = DS_TMP.NameValue(detailCnt, "PRINT_QTY");
                               
                            if(arrCnts[arrayIndex] % 2 == 0){
                                arrCnts[arrayIndex] = arrCnts[arrayIndex] / 2;
                            }else{
                                arrCnts[arrayIndex] = (arrCnts[arrayIndex] + 1) / 2;
                            }
                               
                            arrayIndex = arrayIndex + 1;
                        }          
                    }
                }
            }
        } 
    }else{  //g_checkCnt가 1건 일때 ( 디테일 체크건만 출력한다) 20100707 현업요청 추가 박래형

        if(strSkuflag == "1"){  //단품
            for(var i=1; i<=intLoofCount; i++){
                if(DS_O_MASTER.NameValue(i, "CHECK1") == "T"){
                    //printDetail2(i);     
                    strSkuType = DS_O_MASTER.NameValue(i, "SKU_TYPE");      //단품종류(1:규격, 3:의류)
                 
                    for(detailCnt=1; detailCnt<=DS_IO_DETAIL2.CountRow; detailCnt++){ 
                    	
                    	if(!DS_IO_DETAIL2.IsUpdated){
                            showMessage(EXCLAMATION, OK, "USER-1208");
                            returnFlag = false; //업데이트 못하게 한다.
                    		return;
                    	}

                    	if(DS_IO_DETAIL2.NameValue(detailCnt, "CHECK1") == "T"){
                            
                            arrLines1[arrayIndex] = "";
                            arrLines2[arrayIndex] = "";
                            arrLines3[arrayIndex] = "";
                            arrLines4[arrayIndex] = "";
                            arrLines5[arrayIndex] = "";
                            arrLines6[arrayIndex] = "";
                            arrLines7[arrayIndex] = "";
                            arrLines8[arrayIndex] = "";
                            arrCnts[arrayIndex] = "";

                            if(strSkuType == "1"){                //규격단품   
                            	
                            	// 1. line1 : // STR_NM (점명)                                                   
                            	// 2. line2 : // PBN_RECP_NM+(BIZ_TYPE_NM+TAX_FLAG_NM) (브랜드 영수증명+거래형태(특,직)+과세구분) 
                            	// 3. line3 : // SKU_CD (단품코드)                                                  
                            	// 4. line4 : // SKU_NM (단품코드 명)                                                
                            	// 5. line5 : // SALE_PRC (금액)                                                  
                            	// 8. line8 : // strSkuType (단품종류(1:규격, 3:의류))                                  

                            	arrLines1[arrayIndex] = DS_IO_DETAIL2.NameValue(detailCnt, "STR_NM"); 
                            	arrLines2[arrayIndex] = DS_IO_DETAIL2.NameValue(detailCnt, "PBN_RECP_NM") 
                            	                      + "("
                            					      + DS_IO_DETAIL2.NameValue(detailCnt, "BIZ_TYPE_NM") 
                            					      + DS_IO_DETAIL2.NameValue(detailCnt, "TAX_FLAG_NM")
                            	                      + ")";
                            	arrLines3[arrayIndex] = DS_IO_DETAIL2.NameValue(detailCnt, "SKU_CD");
                            	arrLines4[arrayIndex] = DS_IO_DETAIL2.NameValue(detailCnt, "SKU_NM");
                            	arrLines5[arrayIndex] = DS_IO_DETAIL2.NameValue(detailCnt, "NEW_SALE_PRC");
                            	arrLines6[arrayIndex] = "";
                            	arrLines7[arrayIndex] = "";
                            	arrLines8[arrayIndex] = strSkuType;
//                                 arrCnts[arrayIndex]   = DS_IO_DETAIL2.NameValue(detailCnt, "ORD_QTY"); 
                                arrCnts[arrayIndex]   = DS_IO_DETAIL2.NameValue(detailCnt, "PRINT_QTY"); 
                                
                                if(arrCnts[arrayIndex] % 2 == 0){
                                    arrCnts[arrayIndex] = arrCnts[arrayIndex] / 2;
                                }else{
                                    arrCnts[arrayIndex] = (arrCnts[arrayIndex] + 1) / 2;
                                }
                                
                                arrayIndex = arrayIndex + 1;
                                
                            }else if(strSkuType == "3"){          //의류단품         
                                
								// 1. line1 : // STR_NM (점명)                                                   
								// 2. line2 : // strMMYY (년월)
								// 3. line3 : // SEASON_NM+PUMMOK_NM (시즌+품목명)                                                           
								// 4. line4 : // SKU_CD (단품코드)                                       
								// 5. line5 : // SKU_NM+COLOR_NM+SIZE_NM (단품명+컬러+사이즈)         
								// 6. line6 : // SALE_PRC (금액) 
								// 8. line8 : // strSkuType (단품종류(1:규격, 3:의류))
								
								arrLines1[arrayIndex] = DS_IO_DETAIL2.NameValue(detailCnt, "STR_NM");
								arrLines2[arrayIndex] = strMMYY;
								arrLines3[arrayIndex] = DS_IO_DETAIL2.NameValue(detailCnt, "SEASON_NM") + " "
								                      + DS_IO_DETAIL2.NameValue(detailCnt, "PUMMOK_NM");
								arrLines4[arrayIndex] = DS_IO_DETAIL2.NameValue(detailCnt, "SKU_CD");
								arrLines5[arrayIndex] = DS_IO_DETAIL2.NameValue(detailCnt, "SKU_NM")   + " "
								                      + DS_IO_DETAIL2.NameValue(detailCnt, "COLOR_NM") + " "
								                      + DS_IO_DETAIL2.NameValue(detailCnt, "SIZE_NM");
								arrLines6[arrayIndex] = DS_IO_DETAIL2.NameValue(detailCnt, "NEW_SALE_PRC");
								arrLines7[arrayIndex] = "";
								arrLines8[arrayIndex] = strSkuType;

//                                 arrCnts[arrayIndex]   = DS_IO_DETAIL2.NameValue(detailCnt, "ORD_QTY");
                                arrCnts[arrayIndex]   = DS_IO_DETAIL2.NameValue(detailCnt, "PRINT_QTY");

                                if(arrCnts[arrayIndex] % 2 == 0){
                                    arrCnts[arrayIndex] = arrCnts[arrayIndex] / 2;
                                }else{
                                    arrCnts[arrayIndex] = (arrCnts[arrayIndex] + 1) / 2;
                                }
                                
                                arrayIndex = arrayIndex + 1;  
                                
                            }                              
                    	}
                    }// 단품 for문의 끝
                    
                }
            } 
        
        }else{                  //품목
        	

            if(strTagType == "2M" || strTagType == "2H" || strTagType == "2S"){

                for(var i=1; i<=intLoofCount; i++){
                    if(DS_O_MASTER.NameValue(i, "CHECK1") == "T"){
                        
                        for(detailCnt=1; detailCnt<=DS_IO_DETAIL.CountRow; detailCnt++){
                        	
                            if(!DS_IO_DETAIL.IsUpdated){
                                showMessage(EXCLAMATION, OK, "USER-1209");
                                returnFlag = false; //업데이트못하게 한다.
                                return;
                            }                            

                            if(DS_IO_DETAIL.NameValue(detailCnt, "CHECK1") == "T"){

                                arrLines1[arrayIndex] = "";		// STR_NM + BIZ_TYPE_NM (점명 + 거래형태(특, 직))
                                arrLines2[arrayIndex] = "";		// PBN_RECP_NM (브랜드 영수증명)
                                arrLines3[arrayIndex] = "";		// EVENT_FLAG (행사구분)
                                arrLines4[arrayIndex] = "";		// PMK_RECP_NM (품목 영수증명) 
                                arrLines5[arrayIndex] = "";		// 21+PUMBUN_CD+PUMMOK_SRT_CD+C/D (21+브랜드코드+품목단축코드+C/D) 
                                arrLines6[arrayIndex] = "";		// 29+EVENT_FLAG+SALE_PRC+C/D (21+행사구분+단가+C/D)
                                arrLines7[arrayIndex] = "";		// SALE_PRC (금액)
                                arrLines8[arrayIndex] = "";
                                arrCnts[arrayIndex]   = "";		// 수량
                                
                             	// 2M
                             	// 1. line1 : STR_NM + BIZ_TYPE_NM (점명 + 거래형태(특, 직))
                             	// 2. line2 : PBN_RECP_NM (브랜드 영수증명)
                             	// 3. line3 : EVENT_FLAG (행사구분)
                             	// 4. line4 : PMK_RECP_NM (품목 영수증명) 
                             	// 5. line5 : 21+PUMBUN_CD+PUMMOK_SRT_CD+C/D (21+브랜드코드+품목단축코드+C/D) 
                             	// 6. line6 : 29+EVENT_FLAG+SALE_PRC+C/D (21+행사구분+단가+C/D)
                             	// 7. line7 : SALE_PRC (금액)

                                arrLines1[arrayIndex] = DS_IO_DETAIL.NameValue(detailCnt, "STR_NM") + "" + DS_IO_DETAIL.NameValue(detailCnt, "BIZ_TYPE_NM");
                                arrLines2[arrayIndex] = DS_IO_DETAIL.NameValue(detailCnt, "PBN_RECP_NM");
                                arrLines3[arrayIndex] = DS_IO_DETAIL.NameValue(detailCnt, "EVENT_FLAG");
                                arrLines4[arrayIndex] = DS_IO_DETAIL.NameValue(detailCnt, "PMK_RECP_NM");
                                tempBarCode  = "21" + DS_IO_DETAIL.NameValue(detailCnt, "PUMBUN_CD")
                                                    + DS_IO_DETAIL.NameValue(detailCnt, "PUMMOK_SRT_CD");
                                arrLines5[arrayIndex] = tempBarCode + getSkuCdCheckSum(tempBarCode);
                                tempBarCode2 = "29" + DS_IO_DETAIL.NameValue(detailCnt, "EVENT_FLAG")
                                                    + lpad(DS_IO_DETAIL.NameValue(detailCnt, "NEW_SALE_PRC")+"", 8, "0");
                                arrLines6[arrayIndex] = tempBarCode2 + getSkuCdCheckSum(tempBarCode2);
                                arrLines7[arrayIndex] = DS_IO_DETAIL.NameValue(detailCnt, "NEW_SALE_PRC");
//                                 arrCnts[arrayIndex]   = DS_IO_DETAIL.NameValue(detailCnt, "ORD_QTY");
                                arrCnts[arrayIndex]   = DS_IO_DETAIL.NameValue(detailCnt, "PRINT_QTY");
                                
                                if(arrCnts[arrayIndex] % 2 == 0){
                                    arrCnts[arrayIndex] = arrCnts[arrayIndex] / 2;
                                }else{
                                    arrCnts[arrayIndex] = (arrCnts[arrayIndex] + 1) / 2;
                                }
                                   
                                arrayIndex = arrayIndex + 1;
                            }
                        }          
                    }
                }
            }
        }     
    }

//     alert("arrLines1 : "+arrLines1);
//     alert("arrLines2 : "+arrLines2);
//     alert("arrLines3 : "+arrLines3);
//     alert("arrLines4 : "+arrLines4);
//     alert("arrLines5 : "+arrLines5);
//     alert("arrLines6 : "+arrLines6);
//     alert("arrLines7 : "+arrLines7);
//     alert("arrLines8 : "+arrLines8);
//     alert("arrCnts : "+arrCnts);
    
	// 출력 모듈 호출
    gfnToshibaTegPrint( strSkuflag, arrLines1, arrLines2, arrLines3, arrLines4
    		          , arrLines5,  arrLines6, arrLines7, arrLines8, arrCnts);

	for(var i=1; i<=DS_O_MASTER.CountRow; i++){
		DS_O_MASTER.NameValue(i, "CHECK1") = "F";
	}

	for(var i=1; i<=DS_IO_DETAIL.CountRow; i++){
		DS_IO_DETAIL.NameValue(i, "CHECK1") = "F";
	}
	
	retVal = true;
	return retVal;
  }
  

 
  
 /**
  * updTagFlagData()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010.06.14
  * 개       요 : 택발행한 데이터 정보 수정
  * return값 : void
  */
 function updTagFlagData(){
	  g_CanrowPosChangedFlag = false;
      var goTo       = "updTagFlagData";   
      TR_MAIN.Action  ="/dps/pord303.po?goTo="+goTo; 
      TR_MAIN.KeyValue="SERVLET(I:DS_O_MASTER=DS_O_MASTER)";
      //alert("업데이트함수 첫번째5");
      TR_MAIN.Post();        
  }
  
/**
* showMaster()
* 작 성 자 : 박래형
* 작 성 일 : 2010-01-25
* 개    요 :  마스터 리스트 조회
* return값 : void
*/
function showMaster(){
    var strStrCd     = LC_S_STR_CD.BindColVal;     //점
    var strReqDdate  = EM_DELI_DT1.text;           //납품예정기간
    var strReqDdate2 = EM_DELI_DT2.text;           //납품예정기간
    var strTagFlag   = LC_I_TAG_FLAG.BindColVal;   //택구분
    var strFlag      = RD_FLAG.CodeValue;          //구분(전체.미발행.발행)
    var strPumbunCd  = EM_S_PUMBUN_CD.Text;
    var strSlipNo    = EM_S_SLIP_NO.Text;          // 전표번호

    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strTagFlag="  +encodeURIComponent(strTagFlag) 
                   + "&strStrCd="    +encodeURIComponent(strStrCd)      
                   + "&strReqDate="  +encodeURIComponent(strReqDdate)
                   + "&strReqDate2=" +encodeURIComponent(strReqDdate2)
                   + "&strPumbunCd=" +encodeURIComponent(strPumbunCd)
                   + "&strFlag="     +encodeURIComponent(strFlag)
                   + "&strSlipNo="   +encodeURIComponent(strSlipNo);
    TR_MAIN.Action  ="/dps/pord303.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    //searchSetWait("R") //처리상태 표시
    if(DS_O_MASTER.CountRow < 1){
        //alert("조회된 데이터가 없습니다.");
        DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
        DS_IO_DETAIL2.setDataHeader('<gauce:dataset name="H_SEL_DETAIL2"/>');
    }
    
    /*
    // 누적시킬 데이터셋을 구분한다(단품데이터셋 VS 품목 데이터셋)
    if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SKU_FLAG") == "1"){
        DS_PRINT.setDataHeader('<gauce:dataset name="H_SEL_DETAIL2"/>');
        DS_TMP.setDataHeader('<gauce:dataset name="H_SEL_DETAIL2"/>');
        
    }else{
        DS_PRINT.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
        DS_TMP.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    }
    */
}

/**
* showDetail()
* 작 성 자 : 박래형
* 작 성 일 : 2010-01-25
* 개    요 :  품목 디테일 리스트 조회
* return값 : void
*/
function showDetail(){
    if(DS_O_MASTER.CountRow < 1){return;}  //마스터 데이터가 없을시 조회 안함
    
    var strStrCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");      //점코드
    var strSlipNo   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SLIP_NO");     //전표번호
    
    var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "&strSlipNo=" +encodeURIComponent(strSlipNo)
                   + "&strStrCd="  +encodeURIComponent(strStrCd);
    TR_DETAIL.Action  ="/dps/pord303.po?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();

    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_DETAIL.CountRow);
}

/**
* showDetail2()
* 작 성 자 : 박래형
* 작 성 일 : 2010-01-25
* 개    요 :  단품 디테일 리스트 조회
* return값 : void
*/
function showDetail2(){
    if(DS_O_MASTER.CountRow < 1){return;}  //마스터 데이터가 없을시 조회 안함
    
    
    var strStrCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");         //점코드
    var strSlipNo   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SLIP_NO");        //전표번호
    
    var goTo        = "searchDetail2" ;    
    var action      = "O";     
    var parameters  = "&strSlipNo="  +encodeURIComponent(strSlipNo)
                    + "&strStrCd="   +encodeURIComponent(strStrCd);
    TR_DETAIL.Action  ="/dps/pord303.po?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL2=DS_IO_DETAIL2)"; //조회는 O
    TR_DETAIL.Post();

    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_DETAIL2.CountRow);
}


/**
* printDetail1()
* 작 성 자 : 박래형
* 작 성 일 : 2010-06-03
* 개    요 :  출력위한 디테일 조회 (품목)
* return값 : void
*/
function printDetail1(row){
    if(DS_O_MASTER.CountRow < 1){return;}  //마스터 데이터가 없을시 조회 안함
    
    var strStrCd    = DS_O_MASTER.NameValue(row,"STR_CD");      //점코드
    var strSlipNo   = DS_O_MASTER.NameValue(row,"SLIP_NO");     //전표번호
    
    var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "&strSlipNo=" +encodeURIComponent(strSlipNo)
                   + "&strStrCd="   +encodeURIComponent(strStrCd);
    TR_DETAIL.Action  ="/dps/pord303.po?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_TMP)"; //조회는 O
    TR_DETAIL.Post();
    
}

/**
* printDetail2()
* 작 성 자 : 박래형
* 작 성 일 : 2010-06-03
* 개    요 :  출력위한 디테일 조회 (단품)
* return값 : void
*/
function printDetail2(row){
    if(DS_O_MASTER.CountRow < 1){return;}  //마스터 데이터가 없을시 조회 안함
    
    
    var strStrCd    = DS_O_MASTER.NameValue(row,"STR_CD");         //점코드
    var strSlipNo   = DS_O_MASTER.NameValue(row,"SLIP_NO");        //전표번호
    
    var goTo        = "searchDetail2" ;    
    var action      = "O";     
    var parameters  =  "&strSlipNo=" +encodeURIComponent(strSlipNo)
                    + "&strStrCd="   +encodeURIComponent(strStrCd);
    TR_DETAIL.Action  ="/dps/pord303.po?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL2=DS_TMP)"; //조회는 O      DS_IO_DETAIL2
    TR_DETAIL.Post();
//    alert("카운트세자 = " + DS_TMP.CountRow);
}


/**
 * searchPumbunPop()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-18
 * 개    요 :  조회조건 브랜드팝업
 * return값 : void
 */
 function searchPumbunPop(){
     var tmpOrgCd        = LC_S_STR_CD.BindColVal;
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
     var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
     var strVenCd        = "";                                                        // 협력사
     var strBuyerCd      = "";                                                        // 바이어
     var strPumbunType   = "0";                                                       // 브랜드유형
     var strUseYn        = "Y";                                                       // 사용여부
     var strSkuFlag      = "";                                                        // 단품구분(2:비단품)
     var strSkuType      = "";                                                        // 단품종류(1:규격단품)
     var strItgOrdFlag   = "";                                                        // 통합발주여부
     var strBizType      = "";                                                        // 거래형태(1:직매입) 
     var strSaleBuyFlag  = "1";                                                       // 판매분매입구분

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
      var tmpOrgCd        = LC_S_STR_CD.BindColVal;
      var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
      var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
      var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "0";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "";                                                        // 단품구분(2:비단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "";                                                        // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "1";                                                       // 판매분매입구분


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

  /**
  * checkPbnSkuType()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-06-02
  * 개    요 :  조회부 브랜드 조회
  * return값 : void
  */
  function checkPbnSkuType(){
      
      var strStrCd    = LC_S_STR_CD.BindColVal;
      var strPumbunCd = EM_S_PUMBUN_CD.Text;
      
      var goTo        = "checkPbnSkuType" ;    
      var action      = "O";     
      var parameters  = "&strStrCd=" +encodeURIComponent(strStrCd) 
                      + "&strPumbunCd=" +encodeURIComponent(strPumbunCd);
      TR_MAIN.Action  ="/dps/pord304.po?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_O_PBN_SKU_TYPE=DS_O_PBN_SKU_TYPE)";
      TR_MAIN.Post();
      
      if(DS_O_PBN_SKU_TYPE.NameValue(DS_O_PBN_SKU_TYPE.RowPosition, "SKU_TYPE") == "2"){ // 브랜드이 신선단품일경우 
          return false;
      }else
          return true;
  }

  /**
   * checkValidation()
   * 작 성 자     : 박래형
   * 작 성 일     : 2010-03-04
   * 개    요        : 조회, 저장시  값 체크 
   * return값 : void
   */
  function checkValidation(Gubun) {
       
       var messageCode = "USER-1001";
       
       //조회버튼 클릭시 Validation Check
       if(Gubun == "Search"){   

          if(EM_DELI_DT1.Text.length == 0){                                    // 조회일 정합성
               showMessage(EXCLAMATION, OK, "USER-1002", "납품시작일");
               EM_DELI_DT1.Focus();
               return false;
          }
          if(EM_DELI_DT2.Text.length == 0){                                      // 조회일 정합성
               showMessage(EXCLAMATION, OK, "USER-1002", "납품종료일");
               EM_DELI_DT2.Focus();
               return false;
          }
          if(EM_DELI_DT1.Text > EM_DELI_DT2.Text){                             // 조회일 정합성
               showMessage(EXCLAMATION, OK, "USER-1015");
               EM_DELI_DT1.Focus();
               return false;
           }
           
          if(!checkPbnSkuType()){                                         // 브랜드체크
              showMessage(EXCLAMATION, OK, "GAUCE-1000", "신선브랜드은 조회할 수 없습니다."); 
              EM_S_PUMBUN_CD.Focus();
              return false;
          }
          
       }

       return true; 
   }
   
   /**
   * copyDataSet()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-17
   * 개    요    : 행사구분 데이터셋 복사
   * return값 : void
   */   
   function copyDataSet(dataset){

//       DS_PRINT.ClearData();         //복사될 데이터셋 초기화  
       var setPrint = dataset.ExportData(1,dataset.CountRow, true); 
       DS_PRINT.ImportData(setPrint);           
//       alert("setPrint = "+ setPrint); 
//       alert("dataset = "+ dataset.CountRow); 
//       alert("DS_PRINT = "+ DS_PRINT.CountRow); 
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

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>

    sortColId( eval(this.DataID), row , colid);
</script>

<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>


	if(g_CanrowPosChangedFlag){
		//alert("켄로우포스체인지의 로우 = " + row);
	    if (DS_IO_DETAIL.IsUpdated || DS_IO_DETAIL2.IsUpdated){
	        if(showMessage(QUESTION, YESNO, "GAUCE-1000", "변경된 내역이 있습니다. <br> 이동 하시겠습니까?") != 1 ){
	            return false;
	        }
	    }else{
	        return true;
	    } 		
	}

</script>

<script language=JavaScript for=DS_O_MASTER event=onRowPosChanged(row)> 

	if(clickSORT)
	    return;
    /*
	if(g_checkCnt <= 1){
        if(g_masterCheckRow == row){
            GR_DETAIL.Editable  = true;
            GR_DETAIL2.Editable = true;             
        }else{
            GR_DETAIL.Editable  = false;
            GR_DETAIL2.Editable = false;      
        }
	}else{
        GR_DETAIL.Editable  = true;
        GR_DETAIL2.Editable = true; 		
	}
    */

    if(g_checkCnt > 1){            //마스터가 두건이상이면 디테일은 선택할 수 없다.
        GR_DETAIL.Editable  = false;
        GR_DETAIL2.Editable = false; 
        
    }else if(g_checkCnt == 1){
        //g_masterCheckRow = row;
        if(DS_O_MASTER.NameValue(row, "CHECK1") != "T"){
            GR_DETAIL.Editable  = false;
            GR_DETAIL2.Editable = false; 
            
        }else{
            GR_DETAIL.Editable  = true;
            GR_DETAIL2.Editable = true;            
        }
        
    }else{
        GR_DETAIL.Editable  = true;
        GR_DETAIL2.Editable = true;             
    } 
    
	
    GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "false"; 
    GR_DETAIL2.ColumnProp('CHECK1','HeadCheck')= "false"; 

    if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SKU_TYPE") !='3' ){            //의류단품인 경우 스타일, 칼라, 사이즈를 보여주거나 보여주지 않게.
        GR_DETAIL2.ColumnProp("STYLE_CD",   "show")     = false;
        GR_DETAIL2.ColumnProp("COLOR_CD",   "show")     = false;
        GR_DETAIL2.ColumnProp("SIZE_CD",    "show")     = false;
    }else {
    	if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STYLE_TYPE") =='1' ){
            GR_DETAIL2.ColumnProp("STYLE_CD",   "show")      = true;
            GR_DETAIL2.ColumnProp("COLOR_CD",   "show")      = true;
            GR_DETAIL2.ColumnProp("SIZE_CD",    "show")      = true;    		
    	}else{
            GR_DETAIL2.ColumnProp("STYLE_CD",   "show")      = true;
            GR_DETAIL2.ColumnProp("COLOR_CD",   "show")      = false;
            GR_DETAIL2.ColumnProp("SIZE_CD",    "show")      = false;            		
    	}
    }

    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SKU_FLAG") == '2' || DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SKU_FLAG") == '') {       
            setTabItemIndex('TAB_01',1);
            showDetail();             //품목조회
    
            if(inta == 0){  
                inta++;
            }else{
                setPorcCount("SELECT", DS_IO_DETAIL.CountRow);      
            }           
        } else {  
            setTabItemIndex('TAB_01',2);
            showDetail2();            //단품조회
    
            if( bfListRowPosition == row)
                return;
            bfListRowPosition = row;
            
            if(inta == 0){  
                inta++;
            }else{
                setPorcCount("SELECT", DS_IO_DETAIL2.CountRow);      
            }
        }
    }
</script>


<script language=JavaScript for=DS_O_MASTER event=OnColumnChanged(row,colid)>

    g_checkCnt = 0; //전역변수
    if (colid == "CHECK1") {
        for(var i = 1; i<=DS_O_MASTER.CountRow; i++){
            if(DS_O_MASTER.NameValue(i, "CHECK1") == "T")
                g_checkCnt += 1;
        }
        /*
        if(g_checkCnt > 1){            //마스터가 두건이상이면 디테일은 선택할 수 없다.
            GR_DETAIL.Editable  = false;
            GR_DETAIL2.Editable = false; 
        }else{
            GR_DETAIL.Editable  = true;
            GR_DETAIL2.Editable = true; 
            g_masterCheckRow    = row;
        } */  
        
        if(g_checkCnt > 1){            //마스터가 두건이상이면 디테일은 선택할 수 없다.
            GR_DETAIL.Editable  = false;
            GR_DETAIL2.Editable = false; 
            
        }else if(g_checkCnt == 1){
            //g_masterCheckRow = row;
            if(DS_O_MASTER.NameValue(row, "CHECK1") != "T"){
                GR_DETAIL.Editable  = false;
                GR_DETAIL2.Editable = false; 
                
            }else{
                GR_DETAIL.Editable  = true;
                GR_DETAIL2.Editable = true;           
            }
            
        }else{
            GR_DETAIL.Editable  = true;
            GR_DETAIL2.Editable = true;                   
        }
        
    }

/*
    var strSkuFlag = DS_O_MASTER.NameValue(row, "SKU_FLAG");
    var dataset    = "";
    switch (colid) {
    case "CHECK1":
        if(strSkuFlag == "1"){         //단품일때
            showDetail2();
            dataset = DS_IO_DETAIL2;
            
        }else if(strSkuFlag == "2"){   //품목일때
            showDetail();
            dataset = DS_IO_DETAIL;   
        }
//      alert("체크박스 클릭시");
        copyDataSet(dataset);
        break;
    }
*/
</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>

    //디테일이 변경 가능 경우는 마스터 체크가 없거나 마스터 체크가 1건일때만 가능하다
    //마스터 체크없이 디테일이 체크되었을때 마스터도 자동 체크처리 한다.
    if(DS_IO_DETAIL.IsUpdated){
        DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CHECK1") = "T";
        g_CanrowPosChangedFlag = true;        
    }else{
        DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CHECK1") = "F";   
        g_CanrowPosChangedFlag = false;           
    }  
    if (colid == "PRINT_QTY") {
    	var strPrintQty = DS_IO_DETAIL.NameValue(row, "PRINT_QTY");
    	var strOryQty   = DS_IO_DETAIL.NameValue(row, "ORD_QTY") * 2;
    	if(strPrintQty > strOryQty){
    		showMessage(EXCLAMATION, OK, "USER-1000", "출력수량은 수량의 2배 이상 입력 불가능 합니다.");
    		DS_IO_DETAIL.NameValue(row, "PRINT_QTY") = DS_IO_DETAIL.NameValue(row, "ORD_QTY");
    		setTimeout("setFocusGrid(GR_DETAIL,DS_IO_DETAIL," +row + ",'PRINT_QTY')",50);
    		return;
    	}
    }
</script>

<script language=JavaScript for=DS_IO_DETAIL2 event=OnColumnChanged(row,colid)>

	//디테일이 변경 가능 경우는 마스터 체크가 없거나 마스터 체크가 1건일때만 가능하다
	//마스터 체크없이 디테일이 체크되었을때 마스터도 자동 체크처리 한다.
    //마스터 체크없이 디테일이 체크되었을때 마스터도 자동 체크처리 한다.
	if(DS_IO_DETAIL2.IsUpdated){
	       DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CHECK1") = "T";
	        g_CanrowPosChangedFlag = true;        	    
	}else{
	       DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CHECK1") = "F";  
	        g_CanrowPosChangedFlag = false;            
	}
    if (colid == "PRINT_QTY") {
    	var strPrintQty = DS_IO_DETAIL2.NameValue(row, "PRINT_QTY");
    	var strOryQty   = DS_IO_DETAIL2.NameValue(row, "ORD_QTY") * 2;
    	if(strPrintQty >= strOryQty){
    		showMessage(EXCLAMATION, OK, "USER-1000", "출력수량은 수량의 2배 이상 입력 불가능 합니다.");
    		DS_IO_DETAIL2.NameValue(row, "PRINT_QTY") = DS_IO_DETAIL2.NameValue(row, "ORD_QTY");
    		setFocusGrid(GR_DETAIL2, DS_IO_DETAIL2, row , "PRINT_QTY");
    		setTimeout("setFocusGrid(GR_DETAIL2,DS_IO_DETAIL2," +row + ",'PRINT_QTY')",50);
    		return;
    	}
    }
</script>



<!-- 품목 그리드 헤더 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_DETAIL event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHECK1") {
        if (bCheck == 1) {
            GR_DETAIL.Redraw = false;
            for (var i = 0; i < DS_IO_DETAIL.CountRow; i++)
            {
                DS_IO_DETAIL.NameValue(i + 1, "CHECK1") = "T";
            }    
            GR_DETAIL.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_DETAIL.Redraw = false;
            for (var i = 0; i < DS_IO_DETAIL.CountRow; i++)
            {
                DS_IO_DETAIL.NameValue(i + 1, "CHECK1") = "F";
            } 
            GR_DETAIL.Redraw = true;
        }
    }
</script>

<!-- 품목 그리드 헤더 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_DETAIL2 event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHECK1") {
        if (bCheck == 1) {
            GR_DETAIL2.Redraw = false;
            for (var i = 0; i < DS_IO_DETAIL2.CountRow; i++)
            {
                DS_IO_DETAIL2.NameValue(i + 1, "CHECK1") = "T";
            }    
            GR_DETAIL2.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_DETAIL2.Redraw = false;
            for (var i = 0; i < DS_IO_DETAIL2.CountRow; i++)
            {
                DS_IO_DETAIL2.NameValue(i + 1, "CHECK1") = "F";
            } 
            GR_DETAIL2.Redraw = true;
        }
    }
</script>

<!-- 마스터 그리드 헤더 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_MASTER event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHECK1") {
        if (bCheck == 1) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_O_MASTER.CountRow; i++)
            {
                DS_O_MASTER.NameValue(i + 1, "CHECK1") = "T";
            }    
            GR_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_O_MASTER.CountRow; i++)
            {
                DS_O_MASTER.NameValue(i + 1, "CHECK1") = "F";
            } 
            GR_MASTER.Redraw = true;
        }
    }
</script>

<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    //품목 그리드 정렬
//  sortColId( eval(this.DataID), row, colid);
    
    sortColId( eval(this.DataID), row , colid);
</script>

<!-- Grid DETAIL2 oneClick event 처리 -->
 <script language=JavaScript for=GR_DETAIL2 event=OnClick(row,colid)>
    //단품 그리드 정렬
//   sortColId( eval(this.DataID), row, colid);
    
    sortColId( eval(this.DataID), row , colid);
</script>



<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PUMBUN_CD event=onKillFocus()>

    if(EM_S_PUMBUN_CD.Text != ""){
        searchPumbunNonPop();
    }else
        EM_S_PUMBUN_NM.Text = "";  
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
<comment id="_NSID_"><object id="DS_O_STR_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PRT_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->                       
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 그리드 헤더 가져오기  -->                               
<comment id="_NSID_"><object id="DS_O_MASTER"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL2"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_ORD_UNIT_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TAG_FLAG"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_PBN_SKU_TYPE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PRINT"          classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TMP"            classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 택발행 OCX  -->  
<comment id="_NSID_">
	<OBJECT classid="clsid:E76C9051-A8C4-458E-9F60-3C14DB9EECF9"
            CODEBASE="/<%=dir%>/ocx/TEC_dol.cab#version=1,0,0,0"
		    name="TEC_DO1" id="TEC_DO1" width=0 height=0 hspace=0 vspace=0>
		<PARAM Name="PrinterName" Value="TEC B-SX5T (305 dpi)"> 
	</OBJECT>
</comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
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
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){

    
	var obj   = document.getElementById("GR_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
        <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                <tr>
                    <th class="point" width="80">점</th>
                    <td width="350">
                        <comment id="_NSID_">
                            <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point" width="80">납품예정기간</th>
                    <td >
                        <comment id="_NSID_">
                            <object id=EM_DELI_DT1 classid=<%=Util.CLSID_EMEDIT%>  width=70 tabindex=1 align="absmiddle">
                            </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_DELI_DT1)"  align="absmiddle"/>~
                        <comment id="_NSID_">
                            <object id=EM_DELI_DT2 classid=<%=Util.CLSID_EMEDIT%>  width=70 tabindex=1 align="absmiddle">
                            </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_DELI_DT2)"  align="absmiddle"/>
                    </td>
                    <th style="display:none">구분</th>
                    <td style="display:none"><comment id="_NSID_"> <object id=RD_FLAG
                        classid=<%=Util.CLSID_RADIO%> tabindex=1
                        style="height: 20; width: 180">
                        <param name=Cols value="3">
                        <param name=Format value="1^전체,2^미발행,3^발행">
                        <param name=CodeValue value="1">
                    </object> </comment> <script> _ws_(_NSID_);</script></td>
                </tr>
                <tr>
                    <th>브랜드</th>
                    <td >
                        <comment id="_NSID_">
                              <object id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_PUMBUN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop();" />
                        <comment id="_NSID_">
                              <object id=EM_S_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th class="point">택구분</th>
                    <td>
                        <comment id="_NSID_">
                            <object id=LC_I_TAG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=180 tabindex=1 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td>
                </tr>
                <tr>
                    <th class="point">전표번호</th>
                    <td> <!--  colspan="3" -->
                        <comment id="_NSID_">
                            <object id=EM_S_SLIP_NO classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point">생산년도</th>
                    <td>
                        <comment id="_NSID_">
                            <object id=EM_S_PRT_YYYY classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=1 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td>
		            <th class="point" width="80" style="display:none">발행기</th>
		            <td style="display:none">
		                <comment id="_NSID_">
		                    <object id=LC_O_PRT_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=180 align="absmiddle">
		                    </object>
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
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
                    <tr>
                        <td>
                            <comment id="_NSID_">
                                <OBJECT id=GR_MASTER width=100% height=350 classid=<%=Util.CLSID_GRID%>>
                                    <param name="DataID" value="DS_O_MASTER">
                                </OBJECT>
                            </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
            </td>
          </tr>
          <tr>          
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top"  class="PT05">
                        <div id=TAB_01  width="100%" height=380 TitleWidth=90 TitleAlign="center">
                          <menu TitleName="품      목"       DivId="tab_page1" Enable='false' />
                          <menu TitleName="단      품"       DivId="tab_page2" Enable='false' />
                        </div>
                       <div id=tab_page1 width="100%" >
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                          <tr>
                            <td>
                              <comment id="_NSID_"><object id=GR_DETAIL width="100%" height=350 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_IO_DETAIL">
                              </object></comment><script>_ws_(_NSID_);</script>
                            </td>
                          </tr>
                        </table>
                        </div>
                        <div id=tab_page2 width="100%" >
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                          <tr>
                            <td>
                              <comment id="_NSID_"><object id=GR_DETAIL2 width="100%" height=350 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_IO_DETAIL2">
                              </object></comment><script>_ws_(_NSID_);</script>
                            </td>
                          </tr>
                        </table>
                        </div>            
                    </td>
                </tr>
            </table></td>
        </tr>
    </table></td>
</tr>

</table>
</DIV>
</body>
</html>
