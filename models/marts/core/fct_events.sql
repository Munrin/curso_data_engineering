with 

source as (

    select * from {{ ref('stg_SQL_SERVER_DBO__events') }}

),

renamed as (

    select
        event_id,
        page_url,
        event_type,
        user_id,
        product_id,
        session_id,
        created_at,
        order_id,
        _fivetran_deleted,
        date_load
    from source

)

select * from renamed