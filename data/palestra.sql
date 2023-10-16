-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

--
-- Set default database
--
USE palestra;

--
-- Create table `messaggi`
--
CREATE TABLE messaggi (
  ID_Messaggio int(11) NOT NULL,
  ID_Mittente int(11) DEFAULT NULL,
  ID_Destinatario int(11) DEFAULT NULL,
  Testo_Messaggio text DEFAULT NULL,
  Data_Messaggio timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (ID_Messaggio)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `istruttori`
--
CREATE TABLE istruttori (
  ID_Istruttore int(11) NOT NULL,
  Nome varchar(255) DEFAULT NULL,
  Cognome varchar(255) DEFAULT NULL,
  Email varchar(255) DEFAULT NULL,
  Telefono varchar(15) DEFAULT NULL,
  Id_messaggio int(11) DEFAULT NULL,
  PRIMARY KEY (ID_Istruttore)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE istruttori
ADD CONSTRAINT FK_istruttori_messaggi_ID_Messaggio FOREIGN KEY (Id_messaggio)
REFERENCES messaggi (ID_Messaggio) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `iscritti`
--
CREATE TABLE iscritti (
  ID int(11) NOT NULL AUTO_INCREMENT,
  Nome varchar(255) DEFAULT NULL,
  Cognome varchar(255) DEFAULT NULL,
  Email varchar(255) DEFAULT NULL,
  DataIscrizione date DEFAULT NULL,
  DataUltimoPagamento date DEFAULT NULL,
  ImportoUltimoPagamento decimal(10, 2) DEFAULT NULL,
  Id_messaggio int(11) DEFAULT NULL,
  PRIMARY KEY (ID)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create index `Email` on table `iscritti`
--
ALTER TABLE iscritti
ADD UNIQUE INDEX Email (Email);

--
-- Create foreign key
--
ALTER TABLE iscritti
ADD CONSTRAINT FK_iscritti_messaggi_ID_Messaggio FOREIGN KEY (Id_messaggio)
REFERENCES messaggi (ID_Messaggio) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `profili`
--
CREATE TABLE profili (
  ID int(11) NOT NULL AUTO_INCREMENT,
  IscrittoID int(11) DEFAULT NULL,
  Indirizzo varchar(255) DEFAULT NULL,
  Città varchar(255) DEFAULT NULL,
  CAP varchar(10) DEFAULT NULL,
  NumeroTelefono varchar(15) DEFAULT NULL,
  DataDiNascita date DEFAULT NULL,
  FotoProfilo varchar(255) DEFAULT NULL,
  PRIMARY KEY (ID)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE profili
ADD CONSTRAINT profili_ibfk_1 FOREIGN KEY (IscrittoID)
REFERENCES iscritti (ID);

--
-- Create table `pagamenti`
--
CREATE TABLE pagamenti (
  ID_Pagamento int(11) NOT NULL,
  ID_Iscritto int(11) DEFAULT NULL,
  Data_Pagamento date DEFAULT NULL,
  Importo decimal(10, 2) DEFAULT NULL,
  PRIMARY KEY (ID_Pagamento)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE pagamenti
ADD CONSTRAINT FK_pagamenti_iscritti_ID FOREIGN KEY (ID_Iscritto)
REFERENCES iscritti (ID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `notifiche`
--
CREATE TABLE notifiche (
  ID_Notifica int(11) NOT NULL,
  ID_Iscritto int(11) DEFAULT NULL,
  Tipo_Notifica varchar(255) DEFAULT NULL,
  Messaggio text DEFAULT NULL,
  Data_Notifica timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  Stato_Notifica varchar(255) DEFAULT NULL,
  PRIMARY KEY (ID_Notifica)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE notifiche
ADD CONSTRAINT FK_notifiche_iscritti_ID FOREIGN KEY (ID_Iscritto)
REFERENCES iscritti (ID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `classi`
--
CREATE TABLE classi (
  ID int(11) NOT NULL AUTO_INCREMENT,
  Nome varchar(255) DEFAULT NULL,
  Descrizione text DEFAULT NULL,
  DataOra datetime DEFAULT NULL,
  Durata int(11) DEFAULT NULL,
  PostiTotali int(11) DEFAULT NULL,
  PRIMARY KEY (ID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `presenze`
--
CREATE TABLE presenze (
  ID_Presenza int(11) NOT NULL,
  ID_Iscritto int(11) DEFAULT NULL,
  ID_Classe int(11) DEFAULT NULL,
  Data_Presenza date DEFAULT NULL,
  PRIMARY KEY (ID_Presenza)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE presenze
ADD CONSTRAINT FK_presenze_classi_ID FOREIGN KEY (ID_Classe)
REFERENCES classi (ID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE presenze
ADD CONSTRAINT FK_presenze_iscritti_ID FOREIGN KEY (ID_Iscritto)
REFERENCES iscritti (ID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `prenotazioni`
--
CREATE TABLE prenotazioni (
  ID int(11) NOT NULL AUTO_INCREMENT,
  IscrittoID int(11) DEFAULT NULL,
  ClasseID int(11) DEFAULT NULL,
  DataOraPrenotazione datetime DEFAULT NULL,
  PRIMARY KEY (ID)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create index `FK_prenotazioni` on table `prenotazioni`
--
ALTER TABLE prenotazioni
ADD INDEX FK_prenotazioni (IscrittoID);

--
-- Create foreign key
--
ALTER TABLE prenotazioni
ADD CONSTRAINT prenotazioni_ibfk_1 FOREIGN KEY (IscrittoID)
REFERENCES iscritti (ID);

--
-- Create foreign key
--
ALTER TABLE prenotazioni
ADD CONSTRAINT prenotazioni_ibfk_2 FOREIGN KEY (ClasseID)
REFERENCES classi (ID);

--
-- Create table `assegnazioni`
--
CREATE TABLE assegnazioni (
  ID_Classe int(11) DEFAULT NULL,
  ID_Istruttore int(11) DEFAULT NULL
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE assegnazioni
ADD CONSTRAINT assegnazioni_ibfk_1 FOREIGN KEY (ID_Classe)
REFERENCES classi (ID);

--
-- Create foreign key
--
ALTER TABLE assegnazioni
ADD CONSTRAINT assegnazioni_ibfk_2 FOREIGN KEY (ID_Istruttore)
REFERENCES istruttori (ID_Istruttore);

--
-- Create table `sala`
--
CREATE TABLE sala (
  ID_Sala int(11) NOT NULL,
  Nome_Sala varchar(255) DEFAULT NULL,
  Capacita int(11) DEFAULT NULL,
  Descrizione text DEFAULT NULL,
  PRIMARY KEY (ID_Sala)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `prenotazioni_sale`
--
CREATE TABLE prenotazioni_sale (
  ID_Prenotazione int(11) NOT NULL,
  ID_Sala int(11) DEFAULT NULL,
  Data_Ora_Inizio datetime DEFAULT NULL,
  Data_Ora_Fine datetime DEFAULT NULL,
  PRIMARY KEY (ID_Prenotazione)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE prenotazioni_sale
ADD CONSTRAINT FK_prenotazioni_sale_prenotazioni_ID FOREIGN KEY (ID_Prenotazione)
REFERENCES prenotazioni (ID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE prenotazioni_sale
ADD CONSTRAINT FK_prenotazioni_sale_sala_ID_Sala FOREIGN KEY (ID_Sala)
REFERENCES sala (ID_Sala) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `attrezzature`
--
CREATE TABLE attrezzature (
  ID_Attrezzatura int(11) NOT NULL,
  Nome varchar(255) DEFAULT NULL,
  Quantita int(11) DEFAULT NULL,
  Data_Acquisto date DEFAULT NULL,
  Id_sala int(11) DEFAULT NULL,
  PRIMARY KEY (ID_Attrezzatura)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE attrezzature
ADD CONSTRAINT FK_attrezzature_sala_ID_Sala FOREIGN KEY (Id_sala)
REFERENCES sala (ID_Sala) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE iscritti ADD COLUMN password VARCHAR(255) NOT NULL DEFAULT '';
ALTER TABLE iscritti
ADD is_deleted BOOLEAN DEFAULT FALSE;