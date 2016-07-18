<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EricCRM-Task</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/static/plugins/fontawesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <!-- Theme style -->
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">

    <link rel="stylesheet" href="/static/plugins/fullCalendar/fullcalendar.min.css">

    <link rel="stylesheet" href="/static/plugins/datepicker/datepicker3.css">
    <link rel="stylesheet" href="/static/plugins/colorpicker/bootstrap-colorpicker.min.css">

    <link rel="stylesheet" href="/static/dist/css/skins/skin-blue.min.css">

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <%@include file="../include/mainHeader.jsp" %>
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="task"/>
    </jsp:include>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                待办事项
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                <li class="active">Here</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-md-8">
                    <div class="box box-solid">
                        <div class="box-body">
                            <div id='calendar'></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="box box-danger">
                        <div class="box-header with-border">
                            <h3 class="box-title">已延期事項</h3>
                        </div>
                        <div class="box-body">
                            <ul class="todo-list">
                                <c:forEach items="${timeoutTaskList}" var="list">
                                    <li>
                                        <input type="checkbox"/>
                                        <span class="text">${list.title}</span>
                                        <div class="tools">
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
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

<div class="modal fade" id="addModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增事项</h4>
            </div>
            <div class="modal-body">
                <form id="addForm">
                    <div class="form-group">
                        <label>事项内容</label>
                        <input class="form-control" type="text" name="title" id="task_title">
                    </div>
                    <div class="form-group">
                        <label>开始日期</label>
                        <input type="text" class="form-control" name="start" id="start_time">
                    </div>
                    <div class="form-group">
                        <label>结束日期</label>
                        <input type="text" class="form-control" name="end" id="end_time">
                    </div>
                    <div class="form-group">
                        <label>提醒时间</label>
                        <div>
                            <select name="hour" style="width: 50px">
                                <option value=""></option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                                <option value="13">13</option>
                                <option value="14">14</option>
                                <option value="15">15</option>
                                <option value="16">16</option>
                                <option value="17">17</option>
                                <option value="18">18</option>
                                <option value="19">19</option>
                                <option value="20">20</option>
                                <option value="21">21</option>
                                <option value="22">22</option>
                                <option value="23">23</option>
                            </select>
                            :
                            <select name="min" style="width: 50px">
                                <option value=""></option>
                                <option value="5">5</option>
                                <option value="10">10</option>
                                <option value="15">15</option>
                                <option value="20">20</option>
                                <option value="25">25</option>
                                <option value="30">30</option>
                                <option value="35">35</option>
                                <option value="40">40</option>
                                <option value="45">45</option>
                                <option value="50">50</option>
                                <option value="55">55</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>显示颜色</label>
                        <input type="text" class="form-control" name="color" id="color" value="#61a5e8">
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


<div class="modal fade" id="eventModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">查看代办事项</h4>
            </div>
            <div class="modal-body">
                <form id="eventForm">
                    <input type="hidden" id="eventId"/>
                    <div class="form-group">
                        <label>事项内容</label>
                        <div id="eventTitle"></div>
                    </div>
                    <div class="form-group">
                        <label>开始日期~结束日期</label>
                        <div><span id="eventStart"></span> ~ <span id="eventEnd"></span></div>
                    </div>
                    <div class="form-group">
                        <label>提醒时间</label>
                        <div id="eventRemindtime"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" id="delBtn"><i class="fa fa-trash"></i> 删除</button>
                <button type="button" class="btn btn-primary" id="doneBtn"><i class="fa fa-check"></i> 标记为已完成</button>
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
<script src="/static/plugins/moment/moment.js"></script>
<script src="/static/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="/static/plugins/datepicker/bootstrap-datepicker.zh-CN.js"></script>
<script src="/static/plugins/fullCalendar/fullcalendar.min.js"></script>
<script src="/static/plugins/fullCalendar/lang-all.js"></script>
<script src="/static/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>

<script>
    $(function () {

        var _event = null;
        var $calendar = $("#calendar");

        $calendar.fullCalendar({
            lang: "zh-CN",
            buttonText: {
                today: '今天'
            },
            dayClick: function (date, jsEvent, view) {
                $("#addForm")[0].reset();

                $("#start_time").val(date.format());
                $("#end_time").val(date.format());

                $("#addModal").modal({
                    show: true,
                    backdrop: 'static'
                });
            },
            events: "/task/load",
            eventClick: function (calEvent, jsEvent, view) {
                _event = calEvent;
                $("#eventId").val(calEvent.id);
                $("#eventTitle").text(calEvent.title);
                $("#eventStart").text(moment(calEvent.start).format("YYYY-MM-DD"));
                $("#eventEnd").text(moment(calEvent.end).format("YYYY-MM-DD"));
                if(calEvent.remindertime){
                    $("#eventRemindtime").text(calEvent.remindertime);
                }else {
                    $("#eventRemindtime").text("无");
                }
                $("#eventModal").modal({
                    show: true,
                    backdrop: "static"
                });
            }
        });

        //新增
        $("#color").colorpicker({
            color: '#61a5e8'
        });

        $("#start_time,#end_time").datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            language: 'zh-CN',
            todayHighlight: true
        });

        $("#saveBtn").click(function () {
            if(!$("#task_title").val()) {
                $("#task_title").focus();
                return;
            }
            if(moment($("#start_time").val()).isAfter(moment($("#end_time").val()))){
                alert("结束时间必须大于开始时间!");
                return;
            }
            $.post("/task/new", $("#addForm").serialize()).done(function (result) {
                if (result.state == "success") {
                    $calendar.fullCalendar("renderEvent", result.data);
                    $("#addModal").modal('hide');
                }
            }).fail(function () {
                alert("服务器异常!");
            });
        });


        //删除
        $("#delBtn").click(function(){
            var id = $("#eventId").val();
            if(confirm("确定要删除日程吗？")){
                $.get("/task/del/"+id).done(function(data){
                    if(data == "success"){
                        $calendar.fullCalendar("removeEvents",id);
                        $("#eventModal").modal("hide");
                    }
                }).fail(function(){
                    alert("服务器异常!")
                })
            }
        });

        //标记为已完成
        $("#doneBtn").click(function(){
            var id = $("#eventId").val();
            $.post("/task/done/"+id).done(function(result){
                if(result.state == "success"){
                    _event.color = "#cccccc";
                    $calendar.fullCalendar('updateEvent',_event);
                    $("#eventModal").modal("hide");
                }

            }).fail(function(){
                alert("服务器异常!");
            });
        })




    })

</script>

</body>
</html>

