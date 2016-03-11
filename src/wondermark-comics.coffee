# Description:
#   Get the latest Wondermark comics
#
# Dependencies:
#   "htmlparser": "1.7.6"
#   "soupselect": "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot wondermark - The latest Wondermark comic
#
# Author:
#   derekgottlieb

htmlparser = require "htmlparser"
Select     = require("soupselect").select

module.exports = (robot) ->
  getComic = (msg, url) ->
    msg.http(url)
        .get() (err, res, body) ->
          handler = new htmlparser.DefaultHandler()
          parser = new htmlparser.Parser(handler)
          parser.parseComplete(body)

          comicDiv = Select handler.dom, "div#comic"
          img = comicDiv[0].children[1]
          comic = img.attribs

          msg.send comic.src
          msg.send comic.title if comic.title

  robot.respond /wondermark$/i, (msg) ->
    getComic(msg, "http://wondermark.com")
