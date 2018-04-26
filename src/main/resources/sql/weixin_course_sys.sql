/*
Navicat MySQL Data Transfer

Source Server         : loc
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : weixin_course_sys

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2018-04-26 21:35:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_course`
-- ----------------------------
DROP TABLE IF EXISTS `t_course`;
CREATE TABLE `t_course` (
  `c_id` int(11) NOT NULL AUTO_INCREMENT,
  `c_name` varchar(255) DEFAULT NULL,
  `c_pid` int(11) DEFAULT '0',
  `c_create_time` datetime DEFAULT NULL,
  `c_desc` varchar(255) DEFAULT NULL,
  `f_id` int(11) DEFAULT NULL,
  `download_num` int(11) DEFAULT '0',
  `heat_num` int(11) DEFAULT '0',
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_course
-- ----------------------------
INSERT INTO `t_course` VALUES ('3', '高数', null, '2018-04-22 14:57:16', '高数', null, '0', '0');
INSERT INTO `t_course` VALUES ('4', 'java ee', null, '2018-04-22 14:58:22', 'java ee', null, '0', '0');
INSERT INTO `t_course` VALUES ('5', '安卓', null, '2018-04-22 17:28:39', '安卓', null, null, null);
INSERT INTO `t_course` VALUES ('6', 'web开发', null, '2018-04-22 17:28:47', 'web开发', null, null, null);
INSERT INTO `t_course` VALUES ('7', '数字逻辑', null, '2018-04-22 17:29:00', '数字逻辑', null, null, null);
INSERT INTO `t_course` VALUES ('8', '计算机组成原理', null, '2018-04-22 17:29:10', '计算机组成原理', null, null, null);
INSERT INTO `t_course` VALUES ('9', '第一课', '3', '2018-04-23 22:29:46', '第一课', '1', '5', '50');
INSERT INTO `t_course` VALUES ('10', '第二课', '3', '2018-04-23 22:30:00', '第二课', '1', '5', '0');
INSERT INTO `t_course` VALUES ('11', '第三课', '3', '2018-04-23 22:30:11', '第三课', '1', '6', '0');
INSERT INTO `t_course` VALUES ('12', '第四课', '3', '2018-04-23 22:30:18', '第四课', '1', '0', '0');
INSERT INTO `t_course` VALUES ('13', '第五课', '3', '2018-04-23 22:30:27', '第五课', '1', '24', '0');
INSERT INTO `t_course` VALUES ('14', '第一课', '4', '2018-04-24 23:52:31', '第一课', '6', '0', '4');

-- ----------------------------
-- Table structure for `t_file`
-- ----------------------------
DROP TABLE IF EXISTS `t_file`;
CREATE TABLE `t_file` (
  `f_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_name` varchar(255) DEFAULT NULL,
  `f_addr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_file
-- ----------------------------
INSERT INTO `t_file` VALUES ('1', '大数据二期-建设方案-智能探索平台.pptx', 'E:\\job\\taobao\\weixin_course_sys\\target\\archetype-1.1\\file\\');
INSERT INTO `t_file` VALUES ('2', '大数据二期-建设方案-智能探索平台.pptx', 'E:\\job\\taobao\\weixin_course_sys\\target\\archetype-1.1\\file\\');
INSERT INTO `t_file` VALUES ('3', '大数据二期-建设方案-智能探索平台.pptx', 'E:\\job\\taobao\\weixin_course_sys\\target\\archetype-1.1\\file\\');
INSERT INTO `t_file` VALUES ('4', '大数据二期-建设方案-智能探索平台.pptx', 'E:\\job\\taobao\\weixin_course_sys\\target\\archetype-1.1\\file\\');
INSERT INTO `t_file` VALUES ('5', '大数据二期-建设方案-智能探索平台.pptx', 'E:\\job\\taobao\\weixin_course_sys\\target\\archetype-1.1\\file\\');
INSERT INTO `t_file` VALUES ('6', '大数据二期-建设方案-智能探索平台.pptx', 'E:\\job\\taobao\\weixin_course_sys\\target\\archetype-1.1\\file\\\\4\\14\\1524585159626\\');

-- ----------------------------
-- Table structure for `t_file_image`
-- ----------------------------
DROP TABLE IF EXISTS `t_file_image`;
CREATE TABLE `t_file_image` (
  `fi_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_id` int(11) DEFAULT NULL,
  `fi_addr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_file_image
-- ----------------------------
INSERT INTO `t_file_image` VALUES ('1', '1', 'E:\\job\\taobao\\weixin_course_sys\\target\\archetype-1.1\\file\\\\大数据二期-建设方案-智能探索平台\\');
INSERT INTO `t_file_image` VALUES ('2', '6', 'E:\\job\\taobao\\weixin_course_sys\\target\\archetype-1.1\\file\\\\4\\14\\1524585159626\\');

-- ----------------------------
-- Table structure for `t_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_code` varchar(32) DEFAULT NULL,
  `menu_pid` int(11) NOT NULL,
  `menu_name` varchar(32) DEFAULT NULL,
  `menu_link` varchar(50) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES ('1', 'system', '0', '系统管理', '', '3', '1');
INSERT INTO `t_menu` VALUES ('2', 'menu', '1', '菜单管理', 'menu', '1', '1');
INSERT INTO `t_menu` VALUES ('3', 'role', '1', '角色管理', 'role', '2', '1');
INSERT INTO `t_menu` VALUES ('4', 'user', '1', '用户管理', 'user', '3', '1');
INSERT INTO `t_menu` VALUES ('8', 'info', '0', '信息管理', '', '1', '1');
INSERT INTO `t_menu` VALUES ('10', 'student', '8', '学生信息管理', 'student', '1', '1');
INSERT INTO `t_menu` VALUES ('23', 'teacher', '0', '教师工具', '', '2', '1');
INSERT INTO `t_menu` VALUES ('31', '1429321176178', '0', '父', '', null, '1');
INSERT INTO `t_menu` VALUES ('39', 'course', '23', '课程管理', 'course', '1', '1');

-- ----------------------------
-- Table structure for `t_message`
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `msg_pid` int(11) NOT NULL,
  `msg_content` varchar(500) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `c_id` int(11) NOT NULL COMMENT '作业ID',
  `oper_role` int(1) NOT NULL COMMENT '发送角色，1:老师，2:学生',
  `oper_id` int(11) NOT NULL COMMENT '发送者ID',
  PRIMARY KEY (`msg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('1', '0', '请问请问请问请问请问请问请问请问请问请问请问请问请问', '2018-04-09 09:49:17', '9', '1', '1');
INSERT INTO `t_message` VALUES ('2', '1', '回答', '2018-04-09 09:49:33', '9', '2', '2');
INSERT INTO `t_message` VALUES ('3', '0', '请问2请问2请问2请问2请问2请问2请问2请问2请问2请问2请问2请问2请问2', '2018-04-09 10:41:22', '9', '1', '1');
INSERT INTO `t_message` VALUES ('4', '3', '回答2', '2018-04-09 11:04:33', '9', '1', '2');
INSERT INTO `t_message` VALUES ('5', '0', 'JAVA中hashmap。。。', '2018-04-09 15:27:41', '9', '1', '1');
INSERT INTO `t_message` VALUES ('6', '0', 'java中ArrayList...', '2018-04-09 15:29:25', '9', '1', '1');
INSERT INTO `t_message` VALUES ('7', '5', 'hashMap是键值对', '2018-04-09 15:29:56', '9', '1', '25');
INSERT INTO `t_message` VALUES ('8', '7', 'hashmap原理。。。', '2018-04-09 15:30:21', '9', '2', '2');
INSERT INTO `t_message` VALUES ('9', '6', 'arraylist原理。。。', '2018-04-09 15:30:41', '9', '2', '2');
INSERT INTO `t_message` VALUES ('10', '9', 'arraylist是线程不安全的', '2018-04-10 09:22:36', '9', '2', '2');
INSERT INTO `t_message` VALUES ('11', '10', '好的', '2018-04-10 09:22:57', '9', '2', '2');
INSERT INTO `t_message` VALUES ('12', '0', '测试  测试2', '2018-04-18 00:27:10', '9', '1', '1');
INSERT INTO `t_message` VALUES ('13', '0', '测试3', '2018-04-18 00:29:56', '9', '1', '1');
INSERT INTO `t_message` VALUES ('14', '0', '测试5', '2018-04-18 00:30:47', '9', '1', '1');
INSERT INTO `t_message` VALUES ('15', '0', '测试6', '2018-04-18 00:31:09', '9', '1', '1');
INSERT INTO `t_message` VALUES ('16', '12', 'zale', '2018-04-18 00:31:37', '9', '2', '2');
INSERT INTO `t_message` VALUES ('17', '13', '好的', '2018-04-18 00:31:43', '9', '2', '2');
INSERT INTO `t_message` VALUES ('18', '14', 'ok', '2018-04-18 00:31:49', '9', '2', '2');
INSERT INTO `t_message` VALUES ('19', '15', '嗯', '2018-04-18 00:31:53', '9', '2', '2');
INSERT INTO `t_message` VALUES ('21', '0', '老司颪', '2018-04-18 00:37:43', '9', '1', '1');
INSERT INTO `t_message` VALUES ('22', '0', '提示语', '2018-04-18 19:46:55', '9', '1', '1');
INSERT INTO `t_message` VALUES ('23', '22', '回复语', '2018-04-18 19:49:01', '9', '2', '2');
INSERT INTO `t_message` VALUES ('25', '0', '屁东西', '2018-04-18 19:58:08', '9', '1', '1');
INSERT INTO `t_message` VALUES ('26', '8', '是什么呢？、', '2018-04-18 21:05:15', '9', '1', '1');
INSERT INTO `t_message` VALUES ('27', '11', '你好啊啊啊啊啊啊', '2018-04-18 21:06:45', '9', '1', '1');
INSERT INTO `t_message` VALUES ('28', '26', '屁东西', '2018-04-18 21:08:18', '9', '1', '1');
INSERT INTO `t_message` VALUES ('29', '27', '屁东西', '2018-04-18 21:08:29', '9', '1', '1');
INSERT INTO `t_message` VALUES ('30', '0', '屁东西', '2018-04-18 21:08:52', '9', '1', '1');
INSERT INTO `t_message` VALUES ('35', '0', 'yii o o o o', '2018-04-18 21:12:15', '9', '1', '1');
INSERT INTO `t_message` VALUES ('36', '0', '屁东西', '2018-04-18 21:12:44', '9', '1', '1');
INSERT INTO `t_message` VALUES ('37', '0', '', '2018-04-18 21:12:47', '9', '1', '1');
INSERT INTO `t_message` VALUES ('38', '0', '', '2018-04-18 21:12:53', '9', '1', '1');
INSERT INTO `t_message` VALUES ('40', '0', '开始讨论', '2018-04-19 21:55:48', '9', '1', '1');
INSERT INTO `t_message` VALUES ('42', '0', '发起讨论2', '2018-04-19 21:57:50', '9', '1', '1');
INSERT INTO `t_message` VALUES ('43', '40', '回复讨论', '2018-04-19 21:58:43', '9', '1', '1');
INSERT INTO `t_message` VALUES ('44', '42', '回复讨论2', '2018-04-19 22:03:06', '9', '1', '1');
INSERT INTO `t_message` VALUES ('45', '0', '发起讨论3', '2018-04-19 22:03:14', '9', '1', '1');
INSERT INTO `t_message` VALUES ('46', '45', '回复讨论3', '2018-04-19 22:03:21', '9', '1', '1');
INSERT INTO `t_message` VALUES ('47', '28', '额额额', '2018-04-19 22:03:31', '9', '1', '1');
INSERT INTO `t_message` VALUES ('48', '0', '请回答1988', '2018-04-19 23:42:52', '9', '1', '1');
INSERT INTO `t_message` VALUES ('49', '0', '啊啊啊啊啊啊啊啊啊啊啊啊', '2018-04-20 21:12:35', '9', '1', '1');
INSERT INTO `t_message` VALUES ('50', '49', '呃呃呃呃呃呃呃呃呃呃呃呃呃呃呃', '2018-04-20 21:12:48', '9', '1', '1');
INSERT INTO `t_message` VALUES ('51', '47', '呃呃呃呃呃呃呃呃呃呃呃呃', '2018-04-20 21:13:10', '9', '1', '1');
INSERT INTO `t_message` VALUES ('52', '0', '隐隐约约隐隐约约隐隐约约一样', '2018-04-20 21:19:33', '9', '1', '1');
INSERT INTO `t_message` VALUES ('53', '50', '嗯。好的', '2018-04-20 21:30:43', '9', '1', '1');
INSERT INTO `t_message` VALUES ('54', '0', '请问老师？？？？', '2018-04-20 21:30:57', '9', '1', '1');
INSERT INTO `t_message` VALUES ('55', '54', '怎么了？？？', '2018-04-20 21:31:25', '9', '2', '2');
INSERT INTO `t_message` VALUES ('56', '0', '讨论啊    啊啊啊', '2018-04-20 21:31:54', '9', '1', '1');
INSERT INTO `t_message` VALUES ('57', '0', '沟沟壑壑就斤斤计较', '2018-04-20 22:18:27', '9', '1', '1');
INSERT INTO `t_message` VALUES ('58', '51', '', '2018-04-20 22:19:33', '9', '1', '1');
INSERT INTO `t_message` VALUES ('59', '1', '@王荣坡：好的。', '2018-04-24 00:12:08', '9', '1', '1');
INSERT INTO `t_message` VALUES ('60', '2', '嗯好的', '2018-04-24 00:13:58', '9', '1', '1');
INSERT INTO `t_message` VALUES ('61', '1', '嗯。不好', '2018-04-24 00:16:50', '9', '1', '1');
INSERT INTO `t_message` VALUES ('62', '1', '嗯。是不好', '2018-04-24 00:17:14', '9', '1', '1');
INSERT INTO `t_message` VALUES ('63', '0', '可以可以', '2018-04-24 00:17:31', '9', '1', '1');
INSERT INTO `t_message` VALUES ('64', '63', '怎么可以', '2018-04-24 00:24:18', '9', '1', '1');
INSERT INTO `t_message` VALUES ('65', '64', '不懂啊', '2018-04-24 22:48:36', '9', '1', '1');
INSERT INTO `t_message` VALUES ('66', '65', '怎么了……', '2018-04-24 22:52:18', '9', '1', '1');
INSERT INTO `t_message` VALUES ('67', '66', '没理解', '2018-04-24 22:53:50', '9', '1', '1');
INSERT INTO `t_message` VALUES ('68', '57', '怎了', '2018-04-24 22:55:44', '9', '1', '1');
INSERT INTO `t_message` VALUES ('69', '52', 'ok啊', '2018-04-24 22:56:00', '9', '1', '1');
INSERT INTO `t_message` VALUES ('70', '36', '什么屁东西？', '2018-04-24 22:58:36', '9', '1', '1');
INSERT INTO `t_message` VALUES ('71', '67', '那就慢慢理解', '2018-04-24 22:59:47', '9', '1', '1');
INSERT INTO `t_message` VALUES ('72', '18', '怎么了', '2018-04-24 23:06:17', '9', '1', '1');
INSERT INTO `t_message` VALUES ('73', '0', '23.09', '2018-04-24 23:09:11', '9', '1', '1');
INSERT INTO `t_message` VALUES ('74', '73', '23.10', '2018-04-24 23:09:25', '9', '1', '1');
INSERT INTO `t_message` VALUES ('75', '0', '现在', '2018-04-24 23:10:23', '9', '1', '1');
INSERT INTO `t_message` VALUES ('76', '75', '你好', '2018-04-24 23:10:30', '9', '1', '1');
INSERT INTO `t_message` VALUES ('77', '75', '哪有？', '2018-04-24 23:15:21', '9', '1', '1');
INSERT INTO `t_message` VALUES ('78', '76', '不错啊', '2018-04-24 23:40:53', '9', '1', '1');
INSERT INTO `t_message` VALUES ('79', '74', '好的啊', '2018-04-24 23:42:26', '9', '1', '1');
INSERT INTO `t_message` VALUES ('80', '0', '评论', '2018-04-24 23:56:18', '14', '1', '1');
INSERT INTO `t_message` VALUES ('81', '80', '平常', '2018-04-24 23:56:27', '14', '1', '1');
INSERT INTO `t_message` VALUES ('82', '77', '嗯。。。。', '2018-04-25 21:12:32', '9', '1', '1');
INSERT INTO `t_message` VALUES ('83', '76', 'ok啊', '2018-04-25 21:16:51', '9', '1', '1');
INSERT INTO `t_message` VALUES ('84', '78', '嗯', '2018-04-25 21:17:03', '9', '1', '1');
INSERT INTO `t_message` VALUES ('85', '74', '……', '2018-04-25 21:17:34', '9', '1', '1');
INSERT INTO `t_message` VALUES ('86', '79', '？？？', '2018-04-25 21:17:47', '9', '1', '1');
INSERT INTO `t_message` VALUES ('87', '86', '……', '2018-04-25 21:18:17', '9', '1', '1');
INSERT INTO `t_message` VALUES ('88', '77', '呢两', '2018-04-25 21:48:13', '9', '2', '2');
INSERT INTO `t_message` VALUES ('89', '83', '嗯是', '2018-04-25 21:48:50', '9', '2', '2');

-- ----------------------------
-- Table structure for `t_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_code` varchar(32) DEFAULT NULL,
  `role_name` varchar(32) DEFAULT NULL,
  `sys` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `create_id` int(11) DEFAULT NULL,
  `update_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  KEY `FK_ROLE_USER` (`create_id`),
  CONSTRAINT `t_role_ibfk_1` FOREIGN KEY (`create_id`) REFERENCES `t_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', 'admin', '管理员', null, '拥有最高权限。', '1', '1', '1', '2015-03-05 09:47:47', '2018-04-20 21:27:03');
INSERT INTO `t_role` VALUES ('2', 'teacher', '教师', null, '拥有一些信息之类的管理。', '1', '1', '1', '2015-03-05 11:19:05', '2018-04-22 13:26:21');
INSERT INTO `t_role` VALUES ('3', 'student', '学生', null, '不允许进入后台。', '1', '1', null, '2015-03-05 11:23:56', null);

-- ----------------------------
-- Table structure for `t_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE `t_role_permission` (
  `role_id` int(11) DEFAULT NULL,
  `permission` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_permission
-- ----------------------------
INSERT INTO `t_role_permission` VALUES ('3', 'zixun:');
INSERT INTO `t_role_permission` VALUES ('3', 'notice:');
INSERT INTO `t_role_permission` VALUES ('1', 'ceshi:');
INSERT INTO `t_role_permission` VALUES ('1', 'system:');
INSERT INTO `t_role_permission` VALUES ('1', 'menu:');
INSERT INTO `t_role_permission` VALUES ('1', 'role:');
INSERT INTO `t_role_permission` VALUES ('1', 'user:');
INSERT INTO `t_role_permission` VALUES ('2', 'info:');
INSERT INTO `t_role_permission` VALUES ('2', 'student:');
INSERT INTO `t_role_permission` VALUES ('2', 'teacher:');
INSERT INTO `t_role_permission` VALUES ('2', 'course:');

-- ----------------------------
-- Table structure for `t_student`
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student` (
  `s_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_no` varchar(50) NOT NULL,
  `s_name` varchar(50) NOT NULL,
  `s_password` varchar(50) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `user_role` int(11) DEFAULT NULL,
  `s_sex` tinyint(1) DEFAULT '0',
  `clzss_id` int(11) DEFAULT NULL,
  `weixin_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES ('1', '211106402', '王荣坡', '123456', null, '3', '0', '1', 'owug5t3EYRqfV5uAnO3B6pOdKISI');
INSERT INTO `t_student` VALUES ('31', '211106412', '余双', '', null, '3', '1', '1', 'owug5t_1Q7dYlFQLhfdgbKFitz_w');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(32) DEFAULT NULL,
  `nick_name` varchar(32) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `user_role` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `create_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `weixin_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `FK_USER_ROLE` (`user_role`),
  CONSTRAINT `t_user_ibfk_1` FOREIGN KEY (`user_role`) REFERENCES `t_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', '系统管理员', '123456', '', '1', '1', '1', '2015-03-04 22:55:38', '');
INSERT INTO `t_user` VALUES ('2', 'jiaoshi', '教师', '123456', '', '2', '1', '1', '2015-03-05 11:21:11', 'owug5t42gq8JmoNqWQ5mH-v0BkAQ');
INSERT INTO `t_user` VALUES ('3', 'jiaoshi2', '教师2', '123456', '', '2', '1', '1', '2018-04-20 21:26:07', '');

-- ----------------------------
-- View structure for `v_user`
-- ----------------------------
DROP VIEW IF EXISTS `v_user`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_user` AS select `t1`.`user_id` AS `user_id`,`t1`.`login_name` AS `login_name`,`t1`.`nick_name` AS `nick_name`,`t1`.`password` AS `password`,`t1`.`salt` AS `salt`,`t1`.`user_role` AS `user_role`,`t1`.`state` AS `state`,`t1`.`create_id` AS `create_id`,`t1`.`create_time` AS `create_time`,`t1`.`weixin_id` AS `weixin_id`,`t2`.`role_name` AS `role_name`,`t2`.`role_code` AS `role_code`,`t3`.`login_name` AS `create_name` from ((`t_user` `t1` left join `t_role` `t2` on((`t1`.`user_role` = `t2`.`role_id`))) left join `t_user` `t3` on((`t1`.`create_id` = `t3`.`user_id`))) ;
