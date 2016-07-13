<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EricCRM-新增公告</title>
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
    <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
          page. However, you can choose any other skin. Make sure you
          apply the skin class to the body tag so the changes take effect.
    -->
    <link rel="stylesheet" href="/static/dist/css/skins/skin-blue.min.css">
    <link rel="stylesheet" type="text/css" href="/static/plugins/simditor/styles/simditor.css" />


</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <%@include file="../include/mainHeader.jsp"%>
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="notice"/>
    </jsp:include>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1> 发布公告</h1>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">新增公告</h3>
                </div>
                <div class="box-body">
                    <form id="newForm" method="post">
                        <div class="form-group">
                            <label>标题</label>
                            <input class="form-control" type="text" name="title" id="title">
                        </div>
                        <div class="form-group">
                            <label>公告内容</label>
                            <textarea class="form-control" rows="10" type="text" name="context" id="context"></textarea>
                        </div>
                    </form>
                </div>

                <div class="box-footer">
                    <button class="btn btn-primary pull-right" id="saveBtn">发表</button>
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

<script type="text/javascript" src="/static/plugins/simditor/scripts/module.js"></script>
<script type="text/javascript" src="/static/plugins/simditor/scripts/hotkeys.js"></script>
<script type="text/javascript" src="/static/plugins/simditor/scripts/uploader.js"></script>
<script type="text/javascript" src="/static/plugins/simditor/scripts/simditor.js"></script>


<script>
    $(function(){
        var edit = new Simditor({
            textarea:$("#context"),
            placeholder: '在此处编辑公告内容',
            upload:{
                url:'/notice/img/load',
                fileKey:'file'
            }
        });

        $("#saveBtn").click(function(){
            if(!$("#title").val()){
                $("#title").focus();
                return;
            }
            if(!$("#context").val()){
                $("#context").focus();
                return;
            }

            $("#newForm").submit();
        });

    });
</script>

</body>
</html>

