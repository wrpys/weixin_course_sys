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
                <label class="control-label">题目：</label>
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
            <input type="hidden" name="qId">
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>题目：</label>
                    <div class="controls">
                        <input name="qTitle" type="text" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label">类型：</label>
                    <div class="controls">
                        <label class="radio"><input name="qType" id="qType1" type="radio" value="1" checked />单选</label>&nbsp;&nbsp;&nbsp;
                        <label class="radio"><input name="qType" id="qType2" type="radio" value="2"/>文本</label>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div id="J_AnswerContent" class="hide">
        <iframe id="answerManager" src="#" width="100%" height="100%" frameborder="0" style="border: none;"></iframe>
    </div>

</div>
<br><br><br><br>
<script type="text/javascript">
    BUI.use(['common/search','bui/list','bui/picker','bui/select','bui/overlay'],function (Search,List,Picker,Select,Overlay) {
        var
                enumType = {1:"单选",2:"文本"},
                columns = [
                    { title: 'ID', width: 100, dataIndex: 'qId'},
                    { title: '题目', width: 500, dataIndex: 'qTitle'},
                    { title: '类型', width: 100, dataIndex: 'qType',renderer:BUI.Grid.Format.enumRenderer(enumType)},
                    { title: '操作', width: 200, dataIndex: 'cId',renderer : function(value,obj){
                        var returnStr = '<span class="grid-command editAnswer">编辑答案</span>';
                        return returnStr;
                    }}
                ],
                store = Search.createStore('${ctx}/questionAnswer/questionList',{pageSize:10}),
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
            editing.add({});
            $("#qType1").prop("checked",true);
        }
        function editFunction(){
            var selections = grid.getSelection();
            if(selections.length!=1){
                BUI.Message.Alert("请选中一条记录！");
                return;
            }

            editing.edit(selections[0]);
            if(selections[0].qType==1){
                $("#qType1").prop("checked",true);
            }else{
                $("#qType2").prop("checked",true);
            }
        }

        function delFunction(){
            var selections = grid.getSelection();
            if(selections.length==1){
                BUI.Message.Confirm('确认要删除选中的记录么？',function(){
                    $.ajax({
                        url : '${ctx}/questionAnswer/deleteQuestion',
                        type:'post',
                        dataType : 'json',
                        data : {qId : selections[0].qId},
                        success : function(data){
                            if(data.success){ //删除成功
                                search.load();
                            }else{ //删除失败
                                BUI.Message.Alert(data.msg,'error');
                            }
                        }
                    });
                },'question');
            }else{
                BUI.Message.Alert("请选择一条记录！");
            }
        }

        function submit(record,editor){
            console.log(record);
            $.ajax({
                url : record.qId==''?'${ctx}/questionAnswer/addQuestion':'${ctx}/questionAnswer/updateQuestion',
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

        /*****************************操作******************************************************/
        var answerDialog;
        grid.on('cellclick',function  (ev) {
            var record = ev.record, //点击行的记录
                    field = ev.field, //点击对应列的dataIndex
                    target = $(ev.domTarget); //点击的元素
            if(target.hasClass('editAnswer')){
                if(!answerDialog){
                    answerDialog = createAnswerDialog();
                }
                $("#answerManager").attr("src", "${ctx}/questionAnswer/toAnswer?qId=" + record.qId + "&qType=" + record.qType);
                answerDialog.show();
            }
        });

        //创建弹出框
        function createAnswerDialog(){
            return new Overlay.Dialog({
                title:'编辑答案',
                width:850,
                height:500,
                contentId:'J_AnswerContent',
                success:function () {
                    var me = this;
                    me.close();
                }
            });
        }

    });//seajs end
</script>
<!-- script end -->
</body>
</html>