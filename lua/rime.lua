-- 定义一个我们自己的处理器函数，可以随便起名
function raw_input_with_space_processor(key, env)
  
  -- 检查三个条件：
  -- 1. 按下的是否是空格键 (key.keycode == 0x20)
  -- 2. 输入法是否正处于预编辑状态 (env.engine.context:composing())
  -- 3. 预编辑区里必须有内容 (env.engine.context:get_input() ~= "")
  if key.keycode == 0x20 and env.engine.context:composing() and (env.engine.context:get_input() ~= "") then
    
    -- 获取当前在预编辑区输入的原始编码（如 "bianliang"）
    local raw_input = env.engine.context:get_input()
    
    -- 执行上屏动作：将原始编码和一个空格字符一起提交
    env.engine.context:commit_text(raw_input .. ' ')
    
    -- 返回 1，代表“我已处理此按键，Rime不必再执行默认行为了”
    return 1
  end
  
  -- 如果上面的条件不满足，返回 0，让Rime按照它原来的方式处理按键
  return 0

