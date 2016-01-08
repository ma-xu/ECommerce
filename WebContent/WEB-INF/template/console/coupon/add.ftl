<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.coupon.add")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/jquery.lSelect.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/console/editor/kindeditor.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/input.js"></script>
<link href="${base}/resources/console/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/console/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript" src = "${base}/resources/console/js/ligerUI/js/ligerui.all.js"></script>
<link rel="stylesheet" href="${base}/resources/console/css/ligerUI/css/ligerui-all.css" />
<style type="text/css">
.roles label {
	width: 150px;
	display: block;
	float: left;
	padding-right: 6px;
}
table th {
  width: 150px;
  line-height: 25px;
  padding: 5px 10px 5px 0px;
  font-weight: normal;
  white-space: nowrap;
}
.itemList-upload{
	left:650px;
	top:45px;
	width:111px;
	padding:8px;
	border-radius:2px;
	border:1px solid #D6D6D6;
}
.newsPreview{
	width:93px;
	height:93px;
}
.imgShowBox{
	position:relative;
}
</style>
<script type="text/javascript">
var countMember=0;
$().ready(function() {

	var $inputForm = $("#inputForm");
	
	[@flash_message /]
	
	var selectImageNum = 0;//全局变量
	var $school_id = $("#school_id");
	var $allSchools = $("#allSchools");
	var $selectAllSchool = $("#selectAllSchool");
	
	//ligerui初始化学校选择按钮
	$school_id.ligerComboBox({
		data: [
                { text: '请选择学校', id: 'default' }
              ],
		onBeforeOpen: _selectSchool, 
		valueFieldID: 'school_id', 
		width:100,
		height:20,
		value:"default",
		cancelable: false
	});
	
	//选择所有学校
	$selectAllSchool.click(function(){
		var $this = $(this);
		if ($this.prop("checked")){
			$allSchools.val("allSchools");
			$school_id.attr("disabled","disabled");
			$(".l-text-wrapper").hide();
			
		}
		else{
			$allSchools.val("");
			$school_id.removeAttr("disabled");
			$(".l-text-wrapper").show()
		}
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			name: {
				required: true,
				maxlength:50
			},
			point: {
				digits:true,
				maxlength:20
			},
			circulation: {
			    digits:true,
			    min:0,
			    maxlength:20
			},
			limited:{
			     digits:true,
			     min:0,
			     maxlength:20
			},
			priceExpression:{
				maxlength:50
			},
			converNum:{
				required: true
			},
			introduction:{
				maxlength:300
			},
			promotionTemplateId:{
		    	required: true
			},
			action:{
				required: true,
				maxlength:20
			},
			beginDate:{
				required: true
			},
			endDate:{
				required: true
			},
		},
		messages: {
		},
		submitHandler: function(form) {
			    var submitOK=true;
				var schoolIds =  new Array();
			    $("#listTable input[name='schoolIds']").each(function(){
				 	  schoolIds.push($(this).val());
				   });
				if($("#isEnabled").prop("checked")){
					$.ajax({
						url: "checkLimitedCount.ct",
						type: "GET",
						data:  {
						  schoolIds:schoolIds,
						},
						dataType: "json",
						traditional: true,
						cache: false,
						async: false,
						success: function(couponName) {
							if(couponName !=""){
							    submitOK=false;
								$.message("warn","学校  "+couponName+"  优惠劵数量已经达到上限，请删除!");
							}else{
							    form.submit();
							}
						}
				    })
			   }else{
			   		form.submit();
			   }
			 }
	  });
	
	//添加规则
	$("#addMemberBtn").click(function(){
	  countMember++;
	  var memberListHTML = '<tr>'
								+'<th>${message("规则")}：</th>'
								+'<td>'
								   +'<input type="text"  class="form-control" name="content" maxlength="200"/>'
								+'</td>'
						   +'</tr>';     
       $("#addStuMember").append(memberListHTML);
       changeNavHeight();
	});
	
	<!--start上传图片插件 -->
 	var $smallIconfileImageUpload = $("#smallIconfileImageUpload");
	var $smallIconfilePreview = $("#smallIconfilePreview");
	var $delSmallIconfileImg = $("#delSmallIconfileImg");
	var $smallIconfile = $("#smallIconfile");
    $smallIconfileImageUpload.uploadify({  
        'successTimeout' : 50000,
        'height'        : 27,   
        'width'         : 80,    
        'buttonText'    : '浏览',  
        'swf'           : '${base}/resources/console/uploadify/uploadify.swf',  
        'uploader'      : '${base}/console/file/upload.ct?fileType=image',  
        'auto'          : true,
        'multi'          : true, //是否支持多文件上传  
	    'simUploadLimit' : 1, //一次同步上传的文件数目     
	    'sizeLimit'      : 19871202, //设置单个文件大小限制     
	    'queueSizeLimit' : 1, //队列中同时存在的文件个数限制
	    'fileObjName'    :  'file',
	    'fileTypeDesc'  :  '*.jpg;*.jpeg;*.png',//图片选择描述  
        'fileTypeExts'  :  '*.jpg;*.png',//允许的格式      
        'formData'      :  {
        		'token' : getCookie("token"),
        		'imageWidth':'640',
        		'imageHeight':'320'
         },
        'fileSizeLimit' :'50k',
          //上传成功  
        'onUploadSuccess' : function(file, data, response) {  
            var dataJson = JSON.parse(data);
            var contentImgFileUrl = dataJson['url'];
            var messageContent = dataJson['message']['content'];
            var messageType = dataJson['message']['type'];
            var sizeErrorMessageType = dataJson['sizeErrorMessage']['type'];//图片文件上传尺寸返回信息类型
            var sizeErrorMessageContent = dataJson['sizeErrorMessage']['content'];//图片文件上传尺寸返回信息内容
            if(messageType == 'success'){
            	if(sizeErrorMessageType == 'success'){
            		 $smallIconfilePreview.attr("src",contentImgFileUrl);
	                 $smallIconfile.val(contentImgFileUrl);
	                 $delSmallIconfileImg.css('display','inline'); 
	                 selectImageNum++; 
	                 $("#converNum").val(selectImageNum);
            	}
            	else{
            		$.message("warn", sizeErrorMessageContent);
            	}
            }else{
                $.message("warn", messageContent);
            }
        },
	    onComplete: function (event, queueID, fileObj, response, data) {
	           
	    },  
	    onError: function(event, queueID, fileObj) {     
	        alert("文件:" + fileObj.name + "上传失败");     
	    },
	    onSelect: function(file){
	        //alert("文件:" + file.name);
	    }
    });
	<!--end上传应用图标插件 -->
	
	<!-- start删除图片插件-->
	// 删除封面图片
	$delSmallIconfileImg.on("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "${message("admin.dialog.deleteConfirm")}",
			onOk: function() {
			    $smallIconfilePreview.attr("src","${base}/resources/console/images/newsUpload.png");
	            $smallIconfile.val("");
	            $delSmallIconfileImg.css('display','none'); 
	            selectImageNum--; 
	              $("#converNum").val(selectImageNum);
		            if(selectImageNum == 0){
		            	$("#converNum").val("");
		            }
			}
		});
	});
	<!-- end  删除图片插件-->
	
});

//选择学校
	function _selectSchool()
	{
		var dictSchoolIds = $("#dictSchoolIds").val();
		if($("#supselect").val()==="0")
		{
		    $.ligerDialog.warn('${message("请选择学校")}');
			return;
		}
	    $.ligerDialog.open({ title: '${message("选择学校")}', name:'selectSchool',width: 700, height:480, url: '${base}/console/app/schoolList.ct?dictSchoolIds='+dictSchoolIds, buttons: [
			{ text: '${message("确定")}', onclick: _selectSchoolOK },
			{ text: '${message("取消")}', onclick: _selectSchoolCancel }
		]
		});
		return false;
	}
	
	//弹出dialog确定按钮
	function _selectSchoolOK(item, dialog)
	{
		var data= document.getElementById('selectSchool').contentWindow._select();
		if (!data || data.length < 1)
		{
			$.ligerDialog.warn('${message("请选择学校")}');
			return;
		}
		var trs = "";
		for(var i = 0; i < data.length; i++)
		{
			var school = data[i];
		    trs += '<tr class="schoolTr" id="schoolTr_'+school.id+'">'+
			                '<input type="hidden" class="schoolId" name="schoolIds" value="'+school.id+'">'+
			                '<td>'+
			                	school.code+
		                	'</td>'+
			                '<td>'+
			                	school.name+
		                	'</td>'+
		                	'<td style="vertical-align: middle;"><a href="javascript:void(0);" onclick="deleteTr(this)">[${message("删除")}]</a>'+
							'</td>'+
			        '</tr>';
		}
		$("#listTbody").html("");
		$("#listTbody").append(trs);
		dialog.close();
	}
	
	//弹出dialog取消按钮
	function _selectSchoolCancel(item, dialog)
	{
		dialog.close();
	}
	
	
	function contains(a, obj){
	  for(var i = 0; i < a.length; i++) {
	    if(a[i] === obj){
	      return true;
	    }
	  }
	  return false;
	}
	
	//删除选择行
	function deleteTr(obj){
		var id = obj.parentElement.parentElement.children[0].value;
		$("#schoolTr_"+id).remove();
	}

</script>
</head>
<body>
<div id="wrapper">
	  <!-- start  导航 -->
       [#include "/console/include/nav.ftl" /]
       <!-- end 导航-->
	
	   <div id="page-wrapper" class="gray-bg dashbard-1">
		   <!-- start 头部 -->
	       [#include "/console/include/header.ftl" /]
	       <!-- end 头部-->
	       
	       <!-- start 头部面包屑区域 -->
	       <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-10">
                    <h2> ${message("console.coupon.add")}</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                            <strong>${message("console.coupon.add")}</strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">

                </div>
            </div>
	       <!-- end 头部面包屑区域 -->
	       
            <!-- start 中间内容部分 -->
	        <div class="row border-bottom white-bg-bak dashboard-header mainContent">
	            <div class="panel blank-panel">
                            <div class="panel-heading">
                                <div class="panel-options">
                                    <ul class="nav nav-tabs">
                                        <li class="active">
                                            <a data-toggle="tab" onclick="changeNavHeight()"  href="edit.ct#settingBaseTab">
                                                ${message("console.coupon.info")}
                                            </a>
                                        </li>
                                        <li class="">
                                            <a data-toggle="tab" onclick="changeNavHeight()" href="tabs_panels.html#settingRegisterSecurityTab">
                                                ${message("console.coupon.couponRules")}
                                            </a>
                                        </li>
                                         <li class="">
                                            <a data-toggle="tab" onclick="changeNavHeight()" href="tabs_panels.html#authorizationTab">
                                                ${message("学校授权")}
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <form id="inputForm" action="save.ct" method="post" enctype="multipart/form-data">
                            <div class="panel-body">
                                <div class="tab-content">
                                    <div id="settingBaseTab" class="tab-pane active">
                                        <table class="table table-striped">
											<tr>
												<th>
													<span class="requiredField">*</span>${message("Coupon.name")}:
												</th>
												<td>
													<input type="text" name="name" class="form-control"/>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("Coupon.PromotionTemplate")}:
												</th>
												<td>
													<select name="promotionTemplateId" class="form-control m-b">
														 <option value="">${message("console.common.select")}</option>
														 [#list promotionTemplate as promotionTemplate]
															<option value="${promotionTemplate.id}" >
																${promotionTemplate.name}
															</option>
														 [/#list]
													</select>
												</td>
											</tr>
											<tr>
												<th>
													${message("介绍")}:
												</th>
												<td>
													<textarea name="introduction" class="form-control" style="height: 80px;"></textarea>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("方法名")}:
												</th>
												<td>
													<input type="text" name="action" class="form-control"/>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("Coupon.couponConver")}:
												</th>
												<td>
													<input type="hidden" id="converNum" name="converNum" value=""/>
													<div class="itemList-upload">
														<div class="imgShowBox">
															<img src="${base}/resources/console/images/newsUploadt.png" alt="上传海报" id="smallIconfilePreview" class="newsPreview" >
															<a href="javascript:;" title="删除图片" class="delImg" id="delSmallIconfileImg">×</a>
														</div>
														<div class="uploadContainer" style="margin-left: 7px;">
															<input type="file" id="smallIconfileImageUpload" />
															<input type="hidden" id="smallIconfile" name="couponConver" value="0">
														</div>
													</div>
													<div style="font-weight: inherit;padding-top: 7px;">${message("console.coupon.conver")}</div>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("Coupon.beginDate")}:
												</th>
												<td>
													 <div class="col-sm-8" style="padding-left:0px">
			                                			<input id="beginDate" name="beginDate" class="laydate-icon form-control layer-date">
			                           				 </div>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("Coupon.endDate")}:
												</th>
												<td>
													 <div class="col-sm-8" style="padding-left:0px">
			                                			<input id="endDate" name="endDate" class="laydate-icon form-control layer-date">
			                           				 </div>
												</td>
											</tr>
											<tr>
												<th>
													${message("Coupon.priceExpression")}:
												</th>
												<td>
			                                		<input type="text" name="priceExpression" class="form-control"/>
												</td>
											</tr>
											<tr>
												<th>
													${message("Coupon.couponPrice")}:
												</th>
												<td>
			                                		<input type="text" name="couponPrice" class="form-control"/>
												</td>
											</tr>
											<tr>
												<th>
													${message("Coupon.addPoint")}:
												</th>
												<td>
			                                		<input type="text" name="point" class="form-control">
												</td>
											</tr>
											<tr>
												<th>
													</span>${message("Coupon.circulation")}:
												</th>
												<td>
			                                		<input type="text" name="circulation" class="form-control">
												</td>
											</tr>
											<tr>
												<th>
													${message("Coupon.limited")}:
												</th>
												<td>
			                                		<input type="text" name="limited" class="form-control">
												</td>
											</tr>
											<tr>
												<th>
													${message("Coupon.setUp")}:
												</th>
												<td>
													<input type="checkbox" name="isEnabled" id="isEnabled"/>
													<lable for="isEnabled">${message("Coupon.isEnabled")}</lable>
													<input type="checkbox" name="isExchange" style="margin-left:38px;"/>
													<lable for="isExchange">${message("Coupon.isExchange")}</lable>
												</td>
											</tr>
										</table>
                                    </div>
                                    <div id="settingRegisterSecurityTab" class="tab-pane">
                                        <table class="table table-striped">
											<tr>
												<th>
													${message("添加活动规则")}:
												</th>
												<td>
													<a href="javascript:void(0);" id="addMemberBtn" class="btn btn-primary">
														<span class="addIcon">&nbsp;</span>添加规则
													</a>
													<span>${message("允许输入最大字符长度为200！")}</span>
												</td>
											</tr>
											<table class="table table-striped" id="addStuMember">
											</table>
										</table>
										</table>
                                    </div>
                                     <div id="authorizationTab" class="tab-pane">
                                        <table class="table table-striped">
											<tr>
												<th>
													${message("应用授权学校")}:
												</th>
												<td>
													<div class="col-sm-9" style="width: 120px;">
														<label class="radio-inline">
							                                <input type="checkbox" class="checkbox checkbox-inline" id="selectAllSchool" />
							                                <input type="hidden" id="allSchools" name="allSchools" value=""/>
							                                是否全选
						                                </label>
					                                </div>
					                                <div style="float: left;">
														<input type='text' id="school_id" name="school_id" value='${message("请选择学校")}' style="font-size:12px;height:20px;"/>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													已选择学校:
												</th>
												<td>
													<table class="table table-striped" id="listTable">
														<thead>
															<input type="hidden"  id="dictSchoolIds"/>
															 <tr>
																<th>
																	${message("学校编号")}:
																</th>
																<th>
																	${message("学校名称")}:
																</th>
																<th>
																	<span>${message("console.common.handle")}</span>
																</th>
															</tr>
														</thead>
														<tbody id="listTbody">
														[#list dictschools as dictschool]
														<tr class="schoolTr">
			                								<input type="hidden" class="schoolId" name="schoolIds">
											                <td>
											                	${dictschool.code}
										                	</td>
											                <td>
											                	${dictschool.name}
										                	</td>
										                	<td style="vertical-align: middle;"><a href="javascript:void(0);" onclick="deleteTr(this)">[${message("删除")}]</a>
															</td>
														</tr>
														[/#list]
														</tbody>
													</table>
												</td>
											</tr>
										</table>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-4 col-sm-offset-2">
                                        <input type="submit" class="btn btn-primary" value="${message("console.common.submit")}" />
										<input type="button" class="btn btn-white" value="${message("console.common.back")}" onclick="location.href='../common/index.ct'" />
                                    </div>
                                </div>
                              </form>
                            </div>
                        </div>
	        </div>
	       <!-- end 中间内容部分-->
	       [#include "/console/include/footer.ftl" /]
  </div>
</div>
<script type="text/javascript" src="${base}/resources/console/js/plugins/layer/laydate/laydate.js">
</script>
<script>
    //日期范围限制
    var start = {
        elem: '#beginDate',
        format: 'YYYY-MM-DD hh:mm:ss',
        min: '1900-01-01', //最小日期
        //设定最小日期为当前日期
        max: '2099-06-16',
        //最大日期
        istime: true,
        istoday: false,
        choose: function(datas) {
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#endDate',
        format: 'YYYY-MM-DD hh:mm:ss',
        min: '1900-01-01', //最小日期
        max: '2099-06-16',
        istime: true,
        istoday: false,
        choose: function(datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);
</script>
</body>
</html>