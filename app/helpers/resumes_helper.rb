module ResumesHelper
  def resume_rating_display(rating)
    case rating
    when 0..30 then @rating_class = "label-important"
    when 31..50 then @rating_class = "label-warning"
    when 51..70 then @rating_class = ""
    when 71..200 then @rating_class = "label-success"
    end
    output = ''
    output << content_tag(:div, content_tag(:span,rating, class: "label #{@rating_class}"),class: "rating")
    return output.html_safe
  end
end