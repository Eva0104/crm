<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    <link rel="stylesheet" href="/static/plugins/webuploader/webuploader.css">

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
                <li><a href="/sales"><i class="fa fa-dashboard"></i>进度管理</a></li>
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
                            <button class="btn btn-danger btn-xs" id="delSalesBtn">删除进度</button>
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
                            <td style="width: 200px">${sales.progress}&nbsp;<a href="javaScript:;" id="editLog">修改</a></td>
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
                                <button class="btn btn-success btn-xs" id="addNewLog"><i class="fa fa-plus"></i> 新增记录</button>
                            </div>
                        </div>
                        <div class="box-body">
                            <ul class="timeline">
                                <c:forEach items="${salesLogList}" var="salesLog">
                                  <c:if test="${salesLog.type == '手动'}">
                                      <li>>
                                          <i class="fa fa-envelope bg-blue"></i>
                                          <div class="timeline-item">
                                              <span class="time"><i class="fa fa-weixin"></i>${salesLog.createtime}</span>
                                              <h3 class="timeline-header"><a href="#">${salesLog.context}</a> ...</h3>
                                          </div>
                                      </li>
                                  </c:if>
                                    <c:if test="${salesLog.type == '自动'}">
                                        <li>>
                                            <i class="fa fa-weixin bg-green"></i>
                                            <div class="timeline-item">
                                                <span class="time"><i class="fa fa-clock-o"></i>${salesLog.createtime}</span>
                                                <h3 class="timeline-header"><a href="#">${salesLog.context}</a> ...</h3>
                                            </div>
                                        </li>
                                    </c:if>
                                </c:forEach>
                                <li>
                                    <i class="fa fa-clock-o bg-gray"></i>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="box box-default">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-file-o"></i> 相关资料</h3>
                            <div class="box-tools">
                                <span id="uploadBtn"><span class="text"><i class="fa fa-upload"></i> 上传文件</span></span>
                            </div>
                            <div class="box-body">
                                <table>
                                    <c:forEach items="${salesFileList}" var="file">
                                        <tr>
                                            <td><i class="fa fa-folder" style="color:#00acd6"></i></td>
                                            <td><a href="/sales/${file.id}/downLoad">&nbsp;${file.name}</a></td>
                                        </tr>
                                    </c:forEach>
                                </table>
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
<div class="modal fade" id="addModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增进度记录</h4>
            </div>
            <div class="modal-body">
                <form id="addForm" action="/sales/${sales.id}/addLog" method="post">
                    <div class="form-group">
                        <label>进度描述</label>
                        <input class="form-control" type="text" name="context">
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


<div class="modal fade" id="editModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改跟进状态</h4>
            </div>
            <div class="modal-body">
                <form id="editForm" action="/sales/${sales.id}/editLog" method="post">
                    <input type="hidden" name="name" value="${sales.name}">
                    <div class="form-group">
                        <label>跟进状态</label>
                        <select name="context" class="form-control">
                            <option value="${sales.progress}">${sales.progress}</option>
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
                <button type="button" class="btn btn-primary" id="editBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 2.2.3 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/plugins/moment/moment.js"></script>
<script src="/static/plugins/webuploader/webuploader.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script>
    $(function(){

        //新增跟进记录
        $("#addNewLog").click(function(){
            $("#addModal").modal({
                show:true,
                backdrop:'static'
            });
        });

        $("#saveBtn").click(function(){
            $("#addForm").submit();
        });

        //修改跟进状态
        $("#editLog").click(function(){
            $("#editModal").modal({
                show:true,
                backdrop:'static'
            });
        });

        $("#editBtn").click(function(){
            $("#editForm").submit();
        });

        //上传相关文件
        var uploader = WebUploader.create({
            swf: "/static/plugins/webuploader/Uploader.swf",
            pick:"#uploadBtn",
            server:"/sales/${sales.id}/fileUpload",
            fileValL:"file",
            auto: true
        });

        uploader.on('startUpload',function(){
            $("#uploadBtn .text").html('<i class = "fa fa-spinner fa-spin"></i>上传中..')
        });

        uploader.on('uploadSuccess',function(file){
            window.location.reload();
        });

        uploader.on('uploadError',function(file){
            alert("上传失败！")
        });

        uploader.on('uploadComplete',function(file){
            $("#uploadBtn .text").html('<i class="fa fa-upload"></i> 上传文件');
        });

        //删除进度
        $("#delSalesBtn").click(function(){
            if(confirm("确定删除进度表吗？")){
                var id = ${sales.id};
                window.location.href="/sales/del/"+id;
            }
        });

    })
</script>

</body>
</html>

