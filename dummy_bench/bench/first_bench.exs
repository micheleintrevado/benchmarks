Benchee.run(%{
  "function_name"    => fn -> function_to_test(param) end,
  "second_function_name" => fn -> second_function_to_test(param) end
})
