with 

source as (

select * from {{ source('SQL_SERVER_DBO', 'promos') }}
),

renamed as (

select
 md5(promo_id) as promo_id
,promo_id as promo_name
from source
union all
    select
     md5('sin_promo') as promo_id
    ,'sin_promo' as promo_name

)

select * from renamed 

