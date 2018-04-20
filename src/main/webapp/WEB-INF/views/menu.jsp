<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML>
<html>
<head>
    <%@include file="../layouts/default.jsp"%>
    <style>
        .ztree {height:480px;overflow-y:auto;overflow-x:auto;}
    </style>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="span8 panel panel-small">
            <div class="panel-body">
                <div class="button-group">
                    <button id="menuTreeAddRoot" type="button" class="button button-small">
                        <i class="icon-plus"></i>添加根菜单
                    </button>
                    <button id="menuTreeAdd" type="button" class="button button-small">
                        <i class="icon-plus"></i>添加下级菜单
                    </button>
                    <div class="button button-small" id="menuTreeDelete">
                        <i class="icon-remove"></i>删除
                    </div>
                </div>
                <ul id="tree" class="ztree"></ul>
            </div>
        </div>

        <div class="span10 panel panel-small">
            <form id="menuForm" class="form-horizontal">
                <input name="menuId" type="hidden">
                <div class="control-group">
                    <label class="control-label"><s>*</s>代码：</label>
                    <div class="controls">
                        <input name="menuCode" type="text" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s>*</s>名称：</label>
                    <div class="controls">
                        <input name="menuName" data-rules="{required:true}" class="input-normal control-text" type="text">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">地址：</label>
                    <div class="controls">
                        <input name="menuLink" class="input-normal control-text" type="text">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">排序：</label>
                    <div class="controls">
                        <input name="sort" class="input-normal control-text" type="text">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">状态：</label>
                    <div class="controls">
                        <select name="state">
                            <option value="1">启用</option>
                            <option value="0">禁用</option>
                        </select>
                    </div>
                </div>
                <div class="form-actions actions-bar centered">
                    <button id="menuUpdate" type="button" class="button button-primary">保存</button>
                </div>
            </form>
        </div>

    </div>
</div>
<script type="text/javascript">

    BUI.use(['bui/overlay','bui/form','bui/select','bui/list','bui/picker','ztree/ztree'],function(Overlay,Form,Select,List,Picker){
        //=====================ztree=====================
        var setting = {
            data:{
                key:{
                    name:'menuName'
                },
                simpleData:{
                    enable:true,
                    idKey:'menuId',
                    pIdKey:'menuPid'
                }
            },
            callback:{
                onClick: onClick
            }
        };

        $.fn.zTree.init($("#tree"), setting, ${menus});
        var zTree = $.fn.zTree.getZTreeObj("tree");
        var node = zTree.getNodes()[0];
        zTree.expandNode(node,true,false,true);        //ztree end

        function onClick(event, treeId, treeNode, clickFlag) {
            var form= $('form')[0];
            BUI.FormHelper.setFields(form,treeNode);
        }

        //========================树编辑=============
        var menuForm = new Form.Form({
            height:511,
            srcNode : '#menuForm'
        }).render();

        //修改数据并全部提交
        $("#menuUpdate").click(function(){
            var selected = zTree.getSelectedNodes();
            if(selected.length==0){
                return false;
            }
            var form= $('form')[0];
            var data = BUI.FormHelper.serializeToObject(form);
            if(!menuForm.isValid()){
                return false;
            }
            $.ajax({
                url: "${ctx}/menu/update",
                type:'POST',
                async:false,
                dataType:'json',
                data:data,
                //获取返回的node值，更新znode
                success:function(json){
                    if(json.success){
                        BUI.Message.Alert('提交成功','success');
                        var menu = json.menu;

                        BUI.mix(selected[0],menu);

                        zTree.updateNode(selected[0]);
                    }else{
                        BUI.Message.Alert(json.msg,'error');
                    }
                }
            });
        });

        //添加根节点
        $("#menuTreeAddRoot").click(function(){
            var treeNode={menuPid:0,menuName:"新建根节点菜单",menuCode: $.now()};
            $.ajax({
                url:"${ctx}/menu/add",
                type:"POST",
                async:false,
                dataType:'json',
                data:treeNode,
                success:function(data){
                    if(data.success){
                        BUI.Message.Alert('添加成功','success');
                        zTree.addNodes(null,data.menu);
                        zTree.updateNode(treeNode);
                    }else{
                        BUI.Message.Alert(data.msg,'error');
                    }
                }
            })
        });

        //添加下级节点
        $("#menuTreeAdd").click(function(){
            var nodes = zTree.getSelectedNodes();
            if(nodes.length==0){
                BUI.Message.Alert('请先选择一个节点','info');
            }
            var treeNode={menuPid:nodes[0].menuId,menuName:"新建菜单",menuCode: $.now()};
            $.ajax({
                url:"${ctx}/menu/add",
                type:"POST",
                async:false,
                dataType:'json',
                data:treeNode,
                success:function(data){
                    if(data.success){
                        BUI.Message.Alert('添加成功','success');
                        zTree.addNodes(nodes[0],data.menu);
                        zTree.updateNode(nodes[0]);
                    }else{
                        BUI.Message.Alert(data.msg,'error');
                    }
                }
            })
        });

        //删除节点
        $("#menuTreeDelete").click(function(){
            var nodes = zTree.getSelectedNodes();
            if(nodes.length==0){
                BUI.Message.Alert('请先选择一个节点');
            }
            BUI.Message.Confirm('确认要删除此菜单吗？',function(){
                $.ajax({
                    url:"${ctx}/menu/delete",
                    type:"POST",
//                    async:false,
                    dataType:'json',
                    data:{'ids':nodes[0].menuId},
                    success:function(data){
                        if(data.success){
                            BUI.Message.Alert('删除成功','success');
                            zTree.removeNode(nodes[0]);
                        }else{
                            BUI.Message.Alert(data.msg,'error');
                        }
                    }
                });
            });
        });
    });//end
</script>
</body>
</html>