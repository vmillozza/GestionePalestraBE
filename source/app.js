const express = require('express');
const iscrittiRouter = require('../routes/iscrittiRoutes');
const path = require('path');
const app = express();
const cors = require('cors');

// Abilita la protezione CSRF
//const csrfProtection = csrf({ cookie: false });
//app.use(csrfProtection);
// Middleware per parsare il JSON nelle richieste POST
app.use(express.json());
app.use(cors());
// Monta il router
app.set('view engine', 'pug');
app.set('views', path.join(__dirname, '../views'));
app.use('/', iscrittiRouter);
// Gestisci errori CSRF
app.use((err, req, res, next) => {
    if (err.code !== 'EBADCSRFTOKEN') return next(err);
    res.status(403).send('Sessione CSRF non valida.');
  });
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
