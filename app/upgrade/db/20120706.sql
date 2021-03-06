INSERT INTO `[#DB_PREFIX#]system_setting` (`varname`, `value`) VALUES ('best_agree_min_count', 's:1:"3";');
ALTER TABLE `[#DB_PREFIX#]question_invite` ADD `email` VARCHAR( 255 ) NULL DEFAULT NULL COMMENT '受邀Email' AFTER `recipients_uid`;
ALTER TABLE `[#DB_PREFIX#]question_invite` CHANGE `recipients_uid` `recipients_uid` INT( 11 ) NULL DEFAULT NULL;
DELETE FROM `[#DB_PREFIX#]system_setting` WHERE `varname` = 'question_edit_time';

ALTER TABLE `[#DB_PREFIX#]reputation_topic` ADD `best_answer_count` INT(10) DEFAULT '0' NULL;
ALTER TABLE `[#DB_PREFIX#]reputation_topic` ADD `agree_count` INT(10) DEFAULT '0' NULL ;
ALTER TABLE `[#DB_PREFIX#]reputation_topic` ADD `thanks_count` INT(10) DEFAULT '0' NULL ;
ALTER TABLE `[#DB_PREFIX#]reputation_topic` ADD `reputation` INT(10) DEFAULT '0' NULL ;

CREATE TABLE `[#DB_PREFIX#]attach` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) DEFAULT NULL COMMENT '附件名称',
  `access_key` varchar(32) DEFAULT NULL COMMENT '批次 Key',
  `add_time` int(10) DEFAULT '0' COMMENT '上传时间',
  `file_location` varchar(255) DEFAULT NULL COMMENT '文件位置',
  `is_image` int(1) DEFAULT '0',
  `item_type` varchar(32) DEFAULT '0' COMMENT '关联类型',
  `item_id` int(11) DEFAULT '0' COMMENT '关联 ID',
  PRIMARY KEY (`id`),
  KEY `access_key` (`access_key`),
  KEY `fetch` (`item_id`,`item_type`)
) ENGINE=[#DB_ENGINE#] DEFAULT CHARSET=utf8;

INSERT INTO  `[#DB_PREFIX#]attach` (
 `file_name` ,
 `access_key` ,
 `add_time` ,
 `file_location` ,
 `is_image` ,
 `item_id` ,
`item_type`
)
SELECT  `file_name` ,  `access_key` ,  `add_time` ,  `file_location` ,  `is_image` ,  `question_id` ,  'question'
FROM `[#DB_PREFIX#]question_attach`;

INSERT INTO  `[#DB_PREFIX#]attach` (
 `file_name` ,
 `access_key` ,
 `add_time` ,
 `file_location` ,
 `is_image` ,
 `item_id` ,
`item_type`
)
SELECT  `file_name` ,  `access_key` ,  `add_time` ,  `file_location` ,  `is_image` ,  `answer_id` ,  'answer'
FROM `[#DB_PREFIX#]answer_attach`;

DROP TABLE `[#DB_PREFIX#]question_attach`;
DROP TABLE `[#DB_PREFIX#]answer_attach`;

ALTER TABLE `[#DB_PREFIX#]users_sina` CHANGE `id` `id` BIGINT( 11 ) NOT NULL COMMENT '新浪用户 ID';
ALTER TABLE `[#DB_PREFIX#]users_qq` CHANGE `id` `id` BIGINT( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT;
DELETE FROM `[#DB_PREFIX#]users_sina` WHERE id = 2147483647;
