defmodule Converter do
	def convert path, delimiter do
		{:ok, lines} = File.read(path)
		lines = String.strip(lines)

		{:ok, file} = File.open "result.html", [:write]
		IO.binwrite file, "<html><body>" 
							<> "<table border=\"1\">" 
							<> get_rows(lines, delimiter) <> "</table>" 
							<> "</body></html>"
	end
	
	defp get_rows(lines, delimiter) do
		rows = String.split(lines, "\n")
		wrap_in_cell = fn cell -> "<td>#{cell}</td>" end
		tabled_cells = Enum.map(rows, fn row -> Enum.map(String.split(row, delimiter), wrap_in_cell) end)	
		Enum.join(Enum.map(tabled_cells, fn row -> "<tr>#{row}</tr>" end))
	end
end