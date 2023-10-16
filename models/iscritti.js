const db = require('../data/db');

class Iscritto {
  // Fetch a single member by ID
  static async getById(id) {
    const [rows] = await db.execute('SELECT * FROM iscritti WHERE id = ?', [id]);
    return rows[0];
  }

  // Fetch all members
  static async getAll() {
    const [rows] = await db.execute('SELECT * FROM iscritti');
    return rows;
  }

  // Add a new member
  static async add(nome, cognome, indirizzo, data_nascita, password) {
    const result = await db.execute('INSERT INTO iscritti (nome, cognome, indirizzo, data_nascita, password) VALUES (?, ?, ?, ?, ?)', [nome, cognome, indirizzo, data_nascita, password]);
    return result[0].insertId;
  }

  // Update a member's information
  static async update(id, nome, cognome, indirizzo, data_nascita, password) {
    await db.execute('UPDATE iscritti SET nome = ?, cognome = ?, indirizzo = ?, data_nascita = ?, password = ? WHERE id = ?', [nome, cognome, indirizzo, data_nascita, password, id]);
  }

  // Delete a member
  static async delete(id) {
    //await db.execute('DELETE FROM iscritti WHERE id = ?', [id]);
    await db.execute('UPDATE iscritti SET is_deleted=1 WHERE id = ?', [id]);
  }
}

module.exports = Iscritto;
