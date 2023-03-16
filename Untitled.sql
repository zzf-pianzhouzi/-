CREATE TABLE `acidcheck`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stuId` int(11) NULL DEFAULT NULL,
  `pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `check` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

CREATE TABLE `news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发布人',
  `Newstime` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

CREATE TABLE `stu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stuId` int(11) NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `classes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `role` int(11) NULL DEFAULT NULL COMMENT '1学生，2教师，3管理员',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;
INSERT INTO `acidcheck`(`id`, `stuId`, `pic`, `check`, `time`) VALUES (3, 2, '1', '3', '2023-02-08 17:46:00');
INSERT INTO `acidcheck`(`id`, `stuId`, `pic`, `check`, `time`) VALUES (5, 2, '2', '2', '2023-02-09 13:20:15');
INSERT INTO `acidcheck`(`id`, `stuId`, `pic`, `check`, `time`) VALUES (6, 3, '1', '1', '2023-02-09 13:20:23');
INSERT INTO `acidcheck`(`id`, `stuId`, `pic`, `check`, `time`) VALUES (7, 4, '1', '1', '2023-02-09 13:20:32');
INSERT INTO `acidcheck`(`id`, `stuId`, `pic`, `check`, `time`) VALUES (8, 5, '1', '1', '2023-02-09 13:20:41');
INSERT INTO `acidcheck`(`id`, `stuId`, `pic`, `check`, `time`) VALUES (9, 1, '1', '1', '2023-02-08 03:36:56');
INSERT INTO `acidcheck`(`id`, `stuId`, `pic`, `check`, `time`) VALUES (10, 1, '1', '1', '2023-02-09 03:37:11');
INSERT INTO `acidcheck`(`id`, `stuId`, `pic`, `check`, `time`) VALUES (11, 1, '1', '1', '2023-02-10 03:37:18');
INSERT INTO `news`(`id`, `title`, `content`, `author`, `Newstime`) VALUES (2, '999', '<p>999</p>', '5', '2023-01-04 22:28:56');
INSERT INTO `stu`(`id`, `stuId`, `password`, `name`, `phone`, `classes`, `role`) VALUES (2, 1, '111', '张三', '123456', '软工一班', 1);
INSERT INTO `stu`(`id`, `stuId`, `password`, `name`, `phone`, `classes`, `role`) VALUES (3, 2, '222', '李四', '22222', '软工一班', 2);
INSERT INTO `stu`(`id`, `stuId`, `password`, `name`, `phone`, `classes`, `role`) VALUES (4, 3, '333', '王五', '33333', '软工一班', 1);
INSERT INTO `stu`(`id`, `stuId`, `password`, `name`, `phone`, `classes`, `role`) VALUES (5, 4, '444', '赵六', '44444', '软工二班', 1);
INSERT INTO `stu`(`id`, `stuId`, `password`, `name`, `phone`, `classes`, `role`) VALUES (11, 5, '555', '哈哈', '55555', '', 3);
INSERT INTO `stu`(`id`, `stuId`, `password`, `name`, `phone`, `classes`, `role`) VALUES (12, 6, '666', '张三', '66666', '软工三班', 1);
INSERT INTO `stu`(`id`, `stuId`, `password`, `name`, `phone`, `classes`, `role`) VALUES (17, 7, '777', '999', '77777', '软工三班', 1);
INSERT INTO `stu`(`id`, `stuId`, `password`, `name`, `phone`, `classes`, `role`) VALUES (19, 8, '888', '888', '88888', NULL, 1);

