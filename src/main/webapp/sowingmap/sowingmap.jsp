<%@page language="java" contentType="text/html; charset=utf-8" isELIgnored="false" pageEncoding="utf-8"%><script type="text/javascript">    $(function(){        $('#smtt').edatagrid({            title:'轮播图',            fitColumns:true,            striped:true,            remoteSort:false,            singleSelect:true,            nowrap:false,            toolbar:'#lbt1_dlg_toolbar',            singleSelect:false,            ctrlSelect:true,            fitColumns:true,            pagination:true,//分页            pageSize:3,            pageList:[3,6,9],            url:'${pageContext.request.contextPath}/sowingmap/queryall',            updateUrl: "${pageContext.request.contextPath}/sowingmap/update",            //destroyUrl:"${pageContext.request.contextPath}/sowingmap/deletes",            saveUrl:"${pageContext.request.contextPath}/sowingmap/update",            columns:[[                {field:'id',title:'图片 ID',width:80,checkbox:true},                {field:'title',title:'标题',width:100,sortable:true,},                {field:'imagestatus',title:'图片状态',width:80,align:'right',sortable:true,editor:'text'},                {field:'uploadtime',title:'修改时间',width:60,align:'center',formatter : function(value){                    var date = new Date(value);                    var y = date.getFullYear();                    var m = date.getMonth() + 1;                    var d = date.getDate();                    return y + '-' +m + '-' + d;                }}            ]],            view: detailview,            detailFormatter: function(rowIndex, rowData){                return '<table><tr>' +                    '<td rowspan=2 style="border:0"><img src="http://localhost:9001/' + rowData.path +' " style="height:50px;"></td>' +                    '<td style="border:0">' +                    '<p>文件路径: ' + rowData.oldname+ '</p>' +                    '<p>描述: ' + rowData.desc1 + '</p>' +                    '</td>' +                    '</tr></table>';            }        });    });    $("#btn_add").linkbutton({        onClick:function(){            $("#addSowingmap").dialog("open");        }    });    $("#btn_delete1").linkbutton({        onClick:function(){            var ids=[];            var rows=$("#smtt").datagrid("getSelections");            if(rows.length==0){                $.messager.alert("警告","您未选中！");                $("#smtt").datagrid("unselectAll");                return false;            }            rows.forEach(function(row,i){                ids.push(row.id);                var index=$("#smtt").datagrid("getRowIndex",row);                $("#smtt").datagrid("deleteRow",index);            });            $.ajax({                type:"POST",                url:"${pageContext.request.contextPath}/sowingmap/deletes",                data:"ids="+ids,                dataType:"text",                success:function(result){                    $("#smtt").datagrid("reload");                }            });        }    });    $("#btn_update").linkbutton({        onClick:function () {            /*将选中行变为可编辑*/            var row = $("#smtt").edatagrid("getSelected");            if (row == null) {                alert("请选中行")            } else {                $("#smtt").edatagrid("editRow", $("#smtt").edatagrid("getRowIndex", row))            }        }    });    $("#btn_save").linkbutton({        onClick:function () {            $("#smtt").edatagrid("saveRow");        }    });    //用户添加    $("#addSowingmap").dialog({        title:"添加轮播图片",        iconCls:"icon-add",        width:400,        href:"${pageContext.request.contextPath}/sowingmap/addsm.jsp",        cache:false,        modal:true,        closed:true,        top:120,        buttons:[            {                text:"取消",                iconCls:"icon-redo",                handler:function(){                    $("#regUserForm").form("clear");                }            },{                text:"添加",                iconCls:"icon-ok",                handler:function(){                    $("#regUserForm").submit();                }            }        ]    });    </script><table id="smtt"></table>    <div id="lbt1_dlg_toolbar">        <table cellpadding="0" cellspacing="0" style="width:100%">            <tr>                <td style="padding-left:2px">                    <a id="btn_add" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>                    <a id="btn_delete1" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>                    <a id="btn_update" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>                    <a id="btn_save" href="javascript:void(0)"   class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">保存</a>                </td>            </tr>        </table>    </div><div id="addSowingmap" ></div>