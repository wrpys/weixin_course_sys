<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <%@include file="../layouts/default.jsp"%>
</head>
<body>
<div class="container" style="height:auto;">
    <form id="searchForm" class="form-horizontal">
        <div class="row">
            <div class="control-group span8">
                <label class="control-label">学生：</label>
                <div class="controls">
                    <input type="text" class="control-text" name="studentName">
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
            <input type="hidden" name="wId">
            <input type="hidden" name="msgPid">
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>回复：</label>
                    <div class="controls">
                        <input name="msgContent" type="text" data-rules="{required:true}" class="input-normal control-text">
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
                    { title: '学生', width: 70, dataIndex: 'studentName'},
                    { title: '提问', width: 250, dataIndex: 'studentContent'},
                    { title: '提问时间', width: 160, dataIndex: 'studentCreateTime'},
                    { title: '作业', width: 200, dataIndex: 'wWorkName'},
                    { title: '老师', width: 70, dataIndex: 'teacherName'},
                    { title: '回复', width: 250, dataIndex: 'teacherContent'},
                    { title: '回复时间', width: 160, dataIndex: 'teacherCreateTime'}
                ],
                store = Search.createStore('${ctx}/message/questionMessageList?wId='+wId,{pageSize:10}),
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
                                text: '<i class="icon-plus"></i>回复',
                                listeners : {
                                    'click' : addFunction
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
            var selections = grid.getSelection();
            if(selections.length!=1){
                BUI.Message.Alert("请选中一条记录！");
                return;
            } else {
                var row = selections[0];
                if (row.teacherName) {
                    BUI.Message.Alert("已经回复过，无法再回复！");
                    return;
                }
                editing.edit({wId: row.wId, msgPid: row.msgId});
//                $("input[name='wId']").val(row.wId);
//                $("input[name='msgPid']").val(row.msgId);
//                console.log(row)
//                console.log($("input[name='wId']").val())
//                editing.add({});
            }
        }

        function submit(record,editor){
            $.ajax({
                url : '${ctx}/message/replyQuestion',
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