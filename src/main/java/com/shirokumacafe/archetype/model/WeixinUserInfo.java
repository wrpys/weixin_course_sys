package com.shirokumacafe.archetype.model;

/**
 * 微信用户的信息
 *
 * @author wrp
 * @since 2018/4/22
 */
public class WeixinUserInfo {

    /**
     * 微信ID
     */
    private String weixinId;
    /**
     * 角色：1.学生，2.教师
     */
    private Integer role;
    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 账号
     */
    private String account;
    /**
     * 名称
     */
    private String userName;
    /**
     * 密码
     */
    private String password;

    public String getWeixinId() {
        return weixinId;
    }

    public void setWeixinId(String weixinId) {
        this.weixinId = weixinId;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
