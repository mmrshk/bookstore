class ReviewPresenter < SimpleDelegator
  def initialize(model, view)
    @model = model
    @view = view
  end

  def datetime
    @model.created_at.strftime("%d/%m/%y")
  end

  def name
    @model.name.first.capitalize
  end

  private

  def method_missing(*args, &block)
    @model.public_send(*args, &block)
  end
end
