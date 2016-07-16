<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EricCRM-客户管理-${customer.name}</title>
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

    <%@include file="../include/mainHeader.jsp" %>
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="customer"/>
    </jsp:include>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>　</h1>
            <ol class="breadcrumb">
                <li><a href="/customer"><i class="fa fa-dashboard"></i>客户管理</a></li>
                <li class="active">${customer.name}</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box primary">
                <div class="box-header">
                    <h3 class="box-title">
                        <c:choose>
                            <c:when test="${customer.type == 'person'}">
                                <i class="fa fa-user"></i>
                            </c:when>
                            <c:when test="${customer.type == 'company'}">
                                <i class="fa fa-bank"></i>
                            </c:when>
                        </c:choose>
                        ${customer.name}
                    </h3>
                    <div class="box-tools">
                        <c:if test="${not empty customer.userid}">
                            <button class="btn btn-danger btn-xs" id="openCust">公开客户</button>
                            <button class="btn btn-info btn-xs" id="moveCust">转移客户</button>
                        </c:if>
                    </div>
                </div>
                <div class="box-body">
                    <table class="table">
                        <tr>
                            <td style="width: 100px">联系电话:</td>
                            <td style="width: 200px">${customer.tel}</td>
                            <td style="width: 100px">微信:</td>
                            <td style="width: 200px">${customer.weixin}</td>
                            <td style="width: 100px">电子邮件:</td>
                            <td style="width: 200px">${customer.email}</td>
                        </tr>
                        <tr>
                            <td>等级</td>
                            <td>${customer.level}</td>
                            <td>地址</td>
                            <td colspan="3">${customer.address}</td>
                            <c:if test="${customer.type == 'person'}">
                        <tr>
                            <td>所属公司</td>
                            <td colspan="5"><a href='/customer/${customer.companyid}'>${customer.companyname}</a></td>
                        </tr>
                        </c:if>
                        <c:if test="${customer.type =='company'}">
                            <tr>
                                <td>公司关联人</td>
                                <c:forEach items="${customerList}" var="person">
                                    <td colspan="3"><a href="/customer/${person.id}">${person.name}</a></td>
                                </c:forEach>
                            </tr>
                        </c:if>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="row">
                <div class="col-md-8">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-list"></i> 进度列表</h3>
                        </div>
                        <div class="box-body">
                            <table class="table">
                                <thead>
                                <tr>
                                    <td>时间</td>
                                    <td>机会</td>
                                    <td>进度</td>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${salesList}" var="sales">
                                        <tr>
                                            <td><fmt:formatDate value="${sales.createtime}" pattern="y-M-d HH:mm"></fmt:formatDate></td>
                                            <td><a href="/sales/${sales.id}">${sales.name}</a></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${sales.progress == '完成交易'}">
                                                        <span class="btn btn-success btn-xs">${sales.progress}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="btn btn-primary btn-xs">${sales.progress}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="box box-default collapsed-box">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-qrcode"></i> 电子名片</h3>
                            <div class="box-tools">
                                <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"><i
                                        class="fa fa-plus"></i></button>
                            </div>
                        </div>
                        <div class="box-body" style="text-align: center">
                            <img src="/customer/qrcode/${customer.id}">
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
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
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
    $(function () {

        //公开客户
        $("#openCust").click(function () {
            if (confirm("确认要公开吗？")) {
                var id = ${customer.id};
                window.location.href = "/customer/open/" + id;
            }
        });

        //转移客户
        $("#moveCust").click(function () {
            if (confirm("确认转移客户吗？")) {
                $("#moveModal").modal({
                    show: true,
                    backdrop: 'static'
                });
            }
        });

        $("#moveBtn").click(function () {
            $("#moveForm").submit();
        });


    })
</script>

</body>
</html>

