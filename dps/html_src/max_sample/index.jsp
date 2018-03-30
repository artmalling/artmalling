<HTML>
<HEAD>
<TITLE>ActiveUpdate</TITLE>

<script language=JavaScript for=ManagerEx event=OnUpdateCompleted()>
		location.href = "./view.html"; 
</script>

<script language=JavaScript for=ManagerEx event=OnUpdateError(ErrorCode,ErrMsg)>
	if(ErrorCode=="2010"){
		// 에러 발생시 처리
	}else{
		alert("OnUpdateError\nError Code: "+ErrorCode+"\nError Message : "+ErrMsg);
	}
</script>

</HEAD>
<BODY>

<OBJECT ID="ManagerEx" CLASSID="CLSID:92928D91-53D8-4861-835C-619E5082D3D7" codebase="./cabfiles/ManagerEx.cab#version=3,0,0,10">
	<param name="XMLUrl" value="./cabfiles/install.xml">
	<param name="SaveXML" value="true">
	<!--<Param Name="TrustZone"          value="http://www.gauce.com">-->
</OBJECT>
</BODY>
</HTML>