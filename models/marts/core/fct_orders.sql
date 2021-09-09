with orders as  (
    select * from DEMO_DB.dbt_smuzammil.stg_orders
),

payments as (
    select * from DEMO_DB.dbt_smuzammil.stg_payments
),

order_payments as (
    select
        ORDER_ID AS id,
        sum(case when status = 'success' then amount end) as amount

    from DEMO_DB.dbt_smuzammil.stg_payments
    group by 1
),

final as (

    select
        orders.ID,
        orders.USER_ID,
        orders.order_date,
        coalesce(order_payments.amount, 0) as amount

    from orders
    left join order_payments using(ID)
)

select * from final
limit 500
/* limit added automatically by dbt cloud */