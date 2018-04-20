/*
Navicat MySQL Data Transfer

Source Server         : loc
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : h5_work_sys

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2018-04-12 16:41:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_answer`
-- ----------------------------
DROP TABLE IF EXISTS `t_answer`;
CREATE TABLE `t_answer` (
  `a_id` int(11) NOT NULL AUTO_INCREMENT,
  `a_answer` varchar(255) DEFAULT NULL,
  `a_correct` int(1) NOT NULL,
  `q_id` int(11) NOT NULL,
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_answer
-- ----------------------------
INSERT INTO `t_answer` VALUES ('1', '苹果', '0', '1');
INSERT INTO `t_answer` VALUES ('2', '橘子', '1', '1');
INSERT INTO `t_answer` VALUES ('4', '正确答案是。。。', '1', '2');
INSERT INTO `t_answer` VALUES ('5', '芦柑', '0', '3');
INSERT INTO `t_answer` VALUES ('6', '橙子', '1', '3');

-- ----------------------------
-- Table structure for `t_clzss`
-- ----------------------------
DROP TABLE IF EXISTS `t_clzss`;
CREATE TABLE `t_clzss` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '班级主键id',
  `grade` varchar(255) DEFAULT NULL,
  `clzss` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_clzss
-- ----------------------------
INSERT INTO `t_clzss` VALUES ('1', '2011', '3');
INSERT INTO `t_clzss` VALUES ('2', '2', '1');
INSERT INTO `t_clzss` VALUES ('3', '3', '1');
INSERT INTO `t_clzss` VALUES ('4', '4', '1');
INSERT INTO `t_clzss` VALUES ('5', '5', '1');
INSERT INTO `t_clzss` VALUES ('6', '6', '1');
INSERT INTO `t_clzss` VALUES ('7', '1', '2');
INSERT INTO `t_clzss` VALUES ('8', '2', '2');
INSERT INTO `t_clzss` VALUES ('9', '3', '2');
INSERT INTO `t_clzss` VALUES ('10', '4', '2');
INSERT INTO `t_clzss` VALUES ('11', '5', '2');
INSERT INTO `t_clzss` VALUES ('12', '6', '2');
INSERT INTO `t_clzss` VALUES ('13', '1', '3');
INSERT INTO `t_clzss` VALUES ('14', '2', '3');
INSERT INTO `t_clzss` VALUES ('15', '3', '3');
INSERT INTO `t_clzss` VALUES ('16', '4', '3');
INSERT INTO `t_clzss` VALUES ('17', '5', '3');
INSERT INTO `t_clzss` VALUES ('18', '6', '3');
INSERT INTO `t_clzss` VALUES ('19', '1', '4');
INSERT INTO `t_clzss` VALUES ('20', '2', '4');
INSERT INTO `t_clzss` VALUES ('21', '3', '4');
INSERT INTO `t_clzss` VALUES ('22', '4', '4');
INSERT INTO `t_clzss` VALUES ('23', '5', '4');
INSERT INTO `t_clzss` VALUES ('24', '6', '4');
INSERT INTO `t_clzss` VALUES ('25', '1', '5');
INSERT INTO `t_clzss` VALUES ('26', '2', '5');
INSERT INTO `t_clzss` VALUES ('27', '3', '5');
INSERT INTO `t_clzss` VALUES ('28', '4', '5');
INSERT INTO `t_clzss` VALUES ('29', '5', '5');
INSERT INTO `t_clzss` VALUES ('30', '6', '5');
INSERT INTO `t_clzss` VALUES ('31', '1', '6');
INSERT INTO `t_clzss` VALUES ('32', '2', '6');
INSERT INTO `t_clzss` VALUES ('33', '3', '6');
INSERT INTO `t_clzss` VALUES ('34', '4', '6');
INSERT INTO `t_clzss` VALUES ('35', '5', '6');
INSERT INTO `t_clzss` VALUES ('36', '6', '6');

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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES ('1', 'system', '0', '系统管理', '', '5', '1');
INSERT INTO `t_menu` VALUES ('2', 'menu', '1', '菜单管理', 'menu', '1', '1');
INSERT INTO `t_menu` VALUES ('3', 'role', '1', '角色管理', 'role', '2', '1');
INSERT INTO `t_menu` VALUES ('4', 'user', '1', '用户管理', 'user', '3', '1');
INSERT INTO `t_menu` VALUES ('5', 'zidian', '0', '系统数据', '', '6', '1');
INSERT INTO `t_menu` VALUES ('8', 'info', '0', '信息管理', '', '1', '1');
INSERT INTO `t_menu` VALUES ('10', 'student', '8', '学生信息管理', 'student', '1', '1');
INSERT INTO `t_menu` VALUES ('23', 'gongneng', '0', '教师工具', '', '4', '1');
INSERT INTO `t_menu` VALUES ('29', 'work', '8', '作业管理', 'work', '5', '1');
INSERT INTO `t_menu` VALUES ('31', '1429321176178', '0', '父', '', null, '1');
INSERT INTO `t_menu` VALUES ('32', 'questionMessage', '23', '答疑', 'message/toQuestionMessage', '2', '1');
INSERT INTO `t_menu` VALUES ('33', 'toDiscuss', '23', '参与讨论', 'message/toDiscuss?wId=1', '3', '1');
INSERT INTO `t_menu` VALUES ('34', 'classManagement', '5', '班级管理', 'clzss', '1', '1');
INSERT INTO `t_menu` VALUES ('35', 'workManagement', '23', '作业管理', 'work', '1', '1');
INSERT INTO `t_menu` VALUES ('36', 'questionAnswer', '23', '题库管理', 'questionAnswer', '1', '1');

-- ----------------------------
-- Table structure for `t_message`
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `msg_pid` int(11) NOT NULL,
  `msg_type` int(1) NOT NULL COMMENT '消息类型。1：提问，2：讨论',
  `msg_content` varchar(500) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `w_id` int(11) NOT NULL COMMENT '作业ID',
  `oper_role` int(1) NOT NULL COMMENT '发送角色，1:老师，2:学生',
  `oper_id` int(11) NOT NULL COMMENT '发送者ID',
  PRIMARY KEY (`msg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('1', '0', '1', '请问', '2018-04-09 09:49:17', '1', '1', '1');
INSERT INTO `t_message` VALUES ('2', '1', '1', '回答', '2018-04-09 09:49:33', '1', '2', '2');
INSERT INTO `t_message` VALUES ('3', '0', '1', '请问2', '2018-04-09 10:41:22', '1', '1', '1');
INSERT INTO `t_message` VALUES ('4', '3', '1', '回答2', '2018-04-09 11:04:33', '1', '1', '2');
INSERT INTO `t_message` VALUES ('5', '0', '2', 'JAVA中hashmap。。。', '2018-04-09 15:27:41', '1', '1', '1');
INSERT INTO `t_message` VALUES ('6', '0', '2', 'java中ArrayList...', '2018-04-09 15:29:25', '1', '1', '1');
INSERT INTO `t_message` VALUES ('7', '5', '2', 'hashMap是键值对', '2018-04-09 15:29:56', '1', '1', '25');
INSERT INTO `t_message` VALUES ('8', '7', '2', 'hashmap原理。。。', '2018-04-09 15:30:21', '1', '2', '2');
INSERT INTO `t_message` VALUES ('9', '6', '2', 'arraylist原理。。。', '2018-04-09 15:30:41', '1', '2', '2');
INSERT INTO `t_message` VALUES ('10', '9', '2', 'arraylist是线程不安全的', '2018-04-10 09:22:36', '1', '2', '2');
INSERT INTO `t_message` VALUES ('11', '10', '2', '好的', '2018-04-10 09:22:57', '1', '2', '2');

-- ----------------------------
-- Table structure for `t_question`
-- ----------------------------
DROP TABLE IF EXISTS `t_question`;
CREATE TABLE `t_question` (
  `q_id` int(11) NOT NULL AUTO_INCREMENT,
  `q_title` varchar(255) NOT NULL,
  `q_type` int(1) NOT NULL,
  PRIMARY KEY (`q_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_question
-- ----------------------------
INSERT INTO `t_question` VALUES ('1', '你喜欢吃的水果？', '1');
INSERT INTO `t_question` VALUES ('2', '你喜欢吃的水果2？', '2');
INSERT INTO `t_question` VALUES ('3', '你喜欢吃的水果？3', '1');
INSERT INTO `t_question` VALUES ('4', '你喜欢吃的水果？4', '1');
INSERT INTO `t_question` VALUES ('5', '你喜欢吃的水果？5', '1');
INSERT INTO `t_question` VALUES ('6', '你喜欢吃的水果？6', '1');
INSERT INTO `t_question` VALUES ('7', '你喜欢吃的水果？7', '1');
INSERT INTO `t_question` VALUES ('8', '你喜欢吃的水果？8', '1');
INSERT INTO `t_question` VALUES ('9', '你喜欢吃的水果？9', '1');
INSERT INTO `t_question` VALUES ('10', '你喜欢吃的水果？10', '1');
INSERT INTO `t_question` VALUES ('11', '你喜欢吃的水果？11', '1');

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
INSERT INTO `t_role` VALUES ('1', 'admin', '管理员', null, '拥有最高权限。', '1', '1', '1', '2015-03-05 09:47:47', '2018-04-10 19:04:42');
INSERT INTO `t_role` VALUES ('2', 'teacher', '教师', null, '拥有一些信息之类的管理。', '1', '1', '1', '2015-03-05 11:19:05', '2018-04-12 11:36:35');
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
INSERT INTO `t_role_permission` VALUES ('1', 'info:');
INSERT INTO `t_role_permission` VALUES ('1', 'student:');
INSERT INTO `t_role_permission` VALUES ('1', 'work:');
INSERT INTO `t_role_permission` VALUES ('1', 'gongneng:');
INSERT INTO `t_role_permission` VALUES ('1', 'questionAnswer:');
INSERT INTO `t_role_permission` VALUES ('1', 'workManagement:');
INSERT INTO `t_role_permission` VALUES ('1', 'questionMessage:');
INSERT INTO `t_role_permission` VALUES ('1', 'toDiscuss:');
INSERT INTO `t_role_permission` VALUES ('1', 'system:');
INSERT INTO `t_role_permission` VALUES ('1', 'menu:');
INSERT INTO `t_role_permission` VALUES ('1', 'role:');
INSERT INTO `t_role_permission` VALUES ('1', 'user:');
INSERT INTO `t_role_permission` VALUES ('1', 'zidian:');
INSERT INTO `t_role_permission` VALUES ('1', 'classManagement:');
INSERT INTO `t_role_permission` VALUES ('2', 'info:');
INSERT INTO `t_role_permission` VALUES ('2', 'student:');
INSERT INTO `t_role_permission` VALUES ('2', 'work:');
INSERT INTO `t_role_permission` VALUES ('2', 'gongneng:');
INSERT INTO `t_role_permission` VALUES ('2', 'questionAnswer:');
INSERT INTO `t_role_permission` VALUES ('2', 'workManagement:');
INSERT INTO `t_role_permission` VALUES ('2', 'questionMessage:');
INSERT INTO `t_role_permission` VALUES ('2', 'toDiscuss:');
INSERT INTO `t_role_permission` VALUES ('2', 'zidian:');
INSERT INTO `t_role_permission` VALUES ('2', 'classManagement:');

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
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES ('1', '211106402', '王荣坡', '123456', null, '3', '0', '1');
INSERT INTO `t_student` VALUES ('25', '211106378', '陈洪玮', '', null, '3', '0', '1');
INSERT INTO `t_student` VALUES ('26', '211106379', '陈建俊', '', '', '3', '0', '2');
INSERT INTO `t_student` VALUES ('27', '211106380', '陈建旺', '', '', '3', '0', '1');
INSERT INTO `t_student` VALUES ('28', '211106381', '陈建增', '', '', '3', '0', '1');
INSERT INTO `t_student` VALUES ('29', '211106393', '李娜端', '', '', '3', '1', '2');
INSERT INTO `t_student` VALUES ('30', '211106405', '谢能炎', '', null, '3', '0', '1');
INSERT INTO `t_student` VALUES ('31', '211106412', '余双', '', null, '3', '1', '1');
INSERT INTO `t_student` VALUES ('32', '211106409', '杨琴霞', '', null, '3', '1', '2');
INSERT INTO `t_student` VALUES ('34', '211106401', '测试', '', null, '3', '0', '2');
INSERT INTO `t_student` VALUES ('35', '211106001', '张三', '', null, '3', '0', '2');
INSERT INTO `t_student` VALUES ('36', '211106002', '李四', '', null, '3', '1', '2');
INSERT INTO `t_student` VALUES ('37', '211106003', '王五', '', null, '3', '0', '2');
INSERT INTO `t_student` VALUES ('38', '211106004', '赵六', '', null, '3', '0', '2');
INSERT INTO `t_student` VALUES ('39', '211106005', '孙七', '', null, '3', '0', '2');
INSERT INTO `t_student` VALUES ('40', '211106006', '周八', '', null, '3', '1', '2');
INSERT INTO `t_student` VALUES ('41', '211106007', '吴九', '', null, '3', '0', '2');
INSERT INTO `t_student` VALUES ('42', '211106008', '郑十', '', null, '3', '1', '2');
INSERT INTO `t_student` VALUES ('43', '211101111', 'ceshi', '123456', null, '3', '0', '2');
INSERT INTO `t_student` VALUES ('44', '211806101', '测试1', '123456', null, '3', '0', '2');
INSERT INTO `t_student` VALUES ('45', '211806102', '测试2', '123456', null, '3', '0', '2');

-- ----------------------------
-- Table structure for `t_stu_question`
-- ----------------------------
DROP TABLE IF EXISTS `t_stu_question`;
CREATE TABLE `t_stu_question` (
  `sq_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_id` int(11) DEFAULT NULL COMMENT 'student_id',
  `w_id` int(11) DEFAULT NULL COMMENT 'work_id',
  `q_id` int(11) DEFAULT NULL COMMENT '问题ID',
  `q_answer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_stu_question
-- ----------------------------
INSERT INTO `t_stu_question` VALUES ('1', '1', '1', '1', '橘子');
INSERT INTO `t_stu_question` VALUES ('2', '1', '1', '2', '正确答案是。。。');
INSERT INTO `t_stu_question` VALUES ('3', '1', '1', '3', '橙子');

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
  PRIMARY KEY (`user_id`),
  KEY `FK_USER_ROLE` (`user_role`),
  CONSTRAINT `t_user_ibfk_1` FOREIGN KEY (`user_role`) REFERENCES `t_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', 'wrp', '123456', null, '1', '1', '1', '2015-03-04 22:55:38');
INSERT INTO `t_user` VALUES ('2', 'cjr', '陈家瑞', '123456', null, '2', '1', '1', '2015-03-05 11:21:11');

-- ----------------------------
-- Table structure for `t_work`
-- ----------------------------
DROP TABLE IF EXISTS `t_work`;
CREATE TABLE `t_work` (
  `w_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_tch_id` int(11) DEFAULT NULL,
  `clzss_id` int(11) DEFAULT NULL,
  `w_work_name` varchar(50) DEFAULT NULL,
  `w_add_time` datetime DEFAULT NULL,
  `w_work_requirement` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`w_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_work
-- ----------------------------
INSERT INTO `t_work` VALUES ('1', '2', '1', '做一个网上商城的项目。', '2015-04-17 20:55:06', '使用SpringMVC');

-- ----------------------------
-- Table structure for `t_work_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_work_info`;
CREATE TABLE `t_work_info` (
  `wi_id` int(11) NOT NULL AUTO_INCREMENT,
  `w_id` int(11) DEFAULT NULL,
  `s_id` int(11) DEFAULT NULL,
  `wi_add_time` datetime DEFAULT NULL,
  `w_i_score` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`wi_id`),
  KEY `FK_WORKINFO_WORK` (`w_id`),
  KEY `FK_WORKINFO_STUDENT` (`s_id`),
  CONSTRAINT `t_work_info_ibfk_1` FOREIGN KEY (`s_id`) REFERENCES `t_student` (`s_id`),
  CONSTRAINT `t_work_info_ibfk_2` FOREIGN KEY (`w_id`) REFERENCES `t_work` (`w_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_work_info
-- ----------------------------
INSERT INTO `t_work_info` VALUES ('1', '1', '1', '2015-04-17 20:56:12', '50');
INSERT INTO `t_work_info` VALUES ('2', '1', '31', '2015-04-17 21:05:43', '50');

-- ----------------------------
-- Table structure for `t_work_question`
-- ----------------------------
DROP TABLE IF EXISTS `t_work_question`;
CREATE TABLE `t_work_question` (
  `wq_id` int(11) NOT NULL AUTO_INCREMENT,
  `w_id` int(11) DEFAULT NULL COMMENT '作业ID',
  `q_id` int(11) DEFAULT NULL COMMENT '题目ID',
  PRIMARY KEY (`wq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_work_question
-- ----------------------------
INSERT INTO `t_work_question` VALUES ('1', '1', '1');
INSERT INTO `t_work_question` VALUES ('4', '1', '2');
INSERT INTO `t_work_question` VALUES ('5', '1', '3');

-- ----------------------------
-- View structure for `v_user`
-- ----------------------------
DROP VIEW IF EXISTS `v_user`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_user` AS select `t1`.`user_id` AS `user_id`,`t1`.`login_name` AS `login_name`,`t1`.`nick_name` AS `nick_name`,`t1`.`password` AS `password`,`t1`.`salt` AS `salt`,`t1`.`user_role` AS `user_role`,`t1`.`state` AS `state`,`t1`.`create_id` AS `create_id`,`t1`.`create_time` AS `create_time`,`t2`.`role_name` AS `role_name`,`t2`.`role_code` AS `role_code`,`t3`.`login_name` AS `create_name` from ((`t_user` `t1` left join `t_role` `t2` on((`t1`.`user_role` = `t2`.`role_id`))) left join `t_user` `t3` on((`t1`.`create_id` = `t3`.`user_id`))) ;
