class RepositoriesFilter
  include ActiveModel::Model

  attr_accessor :sort, :order, :offset, :limit, :name
  attr_reader :results, :count

  validates :sort, presence: true, inclusion: { in: %w[id name external_id created_at updated_at] }
  validates :order, presence: true, inclusion: { in: %w[asc desc] }
  validates :offset, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :limit, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

  def search
    if valid?
      @results = Repository.order(Arel.sql(%(#{sort} #{order == 'asc' ? 'asc' : 'desc'})))

      where_string! :name

      @count = @results.count
      @results = @results.select(:id, :name, :external_id, :created_at, :updated_at).offset(offset).limit(limit)
    end
  end

  private

  def where_string!(attribute)
    if (value = send(attribute).to_s.gsub('$', '$$').gsub(/(_|%|\\)/, '$\1')).present?
      @results = @results.where(
        "UNACCENT(LOWER(:column)) LIKE ( SELECT UNACCENT(LOWER(:value)) ) ESCAPE '$'",
        column: attribute,
        value: "%#{value}%"
      )
    end
  end
end
