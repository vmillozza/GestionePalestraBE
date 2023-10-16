const express = require('express');
const Iscritto = require('../models/iscritti');

const router = express.Router();
// Ottieni tutti gli iscritti



router.get('/', async (req, res, next) => {
    try {
       
        let iscritti = await Iscritto.getAll();
       
        iscritti = iscritti.filter(iscritto => iscritto.is_deleted === 0);
        console.log('iscritti ', iscritti);
        res.render("iscritti", { iscritti });
    } catch (error) {
        console.error(error); // Stampa l'errore in console
        res.status(500).send('Errore del server');
        next(error); // Qui abbiamo sostituito "err" con "error"
    }
});

// Ottieni un singolo iscritto per ID
router.get('/:id', async (req, res) => {
    try {
        const iscritto = await Iscritto.getById(req.params.id);
        if (iscritto) {
            res.json(iscritto);
        } else {
            res.status(404).send('Iscritto non trovato');
        }
    } catch (error) {
        res.status(500).send('Errore del server');
    }
});

// Aggiungi un nuovo iscritto
router.post('/', async (req, res) => {
    try {
        const id = await Iscritto.add(req.body.nome, req.body.cognome, req.body.indirizzo, req.body.data_nascita, req.body.password);
        res.status(201).json({ id });
    } catch (error) {
        res.status(500).send('Errore del server');
    }
});

// Aggiorna un iscritto esistente
router.put('/:id', async (req, res) => {
    try {
        await Iscritto.update(req.params.id, req.body.nome, req.body.cognome, req.body.indirizzo, req.body.data_nascita, req.body.password);
        res.status(200).send('Iscritto aggiornato con successo');
    } catch (error) {
        res.status(500).send('Errore del server');
    }
});
router.get('/api/formiscritto', async (req, res) => {
    try {
        const iscritto = await Iscritto.getById(req.params.id);
        if (iscritto) {
            res.render("modifica-iscritti", { iscritto });
        } else {
            res.status(404).send('Iscritto non trovato');
        }
    } catch (error) {
        res.status(500).send('Errore del server');
    }
});
// Elimina un iscritto
router.put('/api/deleteiscritto', async (req, res) => {
    try {
        const id = req.query.id;
        await Iscritto.delete(id);
        
        res.status(200).send('iscritto cancellato correttamente');
    } catch (error) {
        res.status(500).send('Errore del server');
    }
});

module.exports = router;
