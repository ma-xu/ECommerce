<!DOCTYPE html>
<html>
<head>
[#if invitationCode]
<title>${dictClassName}班级的邀请码</title>
[#else]
<title>无效邀请码</title>
[/#if]
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="福州盛云汇" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width,height=device-height" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<link href="${base}/resources/front/css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <!--页眉开始-->
    <div id="header">
    </div>
    <div id="content">
        <div class="main_get">
            <img src="${base}/resources/front/images/pre_get_bg.png"/>
            <div class="red_envelope_amount_bg">
                <img src="${base}/resources/front/images/code.png"/>
                [#if invitationCode]
	                <div class="invitation"><span>${invitationCode}</span></div>
                [#else]
				    <div class="invitation"><span>无效邀请码</span></div>
				[/#if]
				<div class="tips"><span>${dictClassName}班级的邀请码</span></div>
                <div class="center_get">
	                <a href="http://a.app.qq.com/o/simple.jsp?plg_nld=1&plg_auth=1&plg_vkey=1&plg_usr=1&plg_uin=1&pkgname=com.sammyun.xiaoshutong&plg_dev=1&plg_nld=1"><div class="button"><span>下载使用</span></div></a>
	            </div>
            </div>
        </div>
    </div>
    <!--页脚开始-->
	<div id="footer">
	</div>
	<!--页脚结束-->
</body>
</html>