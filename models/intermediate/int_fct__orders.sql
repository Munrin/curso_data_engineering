with 

source_orders as (
    select * from {{ ref('stg_SQL_SERVER_DBO__orders') }}
),

source_order_items as (
   select * from {{ ref('stg_SQL_SERVER_DBO__order_items') }}
  ),

source_products as (
    select * from {{ ref('stg_SQL_SERVER_DBO__products') }}
),

source_promos as (
    select * from {{ ref('stg_SQL_SERVER_DBO__promos') }}
),

fct_orders as (
    select
        so.order_id,
        so_i.product_id,
        so_i.quantity_product,
        (sp.price_dollar*so_i.quantity_product) as price_per_quantity_of_products,
        so.shipping_service_id,
        so.shipping_cost_dollar,
        so.promo_id,
        spr.discount_dollar,
        so.order_cost_dollar,
        so.order_total_dollar, 
        so.user_id,
        so.address_id,
        so.created_at_utc,
        so.estimated_delivery_at,
        so.delivered_at,
        so.tracking_id,
        so.order_status_id
    from source_orders so
    join source_order_items so_i
    on so.order_id = so_i.order_id
    join source_products sp
    on so_i.product_id = sp.product_id
    join source_promos spr
    on so.promo_id = spr.promo_id
    order by order_id
)

select * from fct_orders