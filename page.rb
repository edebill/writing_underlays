require "prawn/graphics"

class Page
  attr_accessor :pdf, :paper, :guide, :spacing, :spacing_mm, :line_weight

  def initialize(pdf, paper, guide, margin_width_mm, spacing_mm, line_weight_mm)
    @pdf = pdf
    @paper = paper
    @guide = guide
    @spacing_mm = spacing_mm
    @spacing = spacing_mm.mm
    @margin_width = margin_width_mm.mm
    @line_weight = line_weight_mm.mm
  end

  def guide_margin
    @margin_width
  end


  def render
    bottom_edge = (paper.height - guide.height) / 2
    pdf.line [0, bottom_edge], [paper.width, bottom_edge]
    pdf.stroke

    top_edge = paper.height - ((paper.height - guide.height) / 2)
    pdf.line [0, top_edge], [paper.width, top_edge]
    pdf.stroke

    pdf.bounding_box([(paper.width - guide.width) / 2,
                      top_edge],
                   :width => guide.width,
                   :height => guide.height) do
      pdf.stroke_bounds
      num_lines = ((guide.height - line_weight - 6.mm) / spacing).to_i

      num_lines.times do |i|
        height = guide.height - (i + 1) * spacing  # count down from top
        pdf.rectangle [guide_margin, height], guide.width - (2 * guide_margin), line_weight
        pdf.fill

      end

      pdf.move_cursor_to 3.mm
      pdf.text "#{spacing_mm}mm", :align => :center, :size => 3.mm
    end


  end
end
