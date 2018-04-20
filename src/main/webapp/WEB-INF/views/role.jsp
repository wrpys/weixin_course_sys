<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <%@include file="../layouts/default.jsp"%>
    <title></title>
    <style>
        .ztree {height:300px;overflow-y:auto;overflow-x:auto;}
    </style>
</head>
<body>
    <div class="row">
        <div class="container">
            <form id="searchForm" class="form-horizontal">
                <div class="row">
                    <div class="control-group span8">
                        <label class="control-label">名称：</label>
                        <div class="controls">
                            <input type="text" class="control-text" name="roleName">
                        </div>
                    </div>
                    <div class="control-group span8">
                        <label class="control-label">状态：</label>
                        <div class="controls">
                            <select name="state">
                                <option value="">全部</option>
                                <option value="1">启用</option>
                                <option value="0">禁用</option>
                            </select>
                        </div>
                    </div>
                    <div class="span3 offset2">
                        <button type="button" id="btnSearch" class="button button-primary">搜索</button>
                    </div>
                </div>

            </form>

            <div class="search-grid-container">
                <div id="grid"></div>
            </div>

            <div id="content" class="hide">
                <div class="row">
                    <div class="panel panel-small span12"><br/>
                       <form  class="form-horizontal">
                           <div class="row">
                               <div class="control-group span8">
                                   <label class="control-label"><s>*</s>角色名称：</label>
                                   <div class="controls">
                                       <input type="text" id="roleName" name="roleName" data-rules="{required:true}" class="input-normal control-text">
                                   </div>
                               </div>
                           </div>
                           <div class="row">
                               <div class="control-group span8">
                                   <label class="control-label"><s>*</s>角色代码：</label>
                                   <div class="controls">
                                       <input type="text" id="roleCode" name="roleCode" data-rules="{required:true}" class="input-normal control-text">
                                   </div>
                               </div>
                           </div>
                           <div class="row">
                               <div class="control-group span8">
                                   <label class="control-label">角色状态：</label>
                                   <div class="controls">
                                       <select name="state" id="state">
                                           <option value="1">启用</option>
                                           <option value="0">禁用</option>
                                       </select>
                                   </div>
                               </div>
                           </div>

                           <div class="row">
                               <div class="control-group span15">
                                   <label class="control-label">备注：</label>
                                   <div class="controls control-row3">
                                       <textarea name="remark" class="input-large" type="text"></textarea>
                                   </div>
                               </div>
                           </div>
                       </form><br/>
                    </div>
                   <div class="panel panel-small span9">
                       <%--<div class="panel-header">--%>
                           <%--<h2>菜单树</h2>--%>
                       <%--</div>--%>
                       <div class="panel-body">
                           <div class="control-group">
                               <div class="controls">
                                   <button id="checkAll" class="button button-small">全选</button>
                                   <button id="checkNone" class="button button-small">取消</button>

                               </div>
                           </div>
                           <ul id="tree" class="ztree"></ul>
                       </div>
                   </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        BUI.use(['common/search','ztree/ztree'],function(Search){
            var setting = {
                check:{
                    enable:true
                },
                data:{
                    key:{
                        name:'menuName'
                    },
                    simpleData:{
                        enable:true,
                        idKey:'menuId',
                        pIdKey:'menuPid'
                    }
                }
            };
            var enumState = {"1":"正常","0":"禁用"},

            columns = [
                {title:'角色名称',width:100,dataIndex:'roleName'},
                {title:'角色编码',width:100,dataIndex:'roleCode'},
                {title:'角色状态',width:100,dataIndex:'state',renderer:BUI.Grid.Format.enumRenderer(enumState)},
//                {title:'创建人',width:100,dataIndex:'createId'},
//                {title:'创建时间',width:100,dataIndex:'createTime'},
//                {title:'修改人',width:100,dataIndex:'updateId'},
//                {title:'修改时间',width:150,dataIndex:'updateTime'},
                {title:'备注',width:200,dataIndex:'remark'}
            ],
                store = Search.createStore('${ctx}/role/list'),
                editing = new BUI.Grid.Plugins.DialogEditing({
                    contentId : 'content',
                    triggerCls : 'btn-edit',
                    editor : {
                        success : function(){  //点击确认的时候触发，可以进行异步传输
                            var editor = this,
                                    record = editing.get('record'),//获取编辑记录
                                    data = editor.get('form').serializeToObject();//编辑完成的记录
                            editor.valid();

                            if(editor.isValid()){

                                var buttons=[];
                                var checkedNodes = zTree.getCheckedNodes(true);
                                BUI.each(checkedNodes,function(item){

                                    var id = item.menuId;
                                    if( BUI.isNumeric( id ) ){  //父节点
                                        buttons.push( item.menuCode + ":" + "" );
                                    }else{
                                        var parentCode = item.getParentNode().menuCode;
                                        buttons.push( parentCode + ":" + item.menuCode );
                                    }

                                });

                                data.buttons=buttons.join(',');
                                if(data.buttons==''){
                                    BUI.Message.Alert('菜单不能为空！');
                                    return;
                                }
                                submit(BUI.mix(record,data),editor);
                            }
                        }
                    }
                }),


        gridCfg = Search.createGridCfg(columns,{
            tbar : {
                items : [
                    {
                        btnCls : 'button button-small',
                        text : '<i class = "icon-plus"></i>添加',
                        listeners :
                        {
                            'click' : addFunction
                        }
                    },
                    {
                       btnCls : 'button button-small',
                       text : '<i class = "icon-edit"></i>修改',
                        listeners :
                        {
                            'click' : editFunction
                        }
                    },
                    {
                        btnCls : 'button button-small',
                        text :  '<i class = "icon-remove"></i>删除',
                        listeners:
                        {
                            'click' : delFunction
                        }
                    }
                ]
            },
            plugins:[BUI.Grid.Plugins.CheckSelection,editing]  //勾选插件

        });

        var search = new Search({
            store : store,
            gridCfg : gridCfg
        }),
        grid = search.get('grid');
        grid.set("emptyDataTpl",'<div class="centered"><img alt="Crying" src="${ctx}/img/merchandise/origonal/no_pic.png"><h2>没有数据哦</h2></div>');

            $.fn.zTree.init($("#tree"), setting, ${menus});
            var zTree = $.fn.zTree.getZTreeObj("tree");

            $("#checkAll").click(function(){
                zTree.checkAllNodes(true);
            })
            $("#checkNone").click(function(){
                zTree.checkAllNodes(false);
            })



            function addFunction(){
                zTree.checkAllNodes(false);//全部取消勾选
                editing.add({state:1});//添加记录
            }

            function editFunction(){
                var selections = grid.getSelection();
                if(selections.length==1){
                    zTree.checkAllNodes(false);//全部取消勾选
                    var selected = selections[0];
                    $("#roleName").attr("readonly",false);
                    $("#roleCode").attr("readonly",false);
                    editing.edit(selected);

                    if(selected.permission != null){
                        var permissions = selected.permission.split(',');
                        var pNode;
                        for(var i=0;i<permissions.length;i++){
                            var perArr = permissions[i].split(":");
                            if(perArr[0]){
                                pNode = zTree.getNodeByParam('menuCode',perArr[0],null);
                                if(pNode!=null){
                                    zTree.checkNode(pNode,true,false);
                                    continue;
                                }
                            }
                        }

                        for(var i=0;i<permissions.length;i++){
                            var perArr = permissions[i].split(":");
                            if(perArr[0]){
                                if(pNode.menuCode!=perArr[0]){
                                    var node = zTree.getNodeByParam('menuCode',perArr[0],pNode);
                                    if(node!=null){
                                        zTree.checkNode(node,true,false);
                                    }
                                }
                            }
                        }




//                        if(pNode!=null){
//                            var node = zTree.getNodeByParam('menuCode',perArr[0],pNode);
//                            zTree.checkNode(node,true,true);
//                        }
                    }
                }else{
                    BUI.Message.Alert("请选中一条记录！");
                }
            }

            function delFunction(){
                var selections = grid.getSelection();
                if(selections.length>=1){
                    var ids = [];
                    BUI.each(selections,function(item){
                        ids.push(item.roleId);
                    });
                    if(ids.length){
                        BUI.Message.Confirm('确认要删除选中的记录么？',function(){
                            $.ajax({
                                url : '${ctx}/role/delete',
                                type:'post',
                                dataType : 'json',
                                data : {ids : ids.join(',')},
                                success : function(data){
                                    if(data.success){ //删除成功
                                        search.load();
                                    }else{ //删除失败
                                        BUI.Message.Alert(data.msg,'error');
                                    }
                                }
                            });
                        },'question');
                    }
                }else{
                    BUI.Message.Alert("未选中任何记录！");
                }
            }
            function submit(record,editor){
                $.ajax({
                    url : record.roleId == undefined ? '${ctx}/role/add':'${ctx}/role/update',
                    dataType : 'json',
                    type : 'post',
                    data : record ,
                    success : function(data){
                        if(data.success){ //编辑、新建成功
                            editor.accept();//隐藏弹出框
                            search.load();
                        }else{//编辑失败
                            var msg = data.msg;
                            BUI.Message.Alert('错误原因：'+ msg);
                        }
                    }
                });
            }



    });
    </script>
</body>
</html>