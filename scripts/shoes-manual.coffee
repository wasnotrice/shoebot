# Searches the Shoes manual for a query and returns the URL of the first
# google hit
#
# manual me <query>   - Googles shoes manual for <query> & returns 1st
# result's URL

module.exports = (robot) ->
  robot.respond /(manual)( me)? (.*)/i, (msg) ->
    googleMe msg, msg.match[3], (url) ->
      msg.send url

googleMe = (msg, query, cb) ->
  msg.http('http://www.google.com/search')
    .query(q: query+" site:shoesrb.com/manual")
    .get() (err, res, body) ->
      cb body.match(/<h3 class="r"><a href="\/url\?q=([^&]*)/)?[1] || body || "Sorry, couldn't find anything for '#{query}'"

