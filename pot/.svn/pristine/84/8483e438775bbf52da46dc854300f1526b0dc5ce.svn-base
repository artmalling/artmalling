<%@ page contentType="text/html;charset=utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<html>
<head>
<title>리스트 조회 및 리스트 입력/수정/삭제 처리</title>
<link href="/pot/css/mds.css" rel="stylesheet" type="text/css">

<script language="javascript"  src="/pot/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/pot/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/pot/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/pot/js/gauce.js" type="text/javascript"></script>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
<!--
body {
    margin-top: 0px;
    margin-left: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
}
-->
</style>
<script language="javascript">
<!--// 공통버튼 처리부분 시작

   /**
    * btn_Search()
    * 작 성 자 : 류태영
    * 작 성 일 : 2004.11.22
    * 개    요 : 조회 처리
    * return값 : void
    */  
    function btn_PopSearch(){
        /*if (updateCheck(ds_master)) return; 업데이트가 된 내역이 있는지 판단하여 진행여부를 물어보는 모달 윈도우를 띄움*/
        /*tr_view.Action = "/mcod/mcod001.do?work=exec";
        tr_view.parameters = "act=select_main,condition=" + condition.value;
        tr_view.KeyValue = "JSP(O:DATA=ds_master)";
        setTimeout("tr_view.post();", 0);*/
    }
    

   /**
    * btn_popClose()
    * 작 성 자 : 류태영
    * 작 성 일 : 2004.11.22
    * 개    요 : 화면 닫음
    * return값 : void
    */
    function btn_popClose(){
        //ds_master.AddRow();
    }
//-->
</script>

<script language="javascript"  for=ds_master event=OnLoadStarted()>
<!--// 데이터셋 로딩을 시작하는 시점에서 발생하는 이벤트 시작 
    searchStart(master_grid);
//-->
</script>

<script language="javascript"  for=ds_master event=OnLoadCompleted(rowcount)>
<!-- //데이터셋의 로딩이 완료되었을때 발생하는 이벤트 시작
    searchEnd(master_grid, rowcount);
//-->
</script>

<script language=JavaScript for=ds_master event=OnLoadError()>
<!--// 데이터셋의 결과 내역중 오류가 생겼을때 발생하는 이벤트 시작
    searchEnd(master_grid, 0);
    showMessage("MCOM-1004", ds_master);
//-->
</script>

<script language=JavaScript for=ds_master event=OnRowPosChanged(row)>
<!--// Row의 Focus가 변경되었을때 변경된 row값으로 발생하는 이벤트 시작
    ON_EDIT(row);
//-->
</script>

<script language=JavaScript for=ds_master event=OnColumnChanged(row,colid)>
<!--//  Cell의 Data가 변경이 되면서 Focus가 이동될때만 발생한다.(OrgNameValue() == NameValue() 일 경우에는 발생하지 않는다.)
    ON_EDIT(row);
    master_grid.SetColumn(colid);
    
    /** 
      *컬럼이 변경되었을 경우에 로직을 추가한다.
      */
//-->
</script>

<script language=JavaScript for=tr_master event=OnFail()>
<!--// TR 컴포넌트를 사용하여 C/R/U/D 처리도중 오류를 발생했을때의 이벤트 시작
    showMessage("MCOM-1001", tr_master, 'Native');
//-->
</script>

<script language=JavaScript for=tr_master event=OnSuccess()>
<!--// TR 컴포넌트를 사용하여 C/R/U/D 처리도중 성공했을때의 이벤트 시작
    showMessage("MCOM-1003", tr_master, 'Native');
//-->   
</script>
<!-- Grid 전체 조회시에는 사용하지 말고 코드에 대한 상세내역을 갖어올때만 사용할 것 -->
<OBJECT id="ds_search" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
    <param name="ViewDeletedRow"  value="True">  <!-- Delete된 Row를 화면에서 감추는 여부 옵션 -->
<OBJECT>
<!-- Grid 전체 조회시에는 사용하지 말고 코드에 대한 상세내역을 갖어올때만 사용할 것 -->

<OBJECT id="tr_view" classid="clsid:78E24950-4295-43d8-9B1A-1F41CD7130E5">
</OBJECT>
</head>
<body onLoad="initWriteGrid(master_grid); doInit();">


<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="td_L5">
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
            <!-- BODY타이틀 -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="12"><img src="../../imgs/background/blank.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="30">
                    <script language="javascript"> createPopButton("테스트 팝업"); </script>
                 </td>
              </tr>
            </table>
          </td>
        </tr>   
      </table>
    </td>
  </tr>
</table>
<!-- 조회조건 및 입력 부분이 들어가는 테이블 -->
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr> 
    <td class="td_L5">
     <table width="100%" border="0" cellspacing="0" cellpadding="0">        
        <tr> 
          <td> 
            <!-- 조회조건 -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="search_tdcolor1">
                 <table width="100%" border="0" cellspacing="2" cellpadding="0">
                    <tr> 
                      <td bgcolor="#99BAD1" class="search_tdcolor2">
                       <table width="100%" border="0" cellspacing="1" cellpadding="0">
                          <tr> 
                            <td bgcolor="#DBEAF3" class="t_search_B" width=70px>코드</td>
                            <td bgcolor="#FFFFFF" class="td_L5" >
                                <input type="text" size="10" maxlength="10" class="input_2" id="searchCode">
                            <td bgcolor="#DBEAF3" class="t_search_B" width=70px>코드명</td>
                            <td bgcolor="#FFFFFF" class="td_L5" >
                                <input type="text" size="20" maxlength="20" class="input_2" id="searchName">
                            <!--<td bgcolor="#DBEAF3" class="t_search_B"></td>
                            <td bgcolor="#FFFFFF" class="td_L5"></td>
                            <td bgcolor="#DBEAF3" class="t_search_B"></td>
                            <td bgcolor="#FFFFFF" class="td_L5" ></td>-->
                          </tr>
                        </table>
                        </td>
                    </tr>
                  </table>
                  </td>
              </tr>
            </table>
            <!-- 조회조건 -->
          </td>
         </tr>
         <tr> 
           <td height="2"><img src="./imgs/background/blank.gif" width="1" height="1"></td>
         </tr>
        <tr> 
          <td> 
            <!--조회결과-->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#848484">
                 <table width="100%" border="0" cellspacing="2" cellpadding="0">
                    <tr> 
                      <td bgcolor="#E7E7E7">
                       <table width="100%" border="0" cellspacing="1" cellpadding="0">
                          <tr> 
                            <td bgcolor="#E7E7E7">
                              <table width="100%" border="0" cellspacing="1" cellpadding="0">
                                <tr bgcolor="#919191"> 
                                  <td height="18" align="center">
                                      <object id="master_grid" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width="100%" height="500px">
                                            <PARAM NAME="DataID"       VALUE="ds_search">
                                            <PARAM name="Format",      VALUE='
                                                <FC>id="CSPOSTNO",     name="우편번호",  width=70 , sort=true,  HeadBgColor="#919191",  HeadColor="#FFFFFF",  BgColor={decode(currow-tointeger(currow/2)*2,0,"#F1F1F1",1,"#FFFFFF")} </FC>
                                                <C> id="CSPOSTCITY",   name="시/도   ",  width=100, sort=true,  HeadBgColor="#919191",  HeadColor="#FFFFFF",  BgColor={decode(currow-tointeger(currow/2)*2,0,"#F1F1F1",1,"#FFFFFF")} </C>
                                                <C> id="CSPOSTGU",     name="구/군/읍",  width=100, sort=true,  HeadBgColor="#919191",  HeadColor="#FFFFFF",  BgColor={decode(currow-tointeger(currow/2)*2,0,"#F1F1F1",1,"#FFFFFF")} </C>
                                                <C> id="CSPOSTDONG",   name="동/면   ",  width=200, sort=true,  HeadBgColor="#919191",  HeadColor="#FFFFFF",  BgColor={decode(currow-tointeger(currow/2)*2,0,"#F1F1F1",1,"#FFFFFF")} </C>
                                            '>
                                      </object>
                                    </td>
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
            <!--조회결과-->
          </td>
        </tr>        
      </table>
    </td>
  </tr>
</table>       
</body>
</html>

