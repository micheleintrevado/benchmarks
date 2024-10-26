defmodule Profession do
  use Construct

  structure do
    field :place
    field :occupation
  end
end

defmodule Person do
  use Construct

  structure do
    field :name
    field :surname
    field :age, :integer
    field :profession, Profession
  end
end

Benchee.run(
 %{
     "create" => fn -> Person.make!(%{name: "michele", surname: "intrevado", age: 25, profession: %{place: "student", occupation: "univaq"}}) end,
 },
 title: "test data structure creation",
 parallel: 4,
 time: 10,
 memory_time: 5,
 measure_function_call_overhead: true,
 save: [path: Path.join(__DIR__, "construct.benchee")]
)

Benchee.report(load: ["bench/construct.benchee"])
