PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE _mysql_data_types_cache (
		`table` TEXT NOT NULL,
		`column_or_index` TEXT NOT NULL,
		`mysql_type` TEXT NOT NULL,
		PRIMARY KEY(`table`, `column_or_index`)
	);
INSERT INTO _mysql_data_types_cache VALUES('wp_users','ID','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','user_login','varchar(60)');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','user_pass','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','user_nicename','varchar(50)');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','user_email','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','user_url','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','user_registered','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','user_activation_key','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','user_status','int(11)');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','display_name','varchar(250)');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','wp_users__user_login_key','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','wp_users__user_nicename','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_users','wp_users__user_email','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_usermeta','umeta_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_usermeta','user_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_usermeta','meta_key','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_usermeta','meta_value','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_usermeta','wp_usermeta__user_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_usermeta','wp_usermeta__meta_key','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_termmeta','meta_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_termmeta','term_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_termmeta','meta_key','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_termmeta','meta_value','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_termmeta','wp_termmeta__term_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_termmeta','wp_termmeta__meta_key','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_terms','term_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_terms','name','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_terms','slug','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_terms','term_group','bigint(10)');
INSERT INTO _mysql_data_types_cache VALUES('wp_terms','wp_terms__slug','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_terms','wp_terms__name','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_taxonomy','term_taxonomy_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_taxonomy','term_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_taxonomy','taxonomy','varchar(32)');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_taxonomy','description','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_taxonomy','parent','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_taxonomy','count','bigint(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_taxonomy','wp_term_taxonomy__term_id_taxonomy','UNIQUE');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_taxonomy','wp_term_taxonomy__taxonomy','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_relationships','object_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_relationships','term_taxonomy_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_relationships','term_order','int(11)');
INSERT INTO _mysql_data_types_cache VALUES('wp_term_relationships','wp_term_relationships__term_taxonomy_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_commentmeta','meta_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_commentmeta','comment_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_commentmeta','meta_key','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_commentmeta','meta_value','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_commentmeta','wp_commentmeta__comment_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_commentmeta','wp_commentmeta__meta_key','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_ID','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_post_ID','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_author','tinytext');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_author_email','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_author_url','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_author_IP','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_date','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_date_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_content','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_karma','int(11)');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_approved','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_agent','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_type','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','comment_parent','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','user_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','wp_comments__comment_post_ID','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','wp_comments__comment_approved_date_gmt','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','wp_comments__comment_date_gmt','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','wp_comments__comment_parent','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_comments','wp_comments__comment_author_email','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_url','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_name','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_image','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_target','varchar(25)');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_description','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_visible','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_owner','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_rating','int(11)');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_updated','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_rel','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_notes','mediumtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','link_rss','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_links','wp_links__link_visible','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_options','option_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_options','option_name','varchar(191)');
INSERT INTO _mysql_data_types_cache VALUES('wp_options','option_value','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_options','autoload','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_options','wp_options__option_name','UNIQUE');
INSERT INTO _mysql_data_types_cache VALUES('wp_options','wp_options__autoload','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_postmeta','meta_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_postmeta','post_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_postmeta','meta_key','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_postmeta','meta_value','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_postmeta','wp_postmeta__post_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_postmeta','wp_postmeta__meta_key','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','ID','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_author','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_date','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_date_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_content','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_title','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_excerpt','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_status','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','comment_status','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','ping_status','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_password','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_name','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','to_ping','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','pinged','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_modified','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_modified_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_content_filtered','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_parent','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','guid','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','menu_order','int(11)');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_type','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','post_mime_type','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','comment_count','bigint(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','wp_posts__post_name','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','wp_posts__type_status_date','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','wp_posts__post_parent','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','wp_posts__post_author','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_posts','wp_posts__type_status_author','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','action_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','hook','varchar(191)');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','status','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','scheduled_date_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','scheduled_date_local','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','priority','tinyint unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','args','varchar(191)');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','schedule','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','group_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','attempts','int(11)');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','last_attempt_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','last_attempt_local','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','claim_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','extended_args','varchar(8000)');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','wp_actionscheduler_actions__hook_status_scheduled_date_gmt','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','wp_actionscheduler_actions__status_scheduled_date_gmt','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','wp_actionscheduler_actions__scheduled_date_gmt','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','wp_actionscheduler_actions__args','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','wp_actionscheduler_actions__group_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','wp_actionscheduler_actions__last_attempt_gmt','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_actions','wp_actionscheduler_actions__claim_id_status_scheduled_date_gmt','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_claims','claim_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_claims','date_created_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_claims','wp_actionscheduler_claims__date_created_gmt','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_groups','group_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_groups','slug','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_groups','wp_actionscheduler_groups__slug','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_logs','log_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_logs','action_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_logs','message','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_logs','log_date_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_logs','log_date_local','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_logs','wp_actionscheduler_logs__action_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_actionscheduler_logs','wp_actionscheduler_logs__log_date_gmt','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_sessions','session_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_sessions','session_key','char(32)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_sessions','session_value','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_sessions','session_expiry','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_sessions','wp_woocommerce_sessions__session_key','UNIQUE');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_api_keys','key_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_api_keys','user_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_api_keys','description','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_api_keys','permissions','varchar(10)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_api_keys','consumer_key','char(64)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_api_keys','consumer_secret','char(43)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_api_keys','nonces','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_api_keys','truncated_key','char(7)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_api_keys','last_access','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_api_keys','wp_woocommerce_api_keys__consumer_key','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_api_keys','wp_woocommerce_api_keys__consumer_secret','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_attribute_taxonomies','attribute_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_attribute_taxonomies','attribute_name','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_attribute_taxonomies','attribute_label','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_attribute_taxonomies','attribute_type','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_attribute_taxonomies','attribute_orderby','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_attribute_taxonomies','attribute_public','int(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_attribute_taxonomies','wp_woocommerce_attribute_taxonomies__attribute_name','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','permission_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','download_id','varchar(36)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','product_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','order_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','order_key','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','user_email','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','user_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','downloads_remaining','varchar(9)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','access_granted','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','access_expires','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','download_count','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','wp_woocommerce_downloadable_product_permissions__download_order_key_product','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','wp_woocommerce_downloadable_product_permissions__download_order_product','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','wp_woocommerce_downloadable_product_permissions__order_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_downloadable_product_permissions','wp_woocommerce_downloadable_product_permissions__user_order_remaining_expires','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_order_items','order_item_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_order_items','order_item_name','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_order_items','order_item_type','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_order_items','order_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_order_items','wp_woocommerce_order_items__order_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_order_itemmeta','meta_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_order_itemmeta','order_item_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_order_itemmeta','meta_key','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_order_itemmeta','meta_value','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_order_itemmeta','wp_woocommerce_order_itemmeta__order_item_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_order_itemmeta','wp_woocommerce_order_itemmeta__meta_key','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','tax_rate_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','tax_rate_country','varchar(2)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','tax_rate_state','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','tax_rate','varchar(8)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','tax_rate_name','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','tax_rate_priority','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','tax_rate_compound','int(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','tax_rate_shipping','int(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','tax_rate_order','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','tax_rate_class','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','wp_woocommerce_tax_rates__tax_rate_country','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','wp_woocommerce_tax_rates__tax_rate_state','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','wp_woocommerce_tax_rates__tax_rate_class','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rates','wp_woocommerce_tax_rates__tax_rate_priority','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rate_locations','location_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rate_locations','location_code','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rate_locations','tax_rate_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rate_locations','location_type','varchar(40)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rate_locations','wp_woocommerce_tax_rate_locations__tax_rate_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_tax_rate_locations','wp_woocommerce_tax_rate_locations__location_type_code','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zones','zone_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zones','zone_name','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zones','zone_order','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zone_locations','location_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zone_locations','zone_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zone_locations','location_code','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zone_locations','location_type','varchar(40)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zone_locations','wp_woocommerce_shipping_zone_locations__zone_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zone_locations','wp_woocommerce_shipping_zone_locations__location_type_code','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zone_methods','zone_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zone_methods','instance_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zone_methods','method_id','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zone_methods','method_order','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_shipping_zone_methods','is_enabled','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokens','token_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokens','gateway_id','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokens','token','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokens','user_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokens','type','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokens','is_default','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokens','wp_woocommerce_payment_tokens__user_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokenmeta','meta_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokenmeta','payment_token_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokenmeta','meta_key','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokenmeta','meta_value','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokenmeta','wp_woocommerce_payment_tokenmeta__payment_token_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_payment_tokenmeta','wp_woocommerce_payment_tokenmeta__meta_key','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_log','log_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_log','timestamp','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_log','level','smallint(4)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_log','source','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_log','message','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_log','context','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_woocommerce_log','wp_woocommerce_log__level','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','webhook_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','status','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','name','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','user_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','delivery_url','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','secret','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','topic','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','date_created','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','date_created_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','date_modified','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','date_modified_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','api_version','smallint(4)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','failure_count','smallint(10)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','pending_delivery','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_webhooks','wp_wc_webhooks__user_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_download_log','download_log_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_download_log','timestamp','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_download_log','permission_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_download_log','user_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_download_log','user_ip_address','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_download_log','wp_wc_download_log__permission_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_download_log','wp_wc_download_log__timestamp','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','product_id','bigint(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','sku','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','global_unique_id','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','virtual','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','downloadable','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','min_price','decimal(19,4)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','max_price','decimal(19,4)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','onsale','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','stock_quantity','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','stock_status','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','rating_count','bigint(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','average_rating','decimal(3,2)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','total_sales','bigint(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','tax_status','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','tax_class','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','wp_wc_product_meta_lookup__virtual','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','wp_wc_product_meta_lookup__downloadable','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','wp_wc_product_meta_lookup__stock_status','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','wp_wc_product_meta_lookup__stock_quantity','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','wp_wc_product_meta_lookup__onsale','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','wp_wc_product_meta_lookup__min_max_price','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_meta_lookup','wp_wc_product_meta_lookup__sku','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_tax_rate_classes','tax_rate_class_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_tax_rate_classes','name','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_tax_rate_classes','slug','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_tax_rate_classes','wp_wc_tax_rate_classes__slug','UNIQUE');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_reserved_stock','order_id','bigint(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_reserved_stock','product_id','bigint(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_reserved_stock','stock_quantity','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_reserved_stock','timestamp','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_reserved_stock','expires','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_rate_limits','rate_limit_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_rate_limits','rate_limit_key','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_rate_limits','rate_limit_expiry','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_rate_limits','rate_limit_remaining','smallint(10)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_rate_limits','wp_wc_rate_limits__rate_limit_key','UNIQUE');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_attributes_lookup','product_id','bigint(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_attributes_lookup','product_or_parent_id','bigint(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_attributes_lookup','taxonomy','varchar(32)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_attributes_lookup','term_id','bigint(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_attributes_lookup','is_variation_attribute','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_attributes_lookup','in_stock','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_attributes_lookup','wp_wc_product_attributes_lookup__is_variation_attribute_term_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_download_directories','url_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_download_directories','url','varchar(256)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_download_directories','enabled','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_product_download_directories','wp_wc_product_download_directories__url','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','order_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','parent_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','date_created','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','date_created_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','date_paid','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','date_completed','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','num_items_sold','int(11)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','total_sales','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','tax_total','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','shipping_total','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','net_total','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','returning_customer','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','status','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','customer_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','wp_wc_order_stats__date_created','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','wp_wc_order_stats__customer_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_stats','wp_wc_order_stats__status','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','order_item_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','order_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','product_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','variation_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','customer_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','date_created','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','product_qty','int(11)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','product_net_revenue','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','product_gross_revenue','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','coupon_amount','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','tax_amount','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','shipping_amount','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','shipping_tax_amount','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','wp_wc_order_product_lookup__order_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','wp_wc_order_product_lookup__product_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','wp_wc_order_product_lookup__customer_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','wp_wc_order_product_lookup__date_created','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_product_lookup','wp_wc_order_product_lookup__customer_product_date','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_tax_lookup','order_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_tax_lookup','tax_rate_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_tax_lookup','date_created','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_tax_lookup','shipping_tax','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_tax_lookup','order_tax','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_tax_lookup','total_tax','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_tax_lookup','wp_wc_order_tax_lookup__tax_rate_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_tax_lookup','wp_wc_order_tax_lookup__date_created','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_coupon_lookup','order_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_coupon_lookup','coupon_id','bigint(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_coupon_lookup','date_created','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_coupon_lookup','discount_amount','double');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_coupon_lookup','wp_wc_order_coupon_lookup__coupon_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_coupon_lookup','wp_wc_order_coupon_lookup__date_created','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','note_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','name','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','type','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','locale','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','title','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','content','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','content_data','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','status','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','source','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','date_created','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','date_reminder','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','is_snoozable','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','layout','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','image','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','is_deleted','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','is_read','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_notes','icon','varchar(200)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_note_actions','action_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_note_actions','note_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_note_actions','name','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_note_actions','label','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_note_actions','query','longtext');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_note_actions','status','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_note_actions','actioned_text','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_note_actions','nonce_action','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_note_actions','nonce_name','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_admin_note_actions','wp_wc_admin_note_actions__note_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','customer_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','user_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','username','varchar(60)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','first_name','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','last_name','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','email','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','date_last_active','timestamp');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','date_registered','timestamp');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','country','char(2)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','postcode','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','city','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','state','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','wp_wc_customer_lookup__user_id','UNIQUE');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_customer_lookup','wp_wc_customer_lookup__email','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_category_lookup','category_tree_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_category_lookup','category_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','status','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','currency','varchar(10)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','type','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','tax_amount','decimal(26,8)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','total_amount','decimal(26,8)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','customer_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','billing_email','varchar(320)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','date_created_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','date_updated_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','parent_order_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','payment_method','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','payment_method_title','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','transaction_id','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','ip_address','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','user_agent','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','customer_note','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','wp_wc_orders__status','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','wp_wc_orders__date_created','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','wp_wc_orders__customer_id_billing_email','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','wp_wc_orders__billing_email','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','wp_wc_orders__type_status_date','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','wp_wc_orders__parent_order_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders','wp_wc_orders__date_updated','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','order_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','address_type','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','first_name','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','last_name','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','company','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','address_1','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','address_2','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','city','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','state','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','postcode','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','country','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','email','varchar(320)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','phone','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','wp_wc_order_addresses__order_id','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','wp_wc_order_addresses__address_type_order_id','UNIQUE');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','wp_wc_order_addresses__email','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_addresses','wp_wc_order_addresses__phone','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','order_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','created_via','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','woocommerce_version','varchar(20)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','prices_include_tax','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','coupon_usages_are_counted','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','download_permission_granted','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','cart_hash','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','new_order_email_sent','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','order_key','varchar(100)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','order_stock_reduced','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','date_paid_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','date_completed_gmt','datetime');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','shipping_tax_amount','decimal(26,8)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','shipping_total_amount','decimal(26,8)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','discount_tax_amount','decimal(26,8)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','discount_total_amount','decimal(26,8)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','recorded_sales','tinyint(1)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','wp_wc_order_operational_data__order_id','UNIQUE');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_order_operational_data','wp_wc_order_operational_data__order_key','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders_meta','id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders_meta','order_id','bigint(20) unsigned');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders_meta','meta_key','varchar(255)');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders_meta','meta_value','text');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders_meta','wp_wc_orders_meta__meta_key_value','KEY');
INSERT INTO _mysql_data_types_cache VALUES('wp_wc_orders_meta','wp_wc_orders_meta__order_id_meta_key_meta_value','KEY');
CREATE TABLE `wp_users` (
`ID` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`user_login` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`user_pass` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`user_nicename` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`user_email` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`user_url` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`user_registered` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`user_activation_key` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`user_status` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`display_name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE);
INSERT INTO wp_users VALUES(1,'admin','$wp$2y$12$AgzE3oRBPI67Tj5IMZ3BwO8Rxk4CCDxsqr8iUeL6GEfDnT2RitZGS','admin','admin@example.com','http://localhost:8080/wp','2026-05-27 18:06:30','',0,'admin');
CREATE TABLE `wp_usermeta` (
`umeta_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`user_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`meta_key` text DEFAULT NULL COLLATE NOCASE,
`meta_value` text COLLATE NOCASE);
INSERT INTO wp_usermeta VALUES(1,1,'nickname','admin');
INSERT INTO wp_usermeta VALUES(2,1,'first_name','');
INSERT INTO wp_usermeta VALUES(3,1,'last_name','');
INSERT INTO wp_usermeta VALUES(4,1,'description','');
INSERT INTO wp_usermeta VALUES(5,1,'rich_editing','true');
INSERT INTO wp_usermeta VALUES(6,1,'syntax_highlighting','true');
INSERT INTO wp_usermeta VALUES(7,1,'comment_shortcuts','false');
INSERT INTO wp_usermeta VALUES(8,1,'admin_color','fresh');
INSERT INTO wp_usermeta VALUES(9,1,'use_ssl','0');
INSERT INTO wp_usermeta VALUES(10,1,'show_admin_bar_front','true');
INSERT INTO wp_usermeta VALUES(11,1,'locale','');
INSERT INTO wp_usermeta VALUES(12,1,'wp_capabilities','a:1:{s:13:"administrator";b:1;}');
INSERT INTO wp_usermeta VALUES(13,1,'wp_user_level','10');
INSERT INTO wp_usermeta VALUES(14,1,'dismissed_wp_pointers','');
INSERT INTO wp_usermeta VALUES(15,1,'show_welcome_panel','1');
CREATE TABLE `wp_termmeta` (
`meta_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`term_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`meta_key` text DEFAULT NULL COLLATE NOCASE,
`meta_value` text COLLATE NOCASE);
CREATE TABLE `wp_terms` (
`term_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`slug` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`term_group` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0);
INSERT INTO wp_terms VALUES(1,'Uncategorized','uncategorized',0);
INSERT INTO wp_terms VALUES(2,'simple','simple',0);
INSERT INTO wp_terms VALUES(3,'grouped','grouped',0);
INSERT INTO wp_terms VALUES(4,'variable','variable',0);
INSERT INTO wp_terms VALUES(5,'external','external',0);
INSERT INTO wp_terms VALUES(6,'exclude-from-search','exclude-from-search',0);
INSERT INTO wp_terms VALUES(7,'exclude-from-catalog','exclude-from-catalog',0);
INSERT INTO wp_terms VALUES(8,'featured','featured',0);
INSERT INTO wp_terms VALUES(9,'outofstock','outofstock',0);
INSERT INTO wp_terms VALUES(10,'rated-1','rated-1',0);
INSERT INTO wp_terms VALUES(11,'rated-2','rated-2',0);
INSERT INTO wp_terms VALUES(12,'rated-3','rated-3',0);
INSERT INTO wp_terms VALUES(13,'rated-4','rated-4',0);
INSERT INTO wp_terms VALUES(14,'rated-5','rated-5',0);
INSERT INTO wp_terms VALUES(15,'Uncategorized','uncategorized',0);
CREATE TABLE `wp_term_taxonomy` (
`term_taxonomy_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`term_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`taxonomy` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`description` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`parent` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`count` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0);
INSERT INTO wp_term_taxonomy VALUES(1,1,'category','',0,1);
INSERT INTO wp_term_taxonomy VALUES(2,2,'product_type','',0,0);
INSERT INTO wp_term_taxonomy VALUES(3,3,'product_type','',0,0);
INSERT INTO wp_term_taxonomy VALUES(4,4,'product_type','',0,0);
INSERT INTO wp_term_taxonomy VALUES(5,5,'product_type','',0,0);
INSERT INTO wp_term_taxonomy VALUES(6,6,'product_visibility','',0,0);
INSERT INTO wp_term_taxonomy VALUES(7,7,'product_visibility','',0,0);
INSERT INTO wp_term_taxonomy VALUES(8,8,'product_visibility','',0,0);
INSERT INTO wp_term_taxonomy VALUES(9,9,'product_visibility','',0,0);
INSERT INTO wp_term_taxonomy VALUES(10,10,'product_visibility','',0,0);
INSERT INTO wp_term_taxonomy VALUES(11,11,'product_visibility','',0,0);
INSERT INTO wp_term_taxonomy VALUES(12,12,'product_visibility','',0,0);
INSERT INTO wp_term_taxonomy VALUES(13,13,'product_visibility','',0,0);
INSERT INTO wp_term_taxonomy VALUES(14,14,'product_visibility','',0,0);
INSERT INTO wp_term_taxonomy VALUES(15,15,'product_cat','',0,0);
CREATE TABLE `wp_term_relationships` (
`object_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`term_taxonomy_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`term_order` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
PRIMARY KEY (`object_id`, `term_taxonomy_id`));
INSERT INTO wp_term_relationships VALUES(1,1,0);
CREATE TABLE `wp_commentmeta` (
`meta_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`comment_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`meta_key` text DEFAULT NULL COLLATE NOCASE,
`meta_value` text COLLATE NOCASE);
CREATE TABLE `wp_comments` (
`comment_ID` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`comment_post_ID` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`comment_author` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`comment_author_email` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`comment_author_url` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`comment_author_IP` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`comment_date` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`comment_date_gmt` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`comment_content` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`comment_karma` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`comment_approved` text NOT NULL ON CONFLICT REPLACE DEFAULT '1' COLLATE NOCASE,
`comment_agent` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`comment_type` text NOT NULL ON CONFLICT REPLACE DEFAULT 'comment' COLLATE NOCASE,
`comment_parent` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`user_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0');
INSERT INTO wp_comments VALUES(1,1,'A WordPress Commenter','wapuu@wordpress.example','https://wordpress.org/','','2026-05-27 18:06:30','2026-05-27 18:06:30',unistr('Hi, this is a comment.\u000aTo get started with moderating, editing, and deleting comments, please visit the Comments screen in the dashboard.\u000aCommenter avatars come from <a href="https://gravatar.com/">Gravatar</a>.'),0,'1','','comment',0,0);
CREATE TABLE `wp_links` (
`link_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`link_url` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`link_name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`link_image` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`link_target` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`link_description` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`link_visible` text NOT NULL ON CONFLICT REPLACE DEFAULT 'Y' COLLATE NOCASE,
`link_owner` integer NOT NULL ON CONFLICT REPLACE DEFAULT '1',
`link_rating` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`link_updated` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`link_rel` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`link_notes` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`link_rss` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE);
CREATE TABLE `wp_options` (
`option_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`option_name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`option_value` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`autoload` text NOT NULL ON CONFLICT REPLACE DEFAULT 'yes' COLLATE NOCASE);
INSERT INTO wp_options VALUES(1,'siteurl','http://localhost:8080/wp','on');
INSERT INTO wp_options VALUES(2,'home','http://localhost:8080/wp','on');
INSERT INTO wp_options VALUES(3,'blogname','Test','on');
INSERT INTO wp_options VALUES(4,'blogdescription','','on');
INSERT INTO wp_options VALUES(5,'users_can_register','0','on');
INSERT INTO wp_options VALUES(6,'admin_email','admin@example.com','on');
INSERT INTO wp_options VALUES(7,'start_of_week','1','on');
INSERT INTO wp_options VALUES(8,'use_balanceTags','0','on');
INSERT INTO wp_options VALUES(9,'use_smilies','1','on');
INSERT INTO wp_options VALUES(10,'require_name_email','1','on');
INSERT INTO wp_options VALUES(11,'comments_notify','1','on');
INSERT INTO wp_options VALUES(12,'posts_per_rss','10','on');
INSERT INTO wp_options VALUES(13,'rss_use_excerpt','0','on');
INSERT INTO wp_options VALUES(14,'mailserver_url','mail.example.com','on');
INSERT INTO wp_options VALUES(15,'mailserver_login','login@example.com','on');
INSERT INTO wp_options VALUES(16,'mailserver_pass','','on');
INSERT INTO wp_options VALUES(17,'mailserver_port','110','on');
INSERT INTO wp_options VALUES(18,'default_category','1','on');
INSERT INTO wp_options VALUES(19,'default_comment_status','open','on');
INSERT INTO wp_options VALUES(20,'default_ping_status','open','on');
INSERT INTO wp_options VALUES(21,'default_pingback_flag','1','on');
INSERT INTO wp_options VALUES(22,'posts_per_page','10','on');
INSERT INTO wp_options VALUES(23,'date_format','F j, Y','on');
INSERT INTO wp_options VALUES(24,'time_format','g:i a','on');
INSERT INTO wp_options VALUES(25,'links_updated_date_format','F j, Y g:i a','on');
INSERT INTO wp_options VALUES(26,'comment_moderation','0','on');
INSERT INTO wp_options VALUES(27,'moderation_notify','1','on');
INSERT INTO wp_options VALUES(28,'permalink_structure','','on');
INSERT INTO wp_options VALUES(29,'rewrite_rules','','on');
INSERT INTO wp_options VALUES(30,'hack_file','0','on');
INSERT INTO wp_options VALUES(31,'blog_charset','UTF-8','on');
INSERT INTO wp_options VALUES(32,'moderation_keys','','off');
INSERT INTO wp_options VALUES(33,'active_plugins','a:2:{i:0;s:36:"sqlite-database-integration/load.php";i:1;s:27:"woocommerce/woocommerce.php";}','on');
INSERT INTO wp_options VALUES(34,'category_base','','on');
INSERT INTO wp_options VALUES(35,'ping_sites','https://rpc.pingomatic.com/','on');
INSERT INTO wp_options VALUES(36,'comment_max_links','2','on');
INSERT INTO wp_options VALUES(37,'gmt_offset','0','on');
INSERT INTO wp_options VALUES(38,'default_email_category','1','on');
INSERT INTO wp_options VALUES(39,'recently_edited','','off');
INSERT INTO wp_options VALUES(40,'template','storefront','on');
INSERT INTO wp_options VALUES(41,'stylesheet','storefront','on');
INSERT INTO wp_options VALUES(42,'comment_registration','0','on');
INSERT INTO wp_options VALUES(43,'html_type','text/html','on');
INSERT INTO wp_options VALUES(44,'use_trackback','0','on');
INSERT INTO wp_options VALUES(45,'default_role','subscriber','on');
INSERT INTO wp_options VALUES(46,'db_version','60717','on');
INSERT INTO wp_options VALUES(47,'uploads_use_yearmonth_folders','1','on');
INSERT INTO wp_options VALUES(48,'upload_path','','on');
INSERT INTO wp_options VALUES(49,'blog_public','1','on');
INSERT INTO wp_options VALUES(50,'default_link_category','2','on');
INSERT INTO wp_options VALUES(51,'show_on_front','posts','on');
INSERT INTO wp_options VALUES(52,'tag_base','','on');
INSERT INTO wp_options VALUES(53,'show_avatars','1','on');
INSERT INTO wp_options VALUES(54,'avatar_rating','G','on');
INSERT INTO wp_options VALUES(55,'upload_url_path','','on');
INSERT INTO wp_options VALUES(56,'thumbnail_size_w','150','on');
INSERT INTO wp_options VALUES(57,'thumbnail_size_h','150','on');
INSERT INTO wp_options VALUES(58,'thumbnail_crop','1','on');
INSERT INTO wp_options VALUES(59,'medium_size_w','300','on');
INSERT INTO wp_options VALUES(60,'medium_size_h','300','on');
INSERT INTO wp_options VALUES(61,'avatar_default','mystery','on');
INSERT INTO wp_options VALUES(62,'large_size_w','1024','on');
INSERT INTO wp_options VALUES(63,'large_size_h','1024','on');
INSERT INTO wp_options VALUES(64,'image_default_link_type','none','on');
INSERT INTO wp_options VALUES(65,'image_default_size','','on');
INSERT INTO wp_options VALUES(66,'image_default_align','','on');
INSERT INTO wp_options VALUES(67,'close_comments_for_old_posts','0','on');
INSERT INTO wp_options VALUES(68,'close_comments_days_old','14','on');
INSERT INTO wp_options VALUES(69,'thread_comments','1','on');
INSERT INTO wp_options VALUES(70,'thread_comments_depth','5','on');
INSERT INTO wp_options VALUES(71,'page_comments','0','on');
INSERT INTO wp_options VALUES(72,'comments_per_page','50','on');
INSERT INTO wp_options VALUES(73,'default_comments_page','newest','on');
INSERT INTO wp_options VALUES(74,'comment_order','asc','on');
INSERT INTO wp_options VALUES(75,'sticky_posts','a:0:{}','on');
INSERT INTO wp_options VALUES(76,'widget_categories','a:0:{}','on');
INSERT INTO wp_options VALUES(77,'widget_text','a:0:{}','on');
INSERT INTO wp_options VALUES(78,'widget_rss','a:0:{}','on');
INSERT INTO wp_options VALUES(79,'uninstall_plugins','a:0:{}','off');
INSERT INTO wp_options VALUES(80,'timezone_string','','on');
INSERT INTO wp_options VALUES(81,'page_for_posts','0','on');
INSERT INTO wp_options VALUES(82,'page_on_front','0','on');
INSERT INTO wp_options VALUES(83,'default_post_format','0','on');
INSERT INTO wp_options VALUES(84,'link_manager_enabled','0','on');
INSERT INTO wp_options VALUES(85,'finished_splitting_shared_terms','1','on');
INSERT INTO wp_options VALUES(86,'site_icon','0','on');
INSERT INTO wp_options VALUES(87,'medium_large_size_w','768','on');
INSERT INTO wp_options VALUES(88,'medium_large_size_h','0','on');
INSERT INTO wp_options VALUES(89,'wp_page_for_privacy_policy','3','on');
INSERT INTO wp_options VALUES(90,'show_comments_cookies_opt_in','1','on');
INSERT INTO wp_options VALUES(92,'disallowed_keys','','off');
INSERT INTO wp_options VALUES(93,'comment_previously_approved','1','on');
INSERT INTO wp_options VALUES(94,'auto_plugin_theme_update_emails','a:0:{}','off');
INSERT INTO wp_options VALUES(95,'auto_update_core_dev','enabled','on');
INSERT INTO wp_options VALUES(96,'auto_update_core_minor','enabled','on');
INSERT INTO wp_options VALUES(97,'auto_update_core_major','enabled','on');
INSERT INTO wp_options VALUES(98,'wp_force_deactivated_plugins','a:0:{}','on');
INSERT INTO wp_options VALUES(99,'wp_attachment_pages_enabled','0','on');
INSERT INTO wp_options VALUES(100,'wp_notes_notify','1','on');
INSERT INTO wp_options VALUES(101,'initial_db_version','60717','on');
INSERT INTO wp_options VALUES(102,'wp_user_roles','a:7:{s:13:"administrator";a:2:{s:4:"name";s:13:"Administrator";s:12:"capabilities";a:115:{s:13:"switch_themes";b:1;s:11:"edit_themes";b:1;s:16:"activate_plugins";b:1;s:12:"edit_plugins";b:1;s:10:"edit_users";b:1;s:10:"edit_files";b:1;s:14:"manage_options";b:1;s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:6:"import";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:8:"level_10";b:1;s:7:"level_9";b:1;s:7:"level_8";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;s:12:"delete_users";b:1;s:12:"create_users";b:1;s:17:"unfiltered_upload";b:1;s:14:"edit_dashboard";b:1;s:14:"update_plugins";b:1;s:14:"delete_plugins";b:1;s:15:"install_plugins";b:1;s:13:"update_themes";b:1;s:14:"install_themes";b:1;s:11:"update_core";b:1;s:10:"list_users";b:1;s:12:"remove_users";b:1;s:13:"promote_users";b:1;s:18:"edit_theme_options";b:1;s:13:"delete_themes";b:1;s:6:"export";b:1;s:18:"manage_woocommerce";b:1;s:16:"create_customers";b:1;s:24:"view_woocommerce_reports";b:1;s:12:"edit_product";b:1;s:12:"read_product";b:1;s:14:"delete_product";b:1;s:13:"edit_products";b:1;s:20:"edit_others_products";b:1;s:16:"publish_products";b:1;s:21:"read_private_products";b:1;s:15:"delete_products";b:1;s:23:"delete_private_products";b:1;s:25:"delete_published_products";b:1;s:22:"delete_others_products";b:1;s:21:"edit_private_products";b:1;s:23:"edit_published_products";b:1;s:20:"manage_product_terms";b:1;s:18:"edit_product_terms";b:1;s:20:"delete_product_terms";b:1;s:20:"assign_product_terms";b:1;s:15:"edit_shop_order";b:1;s:15:"read_shop_order";b:1;s:17:"delete_shop_order";b:1;s:16:"edit_shop_orders";b:1;s:23:"edit_others_shop_orders";b:1;s:19:"publish_shop_orders";b:1;s:24:"read_private_shop_orders";b:1;s:18:"delete_shop_orders";b:1;s:26:"delete_private_shop_orders";b:1;s:28:"delete_published_shop_orders";b:1;s:25:"delete_others_shop_orders";b:1;s:24:"edit_private_shop_orders";b:1;s:26:"edit_published_shop_orders";b:1;s:23:"manage_shop_order_terms";b:1;s:21:"edit_shop_order_terms";b:1;s:23:"delete_shop_order_terms";b:1;s:23:"assign_shop_order_terms";b:1;s:16:"edit_shop_coupon";b:1;s:16:"read_shop_coupon";b:1;s:18:"delete_shop_coupon";b:1;s:17:"edit_shop_coupons";b:1;s:24:"edit_others_shop_coupons";b:1;s:20:"publish_shop_coupons";b:1;s:25:"read_private_shop_coupons";b:1;s:19:"delete_shop_coupons";b:1;s:27:"delete_private_shop_coupons";b:1;s:29:"delete_published_shop_coupons";b:1;s:26:"delete_others_shop_coupons";b:1;s:25:"edit_private_shop_coupons";b:1;s:27:"edit_published_shop_coupons";b:1;s:24:"manage_shop_coupon_terms";b:1;s:22:"edit_shop_coupon_terms";b:1;s:24:"delete_shop_coupon_terms";b:1;s:24:"assign_shop_coupon_terms";b:1;}}s:6:"editor";a:2:{s:4:"name";s:6:"Editor";s:12:"capabilities";a:34:{s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;}}s:6:"author";a:2:{s:4:"name";s:6:"Author";s:12:"capabilities";a:10:{s:12:"upload_files";b:1;s:10:"edit_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:4:"read";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;s:22:"delete_published_posts";b:1;}}s:11:"contributor";a:2:{s:4:"name";s:11:"Contributor";s:12:"capabilities";a:5:{s:10:"edit_posts";b:1;s:4:"read";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;}}s:10:"subscriber";a:2:{s:4:"name";s:10:"Subscriber";s:12:"capabilities";a:2:{s:4:"read";b:1;s:7:"level_0";b:1;}}s:8:"customer";a:2:{s:4:"name";s:8:"Customer";s:12:"capabilities";a:1:{s:4:"read";b:1;}}s:12:"shop_manager";a:2:{s:4:"name";s:12:"Shop manager";s:12:"capabilities";a:93:{s:7:"level_9";b:1;s:7:"level_8";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:4:"read";b:1;s:18:"read_private_pages";b:1;s:18:"read_private_posts";b:1;s:10:"edit_posts";b:1;s:10:"edit_pages";b:1;s:20:"edit_published_posts";b:1;s:20:"edit_published_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"edit_private_posts";b:1;s:17:"edit_others_posts";b:1;s:17:"edit_others_pages";b:1;s:13:"publish_posts";b:1;s:13:"publish_pages";b:1;s:12:"delete_posts";b:1;s:12:"delete_pages";b:1;s:20:"delete_private_pages";b:1;s:20:"delete_private_posts";b:1;s:22:"delete_published_pages";b:1;s:22:"delete_published_posts";b:1;s:19:"delete_others_posts";b:1;s:19:"delete_others_pages";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:17:"moderate_comments";b:1;s:12:"upload_files";b:1;s:6:"export";b:1;s:6:"import";b:1;s:10:"list_users";b:1;s:18:"edit_theme_options";b:1;s:18:"manage_woocommerce";b:1;s:16:"create_customers";b:1;s:24:"view_woocommerce_reports";b:1;s:12:"edit_product";b:1;s:12:"read_product";b:1;s:14:"delete_product";b:1;s:13:"edit_products";b:1;s:20:"edit_others_products";b:1;s:16:"publish_products";b:1;s:21:"read_private_products";b:1;s:15:"delete_products";b:1;s:23:"delete_private_products";b:1;s:25:"delete_published_products";b:1;s:22:"delete_others_products";b:1;s:21:"edit_private_products";b:1;s:23:"edit_published_products";b:1;s:20:"manage_product_terms";b:1;s:18:"edit_product_terms";b:1;s:20:"delete_product_terms";b:1;s:20:"assign_product_terms";b:1;s:15:"edit_shop_order";b:1;s:15:"read_shop_order";b:1;s:17:"delete_shop_order";b:1;s:16:"edit_shop_orders";b:1;s:23:"edit_others_shop_orders";b:1;s:19:"publish_shop_orders";b:1;s:24:"read_private_shop_orders";b:1;s:18:"delete_shop_orders";b:1;s:26:"delete_private_shop_orders";b:1;s:28:"delete_published_shop_orders";b:1;s:25:"delete_others_shop_orders";b:1;s:24:"edit_private_shop_orders";b:1;s:26:"edit_published_shop_orders";b:1;s:23:"manage_shop_order_terms";b:1;s:21:"edit_shop_order_terms";b:1;s:23:"delete_shop_order_terms";b:1;s:23:"assign_shop_order_terms";b:1;s:16:"edit_shop_coupon";b:1;s:16:"read_shop_coupon";b:1;s:18:"delete_shop_coupon";b:1;s:17:"edit_shop_coupons";b:1;s:24:"edit_others_shop_coupons";b:1;s:20:"publish_shop_coupons";b:1;s:25:"read_private_shop_coupons";b:1;s:19:"delete_shop_coupons";b:1;s:27:"delete_private_shop_coupons";b:1;s:29:"delete_published_shop_coupons";b:1;s:26:"delete_others_shop_coupons";b:1;s:25:"edit_private_shop_coupons";b:1;s:27:"edit_published_shop_coupons";b:1;s:24:"manage_shop_coupon_terms";b:1;s:22:"edit_shop_coupon_terms";b:1;s:24:"delete_shop_coupon_terms";b:1;s:24:"assign_shop_coupon_terms";b:1;}}}','on');
INSERT INTO wp_options VALUES(103,'fresh_site','1','auto');
INSERT INTO wp_options VALUES(104,'user_count','1','off');
INSERT INTO wp_options VALUES(105,'widget_block','a:6:{i:2;a:1:{s:7:"content";s:19:"<!-- wp:search /-->";}i:3;a:1:{s:7:"content";s:154:"<!-- wp:group --><div class="wp-block-group"><!-- wp:heading --><h2>Recent Posts</h2><!-- /wp:heading --><!-- wp:latest-posts /--></div><!-- /wp:group -->";}i:4;a:1:{s:7:"content";s:227:"<!-- wp:group --><div class="wp-block-group"><!-- wp:heading --><h2>Recent Comments</h2><!-- /wp:heading --><!-- wp:latest-comments {"displayAvatar":false,"displayDate":false,"displayExcerpt":false} /--></div><!-- /wp:group -->";}i:5;a:1:{s:7:"content";s:146:"<!-- wp:group --><div class="wp-block-group"><!-- wp:heading --><h2>Archives</h2><!-- /wp:heading --><!-- wp:archives /--></div><!-- /wp:group -->";}i:6;a:1:{s:7:"content";s:150:"<!-- wp:group --><div class="wp-block-group"><!-- wp:heading --><h2>Categories</h2><!-- /wp:heading --><!-- wp:categories /--></div><!-- /wp:group -->";}s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(106,'sidebars_widgets','a:8:{s:19:"wp_inactive_widgets";a:0:{}s:9:"sidebar-1";a:5:{i:0;s:7:"block-2";i:1;s:7:"block-3";i:2;s:7:"block-4";i:3;s:7:"block-5";i:4;s:7:"block-6";}s:8:"header-1";a:0:{}s:8:"footer-1";a:0:{}s:8:"footer-2";a:0:{}s:8:"footer-3";a:0:{}s:8:"footer-4";a:0:{}s:13:"array_version";i:3;}','auto');
INSERT INTO wp_options VALUES(107,'widget_pages','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(108,'widget_calendar','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(109,'widget_archives','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(110,'widget_media_audio','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(111,'widget_media_image','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(112,'widget_media_gallery','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(113,'widget_media_video','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(114,'widget_meta','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(115,'widget_search','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(116,'widget_recent-posts','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(117,'widget_recent-comments','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(118,'widget_tag_cloud','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(119,'widget_nav_menu','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(120,'widget_custom_html','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(121,'cron','a:11:{i:1779905203;a:6:{s:32:"recovery_mode_clean_expired_keys";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:34:"wp_privacy_delete_old_export_files";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:6:"hourly";s:4:"args";a:0:{}s:8:"interval";i:3600;}}s:16:"wp_version_check";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:17:"wp_update_plugins";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:16:"wp_update_themes";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:26:"action_scheduler_run_queue";a:1:{s:32:"0d04ed39571b55704c122d726248bbac";a:3:{s:8:"schedule";s:12:"every_minute";s:4:"args";a:1:{i:0;s:7:"WP Cron";}s:8:"interval";i:60;}}}i:1779905204;a:4:{s:14:"wc_admin_daily";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:20:"jetpack_clean_nonces";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:6:"hourly";s:4:"args";a:0:{}s:8:"interval";i:3600;}}s:20:"jetpack_v2_heartbeat";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:33:"wc_admin_process_orders_milestone";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:6:"hourly";s:4:"args";a:0:{}s:8:"interval";i:3600;}}}i:1779905205;a:1:{s:30:"wp_1_wc_regenerate_images_cron";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:39:"wp_1_wc_regenerate_images_cron_interval";s:4:"args";a:0:{}s:8:"interval";i:300;}}}i:1779905214;a:3:{s:33:"woocommerce_cleanup_personal_data";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:30:"woocommerce_tracker_send_event";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:30:"generate_category_lookup_table";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:2:{s:8:"schedule";b:0;s:4:"args";a:0:{}}}}i:1779905264;a:1:{s:25:"woocommerce_geoip_updater";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:11:"fifteendays";s:4:"args";a:0:{}s:8:"interval";i:1296000;}}}i:1779908804;a:1:{s:32:"woocommerce_cancel_unpaid_orders";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:2:{s:8:"schedule";b:0;s:4:"args";a:0:{}}}}i:1779916004;a:2:{s:24:"woocommerce_cleanup_logs";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:31:"woocommerce_cleanup_rate_limits";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1779926400;a:1:{s:27:"woocommerce_scheduled_sales";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1779926804;a:1:{s:28:"woocommerce_cleanup_sessions";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}}i:1779991603;a:1:{s:30:"wp_site_health_scheduled_check";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:6:"weekly";s:4:"args";a:0:{}s:8:"interval";i:604800;}}}s:7:"version";i:2;}','on');
INSERT INTO wp_options VALUES(122,'_transient_wp_core_block_css_files','a:2:{s:7:"version";s:5:"6.9.4";s:5:"files";a:584:{i:0;s:31:"accordion-heading/style-rtl.css";i:1;s:35:"accordion-heading/style-rtl.min.css";i:2;s:27:"accordion-heading/style.css";i:3;s:31:"accordion-heading/style.min.css";i:4;s:28:"accordion-item/style-rtl.css";i:5;s:32:"accordion-item/style-rtl.min.css";i:6;s:24:"accordion-item/style.css";i:7;s:28:"accordion-item/style.min.css";i:8;s:29:"accordion-panel/style-rtl.css";i:9;s:33:"accordion-panel/style-rtl.min.css";i:10;s:25:"accordion-panel/style.css";i:11;s:29:"accordion-panel/style.min.css";i:12;s:23:"accordion/style-rtl.css";i:13;s:27:"accordion/style-rtl.min.css";i:14;s:19:"accordion/style.css";i:15;s:23:"accordion/style.min.css";i:16;s:23:"archives/editor-rtl.css";i:17;s:27:"archives/editor-rtl.min.css";i:18;s:19:"archives/editor.css";i:19;s:23:"archives/editor.min.css";i:20;s:22:"archives/style-rtl.css";i:21;s:26:"archives/style-rtl.min.css";i:22;s:18:"archives/style.css";i:23;s:22:"archives/style.min.css";i:24;s:20:"audio/editor-rtl.css";i:25;s:24:"audio/editor-rtl.min.css";i:26;s:16:"audio/editor.css";i:27;s:20:"audio/editor.min.css";i:28;s:19:"audio/style-rtl.css";i:29;s:23:"audio/style-rtl.min.css";i:30;s:15:"audio/style.css";i:31;s:19:"audio/style.min.css";i:32;s:19:"audio/theme-rtl.css";i:33;s:23:"audio/theme-rtl.min.css";i:34;s:15:"audio/theme.css";i:35;s:19:"audio/theme.min.css";i:36;s:21:"avatar/editor-rtl.css";i:37;s:25:"avatar/editor-rtl.min.css";i:38;s:17:"avatar/editor.css";i:39;s:21:"avatar/editor.min.css";i:40;s:20:"avatar/style-rtl.css";i:41;s:24:"avatar/style-rtl.min.css";i:42;s:16:"avatar/style.css";i:43;s:20:"avatar/style.min.css";i:44;s:21:"button/editor-rtl.css";i:45;s:25:"button/editor-rtl.min.css";i:46;s:17:"button/editor.css";i:47;s:21:"button/editor.min.css";i:48;s:20:"button/style-rtl.css";i:49;s:24:"button/style-rtl.min.css";i:50;s:16:"button/style.css";i:51;s:20:"button/style.min.css";i:52;s:22:"buttons/editor-rtl.css";i:53;s:26:"buttons/editor-rtl.min.css";i:54;s:18:"buttons/editor.css";i:55;s:22:"buttons/editor.min.css";i:56;s:21:"buttons/style-rtl.css";i:57;s:25:"buttons/style-rtl.min.css";i:58;s:17:"buttons/style.css";i:59;s:21:"buttons/style.min.css";i:60;s:22:"calendar/style-rtl.css";i:61;s:26:"calendar/style-rtl.min.css";i:62;s:18:"calendar/style.css";i:63;s:22:"calendar/style.min.css";i:64;s:25:"categories/editor-rtl.css";i:65;s:29:"categories/editor-rtl.min.css";i:66;s:21:"categories/editor.css";i:67;s:25:"categories/editor.min.css";i:68;s:24:"categories/style-rtl.css";i:69;s:28:"categories/style-rtl.min.css";i:70;s:20:"categories/style.css";i:71;s:24:"categories/style.min.css";i:72;s:19:"code/editor-rtl.css";i:73;s:23:"code/editor-rtl.min.css";i:74;s:15:"code/editor.css";i:75;s:19:"code/editor.min.css";i:76;s:18:"code/style-rtl.css";i:77;s:22:"code/style-rtl.min.css";i:78;s:14:"code/style.css";i:79;s:18:"code/style.min.css";i:80;s:18:"code/theme-rtl.css";i:81;s:22:"code/theme-rtl.min.css";i:82;s:14:"code/theme.css";i:83;s:18:"code/theme.min.css";i:84;s:22:"columns/editor-rtl.css";i:85;s:26:"columns/editor-rtl.min.css";i:86;s:18:"columns/editor.css";i:87;s:22:"columns/editor.min.css";i:88;s:21:"columns/style-rtl.css";i:89;s:25:"columns/style-rtl.min.css";i:90;s:17:"columns/style.css";i:91;s:21:"columns/style.min.css";i:92;s:33:"comment-author-name/style-rtl.css";i:93;s:37:"comment-author-name/style-rtl.min.css";i:94;s:29:"comment-author-name/style.css";i:95;s:33:"comment-author-name/style.min.css";i:96;s:29:"comment-content/style-rtl.css";i:97;s:33:"comment-content/style-rtl.min.css";i:98;s:25:"comment-content/style.css";i:99;s:29:"comment-content/style.min.css";i:100;s:26:"comment-date/style-rtl.css";i:101;s:30:"comment-date/style-rtl.min.css";i:102;s:22:"comment-date/style.css";i:103;s:26:"comment-date/style.min.css";i:104;s:31:"comment-edit-link/style-rtl.css";i:105;s:35:"comment-edit-link/style-rtl.min.css";i:106;s:27:"comment-edit-link/style.css";i:107;s:31:"comment-edit-link/style.min.css";i:108;s:32:"comment-reply-link/style-rtl.css";i:109;s:36:"comment-reply-link/style-rtl.min.css";i:110;s:28:"comment-reply-link/style.css";i:111;s:32:"comment-reply-link/style.min.css";i:112;s:30:"comment-template/style-rtl.css";i:113;s:34:"comment-template/style-rtl.min.css";i:114;s:26:"comment-template/style.css";i:115;s:30:"comment-template/style.min.css";i:116;s:42:"comments-pagination-numbers/editor-rtl.css";i:117;s:46:"comments-pagination-numbers/editor-rtl.min.css";i:118;s:38:"comments-pagination-numbers/editor.css";i:119;s:42:"comments-pagination-numbers/editor.min.css";i:120;s:34:"comments-pagination/editor-rtl.css";i:121;s:38:"comments-pagination/editor-rtl.min.css";i:122;s:30:"comments-pagination/editor.css";i:123;s:34:"comments-pagination/editor.min.css";i:124;s:33:"comments-pagination/style-rtl.css";i:125;s:37:"comments-pagination/style-rtl.min.css";i:126;s:29:"comments-pagination/style.css";i:127;s:33:"comments-pagination/style.min.css";i:128;s:29:"comments-title/editor-rtl.css";i:129;s:33:"comments-title/editor-rtl.min.css";i:130;s:25:"comments-title/editor.css";i:131;s:29:"comments-title/editor.min.css";i:132;s:23:"comments/editor-rtl.css";i:133;s:27:"comments/editor-rtl.min.css";i:134;s:19:"comments/editor.css";i:135;s:23:"comments/editor.min.css";i:136;s:22:"comments/style-rtl.css";i:137;s:26:"comments/style-rtl.min.css";i:138;s:18:"comments/style.css";i:139;s:22:"comments/style.min.css";i:140;s:20:"cover/editor-rtl.css";i:141;s:24:"cover/editor-rtl.min.css";i:142;s:16:"cover/editor.css";i:143;s:20:"cover/editor.min.css";i:144;s:19:"cover/style-rtl.css";i:145;s:23:"cover/style-rtl.min.css";i:146;s:15:"cover/style.css";i:147;s:19:"cover/style.min.css";i:148;s:22:"details/editor-rtl.css";i:149;s:26:"details/editor-rtl.min.css";i:150;s:18:"details/editor.css";i:151;s:22:"details/editor.min.css";i:152;s:21:"details/style-rtl.css";i:153;s:25:"details/style-rtl.min.css";i:154;s:17:"details/style.css";i:155;s:21:"details/style.min.css";i:156;s:20:"embed/editor-rtl.css";i:157;s:24:"embed/editor-rtl.min.css";i:158;s:16:"embed/editor.css";i:159;s:20:"embed/editor.min.css";i:160;s:19:"embed/style-rtl.css";i:161;s:23:"embed/style-rtl.min.css";i:162;s:15:"embed/style.css";i:163;s:19:"embed/style.min.css";i:164;s:19:"embed/theme-rtl.css";i:165;s:23:"embed/theme-rtl.min.css";i:166;s:15:"embed/theme.css";i:167;s:19:"embed/theme.min.css";i:168;s:19:"file/editor-rtl.css";i:169;s:23:"file/editor-rtl.min.css";i:170;s:15:"file/editor.css";i:171;s:19:"file/editor.min.css";i:172;s:18:"file/style-rtl.css";i:173;s:22:"file/style-rtl.min.css";i:174;s:14:"file/style.css";i:175;s:18:"file/style.min.css";i:176;s:23:"footnotes/style-rtl.css";i:177;s:27:"footnotes/style-rtl.min.css";i:178;s:19:"footnotes/style.css";i:179;s:23:"footnotes/style.min.css";i:180;s:23:"freeform/editor-rtl.css";i:181;s:27:"freeform/editor-rtl.min.css";i:182;s:19:"freeform/editor.css";i:183;s:23:"freeform/editor.min.css";i:184;s:22:"gallery/editor-rtl.css";i:185;s:26:"gallery/editor-rtl.min.css";i:186;s:18:"gallery/editor.css";i:187;s:22:"gallery/editor.min.css";i:188;s:21:"gallery/style-rtl.css";i:189;s:25:"gallery/style-rtl.min.css";i:190;s:17:"gallery/style.css";i:191;s:21:"gallery/style.min.css";i:192;s:21:"gallery/theme-rtl.css";i:193;s:25:"gallery/theme-rtl.min.css";i:194;s:17:"gallery/theme.css";i:195;s:21:"gallery/theme.min.css";i:196;s:20:"group/editor-rtl.css";i:197;s:24:"group/editor-rtl.min.css";i:198;s:16:"group/editor.css";i:199;s:20:"group/editor.min.css";i:200;s:19:"group/style-rtl.css";i:201;s:23:"group/style-rtl.min.css";i:202;s:15:"group/style.css";i:203;s:19:"group/style.min.css";i:204;s:19:"group/theme-rtl.css";i:205;s:23:"group/theme-rtl.min.css";i:206;s:15:"group/theme.css";i:207;s:19:"group/theme.min.css";i:208;s:21:"heading/style-rtl.css";i:209;s:25:"heading/style-rtl.min.css";i:210;s:17:"heading/style.css";i:211;s:21:"heading/style.min.css";i:212;s:19:"html/editor-rtl.css";i:213;s:23:"html/editor-rtl.min.css";i:214;s:15:"html/editor.css";i:215;s:19:"html/editor.min.css";i:216;s:20:"image/editor-rtl.css";i:217;s:24:"image/editor-rtl.min.css";i:218;s:16:"image/editor.css";i:219;s:20:"image/editor.min.css";i:220;s:19:"image/style-rtl.css";i:221;s:23:"image/style-rtl.min.css";i:222;s:15:"image/style.css";i:223;s:19:"image/style.min.css";i:224;s:19:"image/theme-rtl.css";i:225;s:23:"image/theme-rtl.min.css";i:226;s:15:"image/theme.css";i:227;s:19:"image/theme.min.css";i:228;s:29:"latest-comments/style-rtl.css";i:229;s:33:"latest-comments/style-rtl.min.css";i:230;s:25:"latest-comments/style.css";i:231;s:29:"latest-comments/style.min.css";i:232;s:27:"latest-posts/editor-rtl.css";i:233;s:31:"latest-posts/editor-rtl.min.css";i:234;s:23:"latest-posts/editor.css";i:235;s:27:"latest-posts/editor.min.css";i:236;s:26:"latest-posts/style-rtl.css";i:237;s:30:"latest-posts/style-rtl.min.css";i:238;s:22:"latest-posts/style.css";i:239;s:26:"latest-posts/style.min.css";i:240;s:18:"list/style-rtl.css";i:241;s:22:"list/style-rtl.min.css";i:242;s:14:"list/style.css";i:243;s:18:"list/style.min.css";i:244;s:22:"loginout/style-rtl.css";i:245;s:26:"loginout/style-rtl.min.css";i:246;s:18:"loginout/style.css";i:247;s:22:"loginout/style.min.css";i:248;s:19:"math/editor-rtl.css";i:249;s:23:"math/editor-rtl.min.css";i:250;s:15:"math/editor.css";i:251;s:19:"math/editor.min.css";i:252;s:18:"math/style-rtl.css";i:253;s:22:"math/style-rtl.min.css";i:254;s:14:"math/style.css";i:255;s:18:"math/style.min.css";i:256;s:25:"media-text/editor-rtl.css";i:257;s:29:"media-text/editor-rtl.min.css";i:258;s:21:"media-text/editor.css";i:259;s:25:"media-text/editor.min.css";i:260;s:24:"media-text/style-rtl.css";i:261;s:28:"media-text/style-rtl.min.css";i:262;s:20:"media-text/style.css";i:263;s:24:"media-text/style.min.css";i:264;s:19:"more/editor-rtl.css";i:265;s:23:"more/editor-rtl.min.css";i:266;s:15:"more/editor.css";i:267;s:19:"more/editor.min.css";i:268;s:30:"navigation-link/editor-rtl.css";i:269;s:34:"navigation-link/editor-rtl.min.css";i:270;s:26:"navigation-link/editor.css";i:271;s:30:"navigation-link/editor.min.css";i:272;s:29:"navigation-link/style-rtl.css";i:273;s:33:"navigation-link/style-rtl.min.css";i:274;s:25:"navigation-link/style.css";i:275;s:29:"navigation-link/style.min.css";i:276;s:33:"navigation-submenu/editor-rtl.css";i:277;s:37:"navigation-submenu/editor-rtl.min.css";i:278;s:29:"navigation-submenu/editor.css";i:279;s:33:"navigation-submenu/editor.min.css";i:280;s:25:"navigation/editor-rtl.css";i:281;s:29:"navigation/editor-rtl.min.css";i:282;s:21:"navigation/editor.css";i:283;s:25:"navigation/editor.min.css";i:284;s:24:"navigation/style-rtl.css";i:285;s:28:"navigation/style-rtl.min.css";i:286;s:20:"navigation/style.css";i:287;s:24:"navigation/style.min.css";i:288;s:23:"nextpage/editor-rtl.css";i:289;s:27:"nextpage/editor-rtl.min.css";i:290;s:19:"nextpage/editor.css";i:291;s:23:"nextpage/editor.min.css";i:292;s:24:"page-list/editor-rtl.css";i:293;s:28:"page-list/editor-rtl.min.css";i:294;s:20:"page-list/editor.css";i:295;s:24:"page-list/editor.min.css";i:296;s:23:"page-list/style-rtl.css";i:297;s:27:"page-list/style-rtl.min.css";i:298;s:19:"page-list/style.css";i:299;s:23:"page-list/style.min.css";i:300;s:24:"paragraph/editor-rtl.css";i:301;s:28:"paragraph/editor-rtl.min.css";i:302;s:20:"paragraph/editor.css";i:303;s:24:"paragraph/editor.min.css";i:304;s:23:"paragraph/style-rtl.css";i:305;s:27:"paragraph/style-rtl.min.css";i:306;s:19:"paragraph/style.css";i:307;s:23:"paragraph/style.min.css";i:308;s:35:"post-author-biography/style-rtl.css";i:309;s:39:"post-author-biography/style-rtl.min.css";i:310;s:31:"post-author-biography/style.css";i:311;s:35:"post-author-biography/style.min.css";i:312;s:30:"post-author-name/style-rtl.css";i:313;s:34:"post-author-name/style-rtl.min.css";i:314;s:26:"post-author-name/style.css";i:315;s:30:"post-author-name/style.min.css";i:316;s:25:"post-author/style-rtl.css";i:317;s:29:"post-author/style-rtl.min.css";i:318;s:21:"post-author/style.css";i:319;s:25:"post-author/style.min.css";i:320;s:33:"post-comments-count/style-rtl.css";i:321;s:37:"post-comments-count/style-rtl.min.css";i:322;s:29:"post-comments-count/style.css";i:323;s:33:"post-comments-count/style.min.css";i:324;s:33:"post-comments-form/editor-rtl.css";i:325;s:37:"post-comments-form/editor-rtl.min.css";i:326;s:29:"post-comments-form/editor.css";i:327;s:33:"post-comments-form/editor.min.css";i:328;s:32:"post-comments-form/style-rtl.css";i:329;s:36:"post-comments-form/style-rtl.min.css";i:330;s:28:"post-comments-form/style.css";i:331;s:32:"post-comments-form/style.min.css";i:332;s:32:"post-comments-link/style-rtl.css";i:333;s:36:"post-comments-link/style-rtl.min.css";i:334;s:28:"post-comments-link/style.css";i:335;s:32:"post-comments-link/style.min.css";i:336;s:26:"post-content/style-rtl.css";i:337;s:30:"post-content/style-rtl.min.css";i:338;s:22:"post-content/style.css";i:339;s:26:"post-content/style.min.css";i:340;s:23:"post-date/style-rtl.css";i:341;s:27:"post-date/style-rtl.min.css";i:342;s:19:"post-date/style.css";i:343;s:23:"post-date/style.min.css";i:344;s:27:"post-excerpt/editor-rtl.css";i:345;s:31:"post-excerpt/editor-rtl.min.css";i:346;s:23:"post-excerpt/editor.css";i:347;s:27:"post-excerpt/editor.min.css";i:348;s:26:"post-excerpt/style-rtl.css";i:349;s:30:"post-excerpt/style-rtl.min.css";i:350;s:22:"post-excerpt/style.css";i:351;s:26:"post-excerpt/style.min.css";i:352;s:34:"post-featured-image/editor-rtl.css";i:353;s:38:"post-featured-image/editor-rtl.min.css";i:354;s:30:"post-featured-image/editor.css";i:355;s:34:"post-featured-image/editor.min.css";i:356;s:33:"post-featured-image/style-rtl.css";i:357;s:37:"post-featured-image/style-rtl.min.css";i:358;s:29:"post-featured-image/style.css";i:359;s:33:"post-featured-image/style.min.css";i:360;s:34:"post-navigation-link/style-rtl.css";i:361;s:38:"post-navigation-link/style-rtl.min.css";i:362;s:30:"post-navigation-link/style.css";i:363;s:34:"post-navigation-link/style.min.css";i:364;s:27:"post-template/style-rtl.css";i:365;s:31:"post-template/style-rtl.min.css";i:366;s:23:"post-template/style.css";i:367;s:27:"post-template/style.min.css";i:368;s:24:"post-terms/style-rtl.css";i:369;s:28:"post-terms/style-rtl.min.css";i:370;s:20:"post-terms/style.css";i:371;s:24:"post-terms/style.min.css";i:372;s:31:"post-time-to-read/style-rtl.css";i:373;s:35:"post-time-to-read/style-rtl.min.css";i:374;s:27:"post-time-to-read/style.css";i:375;s:31:"post-time-to-read/style.min.css";i:376;s:24:"post-title/style-rtl.css";i:377;s:28:"post-title/style-rtl.min.css";i:378;s:20:"post-title/style.css";i:379;s:24:"post-title/style.min.css";i:380;s:26:"preformatted/style-rtl.css";i:381;s:30:"preformatted/style-rtl.min.css";i:382;s:22:"preformatted/style.css";i:383;s:26:"preformatted/style.min.css";i:384;s:24:"pullquote/editor-rtl.css";i:385;s:28:"pullquote/editor-rtl.min.css";i:386;s:20:"pullquote/editor.css";i:387;s:24:"pullquote/editor.min.css";i:388;s:23:"pullquote/style-rtl.css";i:389;s:27:"pullquote/style-rtl.min.css";i:390;s:19:"pullquote/style.css";i:391;s:23:"pullquote/style.min.css";i:392;s:23:"pullquote/theme-rtl.css";i:393;s:27:"pullquote/theme-rtl.min.css";i:394;s:19:"pullquote/theme.css";i:395;s:23:"pullquote/theme.min.css";i:396;s:39:"query-pagination-numbers/editor-rtl.css";i:397;s:43:"query-pagination-numbers/editor-rtl.min.css";i:398;s:35:"query-pagination-numbers/editor.css";i:399;s:39:"query-pagination-numbers/editor.min.css";i:400;s:31:"query-pagination/editor-rtl.css";i:401;s:35:"query-pagination/editor-rtl.min.css";i:402;s:27:"query-pagination/editor.css";i:403;s:31:"query-pagination/editor.min.css";i:404;s:30:"query-pagination/style-rtl.css";i:405;s:34:"query-pagination/style-rtl.min.css";i:406;s:26:"query-pagination/style.css";i:407;s:30:"query-pagination/style.min.css";i:408;s:25:"query-title/style-rtl.css";i:409;s:29:"query-title/style-rtl.min.css";i:410;s:21:"query-title/style.css";i:411;s:25:"query-title/style.min.css";i:412;s:25:"query-total/style-rtl.css";i:413;s:29:"query-total/style-rtl.min.css";i:414;s:21:"query-total/style.css";i:415;s:25:"query-total/style.min.css";i:416;s:20:"query/editor-rtl.css";i:417;s:24:"query/editor-rtl.min.css";i:418;s:16:"query/editor.css";i:419;s:20:"query/editor.min.css";i:420;s:19:"quote/style-rtl.css";i:421;s:23:"quote/style-rtl.min.css";i:422;s:15:"quote/style.css";i:423;s:19:"quote/style.min.css";i:424;s:19:"quote/theme-rtl.css";i:425;s:23:"quote/theme-rtl.min.css";i:426;s:15:"quote/theme.css";i:427;s:19:"quote/theme.min.css";i:428;s:23:"read-more/style-rtl.css";i:429;s:27:"read-more/style-rtl.min.css";i:430;s:19:"read-more/style.css";i:431;s:23:"read-more/style.min.css";i:432;s:18:"rss/editor-rtl.css";i:433;s:22:"rss/editor-rtl.min.css";i:434;s:14:"rss/editor.css";i:435;s:18:"rss/editor.min.css";i:436;s:17:"rss/style-rtl.css";i:437;s:21:"rss/style-rtl.min.css";i:438;s:13:"rss/style.css";i:439;s:17:"rss/style.min.css";i:440;s:21:"search/editor-rtl.css";i:441;s:25:"search/editor-rtl.min.css";i:442;s:17:"search/editor.css";i:443;s:21:"search/editor.min.css";i:444;s:20:"search/style-rtl.css";i:445;s:24:"search/style-rtl.min.css";i:446;s:16:"search/style.css";i:447;s:20:"search/style.min.css";i:448;s:20:"search/theme-rtl.css";i:449;s:24:"search/theme-rtl.min.css";i:450;s:16:"search/theme.css";i:451;s:20:"search/theme.min.css";i:452;s:24:"separator/editor-rtl.css";i:453;s:28:"separator/editor-rtl.min.css";i:454;s:20:"separator/editor.css";i:455;s:24:"separator/editor.min.css";i:456;s:23:"separator/style-rtl.css";i:457;s:27:"separator/style-rtl.min.css";i:458;s:19:"separator/style.css";i:459;s:23:"separator/style.min.css";i:460;s:23:"separator/theme-rtl.css";i:461;s:27:"separator/theme-rtl.min.css";i:462;s:19:"separator/theme.css";i:463;s:23:"separator/theme.min.css";i:464;s:24:"shortcode/editor-rtl.css";i:465;s:28:"shortcode/editor-rtl.min.css";i:466;s:20:"shortcode/editor.css";i:467;s:24:"shortcode/editor.min.css";i:468;s:24:"site-logo/editor-rtl.css";i:469;s:28:"site-logo/editor-rtl.min.css";i:470;s:20:"site-logo/editor.css";i:471;s:24:"site-logo/editor.min.css";i:472;s:23:"site-logo/style-rtl.css";i:473;s:27:"site-logo/style-rtl.min.css";i:474;s:19:"site-logo/style.css";i:475;s:23:"site-logo/style.min.css";i:476;s:27:"site-tagline/editor-rtl.css";i:477;s:31:"site-tagline/editor-rtl.min.css";i:478;s:23:"site-tagline/editor.css";i:479;s:27:"site-tagline/editor.min.css";i:480;s:26:"site-tagline/style-rtl.css";i:481;s:30:"site-tagline/style-rtl.min.css";i:482;s:22:"site-tagline/style.css";i:483;s:26:"site-tagline/style.min.css";i:484;s:25:"site-title/editor-rtl.css";i:485;s:29:"site-title/editor-rtl.min.css";i:486;s:21:"site-title/editor.css";i:487;s:25:"site-title/editor.min.css";i:488;s:24:"site-title/style-rtl.css";i:489;s:28:"site-title/style-rtl.min.css";i:490;s:20:"site-title/style.css";i:491;s:24:"site-title/style.min.css";i:492;s:26:"social-link/editor-rtl.css";i:493;s:30:"social-link/editor-rtl.min.css";i:494;s:22:"social-link/editor.css";i:495;s:26:"social-link/editor.min.css";i:496;s:27:"social-links/editor-rtl.css";i:497;s:31:"social-links/editor-rtl.min.css";i:498;s:23:"social-links/editor.css";i:499;s:27:"social-links/editor.min.css";i:500;s:26:"social-links/style-rtl.css";i:501;s:30:"social-links/style-rtl.min.css";i:502;s:22:"social-links/style.css";i:503;s:26:"social-links/style.min.css";i:504;s:21:"spacer/editor-rtl.css";i:505;s:25:"spacer/editor-rtl.min.css";i:506;s:17:"spacer/editor.css";i:507;s:21:"spacer/editor.min.css";i:508;s:20:"spacer/style-rtl.css";i:509;s:24:"spacer/style-rtl.min.css";i:510;s:16:"spacer/style.css";i:511;s:20:"spacer/style.min.css";i:512;s:20:"table/editor-rtl.css";i:513;s:24:"table/editor-rtl.min.css";i:514;s:16:"table/editor.css";i:515;s:20:"table/editor.min.css";i:516;s:19:"table/style-rtl.css";i:517;s:23:"table/style-rtl.min.css";i:518;s:15:"table/style.css";i:519;s:19:"table/style.min.css";i:520;s:19:"table/theme-rtl.css";i:521;s:23:"table/theme-rtl.min.css";i:522;s:15:"table/theme.css";i:523;s:19:"table/theme.min.css";i:524;s:24:"tag-cloud/editor-rtl.css";i:525;s:28:"tag-cloud/editor-rtl.min.css";i:526;s:20:"tag-cloud/editor.css";i:527;s:24:"tag-cloud/editor.min.css";i:528;s:23:"tag-cloud/style-rtl.css";i:529;s:27:"tag-cloud/style-rtl.min.css";i:530;s:19:"tag-cloud/style.css";i:531;s:23:"tag-cloud/style.min.css";i:532;s:28:"template-part/editor-rtl.css";i:533;s:32:"template-part/editor-rtl.min.css";i:534;s:24:"template-part/editor.css";i:535;s:28:"template-part/editor.min.css";i:536;s:27:"template-part/theme-rtl.css";i:537;s:31:"template-part/theme-rtl.min.css";i:538;s:23:"template-part/theme.css";i:539;s:27:"template-part/theme.min.css";i:540;s:24:"term-count/style-rtl.css";i:541;s:28:"term-count/style-rtl.min.css";i:542;s:20:"term-count/style.css";i:543;s:24:"term-count/style.min.css";i:544;s:30:"term-description/style-rtl.css";i:545;s:34:"term-description/style-rtl.min.css";i:546;s:26:"term-description/style.css";i:547;s:30:"term-description/style.min.css";i:548;s:23:"term-name/style-rtl.css";i:549;s:27:"term-name/style-rtl.min.css";i:550;s:19:"term-name/style.css";i:551;s:23:"term-name/style.min.css";i:552;s:28:"term-template/editor-rtl.css";i:553;s:32:"term-template/editor-rtl.min.css";i:554;s:24:"term-template/editor.css";i:555;s:28:"term-template/editor.min.css";i:556;s:27:"term-template/style-rtl.css";i:557;s:31:"term-template/style-rtl.min.css";i:558;s:23:"term-template/style.css";i:559;s:27:"term-template/style.min.css";i:560;s:27:"text-columns/editor-rtl.css";i:561;s:31:"text-columns/editor-rtl.min.css";i:562;s:23:"text-columns/editor.css";i:563;s:27:"text-columns/editor.min.css";i:564;s:26:"text-columns/style-rtl.css";i:565;s:30:"text-columns/style-rtl.min.css";i:566;s:22:"text-columns/style.css";i:567;s:26:"text-columns/style.min.css";i:568;s:19:"verse/style-rtl.css";i:569;s:23:"verse/style-rtl.min.css";i:570;s:15:"verse/style.css";i:571;s:19:"verse/style.min.css";i:572;s:20:"video/editor-rtl.css";i:573;s:24:"video/editor-rtl.min.css";i:574;s:16:"video/editor.css";i:575;s:20:"video/editor.min.css";i:576;s:19:"video/style-rtl.css";i:577;s:23:"video/style-rtl.min.css";i:578;s:15:"video/style.css";i:579;s:19:"video/style.min.css";i:580;s:19:"video/theme-rtl.css";i:581;s:23:"video/theme-rtl.min.css";i:582;s:15:"video/theme.css";i:583;s:19:"video/theme.min.css";}}','on');
INSERT INTO wp_options VALUES(125,'action_scheduler_hybrid_store_demarkation','4','auto');
INSERT INTO wp_options VALUES(126,'schema-ActionScheduler_StoreSchema','7.0.1779905203','auto');
INSERT INTO wp_options VALUES(127,'schema-ActionScheduler_LoggerSchema','3.0.1779905203','auto');
INSERT INTO wp_options VALUES(128,'_transient_timeout_as-post-store-dependencies-met','1779991603','off');
INSERT INTO wp_options VALUES(129,'_transient_as-post-store-dependencies-met','yes','off');
INSERT INTO wp_options VALUES(132,'woocommerce_newly_installed','yes','auto');
INSERT INTO wp_options VALUES(133,'woocommerce_schema_version','920','auto');
INSERT INTO wp_options VALUES(134,'woocommerce_store_address','','on');
INSERT INTO wp_options VALUES(135,'woocommerce_store_address_2','','on');
INSERT INTO wp_options VALUES(136,'woocommerce_store_city','','on');
INSERT INTO wp_options VALUES(137,'woocommerce_default_country','US:CA','on');
INSERT INTO wp_options VALUES(138,'woocommerce_store_postcode','','on');
INSERT INTO wp_options VALUES(139,'woocommerce_allowed_countries','all','on');
INSERT INTO wp_options VALUES(140,'woocommerce_all_except_countries','','on');
INSERT INTO wp_options VALUES(141,'woocommerce_specific_allowed_countries','','on');
INSERT INTO wp_options VALUES(142,'woocommerce_ship_to_countries','','on');
INSERT INTO wp_options VALUES(143,'woocommerce_specific_ship_to_countries','','on');
INSERT INTO wp_options VALUES(144,'woocommerce_default_customer_address','base','on');
INSERT INTO wp_options VALUES(145,'woocommerce_calc_taxes','no','on');
INSERT INTO wp_options VALUES(146,'woocommerce_enable_coupons','yes','on');
INSERT INTO wp_options VALUES(147,'woocommerce_calc_discounts_sequentially','no','off');
INSERT INTO wp_options VALUES(148,'woocommerce_currency','USD','on');
INSERT INTO wp_options VALUES(149,'woocommerce_currency_pos','left','on');
INSERT INTO wp_options VALUES(150,'woocommerce_price_thousand_sep',',','on');
INSERT INTO wp_options VALUES(151,'woocommerce_price_decimal_sep','.','on');
INSERT INTO wp_options VALUES(152,'woocommerce_price_num_decimals','2','on');
INSERT INTO wp_options VALUES(153,'woocommerce_shop_page_id','5','on');
INSERT INTO wp_options VALUES(154,'woocommerce_cart_redirect_after_add','no','on');
INSERT INTO wp_options VALUES(155,'woocommerce_enable_ajax_add_to_cart','yes','on');
INSERT INTO wp_options VALUES(156,'woocommerce_placeholder_image','4','on');
INSERT INTO wp_options VALUES(157,'woocommerce_weight_unit','lbs','on');
INSERT INTO wp_options VALUES(158,'woocommerce_dimension_unit','in','on');
INSERT INTO wp_options VALUES(159,'woocommerce_enable_reviews','yes','on');
INSERT INTO wp_options VALUES(160,'woocommerce_review_rating_verification_label','yes','off');
INSERT INTO wp_options VALUES(161,'woocommerce_review_rating_verification_required','no','off');
INSERT INTO wp_options VALUES(162,'woocommerce_enable_review_rating','yes','on');
INSERT INTO wp_options VALUES(163,'woocommerce_review_rating_required','yes','off');
INSERT INTO wp_options VALUES(164,'woocommerce_manage_stock','yes','on');
INSERT INTO wp_options VALUES(165,'woocommerce_hold_stock_minutes','60','off');
INSERT INTO wp_options VALUES(166,'woocommerce_notify_low_stock','yes','off');
INSERT INTO wp_options VALUES(167,'woocommerce_notify_no_stock','yes','off');
INSERT INTO wp_options VALUES(168,'woocommerce_stock_email_recipient','admin@example.com','off');
INSERT INTO wp_options VALUES(169,'woocommerce_notify_low_stock_amount','2','off');
INSERT INTO wp_options VALUES(170,'woocommerce_notify_no_stock_amount','0','on');
INSERT INTO wp_options VALUES(171,'woocommerce_hide_out_of_stock_items','no','on');
INSERT INTO wp_options VALUES(172,'woocommerce_stock_format','','on');
INSERT INTO wp_options VALUES(173,'woocommerce_file_download_method','force','off');
INSERT INTO wp_options VALUES(174,'woocommerce_downloads_redirect_fallback_allowed','no','off');
INSERT INTO wp_options VALUES(175,'woocommerce_downloads_require_login','no','off');
INSERT INTO wp_options VALUES(176,'woocommerce_downloads_grant_access_after_payment','yes','off');
INSERT INTO wp_options VALUES(177,'woocommerce_downloads_deliver_inline','','off');
INSERT INTO wp_options VALUES(178,'woocommerce_downloads_add_hash_to_filename','yes','on');
INSERT INTO wp_options VALUES(179,'woocommerce_downloads_count_partial','yes','on');
INSERT INTO wp_options VALUES(181,'woocommerce_attribute_lookup_direct_updates','no','on');
INSERT INTO wp_options VALUES(182,'woocommerce_attribute_lookup_optimized_updates','no','on');
INSERT INTO wp_options VALUES(183,'woocommerce_product_match_featured_image_by_sku','no','on');
INSERT INTO wp_options VALUES(184,'woocommerce_prices_include_tax','no','on');
INSERT INTO wp_options VALUES(185,'woocommerce_tax_based_on','shipping','on');
INSERT INTO wp_options VALUES(186,'woocommerce_shipping_tax_class','inherit','on');
INSERT INTO wp_options VALUES(187,'woocommerce_tax_round_at_subtotal','no','on');
INSERT INTO wp_options VALUES(188,'woocommerce_tax_classes','','on');
INSERT INTO wp_options VALUES(189,'woocommerce_tax_display_shop','excl','on');
INSERT INTO wp_options VALUES(190,'woocommerce_tax_display_cart','excl','on');
INSERT INTO wp_options VALUES(191,'woocommerce_price_display_suffix','','on');
INSERT INTO wp_options VALUES(192,'woocommerce_tax_total_display','itemized','off');
INSERT INTO wp_options VALUES(193,'woocommerce_enable_shipping_calc','yes','off');
INSERT INTO wp_options VALUES(194,'woocommerce_shipping_cost_requires_address','no','on');
INSERT INTO wp_options VALUES(195,'woocommerce_shipping_hide_rates_when_free','no','off');
INSERT INTO wp_options VALUES(196,'woocommerce_ship_to_destination','billing','off');
INSERT INTO wp_options VALUES(197,'woocommerce_shipping_debug_mode','no','on');
INSERT INTO wp_options VALUES(198,'woocommerce_enable_guest_checkout','yes','off');
INSERT INTO wp_options VALUES(199,'woocommerce_enable_checkout_login_reminder','no','off');
INSERT INTO wp_options VALUES(200,'woocommerce_enable_signup_and_login_from_checkout','no','off');
INSERT INTO wp_options VALUES(201,'woocommerce_enable_myaccount_registration','no','off');
INSERT INTO wp_options VALUES(202,'woocommerce_registration_generate_password','yes','off');
INSERT INTO wp_options VALUES(203,'woocommerce_registration_generate_username','yes','off');
INSERT INTO wp_options VALUES(204,'woocommerce_erasure_request_removes_order_data','no','off');
INSERT INTO wp_options VALUES(205,'woocommerce_erasure_request_removes_download_data','no','off');
INSERT INTO wp_options VALUES(206,'woocommerce_allow_bulk_remove_personal_data','no','off');
INSERT INTO wp_options VALUES(207,'woocommerce_registration_privacy_policy_text','Your personal data will be used to support your experience throughout this website, to manage access to your account, and for other purposes described in our [privacy_policy].','on');
INSERT INTO wp_options VALUES(208,'woocommerce_checkout_privacy_policy_text','Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our [privacy_policy].','on');
INSERT INTO wp_options VALUES(209,'woocommerce_delete_inactive_accounts','a:2:{s:6:"number";s:0:"";s:4:"unit";s:6:"months";}','off');
INSERT INTO wp_options VALUES(210,'woocommerce_trash_pending_orders','','off');
INSERT INTO wp_options VALUES(211,'woocommerce_trash_failed_orders','','off');
INSERT INTO wp_options VALUES(212,'woocommerce_trash_cancelled_orders','','off');
INSERT INTO wp_options VALUES(213,'woocommerce_anonymize_refunded_orders','a:2:{s:6:"number";s:0:"";s:4:"unit";s:6:"months";}','off');
INSERT INTO wp_options VALUES(214,'woocommerce_anonymize_completed_orders','a:2:{s:6:"number";s:0:"";s:4:"unit";s:6:"months";}','off');
INSERT INTO wp_options VALUES(215,'woocommerce_email_from_name','Test','off');
INSERT INTO wp_options VALUES(216,'woocommerce_email_from_address','admin@example.com','off');
INSERT INTO wp_options VALUES(217,'woocommerce_email_header_image','','off');
INSERT INTO wp_options VALUES(218,'woocommerce_email_header_image_width','120','on');
INSERT INTO wp_options VALUES(219,'woocommerce_email_header_alignment','left','on');
INSERT INTO wp_options VALUES(220,'woocommerce_email_font_family','Helvetica','on');
INSERT INTO wp_options VALUES(221,'woocommerce_email_footer_text','{site_title}<br />{store_address}','off');
INSERT INTO wp_options VALUES(222,'woocommerce_email_base_color','#720eec','off');
INSERT INTO wp_options VALUES(223,'woocommerce_email_background_color','#f7f7f7','off');
INSERT INTO wp_options VALUES(224,'woocommerce_email_body_background_color','#ffffff','off');
INSERT INTO wp_options VALUES(225,'woocommerce_email_text_color','#3c3c3c','off');
INSERT INTO wp_options VALUES(226,'woocommerce_email_footer_text_color','#3c3c3c','off');
INSERT INTO wp_options VALUES(227,'woocommerce_email_auto_sync_with_theme','no','off');
INSERT INTO wp_options VALUES(228,'woocommerce_cart_page_id','6','off');
INSERT INTO wp_options VALUES(229,'woocommerce_checkout_page_id','7','off');
INSERT INTO wp_options VALUES(230,'woocommerce_myaccount_page_id','8','off');
INSERT INTO wp_options VALUES(231,'woocommerce_terms_page_id','','off');
INSERT INTO wp_options VALUES(232,'woocommerce_force_ssl_checkout','no','on');
INSERT INTO wp_options VALUES(233,'woocommerce_unforce_ssl_checkout','no','on');
INSERT INTO wp_options VALUES(234,'woocommerce_checkout_pay_endpoint','order-pay','on');
INSERT INTO wp_options VALUES(235,'woocommerce_checkout_order_received_endpoint','order-received','on');
INSERT INTO wp_options VALUES(236,'woocommerce_myaccount_add_payment_method_endpoint','add-payment-method','on');
INSERT INTO wp_options VALUES(237,'woocommerce_myaccount_delete_payment_method_endpoint','delete-payment-method','on');
INSERT INTO wp_options VALUES(238,'woocommerce_myaccount_set_default_payment_method_endpoint','set-default-payment-method','on');
INSERT INTO wp_options VALUES(239,'woocommerce_myaccount_orders_endpoint','orders','on');
INSERT INTO wp_options VALUES(240,'woocommerce_myaccount_view_order_endpoint','view-order','on');
INSERT INTO wp_options VALUES(241,'woocommerce_myaccount_downloads_endpoint','downloads','on');
INSERT INTO wp_options VALUES(242,'woocommerce_myaccount_edit_account_endpoint','edit-account','on');
INSERT INTO wp_options VALUES(243,'woocommerce_myaccount_edit_address_endpoint','edit-address','on');
INSERT INTO wp_options VALUES(244,'woocommerce_myaccount_payment_methods_endpoint','payment-methods','on');
INSERT INTO wp_options VALUES(245,'woocommerce_myaccount_lost_password_endpoint','lost-password','on');
INSERT INTO wp_options VALUES(246,'woocommerce_logout_endpoint','customer-logout','on');
INSERT INTO wp_options VALUES(247,'woocommerce_api_enabled','no','on');
INSERT INTO wp_options VALUES(248,'woocommerce_allow_tracking','no','on');
INSERT INTO wp_options VALUES(249,'woocommerce_show_marketplace_suggestions','yes','off');
INSERT INTO wp_options VALUES(250,'woocommerce_custom_orders_table_enabled','no','on');
INSERT INTO wp_options VALUES(251,'woocommerce_analytics_enabled','yes','on');
INSERT INTO wp_options VALUES(252,'woocommerce_feature_rate_limit_checkout_enabled','no','on');
INSERT INTO wp_options VALUES(253,'woocommerce_feature_order_attribution_enabled','yes','on');
INSERT INTO wp_options VALUES(254,'woocommerce_feature_site_visibility_badge_enabled','yes','on');
INSERT INTO wp_options VALUES(255,'woocommerce_feature_remote_logging_enabled','yes','on');
INSERT INTO wp_options VALUES(256,'woocommerce_feature_email_improvements_enabled','no','on');
INSERT INTO wp_options VALUES(257,'_transient_timeout_wc_settings_email_improvements_reverted','1779905218','off');
INSERT INTO wp_options VALUES(258,'_transient_wc_settings_email_improvements_reverted','yes','off');
INSERT INTO wp_options VALUES(259,'woocommerce_email_improvements_disabled_count','1','auto');
INSERT INTO wp_options VALUES(260,'woocommerce_email_improvements_first_disabled_at','2026-05-27 18:06:43','auto');
INSERT INTO wp_options VALUES(261,'woocommerce_email_improvements_last_disabled_at','2026-05-27 18:06:43','auto');
INSERT INTO wp_options VALUES(262,'woocommerce_feature_blueprint_enabled','yes','on');
INSERT INTO wp_options VALUES(263,'woocommerce_feature_product_block_editor_enabled','no','on');
INSERT INTO wp_options VALUES(264,'woocommerce_hpos_fts_index_enabled','no','on');
INSERT INTO wp_options VALUES(265,'woocommerce_hpos_datastore_caching_enabled','no','on');
INSERT INTO wp_options VALUES(266,'woocommerce_feature_block_email_editor_enabled','no','on');
INSERT INTO wp_options VALUES(267,'woocommerce_feature_cost_of_goods_sold_enabled','no','on');
INSERT INTO wp_options VALUES(268,'woocommerce_single_image_width','600','on');
INSERT INTO wp_options VALUES(269,'woocommerce_thumbnail_image_width','300','on');
INSERT INTO wp_options VALUES(270,'woocommerce_checkout_highlight_required_fields','yes','on');
INSERT INTO wp_options VALUES(271,'woocommerce_demo_store','no','off');
INSERT INTO wp_options VALUES(272,'wc_downloads_approved_directories_mode','enabled','auto');
INSERT INTO wp_options VALUES(273,'woocommerce_permalinks','a:5:{s:12:"product_base";s:7:"product";s:13:"category_base";s:16:"product-category";s:8:"tag_base";s:11:"product-tag";s:14:"attribute_base";s:0:"";s:22:"use_verbose_page_rules";b:0;}','auto');
INSERT INTO wp_options VALUES(274,'current_theme_supports_woocommerce','yes','auto');
INSERT INTO wp_options VALUES(275,'woocommerce_queue_flush_rewrite_rules','no','auto');
INSERT INTO wp_options VALUES(276,'_transient_wc_attribute_taxonomies','a:0:{}','on');
INSERT INTO wp_options VALUES(277,'_transient_timeout_wc_term_counts','1782497204','off');
INSERT INTO wp_options VALUES(278,'_transient_wc_term_counts','a:0:{}','off');
INSERT INTO wp_options VALUES(279,'product_cat_children','a:0:{}','auto');
INSERT INTO wp_options VALUES(280,'default_product_cat','15','auto');
INSERT INTO wp_options VALUES(281,'woocommerce_refund_returns_page_created','9','off');
INSERT INTO wp_options VALUES(282,'woocommerce_refund_returns_page_id','9','auto');
INSERT INTO wp_options VALUES(283,'_transient_timeout__wc_activation_redirect','1779905234','off');
INSERT INTO wp_options VALUES(284,'_transient__wc_activation_redirect','1','off');
INSERT INTO wp_options VALUES(285,'woocommerce_paypal_settings','a:23:{s:7:"enabled";s:2:"no";s:5:"title";s:6:"PayPal";s:11:"description";s:85:"Pay via PayPal; you can pay with your credit card if you don''t have a PayPal account.";s:5:"email";s:17:"admin@example.com";s:8:"advanced";s:0:"";s:8:"testmode";s:2:"no";s:5:"debug";s:2:"no";s:16:"ipn_notification";s:3:"yes";s:14:"receiver_email";s:17:"admin@example.com";s:14:"identity_token";s:0:"";s:14:"invoice_prefix";s:3:"WC-";s:13:"send_shipping";s:3:"yes";s:16:"address_override";s:2:"no";s:13:"paymentaction";s:4:"sale";s:9:"image_url";s:0:"";s:11:"api_details";s:0:"";s:12:"api_username";s:0:"";s:12:"api_password";s:0:"";s:13:"api_signature";s:0:"";s:20:"sandbox_api_username";s:0:"";s:20:"sandbox_api_password";s:0:"";s:21:"sandbox_api_signature";s:0:"";s:12:"_should_load";s:2:"no";}','on');
INSERT INTO wp_options VALUES(286,'woocommerce_version','9.9.7','auto');
INSERT INTO wp_options VALUES(287,'woocommerce_db_version','9.9.7','auto');
INSERT INTO wp_options VALUES(288,'woocommerce_store_id','bdc7e9c5-fe8a-4504-b05a-ac0c0f048fc7','auto');
INSERT INTO wp_options VALUES(289,'woocommerce_admin_install_timestamp','1779905204','auto');
INSERT INTO wp_options VALUES(290,'woocommerce_inbox_variant_assignment','1','auto');
INSERT INTO wp_options VALUES(291,'woocommerce_remote_variant_assignment','101','auto');
INSERT INTO wp_options VALUES(292,'woocommerce_attribute_lookup_enabled','no','auto');
INSERT INTO wp_options VALUES(293,'_transient_timeout__woocommerce_upload_directory_status','1779991604','off');
INSERT INTO wp_options VALUES(294,'_transient__woocommerce_upload_directory_status','protected','off');
INSERT INTO wp_options VALUES(295,'_transient_woocommerce_activated_plugin','woocommerce/woocommerce.php','on');
INSERT INTO wp_options VALUES(296,'_transient_jetpack_autoloader_plugin_paths','a:1:{i:0;s:29:"{{WP_PLUGIN_DIR}}/woocommerce";}','on');
INSERT INTO wp_options VALUES(297,'woocommerce_admin_notices','a:2:{i:0;s:20:"no_secure_connection";i:1;s:14:"template_files";}','auto');
INSERT INTO wp_options VALUES(298,'woocommerce_maxmind_geolocation_settings','a:1:{s:15:"database_prefix";s:32:"CKzAtggL3qrs1sv2F0q7Cu45pb8yQiAj";}','on');
INSERT INTO wp_options VALUES(299,'_transient_woocommerce_webhook_ids_status_active','a:0:{}','on');
INSERT INTO wp_options VALUES(300,'nonce_key',',Fm|6-do7t^K8a79w}8VEs%gg=Sllv@ek/jZ+WgJ$iv@oJ[I!l3`!,#%!<!jZy3q','off');
INSERT INTO wp_options VALUES(301,'nonce_salt','r%-`NCNHsq56n i v|lX=nEZlhsMKa9tQ6cE,OVg?)Kjt%PwiT,`JpE`TN!^kNaf','off');
INSERT INTO wp_options VALUES(302,'widget_woocommerce_widget_cart','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(303,'widget_woocommerce_layered_nav_filters','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(304,'widget_woocommerce_layered_nav','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(305,'widget_woocommerce_price_filter','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(306,'widget_woocommerce_product_categories','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(307,'widget_woocommerce_product_search','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(308,'widget_woocommerce_product_tag_cloud','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(309,'widget_woocommerce_products','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(310,'widget_woocommerce_recently_viewed_products','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(311,'widget_woocommerce_top_rated_products','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(312,'widget_woocommerce_recent_reviews','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(313,'widget_woocommerce_rating_filter','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(314,'widget_wc_brands_brand_description','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(315,'widget_woocommerce_brand_nav','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(316,'widget_wc_brands_brand_thumbnails','a:1:{s:12:"_multiwidget";i:1;}','auto');
INSERT INTO wp_options VALUES(317,'_site_transient_timeout_woocommerce_blocks_patterns','1782497204','off');
INSERT INTO wp_options VALUES(318,'_site_transient_woocommerce_blocks_patterns','a:2:{s:7:"version";s:5:"9.9.7";s:8:"patterns";a:41:{i:0;a:11:{s:5:"title";s:6:"Banner";s:4:"slug";s:25:"woocommerce-blocks/banner";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:29:"WooCommerce, featured-selling";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:10:"banner.php";}i:1;a:11:{s:5:"title";s:23:"Coming Soon Entire Site";s:4:"slug";s:35:"woocommerce/coming-soon-entire-site";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:5:"false";s:11:"featureFlag";s:17:"launch-your-store";s:13:"templateTypes";s:0:"";s:6:"source";s:27:"coming-soon-entire-site.php";}i:2;a:11:{s:5:"title";s:22:"Coming Soon Store Only";s:4:"slug";s:34:"woocommerce/coming-soon-store-only";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:5:"false";s:11:"featureFlag";s:17:"launch-your-store";s:13:"templateTypes";s:0:"";s:6:"source";s:26:"coming-soon-store-only.php";}i:3;a:11:{s:5:"title";s:11:"Coming Soon";s:4:"slug";s:23:"woocommerce/coming-soon";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:5:"false";s:11:"featureFlag";s:17:"launch-your-store";s:13:"templateTypes";s:0:"";s:6:"source";s:15:"coming-soon.php";}i:4;a:11:{s:5:"title";s:29:"Content right with image left";s:4:"slug";s:48:"woocommerce-blocks/content-right-with-image-left";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:18:"WooCommerce, About";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:28:"content-right-image-left.php";}i:5;a:11:{s:5:"title";s:29:"Featured Category Cover Image";s:4:"slug";s:48:"woocommerce-blocks/featured-category-cover-image";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:18:"WooCommerce, Intro";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:33:"featured-category-cover-image.php";}i:6;a:11:{s:5:"title";s:24:"Featured Category Triple";s:4:"slug";s:43:"woocommerce-blocks/featured-category-triple";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:29:"WooCommerce, featured-selling";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:28:"featured-category-triple.php";}i:7;a:11:{s:5:"title";s:12:"Large Footer";s:4:"slug";s:31:"woocommerce-blocks/footer-large";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:25:"core/template-part/footer";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:16:"footer-large.php";}i:8;a:11:{s:5:"title";s:23:"Footer with Simple Menu";s:4:"slug";s:37:"woocommerce-blocks/footer-simple-menu";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:25:"core/template-part/footer";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:22:"footer-simple-menu.php";}i:9;a:11:{s:5:"title";s:17:"Footer with menus";s:4:"slug";s:38:"woocommerce-blocks/footer-with-3-menus";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:25:"core/template-part/footer";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:23:"footer-with-3-menus.php";}i:10;a:11:{s:5:"title";s:28:"Four Image Grid Content Left";s:4:"slug";s:47:"woocommerce-blocks/form-image-grid-content-left";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:18:"WooCommerce, About";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:32:"four-image-grid-content-left.php";}i:11;a:11:{s:5:"title";s:20:"Centered Header Menu";s:4:"slug";s:39:"woocommerce-blocks/header-centered-menu";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:25:"core/template-part/header";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:27:"header-centered-pattern.php";}i:12;a:11:{s:5:"title";s:23:"Distraction Free Header";s:4:"slug";s:42:"woocommerce-blocks/header-distraction-free";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:25:"core/template-part/header";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:27:"header-distraction-free.php";}i:13;a:11:{s:5:"title";s:16:"Essential Header";s:4:"slug";s:35:"woocommerce-blocks/header-essential";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:25:"core/template-part/header";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:20:"header-essential.php";}i:14;a:11:{s:5:"title";s:12:"Large Header";s:4:"slug";s:31:"woocommerce-blocks/header-large";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:25:"core/template-part/header";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:16:"header-large.php";}i:15;a:11:{s:5:"title";s:14:"Minimal Header";s:4:"slug";s:33:"woocommerce-blocks/header-minimal";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:25:"core/template-part/header";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:18:"header-minimal.php";}i:16;a:11:{s:5:"title";s:47:"Heading with three columns of content with link";s:4:"slug";s:66:"woocommerce-blocks/heading-with-three-columns-of-content-with-link";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:21:"WooCommerce, Services";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:51:"heading-with-three-columns-of-content-with-link.php";}i:17;a:11:{s:5:"title";s:20:"Hero Product 3 Split";s:4:"slug";s:39:"woocommerce-blocks/hero-product-3-split";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:29:"WooCommerce, featured-selling";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:24:"hero-product-3-split.php";}i:18;a:11:{s:5:"title";s:23:"Hero Product Chessboard";s:4:"slug";s:42:"woocommerce-blocks/hero-product-chessboard";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:29:"WooCommerce, featured-selling";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:27:"hero-product-chessboard.php";}i:19;a:11:{s:5:"title";s:18:"Hero Product Split";s:4:"slug";s:37:"woocommerce-blocks/hero-product-split";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:18:"WooCommerce, Intro";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:22:"hero-product-split.php";}i:20;a:11:{s:5:"title";s:33:"Centered content with image below";s:4:"slug";s:52:"woocommerce-blocks/centered-content-with-image-below";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:18:"WooCommerce, Intro";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:43:"intro-centered-content-with-image-below.php";}i:21;a:11:{s:5:"title";s:22:"Just Arrived Full Hero";s:4:"slug";s:41:"woocommerce-blocks/just-arrived-full-hero";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:18:"WooCommerce, Intro";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:26:"just-arrived-full-hero.php";}i:22;a:11:{s:5:"title";s:33:"No Products Found - Clear Filters";s:4:"slug";s:43:"woocommerce/no-products-found-clear-filters";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:2:"no";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:29:"no-products-found-filters.php";}i:23;a:11:{s:5:"title";s:17:"No Products Found";s:4:"slug";s:29:"woocommerce/no-products-found";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:2:"no";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:21:"no-products-found.php";}i:24;a:11:{s:5:"title";s:19:"Default Coming Soon";s:4:"slug";s:36:"woocommerce/page-coming-soon-default";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:5:"false";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:11:"coming-soon";s:6:"source";s:28:"page-coming-soon-default.php";}i:25;a:11:{s:5:"title";s:25:"Coming Soon Image Gallery";s:4:"slug";s:42:"woocommerce/page-coming-soon-image-gallery";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:5:"false";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:11:"coming-soon";s:6:"source";s:34:"page-coming-soon-image-gallery.php";}i:26;a:11:{s:5:"title";s:30:"Coming Soon Minimal Left Image";s:4:"slug";s:47:"woocommerce/page-coming-soon-minimal-left-image";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:5:"false";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:11:"coming-soon";s:6:"source";s:39:"page-coming-soon-minimal-left-image.php";}i:27;a:11:{s:5:"title";s:24:"Coming Soon Modern Black";s:4:"slug";s:41:"woocommerce/page-coming-soon-modern-black";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:5:"false";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:11:"coming-soon";s:6:"source";s:33:"page-coming-soon-modern-black.php";}i:28;a:11:{s:5:"title";s:29:"Coming Soon Split Right Image";s:4:"slug";s:46:"woocommerce/page-coming-soon-split-right-image";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:5:"false";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:11:"coming-soon";s:6:"source";s:38:"page-coming-soon-split-right-image.php";}i:29;a:11:{s:5:"title";s:34:"Coming Soon With Header and Footer";s:4:"slug";s:47:"woocommerce/page-coming-soon-with-header-footer";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:5:"false";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:11:"coming-soon";s:6:"source";s:39:"page-coming-soon-with-header-footer.php";}i:30;a:11:{s:5:"title";s:28:"Product Collection 3 Columns";s:4:"slug";s:47:"woocommerce-blocks/product-collection-3-columns";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:32:"product-collection-3-columns.php";}i:31;a:11:{s:5:"title";s:28:"Product Collection 4 Columns";s:4:"slug";s:47:"woocommerce-blocks/product-collection-4-columns";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:29:"WooCommerce, featured-selling";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:32:"product-collection-4-columns.php";}i:32;a:11:{s:5:"title";s:28:"Product Collection 5 Columns";s:4:"slug";s:47:"woocommerce-blocks/product-collection-5-columns";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:29:"WooCommerce, featured-selling";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:32:"product-collection-5-columns.php";}i:33;a:11:{s:5:"title";s:47:"Product Collection: Featured Products 5 Columns";s:4:"slug";s:65:"woocommerce-blocks/product-collection-featured-products-5-columns";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:29:"WooCommerce, featured-selling";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:50:"product-collection-featured-products-5-columns.php";}i:34;a:11:{s:5:"title";s:15:"Product Gallery";s:4:"slug";s:48:"woocommerce-blocks/product-query-product-gallery";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:29:"WooCommerce, featured-selling";s:8:"keywords";s:0:"";s:10:"blockTypes";s:36:"core/query/woocommerce/product-query";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:33:"product-query-product-gallery.php";}i:35;a:11:{s:5:"title";s:14:"Product Search";s:4:"slug";s:31:"woocommerce/product-search-form";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:2:"no";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:23:"product-search-form.php";}i:36;a:11:{s:5:"title";s:16:"Related Products";s:4:"slug";s:35:"woocommerce-blocks/related-products";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:11:"WooCommerce";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:5:"false";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:20:"related-products.php";}i:37;a:11:{s:5:"title";s:33:"Social: Follow us on social media";s:4:"slug";s:51:"woocommerce-blocks/social-follow-us-in-social-media";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:25:"WooCommerce, social-media";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:36:"social-follow-us-in-social-media.php";}i:38;a:11:{s:5:"title";s:22:"Testimonials 3 Columns";s:4:"slug";s:41:"woocommerce-blocks/testimonials-3-columns";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:20:"WooCommerce, Reviews";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:26:"testimonials-3-columns.php";}i:39;a:11:{s:5:"title";s:19:"Testimonials Single";s:4:"slug";s:38:"woocommerce-blocks/testimonials-single";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:20:"WooCommerce, Reviews";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:23:"testimonials-single.php";}i:40;a:11:{s:5:"title";s:37:"Three columns with images and content";s:4:"slug";s:56:"woocommerce-blocks/three-columns-with-images-and-content";s:11:"description";s:0:"";s:13:"viewportWidth";s:0:"";s:10:"categories";s:21:"WooCommerce, Services";s:8:"keywords";s:0:"";s:10:"blockTypes";s:0:"";s:8:"inserter";s:0:"";s:11:"featureFlag";s:0:"";s:13:"templateTypes";s:0:"";s:6:"source";s:41:"three-columns-with-images-and-content.php";}}}','off');
INSERT INTO wp_options VALUES(319,'woocommerce_checkout_phone_field','optional','auto');
INSERT INTO wp_options VALUES(320,'woocommerce_checkout_company_field','hidden','auto');
INSERT INTO wp_options VALUES(321,'woocommerce_checkout_address_2_field','optional','auto');
INSERT INTO wp_options VALUES(322,'_site_transient_timeout_theme_roots','1779907004','off');
INSERT INTO wp_options VALUES(323,'_site_transient_theme_roots','a:1:{s:10:"storefront";s:7:"/themes";}','off');
INSERT INTO wp_options VALUES(324,'theme_mods_twentytwentyfive','a:1:{s:16:"sidebars_widgets";a:2:{s:4:"time";i:1779905204;s:4:"data";a:3:{s:19:"wp_inactive_widgets";a:0:{}s:9:"sidebar-1";a:3:{i:0;s:7:"block-2";i:1;s:7:"block-3";i:2;s:7:"block-4";}s:9:"sidebar-2";a:2:{i:0;s:7:"block-5";i:1;s:7:"block-6";}}}}','off');
INSERT INTO wp_options VALUES(325,'current_theme','Storefront','auto');
INSERT INTO wp_options VALUES(326,'theme_switched','','auto');
INSERT INTO wp_options VALUES(327,'_site_transient_timeout_wp_theme_files_patterns-39d311eddbd7f05bc67d50091fb13ddd','1779907005','off');
INSERT INTO wp_options VALUES(328,'_site_transient_wp_theme_files_patterns-39d311eddbd7f05bc67d50091fb13ddd','a:2:{s:7:"version";s:5:"4.6.2";s:8:"patterns";a:0:{}}','off');
INSERT INTO wp_options VALUES(329,'theme_mods_storefront','a:1:{s:18:"nav_menu_locations";a:0:{}}','auto');
INSERT INTO wp_options VALUES(330,'woocommerce_catalog_rows','4','auto');
INSERT INTO wp_options VALUES(331,'woocommerce_catalog_columns','3','auto');
INSERT INTO wp_options VALUES(332,'woocommerce_maybe_regenerate_images_hash','27acde77266b4d2a3491118955cb3f66','auto');
INSERT INTO wp_options VALUES(333,'wp_1_wc_regenerate_images_batch_d7ea76af64ce48b8790966709173b094','a:1:{i:0;a:1:{s:13:"attachment_id";s:1:"4";}}','off');
INSERT INTO wp_options VALUES(334,'woocommerce_custom_orders_table_created','yes','auto');
CREATE TABLE `wp_postmeta` (
`meta_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`post_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`meta_key` text DEFAULT NULL COLLATE NOCASE,
`meta_value` text COLLATE NOCASE);
INSERT INTO wp_postmeta VALUES(1,2,'_wp_page_template','default');
INSERT INTO wp_postmeta VALUES(2,3,'_wp_page_template','default');
INSERT INTO wp_postmeta VALUES(3,4,'_wp_attached_file','woocommerce-placeholder.png');
INSERT INTO wp_postmeta VALUES(4,4,'_wp_attachment_metadata','a:6:{s:5:"width";i:1200;s:6:"height";i:1200;s:4:"file";s:27:"woocommerce-placeholder.png";s:8:"filesize";i:48149;s:5:"sizes";a:4:{s:6:"medium";a:5:{s:4:"file";s:35:"woocommerce-placeholder-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";s:8:"filesize";i:12321;}s:5:"large";a:5:{s:4:"file";s:37:"woocommerce-placeholder-1024x1024.png";s:5:"width";i:1024;s:6:"height";i:1024;s:9:"mime-type";s:9:"image/png";s:8:"filesize";i:90808;}s:9:"thumbnail";a:5:{s:4:"file";s:35:"woocommerce-placeholder-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";s:8:"filesize";i:4209;}s:12:"medium_large";a:5:{s:4:"file";s:35:"woocommerce-placeholder-768x768.png";s:5:"width";i:768;s:6:"height";i:768;s:9:"mime-type";s:9:"image/png";s:8:"filesize";i:56643;}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}');
CREATE TABLE `wp_posts` (
`ID` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`post_author` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`post_date` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`post_date_gmt` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`post_content` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`post_title` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`post_excerpt` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`post_status` text NOT NULL ON CONFLICT REPLACE DEFAULT 'publish' COLLATE NOCASE,
`comment_status` text NOT NULL ON CONFLICT REPLACE DEFAULT 'open' COLLATE NOCASE,
`ping_status` text NOT NULL ON CONFLICT REPLACE DEFAULT 'open' COLLATE NOCASE,
`post_password` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`post_name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`to_ping` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`pinged` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`post_modified` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`post_modified_gmt` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`post_content_filtered` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`post_parent` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`guid` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`menu_order` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`post_type` text NOT NULL ON CONFLICT REPLACE DEFAULT 'post' COLLATE NOCASE,
`post_mime_type` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`comment_count` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0');
INSERT INTO wp_posts VALUES(1,1,'2026-05-27 18:06:30','2026-05-27 18:06:30',unistr('<!-- wp:paragraph -->\u000a<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\u000a<!-- /wp:paragraph -->'),'Hello world!','','publish','open','open','','hello-world','','','2026-05-27 18:06:30','2026-05-27 18:06:30','',0,'http://localhost:8080/?p=1',0,'post','',1);
INSERT INTO wp_posts VALUES(2,1,'2026-05-27 18:06:30','2026-05-27 18:06:30',unistr('<!-- wp:paragraph -->\u000a<p>This is an example page. It''s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:quote -->\u000a<blockquote class="wp-block-quote">\u000a<!-- wp:paragraph -->\u000a<p>Hi there! I''m a bike messenger by day, aspiring actor by night, and this is my website. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin'' caught in the rain.)</p>\u000a<!-- /wp:paragraph -->\u000a</blockquote>\u000a<!-- /wp:quote -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>...or something like this:</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:quote -->\u000a<blockquote class="wp-block-quote">\u000a<!-- wp:paragraph -->\u000a<p>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</p>\u000a<!-- /wp:paragraph -->\u000a</blockquote>\u000a<!-- /wp:quote -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>As a new WordPress user, you should go to <a href="http://localhost:8080/wp/wp-admin/">your dashboard</a> to delete this page and create new pages for your content. Have fun!</p>\u000a<!-- /wp:paragraph -->'),'Sample Page','','publish','closed','open','','sample-page','','','2026-05-27 18:06:30','2026-05-27 18:06:30','',0,'http://localhost:8080/?page_id=2',0,'page','',0);
INSERT INTO wp_posts VALUES(3,1,'2026-05-27 18:06:30','2026-05-27 18:06:30',unistr('<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Who we are</h2>\u000a<!-- /wp:heading -->\u000a<!-- wp:paragraph -->\u000a<p><strong class="privacy-policy-tutorial">Suggested text: </strong>Our website address is: http://localhost:8080.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Comments</h2>\u000a<!-- /wp:heading -->\u000a<!-- wp:paragraph -->\u000a<p><strong class="privacy-policy-tutorial">Suggested text: </strong>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&#8217;s IP address and browser user agent string to help spam detection.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:paragraph -->\u000a<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Media</h2>\u000a<!-- /wp:heading -->\u000a<!-- wp:paragraph -->\u000a<p><strong class="privacy-policy-tutorial">Suggested text: </strong>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Cookies</h2>\u000a<!-- /wp:heading -->\u000a<!-- wp:paragraph -->\u000a<p><strong class="privacy-policy-tutorial">Suggested text: </strong>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:paragraph -->\u000a<p>If you visit our login page, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:paragraph -->\u000a<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &quot;Remember Me&quot;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:paragraph -->\u000a<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Embedded content from other websites</h2>\u000a<!-- /wp:heading -->\u000a<!-- wp:paragraph -->\u000a<p><strong class="privacy-policy-tutorial">Suggested text: </strong>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:paragraph -->\u000a<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Who we share your data with</h2>\u000a<!-- /wp:heading -->\u000a<!-- wp:paragraph -->\u000a<p><strong class="privacy-policy-tutorial">Suggested text: </strong>If you request a password reset, your IP address will be included in the reset email.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">How long we retain your data</h2>\u000a<!-- /wp:heading -->\u000a<!-- wp:paragraph -->\u000a<p><strong class="privacy-policy-tutorial">Suggested text: </strong>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:paragraph -->\u000a<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">What rights you have over your data</h2>\u000a<!-- /wp:heading -->\u000a<!-- wp:paragraph -->\u000a<p><strong class="privacy-policy-tutorial">Suggested text: </strong>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\u000a<!-- /wp:paragraph -->\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Where your data is sent</h2>\u000a<!-- /wp:heading -->\u000a<!-- wp:paragraph -->\u000a<p><strong class="privacy-policy-tutorial">Suggested text: </strong>Visitor comments may be checked through an automated spam detection service.</p>\u000a<!-- /wp:paragraph -->\u000a'),'Privacy Policy','','draft','closed','open','','privacy-policy','','','2026-05-27 18:06:30','2026-05-27 18:06:30','',0,'http://localhost:8080/?page_id=3',0,'page','',0);
INSERT INTO wp_posts VALUES(4,0,'2026-05-27 18:06:44','2026-05-27 18:06:44','','woocommerce-placeholder','','inherit','open','closed','','woocommerce-placeholder','','','2026-05-27 18:06:44','2026-05-27 18:06:44','',0,'http://localhost:8080/packages/uploads/2026/05/woocommerce-placeholder.png',0,'attachment','image/png',0);
INSERT INTO wp_posts VALUES(5,1,'2026-05-27 18:06:44','2026-05-27 18:06:44','','Shop','','publish','closed','closed','','shop','','','2026-05-27 18:06:44','2026-05-27 18:06:44','',0,'http://localhost:8080/?page_id=5',0,'page','',0);
INSERT INTO wp_posts VALUES(6,1,'2026-05-27 18:06:44','2026-05-27 18:06:44',unistr('<!-- wp:woocommerce/cart -->\u000a<div class="wp-block-woocommerce-cart alignwide is-loading"><!-- wp:woocommerce/filled-cart-block -->\u000a<div class="wp-block-woocommerce-filled-cart-block"><!-- wp:woocommerce/cart-items-block -->\u000a<div class="wp-block-woocommerce-cart-items-block"><!-- wp:woocommerce/cart-line-items-block -->\u000a<div class="wp-block-woocommerce-cart-line-items-block"></div>\u000a<!-- /wp:woocommerce/cart-line-items-block -->\u000a\u000a<!-- wp:woocommerce/cart-cross-sells-block -->\u000a<div class="wp-block-woocommerce-cart-cross-sells-block"><!-- wp:heading {"fontSize":"large"} -->\u000a<h2 class="wp-block-heading has-large-font-size">You may be interested in…</h2>\u000a<!-- /wp:heading -->\u000a\u000a<!-- wp:woocommerce/cart-cross-sells-products-block -->\u000a<div class="wp-block-woocommerce-cart-cross-sells-products-block"></div>\u000a<!-- /wp:woocommerce/cart-cross-sells-products-block --></div>\u000a<!-- /wp:woocommerce/cart-cross-sells-block --></div>\u000a<!-- /wp:woocommerce/cart-items-block -->\u000a\u000a<!-- wp:woocommerce/cart-totals-block -->\u000a<div class="wp-block-woocommerce-cart-totals-block"><!-- wp:woocommerce/cart-order-summary-block -->\u000a<div class="wp-block-woocommerce-cart-order-summary-block"><!-- wp:woocommerce/cart-order-summary-heading-block -->\u000a<div class="wp-block-woocommerce-cart-order-summary-heading-block"></div>\u000a<!-- /wp:woocommerce/cart-order-summary-heading-block -->\u000a\u000a<!-- wp:woocommerce/cart-order-summary-coupon-form-block -->\u000a<div class="wp-block-woocommerce-cart-order-summary-coupon-form-block"></div>\u000a<!-- /wp:woocommerce/cart-order-summary-coupon-form-block -->\u000a\u000a<!-- wp:woocommerce/cart-order-summary-subtotal-block -->\u000a<div class="wp-block-woocommerce-cart-order-summary-subtotal-block"></div>\u000a<!-- /wp:woocommerce/cart-order-summary-subtotal-block -->\u000a\u000a<!-- wp:woocommerce/cart-order-summary-fee-block -->\u000a<div class="wp-block-woocommerce-cart-order-summary-fee-block"></div>\u000a<!-- /wp:woocommerce/cart-order-summary-fee-block -->\u000a\u000a<!-- wp:woocommerce/cart-order-summary-discount-block -->\u000a<div class="wp-block-woocommerce-cart-order-summary-discount-block"></div>\u000a<!-- /wp:woocommerce/cart-order-summary-discount-block -->\u000a\u000a<!-- wp:woocommerce/cart-order-summary-shipping-block -->\u000a<div class="wp-block-woocommerce-cart-order-summary-shipping-block"></div>\u000a<!-- /wp:woocommerce/cart-order-summary-shipping-block -->\u000a\u000a<!-- wp:woocommerce/cart-order-summary-taxes-block -->\u000a<div class="wp-block-woocommerce-cart-order-summary-taxes-block"></div>\u000a<!-- /wp:woocommerce/cart-order-summary-taxes-block --></div>\u000a<!-- /wp:woocommerce/cart-order-summary-block -->\u000a\u000a<!-- wp:woocommerce/cart-express-payment-block -->\u000a<div class="wp-block-woocommerce-cart-express-payment-block"></div>\u000a<!-- /wp:woocommerce/cart-express-payment-block -->\u000a\u000a<!-- wp:woocommerce/proceed-to-checkout-block -->\u000a<div class="wp-block-woocommerce-proceed-to-checkout-block"></div>\u000a<!-- /wp:woocommerce/proceed-to-checkout-block -->\u000a\u000a<!-- wp:woocommerce/cart-accepted-payment-methods-block -->\u000a<div class="wp-block-woocommerce-cart-accepted-payment-methods-block"></div>\u000a<!-- /wp:woocommerce/cart-accepted-payment-methods-block --></div>\u000a<!-- /wp:woocommerce/cart-totals-block --></div>\u000a<!-- /wp:woocommerce/filled-cart-block -->\u000a\u000a<!-- wp:woocommerce/empty-cart-block -->\u000a<div class="wp-block-woocommerce-empty-cart-block"><!-- wp:heading {"textAlign":"center","className":"with-empty-cart-icon wc-block-cart__empty-cart__title"} -->\u000a<h2 class="wp-block-heading has-text-align-center with-empty-cart-icon wc-block-cart__empty-cart__title">Your cart is currently empty!</h2>\u000a<!-- /wp:heading -->\u000a\u000a<!-- wp:separator {"className":"is-style-dots"} -->\u000a<hr class="wp-block-separator has-alpha-channel-opacity is-style-dots"/>\u000a<!-- /wp:separator -->\u000a\u000a<!-- wp:heading {"textAlign":"center"} -->\u000a<h2 class="wp-block-heading has-text-align-center">New in store</h2>\u000a<!-- /wp:heading -->\u000a\u000a<!-- wp:woocommerce/product-new {"columns":4,"rows":1} /--></div>\u000a<!-- /wp:woocommerce/empty-cart-block --></div>\u000a<!-- /wp:woocommerce/cart -->'),'Cart','','publish','closed','closed','','cart','','','2026-05-27 18:06:44','2026-05-27 18:06:44','',0,'http://localhost:8080/?page_id=6',0,'page','',0);
INSERT INTO wp_posts VALUES(7,1,'2026-05-27 18:06:44','2026-05-27 18:06:44',unistr('<!-- wp:woocommerce/checkout -->\u000a<div class="wp-block-woocommerce-checkout alignwide wc-block-checkout is-loading"><!-- wp:woocommerce/checkout-fields-block -->\u000a<div class="wp-block-woocommerce-checkout-fields-block"><!-- wp:woocommerce/checkout-express-payment-block -->\u000a<div class="wp-block-woocommerce-checkout-express-payment-block"></div>\u000a<!-- /wp:woocommerce/checkout-express-payment-block -->\u000a\u000a<!-- wp:woocommerce/checkout-contact-information-block -->\u000a<div class="wp-block-woocommerce-checkout-contact-information-block"></div>\u000a<!-- /wp:woocommerce/checkout-contact-information-block -->\u000a\u000a<!-- wp:woocommerce/checkout-shipping-method-block -->\u000a<div class="wp-block-woocommerce-checkout-shipping-method-block"></div>\u000a<!-- /wp:woocommerce/checkout-shipping-method-block -->\u000a\u000a<!-- wp:woocommerce/checkout-pickup-options-block -->\u000a<div class="wp-block-woocommerce-checkout-pickup-options-block"></div>\u000a<!-- /wp:woocommerce/checkout-pickup-options-block -->\u000a\u000a<!-- wp:woocommerce/checkout-shipping-address-block -->\u000a<div class="wp-block-woocommerce-checkout-shipping-address-block"></div>\u000a<!-- /wp:woocommerce/checkout-shipping-address-block -->\u000a\u000a<!-- wp:woocommerce/checkout-billing-address-block -->\u000a<div class="wp-block-woocommerce-checkout-billing-address-block"></div>\u000a<!-- /wp:woocommerce/checkout-billing-address-block -->\u000a\u000a<!-- wp:woocommerce/checkout-shipping-methods-block -->\u000a<div class="wp-block-woocommerce-checkout-shipping-methods-block"></div>\u000a<!-- /wp:woocommerce/checkout-shipping-methods-block -->\u000a\u000a<!-- wp:woocommerce/checkout-payment-block -->\u000a<div class="wp-block-woocommerce-checkout-payment-block"></div>\u000a<!-- /wp:woocommerce/checkout-payment-block -->\u000a\u000a<!-- wp:woocommerce/checkout-additional-information-block -->\u000a<div class="wp-block-woocommerce-checkout-additional-information-block"></div>\u000a<!-- /wp:woocommerce/checkout-additional-information-block -->\u000a\u000a<!-- wp:woocommerce/checkout-order-note-block -->\u000a<div class="wp-block-woocommerce-checkout-order-note-block"></div>\u000a<!-- /wp:woocommerce/checkout-order-note-block -->\u000a\u000a<!-- wp:woocommerce/checkout-terms-block -->\u000a<div class="wp-block-woocommerce-checkout-terms-block"></div>\u000a<!-- /wp:woocommerce/checkout-terms-block -->\u000a\u000a<!-- wp:woocommerce/checkout-actions-block -->\u000a<div class="wp-block-woocommerce-checkout-actions-block"></div>\u000a<!-- /wp:woocommerce/checkout-actions-block --></div>\u000a<!-- /wp:woocommerce/checkout-fields-block -->\u000a\u000a<!-- wp:woocommerce/checkout-totals-block -->\u000a<div class="wp-block-woocommerce-checkout-totals-block"><!-- wp:woocommerce/checkout-order-summary-block -->\u000a<div class="wp-block-woocommerce-checkout-order-summary-block"><!-- wp:woocommerce/checkout-order-summary-cart-items-block -->\u000a<div class="wp-block-woocommerce-checkout-order-summary-cart-items-block"></div>\u000a<!-- /wp:woocommerce/checkout-order-summary-cart-items-block -->\u000a\u000a<!-- wp:woocommerce/checkout-order-summary-coupon-form-block -->\u000a<div class="wp-block-woocommerce-checkout-order-summary-coupon-form-block"></div>\u000a<!-- /wp:woocommerce/checkout-order-summary-coupon-form-block -->\u000a\u000a<!-- wp:woocommerce/checkout-order-summary-subtotal-block -->\u000a<div class="wp-block-woocommerce-checkout-order-summary-subtotal-block"></div>\u000a<!-- /wp:woocommerce/checkout-order-summary-subtotal-block -->\u000a\u000a<!-- wp:woocommerce/checkout-order-summary-fee-block -->\u000a<div class="wp-block-woocommerce-checkout-order-summary-fee-block"></div>\u000a<!-- /wp:woocommerce/checkout-order-summary-fee-block -->\u000a\u000a<!-- wp:woocommerce/checkout-order-summary-discount-block -->\u000a<div class="wp-block-woocommerce-checkout-order-summary-discount-block"></div>\u000a<!-- /wp:woocommerce/checkout-order-summary-discount-block -->\u000a\u000a<!-- wp:woocommerce/checkout-order-summary-shipping-block -->\u000a<div class="wp-block-woocommerce-checkout-order-summary-shipping-block"></div>\u000a<!-- /wp:woocommerce/checkout-order-summary-shipping-block -->\u000a\u000a<!-- wp:woocommerce/checkout-order-summary-taxes-block -->\u000a<div class="wp-block-woocommerce-checkout-order-summary-taxes-block"></div>\u000a<!-- /wp:woocommerce/checkout-order-summary-taxes-block --></div>\u000a<!-- /wp:woocommerce/checkout-order-summary-block --></div>\u000a<!-- /wp:woocommerce/checkout-totals-block --></div>\u000a<!-- /wp:woocommerce/checkout -->'),'Checkout','','publish','closed','closed','','checkout','','','2026-05-27 18:06:44','2026-05-27 18:06:44','',0,'http://localhost:8080/?page_id=7',0,'page','',0);
INSERT INTO wp_posts VALUES(8,1,'2026-05-27 18:06:44','2026-05-27 18:06:44','<!-- wp:shortcode -->[woocommerce_my_account]<!-- /wp:shortcode -->','My account','','publish','closed','closed','','my-account','','','2026-05-27 18:06:44','2026-05-27 18:06:44','',0,'http://localhost:8080/?page_id=8',0,'page','',0);
INSERT INTO wp_posts VALUES(9,1,'2026-05-27 18:06:44','0000-00-00 00:00:00',unistr('<!-- wp:paragraph -->\u000a<p><b>This is a sample page.</b></p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Overview</h2>\u000a<!-- /wp:heading -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>Our refund and returns policy lasts 30 days. If 30 days have passed since your purchase, we can’t offer you a full refund or exchange.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>To be eligible for a return, your item must be unused and in the same condition that you received it. It must also be in the original packaging.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>Several types of goods are exempt from being returned. Perishable goods such as food, flowers, newspapers or magazines cannot be returned. We also do not accept products that are intimate or sanitary goods, hazardous materials, or flammable liquids or gases.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>Additional non-returnable items:</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:list -->\u000a<ul>\u000a<li>Gift cards</li>\u000a<li>Downloadable software products</li>\u000a<li>Some health and personal care items</li>\u000a</ul>\u000a<!-- /wp:list -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>To complete your return, we require a receipt or proof of purchase.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>Please do not send your purchase back to the manufacturer.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>There are certain situations where only partial refunds are granted:</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:list -->\u000a<ul>\u000a<li>Book with obvious signs of use</li>\u000a<li>CD, DVD, VHS tape, software, video game, cassette tape, or vinyl record that has been opened.</li>\u000a<li>Any item not in its original condition, is damaged or missing parts for reasons not due to our error.</li>\u000a<li>Any item that is returned more than 30 days after delivery</li>\u000a</ul>\u000a<!-- /wp:list -->\u000a\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Refunds</h2>\u000a<!-- /wp:heading -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>Once your return is received and inspected, we will send you an email to notify you that we have received your returned item. We will also notify you of the approval or rejection of your refund.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>If you are approved, then your refund will be processed, and a credit will automatically be applied to your credit card or original method of payment, within a certain amount of days.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:heading {"level":3} -->\u000a<h3 class="wp-block-heading">Late or missing refunds</h3>\u000a<!-- /wp:heading -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>If you haven’t received a refund yet, first check your bank account again.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>Then contact your credit card company, it may take some time before your refund is officially posted.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>Next contact your bank. There is often some processing time before a refund is posted.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>If you’ve done all of this and you still have not received your refund yet, please contact us at {email address}.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:heading {"level":3} -->\u000a<h3 class="wp-block-heading">Sale items</h3>\u000a<!-- /wp:heading -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>Only regular priced items may be refunded. Sale items cannot be refunded.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Exchanges</h2>\u000a<!-- /wp:heading -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>We only replace items if they are defective or damaged. If you need to exchange it for the same item, send us an email at {email address} and send your item to: {physical address}.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Gifts</h2>\u000a<!-- /wp:heading -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>If the item was marked as a gift when purchased and shipped directly to you, you’ll receive a gift credit for the value of your return. Once the returned item is received, a gift certificate will be mailed to you.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>If the item wasn’t marked as a gift when purchased, or the gift giver had the order shipped to themselves to give to you later, we will send a refund to the gift giver and they will find out about your return.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Shipping returns</h2>\u000a<!-- /wp:heading -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>To return your product, you should mail your product to: {physical address}.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>You will be responsible for paying for your own shipping costs for returning your item. Shipping costs are non-refundable. If you receive a refund, the cost of return shipping will be deducted from your refund.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>Depending on where you live, the time it may take for your exchanged product to reach you may vary.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>If you are returning more expensive items, you may consider using a trackable shipping service or purchasing shipping insurance. We don’t guarantee that we will receive your returned item.</p>\u000a<!-- /wp:paragraph -->\u000a\u000a<!-- wp:heading -->\u000a<h2 class="wp-block-heading">Need help?</h2>\u000a<!-- /wp:heading -->\u000a\u000a<!-- wp:paragraph -->\u000a<p>Contact us at {email} for questions related to refunds and returns.</p>\u000a<!-- /wp:paragraph -->'),'Refund and Returns Policy','','draft','closed','closed','','refund_returns','','','2026-05-27 18:06:44','0000-00-00 00:00:00','',0,'http://localhost:8080/?page_id=9',0,'page','',0);
CREATE TABLE `wp_actionscheduler_actions` (
`action_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`hook` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`status` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`scheduled_date_gmt` text DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`scheduled_date_local` text DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`priority` integer NOT NULL ON CONFLICT REPLACE DEFAULT '10',
`args` text COLLATE NOCASE,
`schedule` text COLLATE NOCASE,
`group_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`attempts` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`last_attempt_gmt` text DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`last_attempt_local` text DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`claim_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`extended_args` text DEFAULT NULL COLLATE NOCASE);
CREATE TABLE `wp_actionscheduler_claims` (
`claim_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`date_created_gmt` text DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE);
CREATE TABLE `wp_actionscheduler_groups` (
`group_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`slug` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE);
CREATE TABLE `wp_actionscheduler_logs` (
`log_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`action_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`message` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`log_date_gmt` text DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`log_date_local` text DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE);
CREATE TABLE `wp_woocommerce_sessions` (
`session_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`session_key` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`session_value` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`session_expiry` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0);
CREATE TABLE `wp_woocommerce_api_keys` (
`key_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`user_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`description` text COLLATE NOCASE,
`permissions` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`consumer_key` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`consumer_secret` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`nonces` text COLLATE NOCASE,
`truncated_key` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`last_access` text DEFAULT null COLLATE NOCASE);
CREATE TABLE `wp_woocommerce_attribute_taxonomies` (
`attribute_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`attribute_name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`attribute_label` text COLLATE NOCASE,
`attribute_type` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`attribute_orderby` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`attribute_public` integer NOT NULL ON CONFLICT REPLACE DEFAULT 1);
CREATE TABLE `wp_woocommerce_downloadable_product_permissions` (
`permission_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`download_id` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`product_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`order_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`order_key` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`user_email` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`user_id` integer,
`downloads_remaining` text COLLATE NOCASE,
`access_granted` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`access_expires` text DEFAULT null COLLATE NOCASE,
`download_count` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0);
CREATE TABLE `wp_woocommerce_order_items` (
`order_item_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`order_item_name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`order_item_type` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`order_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0);
CREATE TABLE `wp_woocommerce_order_itemmeta` (
`meta_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`order_item_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`meta_key` text DEFAULT NULL COLLATE NOCASE,
`meta_value` text COLLATE NOCASE);
CREATE TABLE `wp_woocommerce_tax_rates` (
`tax_rate_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`tax_rate_country` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`tax_rate_state` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`tax_rate` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`tax_rate_name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`tax_rate_priority` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`tax_rate_compound` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`tax_rate_shipping` integer NOT NULL ON CONFLICT REPLACE DEFAULT 1,
`tax_rate_order` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`tax_rate_class` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE);
CREATE TABLE `wp_woocommerce_tax_rate_locations` (
`location_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`location_code` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`tax_rate_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`location_type` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE);
CREATE TABLE `wp_woocommerce_shipping_zones` (
`zone_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`zone_name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`zone_order` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0);
CREATE TABLE `wp_woocommerce_shipping_zone_locations` (
`location_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`zone_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`location_code` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`location_type` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE);
CREATE TABLE `wp_woocommerce_shipping_zone_methods` (
`zone_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`instance_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`method_id` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`method_order` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`is_enabled` integer NOT NULL ON CONFLICT REPLACE DEFAULT '1');
CREATE TABLE `wp_woocommerce_payment_tokens` (
`token_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`gateway_id` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`token` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`user_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`type` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`is_default` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0');
CREATE TABLE `wp_woocommerce_payment_tokenmeta` (
`meta_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`payment_token_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`meta_key` text COLLATE NOCASE,
`meta_value` text COLLATE NOCASE);
CREATE TABLE `wp_woocommerce_log` (
`log_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`timestamp` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`level` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`source` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`message` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`context` text COLLATE NOCASE);
CREATE TABLE `wp_wc_webhooks` (
`webhook_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`status` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`user_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`delivery_url` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`secret` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`topic` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`date_created` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`date_created_gmt` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`date_modified` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`date_modified_gmt` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`api_version` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`failure_count` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0',
`pending_delivery` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0');
CREATE TABLE `wp_wc_download_log` (
`download_log_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`timestamp` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`permission_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`user_id` integer,
`user_ip_address` text DEFAULT '' COLLATE NOCASE);
CREATE TABLE `wp_wc_product_meta_lookup` (
`product_id` integer PRIMARY KEY  NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`sku` text DEFAULT '' COLLATE NOCASE,
`global_unique_id` text DEFAULT '' COLLATE NOCASE,
`virtual` integer DEFAULT 0,
`downloadable` integer DEFAULT 0,
`min_price` real DEFAULT NULL,
`max_price` real DEFAULT NULL,
`onsale` integer DEFAULT 0,
`stock_quantity` real DEFAULT NULL,
`stock_status` text DEFAULT 'instock' COLLATE NOCASE,
`rating_count` integer DEFAULT 0,
`average_rating` real DEFAULT 0.00,
`total_sales` integer DEFAULT 0,
`tax_status` text DEFAULT 'taxable' COLLATE NOCASE,
`tax_class` text DEFAULT '' COLLATE NOCASE);
CREATE TABLE `wp_wc_tax_rate_classes` (
`tax_rate_class_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`slug` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE);
INSERT INTO wp_wc_tax_rate_classes VALUES(1,'Reduced rate','reduced-rate');
INSERT INTO wp_wc_tax_rate_classes VALUES(2,'Zero rate','zero-rate');
CREATE TABLE `wp_wc_reserved_stock` (
`order_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`product_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`stock_quantity` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`timestamp` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`expires` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
PRIMARY KEY (`order_id`, `product_id`));
CREATE TABLE `wp_wc_rate_limits` (
`rate_limit_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`rate_limit_key` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`rate_limit_expiry` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`rate_limit_remaining` integer NOT NULL ON CONFLICT REPLACE DEFAULT '0');
CREATE TABLE `wp_wc_product_attributes_lookup` (
`product_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`product_or_parent_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`taxonomy` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`term_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`is_variation_attribute` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`in_stock` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
PRIMARY KEY (`product_or_parent_id`, `term_id`, `product_id`, `taxonomy`));
CREATE TABLE `wp_wc_product_download_directories` (
`url_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`url` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`enabled` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0);
INSERT INTO wp_wc_product_download_directories VALUES(1,'file:///var/www/html/public/packages/uploads/woocommerce_uploads/',1);
INSERT INTO wp_wc_product_download_directories VALUES(2,'http://localhost:8080/packages/uploads/woocommerce_uploads/',1);
CREATE TABLE `wp_wc_order_stats` (
`order_id` integer PRIMARY KEY  NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`parent_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`date_created` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`date_created_gmt` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`date_paid` text DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`date_completed` text DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`num_items_sold` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`total_sales` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`tax_total` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`shipping_total` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`net_total` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`returning_customer` integer DEFAULT NULL,
`status` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`customer_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0);
CREATE TABLE `wp_wc_order_product_lookup` (
`order_item_id` integer PRIMARY KEY  NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`order_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`product_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`variation_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`customer_id` integer,
`date_created` text NOT NULL ON CONFLICT REPLACE DEFAULT CURRENT_TIMESTAMP COLLATE NOCASE,
`product_qty` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`product_net_revenue` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`product_gross_revenue` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`coupon_amount` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`tax_amount` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`shipping_amount` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`shipping_tax_amount` real NOT NULL ON CONFLICT REPLACE DEFAULT 0);
CREATE TABLE `wp_wc_order_tax_lookup` (
`order_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`tax_rate_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`date_created` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`shipping_tax` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`order_tax` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`total_tax` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
PRIMARY KEY (`order_id`, `tax_rate_id`));
CREATE TABLE `wp_wc_order_coupon_lookup` (
`order_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`coupon_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`date_created` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`discount_amount` real NOT NULL ON CONFLICT REPLACE DEFAULT 0,
PRIMARY KEY (`order_id`, `coupon_id`));
CREATE TABLE `wp_wc_admin_notes` (
`note_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`type` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`locale` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`title` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`content` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`content_data` text DEFAULT null COLLATE NOCASE,
`status` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`source` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`date_created` text NOT NULL ON CONFLICT REPLACE DEFAULT '0000-00-00 00:00:00' COLLATE NOCASE,
`date_reminder` text DEFAULT null COLLATE NOCASE,
`is_snoozable` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`layout` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`image` text DEFAULT NULL COLLATE NOCASE,
`is_deleted` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`is_read` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`icon` text NOT NULL ON CONFLICT REPLACE DEFAULT 'info' COLLATE NOCASE);
CREATE TABLE `wp_wc_admin_note_actions` (
`action_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`note_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`label` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`query` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`status` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`actioned_text` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`nonce_action` text DEFAULT NULL COLLATE NOCASE,
`nonce_name` text DEFAULT NULL COLLATE NOCASE);
CREATE TABLE `wp_wc_customer_lookup` (
`customer_id` integer PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`user_id` integer DEFAULT NULL,
`username` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`first_name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`last_name` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`email` text DEFAULT NULL COLLATE NOCASE,
`date_last_active` text DEFAULT null COLLATE NOCASE,
`date_registered` text DEFAULT null COLLATE NOCASE,
`country` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`postcode` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`city` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE,
`state` text NOT NULL ON CONFLICT REPLACE DEFAULT '' COLLATE NOCASE);
CREATE TABLE `wp_wc_category_lookup` (
`category_tree_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`category_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
PRIMARY KEY (`category_tree_id`, `category_id`));
CREATE TABLE `wp_wc_orders` (
`id` integer PRIMARY KEY ,
`status` text COLLATE NOCASE,
`currency` text COLLATE NOCASE,
`type` text COLLATE NOCASE,
`tax_amount` real,
`total_amount` real,
`customer_id` integer,
`billing_email` text COLLATE NOCASE,
`date_created_gmt` text COLLATE NOCASE,
`date_updated_gmt` text COLLATE NOCASE,
`parent_order_id` integer,
`payment_method` text COLLATE NOCASE,
`payment_method_title` text COLLATE NOCASE,
`transaction_id` text COLLATE NOCASE,
`ip_address` text COLLATE NOCASE,
`user_agent` text COLLATE NOCASE,
`customer_note` text COLLATE NOCASE);
CREATE TABLE `wp_wc_order_addresses` (
`id` integer PRIMARY KEY AUTOINCREMENT,
`order_id` integer NOT NULL ON CONFLICT REPLACE DEFAULT 0,
`address_type` text COLLATE NOCASE,
`first_name` text COLLATE NOCASE,
`last_name` text COLLATE NOCASE,
`company` text COLLATE NOCASE,
`address_1` text COLLATE NOCASE,
`address_2` text COLLATE NOCASE,
`city` text COLLATE NOCASE,
`state` text COLLATE NOCASE,
`postcode` text COLLATE NOCASE,
`country` text COLLATE NOCASE,
`email` text COLLATE NOCASE,
`phone` text COLLATE NOCASE);
CREATE TABLE `wp_wc_order_operational_data` (
`id` integer PRIMARY KEY AUTOINCREMENT,
`order_id` integer,
`created_via` text COLLATE NOCASE,
`woocommerce_version` text COLLATE NOCASE,
`prices_include_tax` integer,
`coupon_usages_are_counted` integer,
`download_permission_granted` integer,
`cart_hash` text COLLATE NOCASE,
`new_order_email_sent` integer,
`order_key` text COLLATE NOCASE,
`order_stock_reduced` integer,
`date_paid_gmt` text COLLATE NOCASE,
`date_completed_gmt` text COLLATE NOCASE,
`shipping_tax_amount` real,
`shipping_total_amount` real,
`discount_tax_amount` real,
`discount_total_amount` real,
`recorded_sales` integer);
CREATE TABLE `wp_wc_orders_meta` (
`id` integer PRIMARY KEY AUTOINCREMENT,
`order_id` integer,
`meta_key` text COLLATE NOCASE,
`meta_value` text COLLATE NOCASE);
PRAGMA writable_schema=ON;
CREATE TABLE IF NOT EXISTS sqlite_sequence(name,seq);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('wp_users',1);
INSERT INTO sqlite_sequence VALUES('wp_usermeta',15);
INSERT INTO sqlite_sequence VALUES('wp_terms',15);
INSERT INTO sqlite_sequence VALUES('wp_term_taxonomy',15);
INSERT INTO sqlite_sequence VALUES('wp_comments',1);
INSERT INTO sqlite_sequence VALUES('wp_options',336);
INSERT INTO sqlite_sequence VALUES('wp_postmeta',4);
INSERT INTO sqlite_sequence VALUES('wp_posts',9);
INSERT INTO sqlite_sequence VALUES('wp_wc_tax_rate_classes',2);
INSERT INTO sqlite_sequence VALUES('wp_wc_product_download_directories',2);
PRAGMA writable_schema=OFF;
COMMIT;
