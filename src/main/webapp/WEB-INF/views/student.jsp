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
                <label class="control-label">学号：</label>
                <div class="controls">
                    <input type="text" class="control-text" name="sNo">
                </div>
            </div>
            <div class="control-group span8">
                <label class="control-label">姓名：</label>
                <div class="controls">
                    <input type="text" class="control-text" name="sName">
                </div>
            </div>

            <div class="control-group span8">
                <label class="control-label">班级：</label>
                <div class="controls bui-form-group-select">
                    <select class="input-small" name="clzssId">
                        <option value="" selected="selected">请选择</option>
                        <c:forEach items="${clzssList}" var="clzss">
                            <option value="${clzss.id}">${clzss.grade}-${clzss.clzss}</option>
                        </c:forEach>
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
        <form id="J_Form" class="form-horizontal">
            <input type="hidden" name="sId">
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>学号：</label>
                    <div class="controls">
                        <input name="sNo" type="text" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>姓名：</label>
                    <div class="controls">
                        <input name="sName" type="text" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label">性别：</label>
                    <div class="controls">
                        <label class="radio"><input name="sSex" id="sSex1" type="radio" value="0" checked />男</label>&nbsp;&nbsp;&nbsp;
                        <label class="radio"><input name="sSex" id="sSex2" type="radio" alue="1"/>女</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>班级：</label>
                    <div class="controls bui-form-group-select">
                        <select class="input-small" name="clzssId" id="clzssId" >
                            <option value="" selected="selected">请选择</option>
                            <c:forEach items="${clzssList}" var="clzss">
                                <option value="${clzss.id}">${clzss.grade}-${clzss.clzss}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
        </form>
    </div>

</div>
<br><br><br><br>
<script type="text/javascript">
    BUI.use(['common/search','bui/list','bui/picker','bui/select','bui/overlay'],function (Search,List,Picker,Select,Overlay) {
        var
                enumSex = {"true":"女","false":"男"},
                columns = [
                    { title: '学号', width: 150, dataIndex: 'sNo'},
                    { title: '姓名', width: 150, dataIndex: 'sName'},
                    { title: '性别', width: 100, dataIndex: 'sSex',renderer:BUI.Grid.Format.enumRenderer(enumSex)},
                    { title: '年级', width: 100, dataIndex: 'grade'},
                    { title: '班级', width: 100, dataIndex: 'clzss'}
                ],
                store = Search.createStore('${ctx}/student/list',{pageSize:10}),
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
                            ,{
                                btnCls: 'button button-small',
                                text: '<i class="icon-repeat"></i>重置密码',
                                listeners : {
                                    'click' : resetFunction
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
            editing.add({state:1});
            $("#sSex1").prop("checked",true);
        }
        function editFunction(){
            var selections = grid.getSelection();
            if(selections.length!=1){
                BUI.Message.Alert("请选中一条记录！");
                return;
            }
            editing.edit(selections[0]);
            if(selections[0].sSex==false){
                $("#sSex1").prop("checked",true);
            }else{
                $("#sSex2").prop("checked",true);
            }
        }

        function delFunction(){
            var selections = grid.getSelection();
            if(selections.length>=1){
                if(selections.length){
                    BUI.Message.Confirm('确认要删除选中的记录么？',function(){
                        $.ajax({
                            url : '${ctx}/student/delete',
                            type:'post',
                            dataType : 'json',
                            data : {sId : selections[0].sId},
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

        function resetFunction(){
            var selections = grid.getSelection();
            if(selections.length == 1){
                BUI.Message.Confirm('确认要重置密码吗？',function(){
                    $.ajax({
                        url : '${ctx}/student/resetPassword',
                        type:'post',
                        dataType : 'json',
                        data : {sId : selections[0].sId},
                        success : function(data){
                            if(data.success){
                                BUI.Message.Alert('重置成功！');
                            }else{
                                BUI.Message.Alert('重置失败！');
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
                url : record.sId==''?'${ctx}/student/add':'${ctx}/student/update',
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