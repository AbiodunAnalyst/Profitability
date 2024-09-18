CREATE MATERIALIZED VIEW sales_channel
AS
SELECT
	am_df."Date",
	am_df."ship-city",
	am_df."Category",
	am_df."Sales_Channel",
	COUNT(am_df."Qty") AS Total_Quantity,
	SUM(am_df."Amount") AS Total_Amount
FROM
	public.am_df
GROUP BY am_df."Date", am_df."ship-city", am_df."Category", am_df."Sales_Channel"
ORDER BY Total_Amount DESC NULLS LAST;

--SELECT * FROM public.sales_channel

--REFRESH MATERIALIZED VIEW sales_channel


-------------------------------------------------------------
CREATE MATERIALIZED VIEW product_volume
AS
SELECT
	am_df."Date",
	am_df."Fulfilment",
	am_df."Size",
	am_df."Category",
	COUNT(am_df."Qty") AS Total_Quantity,
	SUM(am_df."Amount") AS Total_Amount
FROM
	public.am_df
GROUP BY am_df."Date", am_df."Fulfilment", am_df."Category", am_df."Size"
ORDER BY Total_Amount DESC

SELECT * FROM public.product_volume

--REFRESH MATERIALIZED VIEW product_volume
	
---------------------------------------------------
CREATE MATERIALIZED VIEW B2B_P
AS
SELECT
	am_df."Date",
	am_df."B2B",
	am_df."Category",
	am_df."ship-state",
	COUNT(am_df."Qty") AS Total_Quantity,
	SUM(am_df."Amount") AS Total_Amount
FROM
	public.am_df
GROUP BY am_df."Date", am_df."B2B", am_df."Category", am_df."ship-state"
ORDER BY Total_Amount DESC NULLS LAST

--SELECT * FROM public.B2B_P

--REFRESH MATERIALIZED VIEW B2B_P
	
------------------------------------------------------

CREATE MATERIALIZED VIEW cancellation
AS
SELECT
	am_df."Date",
	am_df."Fulfilment",
	am_df."Category",
	COUNT(am_df."Qty") AS Total_Quantity
	SUM(am_df."Amount") AS Total_Amount
FROM
	public.am_df
WHERE am_df."Status" = 'Cancelled'
GROUP BY am_df."Date", am_df."Fulfilment", am_df."Category"
ORDER BY Total_Quantity DESC

--SELECT * FROM public.cancellation

--REFRESH MATERIALIZED VIEW cancellation


------------------------------------------------------
CREATE MATERIALIZED VIEW fulfillment
AS
SELECT
	am_df."Date",
	am_df."Fulfilment",
	am_df."ship-state",
	COUNT(am_df."Qty") AS Total_Quantity,
	SUM(am_df."Amount") AS Total_Amount
FROM
	public.am_df
GROUP BY am_df."Date", am_df."Fulfilment", am_df."ship-state"
ORDER BY Total_Amount DESC

--SELECT * FROM public.fulfillment

--REFRESH MATERIALIZED VIEW fulfillment


SELECT * FROM public.am_df LIMIT 10

