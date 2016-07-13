<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EricCRM-密码设置</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">

    <link rel="stylesheet" href="/static/dist/css/skins/skin-blue.min.css">

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <%@include file="../include/mainHeader.jsp" %>
    <%@include file="../include/leftSide.jsp" %>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                密码设置
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                <li class="active">Here</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3>重置密码</h3>
                </div>

                <div class="box-body">
                    <form method="post" id="changPasswordForm">
                        <div class="form-group">
                            <label>旧密码</label>
                            <input type="text" class="form-control" name="oldpassword">
                        </div>
                        <div class="form-group">
                            <label>新密码</label>
                            <input type="text" class="form-control" name="newpassword" id="newpassword">
                        </div>
                        <div class="form-group">
                            <label>确认密码</label>
                            <input type="text" class="form-control" name="replypassword">
                        </div>
                    </form>
                </div>
                <div class="box-footer">
                    <button class="btn btn-primary" id="saveBtn">保存</button>
                </div>
            </div>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 2.2.3 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script src="/static/plugins/validate/jquery.validate.js"></script>

<script>
    $("#changPasswordForm").validate({
        errorElement: "span",
        errorClass: "text-danger",
        rules: {
            oldpassword: {
                required: true,
                remote:"/user/validate/password"
            },
            newpassword: {
                required: true,
                rangelength: [6,18]
            },
            replypassword: {
                required: true,
                rangelength: [6,18],
                equalTo: "#newpassword"
            }
        },
        messages: {
            oldpassword: {
                required: "请输入旧密码",
                remote:"密码错误"
            },
            newpassword: {
                required: "请输入新密码",
                rangelength: "密码长度为6~18位"
            },
            replypassword: {
                required: "请再次输入新密码",
                rangelength: "密码长度为6~18位",
                equalTo: "两次输入的新密码不一致，请确认"
            }
        },
        submitHandler: function (form) {
            var passowrd = $("#newpassword").val();
            $.post("/user/password", {"password": passowrd})
                    .done(function (data) {
                        if (data == "success") {
                            alert("密码修改成功！点击确定重新登录！");
                            window.location.href = "/";
                        }
                    }).fail(function () {
                        alert("请求服务器异常！")
                    })
        }
    });

    $("#saveBtn").click(function () {
        $("#changPasswordForm").submit();
    });
</script>

</body>
</html>

