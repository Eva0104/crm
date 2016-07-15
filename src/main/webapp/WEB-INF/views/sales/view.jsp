<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EricCRM-进度管理-${sales.name}</title>
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

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <%@include file="../include/mainHeader.jsp"%>
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="sales"/>
    </jsp:include>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>　</h1>
            <ol class="breadcrumb">
                <li><a href="/customer"><i class="fa fa-dashboard"></i>进度管理</a></li>
                <li class="active">${sales.name}</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box primary">
                <div class="box-header">
                    <h3 class="box-title">
                        ${sales.name}
                    </h3>
                    <div class="box-tools">
                        <shiro:hasRole name="经理">
                            <button class="btn btn-danger btn-xs" id="openCust">删除进度</button>
                        </shiro:hasRole>
                    </div>
                </div>
                <div class="box-body">
                    <table class="table">
                        <tr>
                            <td style="width: 100px">关联客户:</td>
                            <td style="width: 200px">${sales.custname}</td>
                            <td style="width: 100px">金额:</td>
                            <td style="width: 200px">￥${sales.price}</td>
                        </tr>
                        <tr>
                            <td style="width: 100px">当前进度：</td>
                            <td style="width: 200px">${sales.progress}&nbsp;<a href="">修改</a></td>
                            <td style="width: 100px">最后跟进时间：</td>
                            <td colspan="4">${sales.lasttime}</td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="row">
                <div class="col-md-8">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-list"></i> 跟进记录</h3>
                            <div class="box-tools">
                                <button class="btn btn-success btn-xs"><i class="fa fa-plus"></i>新增记录</button>
                            </div>
                        </div>
                        <div class="box-body">
                            <ul class="timeline">
                                <li>>
                                    <i class="fa fa-envelope bg-blue"></i>
                                    <div class="timeline-item">
                                        <span class="time"><i class="fa fa-weixin"></i> 12:05</span>

                                        <h3 class="timeline-header"><a href="#">微信</a> ...</h3>
                                    </div>
                                </li>
                                <li>>
                                    <i class="fa fa-weixin bg-blue"></i>
                                    <div class="timeline-item">
                                        <span class="time"><i class="fa fa-clock-o"></i> 12:05</span>

                                        <h3 class="timeline-header"><a href="#">Support Team</a> ...</h3>
                                    </div>
                                </li>

                                <li>
                                    <i class="fa fa-clock-o bg-gray"></i>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="box box-default collapsed-box">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-file-o"></i> 相关资料</h3>
                            <div class="box-tools">
                                <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"><i class="fa fa-plus"></i></button>
                            </div>
                        </div>
                        <div class="box-body" style="text-align: center">
                        </div>
                    </div>

                    <div class="box box-default">
                        <div class="box-header with-border">
                            <h3 class="box-title"><a class="fa fa-calendar-check-o"></a> 待办事项</h3>
                        </div>
                        <div class="box-body">
                            <h5>暂无待办事项</h5>
                        </div>
                    </div>
                </div>

            </div>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</div>
<!-- ./wrapper -->

<%--转移Modal--%>
<div class="modal fade" id="moveModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">转移客户</h4>
            </div>
            <div class="modal-body">
                <form id="moveForm" action="/customer/moveCustomer" method="POST">
                    <input type="hidden" value="${customer.id}" name="id">
                    <div class="form-group">
                        <label>把客户转移给的同事名字</label>
                        <select class="form-control" name="userid">
                            <c:forEach items="${userList}" var="user">
                                <option value="${user.id}">${user.realname}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="moveBtn">保存</button>
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
<script>
    $(function(){

        //公开客户
        $("#openCust").click(function(){
            if(confirm("确认要公开吗？")){
                var id = ${customer.id};
                window.location.href = "/customer/open/"+id;
            }
        });

        //转移客户
        $("#moveCust").click(function(){
            if(confirm("确认转移客户吗？")){
                $("#moveModal").modal({
                    show:true,
                    backdrop:'static'
                });
            }
        });

        $("#moveBtn").click(function(){
            $("#moveForm").submit();
        });


    })
</script>

</body>
</html>

