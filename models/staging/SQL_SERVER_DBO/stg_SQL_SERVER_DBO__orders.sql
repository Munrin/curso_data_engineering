
{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'orders') }}
    ),

renamed_casted AS (
    SELECT
        order_id,
         IFF (SHIPPING_SERVICE = '',md5('without_shipping_service'),md5(SHIPPING_SERVICE)) as shipping_service_id,
         SHIPPING_COST as shipping_cost_dollar,
         ADDRESS_ID,
         --CREAted_at,
         convert_timezone('UTC',to_timestamp_tz(created_at))  as created_at_utc ,
         iff(PROMO_ID = ' ',md5('without_promo'),md5(promo_id))as promo_id ,
         ESTIMATED_DELIVERY_AT,
         ORDER_COST as order_cost_dollar,
         USER_ID ,
         ORDER_TOTAL as order_total_dollar,   
         DELIVERED_AT,
         --iff (TRACKING_ID = ' ',NULL,tracking_id)as tracking_id,
          case when tracking_id=' ' then NULL
          else tracking_id
          end tracking_id,
          md5 (STATUS) as order_status_id ,
          _fivetran_deleted  ,
         _fivetran_synced AS date_load
    FROM src_orders
    union all

    SELECT 
       md5 ('order_empty'),
       md5('without_shipping_service'),
       0,
       null,
       null,
       md5('without_promo'),
       null,
       0,
       null,
       null,
       null,
       null,
       md5('preparing'),
       null,
       null 
    )

SELECT * FROM renamed_casted