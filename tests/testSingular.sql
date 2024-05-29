SELECT *
FROM {{ ref('stg_SQL_SERVER_DBO__orders') }}
WHERE DELIVERED_AT < CREATED_AT
/* comprueba si hay algún caso en el que la fecha de entrega sea anterior a la fecha en que se realizó el pedido, lo que no tendría sentido lógico e indicaría algún tipo de problema con los datos */