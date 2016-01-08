<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.appPushMsg.add")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/jquery.lSelect.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/console/editor/kindeditor.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/input.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/plugins/chosen/chosen.jquery.js"></script>
<link href="${base}/resources/console/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/console/uploadify/jquery.uploadify.min.js"></script>
<link href="${base}/resources/console/css/plugins/chosen/chosen.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/console/css/plugins/iCheck/custom.css" rel="stylesheet" type="text/css" />
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
$().ready(function() {

	var $inputForm = $("#inputForm");
	
	[@flash_message /]
	
	// 表单验证
	$inputForm.validate({
		rules: {
			//dictClassIds:"required",
			author:{
				maxlength:8
			},
			title: {
				required: true,
				maxlength:64
			},
			digest: {
				maxlength:54
			},
			msgBody: "required"
		},
		messages: {
		}
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
	    'fileTypeDesc'  :  '*.jpg;*.gif;*.jpeg;*.png;*.bmp',//图片选择描述  
        'fileTypeExts'  :  '*.jpg;*.gif;*.jpeg;*.png;*.bmp',//允许的格式      
        'formData'      : {'token' : getCookie("token") },
        //上传成功  
        'onUploadSuccess' : function(file, data, response) {  
            var dataJson = JSON.parse(data);
            var contentImgFileUrl = dataJson['url'];
            var messageContent = dataJson['message']['content'];
            var messageType = dataJson['message']['type'];
            if(messageType == 'success'){
	            $smallIconfilePreview.attr("src",contentImgFileUrl);
	            $smallIconfile.val(contentImgFileUrl);
	            $delSmallIconfileImg.css('display','inline'); 
            }else{
                $.message("warn", messageContent);
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
	$delSmallIconfileImg.on("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "${message("admin.dialog.deleteConfirm")}",
			onOk: function() {
			    $smallIconfilePreview.attr("src","${base}/resources/console/images/newsUploadt.png");
	            $smallIconfile.val("");
	            $delSmallIconfileImg.css('display','none'); 
			}
		});
	});
	<!-- end  删除图片插件-->
	
	
		
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
                    <h2> ${message("console.appPushMsg.add")}</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                            <strong>${message("console.appPushMsg.add")}</strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">

                </div>
            </div>
	       <!-- end 头部面包屑区域 -->
	       
	        <!-- start 中间内容部分 -->
	        <div class="wrapper wrapper-content animated fadeIn">
	             <!-- start 新增新闻-->
	             <form id="inputForm" action="save.ct" method="post">
		             <div class="row">
	                    <div class="col-lg-12">
	                        <div class="ibox float-e-margins">
	                            <div class="ibox-content" style="margin:0 auto;">
	                                <div class="row">
	                                    <div class="col-sm-4 m-b-xs">
											
	                                    </div>
	                                </div>
	                                <div class="table-responsive">
	                                     <table class="table table-striped">
	                                     	<tr>
												<th>
													<span class="requiredField">*</span>${message("console.appPushMsg.sendClass")}:
												</th>
												<td>
													<div class="row">
  														<div class="col-md-8">
  															<div class="input-group" style="width:100%;">
						                                        <select id="classSelect" data-placeholder="请选择关联班级(可搜索名字)" name="dictClassIds" class="chosen-select" multiple style="width:100%;"  tabindex="4">
						                                            [#list dictClasses as dictClass]
						                                            <option value="${dictClass.id}" hassubinfo="true" >${dictClass.name}</option>
						                                            [/#list]
						                                        </select>
						                                    </div>
														</div>
														<div class="col-md-4">
															<input type="checkbox" id="isAllClass" name="isAllClass" value="true" class="i-checks" />
															<input type="hidden" name="_isAllClass" value="false" />
															所有班级
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("News.title")}:
												</th>
												<td>
													<input type="text" name="title" class="form-control" maxlength="64" />
												</td>
											</tr>
											<tr>
												<th>
													${message("News.author")}:
												</th>
												<td>
													<input type="text" name="author"  class="form-control" maxlength="8" />
												</td>
											</tr>
											<tr>
												<th>
													${message("AppPushMsg.coverImage")}:
													
												</th>
												<td>
													<p class="text-muted">封面大图片建议尺寸：900像素 * 500像素</p>
													<div class="itemList-upload">
														<div class="imgShowBox">
															<img src="${base}/resources/console/images/newsUploadt.png" alt="上传新闻预览图" id="smallIconfilePreview" class="newsPreview" >
															<a href="javascript:;" title="删除图片" class="delImg" id="delSmallIconfileImg">×</a>
														</div>
														<div class="uploadContainer" style="margin-left: 7px;">
															<input type="file" id="smallIconfileImageUpload" />
															<input type="hidden" id="smallIconfile" name="coverImage" value="0">
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("News.content")}:
												</th>
												<td style="text-align: left;">
													<p class="text-muted">
														请从<a class="btn btn-warning" onclick="openImeibian()">爱美编</a>编辑内容粘贴过来
													</p>
													<textarea name="msgBody" id="editor" class="form-control"></textarea>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("News.summary")}:
												</th>
												<td>
													<p class="text-muted">摘要选填，如果不填写会默认抓取正文前54个字</p>
													<textarea name="digest" class="form-control"></textarea>
												</td>
											</tr>
											<tr>
												<th>
													${message("AppPushMsg.isDraft")}:
												</th>
												<td>
													<label>
														<input type="checkbox" name="isDraft" value="true" class="i-checks" checked />
														<input type="hidden" name="_isDraft" value="false" />
													</label>
												</td>
											</tr>
											<tr>
												<th>
													${message("AppPushMsg.sourceUrl")}:
												</th>
												<td>
													<input type="text" name="sourceUrl" class="form-control" maxlength="255" />
												</td>
											</tr>
										</table>
										<table class="input">
											<tr>
												<th>
													&nbsp;
												</th>
												<td>
													<input type="submit" class="btn  btn-primary" value="${message("console.common.submit")}" />
													<input type="button" class="btn btn-white" value="${message("console.common.back")}" onclick="location.href='list.ct'" />
												</td>
											</tr>
										</table>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                </form>
	             <!-- end 新增新闻-->
	        </div>
	       <!-- end 中间内容部分-->
	       [#include "/console/include/footer.ftl" /]
  </div>
</div>
<script src="${base}/resources/console/js/plugins/iCheck/icheck.min.js"></script>
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
	for (var selector in config) {
	    $(selector).chosen(config[selector]);
	}
	$(".chosen-select").trigger("chosen:updated");
</script>
<script type="text/javascript">
	/*会影响操作
	$(document).ready(function () {
		$('.i-checks').iCheck({
			checkboxClass: 'icheckbox_square-green',
			radioClass: 'iradio_square-green',
		});
	});
	*/
	function openImeibian(){
		window.open("http://www.imeibian.com/");
	}
	
	$("#classSelect").change(function(){
		var selectedNum = $("#classSelect").find("option:selected").size();
		if(selectedNum == ${dictClasses?size}){
			document.getElementById("isAllClass").checked=true;
		}else{
			document.getElementById("isAllClass").checked=false;
		}
	});
	
	$("#isAllClass").change(function(){
		var isAllClass = document.getElementById("isAllClass");
		if(isAllClass.checked == true){
		 	$("#classSelect option").each(function(){
		 		$(this).attr("selected", true);
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
				for (var selector in config) {
				    $(selector).chosen(config[selector]);
				}
				$(".chosen-select").trigger("chosen:updated");
		 	});
		 	
		}
	});
	
</script>
</body>
</html>