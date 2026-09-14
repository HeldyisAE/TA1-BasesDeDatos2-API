const express = require('express');
const sql = require('mssql');
require('dotenv').config();

const app = express();
const PORT = 3000;

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
    })

app.listen(PORT, () => {
    console.log(`Servidor ejecutandose en localhost: ${PORT}`)
});

