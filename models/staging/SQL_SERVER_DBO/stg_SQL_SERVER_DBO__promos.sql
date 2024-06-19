
{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'promos') }}
    ),

renamed_casted AS (
    SELECT
      md5 (promo_id) as promo_id,
      promo_id as nombre_promo
       , discount as discount_dollar
       , md5(status) as promo_id_status
       , _fivetran_deleted
       , _fivetran_synced AS date_load
    FROM src_promos

    union all
      
    select 
        md5('without_promo'),
        'without_promo',
        0,
        md5('inactive'),
        null,
        null
)


SELECT * FROM renamed_casted