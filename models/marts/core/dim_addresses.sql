with 

source as (

    select * from {{ ref('stg_SQL_SERVER_DBO__addresses') }}

),

renamed as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted,
        date_load

    from source

)

select * from renamed