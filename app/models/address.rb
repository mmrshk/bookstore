class Address < ApplicationRecord
  REGULAR_EXPESSION = {
    name: /\A[a-zA-Z]*\z/,
    address: /\A[a-zA-Z0-9 \-\,]*\z/,
    zip: /\A[0-9\-]*\z/,
    phone: /\A\+[0-9]*\z/
  }.freeze

  belongs_to :user, optional: true
  belongs_to :order, optional: true
  validates :firstname, :lastname, :address, :city, :zip, :country, :phone, :cast, presence: true

  validates :firstname, :lastname, :city, :country,
            format: { with: REGULAR_EXPESSION[:name],
                      message: I18n.t('models.address.firstname_warning') },
            length: { maximum: 50 }

  validates :address,
            format: { with: REGULAR_EXPESSION[:address],
                      message: I18n.t('models.address.address_warning') },
            length: { maximum: 50 }

  validates :zip,
            format: { with: REGULAR_EXPESSION[:zip],
                      message: I18n.t('models.address.zip_warning') },
            length: { maximum: 10 }

  validates :phone,
            format: { with: REGULAR_EXPESSION[:phone],
                      message: I18n.t('models.address.phone_warning') },
            length: { maximum: 15 }

  #test on enum that shipping on first place, billing on second
  enum cast: %i[shipping billing]
end
