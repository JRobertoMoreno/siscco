class Negocio < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :giro
end