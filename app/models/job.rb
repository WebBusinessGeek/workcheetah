class Job < ActiveRecord::Base
  attr_accessible :about_company, :description, :title

  def self.text_search(query)
    if query.present?
      rank = <<-RANK
        ts_rank(to_tsvector(title), plainto_tsquery(#{sanitize(query)})) +
        ts_rank(to_tsvector(description), plainto_tsquery(#{sanitize(query)})) +
        ts_rank(to_tsvector(about_company), plainto_tsquery(#{sanitize(query)}))
      RANK
      where("to_tsvector('english', title) @@ :q or to_tsvector('english', description) @@ :q or to_tsvector('english', about_company) @@ :q", q: query).order("#{rank} desc")
    else
      scoped
    end
  end
end
