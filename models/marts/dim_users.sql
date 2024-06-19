with 

source as (
    select * from {{ ref('stg_SQL_SERVER_DBO__users') }}
),

renamed as (
    select
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        address_id,
        created_at,
        updated_at,
        total_orders,
        _fivetran_deleted,
        date_load
    from source
)

select * from renamed