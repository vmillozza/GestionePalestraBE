-- Insert into `messaggi`
INSERT INTO messaggi(ID_Messaggio, ID_Mittente, ID_Destinatario, Testo_Messaggio) 
VALUES (1, 1, 2, 'Ciao! Come stai?');

-- Insert into `istruttori`
INSERT INTO istruttori(ID_Istruttore, Nome, Cognome, Email, Telefono) 
VALUES (1, 'Mario', 'Rossi', 'mario.rossi@example.com', '+391234567890');

-- Insert into `iscritti`
INSERT INTO iscritti(Nome, Cognome, Email, DataIscrizione, DataUltimoPagamento, ImportoUltimoPagamento) 
VALUES ('Luca', 'Bianchi', 'luca.bianchi@example.com', '2023-10-03', '2023-10-03', 100.00);

-- Insert into `profili`
INSERT INTO profili(IscrittoID, Indirizzo, Città, CAP, NumeroTelefono, DataDiNascita, FotoProfilo) 
VALUES (1, 'Via Roma, 10', 'Milano', '20100', '+391234567891', '1990-01-01', 'path/to/photo.jpg');

-- Insert into `pagamenti`
INSERT INTO pagamenti(ID_Pagamento, ID_Iscritto, Data_Pagamento, Importo) 
VALUES (1, 1, '2023-10-03', 100.00);

-- Insert into `notifiche`
INSERT INTO notifiche(ID_Notifica, ID_Iscritto, Tipo_Notifica, Messaggio, Stato_Notifica) 
VALUES (1, 1, 'Pagamento', 'Pagamento ricevuto. Grazie!', 'Letto');

-- Insert into `classi`
INSERT INTO classi(Nome, Descrizione, DataOra, Durata, PostiTotali) 
VALUES ('Yoga', 'Classe di yoga base', '2023-10-10 10:00:00', 60, 20);

-- Insert into `presenze`
INSERT INTO presenze(ID_Presenza, ID_Iscritto, ID_Classe, Data_Presenza) 
VALUES (1, 1, 1, '2023-10-10');

-- Insert into `prenotazioni`
INSERT INTO prenotazioni(IscrittoID, ClasseID, DataOraPrenotazione) 
VALUES (1, 1, '2023-10-03 11:00:00');

-- Insert into `assegnazioni`
INSERT INTO assegnazioni(ID_Classe, ID_Istruttore) 
VALUES (1, 1);

-- Insert into `sala`
INSERT INTO sala(ID_Sala, Nome_Sala, Capacita, Descrizione) 
VALUES (1, 'Sala Yoga', 20, 'Sala dedicata alle lezioni di yoga');

-- Insert into `prenotazioni_sale`
INSERT INTO prenotazioni_sale(ID_Prenotazione, ID_Sala, Data_Ora_Inizio, Data_Ora_Fine) 
VALUES (1, 1, '2023-10-10 10:00:00', '2023-10-10 11:00:00');

-- Insert into `attrezzature`
INSERT INTO attrezzature(ID_Attrezzatura, Nome, Quantita, Data_Acquisto, Id_sala) 
VALUES (1, 'Materassino', 20, '2023-01-01', 1);
