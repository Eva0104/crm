<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EricCRM-文档管理</title>
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
        <jsp:param name="menu" value="doc"/>
    </jsp:include>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Main content -->
        <section class="content">

            <div class="box box-primary">

                <div class="box-header with-border">
                    <h3 class="box-title">文档列表-${fid}</h3>
                    <div class="box-tools">
                        <span id="uploadBtn"><span class="text"><i class="fa fa-upload"></i> 上传文件</span></span>
                        <button class="btn btn-primary btn-xs" id="addDirBtn"><i class="fa fa-folder"></i> 新建文件夹</button>
                    </div>
                </div>

                <div class="box-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>名称</th>
                                <th>大小</th>
                                <th>创建人</th>
                                <th>创建时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${documentList}" var="doc">
                                <tr>
                                    <c:choose>
                                        <c:when test="${doc.type == 'dir'}">
                                            <td><i class="fa fa-folder" style="color:#00acd6"></i></td>
                                            <td><a href="/doc?fid=${doc.id}">${doc.name}</a></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td><i class="fa fa-file" style="color: #00acd6"></i></td>
                                            <td><a href="/doc/download/${doc.id}">${doc.name}</a></td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td>${doc.size}</td>
                                    <td>${doc.createuser}</td>
                                    <td><fmt:formatDate value="${doc.createtime}" pattern="y-M-d HH:mm"></fmt:formatDate></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                        <c:if test="${fid != 0}">
                            <button class="btn btn-primary btn-xs" id="backBtn"><i class="fa fa-reply"></i>返回上一級</button>
                        </c:if>
                        </tfoot>
                    </table>
                </div>

            </div>

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

</div>
<!-- ./wrapper -->

<%--addModal--%>
<div class="modal fade" id="addModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新建文件夹</h4>
            </div>
            <div class="modal-body">
                <form id="addForm" action="/doc/dir/new" method="post">
                    <input class="hidden" name="fid" value="${fid}">
                    <div class="form-group">
                        <label>名称</label>
                        <input class="form-control" type="text" name="name" id="dirname">
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

<script src="/static/plugins/webuploader/webuploader.min.js"></script>

<script>
    $(function(){
        //新建文件夹
        $("#addDirBtn").click(function(){
            $("#addModal").modal({
                show:true,
                backdrop:'static'
            });
        });

        $("#saveBtn").click(function(){
            if(!$("#dirname").val()){
                $("#dirname").focus();
                return;
            }
            $("#addForm").submit();
        });

        //上傳文件
        var uploader = WebUploader.create({
            swf: "/static/plugins/webuploader/Uploader.swf",
            pick:"#uploadBtn",
            server:"/doc/file/upload",
            fileValL:"file",
            formData:{"fid":${fid}},
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

        //返回上一级
        $("#backBtn").click(function(){
            window.location.href="/doc/back/"+${fid}
        });

    })
</script>
</body>
</html>

