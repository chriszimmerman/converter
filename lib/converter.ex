defmodule Converter do
	@moduledoc """
		Converts files from one format to another.
	"""

	@doc """
	Takes in the path to a space-delimited file (such as a csv or tsv) along with a delimiter and places the data in an HTML file in a table.
	"""
	def convert path, delimiter do
		{:ok, lines} = File.read(path)
		lines = String.strip(lines)

		{:ok, file} = File.open "result-#{get_date_as_string}.html", [:write]
		IO.binwrite file, "<html><body>" 
		IO.binwrite file, "<table border=\"1\">" 
		IO.binwrite file, get_rows(lines, delimiter)
		IO.binwrite file, "</table>" 
		IO.binwrite file, "</body></html>"
	end
	
	defp get_rows(lines, delimiter) do
		rows = String.split(lines, "\n")
		wrap_in_cell = fn cell -> "<td>#{cell}</td>" end
		tabled_cells = Enum.map(rows, fn row -> Enum.map(String.split(row, delimiter), wrap_in_cell) end)	
		Enum.join(Enum.map(tabled_cells, fn row -> "<tr>#{row}</tr>" end))
	end

	defp get_date_as_string do
		{{year, month, day}, {hour, minute, second}} = :calendar.local_time
		"#{year}-#{month}-#{day}_#{hour}-#{minute}-#{second}"
	end

	def convert_row(csv_row) do
		data = String.split(csv_row, ",")
		|> Enum.map(fn datum -> "<td>#{datum}</td>" end) 
		|> Enum.join
		|> fn data -> "<tr>#{data}</tr>" end.()
	end
end
