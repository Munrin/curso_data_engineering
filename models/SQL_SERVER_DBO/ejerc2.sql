

 with 

source as (

select * from {{ source('SQL_SERVER_DBO', 'orders') }}
),

renamed as (

 SELECT REPLACE(promo_id, '', 'sin_promo') FROM source
)

select * from renamed 