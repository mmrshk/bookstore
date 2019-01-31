class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order, optional: true
  validates :firstname, :lastname, :address, :city, :zip, :country, :phone, :cast, presence: true

  validates :firstname, :lastname, :city, :country,
          format: { with: /\A[a-zA-Z]*\z/,
                    message: I18n.t('models.address.firstname_warning') },
          length: { maximum: 50 }

  validates :address,
            format: { with: /\A[a-zA-Z0-9 \-\,]*\z/,
                      message: I18n.t('models.address.address_warning') },
            length: { maximum: 50 }

  validates :zip,
            format: { with: /\A[0-9\-]*\z/,
                      message: I18n.t('models.address.zip_warning')},
            length: { maximum: 10 }

  validates :phone,
            format: { with: /\A\+[0-9]*\z/,
                      message: I18n.t('models.address.phone_warning') },
            length: { maximum: 15 }

  enum cast: %i[shipping billing]

  scope :shipping, -> { where(cast: 0) }
  scope :billing,  -> { where(cast: 1) }
end
