<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주매입 > 택발행> 택발행 의뢰등록(단품)
 * 작 성 일 : 2010.02.25
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord3040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 택발행 의뢰등록한다
 * 이    력 :
 *        2010.02.27 (박래형) 신규작성 
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
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">

var strToday        = "";                            //현재날짜
var strStyleType = 0;   //단품종류 1 = A, 2 = B
var blnSkuChanged   = false;                         // 단품코드 변경 여부
var saveFlag = false;   // CanRowPosChange 구분위한

var inta = 0;
var bfListRowPosition = 0;                               // 이전 List Row Position
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top  = 125;		//해당화면의 동적그리드top위치
 var top2 = 280;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GR_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";
	 
     strToday        = getTodayDB("DS_O_RESULT")   //햔재날짜

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //단품 디테일    
    
    // 상단 조회 컴퍼넌트 초기화    
    initComboStyle(LC_S_STR_CD,  DS_STR,   "CODE^0^30,NAME^0^140", 1, PK);                //조회용 점

    initEmEdit(EM_S_PRT_REQ_DT,       "SYYYYMMDD",     PK);                                 //조회용 의뢰일자
    initEmEdit(EM_S_PRT_REQ_DT2,       "TODAY",     PK);                                 //조회용 의뢰일자
    initEmEdit(EM_S_PRT_REQ_SEQ_NO,   "GEN",   NORMAL);                                 //조회용 의뢰번호
    initEmEdit(EM_S_PUMBUN_CD,        "000000", NORMAL);                                 //조회용 픔번코드
    initEmEdit(EM_PUMBUN_NM,          "GEN",     READ);                                 //조회용 브랜드명     
    
    // 단품 컴퍼넌트 초기화    
    
    initComboStyle(LC_I_STR_CD,   DS_STR,       "CODE^0^30,NAME^0^140", 1, PK);         //입력용 점
    initComboStyle(LC_I_TAG_FLAG, DS_TAG_FLAG,  "CODE^0^30,NAME^0^80", 1, PK);        //입력용 택구분
    
    initEmEdit(EM_I_PRT_REQ_DT,     "YYYYMMDD",   PK);                                  //입력용 의뢰일자
    initEmEdit(EM_O_PRT_REQ_SEQ_NO, "GEN^5",   READ);                                   //출력용 의뢰번호
    initEmEdit(EM_I_PUMBUN_CD,      "000000",   PK);                                    //입력용 브랜드(코드)
    initEmEdit(EM_O_PUMBUN_NM,      "GEN",   READ);                                     //출력용 브랜드명    
    initEmEdit(EM_I_APP_DT,         "YYYYMMDD",   PK);                                  //입력용 가격적용일    
    initEmEdit(EM_I_YYYY,           "YYYY",  PK);                                       // 생산년도
    
    initEmEdit(EM_SKU_FLAG,         "GEN",   READ);                                     //단품구분
    initEmEdit(EM_SKU_TYPE,         "GEN",   READ);                                     //단품종류  
    initEmEdit(EM_STYLE_TYPE,       "GEN",   READ);                                     //의류종륲  
    
        
    initEmEdit(EM_VEN_CD,           "GEN",   READ);                                     //협력사코드
    initEmEdit(EM_VEN_NM,           "GEN",   READ);                                     //협력사 명  

    EM_SKU_FLAG.style.display         = "none";
    EM_SKU_TYPE.style.display         = "none";
    EM_STYLE_TYPE.style.display       = "none";
    
//    EM_VEN_CD.style.display         = "none";
//    EM_VEN_NM.style.display         = "none";

    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getStore("DS_STR", "Y", "", "N");                   // 점      
    getEtcCode("DS_TAG_FLAG", "D", "P063", "N");        //택구분    
    
    DS_TAG_FLAG.DeleteRow(1);
    LC_I_TAG_FLAG.value = "1S";
    
    //사용할 데이터셋 레지에 등록
    registerUsingDataset("pord304","DS_IO_MASTER,DS_IO_DETAIL" );
    
    LC_S_STR_CD.Index = 0;      //점코드 초기 셋팅
//    LC_I_STR_CD.Index = 0;    
//    LC_I_TAG_FLAG.Index = 0;

    LC_S_STR_CD.Focus();        //점코드 포커스
/*    
    //조회부 정렬
    EM_S_PRT_REQ_SEQ_NO.alignment  = 1;
    EM_S_PUMBUN_CD.alignment  = 1;
    
    //입력부 정렬
    EM_O_PRT_REQ_SEQ_NO.alignment  = 1;
    EM_I_PUMBUN_CD.alignment  = 1;
    EM_VEN_CD.alignment  = 1;
*/    
    setObject(false);    
}

function gridCreate1(){         //택발행의뢰HEADER
    var hdrProperies = '<FC>id=PRT_REQ_SEQ_NO   name="의뢰번호"     width=60   align=center </FC>'
                     + '<FC>id=TAG_FLAG_NM      name="TAG구분"      width=80   align=center </FC>'
                     + '<FC>id=PRT_REQ_NM       name="의뢰자"       width=70   align=left   </FC>'
                     + '<FC>id=PROC_FLAG_NM     name="구분"         width=40   align=center </FC>';

    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}
//edit={IF(TAG_PRT_YN="N","true","false")}

function gridCreate2(){         //단품 - 택발행의뢰DETAIL(규격과 의류일때 달라짐)
    var hdrProperies = '<FC>id={currow}         name="NO"           width=30    align=center  Edit=none </FC>'
                    + '<FC>id=CHECK1            name="선택"          width=50    align=center  HeadCheckShow=true EditStyle=CheckBox edit={IF(TAG_PRT_YN="N","true","false")}</FC>'
                    + '<FC>id=PUMMOK_CD         name="품목코드"      width=120   align=left   Edit=none  show="false"</FC>'
                    + '<FC>id=SKU_CD            name="단품코드"      width=120   align=left   EditStyle=Popup sumtext="합계" edit={IF(TAG_PRT_YN="N","true","false")}</FC>'
                    + '<FC>id=SKU_NM            name="단품명"        width=100   align=left   Edit=none SHOW=FALSE</FC>'
                    + '<FC>id=RECP_NAME         name="영수증명"      width=100   align=left   Edit=none </FC>'
                    + '<FC>id=PRT_REQ_SEQ_NO    name="의뢰"          width=10    align=left   Edit=none show="false"</FC>'
                    + '<FC>id=PRT_DTL_SEQ_NO    name="디테일"        width=10    align=left   Edit=none show="false"</FC>'
                    + '<FC>id=PUMBUN_CD         name="브랜드"          width=50    align=left   Edit=none show="false"</FC>'
                    + '<FC>id=PUMBUN_NM         name="브랜드명"        width=100   align=left   Edit=none show="false"/FC>'                 
                    + '<FC>id=STYLE_CD          name="스타일"        width=90    align=center Edit=none</FC>'
                    + '<FC>id=COLOR_CD          name="칼라"          width=50    align=center Edit=none</FC>'
                    + '<FC>id=SIZE_CD           name="사이즈"        width=50    align=center Edit=none</FC>'
                    + '<FC>id=VEN_CD            name="협력사코드"    width=70    align=left   Edit=none show="false"</FC>'                  
                    + '<FC>id=VEN_NM            name="협력사명"      width=100   align=left   Edit=none show="false"</FC>'
                    + '<FC>id=REQ_CNT           name="* 의뢰수량"    width=65    align=right  Edit=Numeric edit={IF(TAG_PRT_YN="N","true","false")} sumtext=@sum</FC>'
                    + '<FG> name="판 매 가"'
                    + '<FC>id=SALE_PRC          name="단가"          width=80    align=right  Edit=none  sumtext=@sum</FC>'
                    + '<FC>id=SALE_AMT          name="금액"          width=120    align=right  Edit=none  sumtext=@sum</FC>'
                    + '</FG>'
                    + '<FC>id=TAG_PRT_YN        name="발행여부"      width=60    align=center Edit=none  </FC>'
                    + '<FC>id=PRT_YYYY          name="생산년도"      width=55     align=right     edit=none show=false</FC>'
                    ;

    initGridStyle(GR_DETAIL, "common", hdrProperies, true);
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {     
	
    // CanRowPosChange 구분위한
    saveFlag = false;
    
       // 변경, 추가내역이 있을 경우
    if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
           return;
    }
       
    if(checkValidation("Search")){
        DS_IO_MASTER.ClearData();  
        DS_IO_DETAIL.ClearData();
        inta = 0;
        bfListRowPosition = 0;  
        getMaster();
        // 조회결과 Return
        setPorcCount("SELECT", GR_MASTER);
        if(DS_IO_MASTER.CountRow <= 0){
            LC_S_STR_CD.Focus();
            setObject(false);    
        }
    } 
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     
    // CanRowPosChange 구분위한
    saveFlag = false;
    
    // 전표마스터 추가후 행추가, 삭제 버튼 활성화 (저장되지 않은 내용이 있을경우 추가되지 않음)
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "PRT_REQ_SEQ_NO") == ""){
          if(showMessage(QUESTION, YESNO, "USER-1072") != 1 ){
        	    setObject(true);  
              return;
          }else{
        	  clearObject();
              return;
//              DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
          }
    }    
   
    DS_IO_MASTER.Addrow(); 
    LC_I_STR_CD.Index = 0;   
    EM_I_PRT_REQ_DT.Text = strToday;    //의뢰일자
    EM_I_APP_DT.Text = strToday;        //가격적용일
    EM_I_YYYY.Text = strToday.substring(0,4);
    DS_IO_DETAIL.ClearData();
    LC_I_TAG_FLAG.Index = 0;
    
    setObject(true);  
    LC_I_STR_CD.Focus();
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-28
 * 개    요    : 택 발행 의뢰 마스터 삭제
 * return값 : void
 */
function btn_Delete() {    
    
    // CanRowPosChange 구분위한
    saveFlag = true;
    
    // 삭제할 데이터 없는 경우
    if (DS_IO_MASTER.CountRow == 0){
        showMessage(StopSign, OK, "USER-1019");
        return;
    }

    // 신규 전표인 경우 데이터셋에서만 삭제
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_SEQ_NO").length == 0){
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
        return;
    }
    
    if(!checkValidation("Delete"))
        return;
    
    if(showMessage(QUESTION, YESNO, "USER-1023") == 1){ 
	    var strStrCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
	    var strPrtReqDt    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_DT");
	    var strPrtReqSeqNo = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_SEQ_NO");
	    var goTo       = "saveMaster";  
	    var parameters = "&strFlag=deleMaster" 
	                   + "&strStrCd="+encodeURIComponent(strStrCd)
	                   + "&strPrtReqDt="+encodeURIComponent(strPrtReqDt)
	                   + "&strPrtReqSeqNo="+encodeURIComponent(strPrtReqSeqNo);
	
	    DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
	    
	    TR_S_MAIN.Action="/dps/pord304.po?goTo="+goTo+parameters;  
	    TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
	    TR_S_MAIN.Post(); 
	    
	    btn_Search();
    }
    saveFlag = false;
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
     
    // CanRowPosChange 구분위한
     saveFlag = true;

    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated && !DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(StopSign, OK, "USER-1028");
       return;
    }
    if(DS_IO_DETAIL.CountRow <= 0){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오."); 
        GR_DETAIL.Focus();
        return;
    }
    if(!checkValidation("Save"))
    	return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){
        saveMaster();             
        btn_Search(); 
    }
    saveFlag = false;
    blnSkuChanged = false;
    bfListRowPosition = 0;
}

/**
 * btn_Excel()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 박래형
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
 * setObject(flag)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-03
 * 개    요 :  컴퍼넌트 셋팅
 * return값 : void
 */
 function setObject(flag){

     LC_I_STR_CD.Enable     = flag;
     EM_I_PRT_REQ_DT.Enable = flag;
     EM_I_PUMBUN_CD.Enable  = flag;
     EM_I_APP_DT.Enable     = flag;
     EM_I_YYYY.Enable       = flag;
     LC_I_TAG_FLAG.Enable   = flag;
     
     //이미지버튼
     enableControl(IMG_PRT_REQ_DT, flag);  //의뢰일자 이미지
     enableControl(IMG_PUMBUN_CD,flag);  //브랜드 이미지
     enableControl(IMG_APP_DT,     flag);  //가격적용일 이미지

 }

 /**
 * clearObject()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-25
 * 개    요 :  그리드초기화 셋팅
 * return값 : void
 */
 function clearObject(){

     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_SEQ_NO") = "";
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAG_FLAG_NM") = "";
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_NM") = "";
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PROC_FLAG_NM") = "";
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
     
     if(DS_O_PBN_SKU_TYPE.CountRow <= 0)
    	 return false;
     
     if(DS_O_PBN_SKU_TYPE.NameValue(DS_O_PBN_SKU_TYPE.RowPosition, "SKU_TYPE") == "2"){ // 브랜드이 신선단품일경우 
    	 return false;
     }else
    	 return true;
 }

 /**
 * getMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-28
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getMaster(){
     
     var strStrCd          = LC_S_STR_CD.BindColVal;
     var strPrtReqDt       = EM_S_PRT_REQ_DT.Text;
     var strPrtReqDt2      = EM_S_PRT_REQ_DT2.Text;
     var strPumbunCd       = EM_S_PUMBUN_CD.Text;
     var strPrtReqSeqNo    = EM_S_PRT_REQ_SEQ_NO.Text;
     
     var goTo       = "getMaster" ;    
     var action     = "O";     
     var parameters = "&strStrCd=" +encodeURIComponent(strStrCd) 
				    + "&strPrtReqDt=" +encodeURIComponent(strPrtReqDt)
				    + "&strPrtReqDt2=" +encodeURIComponent(strPrtReqDt2)
                    + "&strPumbunCd=" +encodeURIComponent(strPumbunCd)
                    + "&strPrtReqSeqNo=" +encodeURIComponent(strPrtReqSeqNo);
     TR_M_MAIN.Action  ="/dps/pord304.po?goTo="+goTo+parameters;  
     TR_M_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)";
     TR_M_MAIN.Post();
 }
  
  /**
   * getPbnPmk()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-02-28
   * 개    요 :  단품 디테일 리스트 조회
   * return값 : void
   */
   function getPbnSku(){
       var strStrCd          = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
       var strPrtReqDt       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_DT");
       var strPrtReqSeqNo    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_SEQ_NO");
       var strSkuFlag        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_FLAG");

       var goTo       = "getPbnSku" ;    
       var action     = "O";     
       var parameters = "&strStrCd=" +encodeURIComponent(strStrCd) 
                      + "&strPrtReqDt=" +encodeURIComponent(strPrtReqDt)
                      + "&strPrtReqSeqNo=" +encodeURIComponent(strPrtReqSeqNo)
                      + "&strSkuFlag=" +encodeURIComponent(strSkuFlag);
       TR_MAIN.Action  ="/dps/pord304.po?goTo="+goTo+parameters;  
       TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)";
       TR_MAIN.Post();
       
       strStyleType = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STYLE_TYPE");

       GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "FALSE";
   }
 
 /**
  * addDetailRow()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-02-28
  * 개    요 :  디테일에 리스트 추가
  * return값 : void
  */
  function addDetailRow(){
	    
    //마스터 전표상태가 Y인 경우
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PROC_FLAG") == "Y"){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "처리되어 추가 할수 없습니다."); 
        return;
    }     
    
    // CanRowPosChange 구분위한
    saveFlag = false;
      
    if(DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "의뢰정보를 먼저 입력해주세요.");
        return;
    }
    
    //바인드시킨 값을 잃어버렸기 때문에 다시 셋팅
//    getMarginRate(LC_I_EVENT_FLAG.BindColVal);       

    if(EM_I_PUMBUN_CD.Text.length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "브랜드을 먼저 입력해 주세요.");
        return;
    }
      

    //행추가시 마스터 입력부 컴퍼넌트를 수정할 수 없게 막는다.
    if(DS_IO_DETAIL.CountRow > 0 || DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1){
        setObject(false);  //마스터 입력부 컨트롤 비활성화
    }
//aaaa 메시지 확인    

    //규격단품인지 의류단품인지
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE") == '1' || EM_SKU_TYPE.Text == '1'){ //규격단품
        GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
        GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
        GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;
    }else if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE") == '3' || EM_SKU_TYPE.Text == '3'){ //의류단품
    	if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STYLE_TYPE") == '1' || EM_STYLE_TYPE.Text == '1'){
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = true;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = true;  
    	}else{
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;      		
    	}
    }else if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE") == '2' || EM_SKU_TYPE.Text == '2'){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "신선단품은 등록할 수 없습니다."); 
        EM_I_PUMBUN_CD.Text = "";
        EM_O_PUMBUN_NM.Text = "";
        EM_VEN_CD.Text = "";
        EM_VEN_NM.Text = "";
        setObject(true);  //마스터 입력부 컨트롤 비활성화
        return;
    }else{
//      alert("브랜드을 선택해주세요.");
//      setObject(true);
//      return;
    }
    
    if(checkValidation("Add")){
        DS_IO_DETAIL.Addrow();
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PRT_REQ_DT") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_DT");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PRT_REQ_SEQ_NO") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_SEQ_NO");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMBUN_CD") = EM_I_PUMBUN_CD.Text;
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMBUN_NM") = EM_O_PUMBUN_NM.Text;
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD")    

        setObject(false); 
        GR_DETAIL.SetColumn("SKU_CD");
        GR_DETAIL.Focus();          

        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "TAG_PRT_YN")   = "N";
    } 
//  setObject(true);     
  }
 
  /**
   * delDetailRow()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-02-28
   * 개    요 :  디테일에 리스트 삭제
   * return값 : void
   */
 function delDetailRow(){ 

	    //마스터 전표상태가 Y인 강우
	    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PROC_FLAG") == "Y"){
	        showMessage(EXCLAMATION, OK, "GAUCE-1000", "처리되어 삭제할 수 없습니다."); 
	        return ;
	    }
	    
	    
    // CanRowPosChange 구분위한
    saveFlag = false;
       
    var intRowCount =  "";
                     //단품 탭 
    intRowCount =  DS_IO_DETAIL.CountRow;   
    for(var i=intRowCount; i >= 1; i--){
        if(DS_IO_DETAIL.NameValue(i, "CHECK1") == 'T'){
            DS_IO_DETAIL.DeleteRow(i);
        }
    }

    //그리드 CHEKCBOX헤더 체크해제
    GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "false";
    
    //디테일부에 데이터 없으면 마스터입력부 활성화
    if(DS_IO_DETAIL.CountRow == 0){
        setObject(true);        
    }
 }  

/**
 * saveMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-28
 * 개    요 : 마스터 내용 저장
 * return값 : void
 */
function saveMaster() {     
           
//    if(!checkDSBlank(GD_DETAIL, "1,2,4")) return; //필수 입력부 체크함수    
/*
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PROC_FLAG") != 'N'){   //진행상태가 N이 아니면 수정할수 없다.
        alert("저장할 수 없습니다.");
        return;
    }
*/        
    // 조회조건 셋팅
    var strStrCd          = "";
    var strPrtReqDt       = "";
    var strPrtReqSeqNo    = "";
    var strPumbunCd       = "";     
    var strVenCd          = "";
    var strMgAppDt        = "";
    var strEventFlag      = "";         
    var strEventRate      = "";
    var strTagFlag        = ""; 
    var strProductYear    = "";
    
    
    
    strPrtReqSeqNo = DS_IO_MASTER.NameValue(DS_IO_MASTER.RosPosition, "PRT_REQ_SEQ_NO");
    
    
    
    
    strStrCd          = LC_I_STR_CD.BindColVal;
    strPrtReqDt       = EM_I_PRT_REQ_DT.Text;
//    strPrtReqSeqNo    = EM_O_PRT_REQ_SEQ_NO.Text;

    strPumbunCd       = EM_I_PUMBUN_CD.Text;     
    strVenCd          = EM_VEN_CD.Text;
    strMgAppDt        = EM_I_APP_DT.Text;
    strEventFlag      = "";         
    strEventRate      = "";        
    strTagFlag        = LC_I_TAG_FLAG.BindColVal;               
    strProductYear    = EM_I_YYYY.Text;
    
    var goTo       = "saveMaster" ;    
    var action     = "I";     
    var parameters = "&strFlag=save"     
                   + "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strPrtReqDt="+encodeURIComponent(strPrtReqDt)
                   + "&strPrtReqSeqNo="+encodeURIComponent(strPrtReqSeqNo)
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd)    
                   + "&strVenCd="+encodeURIComponent(strVenCd)     
                   + "&strMgAppDt="+encodeURIComponent(strMgAppDt)
                   + "&strEventFlag="+encodeURIComponent(strEventFlag)     
                   + "&strEventRate="+encodeURIComponent(strEventRate)
                   + "&strTagFlag="+encodeURIComponent(strTagFlag)
                   + "&strPrtYYYY="+encodeURIComponent(strProductYear)
                   ;     
    TR_S_MAIN.Action="/dps/pord304.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_S_MAIN.Post(); 

    //    DS_IO_DETAIL.ClearData();
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
         if(LC_S_STR_CD.Text.length == 0){                              // 점
               showMessage(EXCLAMATION, OK, messageCode, "점");
               LC_S_STR_CD.Focus();
               return false;
         }  
         
         if(EM_S_PRT_REQ_DT.Text.length == 0){                          // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회시작일");
             EM_S_PRT_REQ_DT.Focus();
             return false;
        }
        if(EM_S_PUMBUN_CD.Text != ""){
	        if(!checkPbnSkuType()){                                         // 브랜드체크
	            showMessage(EXCLAMATION, OK, "GAUCE-1000", "신선브랜드은 조회할 수 없습니다."); 
	            EM_S_PUMBUN_CD.Focus();
	            return false;
	        }
        }
     }
     
     // 저장버튼 클릭시 Validation Check
     if(Gubun == "Add"){
         
         if(EM_I_PRT_REQ_DT.Text.length == 0){                                    // 의뢰일자
             showMessage(EXCLAMATION, OK, "USER-1002", "의뢰일자");
             EM_I_PRT_REQ_DT.Focus();
             setObject(true);
             return false;
          } 
         
         if(EM_I_PUMBUN_CD.Text.length == 0){                                 // 브랜드
             showMessage(EXCLAMATION, OK, "USER-1002", "브랜드");
             EM_I_PUMBUN_CD.Focus();
             setObject(true);
             return false;
         }
         
         // 존재하는 브랜드 코드인지 확인한다.
         if(!pumbunValCheck()){
             showMessage(EXCLAMATION, OK, "USER-1069", "브랜드");
             EM_I_PUMBUN_CD.Focus();
             setObject(true);
             return false;
         }
         
         if(EM_I_APP_DT.length == 0){                                    // 가격적용일
             showMessage(EXCLAMATION, OK, "USER-1002", "가격적용일");
             EM_I_APP_DT.Focus();
             setObject(true);
             return false;
          } 

         
         var intRowCount   = DS_IO_DETAIL.CountRow;
         var strSkuCd      = "";                    // 단품코드
         var intQty        = 0;                     // 의뢰수량       
         var intNewSalePrc = 0;                     // 매가단가  
         var intNewSaleAmt = 0;                     // 매가금액
         
         if(intRowCount > 0){
             for(var i=1; i <= intRowCount; i++){
                 
                 strSkuCd      = DS_IO_DETAIL.NameValue(i, "SKU_CD");
                 intQty        = DS_IO_DETAIL.NameValue(i, "REQ_CNT");
                 intNewSalePrc = DS_IO_DETAIL.NameValue(i, "SALE_PRC");
                 intNewSaleAmt = DS_IO_DETAIL.NameValue(i, "SALE_AMT");
                 
                 //행추가는 계속 할 수 있다.
                 if(strSkuCd.length <= 0){
                     return true;
                 }
                 
                 // 존재하는 단품 코드인지 확인한다.
//                 alert("checkSkuInfo+++" + strSkuCd);
                 if(!checkSkuInfo(i)){
                     showMessage(EXCLAMATION, OK, "USER-1069", "단품코드");
                     GR_DETAIL.SetColumn("SKU_CD");  
                     DS_IO_DETAIL.RowPosition = i;  
                     return false;
                 }   
                                 
                 // 중복체크
                var dupRow = checkDupKey(DS_IO_DETAIL, "SKU_CD");
                if (dupRow > 0) {
                    showMessage(StopSign, Ok,  "USER-1044", dupRow);  
                    
                    DS_IO_DETAIL.RowPosition = dupRow;
                    GR_DETAIL.SetColumn("SKU_CD");
                    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CHECK1") = "T";
                    GR_DETAIL.Focus(); 
                    return false;
                }
                
                 if(intQty <= 0){
                     showMessage(EXCLAMATION, OK, "USER-1003", "의뢰수량");
                     DS_IO_DETAIL.RowPosition = i;
                     GR_DETAIL.SetColumn("REQ_CNT");
                     GR_DETAIL.Focus(); 
 
                     return false;
                 }
                 
                 if(intNewSalePrc <= 0){
                     showMessage(EXCLAMATION, OK, "USER-1003", "매가단가");
                     DS_IO_DETAIL.RowPosition = i;
                     GR_DETAIL.SetColumn("SALE_PRC");
                     GR_DETAIL.Focus();
                     
                     return false;
                 }
                 
                 if(intNewSaleAmt <= 0){
                     showMessage(EXCLAMATION, OK, "USER-1003", "매가금액");
                     DS_IO_DETAIL.RowPosition = i;
                     GR_DETAIL.SetColumn("SALE_AMT");
                     GR_DETAIL.Focus();
                     
                     return false;
                 }
             }
         }
      }
     
     // 저장버튼 클릭시 Validation Check
     if(Gubun == "Save"){
         
         if(EM_I_PRT_REQ_DT.Text.length == 0){                                    // 의뢰일자
             showMessage(EXCLAMATION, OK, "USER-1002", "의뢰일자");
             EM_I_PRT_REQ_DT.Focus();
             setObject(true);
             return false;
          } 
         
         if(EM_I_PUMBUN_CD.Text.length == 0){                                 // 브랜드
             showMessage(EXCLAMATION, OK, "USER-1002", "브랜드");
             EM_I_PUMBUN_CD.Focus();
             setObject(true);
             return false;
         }
         
         // 존재하는 브랜드 코드인지 확인한다.
         if(!pumbunValCheck()){
             showMessage(EXCLAMATION, OK, "USER-1069", "브랜드");
             EM_I_PUMBUN_CD.Focus();
             setObject(true);
             return false;
         }
         
         if(EM_I_APP_DT.length == 0){                                    // 가격적용일
             showMessage(EXCLAMATION, OK, "USER-1002", "가격적용일");
             EM_I_APP_DT.Focus();
             setObject(true);
             return false;
          } 

         
         var intRowCount   = DS_IO_DETAIL.CountRow;
         var strSkuCd      = "";                    // 단품코드
         var intQty        = 0;                     // 의뢰수량       
         var intNewSalePrc = 0;                     // 매가단가  
         var intNewSaleAmt = 0;                     // 매가금액
         
         if(intRowCount > 0){
             for(var i=1; i <= intRowCount; i++){
                 
                 strSkuCd      = DS_IO_DETAIL.NameValue(i, "SKU_CD");
                 intQty        = DS_IO_DETAIL.NameValue(i, "REQ_CNT");
                 intNewSalePrc = DS_IO_DETAIL.NameValue(i, "SALE_PRC");
                 intNewSaleAmt = DS_IO_DETAIL.NameValue(i, "SALE_AMT");
                 
//                 alert("strSkuCd.length+++" + strSkuCd);
                 if(strSkuCd.length <= 0){
                     //showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
                     //GR_DETAIL.SetColumn("SKU_CD");  
                     //DS_IO_DETAIL.RowPosition = i;  
                     //return false;
                     DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                 }else{
                     DS_IO_DETAIL.NameValue(i, "CHECK1") = "F";
                	 /*                 
                     // 존재하는 단품 코드인지 확인한다.
                     if(!skuValCheck(i, "SKU_CD")){
                         showMessage(EXCLAMATION, OK, "USER-1069", "단품코드");
                         GR_DETAIL.SetColumn("SKU_CD");  
                         DS_IO_DETAIL.RowPosition = i;  
                         return false;
                     }
    */               
                     
                     // 존재하는 단품 코드인지 확인한다.
//                     alert("checkSkuInfo+++" + strSkuCd);
                     if(!checkSkuInfo(i)){
                         showMessage(EXCLAMATION, OK, "USER-1069", "단품코드");
                         GR_DETAIL.SetColumn("SKU_CD");  
                         DS_IO_DETAIL.RowPosition = i;  
                         return false;
                     }
                     
                                     
                     // 중복체크
                    var dupRow = checkDupKey(DS_IO_DETAIL, "SKU_CD");
                    if (dupRow > 0) {
                        showMessage(StopSign, Ok,  "USER-1044", dupRow);  
                        DS_IO_DETAIL.RowPosition = dupRow;
                        GR_DETAIL.SetColumn("SKU_CD");
                        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CHECK1") = "T";
                        GR_DETAIL.Focus(); 
                        return false;
                    }
                    
                     if(intQty <= 0){
                         showMessage(EXCLAMATION, OK, "USER-1003", "의뢰수량");
                         DS_IO_DETAIL.RowPosition = i;
                         GR_DETAIL.SetColumn("REQ_CNT");
                         GR_DETAIL.Focus(); 
     
                         return false;
                     }
                     
                     if(intNewSalePrc <= 0){
                         showMessage(EXCLAMATION, OK, "USER-1003", "매가단가");
                         DS_IO_DETAIL.RowPosition = i;
                         GR_DETAIL.SetColumn("SALE_PRC");
                         GR_DETAIL.Focus();
                         
                         return false;
                     }
                     
                     if(intNewSaleAmt <= 0){
                         showMessage(EXCLAMATION, OK, "USER-1003", "매가금액");
                         DS_IO_DETAIL.RowPosition = i;
                         GR_DETAIL.SetColumn("SALE_AMT");
                         GR_DETAIL.Focus();
                         
                         return false;
                     }                	 
                 }
             }
         }
         sel_DeleteRow( DS_IO_DETAIL, "CHECK1" );

         if(DS_IO_DETAIL.CountRow <= 0){
             showMessage(EXCLAMATION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오."); 
             GR_DETAIL.Focus();
             return;
         }
      }
     
     if(Gubun == "Delete"){
         if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PROC_FLAG") != "N"){
             showMessage(EXCLAMATION, OK, "GAUCE-1000", "처리되어 삭제할 수 없습니다."); 
             return false;
         }
     }
     return true; 
 }
/**
 * deleMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-03
 * 개    요 : 디테일 내용 삭제시(디테일 내용 없을떄) 마스터 내용 삭제
 * return값 : void
 */
function deleMaster(){

    var strStrCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
    var strPrtReqDt    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_DT")
    var strPrtReqSeqNo = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_SEQ_NO");

    DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);   
    var goTo       = "saveMaster";    
    var action     = "I";     
    var parameters = "&strFlag=deleMaster" 
                   + "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strPrtReqDt="+encodeURIComponent(strPrtReqDt)
                   + "&strPrtReqSeqNo="+encodeURIComponent(strPrtReqSeqNo);
    TR_S_MAIN.Action="/dps/pord304.po?goTo="+goTo+parameters; 
    TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_S_MAIN.Post(); 
    
    DS_IO_PBNPMK.ClearData();    
    DS_IO_DETAIL.ClearData();   
}
 
 

 /**
  * searchPumbunPop()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-27
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
      var strPumbunType   = "";                                                        // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "1";                                                       // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "";                                                        // 판매분매입구분

//      if(EM_S_PUMBUN_CD.Text != ""){
//            setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PUMBUN_CD, EM_PUMBUN_NM, "Y", "1"
//                                  , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
//                                  , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
//                                  , strBizType,strSaleBuyFlag);           
//      }else {       
          
         var rtnMap = strPbnPop( EM_S_PUMBUN_CD, EM_PUMBUN_NM, 'Y'
                                , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                , strBizType,strSaleBuyFlag);
//      }
  }

  /**fogud
   * searchPumbunNonPop()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-27
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
       var strPumbunType   = "";                                                        // 브랜드유형
       var strUseYn        = "Y";                                                       // 사용여부
       var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
       var strSkuType      = "";                                                        // 단품종류(1:규격단품)
       var strItgOrdFlag   = "";                                                        // 통합발주여부
       var strBizType      = "1";                                                       // 거래형태(1:직매입) 
       var strSaleBuyFlag  = "";                                                        // 판매분매입구분

       var rtnMap =  setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PUMBUN_CD, EM_PUMBUN_NM, "Y", "1"
                                 , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                 , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                 , strBizType,strSaleBuyFlag);   

       if(EM_PUMBUN_NM.Text ==""){
           setTimeout("EM_S_PUMBUN_CD.Focus()",50);
       }else{
           GR_MASTER.Focus();
       }
       
       if(rtnMap != null){
           EM_S_PUMBUN_CD.Text = rtnMap.get("PUMBUN_CD");
           EM_PUMBUN_NM.Text   = rtnMap.get("PUMBUN_NAME");

           EM_SKU_FLAG.Text    = rtnMap.get("SKU_FLAG");  //단품구분 (1 규격,  3 의류)
           EM_SKU_TYPE.Text    = rtnMap.get("SKU_TYPE");  //단품종류 (1 A의류, 2 B의류)
           
           EM_VEN_CD.Text    = rtnMap.get("VEN_CD");    //협력사
           EM_VEN_NM.Text    = rtnMap.get("VEN_NAME");  //협력사명

           return true;
       }else{
           return false;
       }       
   }
 

 /**
 * getPumbunInfo()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-27
 * 개    요 :  브랜드팝업 관련 데이터 조회 및 세팅
 * param : 
 * return값 : void
 */
 function getPumbunInfo(){
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_I_STR_CD.BindColVal;                                  // 점
     var strOrgCd        = "";                                                        // 조직코드
     var strVenCd        = "";                                                        // 협력사
     var strBuyerCd      = "";                                                        // 바이어
     var strPumbunType   = "";                                                        // 브랜드유형
     var strUseYn        = "Y";                                                       // 사용여부
     var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
     var strSkuType      = "";                                                        // 단품종류(1:규격단품)
     var strItgOrdFlag   = "";                                                        // 통합발주여부
     var strBizType      = "";                                                        // 거래형태(1:직매입,2:특정)
     var strSaleBuyFlag  = "";                                                        // 판매분매입구분(1:사전매입)

     var rtnMap = strPbnPop(EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, 'Y'
                            ,strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                            ,strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                            ,strBizType,strSaleBuyFlag);
     
   if(rtnMap != null){   
        strStyleType        = rtnMap.get("STYLE_TYPE");        
        EM_SKU_FLAG.Text    = rtnMap.get("SKU_FLAG");  //단품구분 (1 규격,  3 의류)
        EM_SKU_TYPE.Text    = rtnMap.get("SKU_TYPE");  //단품종류 (1 A의류, 2 B의류)        
        EM_VEN_CD.Text      = rtnMap.get("VEN_CD");    //협력사
        EM_VEN_NM.Text      = rtnMap.get("VEN_NAME");  //협력사명     
        EM_STYLE_TYPE.Text  = rtnMap.get("STYLE_TYPE");  //협력사명     
        //pumbunValCheck();
   }
 }
 
 

 /**
 * getSkuPop(row, colid)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-28
 * 개    요 :  단품 팝업  관련 데이터 조회 및 세팅
 * return값 : void
 *///래형래형
 function getSkuPop(row, colid, popFlag){
     var intRow          = 1;
     var strSkuCd        = DS_IO_DETAIL.NameValue(row, "SKU_CD");
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_I_STR_CD.BindColVal;                                  // 점
     var strPumbunCd     = EM_I_PUMBUN_CD.Text;                                       // 브랜드코드
     var strPumbunType   = "";                                                        // 브랜드유형
     var strBizType      = "";                                                        // 거래형태(1:직매입)
     var strUseYn        = "Y";                   

     var rtnList = strSkuMultiSelPop(strSkuCd, "", "Y"
                                     , strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType
                                     , strUseYn);

     if(rtnList != null){
         for(var i = 0; i < rtnList.length; i++){
             if(i == 0 )
                 intRow = row;
             else{
                 DS_IO_DETAIL.AddRow();
                 DS_IO_DETAIL.NameValue(i, "TAG_PRT_YN")   = "N";            	 
             }
             
             DS_IO_DETAIL.NameValue(row+i, "SKU_CD")      = rtnList[i].SKU_CD;
             
             DS_IO_DETAIL.NameValue(row+i, "SKU_NM")      = rtnList[i].SKU_NAME;
             DS_IO_DETAIL.NameValue(row+i, "RECP_NAME")   = rtnList[i].RECP_NAME;      // 영수증명
             DS_IO_DETAIL.NameValue(row+i, "PRT_REQ_SEQ_NO")   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_SEQ_NO");

             DS_IO_DETAIL.NameValue(row+i, "PUMBUN_CD")   = EM_I_PUMBUN_CD.Text;
             DS_IO_DETAIL.NameValue(row+i, "PUMBUN_NM")   = EM_O_PUMBUN_NM.Text;
             
             DS_IO_DETAIL.NameValue(row+i, "VEN_CD")   = EM_VEN_CD.Text;
             DS_IO_DETAIL.NameValue(row+i, "VEN_NM")   = EM_VEN_NM.Text;             

             DS_IO_DETAIL.NameValue(row+i, "TAG_PRT_YN")   = "N";             
             
             getSkuInfoM(row+i);
         }

         for(var x = 1; x <= DS_IO_DETAIL.CountRow; x++){                 
             if(DS_IO_DETAIL.NameValue(x, "TAG_PRT_YN")   != "N"){
                 DS_IO_DETAIL.NameValue(x, "CHECK1") = "T";
             }
         }
         sel_DeleteRow( DS_IO_DETAIL, "CHECK1" );
         
         if(rtnList.length > 1)
             setFocusGrid(GR_DETAIL, DS_IO_DETAIL,intRow,"REQ_CNT");
     }

 }

 /**
 * getABSkuPop(row, colid)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-28
 * 개    요 :  AB단품 팝업  관련 데이터 조회 및 세팅
 * return값 : void
 */
 function getABSkuPop(row, colid){
     var intRow          = 1;
     var strSkuCd        = DS_IO_DETAIL.NameValue(row, colid);
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_I_STR_CD.BindColVal;                                    // 점
     var strPumbunCd     = EM_I_PUMBUN_CD.Text;                                       // 브랜드코드
     var strPumbunType   = "";                                                        // 브랜드유형
     var strBizType      = "";                                                        // 거래형태(1:직매입)
     var strUseYn        = "Y";                                                       // 사용여부   
	 //alert(strStyleType);
     if(strStyleType == "1"){
             rtnList = skuATypeMultiSelPordPop(strSkuCd, "", "Y"
                                              , strUsrCd, strStrCd, strPumbunCd, "", ""
                                              , "", strPumbunType, strBizType, strUseYn);
      }else{
             rtnList = skuBTypeMultiSelPordPop(strSkuCd, "", "Y"
                                              , strUsrCd, strStrCd, strPumbunCd, "", ""
                                              , "", "", "", strPumbunType, strBizType
                                              , strUseYn, "", "");
      }

     // 코드 입력시
     if(strSkuCd != ""){
         if(rtnMap != null){
             DS_IO_DETAIL.NameValue(row, "SKU_CD")        = rtnMap.get("SKU_CD");         // 단품코드
             DS_IO_DETAIL.NameValue(row, "SKU_NM")        = rtnMap.get("SKU_NAME");       // 단품명
             DS_IO_DETAIL.NameValue(row, "RECP_NAME")     = rtnMap.get("RECP_NAME");      // 영수증명

             DS_IO_DETAIL.NameValue(row, "PUMBUN_CD")   = EM_I_PUMBUN_CD.Text;
             DS_IO_DETAIL.NameValue(row, "PUMBUN_NM")   = EM_O_PUMBUN_NM.Text;
             
             DS_IO_DETAIL.NameValue(row, "VEN_CD")   = EM_VEN_CD.Text;
             DS_IO_DETAIL.NameValue(row, "VEN_NM")   = EM_VEN_NM.Text;       
             DS_IO_DETAIL.NameValue(row, "TAG_PRT_YN")   = "N";    
             
             getSkuInfo();      
         }
     }else{
         // 멀티셀렉트 팝업 선택시
         if(rtnList != null){
             for(var i = 0; i < rtnList.length; i++){
                 if(i == 0 )
                     intRow = row;
                 else{
                     DS_IO_DETAIL.AddRow();              
                 }
                 
                 DS_IO_DETAIL.NameValue(row+i, "SKU_CD")      = rtnList[i].SKU_CD;
                 DS_IO_DETAIL.NameValue(row+i, "SKU_NM")      = rtnList[i].SKU_NAME;
                 DS_IO_DETAIL.NameValue(row+i, "RECP_NAME")   = rtnList[i].RECP_NAME;  //영수증명

                 DS_IO_DETAIL.NameValue(row+1, "PUMBUN_CD")   = EM_I_PUMBUN_CD.Text;
                 DS_IO_DETAIL.NameValue(row+1, "PUMBUN_NM")   = EM_O_PUMBUN_NM.Text;
                 
                 DS_IO_DETAIL.NameValue(row+1, "VEN_CD")   = EM_VEN_CD.Text;
                 DS_IO_DETAIL.NameValue(row+1, "VEN_NM")   = EM_VEN_NM.Text;      
                 DS_IO_DETAIL.NameValue(row+1, "TAG_PRT_YN")   = "N";   

                 getSkuInfoM(row+i);
             }

             //TAG_PRT_YN 가 ""인 데이터는 삭제한다
             for(var x = 1; x <= DS_IO_DETAIL.CountRow; x++){  
                 if(DS_IO_DETAIL.NameValue(x, "TAG_PRT_YN")   != "N"){
                     DS_IO_DETAIL.NameValue(x, "CHECK1") = "T";
                 }
             }
             sel_DeleteRow( DS_IO_DETAIL, "CHECK1" );
             
             if(rtnList.length > 1)
                 setFocusGrid(GR_DETAIL, DS_IO_DETAIL,intRow,"REQ_CNT");
         }
     }
 }
 

 

 /**
 * getSkuInfo()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-03
 * 개    요 :  단품 매가 원가 
 * return값 : void
 */
 function getSkuInfo(){
     
     var strStrCd = LC_I_STR_CD.BindColVal;
     var strSkuCd = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SKU_CD");
     var strAppDt = EM_I_APP_DT.Text;
     
     var goTo       = "getSkuInfo" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strSkuCd="+encodeURIComponent(strSkuCd)   
                    + "&strAppDt="+encodeURIComponent(strAppDt);     
     TR_S_MAIN.Action="/dps/pord304.po?goTo="+goTo+parameters;   
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_I_SKU_SALEPRC=DS_I_SKU_SALEPRC)";
     TR_S_MAIN.Post(); 

//     alert("1111");
     if(DS_I_SKU_SALEPRC.CountRow == 0){
         showMessage(EXCLAMATION, OK, "GAUCE-1000", "해당 단품에 가격정보가 없습니다. 확인바랍니다."); 
         clearSkuRowData();
//         DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
         return;
     }
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SALE_PRC") = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"SALE_PRC"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"STYLE_CD") = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"STYLE_CD"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"COLOR_CD") = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"COLOR_CD"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SIZE_CD")  = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"SIZE_CD"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"PUMMOK_SRT_CD")= DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"PUMMOK_SRT_CD"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"PUMMOK_CD")= DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"PUMMOK_CD"); 
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"RECP_NAME")= DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"RECP_NAME"); 

     //래형래형
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "TAG_PRT_YN")   = "N";
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD")       = LC_S_STR_CD.BindColVal;
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PRT_REQ_DT")   = EM_I_PRT_REQ_DT.Text;   
     
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PRT_REQ_SEQ_NO")= DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_SEQ_NO");
 }
 


 /**
 * getSkuInfo()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-03
 * 개    요 :  단품 매가 원가 
 * return값 : void
 */
 function getSkuInfoM(row){
     
     var strStrCd = LC_I_STR_CD.BindColVal;
     var strSkuCd = DS_IO_DETAIL.NameValue(row, "SKU_CD");
     var strAppDt = EM_I_APP_DT.Text;
     
     var goTo       = "getSkuInfo" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                    + "&strSkuCd="+encodeURIComponent(strSkuCd)    
                    + "&strAppDt="+encodeURIComponent(strAppDt);     
     TR_S_MAIN.Action="/dps/pord304.po?goTo="+goTo+parameters;   
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_I_SKU_SALEPRC=DS_I_SKU_SALEPRC)";
     TR_S_MAIN.Post(); 

//     alert("1111");
     if(DS_I_SKU_SALEPRC.CountRow == 0){
         showMessage(EXCLAMATION, OK, "GAUCE-1000", "해당 단품에 가격정보가 없습니다. 확인바랍니다."); 
         clearSkuRowData();
//         DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
         return;
     }
     DS_IO_DETAIL.NameValue(row,"SALE_PRC")      = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"SALE_PRC"); 
     DS_IO_DETAIL.NameValue(row,"STYLE_CD")      = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"STYLE_CD"); 
     DS_IO_DETAIL.NameValue(row,"COLOR_CD")      = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"COLOR_CD"); 
     DS_IO_DETAIL.NameValue(row,"SIZE_CD")       = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"SIZE_CD"); 
     DS_IO_DETAIL.NameValue(row,"PUMMOK_SRT_CD") = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"PUMMOK_SRT_CD"); 
     DS_IO_DETAIL.NameValue(row,"PUMMOK_CD")     = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"PUMMOK_CD"); 
     DS_IO_DETAIL.NameValue(row,"RECP_NAME")     = DS_I_SKU_SALEPRC.NameValue(DS_I_SKU_SALEPRC.RowPosition,"RECP_NAME"); 

     //래형래형
     DS_IO_DETAIL.NameValue(row, "TAG_PRT_YN")   = "N";
     DS_IO_DETAIL.NameValue(row, "STR_CD")       = LC_S_STR_CD.BindColVal;
     DS_IO_DETAIL.NameValue(row, "PRT_REQ_DT")   = EM_I_PRT_REQ_DT.Text;   
     
     DS_IO_DETAIL.NameValue(row, "PRT_REQ_SEQ_NO")= DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_SEQ_NO");
 }
 

 /**
 * checkSkuInfo()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-03
 * 개    요 :  단품 매가 원가 
 * return값 : void
 */
 function checkSkuInfo(row){
     
     var strStrCd = LC_I_STR_CD.BindColVal;
     var strSkuCd = DS_IO_DETAIL.NameValue(row, "SKU_CD");
     var strAppDt = EM_I_APP_DT.Text;
     
     var goTo       = "getSkuInfo" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strSkuCd="+encodeURIComponent(strSkuCd)    
                    + "&strAppDt="+encodeURIComponent(strAppDt);     
     TR_S_MAIN.Action="/dps/pord304.po?goTo="+goTo+parameters;   
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_I_SKU_SALEPRC=DS_I_SKU_SALEPRC)";
     TR_S_MAIN.Post(); 

     
     if(DS_I_SKU_SALEPRC.CountRow == 0){
//         showMessage(EXCLAMATION, OK, "GAUCE-1000", "해당 단품에 가격정보가 없습니다. 확인바랍니다."); 
//         DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
         return false;
     }else{
    	 return true;
     }
 }
 


 /**
 * pumbunValCheck()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-22
 * 개    요 :  브랜드  Validation Check
 * return값 : void
 */
 function pumbunValCheck(){
//	 alert();
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_I_STR_CD.BindColVal;                                         // 점
     var strOrgCd        = "";                                                        // 조직코드
     var strVenCd        = "";                                                        // 협력사
     var strBuyerCd      = "";                                                        // 바이어
     var strPumbunType   = "";                                                        // 브랜드유형
     var strUseYn        = "Y";                                                       // 사용여부
     var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
     var strSkuType      = "";                                                        // 단품종류(1:규격단품)
     var strItgOrdFlag   = "";                                                        // 통합발주여부
     var strBizType      = "";                                                        // 거래형태(1:직매입,2:특정)
     var strSaleBuyFlag  = "";                                                        // 판매분매입구분(1:사전매입)

     var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, "Y", "0"
           , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
           , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
           , strBizType,strSaleBuyFlag);

     if(DS_O_RESULT.CountRow == 1){
         EM_VEN_CD.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD");    //협력사
         EM_VEN_NM.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_NAME");  //협력사명  
         

         EM_I_PUMBUN_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "PUMBUN_CD");
         EM_O_PUMBUN_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "PUMBUN_NAME");

         EM_SKU_FLAG.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "SKU_FLAG");  //단품구분 (1 규격,  3 의류)
         EM_SKU_TYPE.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "SKU_TYPE");  //단품종류 (1 A의류, 2 B의류)
         EM_STYLE_TYPE.Text  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "STYLE_TYPE");  //단품종류 (1 A의류, 2 B의류)
         
         
         return true;    	 
     }else
         return false;
 }

 
 

 /**
 * skuValCheck(row, colid)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-22
 * 개    요 :  단품  Validation Check
 * return값 : void
 */
 function skuValCheck(row, colid){
//   alert("2");
     var intRow          = 1;
     var strSkuCd        = DS_IO_DETAIL.NameValue(row, colid);
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_I_STR_CD.BindColVal;                                         // 점
     var strPumbunCd     = EM_I_PUMBUN_CD.Text;                                         // 브랜드코드
     var strPumbunType   = "";                                                        // 브랜드유형
     var strBizType      = "";                                                        // 거래형태(1:직매입)
     var strUseYn        = "Y";                                                       // 사용여부   

     var rtnMap = setStrSkuNmWithoutToGridPordPop( "DS_O_RESULT", strSkuCd, "", "Y", "0",
                                               strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType,
                                               strUseYn);

//     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SKU_CD") = rtnMap.get("SKU_CD");
//     alert(rtnMap.get("SKU_CD"));
     if(rtnMap != null)
         return true;
     else
         return false;
 }
 
 
 /**
  * clearPumbunInfo()
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-03-08
  * 개    요 :  브랜드정보 Clear
  * return값 : void
  */
 function clearPumbunInfo(){
      EM_O_PUMBUN_NM.Text    = "";
      EM_VEN_CD.Text         = "";
      EM_VEN_NM.Text         = "";
 }
 
 
 /**
  * clearPumbunInfo()
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-03-08
  * 개    요 :  단품정보 Clear
  * return값 : void
  */
 function clearSkuRowData(){
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMMOK_CD")   = "";
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMBUN_CD")   = "";
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "RECP_NAME")   = "";
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STYLE_CD")    = "";
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "COLOR_CD")    = "";
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STYLE_CD")    = "";
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD")      = "";
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SALE_PRC")    = "";
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SALE_AMT")    = "";
 }
 
 /**
  * setStrPbnNmWithoutPopCall()
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-03-10
  * 개    요 :  브랜드입력시 부가정보 바로세팅
  * return값 : void
  */
  function setStrPbnNmWithoutPopCall(){
         var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
         var strStrCd        = LC_I_STR_CD.BindColVal;                                  // 점
         var strOrgCd        = "";                                                        // 조직코드
         var strVenCd        = "";                                                        // 협력사
         var strBuyerCd      = "";                                                        // 바이어
         var strPumbunType   = "";                                                        // 브랜드유형
         var strUseYn        = "Y";                                                       // 사용여부
         var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
         var strSkuType      = "";                                                        // 단품종류(1:규격단품)
         var strItgOrdFlag   = "";                                                        // 통합발주여부
         var strBizType      = "";                                                        // 거래형태(1:직매입,2:특정)
         var strSaleBuyFlag  = "";                                                        // 판매분매입구분(1:사전매입)

         if(EM_I_PUMBUN_CD.Text != ""){
             var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, "Y", '0'
                                   , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                   , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                   , strBizType,strSaleBuyFlag);
             
             EM_SKU_FLAG.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "SKU_FLAG");  //단품구분 (1 규격,  3 의류)
             EM_SKU_TYPE.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "SKU_TYPE");  //단품종류 (1 규격, 2 신선, 3 의류)
             
             EM_STYLE_TYPE.Text  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "STYLE_TYPE");  //단품종류 (1 A의류, 2 B의류)
             
             EM_VEN_CD.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD");    //협력사
             EM_VEN_NM.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_NAME");  //협력사명
         }         
  } 
  
 function test(){
//      alert("단품구분 = " + DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_FLAG"));
//      alert(EM_SKU_FLAG.text);
//        alert(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAG_FLAG_NM"));
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
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_M_MAIN event=onSuccess>
    for(i=0;i<TR_M_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_M_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
trFailed(TR_S_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_M_MAIN event=onFail>
trFailed(TR_M_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--  ===================DS_MASTER============================ -->


<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
//CanRowPosChange 구분위한
    if(saveFlag) return true;
    
    if(DS_IO_MASTER.IsUpdated){       //마스터 변경시
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            return false;
        }else {
            if(DS_IO_MASTER.NameValue(row, "PRT_REQ_SEQ_NO") == "")
                DS_IO_MASTER.DeleteRow(row);
            return true;
        }       
    }else if(DS_IO_DETAIL.IsUpdated){      //디테일 변경시
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            return false;
        }else {
//          alert();
            //DS_IO_DETAIL.DeleteRow(row);
            return true;
        }
    }else{
        return true;
    }
    
</script>

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>

if(clickSORT)
    return;

    var strPrtReqSeqNo = DS_IO_MASTER.NameValue(row, "PRT_REQ_SEQ_NO");
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        
        if(strPrtReqSeqNo != ""){ 
            setTimeout("setObject(false)", 50); 
	        getPbnSku(); 
        }
        
        if(strPrtReqSeqNo !=""){
            if(inta == 0){  
                inta++;
            }else{
                setPorcCount("SELECT", DS_IO_DETAIL.CountRow);      
            }        	
        }
    } 
    
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PROC_FLAG") == "Y"){
        enableControl(IMG_ADD, false);
        enableControl(IMG_DEL, false);
    }else{
        enableControl(IMG_ADD, true);
        enableControl(IMG_DEL, true);    	
    }

    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE") == '1' || EM_SKU_TYPE.Text == '1'){ //규격단품
        GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = false;
        GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
        GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;
    }else if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE") == '3' || EM_SKU_TYPE.Text == '3'){ //의류단품
    	if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STYLE_TYPE") == '1' || EM_STYLE_TYPE.Text == '1'){
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = true;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = true;       		
    	}else{
            GR_DETAIL.ColumnProp("STYLE_CD",   "show")      = true;
            GR_DETAIL.ColumnProp("COLOR_CD",   "show")      = false;
            GR_DETAIL.ColumnProp("SIZE_CD",    "show")      = false;                 		
    	}     
    }    

</script>

<!-- 단품 디테일 입력시 중복 체크 -->
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
    
    switch (colid) {
    /*
    case "PUMBUN_CD": 	
        if(EM_I_PUMBUN_CD.Text.length != 6){
            clearPumbunInfo();
            return;
        }
//        }else if(EM_I_PUMBUN_CD.Text.length == 6){
//            if(pumbunValCheck()){            
//               return
//            }else{
//                getPumbunInfo();
//            }
//        }              
        DS_IO_DETAIL.ClearData();           
        break;      
 */
    case "PRT_REQ_DT":    
        if(EM_I_PRT_REQ_DT.Text.length == 8){
            if(EM_I_PRT_REQ_DT.Text < strToday){
                showMessage(EXCLAMATION, OK, "USER-1030", "의뢰일자");
                EM_I_PRT_REQ_DT.Text = strToday;
                EM_I_PRT_REQ_DT.Focus();
                return false;           
            }           
        }
        break;       
    case "MG_APP_DT":    
        if(EM_I_APP_DT.Text.length == 8){
            if(EM_I_APP_DT.Text < strToday){
                showMessage(EXCLAMATION, OK, "USER-1030", "가격적용일");
                EM_I_APP_DT.Text = strToday;
                EM_I_APP_DT.Focus();
                return false;           
            }           
        }
        break;
    }
</script>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       

<script language=JavaScript for=DS_IO_DETAIL event=onRowPosChanged(row)>

if(clickSORT)
    return;
</script>   

<!-- 단품 디테일 입력시 중복 체크 -->
<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>

    var strReqCnt  = parseInt(DS_IO_DETAIL.NameValue(row, "REQ_CNT"));    //의뢰수량(Grid)
    var strSalePrc = parseInt(DS_IO_DETAIL.NameValue(row, "SALE_PRC"));   //매가단가(Grid)
    var strSaleAmt = 0;
    
    strSaleAmt = strReqCnt*strSalePrc;
    DS_IO_DETAIL.NameValue(row, "SALE_AMT") = strSaleAmt;                 //매가금액
    
    var orgValue = DS_IO_DETAIL.OrgNameValue(row, "SKU_CD");
    var newValue = DS_IO_DETAIL.NameValue(row, "SKU_CD");
    
    switch (colid) {
    case "SKU_CD":
    	//getSkuInfo()
    	 blnSkuChanged = true;
        if(orgValue.length > 0)
            if(orgValue != newValue){
                //getSkuInfo();
//                this.NameValue(row,"ORG_SKU_CD") = newValue;               
            }
        break;
    }

</script>

<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid);
/*
    if( row < 1){
        if( DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
            showMessage(EXCLAMATION, OK, "USER-1000","변경된 상세내역이 존재하여 정렬 할 수 없습니다.");
            return;
        }
        sortColId( eval(this.DataID), row , colid );
    }    
*/    
</script>

<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid);

</script>

<!-- GR_DETAIL CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_DETAIL event=CanColumnPosChange(Row,Colid)>
    switch (Colid) {
    case "SKU_CD":

        if(DS_IO_DETAIL.NameValue(Row, "SKU_CD") == "")
            return;
        
        var blnSkuChk = skuValCheck(Row,Colid);
        if(blnSkuChk) {
//          getSkuPop(Row,Colid);
            return true;
        }else if (!blnSkuChk && DS_IO_DETAIL.NameValue(Row,"SKU_CD") == ""){
            setTimeout("showMessage(EXCLAMATION, OK,'USER-1003', '단품코드')",50);
//            DS_IO_DETAIL.DeleteRow(Row);
//            DS_IO_DETAIL.InsertRow(Row);
            clearSkuRowData();
            DS_IO_DETAIL.NameValue(Row, "SKU_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "CHECK1") = 'T';
            DS_IO_DETAIL.NameValue(Row, "TAG_PRT_YN")   = "N";
            GR_DETAIL.Focus();
            return false;
        }else {
            //if(this.NameValue(row,"SKU_CD") != "")
            setTimeout("showMessage(EXCLAMATION, OK, 'USER-1065', '정확한 단품코드')",50);
//            DS_IO_DETAIL.DeleteRow(Row);
//            DS_IO_DETAIL.InsertRow(Row);
            clearSkuRowData();
            DS_IO_DETAIL.NameValue(Row, "SKU_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "CHECK1") = 'T';
            DS_IO_DETAIL.NameValue(Row, "TAG_PRT_YN")   = "N";
            GR_DETAIL.Focus();
            return false;
        }        
        if (blnSkuChanged) {
            //clearDataSetRow(DS_IO_DETAIL);
            if(DS_IO_DETAIL.NameValue(row,"SKU_CD") != "")
            setTimeout("showMessage(EXCLAMATION, OK, 'USER-1065', '정확한 단품코드')",50);
//            DS_IO_DETAIL.DeleteRow(Row);
//            DS_IO_DETAIL.InsertRow(Row);
            clearSkuRowData();
            DS_IO_DETAIL.NameValue(Row, "SKU_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "CHECK1") = 'T';
            DS_IO_DETAIL.NameValue(Row, "TAG_PRT_YN")   = "N";
            GR_DETAIL.Focus();
            blnSkuChanged = false;
            return false;
        }else{
            return true;
        }
    }
</script>

<!-- GR_DETAIL OnColumnPosChanged(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_DETAIL event=OnColumnPosChanged(Row,Colid)>
    switch (Colid) {
    case "REQ_CNT":
    	if(!saveFlag){
    		if(DS_IO_DETAIL.CountRow > 0){
		    	if(DS_IO_DETAIL.NameValue(Row, "SKU_CD").length != 0){	
		            getSkuInfo();
		    	}
    		}
    	}
        break;
    }
</script>


<!-- 품목 그리드 헤더 선택시 전체 선택/해제 -->
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GR_DETAIL event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_IO_DETAIL.CountRow; i++){
        	if(DS_IO_DETAIL.NameValue(i,"TAG_PRT_YN") == "Y"){        		
        	}else{
                DS_IO_DETAIL.NameValue(i, "CHECK1") = 'T';
        	}
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_IO_DETAIL.CountRow; i++){
            DS_IO_DETAIL.NameValue(i, "CHECK1") = 'F';
        }
    }
</script>

<!-- GD_DETAIL OnPopup event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnPopup(row,colid,data)>
    //getSkuPop(row, colid);
    
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE") == '1' || EM_SKU_TYPE.Text == '1'){     //단품종류가 규격단품이면
        getSkuPop(row, colid, '1');                              //규격단품 팝업띄우는 함수
    }else if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE") == '3' || EM_SKU_TYPE.Text == '3'){
//      alert("의류단품인가");
        getABSkuPop(row, colid);
    }else if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_TYPE") == '2' || EM_SKU_TYPE.Text == '2'){   
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "신선단품은 등록할 수 없습니다."); 
        return;
    }
</script>



<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!--*************************************************************************-->

<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PUMBUN_CD event=onKillFocus()>
	
	if(EM_S_PUMBUN_CD.Text != ""){
	    searchPumbunNonPop();
	}else
		EM_PUMBUN_NM.Text = "";   
</script>


<!-- 브랜드 KillFocus -->
<script language=JavaScript for=EM_I_PUMBUN_CD event=onKillFocus()>

	if(EM_I_PUMBUN_CD.Text.length == 6){
	    if(pumbunValCheck()){
	        return
	    }else{
	        getPumbunInfo();
	    }
	}else if(EM_I_PUMBUN_CD.Text.length == 0){
		clearPumbunInfo();
		return;
	}else{
		clearPumbunInfo();
        getPumbunInfo();
	}
  
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
    EM_S_PUMBUN_CD.Text = "";
    EM_PUMBUN_NM.Text   = "";
</script>



<!-- 점(입력)  변경시  -->
<script language=JavaScript for=LC_I_STR_CD event=OnSelChange()>
    EM_I_PUMBUN_CD.Text  = "";
    EM_O_PUMBUN_NM.Text  = "";
    LC_I_TAG_FLAG.Index  = 0;
    clearPumbunInfo();
</script>


<!-- 의뢰일자 변경시  -->
<script lanaguage=JavaScript for=EM_S_PRT_REQ_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_PRT_REQ_DT );
</script>

<!-- 입력부 의뢰일자 변경시  -->
<script lanaguage=JavaScript for=EM_I_PRT_REQ_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_I_PRT_REQ_DT );
</script>

<!-- 마진적용일 변경시  -->
<script lanaguage=JavaScript for=EM_I_APP_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_I_APP_DT );
</script>



<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_STR"            classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TAG_FLAG"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SKU_SALEPRC"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PBN_SKU_TYPE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
    <object id="TR_M_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
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
            <td width="140">
              <comment id="_NSID_">
                <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">의뢰일자</th>
            <td width="220">
              <comment id="_NSID_">
                <object id=EM_S_PRT_REQ_DT classid=<%= Util.CLSID_EMEDIT %> width=70 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script><img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_PRT_REQ_DT)" align="absmiddle" />
              ~<comment id="_NSID_">
                <object id=EM_S_PRT_REQ_DT2 classid=<%= Util.CLSID_EMEDIT %> width=70 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script><img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_PRT_REQ_DT2)" align="absmiddle" />
            </td>
            <th width="80">의뢰번호</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_S_PRT_REQ_SEQ_NO classid=<%= Util.CLSID_EMEDIT %> width=150 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th>브랜드</th>
            <td colspan="5">
              <comment id="_NSID_">
                <object id=EM_S_PUMBUN_CD classid=<%= Util.CLSID_EMEDIT %> width=116 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script><img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:searchPumbunPop()"  align="absmiddle" /><comment id="_NSID_">
                &nbsp;<object id=EM_PUMBUN_NM classid=<%= Util.CLSID_EMEDIT %> width=200 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"  ></td>
  </tr> 
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width="250">
          <table  width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><OBJECT id=GR_MASTER  width="290" height=754 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_IO_MASTER">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
        </td>
        <td class="PL10" >
        
                <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                <tr>
                <td class="PT01 PB03">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                      <th width="100" class="point">점</th>
                        <td width="140">
                          <comment id="_NSID_">
                            <object id=LC_I_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=140  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                        </td>
                        <th>택구분</th>
                        <td >
                          <comment id="_NSID_">
                            <object id=LC_I_TAG_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=140  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                        </td>
                      </tr>
                    <tr>
                      <th width="100" class="point">의뢰일자</th>
                        <td width="140">
                          <comment id="_NSID_">
                            <object id=EM_I_PRT_REQ_DT classid=<%=Util.CLSID_EMEDIT%> width=115  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script><img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_PRT_REQ_DT onclick="javascript:openCal('G',EM_I_PRT_REQ_DT)" align="absmiddle" />
                        </td>
                        <th width="100">의뢰번호</th>
                        <td >
                          <comment id="_NSID_">
                            <object id=EM_O_PRT_REQ_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=140  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                        </td>
                      </tr>
                      
                      <tr>
                        <th class="point">브랜드</th>
                        <td colspan="3">
                          <comment id="_NSID_">
                            <object id=EM_I_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=115 tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script><img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_PUMBUN_CD class="PR03" onclick="javascript:getPumbunInfo()"  align="absmiddle" />
                          &nbsp;<comment id="_NSID_">
                            <object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=259 tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>                          
                        </td>
                      </tr>
                      
                      <tr>
                        <th>협력사</th>
                        <td colspan="3">
                          <comment id="_NSID_">
                            <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                          &nbsp;&nbsp;<comment id="_NSID_">
                            <object id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=259 tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>                        
                        </td>
                      </tr>
                      
                      <tr>
                        <th class="point">가격적용일</th>
                        <td>
                          <comment id="_NSID_">
                            <object id=EM_I_APP_DT classid=<%=Util.CLSID_EMEDIT%> width=115  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script></script><img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_APP_DT onclick="javascript:openCal('G',EM_I_APP_DT)" align="absmiddle" />
                        </td>
                      <th class="point">생산년도</th> 
                        <td colspan="4">
                          <comment id="_NSID_">
                            <object id=EM_I_YYYY classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>  
                        </td>

                      </tr> 
                       </table></td>
                  </tr>                
                  
                  <tr>
                    <td class="dot"  ></td>
                  </tr>
                  
                  <tr>
                     <td class="right"><img src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD"  width="52" height="18" hspace="2" onclick="javascript:addDetailRow();" /><img src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL" width="52" height="18" onclick="javascript:delDetailRow();" />
                     </td>
                  </tr> 
                  
                  <tr>
                    <td> <table border="0" cellspacing="0" cellpadding="0" class="BD4A" width="100%" >
                      <tr>
                        <td>
                          <comment id="_NSID_"><OBJECT id=GR_DETAIL width="100%" height=600 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_DETAIL">
                            <Param Name="ViewSummary" value="1">
                          </OBJECT></comment><script>_ws_(_NSID_);</script>
                        </td>
                        
                      </tr>
                    </table></td>
                  </tr>
                </table>
            </td>
          </tr>
        </table></td>
    </tr>
</table>

<comment id="_NSID_"> 
    <object id=EM_SKU_FLAG classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object>     
</comment><script> _ws_(_NSID_);</script>

<comment id="_NSID_"> 
    <object id=EM_SKU_TYPE classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
</div>

<comment id="_NSID_"> 
    <object id=EM_STYLE_TYPE classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"> </object> 
</comment><script> _ws_(_NSID_);</script>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            
        <c>Col=PRT_REQ_DT           Ctrl=EM_I_PRT_REQ_DT      param=Text</c>
        <c>Col=PRT_REQ_SEQ_NO       Ctrl=EM_O_PRT_REQ_SEQ_NO  param=Text</c>
        <c>Col=PUMBUN_CD            Ctrl=EM_I_PUMBUN_CD       param=Text</c>
        <c>Col=PUMBUN_NM            Ctrl=EM_O_PUMBUN_NM       param=Text</c>
        <c>Col=VEN_CD               Ctrl=EM_VEN_CD            param=Text</c>
        <c>Col=VEN_NM               Ctrl=EM_VEN_NM            param=Text</c>
        <c>Col=MG_APP_DT            Ctrl=EM_I_APP_DT          param=Text</c>
        <c>Col=PRT_YYYY             Ctrl=EM_I_YYYY            param=Text</c>  
        <c>Col=STR_CD               Ctrl=LC_I_STR_CD          param=BindColVal</c>  
        <c>Col=TAG_FLAG             Ctrl=LC_I_TAG_FLAG        param=BindColVal</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
