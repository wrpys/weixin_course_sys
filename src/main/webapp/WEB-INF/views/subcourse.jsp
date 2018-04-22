<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <%@include file="../layouts/default.jsp"%>
    <style>
        .importBtn{display: none;}
        .timeLeftDiv,.timeRightDiv,.leftDiv,.rightDiv{float: left;margin: 0;padding: 5px;}

        .timeLeftDiv{width: 34%;height: 95%;overflow-y: scroll;}
        .timeRightDiv{width: 61%;height: 95%;margin-left: 1%;overflow-y: scroll;}

        .leftDiv{width: 71%;height: 95%;overflow-y: scroll;}
        .rightDiv{width: 24%;height: 95%;margin-left: 1%;overflow-y: scroll;}

        .panelHeight{height: 180px;overflow-y: scroll;}

        .studentList{width: 100%;height:95%;list-style: none;overflow-y: scroll;}
        .studentList li{width: 100%;height: 30px;margin-top: 5px;border-bottom: 1px solid #ff0000;padding: 0 0 5px 10px;}
        .studentList li p{text-align: left;font-size: 16px;}
        .studentList li div{width:15%;text-align: left;float: left;}
        .optionleft{width:30%;}
    </style>
</head>
<html>
<body>
<div class="container" style="height:auto;">
    <form id="searchForm" class="form-horizontal">
        <div class="row">
            <div class="control-group span8">
                <label class="control-label">子课程名字：</label>
                <div class="controls">
                    <input type="text" class="control-text" name="cName">
                </div>
            </div>
            <div class="control-group span12">
                <label class="control-label">添加时间：</label>
                <div class="controls">
                    <input type="text" class="calendar-time" name="startDate">
                    <span> - </span>
                    <input type="text" class="calendar-time" name="endDate">
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
            <input type="hidden" name="cId">
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>子课程名称：</label>
                    <div class="controls">
                        <input name="cName" type="text"  data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span8" style="height: 200px;">
                    <label class="control-label"><s>*</s>子课程描述：</label>
                    <div class="controls">
                        <textarea name="cDesc" data-rules="{required:true}" style="height: 150px;"></textarea>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <!-- 上传课件 -->
    <%-- <div id="J_uoloadFileContent" class="hide">
        <div class="panel panelHeight">
           	<form id="uploadFile" action="${ctx}/course/uploadFile" method="post" enctype="multipart/form-data">
			    选择一个文件:
			    <input type="file" name="file" id="file" />
			    <br/><br/>
			    <button type="submit" id="submit" class="button button-primary">上传</button>
			</form>
        </div>
    </div> --%>
    <div id="J_uoloadFileContent" class="hide">
        <iframe id="uploadFileManager" src="#" width="100%" height="100%" frameborder="0" style="border: none;"></iframe>
    </div>
    
</div>
<br><br><br><br>
<script type="text/javascript">
var addStudentCourse;
var delStudentCourse;
var tableContent = [];
var timeContent = [];
var delTimeContent = [];
var deleteTime;
var CID;
var CTID;
var parentSearch = null;
BUI.use(['common/search','bui/list','bui/picker','bui/select','bui/calendar','bui/overlay','bui/data','bui/grid','bui/calendar'],function (Search,List,Picker,Select,Calendar,Overlay,Data,Grid,Calendar) {
	var Grid = Grid,
    Store = Data.Store;
    var datepicker = new Calendar.DatePicker({
        trigger:'.calendar-time',
        showTime:true,
        autoRender : true
    });

    //上课时间选择日历插件
    var calendar = new Calendar.Calendar({
        render:'#calendar',
        width:'100%'
    });

    var
            columns = [
                { title: '课程名字', width: 200, dataIndex: 'cName'},
                { title: '添加时间', width: 200, dataIndex: 'cCreateTime'},
                { title: '课程描述', width: 100, dataIndex: 'cDesc'},
                { title: '课件名字', width: 100, dataIndex: 'fName'},
                { title: '下载次数', width: 100, dataIndex: 'downloadNum'},
                { title: '热度', width: 100, dataIndex: 'heatNum'},
                { title: '操作', width: 300, dataIndex: 'cId',renderer : function(value,obj){
                    var returnStr = '<span class="grid-command uploadFile">上传课件</span>&nbsp;&nbsp;';
                    return returnStr;
                }}
            ],
            store = Search.createStore('${ctx}/course/list?cPid=${cId}',{pageSize:15}),
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
    parentSearch = search;
    grid.set("emptyDataTpl",'<div class="centered"><img alt="Crying" src="${ctx}/img/merchandise/origonal/no_pic.png"><h2>没有数据哦</h2></div>');

    editing.on("editorshow",function(ev){
        var record = editing.get('record');
    })

    function addFunction(){
        editing.add({state:1});
    }
    function editFunction(){
        var selections = grid.getSelection();
        if(selections.length == 0 || selections.length > 1){
            BUI.Message.Alert("请选中一条记录！");
            return;
        }

        editing.edit(selections[0]);
        $("#aaPid").val(selections[0].aaPid);
        //getChild($("#aaPid option[value="+selections[0].aaPid+"]"));
        $('#aaId').val(selections[0].aaId);
        $("#flag").val(0);//标志普通和特殊(初始化)
        var J_Form = $("#J_Form");
        J_Form.find('input[name="cName"]').attr('readonly',false);
    }

 /*****************************操作******************************************************/
    var uploadFileDialog;
    grid.on('cellclick',function  (ev) {
        var record = ev.record, //点击行的记录
                field = ev.field, //点击对应列的dataIndex
                target = $(ev.domTarget); //点击的元素
        CID = record.cId;
        if(target.hasClass('uploadFile')){
            if(!uploadFileDialog){
            	uploadFileDialog = createUploadFileDialog();
            }
            $("#uploadFileManager").attr("src", "${ctx}/course/toUpLoadFile?cId=" + record.cId);
            uploadFileDialog.show();
            $(".bui-stdmod-footer").hide();
        }
    });
    
  	//创建弹出框
    function createUploadFileDialog(){
        return new Overlay.Dialog({
            title:'上传文件',
            width:650,
            height:250,
            contentId:'J_uoloadFileContent',
            success:function () {
            	var me = this;
                me.close();
                alert("上传成功!");
            }
        });
    }
    
    

    function delFunction(){
        var selections = grid.getSelection();
        if(selections.length>=1){
            var ids = [];
            BUI.each(selections,function(item){
                ids.push(item.cId);
            });
            if(ids.length){
                BUI.Message.Confirm('确认要删除选中的记录么？',function(){
                    $.ajax({
                        url : '${ctx}/course/delete',
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
        record.cPid = '${cId}';
        $.ajax({
            url : (record.cId==undefined||record.cId==null||record.cId=='')?'${ctx}/course/add':'${ctx}/course/update',
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

//判断上课时间是否重复
function timeContains(data){
    if(timeContent!=''&&timeContent!=null&&timeContent!=undefined){
        for(var i=0,len=timeContent.length;i<len;i++){
            if(data==timeContent[i].ctTime){
                return true;
            }
        }
        return false;
    }
}

//*   判断在数组中是否含有给定的一个变量值
//*   参数：
//*   obj：需要查询的值
//*    a：被查询的数组
//*   在a中查询obj是否存在，如果找到返回true，否则返回false。
//*   此函数只能对字符和数字有效
function contains(a, obj) {
    for (var i = 0,len = a.length; i < len; i++) {
        if (a[i].sId == obj.sId) {
            return true;
        }
    }
    return false;
}

// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
// 例子：
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
Date.prototype.Format = function(fmt)
{ //author: meizz
    var o = {
        "M+" : this.getMonth()+1,                 //月份
        "d+" : this.getDate(),                    //日
        "h+" : this.getHours(),                   //小时
        "m+" : this.getMinutes(),                 //分
        "s+" : this.getSeconds(),                 //秒
        "q+" : Math.floor((this.getMonth()+3)/3), //季度
        "S"  : this.getMilliseconds()             //毫秒
    };
    if(/(y+)/.test(fmt))
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
        if(new RegExp("("+ k +")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;
}

//获取时间所在周几
function getWeekDay(data){
    var myDate = new Date(Date.parse(data.replace(/-/g, "/")));
    var weekDay = ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
    return weekDay[myDate.getDay()];
}

</script>
<!-- script end -->
</body>
</html>