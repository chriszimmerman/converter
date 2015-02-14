defmodule ConverterTest do
	use ExUnit.Case

	test "convert_row converts a csv row into an html table row" do
		csv_row = "Jim Jones,19,Computer Science"
		expected_html_table_row = "<tr><td>Jim Jones</td><td>19</td><td>Computer Science</td></tr>"
		assert Converter.convert_row(csv_row, ",") == expected_html_table_row
	end 

	test "generate_html takes the csv lines and generates html for a web page and table" do
		csv_row = ["Jim Jones,19,Computer Science"]
		expected_html = "<html><body><table border=\"1\"><tr><td>Jim Jones</td><td>19</td><td>Computer Science</td></tr></table></body></html>"

	  assert Converter.generate_html(csv_row, ",") == expected_html
	end
end
