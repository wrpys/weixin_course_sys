/*
Navicat MySQL Data Transfer

Source Server         : loc
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : weixin_course_sys

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2018-05-08 21:53:10
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
  `user_id` int(11) DEFAULT NULL,
  `like_num` int(11) DEFAULT '0',
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_course
-- ----------------------------
INSERT INTO `t_course` VALUES ('3', '高数', null, '2018-04-22 14:57:16', '高数', null, '0', '0', '2', '0');
INSERT INTO `t_course` VALUES ('4', 'java ee', null, '2018-04-22 14:58:22', 'java ee', null, '0', '0', '2', '0');
INSERT INTO `t_course` VALUES ('5', '安卓', null, '2018-04-22 17:28:39', '安卓', null, '0', '0', '2', '0');
INSERT INTO `t_course` VALUES ('6', 'web开发', null, '2018-04-22 17:28:47', 'web开发', null, '0', '0', '2', '0');
INSERT INTO `t_course` VALUES ('7', '数字逻辑', null, '2018-04-22 17:29:00', '数字逻辑', null, '0', '0', '2', '0');
INSERT INTO `t_course` VALUES ('9', '第一课', '3', '2018-04-23 22:29:46', '第一课', '9', '7', '290', '2', '0');
INSERT INTO `t_course` VALUES ('10', '第二课', '3', '2018-04-23 22:30:00', '第二课', null, '5', '11', '2', '0');
INSERT INTO `t_course` VALUES ('11', '第三课', '3', '2018-04-23 22:30:11', '第三课', null, '6', '6', '2', '0');
INSERT INTO `t_course` VALUES ('12', '第四课', '3', '2018-04-23 22:30:18', '第四课', null, '0', '3', '2', '0');
INSERT INTO `t_course` VALUES ('13', '第五课', '3', '2018-04-23 22:30:27', '第五课', null, '24', '1', '2', '0');
INSERT INTO `t_course` VALUES ('14', '第一课', '4', '2018-04-24 23:52:31', '第一课', null, '0', '4', '2', '0');
INSERT INTO `t_course` VALUES ('17', '第六课', '3', '2018-05-02 20:35:01', '第六课', null, '0', '3', '2', '0');
INSERT INTO `t_course` VALUES ('20', '第一课', '18', '2018-05-07 20:57:12', '第一章', null, '0', '0', '2', '0');
INSERT INTO `t_course` VALUES ('22', '教师2添加', null, '2018-05-08 20:01:23', '教师2添加', null, '0', '0', '3', '0');
INSERT INTO `t_course` VALUES ('23', '教师2第一课', '22', '2018-05-08 20:01:32', '教师2第一课', null, '0', '0', '3', '0');
INSERT INTO `t_course` VALUES ('24', '教师2第二课', '22', '2018-05-08 20:01:39', '教师2第二课', null, '0', '0', '3', '0');

-- ----------------------------
-- Table structure for `t_file`
-- ----------------------------
DROP TABLE IF EXISTS `t_file`;
CREATE TABLE `t_file` (
  `f_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_name` varchar(255) DEFAULT NULL,
  `f_addr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_file
-- ----------------------------
INSERT INTO `t_file` VALUES ('9', '智能探索平台.pptx', 'E:\\job\\taobao\\weixin_course_sys\\target\\archetype-1.1\\file\\\\3\\9\\1525496016479\\');

-- ----------------------------
-- Table structure for `t_file_image`
-- ----------------------------
DROP TABLE IF EXISTS `t_file_image`;
CREATE TABLE `t_file_image` (
  `fi_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_id` int(11) DEFAULT NULL,
  `fi_addr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_file_image
-- ----------------------------
INSERT INTO `t_file_image` VALUES ('6', '9', 'E:\\job\\taobao\\weixin_course_sys\\target\\archetype-1.1\\file\\\\3\\9\\1525496016479\\');

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
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('101', '0', '讨论开始1', '2018-05-02 22:24:14', '9', '1', '1');
INSERT INTO `t_message` VALUES ('102', '0', '讨论开始2', '2018-05-02 22:24:27', '9', '1', '1');
INSERT INTO `t_message` VALUES ('103', '102', '2222', '2018-05-02 22:24:37', '9', '1', '1');
INSERT INTO `t_message` VALUES ('104', '103', '3333', '2018-05-02 22:24:48', '9', '1', '1');
INSERT INTO `t_message` VALUES ('105', '102', '222-2', '2018-05-02 22:27:44', '9', '1', '1');
INSERT INTO `t_message` VALUES ('106', '0', '测试', '2018-05-02 22:31:36', '9', '1', '1');
INSERT INTO `t_message` VALUES ('107', '106', '好的噢', '2018-05-02 22:31:48', '9', '1', '1');
INSERT INTO `t_message` VALUES ('108', '107', '你说啥？？？', '2018-05-02 22:32:01', '9', '1', '1');
INSERT INTO `t_message` VALUES ('109', '108', '鸶', '2018-05-02 22:32:14', '9', '1', '1');
INSERT INTO `t_message` VALUES ('110', '103', '九点之前', '2018-05-02 22:32:35', '9', '1', '1');
INSERT INTO `t_message` VALUES ('111', '104', '4444', '2018-05-02 22:32:43', '9', '1', '1');
INSERT INTO `t_message` VALUES ('112', '111', '彡彡', '2018-05-02 22:32:58', '9', '1', '1');
INSERT INTO `t_message` VALUES ('113', '112', '紧急', '2018-05-02 22:33:21', '9', '1', '1');
INSERT INTO `t_message` VALUES ('114', '113', 'huifu', '2018-05-04 22:33:00', '9', '1', '31');
INSERT INTO `t_message` VALUES ('115', '113', 'jiaoshi-huifu', '2018-05-04 22:43:07', '9', '2', '2');
INSERT INTO `t_message` VALUES ('116', '0', '', '2018-05-05 00:29:20', '9', '1', '1');
INSERT INTO `t_message` VALUES ('117', '0', '你好？', '2018-05-05 14:44:40', '9', '1', '1');
INSERT INTO `t_message` VALUES ('118', '117', '可以', '2018-05-05 14:44:47', '9', '1', '1');
INSERT INTO `t_message` VALUES ('119', '0', '嘎嘎嘎嘎嘎', '2018-05-07 21:16:44', '10', '1', '32');
INSERT INTO `t_message` VALUES ('120', '0', '这节课讲的什么呀？', '2018-05-07 21:28:05', '11', '1', '32');
INSERT INTO `t_message` VALUES ('121', '120', '不知道哦！', '2018-05-07 21:28:23', '11', '1', '32');
INSERT INTO `t_message` VALUES ('122', '0', '', '2018-05-07 21:28:24', '11', '1', '32');
INSERT INTO `t_message` VALUES ('123', '0', '高数课吗？', '2018-05-07 21:28:45', '11', '1', '32');
INSERT INTO `t_message` VALUES ('124', '0', '难不难啊？', '2018-05-07 21:31:04', '11', '1', '32');
INSERT INTO `t_message` VALUES ('125', '0', '', '2018-05-07 21:31:09', '11', '1', '32');
INSERT INTO `t_message` VALUES ('126', '114', '加油！', '2018-05-07 21:32:56', '9', '1', '32');
INSERT INTO `t_message` VALUES ('127', '0', '好难啊！', '2018-05-07 21:33:25', '9', '1', '32');
INSERT INTO `t_message` VALUES ('128', '0', '', '2018-05-07 21:33:26', '9', '1', '32');
INSERT INTO `t_message` VALUES ('129', '0', '', '2018-05-08 19:41:00', '9', '1', '1');
INSERT INTO `t_message` VALUES ('130', '0', '可以吗？', '2018-05-08 19:55:00', '9', '1', '1');
INSERT INTO `t_message` VALUES ('131', '127', '我回复你了', '2018-05-08 20:18:45', '9', '1', '1');
INSERT INTO `t_message` VALUES ('132', '0', '说实话，听不懂', '2018-05-08 20:25:00', '9', '1', '32');
INSERT INTO `t_message` VALUES ('133', '126', '回复你了？', '2018-05-08 20:25:57', '9', '1', '1');
INSERT INTO `t_message` VALUES ('134', '130', '什么可以？', '2018-05-08 21:30:49', '9', '2', '4');
INSERT INTO `t_message` VALUES ('135', '134', '没什么……', '2018-05-08 21:31:16', '9', '1', '1');
INSERT INTO `t_message` VALUES ('136', '135', '额', '2018-05-08 21:31:37', '9', '2', '4');
INSERT INTO `t_message` VALUES ('137', '136', '额什么？', '2018-05-08 21:32:38', '9', '1', '1');

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
  `chat_head_addr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES ('1', '211106402', '张三', '123456', '', '3', '0', null, '', '/file/icon/211106402_1525583142009.jpg');
INSERT INTO `t_student` VALUES ('31', '211106412', '李四', '', '', '3', '1', null, 'owug5t_1Q7dYlFQLhfdgbKFitz_w', '');
INSERT INTO `t_student` VALUES ('32', '2018001', 'chen', '123456', '', '3', '1', null, 'owug5t86Yg2eLWYsY-aVPirzTfVg', '/file/icon/2018001_1525700163987.jpg');

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
  `chat_head_addr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `FK_USER_ROLE` (`user_role`),
  CONSTRAINT `t_user_ibfk_1` FOREIGN KEY (`user_role`) REFERENCES `t_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', '系统管理员', '123456', '', '1', '1', '1', '2015-03-04 22:55:38', '', '');
INSERT INTO `t_user` VALUES ('2', 'jiaoshi', '教师', '123456', '', '2', '1', '1', '2015-03-05 11:21:11', '', '');
INSERT INTO `t_user` VALUES ('3', 'jiaoshi2', '教师2', '123456', '', '2', '1', '1', '2018-04-20 21:26:07', '', '');
INSERT INTO `t_user` VALUES ('4', 'jiaoshi3', '教师3', '123456', '', '2', '1', '1', '2018-05-04 20:56:33', 'owug5t1qEvaC8PnxPlBVrjKYFWwg', '/file/icon/jiaoshi3_1525786121569.jpg');

-- ----------------------------
-- View structure for `v_user`
-- ----------------------------
DROP VIEW IF EXISTS `v_user`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_user` AS select `t1`.`user_id` AS `user_id`,`t1`.`login_name` AS `login_name`,`t1`.`nick_name` AS `nick_name`,`t1`.`password` AS `password`,`t1`.`salt` AS `salt`,`t1`.`user_role` AS `user_role`,`t1`.`state` AS `state`,`t1`.`create_id` AS `create_id`,`t1`.`create_time` AS `create_time`,`t1`.`weixin_id` AS `weixin_id`,`t1`.`chat_head_addr` AS `chat_head_addr`,`t2`.`role_name` AS `role_name`,`t2`.`role_code` AS `role_code`,`t3`.`login_name` AS `create_name` from ((`t_user` `t1` left join `t_role` `t2` on((`t1`.`user_role` = `t2`.`role_id`))) left join `t_user` `t3` on((`t1`.`create_id` = `t3`.`user_id`))) ;
