import Matcher from howl.util

class StringInput
  should_complete: -> false

class IntegerInput
  should_complete: -> false
  value_for: (value) =>
    num = tonumber value
    error "Not a valid number: #{value}" unless num
    num

howl.inputs.register 'string', StringInput
howl.inputs.register 'integer', IntegerInput