defmodule DataGenerator do
	@moduledoc """
	Generates test data files.
	"""

	@doc """
	Creates a file of data with number_of_rows rows, each value separated by the delimiter. The file is written to filename.
	"""
	def generate_file(filename, delimiter, number_of_rows) do
		{:ok, file} = File.open filename, [:write]	
		row = Enum.join(["this", "is", "a", "row", "of", "test", "data"], delimiter)
		Enum.each(1..number_of_rows, fn x -> IO.binwrite file, "#{x}#{delimiter}#{row}\n" end)	
	end
end
