
{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'events') }}
    ),

renamed_casted AS (
    SELECT
        event_id
       , page_url
       , event_type
       , USER_ID
       ,case 
            when  product_id=' 'then md5('product_empty')
            else product_id
       , session_id
       , CREATED_AT
       , case 
             when order_id =' 'then md5('order_empty')
             else order_id
       , _fivetran_deleted
       , _fivetran_synced AS date_load
    FROM src_events
    )

SELECT * FROM renamed_casted