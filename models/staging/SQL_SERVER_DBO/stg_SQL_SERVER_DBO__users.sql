
{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'users') }}
    ),

renamed_casted AS (
    SELECT
        user_id
        , updated_at
        , ADDRESS_ID
        , last_name
        , CREATED_AT    
        , phone_number
        , total_orders
        , first_name
        , email 
        ,  _fivetran_deleted  
        , _fivetran_synced AS date_load
    FROM src_users
    )

SELECT * FROM renamed_casted