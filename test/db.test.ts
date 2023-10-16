// test/db.test.ts
import chai from 'chai';

import db from  '../data/db';

const expect = chai.expect;

describe('Database connection', () => {
  it('should connect without errors', async () => {
    const [rows] = await db.query('SELECT 1 as test');
    expect(rows[0].test).to.equal(1);
  });
});
