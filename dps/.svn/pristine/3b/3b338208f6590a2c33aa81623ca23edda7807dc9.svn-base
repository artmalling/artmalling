<!-- 
/*******************************************************************************
 * 시스템명 : 자동전표 현황 조회
 * 작 성 일 : 2010.04.38
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord1211.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 자동전표 현황 조회  팝업
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
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
<title>OFFER_NO-POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var returnParam    = dialogArguments[0];
 var strStrCd       = dialogArguments[1];       // 점코드          
 var strOrdDt       = dialogArguments[2];       // 일자
 var strSlipNo      = dialogArguments[3];       // 전표번호 
 var strSlipFlag    = dialogArguments[4];       // 전표구분
 var strSkuflag     = dialogArguments[5];       // 단품구분
 var strSkuType     = dialogArguments[6];       // 단품종류
 var strPairStrCd   = dialogArguments[7];       // 상대점
 var strPairSlipNo  = dialogArguments[8];       // 상대전표

 var strToday       = "" ;
 var strYYYYMM      = "" ;
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-16
 * 개    요 : initialize
 * return값 : void
**/
function doInit() 
{            
//     alert(strStrCd);
//     alert(strSlipNo);
//     alert(strSlipFlag);
     DS_DETAIL1.setDataHeader('<gauce:dataset name="H_DETAIL1"/>');
     DS_DETAIL2.setDataHeader('<gauce:dataset name="H_DETAIL2"/>');
     DS_DETAIL3.setDataHeader('<gauce:dataset name="H_DETAIL2"/>');
     
     //그리드 초기화
     gridCreate1(); //디테일(품목)
     gridCreate2(); //디테일(규격 신선 의류)
     gridCreate3(); //디테일(매가인상하)
     gridCreate4(); //디테일(대출)
     gridCreate5(); //디테일(대입)
     
     search();
} 


//품목
function gridCreate1(){
    var hdrProperies = '<FC>id={currow}            name="NO"          width=30     align=center  sumtext="" </FC>'
                    + '<FC>id=STR_CD               name="점코드"      width=65      align=left show=false</FC>'
                    + '<FC>id=STR_NM               name="점명"        width=65      align=left show=false</FC>'
                    + '<FC>id=SLIP_NO              name="전표번호"     width=95     align=left Mask="XXXX-X-XXXXXXX"</FC>'
                    + '<FC>id=ORD_SEQ_NO           name="전표상세번호" width=65     align=left show=false</FC>'
                    + '<FC>id=PUMMOK_CD            name="품목코드"     width=100     align=left </FC>'
                    + '<FC>id=PUMMOK_NM            name="품목명"       width=110     align=left </FC>'
                    + '<FC>id=ORD_UNIT_CD          name="단위코드"     width=65     align=left show=false</FC>'
                    + '<FC>id=ORD_UNIT_NM          name="단위명"       width=65     align=left </FC>'
                    + '<FC>id=ORD_QTY              name="수량"         width=65     align=right </FC>'
                    + '<FC>id=CHK_QTY              name="검품수량"     width=65     align=right </FC>'
                    + '<FC>id=MG_RATE              name="마진율"       width=65     align=right </FC>'
                    + '<FG>  name ="원가"'
                    + '<FC>id=NEW_COST_PRC         name="단가"         width=80     align=right </FC>'
                    + '<FC>id=NEW_COST_AMT         name="금액"         width=100     align=right </FC>'
                    + '</FG>'
                    + '<FG>  name ="매가"'
                    + '<FC>id=NEW_SALE_PRC         name="단가"         width=80     align=right </FC>'
                    + '<FC>id=NEW_SALE_AMT         name="금액"         width=100     align=right </FC>'
                    + '</FG>';

    initGridStyle(GR_DETAIL1, "common", hdrProperies, false);
}
 

//규격발주
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}            name="NO"          width=30     align=center  sumtext="" </FC>'
                    + '<FC>id=STR_CD               name="점코드"      width=65      align=left show=false</FC>'
                    + '<FC>id=STR_NM               name="점명"        width=65      align=left show=false</FC>'
                    + '<FC>id=SLIP_NO              name="전표번호"     width=95     align=left Mask="XXXX-X-XXXXXXX"</FC>'
                    + '<FC>id=ORD_SEQ_NO           name="전표상세번호" width=65     align=left show=false</FC>'
                    + '<FC>id=SKU_CD               name="단품코드"     width=100     align=left </FC>'
                    + '<FC>id=SKU_NM               name="단품명"       width=130     align=left </FC>'
                    + '<FC>id=STYLE_CD             name="스타일"       width=100     align=center </FC>'
                    + '<FC>id=COLOR_CD             name="칼라"         width=65     align=center </FC>'
                    + '<FC>id=SIZE_CD              name="사이즈"       width=65     align=center </FC>'
                    + '<FC>id=ORD_UNIT_CD          name="단위코드"     width=65     align=left show=false</FC>'
                    + '<FC>id=ORD_UNIT_NM          name="단위명"       width=65     align=left </FC>'
                    + '<FC>id=ORD_QTY              name="수량"         width=65     align=right </FC>'
                    + '<FC>id=CHK_QTY              name="검품수량"     width=65     align=right </FC>'
                    + '<FG>  name ="원가"'
                    + '<FC>id=NEW_COST_PRC         name="단가"         width=80     align=right </FC>'
                    + '<FC>id=NEW_COST_AMT         name="금액"         width=100     align=right </FC>'
                    + '</FG>'
                    + '<FG>  name ="매가"'
                    + '<FC>id=NEW_SALE_PRC         name="단가"         width=80     align=right </FC>'
                    + '<FC>id=NEW_SALE_AMT         name="금액"         width=100     align=right </FC>'
                    + '</FG>'
                    + '<FC>id=NEW_GAP_RATE         name="차익율"       width=65     align=right </FC>';         
     initGridStyle(GR_DETAIL2, "common", hdrProperies, false);
}
 

//매가인상하
function gridCreate3(){
    var hdrProperies = '<FC>id={currow}            name="NO"          width=30     align=center  sumtext="" </FC>'
                    + '<FC>id=STR_CD               name="점코드"      width=65      align=left show=false</FC>'
                    + '<FC>id=STR_NM               name="점명"        width=65      align=left show=false</FC>'
                    + '<FC>id=SLIP_NO              name="전표번호"     width=95     align=left Mask="XXXX-X-XXXXXXX"</FC>'
                    + '<FC>id=ORD_SEQ_NO           name="전표상세번호" width=65     align=left show=false</FC>'
                    + '<FC>id=SKU_CD               name="단품코드"     width=100     align=left </FC>'
                    + '<FC>id=SKU_NM               name="단품명"       width=130     align=left </FC>'
                    + '<FC>id=STYLE_CD             name="스타일"       width=100     align=center </FC>'
                    + '<FC>id=COLOR_CD             name="칼라"         width=65     align=center </FC>'
                    + '<FC>id=SIZE_CD              name="사이즈"       width=65     align=center </FC>'
                    + '<FC>id=ORD_UNIT_CD          name="단위코드"     width=65     align=left show=false</FC>'
                    + '<FC>id=ORD_UNIT_NM          name="단위명"       width=65     align=left </FC>'
                    + '<FC>id=ORD_QTY              name="수량"         width=65     align=right </FC>'
                    + '<FC>id=CHK_QTY              name="검품수량"     width=65     align=right </FC>'
                    + '<FG>  name ="구매가"'
                    + '<FC>id=OLD_SALE_PRC         name="단가"         width=80     align=right </FC>'
                    + '<FC>id=OLD_SALE_AMT         name="금액"         width=100     align=right </FC>'
                    + '</FG>'
                    + '<FG>  name ="신매가"'
                    + '<FC>id=N_NEW_SALE_PRC       name="단가"         width=80     align=right </FC>'
                    + '<FC>id=N_NEW_SALE_AMT       name="금액"         width=100     align=right </FC>'
                    + '</FG>'
                    + '<FC>id=NEW_GAP_AMT          name="차익액"       width=65     align=right </FC>';      
    initGridStyle(GR_DETAIL3, "common", hdrProperies, false);
}
 

//대출
function gridCreate4(){
    var hdrProperies = '<FC>id={currow}            name="NO"          width=30     align=center  sumtext="" </FC>'
                    + '<FC>id=STR_CD               name="점코드"      width=65      align=left show=false</FC>'
                    + '<FC>id=STR_NM               name="점명"        width=65      align=left show=false</FC>'
                    + '<FC>id=SLIP_NO              name="전표번호"     width=95     align=left Mask="XXXX-X-XXXXXXX"</FC>'
                    + '<FC>id=ORD_SEQ_NO           name="전표상세번호" width=65     align=left show=false</FC>'
                    + '<FC>id=PUMMOK_CD            name="품목코드"     width=65     align=left show=false</FC>'
                    + '<FC>id=PUMMOK_NM            name="품목명"       width=65     align=left show=false</FC>'
                    + '<FC>id=SKU_CD               name="단품코드"     width=100     align=left </FC>'
                    + '<FC>id=SKU_NM               name="단품명"       width=130     align=left </FC>'
                    + '<FC>id=STYLE_CD             name="스타일"       width=100     align=center </FC>'
                    + '<FC>id=COLOR_CD             name="칼라"         width=65     align=center </FC>'
                    + '<FC>id=SIZE_CD              name="사이즈"       width=65     align=center </FC>'
                    + '<FC>id=ORD_UNIT_CD          name="단위코드"     width=65     align=left show=false</FC>'
                    + '<FC>id=ORD_UNIT_NM          name="단위명"       width=65     align=left </FC>'
                    + '<FC>id=ORD_QTY              name="수량"         width=65     align=right </FC>'
                    + '<FC>id=CHK_QTY              name="검품수량"     width=65     align=right </FC>'
                    + '<FG>  name ="원가"'
                    + '<FC>id=NEW_COST_PRC         name="단가"         width=80     align=right </FC>'
                    + '<FC>id=NEW_COST_AMT         name="금액"         width=100     align=right </FC>'
                    + '</FG>'
                    + '<FG>  name ="매가"'
                    + '<FC>id=NEW_SALE_PRC         name="단가"         width=80     align=right </FC>'
                    + '<FC>id=NEW_SALE_AMT         name="금액"         width=100     align=right </FC>'
                    + '</FG>'
                    + '<FC>id=NEW_GAP_RATE         name="차익율"       width=65     align=right </FC>';            
                initGridStyle(GR_DETAIL4, "common", hdrProperies, false);
}

//대입
function gridCreate5(){
   var hdrProperies = '<FC>id={currow}            name="NO"          width=30     align=center  sumtext="" </FC>'
                    + '<FC>id=STR_CD               name="점코드"      width=65      align=left show=false</FC>'
                    + '<FC>id=STR_NM               name="점명"        width=65      align=left show=false</FC>'
                    + '<FC>id=SLIP_NO              name="전표번호"     width=95     align=left Mask="XXXX-X-XXXXXXX"</FC>'
                    + '<FC>id=ORD_SEQ_NO           name="전표상세번호" width=65     align=left show=false</FC>'
                    + '<FC>id=PUMMOK_CD            name="품목코드"     width=65     align=left show=false</FC>'
                    + '<FC>id=PUMMOK_NM            name="품목명"       width=65     align=left show=false</FC>'
                    + '<FC>id=SKU_CD               name="단품코드"     width=100     align=left </FC>'
                    + '<FC>id=SKU_NM               name="단품명"       width=130     align=left </FC>'
                    + '<FC>id=STYLE_CD             name="스타일"       width=100     align=center </FC>'
                    + '<FC>id=COLOR_CD             name="칼라"         width=65     align=center </FC>'
                    + '<FC>id=SIZE_CD              name="사이즈"       width=65     align=center </FC>'
                    + '<FC>id=ORD_UNIT_CD          name="단위코드"     width=65     align=left show=false</FC>'
                    + '<FC>id=ORD_UNIT_NM          name="단위명"       width=65     align=left </FC>'
                    + '<FC>id=ORD_QTY              name="수량"         width=65     align=right </FC>'
                    + '<FC>id=CHK_QTY              name="검품수량"     width=65     align=right </FC>'
                    + '<FG>  name ="원가"'
                    + '<FC>id=NEW_COST_PRC         name="단가"         width=80     align=right </FC>'
                    + '<FC>id=NEW_COST_AMT         name="금액"         width=100     align=right </FC>'
                    + '</FG>'
                    + '<FG>  name ="매가"'
                    + '<FC>id=NEW_SALE_PRC         name="단가"         width=80     align=right </FC>'
                    + '<FC>id=NEW_SALE_AMT         name="금액"         width=100     align=right </FC>'
                    + '</FG>'
                    + '<FC>id=NEW_GAP_RATE         name="차익율"       width=65     align=right </FC>';    

    initGridStyle(GR_DETAIL5, "common", hdrProperies, false);
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
 * getDetail1()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-13
 * 개    요 :  디테일  조회(매입,반품,점출입,매가인상하)
 * return값 : void
 */
 function search(){
     
     if(strSkuflag == '1'){             //단품
         if(strSlipFlag == 'A' || strSlipFlag == 'B'){
             document.getElementById("detail1").style.display ="none";
             document.getElementById("detail2").style.display ="";
             document.getElementById("detail3").style.display ="none";
             document.getElementById("detail4").style.display ="none";   
             
             if(strSkuType == '3'){
                 GR_DETAIL2.ColumnProp("STYLE_CD", "show")   = true;
                 GR_DETAIL2.ColumnProp("COLOR_CD", "show")   = true;
                 GR_DETAIL2.ColumnProp("SIZE_CD",  "show")   = true;
             }else{

                 GR_DETAIL2.ColumnProp("STYLE_CD", "show")   = false;
                 GR_DETAIL2.ColumnProp("COLOR_CD", "show")   = false;
                 GR_DETAIL2.ColumnProp("SIZE_CD",  "show")   = false;
             }
             
             getDetail1();
             
         }else if(strSlipFlag == 'C' || strSlipFlag == 'D'){   //대출대입
             document.getElementById("detail1").style.display ="none";
             document.getElementById("detail2").style.display ="none";
             document.getElementById("detail3").style.display ="none";
             document.getElementById("detail4").style.display ="";    

             
             if(strSkuType == '3'){
                 GR_DETAIL4.ColumnProp("STYLE_CD", "show")   = true;
                 GR_DETAIL4.ColumnProp("COLOR_CD", "show")   = true;
                 GR_DETAIL4.ColumnProp("SIZE_CD",  "show")   = true;
                 GR_DETAIL5.ColumnProp("STYLE_CD", "show")   = true;
                 GR_DETAIL5.ColumnProp("COLOR_CD", "show")   = true;
                 GR_DETAIL5.ColumnProp("SIZE_CD",  "show")   = true;
             }else{

                 GR_DETAIL4.ColumnProp("STYLE_CD", "show")   = false;
                 GR_DETAIL4.ColumnProp("COLOR_CD", "show")   = false;
                 GR_DETAIL4.ColumnProp("SIZE_CD",  "show")   = false;
                 GR_DETAIL5.ColumnProp("STYLE_CD", "show")   = true;
                 GR_DETAIL5.ColumnProp("COLOR_CD", "show")   = true;
                 GR_DETAIL5.ColumnProp("SIZE_CD",  "show")   = true;
             }
             
             getDetail2();
             
         }else if(strSlipFlag == 'E' || strSlipFlag == 'F'){   //점출점입
             document.getElementById("detail1").style.display ="none";
             document.getElementById("detail2").style.display ="";
             document.getElementById("detail3").style.display ="none";
             document.getElementById("detail4").style.display ="none"; 
             
             if(strSkuType == '3'){
                 GR_DETAIL2.ColumnProp("STYLE_CD", "show")   = true;
                 GR_DETAIL2.ColumnProp("COLOR_CD", "show")   = true;
                 GR_DETAIL2.ColumnProp("SIZE_CD",  "show")   = true;
             }else{

                 GR_DETAIL2.ColumnProp("STYLE_CD", "show")   = false;
                 GR_DETAIL2.ColumnProp("COLOR_CD", "show")   = false;
                 GR_DETAIL2.ColumnProp("SIZE_CD",  "show")   = false;
             }             
             
             getDetail1();
             
         }else{     //매가인상하
             document.getElementById("detail1").style.display ="none";
             document.getElementById("detail2").style.display ="none";
             document.getElementById("detail3").style.display ="";
             document.getElementById("detail4").style.display ="none"; 
            
             getDetail1();           
         }         
     }else{                             //비단품
         
         document.getElementById("detail1").style.display ="";
         document.getElementById("detail2").style.display ="none";
         document.getElementById("detail3").style.display ="none";
         document.getElementById("detail4").style.display ="none"; 
         getDetail1();
     }	 
 }
 
 /**
  * getDetail1()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-04-13
  * 개    요 :  디테일  조회(매입,반품,점출입,매가인상하)
  * return값 : void
  */
 function getDetail1(){

    var strOrdDt    = strOrdDt;

//    alert(strStrCd);
//    alert(strSlip);
//    alert(strSlipFlag);
  
    var goTo        = "getDetail1";    
    var action      = "O";     
    var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)    
                    + "&strSlip="+encodeURIComponent(strSlipNo)     
                    + "&strSlipFlag="+encodeURIComponent(strSlipFlag);  
    TR_MAIN.Action="/dps/pord121.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL1=DS_DETAIL1)"; //조회는 O
    TR_MAIN.Post();     
 }
 
 

 /**
 * getDetail2()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-13
 * 개    요 :  대출입
 * return값 : void
 */
 function getDetail2(){
    var strSSlipNo  = "";
    var strPSlipNo  = "";
    
    if(strSlipFlag == 'C'){
        strSSlipNo  = strSlipNo;
        strPSlipNo  = strPairSlipNo;
    }else{
        strSSlipNo  = strPairSlipNo;
        strPSlipNo  = strSlipNo;
    }
    
    var goTo       = "getDetail2" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                     + "&strSlipNo="+encodeURIComponent(strSSlipNo)
                     + "&strPSlipNo="+encodeURIComponent(strPSlipNo)
                     + "&strSlipFlag="+encodeURIComponent(strSlipFlag);
    
    TR_MAIN.Action="/dps/pord121.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL2=DS_DETAIL2,"+action+":DS_DETAIL3=DS_DETAIL3)"; //조회는 O
    TR_MAIN.Post();

    var strShowFlag2 = DS_DETAIL2.NameValue(DS_DETAIL2.RowPosition, "SKU_TYPE"); 
    var strShowFlag3 = DS_DETAIL3.NameValue(DS_DETAIL3.RowPosition, "SKU_TYPE");    
    
    if(strShowFlag2 == '3'){
        GR_DETAIL4.ColumnProp("STYLE_CD", "show")   = true;
        GR_DETAIL4.ColumnProp("COLOR_CD", "show")   = true;
        GR_DETAIL4.ColumnProp("SIZE_CD",  "show")   = true;         
        
    }else{
        GR_DETAIL4.ColumnProp("STYLE_CD", "show")   = false;
        GR_DETAIL4.ColumnProp("COLOR_CD", "show")   = false;
        GR_DETAIL4.ColumnProp("SIZE_CD",  "show")   = false;
    }   
    
    if(strShowFlag3 == '3'){
        GR_DETAIL5.ColumnProp("STYLE_CD", "show")   = true;
        GR_DETAIL5.ColumnProp("COLOR_CD", "show")   = true;
        GR_DETAIL5.ColumnProp("SIZE_CD",  "show")   = true;
    }else{
        GR_DETAIL5.ColumnProp("STYLE_CD", "show")   = false;
        GR_DETAIL5.ColumnProp("COLOR_CD", "show")   = false;
        GR_DETAIL5.ColumnProp("SIZE_CD",  "show")   = false;         
    }
 }
 
 
 
/*************************************************************************
 * 3. 함수
*************************************************************************/

/**
 * btn_Close()
 * 작 성 자 : ckj
 * 작 성 일 : 2006.07.12
 * 개    요 : Close
 * return값 : void
 */  
 function btn_Close()
 {
     window.close();
 }
 
 /**
  * btn_Conf()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010.02.21
  * 개    요 : 확인버튼 클릭 처리
  * return값 : void
  **/  
 function btn_Conf()
 {
        doDoubleClick(DS_O_RESULT.RowPosition);
 }    
 
 /**
  * doDoubleClick()
  * 작 성 자 : ckj
  * 작 성 일 : 2006.08.10
  * 개    요 : 더블클릭 처리
  * return값 : void
  **/  
 function doDoubleClick(row)
 {
      if( row == undefined ) 
          row = DS_O_RESULT.RowPosition;
          
      if (row > 0) 
      {
          for(var i=1;i<=DS_O_RESULT.CountColumn;i++)
          {
              returnParam.put(DS_O_RESULT.ColumnID(i), DS_O_RESULT.NameValue(row, DS_O_RESULT.ColumnID(i)));
          }      
          window.returnValue = true;
          window.close();
      }
      return false;  
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <script language=JavaScript for=GR_DETAIL1 event=OnDblClick(row,colid)>
<!--// 그리드 double 클릭이벤트에서 처리 할 내역 추가       
    window.close();
//-->
</script> 
 <script language=JavaScript for=GR_DETAIL2 event=OnDblClick(row,colid)>
<!--// 그리드 double 클릭이벤트에서 처리 할 내역 추가       
    window.close();
//-->
</script> 
 <script language=JavaScript for=GR_DETAIL3 event=OnDblClick(row,colid)>
<!--// 그리드 double 클릭이벤트에서 처리 할 내역 추가       
    window.close();
//-->
</script> 
 <script language=JavaScript for=GR_DETAIL4 event=OnDblClick(row,colid)>
<!--// 그리드 double 클릭이벤트에서 처리 할 내역 추가       
    window.close();
//-->
</script> 
 <script language=JavaScript for=GR_DETAIL5 event=OnDblClick(row,colid)>
<!--// 그리드 double 클릭이벤트에서 처리 할 내역 추가       
    window.close();
//-->
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
<comment id="_NSID_"><object id="DS_I_COND"             classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR"                classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<comment id="_NSID_"><object id="DS_DETAIL1"            classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL2"            classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL3"            classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <object id="TR_MAIN"        classid="<%=Util.CLSID_TRANSACTION%>">
      <param name="KeyName"   value="Toinb_dataid4">
    </object>
</comment>
<script> _ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body  onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <span id="title1" class="PL03">전표별 발주현황 세부사항 조회</span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>                
                </tr>
            </table></td>
          </tr>
        </table>
        </td>
      </tr>
      <tr>
        <td>
        <div id ="detail1">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">        
            <tr>
                <td class="sub_title PB03 PT10"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                    align="absmiddle" /> 품목<span id="FFF" class="sub_title PB03 PT10"></span></td>
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL1
                            width=100% height=400 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL1">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
       </div>
        <div id ="detail2">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">        
            <tr>
                <td class="sub_title PB03 PT10"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                    align="absmiddle" /> 단품<span id="DDD" class="sub_title PB03 PT10"></span></td>
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL2
                            width=100% height=400 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL1">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
       </div>
        <div id ="detail3">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">        
            <tr>
                <td class="sub_title PB03 PT10"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                    align="absmiddle" /> 매가인상하<span id="CCC" class="sub_title PB03 PT10"></span></td>
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL3
                            width=100% height=400 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL1">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
       </div>
        <div id ="detail4">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">        
            <tr>
                <td class="sub_title PB03 PT10"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                    align="absmiddle" /> 대출<span id="BBB" class="sub_title PB03 PT10"></span></td>
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL4
                            width=100% height=195 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL2">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">        
            <tr>
                <td class="sub_title PB03 PT10"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                    align="absmiddle" /> 대입<span id="AAA" class="sub_title PB03 PT10"></span></td>
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL5
                            width=100% height=195 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL3">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
       </div>
        </td>
      </tr>
    </table>
    </td>
     <td class="pop06" ></td>
  </tr>
  <tr>
     <td class="pop07" ></td>
     <td class="pop08" ></td>
     <td class="pop09" ></td>
  </tr>
</table>
</body>
</html>
