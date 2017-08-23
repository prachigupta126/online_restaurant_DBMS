-------Report 1 ; This gives a daily overview of how the restaurant is doing using overall metrics

select c.order_date "Day",orders_num "Number of Orders", abv "Average Bill Value" ,FoodSales "Food Sales", 
nonAlcoholic_Sales "Non-alcoholic drink Sales",Alcoholic_sales "Alcoholic drink Sales",net_sales "Net Sales"  
    from 
        --Aggregate in order to show Net Sales and Avg Value per Meal 
        (select count(order_id) as orders_num,round(avg(Billamount),2) abv,round(sum(Billamount),2) net_sales,order_date 
        from 
                    --Here we find the bill amount per order 
                    (select ol.order_id,trunc(billingtime) order_date ,sum(m.price*ol.quantity) as Billamount 
                    from 
                    Orderline ol join Menu m 
                    on (m.item_no=ol.item_no) join  Orders o 
                    on (o.order_id=ol.order_id)
                    group by ol.order_id,trunc(billingtime) ) b 
        group by order_date)c
FULL OUTER JOIN
        --convert category sales from row to columns to display in the report
        (select coalesce(sum(case when category_type='Food' then cat_sales end),0) FoodSales, 
            coalesce(sum(case when category_type='Non-Alcoholic' then cat_sales end),0) nonAlcoholic_Sales,
            coalesce(sum(case when category_type='Alcoholic' then cat_sales end),0) Alcoholic_Sales,order_date
            from
              --Sum category level sales to see how the restaurant is doing in each individual category
                (select category_type,order_date ,round(sum(Billamount),2)as cat_sales  
                from 
                        (select ol.order_id,trunc(billingtime) order_date ,m.category_type,sum(m.price*ol.quantity) as Billamount 
                        from 
                        Orderline ol join Menu m on (m.item_no=ol.item_no) 
                        join  Orders o on (o.order_id=ol.order_id)
                        group by ol.order_id,trunc(billingtime),m.category_type ) i
                group by category_type,order_date)
                group by order_date)d 
on c.order_date = d.order_date
order by c.order_date; 

-----------------Report 2 ; This gives the item sales per day and the discount offered that day

select m.item_name "Item",trunc(billingtime) "Day",m.price "Price",m.discount "Discount",sum(ol.quantity) as "Quantity ordered" 
from 
        Orderline ol join Menu m on (m.item_no=ol.item_no) 
        join  Orders o on (o.order_id=ol.order_id)
group by m.item_name,trunc(billingtime), m.price, m.discount
order by trunc(billingtime);
 --having trunc(billingtime) = '12-DEC-17'; Add this line to get menu item sales for a specific day


