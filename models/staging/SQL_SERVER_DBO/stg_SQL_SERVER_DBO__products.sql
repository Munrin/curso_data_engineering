
{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'products') }}
    ),

renamed_casted AS (
    SELECT
        product_id
        , price as price_dollar
        , name
        , inventory
        ,  _fivetran_deleted  
        , _fivetran_synced AS date_load
    FROM src_products   
    union all
    select 
        md5('product_empty'),
        0,
        'product_empty',
        0,
        null,
        null
)

SELECT * FROM renamed_casted