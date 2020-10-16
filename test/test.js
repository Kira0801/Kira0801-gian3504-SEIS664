process.env.NODE_ENV = 'test';


let assert = require('assert');
let chai = require('chai');
let chaiHttp = require('chai-http');
let server = require('../server');
let should = chai.should();



chai.use(chaiHttp);
//Our parent block
describe('Node-svc', () => {
  /*
  * Test the /GET route
  */
  describe('/GET /0', () => {
      it('Simplest request', (done) => {
        chai.request("localhost:3000")
            .get('/0')
            .end((err, res) => {
                  res.should.have.status(200);
		// res.body.should.be.a('array');
                // res.body.length.should.be.eql(0);
             if (err) return done(err);
            done();
            });
      });
  });

});
