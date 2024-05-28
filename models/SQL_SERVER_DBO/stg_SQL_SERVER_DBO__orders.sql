
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
        order_id
        , SHIPPING_SERVICE
        , SHIPPING_COST
        , ADDRESS_ID
        , CREATED_AT    
        , PROMO_ID
        , ESTIMATED_DELIVERY_AT
        , ORDER_COST
        , USER_ID 
        , ORDER_TOTAL   
        , DELIVERED_AT
        , TRACKING_ID
        ,   STATUS  
        ,  _fivetran_deleted  
        , _fivetran_synced AS date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted