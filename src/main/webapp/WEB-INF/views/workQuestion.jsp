<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <%@include file="../layouts/default.jsp"%>
    <style>
        .importBtn{display: none;}
    </style>
</head>
<body>
<div class="container" style="height:auto;">
    <form id="searchForm" class="form-horizontal">
        <div class="row">
            <div class="control-group span8">
                <label class="control-label">题目标题：</label>
                <div class="controls">
                    <input type="text" class="control-text" name="qTitle">
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
        <form id="J_Form" class="form-horizontal">
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>题目ID：</label>
                    <div class="controls">
                        <input name="wId" type="hidden">
                        <input name="qId" type="text" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
        </form>
    </div>

</div>
<br><br><br><br>
<script type="text/javascript">
    var wId = "${wId}";
    BUI.use(['common/search','bui/list','bui/picker','bui/select','bui/overlay'],function (Search,List,Picker,Select,Overlay) {
        var
                columns = [
                    { title: '作业ID', width: 100, dataIndex: 'wId'},
                    { title: '作业名称', width: 250, dataIndex: 'wWorkName'},
                    { title: '题目ID', width: 100, dataIndex: 'qId'},
                    { title: '题目标题', width: 250, dataIndex: 'qTitle'}
                ],
                store = Search.createStore('${ctx}/work/workQuestionList?wId=' + wId,{pageSize:10}),
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
                                text: '<i class="icon-remove"></i>删除',
                                listeners : {
                                    'click' : delFunction
                                }
                            }
                        ]
                    },
                    plugins: [BUI.Grid.Plugins.CheckSelection,editing] //勾选插件
                });
        var  search = new Search({
                    store : store,
                    gridCfg : gridCfg
                }),
                grid = search.get('grid');
        grid.set("emptyDataTpl",'<div class="centered"><img alt="Crying" src="${ctx}/img/merchandise/origonal/no_pic.png"><h2>没有数据哦</h2></div>');
        editing.on("editorshow",function(ev){
            var record = editing.get('record');
        })

        function addFunction(){
            editing.add({state:1,wId:wId});
        }

        function delFunction(){
            var selections = grid.getSelection();
            if(selections.length>=1){
                if(selections.length){
                    BUI.Message.Confirm('确认要删除选中的记录么？',function(){
                        $.ajax({
                            url : '${ctx}/work/deleteWorkQuestion',
                            type:'post',
                            dataType : 'json',
                            data : {wqId : selections[0].wqId},
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
                BUI.Message.Alert("请选择一条记录！");
            }
        }

        function submit(record,editor){
            console.log(record);
            $.ajax({
                url : '${ctx}/work/addWorkQuestion',
                dataType : 'json',
                type:'post',
                data : record,
                success : function(data){
                    if(data.success){ //编辑、新建成功
                        editor.accept(); //隐藏弹出框
                        search.load();
                    }else{ //编辑失败
                        var msg = data.msg;
                        BUI.Message.Alert('提示:' + msg);
                    }
                }
            });
        }
    });//seajs end

</script>
<!-- script end -->
</body>
</html>