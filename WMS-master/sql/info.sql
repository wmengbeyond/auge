###  中心仓数据
CREATE TABLE `wms_warehouse` (
  `wh_id` int(11) NOT NULL AUTO_INCREMENT,
  `wh_code` varchar(32) NOT NULL COMMENT '编号',
  `wh_name` varchar(32) NOT NULL DEFAULT '' COMMENT '名称',
  `wh_addr` varchar(64) NOT NULL DEFAULT '' COMMENT '地址',
  `wh_tel` varchar(16) NOT NULL DEFAULT '' COMMENT '电话',
  `wh_contact` varchar(16) NOT NULL DEFAULT '' COMMENT '联系人',
  `wh_phone` varchar(16) NOT NULL DEFAULT '' COMMENT '手机号',
  `wh_mtime` int(11) DEFAULT '0' COMMENT '修改时间',
  `wh_ctime` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`wh_id`),
  UNIQUE KEY `idx_code` (`wh_code`),
  KEY `idx_name` (`wh_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

###  商品品牌信息
CREATE TABLE `wms_brand` (
  `brand_id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_code` varchar(16) NOT NULL COMMENT '品牌编号',
  `brand_name` varchar(32) NOT NULL DEFAULT '' COMMENT '品牌名称',
  `brand_type` varchar(16) NOT NULL DEFAULT '' COMMENT '品牌类型 自有品牌 代理品牌 同质配套 无',
  `brand_cj` varchar(32) NOT NULL DEFAULT '' COMMENT '品牌厂家',
  `brand_status` int(11) NOT NULL DEFAULT '1' COMMENT '品牌状态 1 启用 0 禁用',
  `brand_ctime` int(11) DEFAULT '0' COMMENT '创建时间',
  `brand_cperson` varchar(16) NOT NULL DEFAULT '' COMMENT '建档人',
  `brand_mtime` int(11) DEFAULT '0' COMMENT '修改时间',
  `brand_mperson` varchar(16) NOT NULL DEFAULT '' COMMENT '修改人',
  PRIMARY KEY (`brand_id`),
  UNIQUE KEY `idx_code` (`brand_code`),
  KEY `idx_name` (`brand_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

insert into `wms_db`.`wms_brand` ( `brand_code`, `brand_name`, `brand_type`, `brand_cj`, `brand_status`, `brand_ctime`, `brand_cperson`, `brand_mtime`, `brand_mperson`) values ( 'PP0001', '米其林', '自有品牌', '米其林（中国）投资有限公司', '1', '1519573348', '骑士', '1519573348', '骑士');

### 商品类别信息
CREATE TABLE `wms_goods_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_code` varchar(16) NOT NULL COMMENT '类别编号',
  `category_name` varchar(32) NOT NULL DEFAULT '' COMMENT '类别名称',
  `category_type` varchar(16) NOT NULL DEFAULT '' COMMENT '类别分级 类别一级 类别二级 类别三级',
  `category_status` int(11) NOT NULL DEFAULT '1' COMMENT '类别状态 1 启用 0 禁用',
  `category_ctime` bigint(13) DEFAULT '0' COMMENT '创建时间',
  `category_cperson` varchar(16) NOT NULL DEFAULT '' COMMENT '建档人',
  `category_mtime` bigint(13) DEFAULT '0' COMMENT '修改时间',
  `category_mperson` varchar(16) NOT NULL DEFAULT '' COMMENT '修改人',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `idx_code` (`category_code`),
  KEY `idx_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

### 商品属性信息
CREATE TABLE `wms_goods_attr` (
  `attr_id` int(11) NOT NULL AUTO_INCREMENT,
  `attr_code` varchar(16) NOT NULL COMMENT '商品属性信息编号',
  `attr_name` varchar(32) NOT NULL DEFAULT '' COMMENT '商品属性信息名称',
  `attr_alias` varchar(32) NOT NULL DEFAULT '' COMMENT '商品属性信息别名',
  `attr_cat1` varchar(16) NOT NULL DEFAULT '' COMMENT '商品属性信息类别1',
  `attr_cat2` varchar(16) NOT NULL DEFAULT '' COMMENT '商品属性信息类别2',
  `attr_cat3` varchar(16) NOT NULL DEFAULT '' COMMENT '商品属性信息类别3',
  `attr_status` int(11) NOT NULL DEFAULT '1' COMMENT '商品属性信息状态 1 启用 0 禁用',
  `attr_ctime` bigint(13) DEFAULT '0' COMMENT '创建时间',
  `attr_cperson` varchar(16) NOT NULL DEFAULT '' COMMENT '建档人',
  `attr_mtime` bigint(13) DEFAULT '0' COMMENT '修改时间',
  `attr_mperson` varchar(16) NOT NULL DEFAULT '' COMMENT '修改人',
  `attr_param1` varchar(16) NOT NULL DEFAULT '' COMMENT '参数1',
  `attr_param2` varchar(16) NOT NULL DEFAULT '' COMMENT '参数2',
  `attr_param3` varchar(16) NOT NULL DEFAULT '' COMMENT '参数3',
  `attr_param4` varchar(16) NOT NULL DEFAULT '' COMMENT '参数4',
  `attr_param5` varchar(16) NOT NULL DEFAULT '' COMMENT '参数5',
  `attr_param6` varchar(16) NOT NULL DEFAULT '' COMMENT '参数6',
  `attr_param7` varchar(16) NOT NULL DEFAULT '' COMMENT '参数7',
  `attr_param8` varchar(16) NOT NULL DEFAULT '' COMMENT '参数8',
  `attr_param9` varchar(16) NOT NULL DEFAULT '' COMMENT '参数9',
  `attr_param10` varchar(16) NOT NULL DEFAULT '' COMMENT '参数10',
  `attr_param11` varchar(16) NOT NULL DEFAULT '' COMMENT '参数11',
  `attr_param12` varchar(16) NOT NULL DEFAULT '' COMMENT '参数12',
  `attr_param13` varchar(16) NOT NULL DEFAULT '' COMMENT '参数13',
  `attr_param14` varchar(16) NOT NULL DEFAULT '' COMMENT '参数14',
  `attr_param15` varchar(16) NOT NULL DEFAULT '' COMMENT '参数15',
  `attr_param16` varchar(16) NOT NULL DEFAULT '' COMMENT '参数16',
  PRIMARY KEY (`attr_id`),
  UNIQUE KEY `idx_code` (`attr_code`),
  KEY `idx_name` (`attr_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



CREATE TABLE `wms_supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_code` varchar(16) NOT NULL COMMENT '供应商编码',
  `supplier_person` varchar(32) NOT NULL DEFAULT '' COMMENT '业务联系人',
  `supplier_name` varchar(32) NOT NULL DEFAULT '' COMMENT '供应商名称',
  `supplier_addr` varchar(32) NOT NULL DEFAULT '' COMMENT '经营地址',
  `supplier_email` varchar(16) NOT NULL DEFAULT '' COMMENT '业务邮箱',
  `supplier_billtype` varchar(16) NOT NULL DEFAULT '' COMMENT '票据类型',
  `supplier_bank` varchar(16) NOT NULL DEFAULT '' COMMENT '结算银行',
  `supplier_contact` varchar(16) NOT NULL DEFAULT '' COMMENT '联系方式',
  `supplier_area` varchar(16) NOT NULL DEFAULT '' COMMENT '所属区域',
  `supplier_tel` varchar(16) NOT NULL DEFAULT '' COMMENT '固话/传真',
  `supplier_taxrate` varchar(16) NOT NULL DEFAULT '' COMMENT '开票税点',
  `supplier_yhzh` varchar(16) NOT NULL DEFAULT '' COMMENT '银行账户',
  `supplier_alias` varchar(16) NOT NULL DEFAULT '' COMMENT '简称',
  `supplier_card` varchar(16) NOT NULL DEFAULT '' COMMENT '身份证号',
  `supplier_city` varchar(16) NOT NULL DEFAULT '' COMMENT '所属城市',
  `supplier_qqwx` varchar(16) NOT NULL DEFAULT '' COMMENT '业务QQ/微信',
  `supplier_payment` varchar(16) NOT NULL DEFAULT '' COMMENT '付款方式',
  `supplier_bankacc` varchar(16) NOT NULL DEFAULT '' COMMENT '银行账号',
  `supplier_collaboratetype` varchar(16) NOT NULL DEFAULT '' COMMENT '合作类型',
  `supplier_cardimg` varchar(16) NOT NULL DEFAULT '' COMMENT '身份证照',
  `supplier_store` varchar(16) NOT NULL DEFAULT '' COMMENT '所属仓库',
  `supplier_channel` varchar(16) NOT NULL DEFAULT '' COMMENT '进货渠道',
  `supplier_taxNumber` varchar(16) NOT NULL DEFAULT '' COMMENT '企业税号',
  `supplier_billdata` varchar(16) NOT NULL DEFAULT '' COMMENT '开票资料',
  `supplier_status` int(11) NOT NULL DEFAULT '1' COMMENT '供应商信息状态 1 启用 0 禁用',
  `supplier_ctime` bigint(13) DEFAULT '0' COMMENT '创建时间',
  `supplier_cperson` varchar(16) NOT NULL DEFAULT '' COMMENT '建档人',
  `supplier_mtime` bigint(13) DEFAULT '0' COMMENT '修改时间',
  `supplier_mperson` varchar(16) NOT NULL DEFAULT '' COMMENT '修改人',
  PRIMARY KEY (`supplier_id`),
  UNIQUE KEY `idx_code` (`supplier_code`),
  KEY `idx_name` (`supplier_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
