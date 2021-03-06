<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EricCRM-统计</title>
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
        <jsp:param name="menu" value="chart"/>
    </jsp:include>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                统计
                <small>客户关系管理系统</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                <li class="active">Here</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <div class="box box-primary">
                <div class="box-header">
                    <h3>统计区间</h3>
                </div>
                <div class="box-body">
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="info-box">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-plus"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">本月新增客户数量</span>
                            <span class="info-box-number">${newCustomerCount}</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="info-box">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-bar-chart"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">本月完成交易量</span>
                            <span class="info-box-number">${finishSalesCount}</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="info-box">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-line-chart"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">本月完成交易额</span>
                            <span class="info-box-number">${finishSalesMoney}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="box box-primary">
                <div class="box-header">
                    <h5 class="box-title">销售机会统计</h5>
                </div>
                <div class="box-body">
                    <div id="pieChart" style="width: 600px;height:400px;"></div>
                </div>
            </div>

            <div class="box box-primary">
                <div class="box-header">
                    <h5 class="box-title">员工业绩统计</h5>
                </div>
                <div class="box-body">
                    <div id="barChart" style="width: 600px;height:400px;"></div>
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
<script src="/static/plugins/echarts/echarts.min.js"></script>

<script>
    $(function(){

        //柱状图
        var mybar = echarts.init($("#barChart")[0]);
        var option = {
            tooltip: {},
            xAxis: {
                data: []
            },
            yAxis: {},
            series: [{
                name: '销量',
                type: 'bar',
                data: []
            }]
        };
        mybar.setOption(option);

        $.get("/chart/user/price").done(function (data) {
            // 填入数据
            mybar.setOption({
                xAxis: {
                    data: data.name
                },
                series: [{
                    // 根据名字对应到相应的系列
                    name: '销量',
                    data: data.price
                }]
            });
        });

        //饼状图
        var myPie = echarts.init($("#pieChart")[0]);
        var option = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: ['完成交易','初次接触','提供合同','确认意向','交易搁置']
            },
            series: [
                {
                    name: '销售机会',
                    type: 'pie',
                    data: [],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        myPie.setOption(option);
        $.get("/chart/progress/data").done(function (data) {
            // 填入数据
            myPie.setOption({
                series: [{
                    data: data
                }]
            });

        });

    });

</script>

</body>
</html>

