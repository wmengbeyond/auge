<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>奥格 | 登录</title>
	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<!--icon-->
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/common/favicon.ico" media="screen"/>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/model/login/login.css">

	<link rel="stylesheet" href="${pageContext.request.contextPath}/common/libs/font-awesome/css/font-awesome.min.css">
	<!-- Ionicons -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/common/libs/ionicons/css/ionicons.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/adminlte/dist/css/AdminLTE.min.css">
	<!-- iCheck -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/adminlte/plugins/iCheck/square/red.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/adminlte/plugins/bootstrap-validator/dist/css/bootstrap-validator.css"/>
	<script src="${pageContext.request.contextPath}/common/libs/html5shiv/html5shiv.min.js"></script>
	<script src="${pageContext.request.contextPath}/common/libs/respond/respond.min.js"></script>
</head>
<body class="hold-transition login-page" onLoad="document.forms.login_form.userName.focus()">
<div class="login-box">
	<div class="login-logo">
		<a href="#">后台管理系统</a>
	</div>
	<!-- /.login-logo -->
	<div class="login-box-body">
		<%--<p class="login-box-msg">用  户  登  陆</p>--%>
		<form id="login_form" name="login_form">
			<div class="form-group has-feedback">
				<input type="text" class="form-control" id="userName" name="userName" placeholder="请输入登录名">
				<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
			</div>
			<div class="form-group has-feedback">
				<input type="password" class="form-control" id="password" name="password" placeholder="请输入密码">
				<span class="glyphicon glyphicon-lock form-control-feedback"></span>
			</div>
			<div class="row">
				<div class="col-xs-9">
					<input type="text" id="checkCode" class="form-control" placeholder="验证码" name="checkCode">
				</div>
				<div class="col-xs-3">
					<div class="pull-right">
						<img id="checkCodeImg" alt="checkCodeImg" src="account/checkCode/1">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-6">
					<div class="checkbox icheck">
						<label>
							<input type="checkbox" name="rememberMe"> 记住用户
						</label>
					</div>
				</div>
				<!-- /.col -->
				<div class="col-xs-6">
					<div class="checkbox pull-right">
						<a href="#">忘记密码</a>
						<span>&nbsp;/&nbsp;</span>
						<a href="register" class="text-center">注册</a>
					</div>
				</div>
				<!-- /.col -->
			</div>
			<div class="row">
				<div class="col-xs-12">
					<button type="submit" class="btn btn-danger btn-block btn-flat">登 录</button>
				</div>
			</div>
		</form>

		<div class="social-auth-links" style="margin-bottom: 0px;">
			<div class="row">
				<div class="col-xs-5">
					<div class="text-left" style="margin-top: 5px;">快速登录</div>
				</div>
				<div class="col-xs-7">
					<div class="text-right">
						<%--<a class="btn btn-social-icon btn-primary"><i class="fa fa-qq"></i></a>--%>
						<a class="btn btn-social-icon btn-success"><i class="fa fa-wechat"></i></a>
					</div>
				</div>
			</div>
			<!-- /.social-auth-links -->
		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->
</div>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/jquery-2.2.3.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/jquery.md5.js"></script>
    <!-- iCheck -->
    <script src="${pageContext.request.contextPath}/adminlte/plugins/iCheck/icheck.min.js"></script>

	<script>
		$(function() {
			validatorInit();
			refreshCheckCode();

            $('input').iCheck({
                checkboxClass: 'icheckbox_square-red',
                radioClass: 'iradio_square-red',
                increaseArea: '20%' // optional
            });

//            fillbackLoginForm();
		});

		// 刷新图形验证码
		function refreshCheckCode() {
			$('#checkCodeImg').click(function() {
				var timestamp = new Date().getTime();
				$(this).attr("src", "account/checkCode/" + timestamp)
			})
		}

		// 登陆信息加密模块
		function infoEncrypt(userName, password, checkCode) {
			var str1 = $.md5(password);
			var str2 = $.md5(str1 + userName);
			var str3 = $.md5(str2 + checkCode.toUpperCase());
			return str3;
		}

		function validatorInit() {
			$('#login_form').bootstrapValidator({
				message : 'This value is not valid',
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					userID : {
						validators : {
							notEmpty : {
								message : '用户名不能为空'
							},regexp: {
		                        regexp: '[0-9]+',
		                        message: '只允许输入数字'
		                    },
							callback : {}
						}
					},
					password : {
						validators : {
							notEmpty : {
								message : '密码不能为空'
							},
							callback : {}
						}
					},
					checkCode : {
						validators : {
							notEmpty : {
								message : '验证码不能为空'
							}
						}
					}
				}
			})
			.on('success.form.bv', function(e) {
				// 禁用默认表单提交
				e.preventDefault();

				// 获取 form 实例
				var $form = $(e.target);
				// 获取 bootstrapValidator 实例
				var bv = $form.data('bootstrapValidator');

				// 发送数据到后端 进行验证
				var userName = $('#userName').val();
				var password = $('#password').val();
				var checkCode = $('#checkCode').val();

				// 加密
				password = infoEncrypt(userName, password, checkCode)

				var data = {
					"userName" : userName,
					"password" : password,
				}
				$.ajax({
					type:"POST",
					url:"account/login",
					dataType:"json",
					contentType:"application/json",
					data:JSON.stringify(data),
					success:function(response){
						// 接收到后端响应

						// 分析返回的 JSON 数据
						if(response.result == 'error'){
							var errorMessage;
							var field;
							if(response.msg == "unknownAccount"){
								errorMessage = "用户名错误";
								field = "userName";
							}
							else if(response.msg == "incorrectCredentials"){
								errorMessage = "密码或验证码错误";
								field = "password";
								$('#password').val("");
							}else{
							    errorMessage = "服务器错误";
                                field = "password";
                                $('#password').val("");
							}

							// 更新 callback 错误信息，以及为错误对应的字段添加 错误信息
							bv.updateMessage(field,'callback',errorMessage);
							bv.updateStatus(field,'INVALID','callback');
							bv.updateStatus("checkCode",'INVALID','callback');

							$('#checkCodeImg').attr("src","account/checkCode/" + new Date().getTime());
							$('#checkCode').val("");
						}else{
							// 页面跳转
							window.location.href = "/WMS-1.0/";
						}
					},
					error:function(data){
						// 处理错误
					}
				});
			});
		}
        //使用本地缓存记住用户名密码
        function rememberMe(rm_flag){
            //remember me
            if(rm_flag){
                localStorage.userName=$("input[name='userName']").val();
                localStorage.password=$("input[name='password']").val();
                localStorage.rememberMe=1;
            }
            //delete remember msg
            else{
                localStorage.userName=null;
                localStorage.password=null;
                localStorage.rememberMe=0;
            }
        }

        //记住回填
        function fillbackLoginForm(){
            if(localStorage.rememberMe&&localStorage.rememberMe=="1"){
                $("input[name='userName']").val(localStorage.userName);
                $("input[name='password']").val(localStorage.password);
                $("input[name='rememberMe']").iCheck('check');
                $("input[name='rememberMe']").iCheck('update');
            }
        }
	</script>

<%--<script type="text/javascript"> document.getElementById("userName").focus(); </script>--%>
</body>
</html>