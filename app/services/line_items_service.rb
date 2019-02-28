class LineItemsService
  QUANTITY = {
    increment: 'increment',
    decrement: 'decrement'
  }.freeze

  attr_reader :params

  def initialize(line_item, line_item_params)
    @line_item = line_item
    @params = line_item_params
  end

  def quantity_change!
    case params[:quantity]
    when QUANTITY[:increment] then @line_item.increment!(:quantity)
    when QUANTITY[:decrement] then @line_item.decrement!(:quantity) if @line_item.quantity > 1
    end
  end

  def create
    @line_item = LineItem.find_or_initialize_by(book_id: params[:book_id]).tap do |item|
      item.quantity += params[:quantity].to_i
    end
  end

  def destroy
    @line_item = LineItem.find_by(id: params[:id])
  end
end
