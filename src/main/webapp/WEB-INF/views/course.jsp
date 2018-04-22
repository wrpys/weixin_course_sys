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

        .panelHeight{height: 400px;overflow-y: scroll;}

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
                <label class="control-label">课程名字：</label>
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
                    <label class="control-label"><s>*</s>课程名称：</label>
                    <div class="controls">
                        <input name="cName" type="text"  data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span8" style="height: 200px;">
                    <label class="control-label"><s>*</s>课程描述：</label>
                    <div class="controls">
                        <textarea name="cDesc" data-rules="{required:true}" style="height: 150px;"></textarea>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div id="J_TimeContent" class="hide">
        <div class="timeLeftDiv panelHeight panel panel-small">
            <div id="calendar"></div>
        </div>
        <div class="timeRightDiv panel panel-small">
            <h3>上课时间列表:</h3>
            <table class="table" id="timeTable">
                <thead>
                    <tr>
                        <th>时间</th>
                        <th>周几</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="timeBody">

                </tbody>
            </table>
        </div>
    </div>
    <%--选课学生--%>
    <div id="J_StudentContent" class="hide">
        <div class="leftDiv panel panel-small">
            <div class="row">
                <div class="control-group span5">
                    <div class="controls">
                        <label class="control-label">学号：</label>
                        <input type="text" class="control-text" id="sNo">
                    </div>
                </div>
                <div class="control-group span6">
                    <div class="controls bui-form-group-select">
                        <label class="control-label">专业：</label>
                        <select class="input-small" onchange="getChild2(this);">
                            <option value="" selected="selected">系别</option>
                            <c:forEach items="${departments}" var="department">
                                <option value="${department.dId}">${department.dName}</option>
                            </c:forEach>
                        </select>&nbsp;&nbsp;
                        <select class="input-small" value="" id="dId">
                            <option value="" selected="selected">专业</option>
                        </select>
                    </div>
                </div>
                <div class="span3">
                    <button type="button" id="btnSearch2" class="button button-primary">搜索</button>
                </div>
            </div><br>
            <button class="button button-small" onclick="addStudentCourse();"><i class="icon-plus"></i>添加</button>
            <div id="J_ContentGrid" ></div>
        </div>
        <div class="rightDiv panel panel-small">
            <h3>学生列表:</h3>
            <table class="table" id="studentTable">
                <tr>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>操作</th>
                </tr>
            </table>
        </div>
    </div>
    <%--上课时间-出勤和作业提交--%>
    <div id="J_CourseTimeContent" class="hide">
        <div class="panel panelHeight">
            <div id="J_CourseTimeContentGrid" ></div>
        </div>
    </div>
    <%--出勤--%>
    <div id="J_StudentListContent" class="hide">
        <ul class="studentList">
            <form id="attendanceForm">
            </form>
        </ul>
    </div>
    <%--作业提交--%>
    <div id="J_WorkListContent" class="hide">
        <ul class="studentList">
            <form id="workForm">
            </form>
        </ul>
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
BUI.use(['common/search','bui/list','bui/picker','bui/select','bui/calendar','bui/overlay','bui/data','bui/grid','bui/calendar'],function (Search,List,Picker,Select,Calendar,Overlay,Data,Grid,Calendar) {

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
                /* { title: '课程号', width: 50, dataIndex: 'cId'}, */
                { title: '课程名字', width: 200, dataIndex: 'cName'},
                { title: '添加时间', width: 200, dataIndex: 'cCreateTime'},
                { title: '课程描述', width: 80, dataIndex: 'cDesc'},
                { title: '下载次数', width: 100, dataIndex: 'downloadNum'},
                { title: '热度', width: 100, dataIndex: 'heatNum'},
                { title: '操作', width: 300, dataIndex: 'cId',renderer : function(value,obj){
                    var returnStr = '<span class="grid-command addCourseTimeBtn">查看子课程</span>&nbsp;&nbsp;';
                        /* returnStr += '<span class="grid-command selCourseBtn">选课学生</span>&nbsp;&nbsp;';
                        returnStr += '<span class="grid-command attendanceAndWork">出勤和作业提交</span>'; */
                    return returnStr;
                }}
            ],
            store = Search.createStore('${ctx}/course/list',{pageSize:15}),
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
        editing.add({state:1});
    }
    function editFunction(){
        var selections = grid.getSelection();
        if(selections.length > 1){
            BUI.Message.Alert("请选中一条记录！");
            return;
        }

        editing.edit(selections[0]);
        $("#aaPid").val(selections[0].aaPid);
        getChild($("#aaPid option[value="+selections[0].aaPid+"]"));
        $('#aaId').val(selections[0].aaId);
        $("#flag").val(0);//标志普通和特殊(初始化)
        var J_Form = $("#J_Form");
        J_Form.find('input[name="cName"]').attr('readonly',false);
    }

/*****************************上课时间************************************************************/
//创建弹出框
    var timeDialog;
    function createTimeDialog(){
        return new Overlay.Dialog({
            title:'上课时间列表',
            width:850,
            height:500,
            contentId:'J_TimeContent',
            success:function () {
                var me = this;
                var selections = timeContent;
                if(selections.length>=1){
                    var cId = CID;
                    var ctIdAndTimes = [];
                    BUI.each(selections,function(item){
                        ctIdAndTimes.push(item.ctId + "=" + item.ctTime);
                    });
                    if(ctIdAndTimes.length){
                        $.ajax({
                            url : '${ctx}/course/updateCourseTime',
                            type:'post',
                            dataType : 'json',
                            data : {ctIdAndTimes : ctIdAndTimes.join(','),cId:cId,ctIds:delTimeContent.join(',')},
                            success : function(data){
                                console.log(data)
                                if(data.success){
                                    me.close();
                                    search.load();
                                }else{
                                    BUI.Message.Alert('操作失败！','error');
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    //渲染上课时间列表
    function rendererTimeList(){
        var timeListContent = "";
        $.each(timeContent,function(i,v){
            var data = v.ctTime;
            timeListContent +='<tr><td>' + data.substring(0,10) +
                    '</td><td>' + getWeekDay(data) +
                    '</td><td><a onclick="deleteTime('+v.ctId+',\''+data+'\');">删除</a></td></tr>';
        });
        $('#timeBody').empty().html(timeListContent);
    }

    //获取上课时间
    function getCourseTimeByCId(cId){
        $.ajax({
            url : '${ctx}/course/getCourseTimeByCId',
            type:'post',
            dataType : 'json',
            data : {cId:cId},
            success : function(data){
                timeContent = data;
                delTimeContent = [];
                rendererTimeList();
            }
        });
    }

    //日历插件的启动和点击事件
    calendar.render();
    calendar.on('selectedchange',function (ev) {
        var data = ev.date.Format('yyyy-MM-dd hh:mm:ss');
        if(timeContains(data)){
            BUI.Message.Alert('该上课时间已存在！');
            return ;
        }
        var courseTime = {
            ctId:null,
            cId:CID,
            ctTime:data,
            isAttendance:0,
            isWork:0
        };
        timeContent.push(courseTime);
        console.log(timeContent)
        rendererTimeList();
    });

    //删除上课时间
    deleteTime = function(ctId,data){
        for(var i= 0,len=timeContent.length;i<len;i++){
            if(ctId==''||ctId==null||ctId==undefined){
                if(data==timeContent[i].ctTime){
                    timeContent.splice(i,1);
                    break ;
                }
            }else{
                if(ctId==timeContent[i].ctId){
                    timeContent.splice(i,1);
                    delTimeContent.push(ctId);
                    break ;
                }
            }
        }
        rendererTimeList();
    }

/*****************************选课********************************************************/

    var Grid = Grid,
            Store = Data.Store,
            studentColumns = [
                { title: '学号', width: 120, dataIndex: 'sNo'},
                { title: '姓名', width: 100, dataIndex: 'sName'},
                { title: '专业', width: 100, dataIndex: 'dName'},
                { title: '年级', width: 70, dataIndex: 'grade'},
                { title: '班级', width: 50, dataIndex: 'sClass'}
            ];
    var params = {
        sNo:'',
        dId:''
    };
    var studentStore = new Store({
                url : '${ctx}/student/list',
                pageSize:10,
                params : { },
                autoLoad:true
            }),
            studentGrid = new Grid.Grid({
                render:'#J_ContentGrid',
                columns : studentColumns,
                itemStatusFields : { //设置数据跟状态的对应关系
                    selected : 'selected',
                    disabled : 'disabled'
                },
                store : studentStore,
                bbar:{
                    pagingBar:true
                },
                plugins : [Grid.Plugins.CheckSelection]	// 插件形式引入多选表格
                //multiSelect: true  // 控制表格是否可以多选，但是这种方式没有前面的复选框 默认为false
            });

    //创建弹出框（学生选课）
    var studentDialog;
    function createDialog(){
        return new Overlay.Dialog({
            title:'学生列表',
            width:850,
            height:500,
            contentId:'J_StudentContent',
            success:function () {
                var me = this;
                var selections = tableContent;
                if(selections.length>=1){
                    var cId = CID;
                    var ids = [];
                    BUI.each(selections,function(item){
                        ids.push(item.sId);
                    });
                    if(ids.length){
                        $.ajax({
                            url : '${ctx}/courseStudent/update',
                            type:'post',
                            dataType : 'json',
                            data : {ids : ids.join(','),cId:cId},
                            success : function(data){
                                console.log(data)
                                if(data.success){ //删除成功
                                    me.close();
                                    search.load();
                                }else{ //删除失败
                                    BUI.Message.Alert('操作失败！','error');
                                }
                            }
                        });
                    }
                }else{
                    BUI.Message.Alert('未添加学生！','error');
                }
            }
        });
    }

    //搜索学生
    $("#btnSearch2").click(function(){
        params.sNo = $('#sNo').val();
        params.dId = $('#dId').val();
        studentStore.load(params);
    });

    //添加学生
    var studentTable = $("#studentTable");
    addStudentCourse = function(){
        var selections = studentGrid.getSelection();
        console.log(selections);
        if(selections.length>0){
            $.each(selections,function(i,v){
                if(!contains(tableContent,v)){
                    tableContent.push(v);
                }
            })
            console.log(tableContent)
            rendererTable();
        }

    }
    //删除学生
    delStudentCourse = function(sId){
        console.log(sId)
        for (var i = 0,len = tableContent.length; i < len; i++) {
            if (tableContent[i].sId == sId) {
                tableContent.splice(i,1);
                break;
            }
        }
        console.log(tableContent)
        rendererTable();
    }
    //渲染表格
    function rendererTable(){
        var studentList = '<tr><th>学号</th><th>姓名</th><th>操作</th></tr>';
        $.each(tableContent,function(i,v){
            studentList +='<tr><td>' + v.sNo +
                    '</td><td>' + v.sName +
                    '</td><td><a onclick="delStudentCourse('+ v.sId +');">删除</a></td></tr>';
        })
        studentTable.empty().html(studentList);
    }

    function getCourseStudentByCId(cId){
        $.ajax({
            url : '${ctx}/courseStudent/getCourseStudentByCId',
            type:'post',
            dataType : 'json',
            data : {cId:cId},
            success : function(data){
                tableContent = data;
                rendererTable();
            }
        });
    }

/********************************上课时间-点名和作业提交*******************************************************/
var
        CourseTimeColumns = [
            { title: '上课时间', width: 120, dataIndex: 'ctTime',renderer : function(value,obj){
                return value.substring(0,10);
            }},
            { title: '周几', width: 100, dataIndex: 'ctTime',renderer : function(value,obj){
                return getWeekDay(value);
            }},
            { title: '操作', width: 200, dataIndex: 'ctId',renderer : function(value,obj){
                var returnStr = "";
                if(obj.isAttendance==0){
                    returnStr += '<span class="grid-command beginAttendance">开始点名</span>';
                }else{
                    returnStr += '<span class="grid-command">已点名&nbsp;&nbsp;&nbsp;</span>';
                }
                if(obj.isWork==0){
                    returnStr += '<span class="grid-command beginWork">录入作业提交</span>';
                }else{
                    returnStr += '<span class="grid-command">已录入</span>';
                }
                return returnStr;
            }}
        ];
    var CourseTimeParams = {
        cId:CID
    };
    var CourseTimeStore = new Store({
                url : '${ctx}/course/courseTimeList',
                pageSize:10,
                params : CourseTimeParams
            }),
            CourseTimeGrid = new Grid.Grid({
                render:'#J_CourseTimeContentGrid',
                columns : CourseTimeColumns,
                itemStatusFields : { //设置数据跟状态的对应关系
                    selected : 'selected',
                    disabled : 'disabled'
                },
                store : CourseTimeStore,
                bbar:{
                    pagingBar:true
                }
            });

    //创建弹出框（学生选课）
    var courseTimeDialog;
    function createCourseTimeDialog(){
        return new Overlay.Dialog({
            title:'上课时间列表',
            width:850,
            height:500,
            contentId:'J_CourseTimeContent',
            success:function () {
                this.close();
            }
        });
    }

    CourseTimeGrid.on('cellclick',function  (ev) {
        var record = ev.record, //点击行的记录
                field = ev.field, //点击对应列的dataIndex
                target = $(ev.domTarget); //点击的元素
        CTID = record.ctId;
        if(target.hasClass('beginAttendance')){
            if(!studentListDialog){
                studentListDialog = createStudentListDialog();
            }
            getCourseStudentListByCId(record.cId);
            studentListDialog.show();
        }else if(target.hasClass('beginWork')){
            if(!workListDialog){
                workListDialog = createWorkListDialog();
            }
            getWorkListByCId(record.cId);
            workListDialog.show();
        }
    });


 /*****************************点名******************************************************/
 //创建弹出框（点名）
 var studentListDialog;
    function createStudentListDialog(){
        return new Overlay.Dialog({
            title:'学生列表',
            width:850,
            height:500,
            contentId:'J_StudentListContent',
            success:function () {
                var me = this;
                var cId = CID;
                var form = $("#attendanceForm");
                var data = form.serialize();
                console.log(data)
                $.ajax({
                    url : '${ctx}/courseStudent/attendance?cId='+cId+'&ctId='+CTID,
                    type:'post',
                    dataType : 'json',
                    data : data,
                    success : function(data){
                        console.log(data)
                        if(data.success){ //删除成功
                            me.close();
                            CourseTimeStore.load(CourseTimeParams);
                        }else{ //删除失败
                            BUI.Message.Alert('操作失败！','error');
                        }
                    }
                });
            }
        });
    }
    //获得学生列表
    function getCourseStudentListByCId(cId){
        $.ajax({
            url : '${ctx}/courseStudent/getCourseStudentByCId',
            type:'post',
            dataType : 'json',
            data : {cId:cId},
            success : function(data){
                rendererStudentList(data);
            }
        });
    }
    //渲染学生列表
    function rendererStudentList(courseStudeltList){
        var attendanceForm = $("#attendanceForm");
        var rendererStudentListStr = "";
        $.each(courseStudeltList,function(i,v){
            rendererStudentListStr += '<li>'+
                                      '<div  class="optionleft">'+
                                      '<b>'+(i+1)+'.</b>'+ v.sNo + v.sName +
                                      '</div>'+
                                      '<div>'+
                                      '<input type="radio" checked name="'+ v.sId +'" value="1"';
            if(v.attendance==1){
                rendererStudentListStr += 'checked="checked"';
            }
            rendererStudentListStr +='>A.出勤'+
                                      '</div>'+
                                      '<div>'+
                                      '<input type="radio" name="'+ v.sId +'" value="2"';
            if(v.attendance==2){
                rendererStudentListStr += 'checked="checked"';
            }
            rendererStudentListStr +='>B.旷课'+
                                      '</div>'+
                                      '<div>'+
                                      '<input type="radio" name="'+ v.sId +'" value="3"';
            if(v.attendance==3){
                rendererStudentListStr += 'checked="checked"';
            }
            rendererStudentListStr +='>C.迟到'+
                                      '</div>'+
                                      '<div>'+
                                      '<input type="radio" name="'+ v.sId +'" value="4"';
            if(v.attendance==4){
                rendererStudentListStr += 'checked="checked"';
            }
            rendererStudentListStr +='>D.早退'+
                                      '</div>'+
                                      '</li>';
        })
        attendanceForm.empty().html(rendererStudentListStr);
    }

    /*****************************作业提交******************************************************/
    //创建弹出框（作业提交）
    var workListDialog;
    function createWorkListDialog(){
        return new Overlay.Dialog({
            title:'学生列表',
            width:850,
            height:500,
            contentId:'J_WorkListContent',
            success:function () {
                var me = this;
                var cId = CID;
                var form = $("#workForm");
                var data = form.serialize();
                console.log(data)
                $.ajax({
                    url : '${ctx}/courseStudent/work?cId='+cId+'&ctId='+CTID,
                    type:'post',
                    dataType : 'json',
                    data : data,
                    success : function(data){
                        console.log(data)
                        if(data.success){ //删除成功
                            me.close();
                            CourseTimeStore.load(CourseTimeParams);
                        }else{ //删除失败
                            BUI.Message.Alert('操作失败！','error');
                        }
                    }
                });
            }
        });
    }
    //获得学生列表
    function getWorkListByCId(cId){
        $.ajax({
            url : '${ctx}/courseStudent/getCourseStudentByCId',
            type:'post',
            dataType : 'json',
            data : {cId:cId},
            success : function(data){
                rendererWorkList(data);
            }
        });
    }
    //渲染学生列表
    function rendererWorkList(workList){
        var workForm = $("#workForm");
        var rendererStudentListStr = "";
        $.each(workList,function(i,v){
            rendererStudentListStr += '<li>'+
                    '<div  class="optionleft">'+
                    '<b>'+(i+1)+'.</b>'+ v.sNo + v.sName +
                    '</div>'+
                    '<div>'+
                    '<input type="radio" checked name="'+ v.sId +'" value="1"';
            if(v.work==1){
                rendererStudentListStr += 'checked="checked"';
            }
            rendererStudentListStr +='>A.已交'+
                    '</div>'+
                    '<div>'+
                    '<input type="radio" name="'+ v.sId +'" value="2"';
            if(v.work==2){
                rendererStudentListStr += 'checked="checked"';
            }
            rendererStudentListStr +='>B.未交'+
                    '</div>'+
                    '<div>'+
                    '<input type="radio" name="'+ v.sId +'" value="3"';
            if(v.work==3){
                rendererStudentListStr += 'checked="checked"';
            }
            rendererStudentListStr +='>C.漏教'+
                    '</div>'+
                    '</li>';
        })
        workForm.empty().html(rendererStudentListStr);
    }

 /*****************************操作******************************************************/
    grid.on('cellclick',function  (ev) {
        var record = ev.record, //点击行的记录
                field = ev.field, //点击对应列的dataIndex
                target = $(ev.domTarget); //点击的元素
        CID = record.cId;
        if(target.hasClass('addCourseTimeBtn')){
            if(!timeDialog){
                timeDialog = createTimeDialog();
            }
            timeDialog.show();
            getCourseTimeByCId(record.cId)
        }else if(target.hasClass('selCourseBtn')){
            if(!studentDialog){
                studentDialog = createDialog();
                studentGrid.render();
            }
            studentDialog.show();
            getCourseStudentByCId(record.cId);
        }else if(target.hasClass('attendanceAndWork')){
            if(!courseTimeDialog){
                courseTimeDialog = createCourseTimeDialog();
                CourseTimeGrid.render();

            }
            CourseTimeParams.cId = record.cId;
            CourseTimeStore.load(CourseTimeParams);
            courseTimeDialog.show();
        }
    });

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

//上课地址专业级联
function getChild(obj){
    var aaPid = $(obj).val();
    $.ajax({
        url : '${ctx}/attendAddr/getAttendAddrByAaPid',
        async: false,
        dataType : 'json',
        type:'post',
        data : {aaPid:aaPid},
        success : function(data){
            var seleteHtml = '<option value="" selected="selected">教室</option>';
            $.each(data,function(i,value){
                console.log(value)
                seleteHtml += '<option value="'+value.aaId+'">'+value.aaName+'</option>';
            })
            $("#aaId").empty().html(seleteHtml);
        }
    });
}

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

//系别专业级联
function getChild2(obj){
    var dPid = $(obj).val();
    $.ajax({
        url : '${ctx}/department/getDepartmentByDPid',
        async: false,
        dataType : 'json',
        type:'post',
        data : {dPid:dPid},
        success : function(data){
            var seleteHtml = '<option value="" selected="selected">专业</option>';
            $.each(data,function(i,value){
                console.log(value)
                seleteHtml += '<option value="'+value.dId+'">'+value.dName+'</option>';
            })
            $("#dId").empty().html(seleteHtml);
        }
    });
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