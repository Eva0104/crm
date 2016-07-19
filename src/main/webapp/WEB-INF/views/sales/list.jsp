<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EricCRM-Sales</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/static/plugins/fontawesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <!-- Theme style -->
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/plugins/dataTables/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-blue.min.css">
    <link rel="stylesheet" href="/static/plugins/daterangepicker/daterangepicker-bs3.css">

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <%@include file="../include/mainHeader.jsp" %>
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="sales"/>
    </jsp:include>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                机会列表
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                <li class="active">Here</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box box-default collapsed-box">
                <div class="box-header with-border">
                    <h3 class="box-title"><i class="fa fa-search"></i> 搜索</h3>
                    <div class="box-tools">
                        <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"><i
                                class="fa fa-plus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <form class="form-inline">
                        <input type="hidden" id="search_start_time">
                        <input type="hidden" id="search_end_time">
                        <input type="text" class="form-control" placeholder="机会名称" id="search_name">
                        <select class="form-control" id="search_progress">
                            <option value="">当前进度</option>
                            <option value="初次接触">初次接触</option>
                            <option value="确认意向">确认意向</option>
                            <option value="提供合同">提供合同</option>
                            <option value="完成交易">完成交易</option>
                            <option value="交易搁置">交易搁置</option>
                        </select>
                        <input type="text" id="rangepicker" class="form-control" placeholder="跟进时间">
                        <button class="btn btn-success" id="searchBtn" type="button"><i class="fa fa-search"></i>搜索</button>
                    </form>
                </div>
            </div>
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">进度列表</h3>
                    <div class="box-tools">
                        <button class="btn btn-primary btn-xs" id="addSales"><i class="fa fa-plus"></i> 新建进度表</button>
                    </div>
                </div>
                <div class="box-body">
                    <table class="table" id="salesTable">
                        <thead>
                        <tr>
                            <th>名称</th>
                            <th>关联客户</th>
                            <th>金额</th>
                            <th>当前进度</th>
                            <th>最后跟进时间</th>
                            <th>所属人</th>
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

<div class="modal fade" id="addModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增机会</h4>
            </div>
            <div class="modal-body">
                <form id="addForm">
                    <div class="form-group">
                        <label>机会名称</label>
                        <input class="form-control" type="text" name="name">
                    </div>
                    <div class="form-group">
                        <label>价值</label>
                        <input class="form-control" type="text" name="price">
                    </div>
                    <div class="form-group">
                        <label>关联客户</label>
                        <select class="form-control" name="custid">
                            <option value=""></option>
                            <c:forEach items="${customerList}" var="cust">
                                <option value="${cust.id}">${cust.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>当前进度</label>
                        <select class="form-control" name="progress">
                            <option value="初次接触">初次接触</option>
                            <option value="确认意向">确认意向</option>
                            <option value="提供合同">提供合同</option>
                            <option value="完成交易">完成交易</option>
                            <option value="交易搁置">交易搁置</option>
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


<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 2.2.3 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/plugins/dataTables/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>
<script src="/static/plugins/validate/jquery.validate.js"></script>
<script src="/static/plugins/moment/moment.js"></script>
<script src="/static/plugins/daterangepicker/daterangepicker.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>

<script>
    $(function () {

        var dataTable = $("#salesTable").DataTable({
            serverSide: true,
            ajax: {
                url: "/sales/list",
                data: function(dataSouce){
                    dataSouce.name=$("#search_name").val();
                    dataSouce.progress=$("#search_progress").val();
                    dataSouce.startdate=$("#search_start_time").val();
                    dataSouce.enddate=$("#search_end_time").val();
                }
            },
            ordering: false,
            "autoWidth": false,
            searching: false,
            columns: [
                {
                    "data": function (row) {
                        return "<a href='/sales/" + row.id + "'>" + row.name + "</a>"
                    }
                },
                {"data": function(row){
                    return "<a href='/customer/" + row.custid + "'>" + row.custname + "</a>"
                }},
                {
                    "data": function (row) {
                        return "￥" + row.price
                    }
                },
                {
                    "data": function (row) {
                        if (row.progress == '交易搁置') {
                            return "<label class='label label-danger'>" + row.progress + "</label>"
                        }
                        return "<label class='label label-success'>" + row.progress + "</label>"
                    }
                },
                {
                    "data": function (row) {
                        var timestemp = row.lasttime;
                        if (!timestemp) {
                            return "无";
                        }
                        var date = moment(timestemp);
                        return date.format("YYYY-MM-DD HH:mm");
                    }
                },
                {"data": "username"}
            ],
            "language": {
                "search": "请输入客户名称或联系方式",
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

        //条件搜索
        $("#searchBtn").click(function () {
            dataTable.ajax.reload();
        });

        $("#rangepicker").daterangepicker({
            format: "YYYY-MM-DD",
            separator: "~",
            locale: {
                "applyLabel": "选择",
                "cancelLabel": "取消",
                "fromLabel": "从",
                "toLabel": "到",
                "customRangeLabel": "自定义",
                "weekLabel": "周",
                "daysOfWeek": [
                    "一",
                    "二",
                    "三",
                    "四",
                    "五",
                    "六",
                    "日"
                ],
                "monthNames": [
                    "一月",
                    "二月",
                    "三月",
                    "四月",
                    "五月",
                    "六月",
                    "七月",
                    "八月",
                    "九月",
                    "十月",
                    "十一月",
                    "十二月"
                ],
                "firstDay": 1,
            },
            ranges: {
                '今天': [moment(), moment()],
                '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                '最近七天': [moment().subtract(6, 'days'), moment()],
                '最近30天': [moment().subtract(29, 'days'), moment()],
                '本月': [moment().startOf('month'), moment().endOf('month')],
                '上个月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            }
        });



        $("#rangepicker").on('apply.daterangepicker', function (ev, picker) {
            $("#search_start_time").val(picker.startDate.format("YYYY-MM-DD"));
            $("#search_end_time").val(picker.endDate.format("YYYY-MM-DD"));

        });

        //新增进度
        $("#addSales").click(function () {
            $("#addModal").modal({
                show: true,
                backdrop: 'static'
            });
        });

        $("#addForm").validate({
            errorElement: "span",
            errorClass: "text-danger",
            rules: {
                name: {
                    required: true
                },
                price: {
                    required: true
                },
                progress: {
                    required: true
                }
            },
            messages: {
                name: {
                    required: "请输入机会名称"
                },
                price: {
                    required: "请输入金额"
                },
                progress: {
                    required: "请选择进度"
                }
            },
            submitHandler: function (form) {
                $.post("/sales/add", $(form).serialize()).done(function (data) {
                    if (data == "success") {
                        $("#addModal").modal("hide");
                        window.location.reload();
                    }
                }).fail(function () {
                    alert("请求服务器异常！");
                })
            }
        });

        $("#saveBtn").click(function () {
            $("#addForm").submit();
        });


    })
</script>

</body>
</html>

