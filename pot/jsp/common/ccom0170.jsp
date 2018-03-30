<!-- 
/*******************************************************************************
 * 시스템명 : F&B매장코드 조회  팝업
 * 작 성 일 : 2010.02.17
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : ccom0170.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : F&B매장(대표매장)코드 조회 팝업
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
<title>F&B매장 -POPUP</title>
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
 var fnbShopCd      = dialogArguments[1];
 var fnbShopNm      = dialogArguments[2];
 var multiGb        = dialogArguments[3];
 var addCondition   = dialogArguments[4];

/**
 * doInit()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-16
 * 개    요 : initialize
 * return값 : void
**/
function doInit() 
{     	
    //그리드 초기화
    gridCreate1();
            
    // EMedit 초기화
    initEmEdit(EM_FNB_SHOP_CD, "CODE^4^0", NORMAL);
    initEmEdit(EM_FNB_SHOP_NAME, "GEN^20", NORMAL);

    // Input Data Set Header 초기화 
    DS_I_COND.setDataHeader  ('FNB_SHOP_CD:STRING(4),FNB_SHOP_NAME:STRING(20),ADD_CONDITION:STRING(200)');
    DS_I_COND.ClearData();
    DS_I_COND.Addrow();

    DS_I_COND.NameValue(DS_I_COND.RowPosition, "FNB_SHOP_CD") = fnbShopCd; 
    DS_I_COND.NameValue(DS_I_COND.RowPosition, "FNB_SHOP_NAME") = fnbShopNm; 
    DS_I_COND.NameValue(DS_I_COND.RowPosition, "ADD_CONDITION") = addCondition;

    EM_FNB_SHOP_CD.Focus();
    if(fnbShopCd.length > 0 || fnbShopNm.length > 0   ){
        btn_Search();
    }
} 

function gridCreate1(){
    var hdrProperies = '<FC>ID="FNB_SHOP_CD"     name="매장코드"       width=100,   edit=none,   align=center</FC>'
                     + '<FC>ID="FNB_SHOP_NAME"   name="매장명"         width=180,  edit=none,   align=left  </FC>'
                     + '<FC>ID="VEN_CD"          name="협력사코드"       width=110,   edit=none,   align=left,  show=false  </FC>';
    if( multiGb == "M"){
        hdrProperies = '<FC>ID="SEL"             name="선택"     width=30,   align=center, EditStyle="CheckBox"</FC>'
                     + '<FC>ID="FNB_SHOP_CD"     name="매장코드"       width=100,   edit=none,   align=center</FC>'
                     + '<FC>ID="FNB_SHOP_NAME"   name="매장명"         width=180,  edit=none,   align=left  </FC>'
                     + '<FC>ID="VEN_CD"          name="협력사코드"       width=110,   edit=none,   align=left,  show=false  </FC>';
    }
    initGridStyle(GD_SEARCH, "common", hdrProperies, true);
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
  * 작 성 자 : 
  * 작 성 일 : 2010-01-25
  * 개    요  : 점별 행사 코드 조회
  * return값 : void
  */
  function btn_Search() 
  { 
	  DS_I_COND.UserStatus(1) = "1";      
      TR_MAIN.Action="/pot/ccom017.cc?goTo=searchOnPop";
      TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_COND,O:DS_O_RESULT=DS_O_RESULT)";
      TR_MAIN.Post();  
      
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
     * 작 성 자 : 정진영
     * 작 성 일 : 2010.02.21
     * 개    요 : 확인버튼 클릭 처리
     * return값 : void
     **/  
    function btn_Conf()
    {

        if( multiGb == "M"){
            var idx = 0;
            for( var i = 1; i<=DS_O_RESULT.CountRow; i++){
                if( DS_O_RESULT.NameValue(i,"SEL") == "T"){
                    var objJson = "[{";
                    for(var j=1;j<=DS_O_RESULT.CountColumn;j++)
                    {
                        if(j>1) objJson +=  ",";
                        objJson += "'"+DS_O_RESULT.ColumnID(j)+"':'"+DS_O_RESULT.NameValue( i, DS_O_RESULT.ColumnID(j))+"'";
                    }
                    objJson += "}]"; 
                    returnParam[idx++] = eval(objJson)[0];  
                }
            }
            window.returnValue = true;
            window.close();      
        }else {
            doDoubleClick(DS_O_RESULT.RowPosition);
        }
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

            if( multiGb == "M"){
                var objJson = "[{";
                for(var j=1;j<=DS_O_RESULT.CountColumn;j++)
                {
                    if(j>1) objJson +=  ",";
                    objJson += "'"+DS_O_RESULT.ColumnID(j)+"':'"+DS_O_RESULT.NameValue(row, DS_O_RESULT.ColumnID(j))+"'";
                }
                objJson += "}]"; 
                returnParam[0] = eval(objJson)[0];
            }else{
                for(var i=1;i<=DS_O_RESULT.CountColumn;i++)
                {
                    returnParam.put(DS_O_RESULT.ColumnID(i), DS_O_RESULT.NameValue(row, DS_O_RESULT.ColumnID(i)));
                }
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
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <script language=JavaScript for=GD_SEARCH event=OnDblClick(row,colid)>
<!--// 그리드 double 클릭이벤트에서 처리 할 내역 추가        
    doDoubleClick(row);    
//-->
</script> 
<script language=JavaScript for=GD_SEARCH event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<comment id="_NSID_"><object id=DS_I_COND classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id=DS_O_RESULT classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <span id="title1" class="PL03">F&B매장</span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/<%=dir%>/imgs/btn/search.gif" width="50" height="22"  onClick="btn_Search();"/></td>
                <td><img src="/<%=dir%>/imgs/btn/confirm.gif" width="50" height="22" onClick="btn_Conf()"/></td>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
                
                </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="popT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="60">매장코드</th>
                <td width="66">
                <comment id="_NSID_">
                    <object id=EM_FNB_SHOP_CD classid=<%=Util.CLSID_EMEDIT%> height=20 width=65 onKeyDown="if(event.keyCode == 13) btn_Search();" >
                    </object>
                </comment><script>_ws_(_NSID_);</script>
              </tr>
              <tr>
                </td>
                <th width="50">매장명</th>
                <td>
                <comment id="_NSID_">
                    <object id=EM_FNB_SHOP_NAME classid=<%=Util.CLSID_EMEDIT%> height=20 width=245 onKeyDown="if(event.keyCode == 13) btn_Search();" >
                    </object>
                </comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="g_table">      
        <tr>
        <td>
            <!-- 마스터 -->
            <comment id="_NSID_"><object id=GD_SEARCH height="275px" width="100%" classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_RESULT">
            </object></comment><script>_ws_(_NSID_);</script>
            </td>
            </tr>
        </table></td>
      </tr>
    </table></td>
     <td class="pop06" ></td>
  </tr>
  <tr>
     <td class="pop07" ></td>
     <td class="pop08" ></td>
     <td class="pop09" ></td>
  </tr>
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

<comment id="_NSID_">
<object id=BO_SEARCH classid=<%= Util.CLSID_BIND %>>
        <param name=DataID          value=DS_I_COND>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>col=FNB_SHOP_CD                ctrl=EM_FNB_SHOP_CD               param=Text</c>
            <c>col=FNB_SHOP_NAME              ctrl=EM_FNB_SHOP_NAME             param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
