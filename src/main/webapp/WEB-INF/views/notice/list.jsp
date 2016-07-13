<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EricCRM-公告</title>
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

    <link rel="stylesheet" href="/static/plugins/dataTables/css/dataTables.bootstrap.min.css">
    <![endif]-->
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <%@include file="../include/mainHeader.jsp"%>
    <%--<%@include file="../include/leftSide.jsp"%>--%>
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="notice"/>
    </jsp:include>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                公告
            </h1>

        </section>

        <!-- Main content -->
        <section class="content">

            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">公告列表</h3>
                    <shiro:hasRole name="经理">
                        <div class="box-tools pull-right">
                            <a href="/notice/new" class="btn-xs btn btn-success" ><i class="fa fa-pencil"></i>发布公告</a>
                        </div>
                    </shiro:hasRole>
                </div>
                <div class="box-body">
                    <table class="table" id="noticeTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>标题</th>
                                <th>公布时间</th>
                                <th>发布人</th>
                                <th>#</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
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

<script src="/static/plugins/dataTables/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>
<script src="/static/plugins/moment/moment.js"></script>
<script>
    $(function(){

        var dataTable = $("#noticeTable").DataTable({
            serverSide:true,
            ajax:"/notice/list",
            autoWidth: false,
            ordering:false,
            columns:[
                {"data":"id"},
                {"data":function(row){
                    return "<a href='/notice/"+row.id+"'>"+row.title+"</a>";
                }},
                {"data":function(row){
                    var timestemp = row.createtime;
                    var date = moment(timestemp);
                    return date.format("YYYY-MM-DD HH:mm");
                }},
                {"data":"realname"}
            ],
            "language": {
                "search": "请输入员工姓名或账号",
                "zeroRecords": "没有匹配的数据",
                "lengthMenu": "显示 _MENU_ 条数据",
                "info": "显示从 _START_ 到 _END_ 条数据 共 _TOTAL_ 条数据",
                "infoFiltered": "(从 _MAX_ 条数据中查询结果)",
                "loadingRecords": "加载中...",
                "processing": "处理中...",
                "paginate": {
                    "first": "首页",
                    "last": "末页",
                    "next": "下一页",
                    "previous": "上一页"

                }
            }
        })


    })

</script>


</body>
</html>


