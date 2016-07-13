<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EricCRM-客户管理</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/static/plugins/fontawesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <!-- Theme style -->
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">

    <link rel="stylesheet" href="/static/dist/css/skins/skin-blue.min.css">

    <link rel="stylesheet" href="/static/plugins/dataTables/css/dataTables.bootstrap.min.css">

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <%@include file="../include/mainHeader.jsp"%>
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="customer"/>
    </jsp:include>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                客户管理
            </h1>
        </section>

        <!-- Main content -->
        <section class="content">

            <div class="box primary">
                <div class="box-header with-border">
                    <h3>我的客户列表</h3>
                    <div class="box-tools pull-right">
                        <a href="javaScript:;" id="addBtn" class="btn btn-success btn-xs"><i class="fa fa-plus"></i> 新增</a>
                    </div>
                </div>

                <div class="box-body">
                    <table class="table" id="customerTable">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>客户名称</th>
                            <th>联系方式</th>
                            <th>微信号</th>
                            <th>电子邮箱</th>
                            <th>地址</th>
                            <th>等级</th>
                            <th>创建时间</th>
                            <th>公司名称</th>
                            <th>#</th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>
        </section>
    </div>
</div>

<%--addModal--%>
<div class="modal fade" id="addModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增客户</h4>
            </div>
            <div class="modal-body">
                <form id="addForm">
                    <div class="form-group">
                        <label>客户名称</label>
                        <input class="form-control" type="text" name="name">
                    </div>
                    <div class="form-group">
                        <label>联系方式</label>
                        <input class="form-control" type="text" name="tel">
                    </div>
                    <div class="form-group">
                        <label>地址</label>
                        <input class="form-control" type="text" name="address">
                    </div>
                    <div class="form-group">
                        <label>微信号</label>
                        <input class="form-control" type="text" name="weixin">
                    </div>
                    <div class="form-group">
                        <label>电子邮箱</label>
                        <input type="text" class="form-control" name="email">
                    </div>
                    <div class="form-group">
                        <label>所属公司</label>
                        <input type="text" class="form-control" name="companyname">
                    </div>
                    <div class="form-group">
                        <label>等级</label>
                        <input type="text" class="form-control" name="level">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 2.2.3 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>

<script src="/static/plugins/validate/jquery.validate.js"></script>
<script src="/static/plugins/dataTables/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>
<script src="/static/plugins/moment/moment.js"></script>

<script>
    $(function(){
        var dataTable = $("#customerTable").DataTable({
            serverSide:true,
            ajax:"/customer/list",
            ordering:false,
            "autoWidth": false,
            columns:[
                {"data":"id"},
                {"data":"name"},
                {"data":"tel"},
                {"data":"weixin"},
                {"data":"email"},
                {"data":"address"},
                {"data":"level"},
                {"data":function(row){
                    var timeStemp = row.creattime;
                    var date = moment(timeStemp);
                    return date.format("YYYY-MM-DD HH:mm");
                }},
                {"data":"companyname"}
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
        });


        $("#addBtn").click(function(){
            $("#addModal").modal({
                show:true,
                dropback:'static'
            });
        });

        $("#addForm").validate({
            errorElemrnt:"span",
            errorClass:"text-danger",
            rules:{
                name:{
                    required:true
                },
                tel:{
                    required:true
                },
                address:{
                    required:true
                },
                weixin:{
                    required:true
                }
            },
            messages:{
                name:{
                    required:"请输入客户名称",
                    remote:"该客户已存在"
                },
                tel:{
                    required:"请输入客户联系方式"
                },
                address:{
                    required:"请输入客户地址"
                },
                weixin:{
                    required:"请输入微信号"
                }
            },
            submitHandler:function(form){
                $.post("/customer/new",$(form).serialize()).done(function(data){
                    if(data == "success"){
                        $("#addModal").modal("hide");
                        location.reload();
                    }
                }).fail(function(){
                    alert("请求服务器异常！");
                })
            }
        });

        $("#saveBtn").click(function(){
            $("#addForm").submit();
        });



    })


</script>

</body>
</html>

