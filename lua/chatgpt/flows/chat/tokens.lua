-- ---------------- [ File: lua/chatgpt/flows/chat/tokens.lua ]
local Tokens = {}

--[[
  cost_per_token
  @param {string} token_name
  @return {number} cost_per_token
]]
local cost_per_token = {
  davinci = 0.000002,
}

--- Calculate the number of tokens in a given text.
-- @param text The text to calculate the number of tokens for.
-- @return The number of tokens in the given text.
function Tokens.calculate_tokens(text)
  local tokens = 0
  local current_token = ""
  for char in text:gmatch(".") do
    if char == " " or char == "\n" then
      if current_token ~= "" then
        tokens = tokens + 1
        current_token = ""
      end
    else
      current_token = current_token .. char
    end
  end
  if current_token ~= "" then
    tokens = tokens + 1
  end
  return tokens
end

--- Calculate the cost of a given text in dollars.
-- @param text The text to calculate the cost of.
-- @param model The model to use to calculate the cost.
-- @return The cost of the given text in dollars.
function Tokens.calculate_usage_in_dollars(text, model)
  local tokens = Tokens.calculate_tokens(text)
  return Tokens.usage_in_dollars(tokens, model)
end

--- Calculate the cost of a given number of tokens in dollars.
-- @param tokens The number of tokens to calculate the cost of.
-- @param model The model to use to calculate the cost.
-- @return The cost of the given number of tokens in dollars.
function Tokens.usage_in_dollars(tokens, model)
  return tokens * cost_per_token[model or "davinci"]
end

return Tokens
