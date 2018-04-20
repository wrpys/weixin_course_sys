<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
<head>
    <%@include file="../layouts/default.jsp"%>
</head>
<body>
<div class="container">
    <form id="searchForm" class="form-horizontal">
        <div class="row">
            <div class="control-group span8">
                <label class="control-label">作业名称：</label>
                <div class="controls">
                    <input type="text" class="control-text" name="wWorkName">
                </div>
            </div>
            <div class="control-group span8">
                <label class="control-label">作业要求：</label>
                <div class="controls">
                    <input type="text" class="control-text" name="wWorkRequirement">
                </div>
            </div>
            <div class="span3 offset2">
                <button  type="button" id="btnSearch" class="button button-primary">搜索</button>
            </div>
        </div>
    </form>

    <div class="search-grid-container">
        <div id="grid"></div>
    </div>

    <div id="content" class="hide">
        <form id="J_Form" class="form-horizontal">
        	<input type="hidden" name="wId">
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>作业名称：</label>
                    <div class="controls">
                    	<input type="text" data-rules="{required:true}" class="control-text" name="wWorkName">
                	</div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>年级：</label>
                    <div class="controls">
                        <input name="grade" type="text" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>班级：</label>
                    <div class="controls">
                        <input name="clzss" type="text" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span8" style="height: 200px;">
                    <label class="control-label"><s>*</s>作业要求：</label>
                    <div class="controls">
                        <textarea name="wWorkRequirement" style="height: 150px;"></textarea>
                    </div>
                </div>
            </div>
        </form>
    </div>

</div>
<script type="text/javascript">
BUI.use(['common/search','bui/list','bui/picker','bui/select','bui/calendar','bui/overlay','bui/data','bui/grid','bui/calendar'],function (Search,List,Picker,Select,Calendar,Overlay,Data,Grid,Calendar) {
        var columns = [
                { title : '作业名称', width: 200, dataIndex: 'wWorkName'},
                { title : '布置时间', width: 150, dataIndex: 'wAddTime'},
                { title : '作业要求', width: 300, dataIndex: 'wWorkRequirement'},
                { title: '操作', width: 250, dataIndex: 'wId',renderer : function(value,obj){
                    var returnStr = '<span class="grid-command editQuestion">编辑题目</span>' +
                            '<span class="grid-command questionMessage">答疑</span>' +
                            '<span class="grid-command discuss">参与讨论</span>' +
                            '<span class="grid-command searchWorkInfo">查看提交情况</span>';
                    return returnStr;
                }}
             ],
                store = Search.createStore('${ctx}/work/list',{pageSize:5}),
                editing = new BUI.Grid.Plugins.DialogEditing({
                    contentId : 'content',
                    triggerCls : 'btn-edit',
                    editor : {
                        success : function(){ //点击确认的时候触发，可以进行异步提交
                            var editor = this,
                                record = editing.get('record'),
                                data = editor.get('form').serializeToObject();
                            editor.valid();
                            if(editor.isValid()){
                                submit(BUI.mix(record,data),editor);
                            }
                        }
                    }
                }),
                gridCfg = Search.createGridCfg(columns,{
                    tbar: {
                        items: [
                            {
                                btnCls: 'button button-small',
                                text: '<i class="icon-plus"></i>添加',
                                listeners : {
                                    'click' : addFunction
                                }
                            },{
                                btnCls: 'button button-small',
                                text: '<i class="icon-edit"></i>修改',
                                listeners : {
                                    'click' : editFunction
                                }
                            },{
                                btnCls: 'button button-small',
                                text: '<i class="icon-remove"></i>删除',
                                listeners : {
                                    'click' : delFunction
                                }
                            }
                        ]
                    },
                    plugins: [BUI.Grid.Plugins.CheckSelection,editing,BUI.Grid.Plugins.AutoFit] //勾选插件
                });
        		var  search = new Search({
                    store : store,
                    gridCfg : gridCfg
                }),
                grid = search.get('grid');
                grid.set("emptyDataTpl",'<div class="centered"><img alt="Crying" src="${ctx}/img/merchandise/origonal/no_pic.png"><h2>没有数据哦</h2></div>');

        function addFunction(){
            editing.add({state:1}); //添加记录后，直接编辑
        }

        function editFunction(){
            var selections = grid.getSelection();
            if(selections.length==1){
                editing.edit(selections[0]);
            }else{
                BUI.Message.Alert("请选中一条记录！");
            }
        }

        function delFunction(){
            var selections = grid.getSelection();
            if(selections.length>=1){
                var ids = [];
                BUI.each(selections,function(item){
                    ids.push(item.wId);
                });
                if(ids.length){
                    BUI.Message.Confirm('确认要删除选中的记录吗？',function(){
                        $.ajax({
                            url : '${ctx}/work/delete',
                            type:'post',
                            dataType : 'json',
                            data : {ids : ids.join(',')},
                            success : function(data){
                                if(data.success){ //删除成功
                                    BUI.Message.Alert('删除成功！');
                                    search.load();
                                }else{ //删除失败
                                    BUI.Message.Alert('删除失败！');
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
                url : (record.wId==undefined||record.wId==null||record.wId=='')?'${ctx}/work/add':'${ctx}/work/update',
                dataType : 'json',
                type:'post',
                data : {clzss:record.clzss,grade:record.grade,
                	userTchId:record.userTchId,wId:record.wId,
                	wWorkName:record.wWorkName,wWorkRequirement:record.wWorkRequirement
                	},
                success : function(data){
                    if(data.success){ //编辑、新建成功
                        editor.accept(); //隐藏弹出框
                        search.load();
                    }else{ //编辑失败
                        var msg = data.msg;
                        BUI.Message.Alert('错误原因:' + msg);
                    }
                }
            });
        }
        /*****************************操作及查看作业提交情况******************************************************/
        grid.on('cellclick',function  (ev) {
            var record = ev.record, //点击行的记录
                    field = ev.field, //点击对应列的dataIndex
                    target = $(ev.domTarget); //点击的元素
            if(target.hasClass('searchWorkInfo')){
                window.parent.tabTemp.addTab({
                    id: 1001,
                    title: "成绩列表-" + record.wWorkName,
                    href: "${ctx}/work/toWorkAnalysis?wId=" + record.wId + "&clzssId=" + record.clzssId
                }, true);
            } else if (target.hasClass('editQuestion')) {
                window.parent.tabTemp.addTab({
                    id: 1002,
                    title: '编辑题目-' + record.wWorkName,
                    href: "${ctx}/work/toWorkQuestion?wId=" + record.wId
                }, true);
            } else if (target.hasClass('questionMessage')) {
                window.parent.tabTemp.addTab({
                    id: 1000 + record.wId,
                    title: '答疑-' + record.wWorkName,
                    href: "${ctx}/message/toQuestionMessage?wId=" + record.wId
                }, true);
            } else if (target.hasClass('discuss')) {
                window.parent.tabTemp.addTab({
                    id: 1000 + record.wId,
                    title: '参与讨论-' + record.wWorkName,
                    href: "${ctx}/message/toDiscuss?wId=" + record.wId
                }, true);
            }
        });

    }); //-----BUI end-----
</script>
<!-- script end -->
</body>
</html>