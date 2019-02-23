class BookFilterService
  DEFAULT_FILTER = :newest

  FILTERS = {
    newest: I18n.t('models.book.newest'),
    pop_first: I18n.t('models.book.pop_first'),
    by_title_asc: I18n.t('models.book.by_title_asc'),
    by_title_desc: I18n.t('models.book.by_title_asc'),
    price_asc: I18n.t('models.book.price_asc'),
    price_desc: I18n.t('models.book.price_desc')
  }.freeze

  def filter(params)
    FILTERS.include?(params[:filter]&.to_sym) ? params[:filter] : DEFAULT_FILTER
  end
end
