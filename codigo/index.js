/*
IMPORTS
*/
const express = require('express');
const sql = require('mssql');
require('dotenv').config();


/*
CONSTANTES DE API
*/
const app = express();
const PORT = 3000;


/*
CONFIGURACIÓN DE CONEXIÓN AL SERVIDOR SQL
*/
const sqlConfig = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    database: process.env.DB_DATABASE,
    options: {
        encrypt: false,
        trustServerCertificate: true
    }
};

sql.connect(sqlConfig)
    .then(() => {
        console.log('COnectado a SQL Server');

    })
    .catch((error) => {
        console.error('Error:', error)
    });


/*
ENDPOINTS
*/
app.use(express.json());

//Consulta todos los productos con JOIN
app.get('/products', async(req, res) => {

    try {
        const result = await sql.query('EXEC sp_ProductGetAll');
        res.json(result.recordset);
    } catch(error) {
        console.error(error);
        res.status(500).json({error: 'Error al obtener productos'})
    }
    
});

//Consulta productos por id
app.get('/products/:id', async(req, res) => {

    try {
        const productID = req.params.id; //Permite tomar los parámetros del servidor

        const result = await sql.query(`EXEC sp_ProductGetByID ${productID}`);
        res.json(result.recordset);
    } catch(error) {
        console.error(error);
        res.status(500).json({error: 'Error al obtener el producto'})
    }

});

//Consulta todas las ordenes de compra
app.get('/sales-orders', async(req, res) => {

    try {
        const result = await sql.query('EXEC sp_SalesOrderGetAll')
        res.json(result.recordset);
    } catch(error) {
        console.error(error);
        res.status(500).json({error: 'Error al obtener las ordenes de venta'})
    }

});

//Crea un nuevo producto
app.post('/products', async(req, res) => {

    try {
        const {Name, ProductNumber, Color, SafetyStockLevel, ReorderPoint, StandardCost, 
            ListPrice, Size, DaysToManufacture, SellStartDate } = req.body;

        const result = await sql.query(`EXEC sp_CreateProduct ${Name}, ${ProductNumber}, ${Color}, ${SafetyStockLevel},
                                        ${ReorderPoint}, ${StandardCost}, ${ListPrice}, ${Size}, ${DaysToManufacture},${SellStartDate}`);

        res.status(201).json({message: 'Producto creado correctamente'});
    } catch (error) {
        console.error(error);
        res.status(500).json({error: 'Error al insertar producto'});
    }

});

//Actualiza la información de un producto por id
app.put('/products/:id', async(req, res) => {

    try {
        const productID = req.params.id;

        const {Color, StandardCost, ListPrice, Size, DaysToManufacture} = req.body;

        const result = await sql.query(`EXEC sp_UpdateProduct ${productID}, ${Color}, 
                                        ${StandardCost}, ${ListPrice}, ${Size}, ${DaysToManufacture}`);
        res.json({message: 'Producto actualizado correctamente'}); 
    } catch(error) {
        console.error(error);
        res.status(500).json({error: 'Error al actualizar producto'})
    }

});

//Elimina un producto por id
app.delete('/products/:id', async(req, res) => {

    try {
        const productID = req.params.id;

        const result = await sql.query(`EXEC sp_DeleteProduct ${productID}`);
        res.json({message: 'Producto eliminado correctamente'});
    } catch(error) {
        console.error(error);
        res.status(500).json({error: 'Error al eliminar producto'})
    }

});

/* 
EJECUCIÓN
*/
app.listen(PORT, () => {
    console.log(`Servidor ejecutandose en localhost: ${PORT}`)
});

