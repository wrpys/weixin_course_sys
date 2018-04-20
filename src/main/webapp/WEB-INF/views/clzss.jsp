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
    <div class="search-grid-container">
        <div id="grid"></div>
    </div>

    <div id="content" class="hide">
        <form id="J_Form" class="form-horizontal">
            <input type="hidden" name="id">
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>年段：</label>
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
        </form>
    </div>
</div>
<br><br><br><br>
<script type="text/javascript">

//上传文件的回显,显示导入按钮
function displayFileName(excel_fileName,excel_realName){
    $('#excel_realName').html("文件： "+excel_realName);
    $('#excel_fileName').val(excel_fileName);
    $('.importBtn').show(); //如果有xls导入的功能
}

    var searchTemp;
    BUI.use(['common/search','bui/list','bui/picker','bui/select','bui/overlay'],function (Search,List,Picker,Select,Overlay) {
        var
                columns = [
                    { title: '年级', width: 100, dataIndex: 'grade'},
                    { title: '班级', width: 100, dataIndex: 'clzss'}
                ],
                store = Search.createStore('${ctx}/clzss/list',{pageSize:10}),
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
        searchTemp = search;
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
            //$("#dPid").val(selections[0].dPid);
            //getChild($("#dPid option[value="+selections[0].dPid+"]"),2);
            $('#id').val(selections[0].id);
            console.log(selections[0])
        }

        function delFunction(){
            var selections = grid.getSelection();
            if(selections.length>=1){
                var ids = [];
                BUI.each(selections,function(item){
                    ids.push(item.id);
                });
                if(ids.length){
                    BUI.Message.Confirm('确认要删除选中的记录吗?',function(){
                        $.ajax({
                            url : '${ctx}/clzss/deleteBatchs',
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
            console.log(record);
            $.ajax({
                url : record.id==''?'${ctx}/clzss/add':'${ctx}/clzss/update',
           		dataType : 'json',
                type:'post',
                data : {id:record.id,grade:record.grade,clzss:record.clzss},
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
</body>
</html>