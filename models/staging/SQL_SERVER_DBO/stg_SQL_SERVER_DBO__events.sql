
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
       , product_id
       , session_id
       , CREATED_AT
       , order_id
       , _fivetran_deleted
       , _fivetran_synced AS date_load
    FROM src_events
    )

SELECT * FROM renamed_casted