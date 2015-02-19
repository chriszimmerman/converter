defmodule ConverterTest do
	use ExUnit.Case

	test "convert_row converts a csv row into an html table row" do
		csv_row = "Jim Jones,19,Computer Science"
		expected_html_table_row = "<tr><td>Jim Jones</td><td>19</td><td>Computer Science</td></tr>"
		assert Converter.convert_row(csv_row, ",") == expected_html_table_row
	end 

	test "convert_row converts a tsv row into an html table row" do
		tsv_row = "Jim Jones\t19\tComputer Science"
		expected_html_table_row = "<tr><td>Jim Jones</td><td>19</td><td>Computer Science</td></tr>"
		assert Converter.convert_row(tsv_row, "\t") == expected_html_table_row
	end 

	test "generate_html takes a csv line and generates html for a web page and table" do
		csv_row = ["Jim Jones,19,Computer Science"]
		expected_html = "<html><body><table border=\"1\"><tr><td>Jim Jones</td><td>19</td><td>Computer Science</td></tr></table></body></html>"

	  assert Converter.generate_html(csv_row, ",") == expected_html
	end

	test "generate_html takes multiple csv lines and generates html for a web page and table" do
		csv_row = ["Jim Jones,19,Computer Science", "Serj Tankian,45,Screamology"]
		expected_html = "<html><body><table border=\"1\"><tr><td>Jim Jones</td><td>19</td><td>Computer Science</td></tr>"
									<> "<tr><td>Serj Tankian</td><td>45</td><td>Screamology</td></tr></table></body></html>"

	  assert Converter.generate_html(csv_row, ",") == expected_html
	end

	test "generate_html takes a tsv line and generates html for a web page and table" do
		tsv_row = ["Jim Jones\t19\tComputer Science"]
		expected_html = "<html><body><table border=\"1\"><tr><td>Jim Jones</td><td>19</td><td>Computer Science</td></tr></table></body></html>"

	  assert Converter.generate_html(tsv_row, "\t") == expected_html
	end

	test "generate_html takes multiple tsv lines and generates html for a web page and table" do
		tsv_row = ["Jim Jones\t19\tComputer Science", "Serj Tankian\t45\tScreamology"]
		expected_html = "<html><body><table border=\"1\"><tr><td>Jim Jones</td><td>19</td><td>Computer Science</td></tr>"
									<> "<tr><td>Serj Tankian</td><td>45</td><td>Screamology</td></tr></table></body></html>"

	  assert Converter.generate_html(tsv_row, "\t") == expected_html
	end
end
