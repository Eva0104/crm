<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EricCRM</title>
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

    <%@include file="../include/mainHeader.jsp"%>
    <%@include file="../include/leftSide.jsp"%>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                员工管理
            </h1>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box primary">
                <div class="box-header with-border">
                    <h3>员工列表</h3>
                    <div class="box-tools pull-right">
                        <a href="javaScript:;" id="addBtn" class="btn btn-success btn-xs"><i class="fa fa-plus"></i> 新增</a>
                    </div>
                </div>

                <div class="box-body">
                    <table class="table" id="userTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>账号</th>
                                <th>员工姓名</th>
                                <th>微信号</th>
                                <th>角色</th>
                                <th>状态</th>
                                <th>创建时间</th>
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

<div class="modal fade" id="addModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增用户</h4>
            </div>
            <div class="modal-body">
                <form id="addForm">
                    <div class="form-group">
                        <label>账号(用于系统登录)</label>
                        <input class="form-control" type="text" name="username">
                    </div>
                    <div class="form-group">
                        <label>员工姓名(真实姓名)</label>
                        <input class="form-control" type="text" name="realname">
                    </div>
                    <div class="form-group">
                        <label>密码(默认为000000)</label>
                        <input class="form-control" type="text" name="password" value="000000">
                    </div>
                    <div class="form-group">
                        <label>微信号</label>
                        <input class="form-control" type="text" name="weixin">
                    </div>
                    <div class="form-group">
                        <label>角色</label>
                        <select class="form-control" name="roleid">
                            <c:forEach items="${roleList}" var="role">
                            <option value="${role.id}">${role.rolename}</option>
                            </c:forEach>
                        </select>
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

<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/plugins/dataTables/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>
<script src="/static/plugins/moment/moment.js"></script>
<script src="/static/plugins/validate/jquery.validate.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>

<script>
    $(function(){
        var dataTable = $("#userTable").DataTable({
            serverSide:true,
            ajax:"/admin/users/load",
            ordering:false,
            "autoWidth": false,
            columns:[
                {"data":"id"},
                {"data":"username"},
                {"data":"realname"},
                {"data":"weixin"},
                {"data":"role.rolename"},
                {"data":function(row){
                    if(row.enable){
                        return "<span class='lable lable-success'>正常</span>";
                    }else{
                        return "<span class='lable lable-success'>禁用</span>";
                    }
                }},
                {"data":function(row){
                    var timeStemp = row.creattime;
                    var date = moment(timeStemp);
                    return date.format("YYYY-MM-DD HH:mm");
                }},
                {"data":function(row){
                    return "#";
                }}
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

        $("#addForm").validate({
            errorElemrnt:"span",
            errorClass:"text-danger",
            rules:{
                username:{
                    required:true,
                    rangelength:[3,18],
                    remote:"/admin/users/checkUsername"
                },
                realname:{
                    required:true,
                    rangelength:[2,18]
                },
                password:{
                    required:true,
                    rangelength:[6,18]
                },
                weixin:{
                    required:true
                }
            },
            messages:{
                username:{
                    required:"请输入用户名",
                    rangelength:"用户名长度为3~18位",
                    remote:"该用户名已被占用"
                },
                realname:{
                    required:"请输入员工真实姓名",
                    rangelength:"真实姓名长度为2~18位"
                },
                password:{
                    required:"请输入密码",
                    rangelength:"密码长度为6~18位"
                },
                weixin:{
                    required:"请输入微信号"
                }
            },
            submitHandler:function(form){
                $.post("/admin/users/new",$(form).serialize()).done(function(data){
                    if(data == "success"){
                        $("#addModal").modal("hide");
                        dataTable.ajax.reload();
                    }
                }).fail(function(){
                    alert("请求服务器异常！");
                })
            }
        });

        $("#saveBtn").click(function(){
            $("#addForm").submit();
        });

        $("#addBtn").click(function(){
            $("#addModal").modal({
                show:true,
                backdrop:'static',
                keyboard:false
            });
        });
    });
</script>

</body>
</html>


