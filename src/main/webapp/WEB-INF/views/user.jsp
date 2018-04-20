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
                    <label class="control-label">账号：</label>
                    <div class="controls">
                        <input type="text" class="control-text" name="loginName">
                    </div>
                </div>
                <div class="control-group span8">
                    <label class="control-label">昵称：</label>
                    <div class="controls">
                        <input type="text" class="control-text" name="nickName">
                    </div>
                </div>
                <div class="control-group span9">
                    <label class="control-label">创建时间：</label>
                    <div class="controls">
                        <input type="text" class="calendar" name="startDate">
                        <span> - </span>
                        <input type="text" class="calendar" name="endDate">
                    </div>
                </div>
                <div class="control-group span8">
                    <label class="control-label">角色：</label>
                    <div class="controls">
                        <select name="userRole">
                            <option value="">请选择</option>
                            <c:forEach items="${roleList}" var="role">
                                <option value="${role.roleId}">${role.roleName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="control-group span8">
                    <label class="control-label">状态：</label>
                    <div class="controls">
                        <select name="state">
                            <option value="">请选择</option>
                            <option value="0">禁用</option>
                            <option value="1">正常</option>
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
                <div class="row">
                    <div class="control-group span8">
                        <label class="control-label"><s>*</s>账号：</label>
                        <div class="controls">
                            <input name="loginName" type="text" data-rules="{required:true}" class="input-normal control-text">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group span8">
                        <label class="control-label"><s>*</s>昵称：</label>
                        <div class="controls">
                            <input name="nickName" type="text" data-rules="{required:true}" class="input-normal control-text">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group span8">
                        <label class="control-label"><s>*</s>角色：</label>
                        <div class="controls">
                            <div id="roleSelect">
                                <input type="hidden" id="hide" value="" name="userRole" data-rules="{required:true}">
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

    </div>
    <br><br><br><br>
    <script type="text/javascript">
        BUI.use(['common/search','bui/list','bui/picker','bui/select'],function (Search,List,Picker,Select) {
              var
              enumState = {"1":"正常","0":"禁用"},
              columns = [
                { title: '账户名称', width: 150, dataIndex: 'loginName'},
                { title: '昵称', width: 100, dataIndex: 'nickName'},
                { title: '角色', width: 100, dataIndex: 'roleName'},
                { title: '状态', width: 100, dataIndex: 'state',renderer:BUI.Grid.Format.enumRenderer(enumState)},
                { title: '创建时间', width: 150, dataIndex: 'createTime'},
                { title: '创建人', width: 100, dataIndex: 'createName'}
              ],
                store = Search.createStore('${ctx}/user/list',{pageSize:15}),
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
                                text: '<i class="icon-remove"></i>启用/禁用',
                                listeners : {
                                    'click' : changeFunction
                                }
                            },{
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

            editing.on("editorshow",function(ev){
                var record = editing.get('record');
                $("#roleSelect").find(".bui-select-input").val(record.roleName);
            })
            function addFunction(){
                editing.add({state:1});
            }
            function editFunction(){
                var selections = grid.getSelection();
                editing.edit(selections[0]);
                if(selections.length==0){
                    BUI.Message.Alert("请选中一条记录！");
                }

            }

            function changeFunction(){
                var selections = grid.getSelection();
                if(selections.length==1){
                    var selected = selections[0];
                    var confirmStr = "确认要启用该用户？";
                    if(selected.state==1){
                        confirmStr = "确认要禁用该用户？";
                    }
                    BUI.Message.Confirm(confirmStr,function(){
                        $.ajax({
                            url : '${ctx}/user/changeState',
                            type:'post',
                            dataType : 'json',
                            data : selected,
                            success : function(data){
                                if(data.success){
                                    search.load();
                                    BUI.Message.Alert('修改成功！');
                                }else{
                                    BUI.Message.Alert('修改失败！');
                                }
                            }
                        });
                    },'question');
                }else{
                    BUI.Message.Alert("请选中一条记录！");
                }
            }

            function resetFunction(){
                var selections = grid.getSelection();
                var ids = [];
                BUI.each(selections,function(item){
                    ids.push(item.userId);
                });
                if(ids.length){
                    BUI.Message.Confirm('确认要重置密码吗？',function(){
                        $.ajax({
                            url : '${ctx}/user/resetPassword',
                            type:'post',
                            dataType : 'json',
                            data : {ids : ids.join(',')},
                            success : function(data){
                                if(data.success){
                                    BUI.Message.Alert('重置成功！');
                                }else{
                                    BUI.Message.Alert('重置失败！');
                                }
                            }
                        });
                    },'question');
                }
            }
            function submit(record,editor){
                console.log(record);
                $.ajax({
                    url : record.userId==undefined?'${ctx}/user/add':'${ctx}/user/update',
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

            var roles = ${roles};
            var list = new List.SimpleList({
                        elCls: 'bui-select-list',
                        idField:'roleId',
                        items: roles,
                        itemTpl: '<li role="option" class="bui-list-item" value="{roleId}">{roleName}</li>'
                    }),
                    picker = new Picker.ListPicker({
                        children: [list]
                    })
                    select = new Select.Select({
                        render:'#roleSelect',
                        valueField: '#hide',
                        multipleSelect:false,
                        picker : picker
                    });
            select.render();
        });//seajs end
    </script>
<!-- script end -->
</body>
</html>