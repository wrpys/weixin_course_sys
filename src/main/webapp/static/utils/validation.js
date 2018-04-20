/**
 * 验证类js
 */
myValidation = {

    /**
     *  检验字符串非空性
     *  str   待检验的字符串
     *  当检验值不为空时候 返回true 否则返回false
     */
    checkStrIsEmpty : function(str){

        var patn = /^[ ]*$/ ;
        if(patn.test(str)){
            return false;
        }
        return true;
    },

    /**
     *  检验买家账号合法性 [6-20位字符(由中文，英文，数字，下划线组成)]
     *  str   待检验的字符串
     *  当检验值符合条件时候 返回true 否则返回false
     */
    checkUserAccountValidity2 : function(str){

        var patn = /^[a-zA-Z_0-9\u4e00-\u9fa5]+$/ ;
        if(patn.test(str)){
            var len = str.replace(/[^\x00-\xff]/g,"aa").length;
            if(len>=6 && len<=20){
                return true;
            }
        }
        return false;
    },

    /**
     *  检验用户账号合法性 [6-20位字符(由英文，数字，下划线组成)]
     *  str   待检验的字符串
     *  当检验值符合条件时候 返回true 否则返回false
     */
    checkUserAccountValidity : function(str){

        var patn = /^[a-zA-Z_0-9]{6,20}$/ ;
        if(patn.test(str)){
            return true;
        }
        return false;
    },

    /**
     *  检验用户密码合法性 [6-16位字符(由英文，数字组成)]
     *  str   待检验的字符串
     *  当检验值符合条件时候 返回true 否则返回false
     */
    checkUserPasswordValidity : function(str){
        var patn = /^[a-zA-Z0-9]{6,16}$/ ;
        if(patn.test(str)){
            return true;
        }
        return false;
    },

    /**
     *  检验验证码 [4位字符(由英文，数字组成)]
     *  str   待检验的字符串
     *  当检验值符合条件时候 返回true 否则返回false
     */
    checkVerificationCodeValidity : function(str){
        var patn = /^[a-zA-Z0-9]{4}$/ ;
        if(patn.test(str)){
            return true;
        }
        return false;
    },


    /**
     *  检验是否是数字
     *  str   待检验的字符串
     *  当检验值为数字时候 返回true 否则返回false
     */
    checkIsNumber : function(str){

        var patn = /^([0]|[1-9][0-9]*)$/;
        if(!patn.test(str)){
            return false;
        }
        return true;

    },

    /**
     *  检验价格合法性
     *  str   待检验的字符串
     *  当检验值为合法的价格格式时候 返回true 否则返回false
     */
    checkPriceValidity : function(str){

        var patn = /^(0|[1-9]\d*)(\.\d{1,2})?$/ ;
        if(!patn.test(str)){
            return false;
        }
        return true;
    },

    /**
     *  检验邮箱格式
     *  str 待检验的字符串
     *  当检验值为合法的邮箱地址格式时候 返回true 否则返回false
     */
    checkEmailPattern : function(str) {

        var patn = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
        if(!patn.test(str)){
            return false;
        }
        return true;
    },

    /**
     *  检验手机格式
     *  str 待检验的字符串
     *  当检验值为合法的手机格式时候 返回true 否则返回false
     */
    checkMobilePattern : function(str) {

        var patn = /^((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|145|147)\d{8}$/;
        if(!patn.test(str)){
            return false;
        }
        return true;
    }

}

