
{{
  config(
    materialized='view'
  )
}}

WITH src_order_items AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'order_items') }}
    ),

renamed_casted AS (
    SELECT
        product_id
        , price
        , name
        , inventory
        ,  _fivetran_deleted  
        , _fivetran_synced AS date_load
    FROM src_order_items   )

SELECT * FROM renamed_casted