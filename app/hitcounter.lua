local redis = require "resty.redis"
local red = redis:new()

function connect()
  red:set_timeout(1000) -- 1 sec

  local ok, err = red:connect("127.0.0.1", 6379)
  if not ok then
    ngx.say("failed to connect to redis: ", err)
    ngx.exit(ngx.ERROR)
    return nil
  end
end

local HC = {}

function HC.add()
  connect()
  ok, err = red:incr("hit_counter")
  if not ok then
    ngx.say("failed to increment hit_counter: ", err)
    return
  end
end

function HC.get()
  local hit_counter, err = red:get("hit_counter")
  if not hit_counter then
    ngx.say("failed to get hit_counter: ", err)
    return
  end
  return hit_counter
end

return HC
