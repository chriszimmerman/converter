defmodule Converter do
	def csv_to_html path do
		{:ok, lines} = File.read(path)
		lines = String.strip(lines)

		{:ok, file} = File.open "result.html", [:write]
		IO.binwrite file, "<html><body>" 
							<> "<table border=\"1\">" 
							<> get_rows lines <> "</table>" 
							<> "</body></html>"
	end
	
	defp get_rows lines do
		rows = String.split(lines, "\n")
		tabled_cells = Enum.map(rows, fn row -> Enum.map(String.split(row, ","), fn cell -> "<td>#{cell}</td>" end) end)	
		Enum.join(Enum.map(tabled_cells, fn row -> "<tr>#{row}</tr>" end))
	end
end
