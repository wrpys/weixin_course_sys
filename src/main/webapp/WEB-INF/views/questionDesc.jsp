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
</div>
<br><br><br><br>
<script type="text/javascript">
    var wId = "${wId}";
    var sId = "${sId}";
    BUI.use(['common/search','bui/list','bui/picker','bui/select','bui/overlay'],function (Search,List,Picker,Select,Overlay) {
        var
                columns = [
                    { title: '题目标题', width: 150, dataIndex: 'qTitle'},
                    { title: '题目正确答案', width: 250, dataIndex: 'correctAnswer'},
                    { title: '学生选择答案', width: 250, dataIndex: 'qAnswer'}
                ],
                store = Search.createStore('${ctx}/work/getQuestionDesc?wId=' + wId + "&sId=" + sId,{pageSize:10}),
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
                gridCfg = Search.createGridCfg(columns,{});
        var  search = new Search({
                    store : store,
                    gridCfg : gridCfg
                }),
                grid = search.get('grid');
        grid.set("emptyDataTpl",'<div class="centered"><img alt="Crying" src="${ctx}/img/merchandise/origonal/no_pic.png"><h2>没有数据哦</h2></div>');
        editing.on("editorshow",function(ev){
            var record = editing.get('record');
        })
    });//seajs end

</script>
<!-- script end -->
</body>
</html>