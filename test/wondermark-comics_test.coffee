chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'hello-world', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/wondermark-comics')(@robot)

  it 'responds to request for latest comic', ->
    expect(@robot.respond).to.have.been.calledWith(/wondermark/i)
