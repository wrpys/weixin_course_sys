<%@ page import="com.shirokumacafe.archetype.entity.User" %>
<%@ page import="com.shirokumacafe.archetype.common.Users" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%
    User user = (User) session.getAttribute(Users.SESSION_USER);
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>作业系统 后台管理</title>
    <%@include file="../layouts/default.jsp"%>
    <link rel="stylesheet" href="${ctx}/static/styles/main.css">
</head>

<body>

<div id="J_Layout"></div>

<!-- 初始隐藏 dialog内容 -->
<div id="content" class="hide">
    <form id="J_Form" class="form-horizontal">
        <div class="row">
            <div class="control-group span8">
                <label class="control-label"><s>*</s>旧的密码：</label>

                <div class="controls">
                    <input name="oldPass" id="oldPass" type="password" data-rules="{required:true}"
                           class="input-normal control-text">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group span8">
                <label class="control-label"><s>*</s>新的密码：</label>

                <div class="controls">
                    <input name="newPass" id="newPass" type="password" data-rules="{required:true}"
                           class="input-normal control-text">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group span8">
                <label class="control-label"><s>*</s>确认密码：</label>

                <div class="controls">
                    <%--非空验证，同时要与第一次输入一致--%>
                    <input name="newPass" id="secondPass" type="password"
                           data-rules="{required:true,equalTo:'#newPass'}" class="input-normal control-text">
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    var tabTemp;
    BUI.use(['bui/layout', 'bui/tab', 'bui/editor', 'bui/form', 'ztree/ztree'], function (Layout, Tab, Editor) {
        var menus = ${menus},
                tab = [];

        //初始化tab和ztree数据
        for (var i = 0; i < menus.length; i++) {
            tab.push({
                layout: {title: menus[i].menuName},
                content: '<ul id="' + menus[i].menuId + '" class="ztree"></ul>'
            });
        }

        var control = new Layout.Viewport({
//            render: '#J_Layout',
            elCls: 'ext-border-layout',
            children: [
                {
                    layout: {
                        fit: 'both',
                        region: 'north'
                    },
                    xclass: 'controller',
                    content: '<div class="header">' +
                            '<div class="dl-title"><span>作业系统 后台管理</span></div>' +
                            '<div class="dl-log">欢迎您，<span class="dl-log-user"><%=user.getNickName()%></span>' +
                            '<a class="dl-log-quit btn-edit" title="修改密码" id="changePass">[修改密码]</a>' +
                            '<a href="${ctx}/logout" title="退出系统" class="dl-log-quit">[退出]</a></div></div>'
                },
                {
                    xclass: 'controller',
                    layout: {
                        region: 'west',
                        title: '菜单栏',
                        fit: 'both', //height,width,both,none
                        collapsable: true,
                        width: 260
                    },
                    defaultChildClass: 'controller',
                    children: tab,
                    plugins: [Layout.Accordion]
                },
                {
                    xclass: 'controller',
                    layout: {
                        fit:'both',
                        region: 'center'
                    },
                    children: [
                        {
                            xclass: 'nav-tab',
                            id: 'mytab',
                            children: [
                                {
                                    xclass: 'nav-tab-item',
                                    title: '首页',
                                    href: '${ctx}/toIndex',
                                    closeable: false,
                                    actived: true
                                }
                            ],
                            plugins: [Tab.NavTabItem]
                        }
                    ],
                    plugins: [Tab.NavTab]
                }
            ],
            plugins: [Layout.Border]
        });
        control.render();

        var tab = control.getChild('mytab', true);
        tabTemp=tab;
        console.log(tab)
        var setting = {
            data: {
                key: {
                    name: 'menuName'
                },
                simpleData: {
                    enable: true,
                    idKey: 'menuId',
                    pIdKey: 'menuPid'
                }
            },
            callback: {
                onClick: function (event, treeId, treeNode) {
                    if (treeNode.isParent) return;
                    tab.addTab({
                        id: treeNode.menuId,
                        title: treeNode.menuName,
                        href: treeNode.menuLink
                    }, true);
                }
            }
        };


        //初始化菜单
        for (var i = 0; i < menus.length; i++) {
            $.fn.zTree.init($("#" + menus[i].menuId), setting, menus[i].children);
        }

        //创建编辑器
        var editor = new Editor.DialogEditor({
            contentId: 'content',
            width: 400,
            mask: true,      //是否模态
            title: '修改密码',
            form: {
                srcNode: '#J_Form' //配置为content或J_Form皆可
            },
            success: function () {
                editor.valid();
                if (editor.isValid()) {
                    var oldPass = $("#oldPass").val();
                    var newPass = $("#newPass").val();
                    $.ajax({
                        url: '${ctx}/user/changePassword',
                        dataType: 'json',
                        type: 'post',
                        data: {'oldPass': oldPass, 'newPass': newPass},
                        success: function (data) {
                            if (data.success) {     //编辑、新建成功
                                editor.accept();   //隐藏弹出框
                            } else {
                                var msg = data.msg;
                                BUI.Message.Alert(msg);
                            }
                        }
                    });
                }
            }
        });

        $('#changePass').click(function () {
            editor.show();
        });
    });


</script>
</body>
</html>