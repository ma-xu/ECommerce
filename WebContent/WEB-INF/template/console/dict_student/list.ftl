<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.dictStudent.list")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/list.js"></script>
<link href="${base}/resources/console/css/excelImport.css" rel="stylesheet">
<script type="text/javascript" src="${base}/resources/console/js/excelImport.js"></script>
<link href="${base}/resources/console/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/console/uploadify/jquery.uploadify.min.js"></script>
<style type="text/css">
.uploadify {
  position: relative;
  margin-top: 0px;
  display: inline-block;
}
.uploadify-queue {
  margin-bottom: 1em;
  display: none;
}
#listTable td{
	vertical-align : middle;
}

</style>
<script type="text/javascript">
$().ready(function() {

	[@flash_message /]
	<!-- start 上传图集 -->
	var $batchSaveStudentUpload = $("#batchSaveStudentUpload");
    $batchSaveStudentUpload.uploadify({  
        'successTimeout' : 50000,
        'height'        : 34,   
        'width'         : 100,    
        'buttonText'    : '${message("批量导入学生")}',  
        'swf'           : '${base}/resources/console/uploadify/uploadify.swf',  
        'uploader'      : '${base}/console/dict_student/batchImportExcel.ct?fileType=file',  
        'auto'          : true,
        'multi'          : true, //是否支持多文件上传  
	    'simUploadLimit' : 1, //一次同步上传的文件数目     
	    'sizeLimit'      : 19871202, //设置单个文件大小限制     
	    'queueSizeLimit' : 1, //队列中同时存在的文件个数限制
	    'fileObjName'    :  'file',
	    'fileTypeDesc'  :  '*.xls',//选择描述  
        'fileTypeExts'  :  '*.xls',//允许的格式      
        'formData'      : {'token' : getCookie("token")},
        //上传成功  
        'onUploadSuccess' : function(file, data, response) {  
        	layer.closeAll();
            var dataJson = JSON.parse(data);
            var contentImgFileUrl = dataJson['url'];
            var messageContent = dataJson['message']['content'];
            var messageType = dataJson['message']['type'];
            if(messageType == 'success'){
		        $.message("success", "数据导入成功！");
	        	location.reload();
            }else{
                $.message("warn", messageContent);
            }
        },
	    onUploadStart :function(){
    		layer.load('文件处理中,请稍等。。。');
	    },  
	    onError: function(event, queueID, fileObj) {     
	        alert("文件:" + fileObj.name + "上传失败");     
	    }
    });
	<!-- end 上传图集 -->
	
	
    <!-- start 上传卡号 -->
    var $batchSaveCardUpload = $("#batchSaveCardUpload");
    $batchSaveCardUpload.uploadify({  
        'successTimeout' : 50000,
        'height'        : 34,   
        'width'         : 100,    
        'buttonText'    : '${message("批量更新卡号")}',  
        'swf'           : '${base}/resources/console/uploadify/uploadify.swf',  
        'uploader'      : '${base}/console/timeCard/card4Student.ct?fileType=file',  
        'auto'          : true,
        'multi'          : true, //是否支持多文件上传  
	    'simUploadLimit' : 1, //一次同步上传的文件数目     
	    'sizeLimit'      : 19871202, //设置单个文件大小限制     
	    'queueSizeLimit' : 1, //队列中同时存在的文件个数限制
	    'fileObjName'    :  'file',
	    'fileTypeDesc'  :  '*.xls',//选择描述  
        'fileTypeExts'  :  '*.xls',//允许的格式      
        'formData'      : {'token' : getCookie("token")},
        //上传成功  
        'onUploadSuccess' : function(file, data, response) {  
        	layer.closeAll();
            var dataJson = JSON.parse(data);
            var contentImgFileUrl = dataJson['url'];
            var messageContent = dataJson['message']['content'];
            var messageType = dataJson['message']['type'];
            if(messageType == 'success'){
		        $.message("success", "数据导入成功！");
	        	location.reload();
            }else{
                $.message("warn", messageContent);
            }
        },
     	onUploadStart :function(){
    		layer.load('文件处理中,请稍等。。。');
	    },  
	    onError: function(event, queueID, fileObj) {     
	        alert("文件:" + fileObj.name + "上传失败");     
	    }
    });
    <!-- end 上传卡号 -->
});

//查看卡号详情层
function showCardDiv(id,name,dictStudentId,dictStudentName){
	var $dictStudentId = $("#dictStudentId");
	var $dictStudentName = $("#dictStudentName");
	var $patriarchId = $("#patriarchId");
	var $cardDiv = $("#cardDiv");
	var $cardDivTitle = $("#cardDivTitle");
	var $cardsTable = $("#cardsTable");
	var $cardNumber = $("#cardNumber");
	
	layer.load();
	$patriarchId.val(id);
	$cardDivTitle.html(name);
	$cardsTable.html("<tr><th>卡号</th><th>状态</th><th>操作</th></tr>");
	$.ajax({
		type: "GET",
		url: "${base}/console/timeCard/getCardsByMember.ct",
		data: {
		    id:id
		},
		dataType: "json",
		success:function(cards){
			if(cards==null||cards.length==0){
				$cardsTable.append("<tr><td colspan='3'>无数据</td></tr>");
				return;
			}
			else{
				for(num in cards){
					var card = cards[num];
					var status = card.cardStatus;
					var handle="";
					if(status=="normal"){
						status = "<span style='color:green;'>正常</span>";
						handle="<a onclick='cardChangeStatus("+card.id+",\"disable\")'>[禁用]</a><a onclick='cardChangeStatus("+card.id+",\"loss\")'>[挂失]</a>";
					}
					else if(status=="disable"){
						status = "<span style='color:red;'>禁用</span>";
						handle="<a onclick='cardChangeStatus("+card.id+",\"normal\")'>[启用]</a>";
					}
					else if(status=="loss"){
						status = "<span style='color:darkgray;'>挂失</span>";
						handle="<a onclick='cardChangeStatus("+card.id+",\"disable\")'>[禁用]</a><a onclick='cardChangeStatus("+card.id+",\"normal\")'>[解挂]</a>";
					}	
					handle = handle + "<a onclick='deleteCard("+card.id+")'>[删除]</a>"				
					var contentTD = "<tr><td>"+card.cardNumber+"</td><td>"+status+"</td><td>";
					contentTD += handle;
					contentTD += "</td></tr>";
					$cardsTable.append(contentTD);
				}
			}
			
		}
	});
	$dictStudentId.val(dictStudentId);
	$dictStudentName.html(dictStudentName);
	$cardNumber.val("");
	$cardDiv.fadeIn();
	layer.closeAll();
}

// 关闭查看卡号详情层
function closeCardDiv(){
	$("#cardDiv").fadeOut();
	window.location.reload();
}

// 添加卡号
function submitCard(){
	var id = $("#patriarchId").val();
	var $cardNumber = $("#cardNumber");
	var name = $("#cardDivTitle").html();
	var cardNumber = $cardNumber.val();
	var dictStudentId = $("#dictStudentId").val();
	var dictStudentName = $("#dictStudentName").val();
	if(cardNumber==null||cardNumber==""){
		$.message("warn", "卡号不能为空");
		return;
	}
	$.ajax({
		type: "GET",
		url: "${base}/console/timeCard/addCardMember.ct",
		data: {
		   	memberId:id,
		    cardNumber:cardNumber,
		    studentId:dictStudentId
		},
		dataType: "json",
		success:function(mark){
			if(mark=="success"){
				$.message("success", "操作成功！");
				showCardDiv(id,name,dictStudentId,dictStudentName);
			}
			else{
				$.message("warn", mark);
				$("#cardNumber").val(cardNumber);
				showCardDiv(id,name,dictStudentId,dictStudentName);
			}
			
		}
	});
	
}

//删除卡号
function deleteCard(cardId){
	
	var id = $("#patriarchId").val();
	var $cardNumber = $("#cardNumber");
	var name = $("#cardDivTitle").html();
	var cardNumber = $cardNumber.val();
	var dictStudentId = $("#dictStudentId").val();
	var dictStudentName = $("#dictStudentName").val();
	
	$.dialog({
		type: "warn",
		content: message("console.dialog.deleteConfirm"),
		ok: message("console.dialog.ok"),
		cancel: message("console.dialog.cancel"),
		onOk: function() {
			layer.load();
			$.ajax({
				url: "${base}/console/timeCard/deleteCard.ct",
				type: "POST",
				data: {
					id:cardId
				},
				dataType: "json",
				cache: false,
				success: function(message) {
					layer.closeAll('loading');
					$.message(message);
					if (message.type == "success") {
						$.message("success", "操作成功！");
						showCardDiv(id,name,dictStudentId,dictStudentName);
					}
				}
			});
		}
	});
}

//操作改变卡的状态
function cardChangeStatus(cardId,status){
	if(status=="normal"){
		var normalCount = $("#normalCount").val();
		if(normalCount>0){
			$.message("warn", "当前学生存在正常状态卡!");
			return false;
		}
	}
	$.ajax({
		type:"GET",
		url:"${base}/console/timeCard/cardChangeStatus.ct",
		data:{
			carId:cardId,
			status:status
		},
		dataType:"json",
		success:function(){
			var studentId = $("#studentId").html();
			var name = $("#cardDivTitle").html();
			$.message("warn", "操作成功!");
			showCardDiv(studentId,name);
		}
	});
}

//静态化毕业相册
function staticGraduationAlbum(id){
	$.ajax({
		type: "GET",
		url: "${base}/console/dict_student/buildDictStudent.ct",
		data: {
		    id:id
		},
		dataType: "json",
		success:function(data){
			if(data=="success"){
			  $.message("warn", "操作成功!");
			}
		}
	});
}

//图片放大
//function showBigImge(url){
//	var content= 
//	'<div>'+
//	'<img src="'+url+'"  width="300" />'+
//	'</div>';
//	layer.open({
//	    type: 1,
//	    title: false,
//	    area: '300px',
//	    shift:1,
//	    skin: 'layui-layer-demo', //样式类名
//	    closeBtn: true, //不显示关闭按钮
//	    shift: 2,
//	    shadeClose: true, //开启遮罩关闭
//	    content: content
//	});
//}

//获取批量更新模板中需要下载的数据 
function card4Student(){
    var form = $("<form>");  
	form.attr('style','display:none');  
	form.attr('target','');  
	form.attr('method','GET');  
	form.attr('action','${base}/console/excel/card4Student.ct');  
	  
	var input1 = $('<input>');  
	input1.attr('type','hidden');  
	input1.attr('name','fileName');  
	input1.attr('value',"card4Student.xls");  
	
    $('body').append(form);  
	form.append(input1);
	
	$('input[name="ids"]:checked').each(function(){  
	    input2 = $('<input>');  
	    input2.attr('type','hidden');  
	    input2.attr('name','ids');  
	    input2.attr('value',$(this).val());  
	    form.append(input2);    
	});
  
	form.submit();  
	form.remove();  
}

//获取批量生成数据的人员
function createData4Student(){
  var $checkedIds = $("#listTable input[name='ids']:enabled:checked");
  layer.load();
   $.ajax({
		url: "createData4Student.ct",
		type: "POST",
		data: $checkedIds.serialize(),
		dataType: "json",
		cache: false,
		success: function(message) {
			layer.closeAll('loading');
			$.message(message);
		}
	});
}


//获取家长详情(查看家长按钮屏蔽之后不会使用)
/*function getDetail(id){
	$("#showDetail").fadeIn();
	$.ajax({
		type: "GET",
		url: "showPatriarchDetail.ct",
		data: {
		    id:id
		},
		dataType: "json",
		success:function(memberMap){
			var content = "";
			for(var i=0;i<memberMap.length;i++){
			    var record = memberMap[i];
			    var realName = record.realName;
			    var mobile = record.mobile;
			    var cardNum = record.cardNum;
			    if(cardNum == undefined){
			    	cardNum = "";
			    }
		    	content+="<tr><td>"+realName+"</td>";
			    content+="<td>"+mobile+"</td>";
			    content+="<td>"+cardNum+"</td>";
			    content+="</tr>";
			}
			var tbody = $("#detailBody");
			tbody.html(content);
			mergeSameCell(document.getElementById('patriarchList'),1,0,[0,1]);
			dealTdVertical();
		}
	});
}*/

//关闭家长详情(查看家长按钮屏蔽之后不会使用)
/*function closeDetail(){
	$("#showDetail").fadeOut();
}*/

//处理bootstrap(默认是这个vertical-align:top) 合并单元格之后的td内容不居中
//(查看家长按钮屏蔽之后不会使用)
/*function dealTdVertical(){
	var $tds = $("#detailBody td");
	$tds.each(function(){
		var $this = $(this);
		if(typeof($this.attr("rowspan"))!="undefined"){
			$this.css("vertical-align","middle");
		}
	}); 
}*/
</script>
</head>
<body>
<body class="fixed-navigation">
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
                    <h2>${message("console.dictStudent.list")}</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                           <strong>${message("console.dictStudent.list")} <span>(${message("console.page.total", page.total)})</span></strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">
                
                </div>
            </div>
	       	<!-- end 头部面包屑区域 -->
	       
	        <!-- start 中间内容部分 -->
	        <div class="wrapper wrapper-content animated fadeIn">
        		<form id="listForm" action="list.ct" method="get">
             	<!-- start  学生列表管理 -->
             	<div class="row">
           	 		<div class="col-lg-14">
                    	<div class="ibox float-e-margins">
                            <div class="ibox-content">
                                <div class="row">
                                    <div class="col-sm-14 m-b-xs">
                                    	<div class="btn-group">
	                                       	[@shiro.hasPermission name = "console:addDictStudent"]
	                                        <a href="add.ct" class="btn btn-primary">
												<span class="addIcon">&nbsp;</span>${message("console.common.add")}
											</a>
										   	[/@shiro.hasPermission]
	                                        [@shiro.hasPermission name = "console:deleteDictStudent"]
												<a href="javascript:;" id="deleteButton" class="btn btn-primary disabled">
													<span class="deleteIcon">&nbsp;</span>${message("console.common.delete")}
												</a>
											[/@shiro.hasPermission]
											<a href="javascript:;" id="refreshButton" class="btn btn-primary">
												<span class="refreshIcon">&nbsp;</span>${message("console.common.refresh")}
											</a>
											<div class="btn-group">
		                                        <button data-toggle="dropdown" class="btn btn-primary dropdown-toggle" aria-expanded="false">${message("console.page.pageSize")} <span class="caret"></span>
		                                        </button>
		                                        <ul class="dropdown-menu" id="pageSizeOption">
													<li>
														<a href="javascript:;"[#if page.pageSize == 10] class="current"[/#if] val="10">10</a>
													</li>
													<li>
														<a href="javascript:;"[#if page.pageSize == 20] class="current"[/#if] val="20">20</a>
													</li>
													<li>
														<a href="javascript:;"[#if page.pageSize == 50] class="current"[/#if] val="50">50</a>
													</li>
													<li>
														<a href="javascript:;"[#if page.pageSize == 100] class="current"[/#if] val="100">100</a>
													</li>
												</ul>
	                                       	</div>
	                                       	<a onClick="createData4Student()" class="btn btn-primary">
												<span class="addIcon">&nbsp;</span>${message("一键生成数据")}
											</a>
											[@shiro.hasPermission name = "console:addDictStudent"]
	                                   		<a href="upload.ct?type=dictStudent" class="btn btn-primary">
												<span class="addIcon">&nbsp;</span>${message("批量上传头像")}
											</a>
											[/@shiro.hasPermission]
											[@shiro.hasPermission name = "console:exportDictStudent"]
											<div class="btn-group" role="group">
		                                        <button data-toggle="dropdown" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
		                                        	${message("导出学生信息")} 
		                                        	<span class="caret"></span>
		                                        </button>
		                                        <ul class="dropdown-menu">
													<li>
														<a href="javascript:;" id="searchExportButton">搜索导出</a>
													</li>
													<li>
														<a href="javascript:;" id="exportButton">选择导出</a>
													</li>
												</ul>
	                                       	</div>
											[/@shiro.hasPermission]
										</div>
										<div class="input-group pull-right">
											<form action="list.ct" method="get">
												<select id="search_class" name="dictClass" class="btn-white dropdown-toggle" style="height: 30px;width: 83px;margin-right: 1px;">
	                                            	 <option value="">
	                                                 	${message("搜索班级")}
	                                                 </option>
	                                                 [#list dictClasses as dictClass]
	                                                    <option value="${dictClass.id}" [#if returnDictClass=="${dictClass.id}"] selected="selected" [/#if]>${dictClass.name}</option>
	                                                 [/#list]
	                                            </select>
												<input type="text" name="studentName" value="${studentName}" class="input-sm form-control" style="width:100px;margin-top: 12px;" placeholder="搜索学生姓名">
												<input type="text" name="studentNo" value="${studentNo}" class="input-sm form-control" style="width:150px;margin-top: 12px;" placeholder="搜索学生学号">
												<input type="submit" class="btn btn-primary" value="搜索"/>
											</form>
										</div>
                                    </div>
                                </div>
                                <div class="row">
                                	<div class="col-sm-14 m-b-xs">
                                		<div class="btn-toolbar" role="toolbar" aria-label="...">
		                                    <div class="btn-group">
												<a href="${base}/console/excel/downloadExcel.ct?fileName=memberStu.xls" class="btn btn-primary">
													<span class="addIcon">&nbsp;</span>${message("下载学生模版")}
												</a>
		                                    </div>
		                                    <div class="btn-group" style="margin-left:0px;margin-top:10px;">
		                                    	[@shiro.hasPermission name = "console:addDictStudent"]
												<input type="file" id="batchSaveStudentUpload" class="btn btn-primary" style="margin-top:10px;"/>
												[/@shiro.hasPermission]
											</div>
		                                    [@shiro.hasPermission name = "console:addTeacher"]
		                                    <div class="btn-group" style="margin-left:10px;">
												<a onClick="card4Student()" class="btn btn-primary">
													<span class="addIcon">&nbsp;</span>${message("下载卡号更新模板")}
												</a>
		                                    </div>
		                                    <div class="btn-group" style="margin-left:0px;margin-top:10px;">
		                                    	<input type="file" id="batchSaveCardUpload" class="btn btn-primary" style="margin-top:10px;"/>
	                                    	</div>
		                                	[/@shiro.hasPermission]
	                                	</div>
                                	</div>
                                </div>
                                <div class="table-responsive">
                                     <div class="table-responsive">
	                                     <table id="listTable" class="table table-striped">
												<tr>
													<th class="check">
														<input type="checkbox" id="selectAll" />
													</th>
													<th style="width:80px;">
														<a href="javascript:;" class="sort" name="dictClass">${message("DictStudent.dictClass")}</a>
													</th>
													<th style="width:130px;">
														<a href="javascript:;" class="sort" name="studentNo">${message("DictStudent.studentNo")}</a>
													</th>
													<th style="width:100px;">
														<a href="javascript:;" class="sort" name="studentName">${message("DictStudent.studentName")}(${message("DictStudent.gender")})</a>
													</th>
													<!--<th>
														<a href="javascript:;" class="sort" name="gender">${message("DictStudent.gender")}</a>
													</th>
													<th>
														<a href="javascript:;" class="sort" name="birthday">${message("DictStudent.birthday")}</a>
													</th> -->
													<th style="width:60px;">
														<a href="javascript:;" class="sort" name="studentStatus">${message("DictStudent.studentStatus")}</a>
													</th>
												<!--	<th>
														<a href="javascript:;" class="sort" name="stuDate">${message("DictStudent.stuDate")}</a>
													</th>
													<th>
														<a href="javascript:;" class="sort" name="stuAddress">${message("DictStudent.stuAddress")}</a>
													</th> -->
													<th style="width:80px;">
														<a href="javascript:;" class="sort" name="stuAddress">${message("DictStudent.photo")}</a>
													</th>
													<th style="text-align: center; width:260px;">
														<a href="javascript:;"  name="patriarchInfo">${message("DictStudent.patriarchInfo")}</a>
													</th>
													<th style="width:100px;">
														<a href="javascript:;" class="sort" name="createDate">${message("console.common.createDate")}</a>
													</th>
													<th style="width:160px;">
														<span>${message("console.common.handle")}</span>
													</th>
												</tr>
												[#list page.content as dictStudent]
													<tr>
														<td>
															<input type="checkbox" name="ids" value="${dictStudent.id}" />
														</td>
														<td>
															${dictStudent.dictClass.name}
														</td>
														<td>
															${dictStudent.studentNo}
														</td>
														<td>
															${dictStudent.studentName}
															[#if dictStudent.gender ??]
														    (${message("DictStudent.gender.${dictStudent.gender}")})
														    [/#if]
														</td>
														<!--<td>
															[#if dictStudent.gender ??]
														    ${message("DictStudent.gender.${dictStudent.gender}")}
														    [/#if]
														</td>
														<td>  
														    [#if dictStudent.birthday??]
															    ${dictStudent.birthday?string("yyyy-MM-dd")}
															[#else]
															    -
															[/#if]
														</td> -->
														<td>
															[#if dictStudent.studentStatus=="active"]
															    ${message("console.dictStudent.status.active")}
															[#elseif dictStudent.studentStatus=="graduated"]
																${message("console.dictStudent.status.graduated")}
															[#elseif dictStudent.studentStatus=="quit"]
																${message("console.dictStudent.status.quit")}
															[#elseif dictStudent.studentStatus=="dropouts"]
															    ${message("console.dictStudent.status.dropouts")}
															[/#if]
														</td>
													<!--	<td>
															${dictStudent.stuDate}
														</td>
														<td>
															${dictStudent.stuAddress}
														</td> -->
														<td>
														    [#if dictStudent.iconPhoto??]
																<a href="javscript:;" onclick='showBigImge("${dictStudent.iconPhoto}")'>
																	<img class="img_plus" src="${dictStudent.iconPhoto}" height="40"/>
																</a>
															[#else]
															    <a href="javscript:;" onclick='showBigImge("${setting.defaultImage}")'>
																	<img class="img_plus" src="${setting.defaultImage}" height="40"/>
																</a>
															[/#if]
														</td>
														<td style="padding:0;border-left:1px solid #ddd;border-right:1px solid #ddd;">
														[#if dictStudent.patriarchStudentMap?? && dictStudent.patriarchStudentMap?size > 0]
															<table id="patriarchInfo" class="table" style="margin-bottom:0px;">
																[#list dictStudent.patriarchStudentMap as patriarchStudent]
																<tr [#if patriarchStudent_index == 0]style="border-top-style: hidden;"[/#if]>
																	<td style="width:80px;">
																		${patriarchStudent.member.realName}
																	</td>
																	<td style="width:100px;">
																		${patriarchStudent.member.mobile}
																	</td>
																	<td style="width:80px;">
																		${message("Patriarch.count")}
																		<a href="#" onclick="showCardDiv(${patriarchStudent.member.id},'${patriarchStudent.member.realName}','${dictStudent.id}','${dictStudent.studentName}')">
																			(${patriarchStudent.member.timeCards?size})
																		</a>
																	</td>
																</tr>
																[/#list]
															</table>
                                                        [#else]
                                                            ${message("DictStudent.noPatriarch")}
                                                        [/#if]
														</td>
														<td>
															<span title="${dictStudent.createDate?string("yyyy-MM-dd HH:mm:ss")}">${dictStudent.createDate}</span>
														</td>
														<td>
														[@shiro.hasPermission name = "console:editDictStudent"]
															<a href="edit.ct?id=${dictStudent.id}">[${message("console.common.edit")}]</a>
															<a href="staticEdit.ct?id=${dictStudent.id}">[${message("制作毕业相册")}]</a>
															<!--<a href="#" onclick="staticGraduationAlbum(${dictStudent.id})">[${message("静态化毕业相册")}]</a>-->
														[/@shiro.hasPermission]
														</td>
													</tr>
												[/#list]
											</table>
											[@pagination pageNumber = page.pageNumber totalPages = page.totalPages]
												[#include "/console/include/pagination.ftl"]
											[/@pagination]
	                                </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
             	<!-- end 学生列表管理 -->
             	<!-- start 家长详情展示区 -->
                <!--<div id="showDetail" class="modal in" style="overflow: auto; display: none;" tabindex="-1" aria-hidden="false">
                    <div class="modal-backdrop  in">
                    </div>
                    <div class="modal-dialog">
                        <div class="modal-content marginTop">
                            <div class="modal-body ui-front">
                                <a onclick="closeDetail()" type="button" class="close" data-dismiss="modal"  aria-hidden="true">
                                    ×
                                </a>
                                <table class="table table-striped" id="patriarchList">
                                    <thead>
                                        <tr>
                                            <th>${message("姓名")}</th>
                                            <th style="width:200px;">${message("手机号码")}</th>
                                            <th>${message("卡号")}</th>
                                        </tr>
                                    </thead>
                                    <tbody id="detailBody">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>-->
                <!-- end 家长详情展示区 -->
            	<!--start 卡号详情展示区 -->
		       	<div id="cardDiv" class="modal in" style="overflow: auto; display: none;" tabindex="-1" aria-hidden="false">
		       		<div class="modal-backdrop in" onclick="closeCardDiv()"></div>
				    <div class="modal-dialog">
				        <div class="modal-content">
				            <div class="modal-header">
				                <a type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeCardDiv()">
				                    ×
				                </a>
				                <h4 class="modal-title">
				                	<input type="hidden" id="patriarchId" value=""/> 
				                    <a id="cardDivTitle"></a>的卡号列表:
				                </h4>
				            </div>
				            <div class="modal-body ui-front">
	            	 			<table id="cardsTable" class="table table-striped">
		            	 		</table>
		            	 		<h3 class="modal-title" style="border-top: solid 1px lightgray;margin-top: 10px;padding-top: 10px;padding-bottom: 10px;">
				                    添加卡号：(关联<span id="dictStudentName"></span>同学)
				                    <input type="hidden" id="dictStudentId" value=""/>
				                </h3>
				               	<div class="input-group" style="width:100%;margin-bottom: -30px;">
				               		<table class="table table-striped">
				               			<tr>
				               				<td><label>卡号:</label></td>
				               				<td>
				               					<input class="form-control" id="cardNumber"/>
			               					</td>
				               				<td>
				               					<button onclick="submitCard()" id="addCardBUtton" class="btn btn-sm btn-primary" >确认</button>
		               						</td>
				               			</tr>
				               		</table>
				               	</div>
				            </div>
				        </div>
				    </div>
				</div>
                <!-- end 卡号详情展示区 -->
             	</form>
	        </div>
	       <!-- end 中间内容部分-->
	       [#include "/console/include/footer.ftl" /]
  </div>
</div>
</body>
</html>