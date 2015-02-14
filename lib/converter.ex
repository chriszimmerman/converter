defmodule Converter do
	@moduledoc """
		Converts files from one format to another.
	"""

	@doc """
	Takes in the path to a space-delimited file (such as a csv or tsv) along with a delimiter and places the data in an HTML file in a table.
	"""
	def convert path, delimiter do
		{:ok, lines} = File.read(path)
		lines = String.split(lines, "\n")

		{:ok, file} = File.open "result-#{get_date_as_string}.html", [:write]
		html = generate_html(lines, delimiter)
		IO.binwrite file, html
	end
	
	defp get_date_as_string do
		{{year, month, day}, {hour, minute, second}} = :calendar.local_time
		"#{year}-#{month}-#{day}_#{hour}-#{minute}-#{second}"
	end

	def generate_html(lines, delimiter) do
		table_rows = Enum.map(lines, fn line -> convert_row(line, delimiter) end)
		concatenated_markup = Enum.join(table_rows)
		"<html><body><table border=\"1\">#{concatenated_markup}</table></body></html>"
	end

	def convert_row(csv_row, delimiter) do
		data = String.split(csv_row, delimiter)
		|> Enum.map(fn datum -> "<td>#{datum}</td>" end) 
		|> Enum.join
		|> fn data -> "<tr>#{data}</tr>" end.()
	end
end
