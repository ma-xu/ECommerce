<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.memberRank.add")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/input.js"></script>
<link href="${base}/resources/console/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/console/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $isDefault = $("#isDefault");
	var $inputForm = $("#inputForm");

	[@flash_message /]
	
	// 表单验证
	$inputForm.validate({
		rules: {
			name: {
				required: true,
				remote: {
					url: "check_name.ct",
					cache: false
				},
				maxlength:100
			},
			point: {
				required: true,
				digits: true,
				max: 1000000000000000000
			},
			rankIcon: {
				required: true
			},
		},
		messages: {
			name: {
				remote: "${message("console.validate.exist")}"
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
        'formData'      : {'token' : getCookie("token") },
        //上传成功  
        'onUploadSuccess' : function(file, data, response) {  
            var dataJson = JSON.parse(data);
            var contentImgFileUrl = dataJson['url'];
            var messageContent = dataJson['message']['content'];
            var messageType = dataJson['message']['type'];
            if(messageType == 'success'){
	            $showColumnCoverImage.attr("src",contentImgFileUrl);
	            $showColumnCoverImageHref.attr("href",contentImgFileUrl);
	            $deleteColumnCoverImage.attr("val",contentImgFileUrl);
	            $columnCoverImage.val(contentImgFileUrl);
	            $("#columnCoverImageUpload").hide(100);
	            $showColumnCoverImage.show(100);
	            $showColumnCoverImageHref.show(100);
	            $deleteColumnCoverImage.show(100);
	            $showColumnCoverImageBr.show(100);
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
					<h2> ${message("console.memberRank.add")} </h2>
	                <ol class="breadcrumb">
						<li>
						    <!--首页-->
							<a href="${base}/console/common/index.ct">${message("console.path.index")}</a> 
	                    </li>
	                    <li>
	                        <strong>${message("console.memberRank.add")}</strong>
	                    </li>
					</ol>
	            </div>
	            <div class="col-lg-2">
	
	            </div>
	        </div>
	       	<!-- end 头部面包屑区域 -->	
			<!-- start 中间内容部分 -->
			<div class="wrapper wrapper-content animated fadeIn">
				<div class="row">
			        <div class="col-lg-12">
			            <div class="ibox float-e-margins">
			                <div class="ibox-content" style="width:50%;margin:0 auto;">
			                    <form id="inputForm" action="save.ct" method="post" class="form-horizontal m-t">
			                        <div class="form-group">
			                            <label class="col-sm-3 control-label"><span class="requiredField">*</span>${message("MemberRank.name")}：</label>
			                            <div class="col-sm-8">
			                                <input id="name" name="name" class="form-control" autocomplete="off">
			                            </div>
			                        </div>
			                        <!--<div class="form-group">
			                            <label class="col-sm-3 control-label">${message("MemberRank.scale")}：</label>
			                            <div class="col-sm-8">
			                                <input id="scale" name="scale" class="form-control" autocomplete="off">
			                            </div>
			                        </div>-->
			                        <div class="form-group">
			                            <label class="col-sm-3 control-label"><span class="requiredField">*</span>${message("MemberRank.point")}：</label>
			                            <div class="col-sm-8">
			                                <input id="point" name="point" class="form-control" autocomplete="off">
			                            </div>
			                        </div>
			                        <div class="form-group">
			                        	<label class="col-sm-3 control-label">${message("MemberRank.isDefault")}：</label>
			                        	<div class="col-sm-8" style="padding-top:7px;">
			                        		<label>
												<input type="checkbox" name="isDefault"/>${message("MemberRank.isDefault")}
												<input type="hidden" name="_isDefault" value="false"/>
											</label>
										</div>
									</div>
			                        <div class="form-group">
										<th>
											 <label class="col-sm-3 control-label">
											 	<span class="requiredField">*</span>${message("MemberRank.rankIcon")}:
											 </label>
										</th>
										<div class="col-sm-9">
											<input type="file" id="columnCoverImageUpload" />
											<img style="display: none;" height="150px" id="showColumnCoverImage" />
											<br style="display: none;" id="showColumnCoverImageBr"/>
											<a href="#" style="display: none;" id="showColumnCoverImageHref" target="_blank">[${message("admin.common.view")}]</a>
											<a href="javascript:;" style="display: none;" id="deleteColumnCoverImage" val="">[${message("admin.common.delete")}]</a>
											<input type="hidden" id="columnCoverImage" name="rankIcon" class="form-control"/>
										</div>
									</div>
			                        <div class="form-group">
			                            <div class="col-sm-8 col-sm-offset-3">
			                               <input type="submit" class="btn  btn-primary" value="${message("console.common.confirm")}" />
										   <input type="button" class="btn btn-white" value="${message("console.common.back")}" onclick="location.href='list.ct'" />
			                            </div>
			                        </div>
			                    </form>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
			<!-- end 中间内容部分 -->
		   	[#include "/console/include/footer.ftl" /]
		</div>
	</div>
</body>
</html>