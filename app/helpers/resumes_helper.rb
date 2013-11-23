module ResumesHelper
  def render_rating_display(rating)
    case rating
    when 0..30 then @rating_class = "label-danger"
    when 31..50 then @rating_class = "label-default"
    when 51..70 then @rating_class = "label-primary"
    when 71..200 then @rating_class = "label-success"
    end
    output = ''
    output << content_tag(:div, content_tag(:span,rating, class: "label #{@rating_class}"),class: "rating")
    return output.html_safe
  end

  def employee_types_collection
    [
        ['Employee (I prefer to work in a building)', 'employee'],
        ['Freelancer (I will be working online)', 'freelancer'],
        ['Company(I will be ... ???)', 'company']
    ]
  end
end