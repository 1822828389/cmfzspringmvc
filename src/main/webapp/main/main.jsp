<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>持名法州主页</title>
    <link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../themes/IconExtension.css">
    <link rel="stylesheet" type="text/css" href="../themes/icon.css">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/datagrid-detailview.js"></script>
    <script type="text/javascript" src="../js/jquery.edatagrid.js"></script>
    <script type="text/javascript" src="../js/jquery.etree.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/china.js"></script>
    <script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        <!-- 菜单处理 -->
        $(function () {

            $('#btn_changepassword').bind('click', function(){
                alert('easyui');
                $("#changepass_dialog").dialog("open");
            });

            $.ajax({
                url: "${pageContext.request.contextPath}/menu/query",
                type: "post",
                dataType: "json",
                contextType: "application/json",
                success: function (data) {
                    //console.log(data);
                    $.each(data, function (index, first) {
                        var c = "";
                        $.each(first.childrenlist, function (index2, second) {
                            c += "<div><a href='#' onclick=\"addTabs('" + second.title + "','" + second.url + "','" + second.iconCls + "')\" class='easyui-linkbutton' style='width: 100%;height: 27px;text-align: center;background-color:#F07CF0' data-options=\"iconCls:'icon-search'\">" + second.title + "</a></div>";
                        })
                        $('#aa').accordion('add', {
                            title: first.title,
                            content: c,
                            selected: true,
                            iconCls: first.iconCls
                        });
                    });
                }

            })
        })

        function addTabs(title, href, iconCls) {
            /*
             *存在选中  不存在添加
             * */
            var flag = $("#tt").tabs("exists", title);
            if (flag) {
                $("#tt").tabs("select", title);
            } else {
                $('#tt').tabs('add', {
                    title: title,
                    selected: true,
                    iconCls: iconCls,
                    href: href,
                    closable: true
                });
            }
        }

        //添加章节表单初始化
        $("#changepass_ff").form({
            url:'${pageContext.request.contextPath}/mymanager/changepass',
            iframe:false,
            onSubmit: function(){
                return $("#changepass_ff").form("validate");
            },
            success:function(data){
                alert("修改密码成功");
                $("#changepass_dialog").dialog("close");
            }
        })
    </script>

</head>
<body class="easyui-layout">
<div data-options="region:'north',split:true" style="height:60px;background-color:  #5C160C">
    <div style="font-size: 24px;color: #FAF7F7;font-family: 楷体;font-weight: 900;width: 500px;float:left;padding-left: 20px;padding-top: 10px">
        持名法州后台管理系统
    </div>
    <div style="font-size: 16px;color: #FAF7F7;font-family: 楷体;width: 300px;float:right;padding-top:15px">
        欢迎您:${sessionScope.manager.name} &nbsp;<a id="btn_changepassword" href="javascript:void(0)" class="easyui-linkbutton"
        data-options="iconCls:'icon-edit'">修改密码</a>&nbsp;&nbsp;<a id="btn_leave" href="${pageContext.request.contextPath}/mymanager/safeout"
                                                                                                               class="easyui-linkbutton"
                                                                                                               data-options="iconCls:'icon-01'">退出系统</a>
    </div>
</div>
<div data-options="region:'south',split:true" style="height: 40px;background: #5C160C">
    <div style="text-align: center;font-size:15px; color: #FAF7F7;font-family: 楷体">&copy;百知教育 htf@zparkhr.com.cn</div>
</div>

<div data-options="region:'west',title:'导航菜单',split:true" style="width:220px;">
    <div id="aa" class="easyui-accordion" data-options="fit:true">

    </div>
</div>
<div data-options="region:'center'">
    <div id="tt" class="easyui-tabs" data-options="fit:true,narrow:true,pill:true">
        <div title="主页" data-options="iconCls:'icon-neighbourhood',"
             style="background-image:url(${pageContext.request.contextPath}/main/image/shouye.jpg);background-repeat: no-repeat;background-size:100% 100%;"></div>
    </div>
</div>
<div id="changepass_dialog" class="easyui-dialog" title="修改密码" style="width:250px;height:200px;"
     data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:[{
				text:'修改',
				handler:function(){
				$('#changepass_ff').submit();
				}
			},{
				text:'关闭',
				handler:function(){-
                    $('#changePassDialog').dialog('close');
				}
			}]">

    <form id="changepass_ff" method="post" enctype="multipart/form-data">
        <br/>
        <div>
            <label>旧密码:</label>
            <input class="easyui-validatebox"  type="text" name="password1"/><br/><br/>
            <label>新密码:</label>
            <input class="easyui-validatebox"  type="text" name="password2"/><br/><br/>
            <label>新密码:</label>
            <input class="easyui-validatebox"  type="text" name="password3"/>
        </div><br/>
    </form>
</div>
</body>
</html>