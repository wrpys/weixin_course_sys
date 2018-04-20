<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <%@include file="../layouts/default.jsp"%>
</head>
<body>
<div class="container" style="height:auto;">
    <div class="search-grid-container">
        <div id="grid"></div>
    </div>

    <div id="content" class="hide">
        <form id="J_Form" class="form-horizontal">
            <input type="hidden" name="aId">
            <input type="hidden" name="qId">
            <c:if test="${qType==1}">
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>答案：</label>
                     <div class="controls">
                        <input name="aAnswer" type="text" data-rules="{required:true}" class="input-normal control-text">
                     </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label">正确答案：</label>
                    <div class="controls">
                        <label class="radio"><input name="aCorrect" id="aCorrect1" type="radio" value="1" checked />是</label>&nbsp;&nbsp;&nbsp;
                        <label class="radio"><input name="aCorrect" id="aCorrect2" type="radio" value="0"/>否</label>
                    </div>
                </div>
            </div>
            </c:if>
                <c:if test="${qType==2}">
                <div class="row">
                    <label class="control-label"><s>*</s>答案：</label>
                    <div class="controls control-row2">
                        <textarea name="aAnswer" class="input-large" type="text"></textarea>
                    </div>
                    <input type="hidden" name="aCorrect" id="aCorrect">
                </div>
                </c:if>
        </form>
    </div>

</div>
<br><br><br><br>
<script type="text/javascript">
    var qId = "${qId}";
    var qType = "${qType}";
    BUI.use(['common/search','bui/list','bui/picker','bui/select','bui/overlay'],function (Search,List,Picker,Select,Overlay) {
        var
                enumType = {1:"是",0:"否"},
                columns = [
                    { title: 'ID', width: 100, dataIndex: 'aId'},
                    { title: '题目', width: 500, dataIndex: 'aAnswer'},
                    { title: '是否为正常答案', width: 80, dataIndex: 'aCorrect',renderer:BUI.Grid.Format.enumRenderer(enumType)},
                ],
                store = Search.createStore('${ctx}/questionAnswer/answerList?qId=' + qId,{pageSize:10}),
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
            editing.add({qId: qId});
            if (qType == "1") {
                $("#aCorrect2").prop("checked",true);
            } else {
                $("#aCorrect").val(1);
            }
        }
        function editFunction(){
            var selections = grid.getSelection();
            if(selections.length!=1){
                BUI.Message.Alert("请选中一条记录！");
                return;
            }
            editing.edit(selections[0]);
            if (qType == "1") {
                if(selections[0].aCorrect==1){
                    $("#aCorrect1").prop("checked",true);
                }else{
                    $("#aCorrect2").prop("checked",true);
                }
            } else {
                $("#aCorrect").val(1);
            }

        }

        function delFunction(){
            var selections = grid.getSelection();
            if(selections.length==1){
                BUI.Message.Confirm('确认要删除选中的记录么？',function(){
                    $.ajax({
                        url : '${ctx}/questionAnswer/deleteAnswer',
                        type:'post',
                        dataType : 'json',
                        data : {aId : selections[0].aId},
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
                url : record.aId==''?'${ctx}/questionAnswer/addAnswer':'${ctx}/questionAnswer/updateAnswer',
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