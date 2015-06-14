require "prawn"
require "prawn/measurement_extensions"
require "ostruct"

require_relative "page"

guide_size = OpenStruct.new(:width => 4.75.in,
                            :height => 8.2.in)

paper_size = OpenStruct.new(:width => 8.5.in,
                            :height => 11.in)

spacings = [9, 8, 7, 6, 5, 4, 3]

margin_width = 11
line_weight = 0.6

Prawn::Document.generate("guides.pdf", :margin => 0) do |pdf|
  page = nil
  page = 1
  in_pt = 1.in
  pdf.text "paper size: #{paper_size.width / in_pt}x#{paper_size.height / in_pt}in"
  pdf.text "page size: #{guide_size.width / in_pt}x#{guide_size.height / in_pt}in"
  pdf.text "line weight: #{line_weight}mm"
  pdf.text "margin: #{margin_width}mm"



  spacings.each do |spacing|
    pdf.start_new_page if page

    page = Page.new(pdf, paper_size, guide_size, margin_width, spacing, line_weight)
    page.render
  end

  spacings.each do |spacing|
    pdf.start_new_page if page

    page = Page.new(pdf, paper_size, guide_size, margin_width, spacing, (spacing - line_weight))
    page.render
  end

end

`open guides.pdf`
