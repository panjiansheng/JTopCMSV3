<%@ page contentType="text/html; charset=utf-8" session="false"%>
<%@ taglib uri="/cmsTag" prefix="cms"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<link href="../style/blue/css/main.css" type="text/css" rel="stylesheet" />
		<link href="../style/blue/css/reset-min.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../common/js/jquery-1.7.gzjs"></script>
		<script type="text/javascript" src="../javascript/commonUtil_src.js"></script>
		<script>
		basePath='<cms:BasePath/>';
		
		 var api = frameElement.api, W = api.opener; 
		 
         if("true"==="${param.fromFlow}")
         {     	 	
            //W.$.dialog.tips('添加模型步骤成功...',1); 
            api.close(); 
         	//api.reload( api.get('cwa') );    
       		//W.window.location.reload();       
       		W.window.parent.location="ManageContentClass.jsp?redirect=true&classId=${param.classId}";
         }
         
         var ref_flag=/^(\w){1,25}$/; 
         
         var ref_name = /^[\u0391-\uFFE5\w]{1,50}$/;

         $(function()
		 {
		    validate('className',0,ref_name,'格式为文字,数字,下划线');
 			validate('classFlag',0,ref_flag,'格式为字母,数字,下划线');	
 				
		 })

      	</script>
	</head>
	<body>

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="left" valign="top">
					<!--main start-->
					<div class="addtit">
						<img src="../style/icons/validation-valid-document.png" width="16" height="16" />采集扩展
					</div>

					<form id="classForm" name="classForm" method="post">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form-table">
							<tr>
									<td class="input-title">
										<strong>规则名称</strong>
									</td>
									<td class="td-input">
										<input type="text" size="36" id="className" name="className" class="form-input" value="${Class.className}" />
										<span class="red">*</span><span class="ps"></span>
									</td>
								</tr>
							<tr>
								<td width="29%" class="input-title">
									<strong>目标模型</strong>
								</td>
								<td class="td-input">
									<select class="form-select" id="parent" name="parent" >
										<option value="-9999">
											----------- 请选择目标模型 -----------
										</option>
										 
									</select>
								</td>
							</tr>
							 <tr>
									<td width="29%" class="input-title">
										<strong>采集字段</strong>
									</td>
									<td class="td-input">
										<select class="form-select" id="parent" name="parent"  >
											<option value="-9999">
												----------- 请选需采集字段 -----------
											</option>
											 
										</select>
									</td>
								</tr>
								
								 
						</table>
						
						<!-- hidden -->
						 		
						<cms:Token mode="html"/>
						
					</form>
					<div style="height:15px"></div>
					<div class="breadnavTab"  >
						<table width="100%" border="0" cellspacing="0" cellpadding="0" >
							<tr class="btnbg100">
								<div style="float:right">
									<a id="submitSpecClassFormBut" href="javascript:submitContentClassForm();"  class="btnwithico"><img src="../style/icons/tick.png" width="16" height="16" id="submitSpecClassFormImg" /><b>确认&nbsp;</b> </a>
									<a href="javascript:close();"  class="btnwithico" onclick=""><img src="../style/icon/close.png" width="16" height="16"><b>取消&nbsp;</b> </a>
								</div>
								 
							</tr>
						</table>
					</div>
				</td>
			</tr>

		</table>
		<!--[if lt IE 7]>
        <script type="text/javascript" src="js/unitpngfix.js"></script>
<![endif]-->
	</body>
</html>
<script>  
initSelect('parent','${Class.parent}');
   
var api = frameElement.api, W = api.opener;
  
function close()
{
	api.close();
}

function submitContentClassForm()
{	
	var hasError = false;
	//系统信息字段验证
    var currError = submitValidate('classFlag',0,ref_flag,'格式为字母,数字,下划线');	
        
        if(currError)
        {
        	hasError = true;
        }
        
    currError = submitValidate('className',0,ref_name,'格式为文字,数字,下划线');

   		if(currError)
        {
        	hasError = true;
        }
    
    
    			
    if(hasError)
    {
    	$("#submitFormBut").removeAttr("disabled"); 
	    $("#submitFormImg").removeAttr("disabled"); 
	    
	    return;

	}
	
	//后台验证
	
	if('${Class.classFlag}' != $('#classFlag').val())
	{
		var count = validateExistFlag('contentClass', $('#classFlag').val());
		
		if(count > 0)
		{
			showTips('classFlag', '系统已存在此值，不可重复录入');
			
			return;
		}
	}
	
	$("#submitSpecClassFormBut").attr("disabled","disabled"); 
	$("#submitSpecClassFormImg").attr("disabled","disabled"); 
	
	var url = "<cms:BasePath/>channel/editSpecClass.do"+"?<cms:Token mode='param'/>";
 	var postData = encodeURI($("#classForm").serialize());
 					
	$.ajax({
  		type: "POST",
   		url: url,
   		data: postData,
   
       	success: function(mg)
        {      
        	var msg = eval("("+mg+")");
        	
           if('success' == msg)
           {
           		W.$.dialog({ 
	   					title :'提示',
	    				width: '150px', 
	    				height: '60px', 
	    				parent:api,
	                    lock: true, 
	    				icon: '32X32/succ.png',
	                    content: '修改专题分类成功！', 
	                    ok: function(){ 
      						W.window.location.reload();
    					} 
		  		});
           		
           } 	
           else
           {
           	   							W.$.dialog(
									    { 
									   					title :'提示',
									    				width: '200px', 
									    				height: '60px', 
									                    lock: true, 
									                    parent:api,
									                     
									    				icon: '32X32/fail.png', 
									    				
									                    content: "执行失败，无权限请联系管理员！",
							
									    				cancel: true
										});
										
										$("#submitSpecClassFormBut").removeAttr("disabled"); 
										$("#submitSpecClassFormImg").removeAttr("disabled");
           }   
        }
 	});
}

</script>
 
