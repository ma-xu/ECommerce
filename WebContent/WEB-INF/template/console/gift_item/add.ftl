<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.giftItem.add")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/input.js"></script>
<link href="${base}/resources/console/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/console/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/plugins/chosen/chosen.jquery.js"></script>
<link href="${base}/resources/console/css/plugins/chosen/chosen.css" rel="stylesheet" type="text/css" />
<style type="text/css">
table th {
  width: 150px;
  line-height: 25px;
  padding: 5px 10px 5px 0px;
  font-weight: normal;
  white-space: nowrap;
}
</style>
<script type="text/javascript">
$().ready(function() {

	var $isBuy = $("#isBuy");
	var $inputForm = $("#inputForm");
	var $defaultPointScaleDiv = $("#defaultPointScaleDiv");
	var $defaultPriceChangeDiv = $("#defaultPriceChangeDiv");
	var $defaultPriceChange = $("#defaultPriceChange");
	var $defaultPointScale = $("#defaultPointScale");
	var $addRule = $("#addRule");
	var count = 0;//赠品项规则序列
	var $rulesTable = $("#rulesTable");

	[@flash_message /]
	
	// 表单验证
	$inputForm.validate({
		rules: {
			giftName: {
				required: true,
				maxlength:20
			},
			quantity: {
				required: true,
				pattern:/^[1-9]\d*$/,
				max: 2147483647
			},
			maxExchangeNum:{
				required: true,
				pattern:/^[1-9]\d*$/,
				max: 2147483647
			},
			price: {
				required: true,
				min: 0,
				decimal: {
					integer: 12,
					fraction: 2
				}
			},
			image : {
				required: true
			},
			point : {
				required: true,
				digits: true,
				max: 1000000000000000000
			},
			decription : {
				required: true,
				maxlength:255
			},
			defaultPriceChange:{
				required: true,
				min: 1,
				decimal: {
					integer: 12,
					fraction: 2
				}
			}
		},
		messages: {
			quantity: {
				pattern: "${message("console.app.appCodeIllegalPattern")}"
			},
			maxExchangeNum: {
				pattern: "${message("console.app.appCodeIllegalPattern")}"
			}
		},
		submitHandler: function(form) {
		    var submitOk=true;
		    var $price = $("#price").val();
		    var $defaultPriceChange = $("#defaultPriceChange").val();
		    if($("#isBuy").prop("checked")){
		    	if($defaultPriceChange!=""){
		    		var price = parseFloat($price);
		    		var defaultPriceChange = parseFloat($defaultPriceChange);
		    		if(price <= defaultPriceChange){
					    submitOk=false;
						$.message("warn", "最低使用金额不能超过销售价！");
					}
		    	}
		    	else{
		    		submitOk=false;
					$.message("warn", "最低使用金额不能为空！");
		    	}
		    }
			if(submitOk){
				form.submit();
			}
		}
	});
	
	<!--start上传图片插件 -->
 	var $columnCoverImageUpload = $("#columnCoverImageUpload");
	var $showColumnCoverImage = $("#showColumnCoverImage");
	var $showColumnCoverImageHref = $("#showColumnCoverImageHref");
	var $deleteColumnCoverImage = $("#deleteColumnCoverImage");
	var $columnCoverImage = $("#columnCoverImage");
	var $showColumnCoverImageBr = $("#showColumnCoverImageBr");
    $columnCoverImageUpload.uploadify({  
        'successTimeout' : 50000,
        'height'        : 27,   
        'width'         : 80,    
        'buttonText'    : '浏览',  
        'swf'           : '${base}/resources/console/uploadify/uploadify.swf',  
        'uploader'      : '${base}/console/file/upload.ct?fileType=image',  
        'auto'          : true,
        'multi'          : true, //是否支持多文件上传  
	    'simUploadLimit' : 1, //一次同步上传的文件数目     
	    'fileSizeLimit'  : '2048', //设置单个文件大小限制     
	    'queueSizeLimit' : 1, //队列中同时存在的文件个数限制
	    'fileObjName'    :  'file',
	    'fileTypeDesc'  :  '*.jpg;*.gif;*.jpeg;*.png;*.bmp',       //图片选择描述  
        'fileTypeExts'  :  '*.jpg;*.gif;*.jpeg;*.png;*.bmp',//允许的格式      
        'formData'      : {'token' : getCookie("token") ,
        				   'imageWidth':'128',
	        		       'imageHeight':'128'
    					},
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
            		$showColumnCoverImage.attr("src",contentImgFileUrl);
		            $showColumnCoverImageHref.attr("href",contentImgFileUrl);
		            $deleteColumnCoverImage.attr("val",contentImgFileUrl);
		            $columnCoverImage.val(contentImgFileUrl);
		            $("#columnCoverImageUpload").hide(100);
		            $showColumnCoverImage.show(100);
		            $showColumnCoverImageHref.show(100);
		            $deleteColumnCoverImage.show(100);
		            $showColumnCoverImageBr.show(100);
            	}
            	else{
            		$.message("warn", sizeErrorMessageContent);
            	}
            }else{
                if(messageContent){
                    $.message("warn", messageContent);
                }else{
                    $.message("warn", dataJson['message']);
                }
            }
        },
	    onComplete: function (event, queueID, fileObj, response, data) {
	           
	    },  
	    onError: function(event, queueID, fileObj) {     
	        alert("文件:" + fileObj.name + "上传失败");     
	    }
    });
	<!--end上传图片插件 -->
	
	<!-- start删除图片插件-->
	// 删除封面图片
	$deleteColumnCoverImage.on("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "${message("admin.dialog.deleteConfirm")}",
			onOk: function() {
	            $showColumnCoverImage.attr("src","");
	            $showColumnCoverImageHref.attr("href","");
	            $deleteColumnCoverImage.attr("val","");
	            $columnCoverImage.val("");
	            $("#columnCoverImageUpload").show(100);
	            $showColumnCoverImage.hide(100);
	            $showColumnCoverImageHref.hide(100);
	            $deleteColumnCoverImage.hide(100);
	            $showColumnCoverImageBr.hide(100);
			}
		});
	});
	<!-- end  删除图片插件-->
	
	// 是否需要现金购买
	$isBuy.click(function() {
		if ($(this).prop("checked")) {
			$defaultPriceChangeDiv.show();
			$defaultPriceChange.attr("name","defaultPriceChange");	
		} else {
			$defaultPriceChangeDiv.hide();
			$defaultPriceChange.attr("value","");
			$defaultPriceChange.removeAttr("name");
		}
	});
	
	//添加规则
	$("#addRule").click(function(){
	  var ruleHTML = '<tr>'
						+'<th>${message("规则")}：</th>'
						+'<td>'
					   	+'<input type="text"  class="form-control" name="contents" maxlength="200"/>'
						+'</td>'
				   +'</tr>';     
       $rulesTable.append(ruleHTML);
       count++;
	});
	
});
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
					<h2> ${message("console.giftItem.add")} </h2>
	                <ol class="breadcrumb">
						<li>
						    <!--首页-->
							<a href="${base}/console/common/index.ct">${message("console.path.index")}</a> 
	                    </li>
	                    <li>
	                        <strong>${message("console.giftItem.add")}</strong>
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
                                    <a data-toggle="tab" onclick="changeNavHeight()"  href="tabs_panels.html#settingBaseTab">
                                        ${message("GiftItem.info")}
                                    </a>
                                </li>
                                <li class="">
                                    <a data-toggle="tab" onclick="changeNavHeight()" href="tabs_panels.html#settingGiftItemRulesTab">
                                        ${message("GIftItem.rules")}
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
												<span class="requiredField">*</span>${message("GiftItem.giftName")}:
											</th>
											<td>
												<input type="text" name="giftName" class="form-control"/>
											</td>
										</tr>
										<tr>
											<th>${message("GiftItem.relatedDictSchool")}:</th>
											<td>
												<div class="col-md-12">
													<div class="input-group" style="width:100%;">
				                                        <select id="schoolSelect" data-placeholder="请选择关联学校(可搜索名字)" name="dictSchoolIds" class="chosen-select" multiple style="width:100%;"  tabindex="4">
				                                            <option id="selectAllSchools">------${message("GiftItem.allDictSchool")}------</option>
				                                            [#list dictSchools as dictSchool]
				                                            <option value="${dictSchool.id}" hassubinfo="true" >${dictSchool.name}</option>
				                                            [/#list]
				                                        </select>
				                                    </div>
												</div>
											</td>
										</tr>
										<tr>
											<th>
												<span class="requiredField">*</span>${message("GiftItem.image")}:
											</th>
											<td>
												<div class="col-sm-9">
													<input type="file" id="columnCoverImageUpload" />
													<img style="display: none;" height="150px" id="showColumnCoverImage" />
													<br style="display: none;" id="showColumnCoverImageBr"/>
													<a href="#" style="display: none;" id="showColumnCoverImageHref" target="_blank">[${message("admin.common.view")}]</a>
													<a href="javascript:;" style="display: none;" id="deleteColumnCoverImage" val="">[${message("admin.common.delete")}]</a>
													<input type="hidden" id="columnCoverImage" name="image" class="form-control"/>
													<div style="font-weight: inherit;padding-top: 7px;">请上传128*128像素大小的图片</div>
												</div>
											</td>
										</tr>
										<tr>
											<th>
												<span class="requiredField">*</span>${message("GiftItem.price")}:
											</th>
											<td>
												<input type="text" id="price" name="price" class="form-control"/>
											</td>
										</tr>
										<tr>
											<th>
												<span class="requiredField">*</span>${message("GiftItem.point")}:
											</th>
											<td>
												<input type="text" name="point" class="form-control"/>
											</td>
										</tr>
										<tr>
											<th>
												${message("GiftItem.isOnline")}:
											</th>
											<td>
												<input type="checkbox" name="isOnline" id="isOnline"/>
												<lable for="isOnline">${message("GiftItem.online")}</lable>
											</td>
										</tr>
										<tr>
											<th>
												<span class="requiredField">*</span>${message("GiftItem.decription")}:
											</th>
											<td>
												<textarea name="decription" class="form-control" style="height: 80px;"></textarea>
											</td>
										</tr>
										<tr>
											<th>
												<span class="requiredField">*</span>${message("GiftItem.quantity")}:
											</th>
											<td>
												<input type="text" name="quantity" class="form-control"/>
											</td>
										</tr>
										<tr>
											<th>
												<span class="requiredField">*</span>${message("GiftItem.maxExchangeNum")}:
											</th>
											<td>
												<input type="text" name="maxExchangeNum" class="form-control"/>
											</td>
										</tr>
										<tr>
											<th>
												${message("GiftItem.isBuy")}:
											</th>
											<td>
												<input type="checkbox" name="isBuy" id="isBuy"/>
												<lable for="isBuy">${message("GiftItem.buy")}</lable>
											</td>
										</tr>
										<tr id="defaultPriceChangeDiv" style="display:none;">
											<th>
												<span class="requiredField">*</span>${message("GiftItem.defaultPriceChange")}:
											</th>
											<td>
												<input type="text" id="defaultPriceChange" class="form-control"/>
											</td>
										</tr>
									</table>
								</div>
								<div id="settingGiftItemRulesTab" class="tab-pane">
                                    <table class="table table-striped">
										<tr>
											<th>
												${message("添加赠品项规则")}:
											</th>
											<td>
												<a href="javascript:void(0);" id="addRule" class="btn btn-primary">
													<span class="addIcon">&nbsp;</span>添加规则
												</a>
												<span>${message("允许输入最大字符长度为200！")}</span>
											</td>
										</tr>
										<table class="table table-striped" id="rulesTable">
										</table>
									</table>
									</table>
                                </div>
							</div>
						</div>
						<div class="form-group">
                            <div class="col-sm-4 col-sm-offset-2">
                                <input type="submit" class="btn btn-primary" value="${message("console.common.submit")}" />
								<input type="button" class="btn btn-white" value="${message("console.common.back")}" onclick="location.href='list.ct'" />
                            </div>
                        </div>
					</form>
				</div>
			</div>
			<!-- end 中间内容部分 -->
		   	[#include "/console/include/footer.ftl" /]
		</div>
	</div>
	<script>
		var config = {
		    '.chosen-select': {},
		    '.chosen-select-deselect': {
		        allow_single_deselect: true
		    },
		    '.chosen-select-no-single': {
		        disable_search_threshold: 10
		    },
		    '.chosen-select-no-results': {
		        no_results_text: '无选择项'
		    },
		    '.chosen-select-width': {
		        width: "95%"
		    }
		}
		function initChosen(){
			for (var selector in config) {
			    $(selector).chosen(config[selector]);
			}
			$(".chosen-select").trigger("chosen:updated");
		}
		initChosen();
		
		$().ready(function() {
			
			$("#schoolSelect").change(function(){
				if(document.getElementById("selectAllSchools").selected == true){
					$("#schoolSelect option").each(function(){
						$(this).attr("selected", true);
					});
					document.getElementById("selectAllSchools").selected =false;
					document.getElementById("selectAllSchools").disabled = true;
					initChosen();
				}
				if($("#schoolSelect option:selected").length == ${dictSchools?size}){
					document.getElementById("selectAllSchools").selected =false;
					document.getElementById("selectAllSchools").disabled = true;
					initChosen();
				}else{
					document.getElementById("selectAllSchools").selected =false;
					document.getElementById("selectAllSchools").disabled = false;
					initChosen();
				}
			});
			
		});
	</script>
</body>
</html>