 with orders as (

    select * from {{ref('stg_orders')}}
),

payments as (

    select * from {{ref('stg_payments')}}

),

final as 
(
select 
payments.order_id,
orders.customer_id,
orders.order_date,
sum(payments.amount) as total_order_amount
from orders left join 
payments using (order_id)
where payments.status = 'success'
group by 1,2,3
)

select * from final