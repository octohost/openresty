local redis = require "resty.redis"
local red = redis:new()

red:set_timeout(1000) -- 1 sec

if ngx.var.uri ~= '/' then
  ngx.status = ngx.HTTP_NOT_FOUND
  ngx.say('not found: ', ngx.var.uri)
  return
end

ngx.say('<h1>Hit Counter</h1>')

local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
  ngx.say("failed to connect to redis: ", err)
  return
end

ok, err = red:incr("hit_counter")
if not ok then
  ngx.say("failed to increment hit_counter: ", err)
  return
end

local hit_counter, err = red:get("hit_counter")
if not hit_counter then
  ngx.say("failed to get hit_counter: ", err)
  return
end

ngx.say("<p>Visitors: ",hit_counter,"</p>")
