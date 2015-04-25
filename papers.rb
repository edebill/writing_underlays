require "prawn"
require "prawn/measurement_extensions"
require "ostruct"

require "page"

guide_size = OpenStruct.new(:width => 4.75.in,
                            :height => 8.2.in)

paper_size = OpenStruct.new(:width => 8.5.in,
                            :height => 11.in)

spacings = [9, 8, 7, 6, 5, 4, 3]

Prawn::Document.generate("guides.pdf", :margin => 0) do |pdf|
  page = nil
  spacings.each do |spacing|
    pdf.start_new_page if page

    page = Page.new(pdf, paper_size, guide_size, spacing)
    page.render
  end
end

`open guides.pdf`
