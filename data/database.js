// database.js
const mysql = require('mysql');

module.exports = {
  initApp: function() {
    let app = express();
    app.use(bodyParser.json());

    let conn = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      password: '',
      database: 'palestra'
    });

    conn.connect((err) => {
      if(err) throw err;
      console.log('Connected to database');
    });

    return { app, conn };
  }
};
