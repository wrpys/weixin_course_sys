/**
 * 工具类js
 */
myUtil = {

    /**
     * 浮点数乘法运算
     * arg1
     * arg2
     * 返回相乘的结果
     */
    floatMultiply : function(arg1,arg2){
        var m=0,s1=arg1.toString(),s2=arg2.toString();
        try{m+=s1.split(".")[1].length}catch(e){}
        try{m+=s2.split(".")[1].length}catch(e){}
        return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);
    } ,

    /**
     * 浮点数加法运算
     * arg1
     * arg2
     * 返回相加的结果
     */
    floatAdd : function(arg1,arg2){
        var r1,r2,m;
        try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
        try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
        m=Math.pow(10,Math.max(r1,r2));
        return (arg1*m+arg2*m)/m;
    } ,

    /**
     * 全选/全不选
     * checkBtn1 全选按钮
     * checkBtn2 列表项选择按钮
     */
    selectAllItems : function(selectAllBtn,itemBtnName){
        var itemBtn = document.getElementsByName(itemBtnName);
        if(selectAllBtn.checked == true){
            for(var i=0;i<itemBtn.length;i++)
                itemBtn[i].checked = true;
        }else{
            for(var i=0;i<itemBtn.length;i++)
                itemBtn[i].checked = false;
        }
    },

    /**
     * 是否选中了一个
     * itemBtnName 列表项选择按钮
     * return 如果至少选中了一个返回true 否则返回false
     */
    isLeastSelectOne : function(itemBtnName){
        var itemBtn = document.getElementsByName(itemBtnName);
        var tag_isLeastSelectOne = false;
        for(var i=0;i<itemBtn.length;i++){
            if(itemBtn[i].checked==true){
                tag_isLeastSelectOne = true;
                break;
            }
        }
        return tag_isLeastSelectOne;
    },


    /**
     * 打开编辑窗口
     * url     打开窗口url
     * name    打开窗口名称
     * iWidth  打开窗口宽度
     * 返回相乘的结果
     */
    openEditWindow : function(url,name,iWidth){

        var hbody = window.screen.availHeight;
        if(iWidth==null || iWidth==''){
            iWidth = '807';
        }
        var iHeight = parseInt(hbody-235);
        var iTop = (window.screen.availHeight-30-iHeight)/2;
        var iLeft = (window.screen.availWidth-10-iWidth)/2;
        var myParam = 'height=' + iHeight + ',width=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',scrollbars=yes';
        var win = window.open(url,name,myParam);
        try{
            win.focus();
        }catch(e){

        }

    },

    /**
     * 限制文本框中最大输入数量
     * objInput  文本框对象
     * L         最大输入数量
     */
    limitMaxInput : function(objInput,L){
        if(objInput.value.length>parseInt(L)){
            objInput.value=objInput.value.substring(0,L);
        }
    },

    /**
     * 统计输入的字符数(一个汉字按2个字符来计算)
     * str 用户输入的字符串
     * 返回字符数
     */
    countCharacters : function(str){
        var sum = 0;
        for(var i = 0;i<str.length;i++){
            if( (str.charCodeAt(i)>=0) && (str.charCodeAt(i)<=255) ){
                sum=sum+1;
            }else{
                sum=sum+2;
            }
        }
        return sum;
    },


    /**
     * 跳转到登录/注册
     */
    turnToLogin : function(){
        var _ele = document.createElement("a");
        _ele.href = "login.do";
        document.body.appendChild(_ele);

        if(document.all){   //判断是否是IE
            _ele.click();
        }else{
            var evt = document.createEvent("MouseEvents");
            evt.initEvent("click", true, true);
            _ele.dispatchEvent(evt);
        }

    }
}

