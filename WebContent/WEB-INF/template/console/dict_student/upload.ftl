<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("批量上传头像")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<link href="${base}/resources/console/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/console/uploadify/jquery.uploadify.min.js"></script>
<!-- Fancy box -->
<link href="${base}/resources/console/js/plugins/fancybox/jquery.fancybox.css" rel="stylesheet">
<script src="${base}/resources/console/js/plugins/fancybox/jquery.fancybox.js"></script>
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

    var $deleteAttachmentFile = $("a.deleteAttachmentFile");
    //区分老师、学生、家长管理中图像批量上传
    var menuId = '${menuId}';
    var uploadUrl = "";
    var jsessionid = '${pageContext.session.id}';
    if(menuId && (menuId == 'MemberPatriarch') || menuId == 'Member' || menuId == 'DictStudent'){
        uploadUrl = "${base}/console/file/uploadHeadPortrait.ct;jsessionid=" + jsessionid;
    }else{
        uploadUrl = "${base}/console/file/upload.ct;jsessionid=" + jsessionid;
    }
    
	 <!-- 附件上传 -->
    $("#article_attachment_file_upload").uploadify({  
        'successTimeout' : 50000,
 		'height'        : 27,
        'width'         : 80,
        'buttonText'    : '浏览',
        'swf'           : '${base}/resources/console/uploadify/uploadify.swf',    
        'uploader'      : uploadUrl,   
        'auto'          : false,
        'multi'          : true, //是否支持多文件上传  
	    'simUploadLimit' : 1, //一次同步上传的文件数目     
	    'fileSizeLimit'  : '2048', //设置单个文件大小限制     
	    'queueSizeLimit' : 500, //队列中同时存在的文件个数限制
	    'fileObjName'    :  'file',
	    'fileTypeDesc'  :  '*.jpg;*.gif;*.jpeg;*.png;*.bmp',//图片选择描述  
        'fileTypeExts'  :  '*.jpg;*.gif;*.jpeg;*.png;*.bmp',//允许的格式       
        'formData'      : {'token' : getCookie("token"),'fileType' : 'image' },
        //上传成功
        'onUploadStart' : function(file){
          [@compress single_line = true]
           $.ajax({
					type: "GET",
					url: "${base}/console/dict_student/checkName.ct",
					data: {
					    fileName:file.name,
					    type:"${type}"
					},
					dataType: "json",
					success:function(message){
					if(message !="success"){
					    var fileName = file.name;
					    var errorMsg = message;
					    $('#article_attachment_file_upload').uploadify('stop','*');
						$.dialog({
							type: "warn",
							content:'${message("upload.image.error","'+errorMsg+'")}',
							onOk: function() {
							   $('#article_attachment_file_upload').uploadify('cancel');
							   $('#article_attachment_file_upload').uploadify('upload','*');
							},
						});
					  }
					}
				});
			[/@compress]
        },
        'onUploadSuccess' : function(file, data, response) {  
            var dataJson = JSON.parse(data);
            var contentImgFileUrl = dataJson['url'];
            var messageContent = dataJson['message']['content'];
            var messageType = dataJson['message']['type'];
            if(messageType == 'success'){
            [@compress single_line = true]
               $.ajax({
						type: "GET",
						url: "${base}/console/dict_student/uploadIconPhoto.ct",
						data: {
						    fileName:file.name,
						    url:contentImgFileUrl,
						    type:"${type}"
						},
						dataType: "json",
						success:function(message){
						  if(message=="success"){
						  }
						}
					});
			 [/@compress]
            }else{
                if(messageContent){
                    $.message("warn", messageContent);
                }else{
                    $.message("warn", dataJson['message']);
                }
            }
        },
        //onQueueComplete:function(queueData){
        //     $.message("warn", "${message("批量上传完成！")}");
        //},
	    onError: function(event, queueID, fileObj) {     
	        alert("文件:" + fileObj.name + "上传失败");
	    }
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
                    <h2> ${message("批量上传头像")}</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                            <strong>${message("批量上传头像")}</strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">

                </div>
            </div>
	       <!-- end 头部面包屑区域 -->
	       
	        <!-- start 中间内容部分 -->
	        <div class="wrapper wrapper-content animated fadeIn">
	             <!-- start -->
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
											<tr id="article_attachment">
												<th>
													${message("批量上传头像")}
												</th>
												<td>
													<input type="file" name="attachment" id="article_attachment_file_upload" />
													<a href="javascript:$('#article_attachment_file_upload').uploadify('upload','*')" class="button">${message("开始上传")}</a>      
								                    <a href="javascript:$('#article_attachment_file_upload').uploadify('cancel', '*')" class="button">${message("取消所有上传")}</a> 
												</td>
											</tr>
										</table>
										<table class="input">
											<tr>
												<th>
													&nbsp;
												</th>
												<td>
												    [#if type == "dictStudent"]
    													<input type="button" class="btn btn-white" value="${message("console.common.back")}" onclick="location.href='list.ct'" />
												    [/#if]
												    [#if type == "member"]
												        <input type="button" class="btn btn-white" value="${message("console.common.back")}" onclick="location.href='${base}/console/member/list.ct'" />
												    [/#if]
												    [#if type == "teacher"]
												        <input type="button" class="btn btn-white" value="${message("console.common.back")}" onclick="location.href='${base}/console/teacher/list.ct'" />
												    [/#if]
												</td>
											</tr>
										</table>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                </form>
	             <!-- end -->
	        </div>
	       <!-- end 中间内容部分-->
	       [#include "/console/include/footer.ftl" /]
  </div>
</div>
<script>
    $(document).ready(function () {
        $('.fancybox').fancybox({
            openEffect: 'none',
            closeEffect: 'none'
        });
    });
</script>
</body>
</html>