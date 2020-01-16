<%--
  Created by IntelliJ IDEA.
  User: LI138
  Date: 2020/1/14
  Time: 10:38
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%

        pageContext.setAttribute("app_path",request.getContextPath());
    %>
    <script src="${app_path}/static/js/jquery-3.4.1.min.js"></script>
    <script src="${app_path}/static/bootstrap/js/bootstrap.js"></script>
    <link href="${app_path}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<!-- 员工修改模态框 -->
    <div class="modal fade"  id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门ID即可--%>
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
    </div>
<!-- 员工添加模态框 -->
<div class="modal fade"  id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text"  name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门ID即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>ssm-crud</h1>
        </div>

    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger"  id="emp_delete_emp">删除</button>
        </div>
    </div>
    <%--表格显示数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>

                    </th>

                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>

</div>
<script type="text/javascript">
    var totalRecord,currentPage;
    //直接加载完以后，直接发送一个ajax请求，要到数据
    $(function () {
        //首页
        to_page(1);
    });
    function to_page(pn) {
        $.ajax({
            url:"${app_path}/emps",
            data:"pn="+pn,
            type:"get",
            success:function (result) {
                //console.log(result);
                //1.解析并显示员工信息
                buil_emps_table(result);
                //2.解析并显示分页信息
                buil_page_info(result);
                //3.解析显示分页条信息
                buil_page_nav(result);
            }

        });
    }
    //员工信息
    function buil_emps_table(result) {
        //清空
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd=$("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd=$("<td></td>").append(item.email);
            var deptNameTd=$("<td></td>").append(item.dept.deptName);
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                            .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
           //为编辑按钮田间一个自定义属性，来表示当前员工id
            editBtn.attr("edit-id",item.empId);

            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm  delete_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
            //为删除按钮田间一个自定义属性，来表示当前员工id
            delBtn.attr("del-id",item.empId);

            var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);

            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }
    //解析显示分页信息
    function buil_page_info(result) {
        $("#page_info_area").empty();
            var painfo =result.extend.pageInfo;
        $("#page_info_area").append("当前"+painfo.pageNum
            +" 页，总"+painfo.pages+"页，总"
            +painfo.total+" 条记录")
        totalRecord=painfo.total;
        currentPage=painfo.pageNum;
    }
    //分页条
    function buil_page_nav(result) {
        $("#page_nav_area").empty();
        var ul= $("<ul></ul>").addClass("pagination");
        //构建元素
        var firstPageLi=$("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled")
        }else {
            //为元素添加点击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }


        var lastPageLi=$("<li></li>").append($("<a></a>").attr("href","#").append("末页"));
        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        if(result.extend.pageInfo.hasNextPage==false){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled")
        }else {
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
        }

        //添加首页和前一页
        ul.append(firstPageLi).append(prePageLi);
        //遍历给ul中添加页码
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi =$("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum==item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        //把ul添加到nav元素
        var navEle = $("<nav></nav>").attr("aria-label","Page navigation").append(ul);
        navEle.appendTo("#page_nav_area")
    }
    //重置方法
    function reset_form(element){
        //清除表单数据
        $(element)[0].reset();
        //清空表单样式
        $(element).find("*").removeClass("has-error has-success");
        $(element).find(".help-block").text("");
    }
    //点击新增按钮
    $("#emp_add_modal_btn").click(function () {
        //清除表单数据（表单重置）
        //$("#empAddModal form")[0].reset();
        reset_form("#empAddModal form");
        //返送ajax请求，查出部门信息
        getDepts("#dept_add_select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });
    //查出部门信息，并显示在下拉列表中
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${app_path}/depts",
            type:"get",
            success:function (result) {
                //显示部门信息
                //$("#dept_add_select")
                $.each(result.extend.depts,function (index,item) {
                    var optionEle=$("<option></option>").append(item.deptName).attr("value",item.deptId);
                    optionEle.appendTo($(ele));
                });
            }
        });
    }
    //员工校验
    function validate_add_form(){
        //验证员工姓名
        var empName = $("#empName_add_input").val();
        var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u4e00-\u9fa5]{2,5})/;
        if(!regName.test(empName)){
            //alert("用户可以是2-5位中文，或者是6-16位英文和数字的组合")
            show_validate_msg("#empName_add_input","error","用户必须是2-5位中文，或者是6-16位英文和数字的组合");
            return false;
        }else {
            show_validate_msg("#empName_add_input","success","");

        }
        //验证邮箱
        var emil = $("#email_add_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-])+\.([a-z\.]{2,6})$/;
        if(!regEmail.test(emil)){
            //alert("邮箱格式不正确");
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            return false;
        }else {
            show_validate_msg("#email_add_input","success","");
        }
        return true;
    }
    function show_validate_msg(ele,status,msg){
        //清楚当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else  if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    $("#empName_add_input").change(function () {
        var empName=this.value;
        //发送ajax校验用户名是否可用
        $.ajax({
            url:"${app_path}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else {
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });
    //点击保存员工
    $("#emp_save_btn").click(function () {
            //模态框中填写的数据提交给服务器
        //1.对要提交的数据进行校验
                //2.返送ajax请求
        if(!validate_add_form()){
            return false;
        }
        if($("#emp_save_btn").attr("ajax-va")=="error"){
            return false;
        }
        //判断之前的用户名校验是否成功了
        $.ajax({
            url:"${app_path}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                if(result.code==100){
                    // alert(result.msg);
                    //员工保存成功后
                    //1关闭模态框
                    $("#empAddModal").modal("hide");
                    //2.来到最后一页
                    to_page(totalRecord);
                }else {
                    //显示失败信息
                    //有哪个字段的错误信息就显示那个字段的
                    if(undefined!=result.extend.errorFields.email){
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined!=result.extend.errorFielde.empName){
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }

            }
        });
    });

    //我们是按扭创建之前就绑定了click，所以绑定不上
    //可以在创建按钮的时候绑定，绑定点击.live()
    //jquery新版没有live(),使用on进行代替
    $(document).on("click",".edit_btn",function () {

        //2.查出员工信息，并显示部门列表
        getDepts("#dept_update_select");
        //1.查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));

        //把员工Id传输给更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));

        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });
        function getEmp(id) {
            $.ajax({
                url:"${app_path}/emp/"+id,
                type:"GET",
                success:function (result) {
                    //console.log(result);
                    var empData=result.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);
            }
            });
        }
        $("#emp_update_btn").click(function () {
            //邮箱验证
            var emil = $("#email_update_input").val();
            var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-])+\.([a-z\.]{2,6})$/;
            if(!regEmail.test(emil)){
                //alert("邮箱格式不正确");
                show_validate_msg("#email_update_input","error","邮箱格式不正确");
                return false;
            }else {
                show_validate_msg("#email_update_input","success","");
            }
            //发送ajax请求
            $.ajax({
                url:"${app_path}/emp/"+$(this).attr("edit-id"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (result) {
                    //关闭模态框
                    $("#empUpdateModal").modal("hide");
                    //回到本页面
                    to_page(currentPage);
                }
            });
        });
        //单个删除
    $(document).on("click",".delete_btn",function () {
        //alert($(this).parents("tr").find("td:eq(1)").text());
            var empName =$(this).parents("tr").find("td:eq(2)").text();
            var empId=$(this).attr("del-id");
            if(confirm("确认删除【"+empName+"】吗？")){
                //确认，发送ajax请求
                $.ajax({
                    url:"${app_path}/emp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        //alert(result.msg);
                        to_page(currentPage);
                    }
                });

            }

    });

    //全选/全不选
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"));
        //attr获取自定义属性的值，prop修改读取dom原生属性的值
        //alert($(this).prop("checked"));
    });
    $(document).on("click",".check_item",function () {
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });
    //点击删除，批量删除
    $("#emp_delete_emp").click(function () {
        var empName="";
        var del_ids="";
       $.each($(".check_item:checked"),function () {
           empName+=$(this).parents("tr").find("td:eq(2)").text()+",";
           del_ids+=$(this).parents("tr").find("td:eq(1)").text()+"-";
       });
       empName=empName.substring(0,empName.length-1);
        del_ids=del_ids.substring(0,del_ids.length-1);
       if(confirm("确认删除【"+empName+"】吗？")){
           $.ajax({
               url:"${app_path}/emp/"+del_ids,
               type:"DELETE",
               success:function (result) {
                   //alert(result.msg);
                   to_page(currentPage);
               }
           });
       }
    });
</script>
</body>
</html>
