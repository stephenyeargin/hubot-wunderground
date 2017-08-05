Helper = require('hubot-test-helper')
chai = require 'chai'
nock = require 'nock'
fs = require 'fs'

expect = chai.expect

helper = new Helper('../src/wunderground.coffee')

describe 'wunderground', ->
  beforeEach ->
    process.env.HUBOT_WUNDERGROUND_API_KEY = 'foobarbaz123456'

    @room = helper.createRoom()

    do nock.disableNetConnect

    nock('http://api.wunderground.com')
      .get("/api/foobarbaz123456/forecast/q/nashville.json")
      .reply 200, fs.readFileSync('test/fixtures/nashville.json')

    nock('http://api.wunderground.com')
      .get("/api/foobarbaz123456/forecast/q/nashville_tn.json")
      .reply 200, fs.readFileSync('test/fixtures/nashville-tn.json')

    nock('http://api.wunderground.com')
      .get("/api/foobarbaz123456/radar/q/nashville_tn.json")
      .reply 200, fs.readFileSync('test/fixtures/nashville-tn-radar.json')

    nock('http://api.wunderground.com')
      .get("/api/foobarbaz123456/satellite/q/nashville_tn.json")
      .reply 200, fs.readFileSync('test/fixtures/nashville-tn-satellite.json')

    nock('http://api.wunderground.com')
      .get("/api/foobarbaz123456/webcams/q/nashville_tn.json")
      .reply 200, fs.readFileSync('test/fixtures/nashville-tn-webcams.json')

  afterEach ->
    @room.destroy()

  # Test case
  it 'returns an ambigious weather result', (done) ->
    selfRoom = @room
    testPromise = new Promise (resolve, reject) ->
      selfRoom.user.say('alice', '@hubot weather in nashville')
      setTimeout(() ->
        resolve()
      , 1000)

    testPromise.then ((result) ->
      try
        expect(selfRoom.messages).to.eql [
          ['alice', '@hubot weather in nashville']
          ['hubot', "Possible matches for 'nashville'.\n - AR/Nashville\n - GA/Nashville\n - IL/Nashville\n - IN/Nashville\n - KS/Nashville\n - MI/Nashville\n - NC/Nashville\n - NY/Nashville\n - OH/Nashville\n - PA/Nashville\n - TN/Nashville\n - VT/Nashville"]
        ]
        done()
      catch err
        done err
      return
    ), done

  it 'returns a weather forecast', (done) ->
    selfRoom = @room
    testPromise = new Promise (resolve, reject) ->
      selfRoom.user.say('alice', '@hubot weather in nashville tn')
      setTimeout(() ->
        resolve()
      , 1000)

    testPromise.then ((result) ->
      try
        expect(selfRoom.messages).to.eql [
          ['alice', '@hubot weather in nashville tn']
          ['hubot',  'Friday in nashville tn: Clear. Lows overnight in the low 60s. (7199)']
        ]
        done()
      catch err
        done err
      return
    ), done

  it 'returns a weather radar', (done) ->
    selfRoom = @room
    testPromise = new Promise (resolve, reject) ->
      selfRoom.user.say('alice', '@hubot radar in nashville tn')
      setTimeout(() ->
        resolve()
      , 1000)

    testPromise.then ((result) ->
      try
        expect(selfRoom.messages).to.eql [
          ['alice', '@hubot radar in nashville tn']
          ['hubot',  'http://resize.wunderground.com/cgi-bin/resize_convert?ox=gif&url=radblast/cgi-bin/radar/WUNIDS_composite%3Fcenterlat=36.16999817%26centerlon=-86.77999878%26radius=75%26newmaps=1%26smooth=1%26reproj.automerc=1%26api_key=foobarbaz123456.png']
        ]
        done()
      catch err
        done err
      return
    ), done

  it 'returns a weather satellite', (done) ->
    selfRoom = @room
    testPromise = new Promise (resolve, reject) ->
      selfRoom.user.say('alice', '@hubot satellite in nashville tn')
      setTimeout(() ->
        resolve()
      , 1000)

    testPromise.then ((result) ->
      try
        expect(selfRoom.messages).to.eql [
          ['alice', '@hubot satellite in nashville tn']
          ['hubot',  'http://wublast.wunderground.com/cgi-bin/WUBLAST?lat=36.16999817&lon=-86.77999878&radius=75&width=300&height=300&key=sat_ir4_thumb&gtt=0&extension=png&proj=me&num=1&delay=25&timelabel=0&basemap=1&borders=1&theme=WUBLAST_WORLD&rand=1501902218&api_key=foobarbaz123456.png']
        ]
        done()
      catch err
        done err
      return
    ), done
