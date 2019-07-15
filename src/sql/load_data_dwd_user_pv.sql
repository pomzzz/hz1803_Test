--qfbap_ods.ods_code_category to qfbap_dwd.dwd_code_category
INSERT into
qfbap_dwd.dwd_code_category
select
first_category_id,
first_category_name,
second_category_id,
second_catery_name,
third_category_id,
third_category_name,
category_id,
CURRENT_TIMESTAMP dw_date
from qfbap_ods.ods_code_category;
--qfbap_ods.ods_user to qfbap_dwd.dwd_user
INSERT INTO
qfbap_dwd.dwd_user
SELECT
user_id,
user_name,
user_gender,
user_birthday,
user_age,
constellation,
province,
city,
city_level,
e_mail,
op_mail,
mobile,
num_seg_mobile,
op_Mobile,
register_time,
login_ip,
login_source,
request_user,
total_score,
used_score,
is_blacklist,
is_married,
education,
monthly_income,
profession,
create_date
FROM qfbap_ods.ods_user;
--qfbap_ods.ods_user_addr to qfbap_dwd.dwd_user_addr
INSERT INTO
qfbap_dwd.dwd_user_addr
SELECT
user_id,
order_addr,
user_order_flag,
addr_id,
arear_id,
CURRENT_TIMESTAMP dw_date
FROM qfbap_ods.ods_user_addr;
--qfbap_ods.ods_user_extend to qfbap_dwd.dwd_user_extend
INSERT INTO
qfbap_dwd.dwd_user_extend
SELECT
user_id,
user_gender,
is_pregnant_woman,
is_have_children,
is_have_car,
phone_brand,
phone_brand_level,
phone_cnt,
change_phone_cnt,
is_maja,
majia_account_cnt,
loyal_model,
shopping_type_model,
weight,
height,
CURRENT_TIMESTAMP dw_date
FROM qfbap_ods.ods_user_extend;
--qfbap_ods.ods_biz_trade to qfbap_dwd.dwd_biz_trade
set hive.exec.dynamic.partition.mode=nonstrict;
insert into table qfbap_dwd.dwd_biz_trade
partition (dt)
select
trade_id,
order_id,
user_id,
amount,
trade_type,
trade_time,
CURRENT_TIMESTAMP dw_date,
dt
FROM qfbap_ods.ods_biz_trade;
--qfbap_ods.ods_cart to qfbap_dwd.dwd_cart
set hive.exec.dynamic.partition.mode=nonstrict;
INSERT INTO qfbap_dwd.dwd_cart
partition (dt)
SELECT
cart_id,
session_id,
user_id,
goods_id,
goods_num,
add_time,
cancle_time,
sumbit_time,
create_date,
CURRENT_TIMESTAMP dw_date,
dt
FROM qfbap_ods.ods_cart;
--qfbap_ods.ods_order_delivery to qfbap_dwd.dwd_order_delivery
set hive.exec.dynamic.partition.mode=nonstrict;
INSERT INTO qfbap_dwd.dwd_order_delivery
partition (dt)
SELECT
order_id,
order_no,
consignee,
area_id,
area_name,
address,
mobile,
phone,
coupon_id,
coupon_money,
carriage_money,
create_time,
update_time,
addr_id,
CURRENT_TIMESTAMP dw_date,
dt
FROM qfbap_ods.ods_order_delivery;
--qfbap_ods.ods_order_item to qfbap_dwd.dwd_order_item
set hive.exec.dynamic.partition.mode=nonstrict;
insert into qfbap_dwd.dwd_order_item
partition (dt)
select
user_id,
order_id,
order_no,
goods_id,
goods_no,
goods_name,
goods_amount,
shop_id,
shop_name,
curr_price,
market_price,
discount,
cost_price,
first_cart,
first_cart_name,
second_cart,
second_cart_name,
third_cart,
third_cart_name,
goods_desc,
CURRENT_TIMESTAMP dw_date,
dt
from qfbap_ods.ods_order_item;
--qfbap_ods.ods_us_order to qfbap_dwd.dwd_us_order
set hive.exec.dynamic.partition.mode=nonstrict;
insert into qfbap_dwd.dwd_us_order
partition (dt)
select
order_id,
order_no,
order_date,
user_id,
user_name,
order_money,
order_type,
order_status,
pay_status,
pay_type,
order_source,
update_time,
CURRENT_TIMESTAMP dw_date,
dt
FROM qfbap_ods.ods_us_order;
--qfbap_ods.ods_user_app_click_log to qfbap_dwd.dwd_user_app_pv
set hive.exec.dynamic.partition.mode=nonstrict;
insert into qfbap_dwd.dwd_user_app_pv
partition (dt)
select
log_id,
user_id,
imei,
log_time,
hour(log_time) log_hour,
visit_os,
os_version,
app_name,
app_version,
device_token,
visit_ip,
province,
city,
CURRENT_TIMESTAMP dw_date,
dt
from qfbap_ods.ods_user_app_click_log;
--qfbap_ods.ods_user_pc_click_log to qfbap_dwd.dwd_user_pc_pv
set hive.exec.dynamic.partition.mode=nonstrict;
INSERT INTO qfbap_dwd.dwd_user_pc_pv
partition (dt)
select
max(log_id),
user_id,
session_id,
cookie_id,
min(visit_time) in_time,
max(visit_time) out_time,
case when min(visit_time) = max(visit_time) then 3 else (max(visit_time ) - min(visit_time)) END stay_time,
count(1) pv,
visit_os,
browser_name,
visit_ip,
province,
city,
current_timestamp() dw_date,
dt
FROM qfbap_ods.ods_user_pc_click_log
GROUP BY user_id,session_id,cookie_id,visit_os,browser_name,visit_ip,province,city,dt;