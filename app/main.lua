local hitcounter = require "hitcounter"

if ngx.var.uri ~= '/' then
  ngx.status = ngx.HTTP_NOT_FOUND
  ngx.say('not found: ', ngx.var.uri)
  return
end

ngx.say('<h2>Nginx/OpenResty</h2>')
hitcounter.add()
ngx.say("<p>Visitors: ",hitcounter.get(),"</p>")
